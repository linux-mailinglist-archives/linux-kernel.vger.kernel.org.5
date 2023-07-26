Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2541A76308D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjGZIzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGZIzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:55:14 -0400
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DBA30EB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:48:30 -0700 (PDT)
Date:   Wed, 26 Jul 2023 17:48:18 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690361307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=McfcWIQnPPHbZphZYBIYnAn4Lt4MKunTWFsFjRbBvKo=;
        b=VPvLRZynAgP2muaMo3LsPtLZy2mhoXJLuhdHAtWI6xGA1KbScW/I/bmY75xBDkKv/0HAsw
        5i4Zhfs+toFsZZvzs+e2qApek5r37BcJHL7nMO5kXIUV4mBtqMr21tmpxVHtq2CJw9wD5K
        +Z+B5fzao0764V0NTUf+6eRd76p17Ng=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiaqi Yan <jiaqiyan@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlb: Do not clear hugetlb dtor until
 allocating vmemmap
Message-ID: <20230726084818.GA268581@ik1-406-35019.vs.sakura.ne.jp>
References: <20230718004942.113174-1-mike.kravetz@oracle.com>
 <20230718004942.113174-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230718004942.113174-2-mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:49:41PM -0700, Mike Kravetz wrote:
> Freeing a hugetlb page and releasing base pages back to the underlying
> allocator such as buddy or cma is performed in two steps:
> - remove_hugetlb_folio() is called to remove the folio from hugetlb
>   lists, get a ref on the page and remove hugetlb destructor.  This
>   all must be done under the hugetlb lock.  After this call, the page
>   can be treated as a normal compound page or a collection of base
>   size pages.
> - update_and_free_hugetlb_folio() is called to allocate vmemmap if
>   needed and the free routine of the underlying allocator is called
>   on the resulting page.  We can not hold the hugetlb lock here.
> 
> One issue with this scheme is that a memory error could occur between
> these two steps.  In this case, the memory error handling code treats
> the old hugetlb page as a normal compound page or collection of base
> pages.  It will then try to SetPageHWPoison(page) on the page with an
> error.  If the page with error is a tail page without vmemmap, a write
> error will occur when trying to set the flag.
> 
> Address this issue by modifying remove_hugetlb_folio() and
> update_and_free_hugetlb_folio() such that the hugetlb destructor is not
> cleared until after allocating vmemmap.  Since clearing the destructor
> requires holding the hugetlb lock, the clearing is done in
> remove_hugetlb_folio() if the vmemmap is present.  This saves a
> lock/unlock cycle.  Otherwise, destructor is cleared in
> update_and_free_hugetlb_folio() after allocating vmemmap.
> 
> Note that this will leave hugetlb pages in a state where they are marked
> free (by hugetlb specific page flag) and have a ref count.  This is not
> a normal state.  The only code that would notice is the memory error
> code, and it is set up to retry in such a case.
> 
> A subsequent patch will create a routine to do bulk processing of
> vmemmap allocation.  This will eliminate a lock/unlock cycle for each
> hugetlb page in the case where we are freeing a large number of pages.
> 
> Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

I wrote a reproducer to cause the race condition between memory failure
and shrinking free hugepage pool (with vmemmap optimization enabled).
Then I observed that v6.5-rc2 kernel panicked with "BUG: unable to handle
page fault for address...", and confirmed that the kernel with your patches
do not reproduce it.  Thank you for fixing this.

Tested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
