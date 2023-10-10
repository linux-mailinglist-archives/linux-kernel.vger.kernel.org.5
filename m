Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CBC7BEF75
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379120AbjJJAHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377918AbjJJAHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:07:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03792A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:07:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD330C433C8;
        Tue, 10 Oct 2023 00:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696896457;
        bh=6b49PW5LaeMyJQFy8snvZ2ofXdD/Lial7GWWzU0yfhE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M8QqAFFMRc3t/UxGKQLvGIV8tdRYA5+JgGdk/vKa7VjQBYOHnaoikyMPusYG+VD3Z
         oBng8VDURbRPyEpjCJTzj0oTbHLrABaY9NtQ4VgcZ6ddscwqcUpylA80UiHLK7h3Cx
         +A0fUcfOrN128LZK3iFGviEV2zPB0g+vZracjMyc=
Date:   Mon, 9 Oct 2023 17:07:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, Usama Arif <usama.arif@bytedance.com>
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Message-Id: <20231009170710.b52f5a6e57c23d5caecce8ab@linux-foundation.org>
In-Reply-To: <20231009151513.GB3846@monkey>
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
        <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
        <20230929205731.GA10357@monkey>
        <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
        <20231006030836.GC86415@monkey>
        <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
        <20231006223512.GC3861@monkey>
        <20231009032926.GA3376@monkey>
        <070bd916-d4d6-41c2-9f51-af35e80c96b9@linaro.org>
        <20231009150401.GA3846@monkey>
        <20231009151513.GB3846@monkey>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 08:15:13 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> > This should also be empty and a noop.
> > 
> > Is it possible that the misaligned kernel image could make these lists
> > appear as non-empty?
> 
> Actually, just saw this:
> 
> https://lore.kernel.org/linux-mm/20231009145605.2150897-1-usama.arif@bytedance.com/
> 
> Will take a look, although as mentioned above prep_and_add_bootmem_folios on
> an empty list should be a noop.

Konrad, are you able to test Usama's patch?  Thanks.

From: Usama Arif <usama.arif@bytedance.com>
Subject: mm: hugetlb: only prep and add allocated folios for non-gigantic pages
Date: Mon, 9 Oct 2023 15:56:05 +0100

Calling prep_and_add_allocated_folios when allocating gigantic pages at
boot time causes the kernel to crash as folio_list is empty and iterating
it causes a NULL pointer dereference.  Call this only for non-gigantic
pages when folio_list has entries.

Link: https://lkml.kernel.org/r/20231009145605.2150897-1-usama.arif@bytedance.com
Fixes: bfb41d6b2fe148 ("hugetlb: restructure pool allocations")
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Cc: Fam Zheng <fam.zheng@bytedance.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Punit Agrawal <punit.agrawal@bytedance.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Xiongchun Duan <duanxiongchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/hugetlb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/hugetlb.c~hugetlb-restructure-pool-allocations-fix
+++ a/mm/hugetlb.c
@@ -3307,7 +3307,8 @@ static void __init hugetlb_hstate_alloc_
 	}
 
 	/* list will be empty if hstate_is_gigantic */
-	prep_and_add_allocated_folios(h, &folio_list);
+	if (!hstate_is_gigantic(h))
+		prep_and_add_allocated_folios(h, &folio_list);
 
 	if (i < h->max_huge_pages) {
 		char buf[32];
_

