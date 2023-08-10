Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAD1776F25
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjHJEnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjHJEnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:43:01 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 710221BFB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:42:59 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8BxuOjRatRkQmAUAA--.8276S3;
        Thu, 10 Aug 2023 12:42:57 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxviPQatRkLnZSAA--.34237S3;
        Thu, 10 Aug 2023 12:42:56 +0800 (CST)
Message-ID: <268b625c-06ae-6429-b20c-b67190599bdb@loongson.cn>
Date:   Thu, 10 Aug 2023 12:42:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] LoongArch: mm: Add unified function
 populate_kernel_pte
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, WANG Xuerui <kernel@xen0n.name>
References: <20230712031622.1888321-1-maobibo@loongson.cn>
 <20230712031622.1888321-4-maobibo@loongson.cn>
 <CAAhV-H5pHoFo7i8EpacLU=AWKKPckssJN1aThi+Bb8PPHn0gkA@mail.gmail.com>
 <e6139ffa-92e5-8247-ba0b-71def4795104@loongson.cn>
 <CAAhV-H7Y9SGaLA3+x8-kMg0eWW3UeGLTGMnmcTp7xftJPiJSoA@mail.gmail.com>
 <b4b21efb-a0c7-4625-91e7-4d0c5b80a249@loongson.cn>
 <CAAhV-H7kBP-qME2mxwQKqYeggWu4ApqAJukz3eZxfqsYzRvGEA@mail.gmail.com>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H7kBP-qME2mxwQKqYeggWu4ApqAJukz3eZxfqsYzRvGEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviPQatRkLnZSAA--.34237S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Aw17Jw4DCw4fAF1kCr1Dtwc_yoW3Jr1Upr
        ZrJF1vvF4UXr1UJ39Fqw1Ygrnrtw1DK3WUWrnrJ3W8A34qqrnrGF1UJr1Uury0yF45JF48
        Xr15KrsxCa4UX3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7BMNUUU
        UU=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/10 12:27, Huacai Chen 写道:
