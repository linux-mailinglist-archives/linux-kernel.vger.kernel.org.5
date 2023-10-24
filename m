Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4D7D5382
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjJXN7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJXN7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:59:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB732726
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:48:47 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SFCwH4tjHzMm3y;
        Tue, 24 Oct 2023 21:44:31 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 24 Oct 2023 21:48:43 +0800
Message-ID: <e0b65883-18fa-40c8-a61a-bebcfee109a4@huawei.com>
Date:   Tue, 24 Oct 2023 21:48:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <akpm@linux-foundation.org>, <v-songbaohua@oppo.com>,
        <yuzhao@google.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/24 20:56, Baolin Wang wrote:
> Now ptep_clear_flush_young() is only called by folio_referenced() to
> check if the folio was referenced, and now it will call a tlb flush on
> ARM64 architecture. However the tlb flush can be expensive on ARM64
> servers, especially for the systems with a large CPU numbers.
> 
> Similar to the x86 architecture, below comments also apply equally to
> ARM64 architecture. So we can drop the tlb flush operation in
> ptep_clear_flush_young() on ARM64 architecture to improve the performance.
> "
> /* Clearing the accessed bit without a TLB flush
>   * doesn't cause data corruption. [ It could cause incorrect
>   * page aging and the (mistaken) reclaim of hot pages, but the
>   * chance of that should be relatively low. ]
>   *
>   * So as a performance optimization don't flush the TLB when
>   * clearing the accessed bit, it will eventually be flushed by
>   * a context switch or a VM operation anyway. [ In the rare
>   * event of it not getting flushed for a long time the delay
>   * shouldn't really matter because there's no real memory
>   * pressure for swapout to react to. ]
>   */
> "
> Running the thpscale to show some obvious improvements for compaction
> latency with this patch:
>                               base                   patched
> Amean     fault-both-1      1093.19 (   0.00%)     1084.57 *   0.79%*
> Amean     fault-both-3      2566.22 (   0.00%)     2228.45 *  13.16%*
> Amean     fault-both-5      3591.22 (   0.00%)     3146.73 *  12.38%*
> Amean     fault-both-7      4157.26 (   0.00%)     4113.67 *   1.05%*
> Amean     fault-both-12     6184.79 (   0.00%)     5218.70 *  15.62%*
> Amean     fault-both-18     9103.70 (   0.00%)     7739.71 *  14.98%*
> Amean     fault-both-24    12341.73 (   0.00%)    10684.23 *  13.43%*
> Amean     fault-both-30    15519.00 (   0.00%)    13695.14 *  11.75%*
> Amean     fault-both-32    16189.15 (   0.00%)    14365.73 *  11.26%*
>                         base       patched
> Duration User         167.78      161.03
> Duration System      1836.66     1673.01
> Duration Elapsed     2074.58     2059.75
> 
> Barry Song submitted a similar patch [1] before, that replaces the
> ptep_clear_flush_young_notify() with ptep_clear_young_notify() in
> folio_referenced_one(). However, I'm not sure if removing the tlb flush
> operation is applicable to every architecture in kernel, so dropping
> the tlb flush for ARM64 seems a sensible change.

At least x86/s390/riscv/powerpc already do it, also I think we could
change pmdp_clear_flush_young_notify() too, since it is same with
ptep_clear_flush_young_notify(),

> 
> Note: I am okay for both approach, if someone can help to ensure that
> all architectures do not need the tlb flush when clearing the accessed
> bit, then I also think Barry's patch is better (hope Barry can resend
> his patch).
> 
> [1] https://lore.kernel.org/lkml/20220617070555.344368-1-21cnbao@gmail.com/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   arch/arm64/include/asm/pgtable.h | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0bd18de9fd97..2979d796ba9d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>   static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>   					 unsigned long address, pte_t *ptep)
>   {
> -	int young = ptep_test_and_clear_young(vma, address, ptep);
> -
> -	if (young) {
> -		/*
> -		 * We can elide the trailing DSB here since the worst that can
> -		 * happen is that a CPU continues to use the young entry in its
> -		 * TLB and we mistakenly reclaim the associated page. The
> -		 * window for such an event is bounded by the next
> -		 * context-switch, which provides a DSB to complete the TLB
> -		 * invalidation.
> -		 */
> -		flush_tlb_page_nosync(vma, address);
> -	}
> -
> -	return young;
> +	/*
> +	 * This comment is borrowed from x86, but applies equally to ARM64:
> +	 *
> +	 * Clearing the accessed bit without a TLB flush doesn't cause
> +	 * data corruption. [ It could cause incorrect page aging and
> +	 * the (mistaken) reclaim of hot pages, but the chance of that
> +	 * should be relatively low. ]
> +	 *
> +	 * So as a performance optimization don't flush the TLB when
> +	 * clearing the accessed bit, it will eventually be flushed by
> +	 * a context switch or a VM operation anyway. [ In the rare
> +	 * event of it not getting flushed for a long time the delay
> +	 * shouldn't really matter because there's no real memory
> +	 * pressure for swapout to react to. ]
> +	 */
> +	return ptep_test_and_clear_young(vma, address, ptep);
>   }
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
