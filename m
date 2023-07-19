Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA9758C30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGSDgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGSDge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:36:34 -0400
Received: from out-17.mta1.migadu.com (out-17.mta1.migadu.com [IPv6:2001:41d0:203:375::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD06A4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:36:33 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689737791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/bKdSl4bL/ALz46t3piE5f2eCd5ENeQ8V1dbQqCg9c=;
        b=qTMC2PfZJIX6ph5q/BQMb7swLil9bXc6mnr4B99vRzZ+6MFfqW+rxOLWHjdtrzlwUfXsUK
        u6s5XHVNbse7WX/9Fprhd6EKbW3t+64IhHP43mIWQyzpXJ/7ytTKH4pUA362YCrmmN8a89
        qtXXBcLfZjBeb5AXF7KfaIN25KCsbc4=
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] hugetlb: optimize update_and_free_pages_bulk to
 avoid lock cycles
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230718004942.113174-3-mike.kravetz@oracle.com>
Date:   Wed, 19 Jul 2023 11:35:44 +0800
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Message-Id: <CCCD27BE-0127-4148-92A8-673075A976E0@linux.dev>
References: <20230718004942.113174-1-mike.kravetz@oracle.com>
 <20230718004942.113174-3-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 18, 2023, at 08:49, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> update_and_free_pages_bulk is designed to free a list of hugetlb pages
> back to their associated lower level allocators.  This may require
> allocating vmemmmap pages associated with each hugetlb page.  The
> hugetlb page destructor must be changed before pages are freed to lower
> level allocators.  However, the destructor must be changed under the
> hugetlb lock.  This means there is potentially one lock cycle per page.
> 
> Minimize the number of lock cycles in update_and_free_pages_bulk by:
> 1) allocating necessary vmemmap for all hugetlb pages on the list
> 2) take hugetlb lock and clear destructor for all pages on the list
> 3) free all pages on list back to low level allocators
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