> On Thu, Aug 10, 2023 at 12:09 PM bibo mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> 在 2023/8/2 15:25, Huacai Chen 写道:
>>> On Tue, Aug 1, 2023 at 9:22 AM bibo mao <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> 在 2023/7/31 22:15, Huacai Chen 写道:
>>>>> On Wed, Jul 12, 2023 at 11:16 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>> Function pcpu_populate_pte and fixmap_pte are similar, they populate
>>>>>> one page from kernel address space. And there is confusion between
>>>>>> pgd and p4d in function fixmap_pte, such as pgd_none always returns
>>>>>> zero. This patch adds unified function populate_kernel_pte and replaces
>>>>>> pcpu_populate_pte and fixmap_pte.
>>>>>>
>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>>> ---
>>>>>>  arch/loongarch/include/asm/pgalloc.h |  1 +
>>>>>>  arch/loongarch/kernel/numa.c         | 40 +--------------------
>>>>>>  arch/loongarch/mm/init.c             | 52 ++++++++++++++++------------
>>>>>>  3 files changed, 32 insertions(+), 61 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
>>>>>> index af1d1e4a6965..ca17b573dba6 100644
>>>>>> --- a/arch/loongarch/include/asm/pgalloc.h
>>>>>> +++ b/arch/loongarch/include/asm/pgalloc.h
>>>>>> @@ -91,4 +91,5 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>>>>>>
>>>>>>  #endif /* __PAGETABLE_PUD_FOLDED */
>>>>>>
>>>>>> +extern pte_t * __init populate_kernel_pte(unsigned long addr);
>>>>>>  #endif /* _ASM_PGALLOC_H */
>>>>>> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
>>>>>> index 778e1c20bfb0..24a693b76873 100644
>>>>>> --- a/arch/loongarch/kernel/numa.c
>>>>>> +++ b/arch/loongarch/kernel/numa.c
>>>>>> @@ -67,46 +67,8 @@ static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
>>>>>>
>>>>>>  void __init pcpu_populate_pte(unsigned long addr)
>>>>>>  {
>>>>>> -       pgd_t *pgd = pgd_offset_k(addr);
>>>>>> -       p4d_t *p4d = p4d_offset(pgd, addr);
>>>>>> -       pud_t *pud;
>>>>>> -       pmd_t *pmd;
>>>>>> -
>>>>>> -       if (p4d_none(*p4d)) {
>>>>>> -               pud = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
>>>>>> -               if (!pud)
>>>>>> -                       goto err_alloc;
>>>>>> -               p4d_populate(&init_mm, p4d, pud);
>>>>>> -#ifndef __PAGETABLE_PUD_FOLDED
>>>>>> -               pud_init(pud);
>>>>>> -#endif
>>>>>> -       }
>>>>>> -
>>>>>> -       pud = pud_offset(p4d, addr);
>>>>>> -       if (pud_none(*pud)) {
>>>>>> -               pmd = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
>>>>>> -               if (!pmd)
>>>>>> -                       goto err_alloc;
>>>>>> -               pud_populate(&init_mm, pud, pmd);
>>>>>> -#ifndef __PAGETABLE_PMD_FOLDED
>>>>>> -               pmd_init(pmd);
>>>>>> -#endif
>>>>>> -       }
>>>>>> -
>>>>>> -       pmd = pmd_offset(pud, addr);
>>>>>> -       if (!pmd_present(*pmd)) {
>>>>>> -               pte_t *pte;
>>>>>> -
>>>>>> -               pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>>>>>> -               if (!pte)
>>>>>> -                       goto err_alloc;
>>>>>> -               pmd_populate_kernel(&init_mm, pmd, pte);
>>>>>> -       }
>>>>>> -
>>>>>> +       populate_kernel_pte(addr);
>>>>>>         return;
>>>>>> -
>>>>>> -err_alloc:
>>>>>> -       panic("%s: Failed to allocate memory\n", __func__);
>>>>>>  }
>>>>>>
>>>>>>  void __init setup_per_cpu_areas(void)
>>>>>> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
>>>>>> index 3b7d8129570b..6cd2948373ae 100644
>>>>>> --- a/arch/loongarch/mm/init.c
>>>>>> +++ b/arch/loongarch/mm/init.c
>>>>>> @@ -191,46 +191,49 @@ void vmemmap_free(unsigned long start, unsigned long end, struct vmem_altmap *al
>>>>>>  #endif
>>>>>>  #endif
>>>>>>
>>>>>> -static pte_t *fixmap_pte(unsigned long addr)
>>>>>> +pte_t * __init populate_kernel_pte(unsigned long addr)
>>>>>>  {
>>>>>> -       pgd_t *pgd;
>>>>>> -       p4d_t *p4d;
>>>>>> +       pgd_t *pgd = pgd_offset_k(addr);
>>>>>> +       p4d_t *p4d = p4d_offset(pgd, addr);
>>>>>>         pud_t *pud;
>>>>>>         pmd_t *pmd;
>>>>>>
>>>>>> -       pgd = pgd_offset_k(addr);
>>>>>> -       p4d = p4d_offset(pgd, addr);
>>>>>> -
>>>>>> -       if (pgd_none(*pgd)) {
>>>>>> -               pud_t *new __maybe_unused;
>>>>>> -
>>>>>> -               new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
>>>>>> -               pgd_populate(&init_mm, pgd, new);
>>>>>> +       if (p4d_none(*p4d)) {
>>>>>> +               pud = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
>>>>>> +               if (!pud)
>>>>>> +                       goto err_alloc;
>>>>>> +               p4d_populate(&init_mm, p4d, pud);
>>>>>>  #ifndef __PAGETABLE_PUD_FOLDED
>>>>>> -               pud_init(new);
>>>>>> +               pud_init(pud);
>>>>>>  #endif
>>>>>>         }
>>>>>>
>>>>>>         pud = pud_offset(p4d, addr);
>>>>>>         if (pud_none(*pud)) {
>>>>>> -               pmd_t *new __maybe_unused;
>>>>>> -
>>>>>> -               new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
>>>>>> -               pud_populate(&init_mm, pud, new);
>>>>>> +               pmd = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
>>>>>> +               if (!pmd)
>>>>>> +                       goto err_alloc;
>>>>>> +               pud_populate(&init_mm, pud, pmd);
>>>>>>  #ifndef __PAGETABLE_PMD_FOLDED
>>>>>> -               pmd_init(new);
>>>>>> +               pmd_init(pmd);
>>>>>>  #endif
>>>>>>         }
>>>>>>
>>>>>>         pmd = pmd_offset(pud, addr);
>>>>>> -       if (pmd_none(*pmd)) {
>>>>>> -               pte_t *new __maybe_unused;
>>>>>> +       if (!pmd_present(*pmd)) {
>>>>>> +               pte_t *pte;
>>>>>>
>>>>>> -               new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
>>>>>> -               pmd_populate_kernel(&init_mm, pmd, new);
>>>>>> +               pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>>>>> I don't think memblock_alloc_low() here can be replaced by memblock_alloc().
>>>> Can you share me the points that pte table must be allocated with memblock_alloc_low
>>>> in this place?
>>> I forget the reason now, so if you confirm memblock_alloc() works well
>>> here, you can use it. But please don't use memblock_alloc_raw().
>> what a mess, there is more comments if there is special reason, else everyone can
>> forgot by elapsed time.
>>
>> why the function memblock_alloc_raw can not be use? there is one useless page copy.
> This is not a performance critical path, keeping consistency with
> mm/percpu.c can make life easier.
yes, it is not critical path, it influences boot speed. Can we make it better? else it
will be just so so.

Regards
Bibo Mao
> 
> Huacai
> 
>>
>> Regards
>> Bibo Mao
>>
>>
>>>
>>> Huacai
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>>
>>>>>
>>>>> Huacai
>>>>>> +               if (!pte)
>>>>>> +                       goto err_alloc;
>>>>>> +               pmd_populate_kernel(&init_mm, pmd, pte);
>>>>>>         }
>>>>>>
>>>>>>         return pte_offset_kernel(pmd, addr);
>>>>>> +
>>>>>> +err_alloc:
>>>>>> +       panic("%s: Failed to allocate memory\n", __func__);
>>>>>> +       return NULL;
>>>>>>  }
>>>>>>
>>>>>>  void __init __set_fixmap(enum fixed_addresses idx,
>>>>>> @@ -241,7 +244,12 @@ void __init __set_fixmap(enum fixed_addresses idx,
>>>>>>
>>>>>>         BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
>>>>>>
>>>>>> -       ptep = fixmap_pte(addr);
>>>>>> +       /*
>>>>>> +        * Now only FIX_EARLYCON_MEM_BASE fixed map is used
>>>>>> +        * __set_fixmap must be called before mem_init since function
>>>>>> +        * populate_kernel_pte allocates memory with memblock_alloc method.
>>>>>> +        */
>>>>>> +       ptep = populate_kernel_pte(addr);
>>>>>>         if (!pte_none(*ptep)) {
>>>>>>                 pte_ERROR(*ptep);
>>>>>>                 return;
>>>>>> --
>>>>>> 2.27.0
>>>>>>
>>>>
>>>>
>>
>>

