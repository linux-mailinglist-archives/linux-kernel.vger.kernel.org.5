Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575087691B2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGaJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGaJ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:28:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0AA11B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:28:57 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RDtBf1XbkzNmbm;
        Mon, 31 Jul 2023 17:25:30 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 17:28:54 +0800
Message-ID: <d9694393-d916-0d7f-8fce-ac656de544de@huawei.com>
Date:   Mon, 31 Jul 2023 17:28:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/4] arm64: tlb: set huge page size to stride for hugepage
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, <kirill@shutemov.name>,
        <joel@joelfernandes.org>, <william.kucharski@oracle.com>,
        <kaleshsingh@google.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230731074829.79309-1-wangkefeng.wang@huawei.com>
 <20230731074829.79309-5-wangkefeng.wang@huawei.com>
 <CAGsJ_4xvSyvskcKMptiwm+8eV-sgSWsJYgBEYpwQ2n=cHHNZ7Q@mail.gmail.com>
 <CAGsJ_4yrsgJAzKq_-rPTnnr-AFXzgDK94m+WYxiAw4vq+TfGdA@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAGsJ_4yrsgJAzKq_-rPTnnr-AFXzgDK94m+WYxiAw4vq+TfGdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/31 16:43, Barry Song wrote:
> On Mon, Jul 31, 2023 at 4:33 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Mon, Jul 31, 2023 at 4:14 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>
>>> It is better to use huge_page_size() for hugepage(HugeTLB) instead of
>>> PAGE_SIZE for stride, which has been done in flush_pmd/pud_tlb_range(),
>>> it could reduce the loop in __flush_tlb_range().
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>   arch/arm64/include/asm/tlbflush.h | 21 +++++++++++----------
>>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>>> index 412a3b9a3c25..25e35e6f8093 100644
>>> --- a/arch/arm64/include/asm/tlbflush.h
>>> +++ b/arch/arm64/include/asm/tlbflush.h
>>> @@ -360,16 +360,17 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>>>          dsb(ish);
>>>   }
>>>
>>> -static inline void flush_tlb_range(struct vm_area_struct *vma,
>>> -                                  unsigned long start, unsigned long end)
>>> -{
>>> -       /*
>>> -        * We cannot use leaf-only invalidation here, since we may be invalidating
>>> -        * table entries as part of collapsing hugepages or moving page tables.
>>> -        * Set the tlb_level to 0 because we can not get enough information here.
>>> -        */
>>> -       __flush_tlb_range(vma, start, end, PAGE_SIZE, false, 0);
>>> -}
>>> +/*
>>> + * We cannot use leaf-only invalidation here, since we may be invalidating
>>> + * table entries as part of collapsing hugepages or moving page tables.
>>> + * Set the tlb_level to 0 because we can not get enough information here.
>>> + */
>>> +#define flush_tlb_range(vma, start, end)                               \
>>> +       __flush_tlb_range(vma, start, end,                              \
>>> +                               ((vma)->vm_flags & VM_HUGETLB)          \
>>> +                               ? huge_page_size(hstate_vma(vma))       \
>>> +                               : PAGE_SIZE, false, 0)
>>> +
>>
>> seems like a good idea.
>>
>> I wonder if a better implementation will be MMU_GATHER_PAGE_SIZE,  in this case,
>> we are going to support stride for other large folios as well, such as thp.
>>
> 
> BTW, in most cases we have already had right stride:
> 
> arch/arm64/include/asm/tlb.h has already this to get stride:

MMU_GATHER_PAGE_SIZE works for tlb_flush, but flush_tlb_range()
directly called without mmu_gather, see above 3 patches is to
use correct flush_[hugetlb/pmd/pud]_tlb_range(also there are
some other places, like get_clear_contig_flush/clear_flush on arm64),
so enable MMU_GATHER_PAGE_SIZE for arm64 is independent thing, right?

> 
> static inline void tlb_flush(struct mmu_gather *tlb)
> {
>     struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
>     bool last_level = !tlb->freed_tables;
>     unsigned long stride = tlb_get_unmap_size(tlb);
>     int tlb_level = tlb_get_level(tlb);
> 
>     /*
>      * If we're tearing down the address space then we only care about
>      * invalidating the walk-cache, since the ASID allocator won't
>      * reallocate our ASID without invalidating the entire TLB.
>    */
>    if (tlb->fullmm) {
>        if (!last_level)
>             flush_tlb_mm(tlb->mm);
>         return;
>    }
> 
>     __flush_tlb_range(&vma, tlb->start, tlb->end, stride,
>      last_level, tlb_level);
> }
> 
>>>
>>>   static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>>>   {
>>> --
>>> 2.41.0
>>>
>>
>> Thanks
>> Barry
