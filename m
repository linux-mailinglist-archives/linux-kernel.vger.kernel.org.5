Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2823676A624
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjHABSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjHABS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:18:28 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D01F114
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 18:18:25 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8AxV_FgXchk6cANAA--.33079S3;
        Tue, 01 Aug 2023 09:18:24 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_yNeXchkCmZDAA--.3784S3;
        Tue, 01 Aug 2023 09:18:23 +0800 (CST)
Message-ID: <bae284ee-aa1d-a31e-20bf-73db79824717@loongson.cn>
Date:   Tue, 1 Aug 2023 09:18:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] LoongArch: Code cleanup in function pcpu_populate_pte
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, WANG Xuerui <kernel@xen0n.name>
References: <20230712031622.1888321-1-maobibo@loongson.cn>
 <20230712031622.1888321-3-maobibo@loongson.cn>
 <CAAhV-H4nG=vRqaU+q7j3Kp9v24u-NNEjdisF34QP-kM+_J2+tg@mail.gmail.com>
Content-Language: en-US
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H4nG=vRqaU+q7j3Kp9v24u-NNEjdisF34QP-kM+_J2+tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_yNeXchkCmZDAA--.3784S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw1DCFWDJr48Zw1xJw1UJwc_yoW5Gw1xpr
        ZrJ3ZYvFs8Wrn7Gay3X3sYgrnrtwsYg3W7Kw47XF18AasFqrnrKw1kGrsruryjvFW7AF4I
        vF45Jrnxua1qq3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/31 22:15, Huacai Chen 写道:
> On Wed, Jul 12, 2023 at 11:16 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> There are some code cleanups in function pcpu_populate_pte:
>> 1. Replace memblock_alloc with memblock_alloc_raw for pud and pmd since
>> they will be reinitialized with pud_init and pmd_init.
>>
>> 2. Add memory allocation failure handling
>>
>> 3. Replace pgd_populate with p4d_populate, it will be useful if there
>> four-level page tables.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>  arch/loongarch/kernel/numa.c | 33 ++++++++++++++++++++-------------
>>  1 file changed, 20 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
>> index 708665895b47..778e1c20bfb0 100644
>> --- a/arch/loongarch/kernel/numa.c
>> +++ b/arch/loongarch/kernel/numa.c
>> @@ -73,33 +73,40 @@ void __init pcpu_populate_pte(unsigned long addr)
>>         pmd_t *pmd;
>>
>>         if (p4d_none(*p4d)) {
>> -               pud_t *new;
>> -
>> -               new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> -               pgd_populate(&init_mm, pgd, new);
>> +               pud = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> Don't use memblock_alloc_raw() here, it is better to keep consistency
> with mm/percpu.c.
memblock_alloc will clear the page, and there will be page table initialization
with the following pud_init(pud). memblock_alloc_raw will not clear the page.

I prefer memblock_alloc_raw for better performance however ok with both, it is
up to you to decide.

Regards
Bibo Mao

> 
> 
> Huacai
>> +               if (!pud)
>> +                       goto err_alloc;
>> +               p4d_populate(&init_mm, p4d, pud);
>>  #ifndef __PAGETABLE_PUD_FOLDED
>> -               pud_init(new);
>> +               pud_init(pud);
>>  #endif
>>         }
>>
>>         pud = pud_offset(p4d, addr);
>>         if (pud_none(*pud)) {
>> -               pmd_t *new;
>> -
>> -               new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> -               pud_populate(&init_mm, pud, new);
>> +               pmd = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
>> +               if (!pmd)
>> +                       goto err_alloc;
>> +               pud_populate(&init_mm, pud, pmd);
>>  #ifndef __PAGETABLE_PMD_FOLDED
>> -               pmd_init(new);
>> +               pmd_init(pmd);
>>  #endif
>>         }
>>
>>         pmd = pmd_offset(pud, addr);
>>         if (!pmd_present(*pmd)) {
>> -               pte_t *new;
>> +               pte_t *pte;
>>
>> -               new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> -               pmd_populate_kernel(&init_mm, pmd, new);
>> +               pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> +               if (!pte)
>> +                       goto err_alloc;
>> +               pmd_populate_kernel(&init_mm, pmd, pte);
>>         }
>> +
>> +       return;
>> +
>> +err_alloc:
>> +       panic("%s: Failed to allocate memory\n", __func__);
>>  }
>>
>>  void __init setup_per_cpu_areas(void)
>> --
>> 2.27.0
>>

