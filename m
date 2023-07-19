Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E854A758B67
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGSCfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:35:21 -0400
Received: from out-6.mta1.migadu.com (out-6.mta1.migadu.com [95.215.58.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA3D1BC3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:35:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689734116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9ZAEbBiO24j7Uknj5PMKtSmu00bsu4fHz6ctS0uYi8=;
        b=n0asVgRiKnEBpyy9M1+lERgGLufw19A9QodAMrALzkWRaj5U6PtL8Oxgm592EvQRn6p6RZ
        gpiOyhAV0RHQCG9XzBocXXqaQbUbtEJQyf4VWcZFbMYhYpw1Ns6TrWF5/urtuidNDtZkSh
        sZnvHKgALLeThB1MKDjpaXG8D1MM93c=
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] hugetlb: Do not clear hugetlb dtor until
 allocating vmemmap
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230718004942.113174-2-mike.kravetz@oracle.com>
Date:   Wed, 19 Jul 2023 10:34:36 +0800
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4015AB29-76AD-4CA7-89C4-5916E2F8670B@linux.dev>
References: <20230718004942.113174-1-mike.kravetz@oracle.com>
 <20230718004942.113174-2-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 18, 2023, at 08:49, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> Freeing a hugetlb page and releasing base pages back to the underlying
> allocator such as buddy or cma is performed in two steps:
> - remove_hugetlb_folio() is called to remove the folio from hugetlb
>  lists, get a ref on the page and remove hugetlb destructor.  This
>  all must be done under the hugetlb lock.  After this call, the page
>  can be treated as a normal compound page or a collection of base
>  size pages.
> - update_and_free_hugetlb_folio() is called to allocate vmemmap if
>  needed and the free routine of the underlying allocator is called
>  on the resulting page.  We can not hold the hugetlb lock here.
>=20
> One issue with this scheme is that a memory error could occur between
> these two steps.  In this case, the memory error handling code treats
> the old hugetlb page as a normal compound page or collection of base
> pages.  It will then try to SetPageHWPoison(page) on the page with an
> error.  If the page with error is a tail page without vmemmap, a write
> error will occur when trying to set the flag.
>=20
> Address this issue by modifying remove_hugetlb_folio() and
> update_and_free_hugetlb_folio() such that the hugetlb destructor is =
not
> cleared until after allocating vmemmap.  Since clearing the destructor
> requires holding the hugetlb lock, the clearing is done in
> remove_hugetlb_folio() if the vmemmap is present.  This saves a
> lock/unlock cycle.  Otherwise, destructor is cleared in
> update_and_free_hugetlb_folio() after allocating vmemmap.
>=20
> Note that this will leave hugetlb pages in a state where they are =
marked
> free (by hugetlb specific page flag) and have a ref count.  This is =
not
> a normal state.  The only code that would notice is the memory error
> code, and it is set up to retry in such a case.
>=20
> A subsequent patch will create a routine to do bulk processing of
> vmemmap allocation.  This will eliminate a lock/unlock cycle for each
> hugetlb page in the case where we are freeing a large number of pages.
>=20
> Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated =
with each HugeTLB page")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

