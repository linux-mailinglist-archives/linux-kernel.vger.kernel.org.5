Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B370788F48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHYTjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHYTjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:39:17 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3B2686
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:39:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51F5B60002;
        Fri, 25 Aug 2023 19:39:07 +0000 (UTC)
Message-ID: <6dcfcf22-08a4-ba1f-17c2-75f93efb6329@ghiti.fr>
Date:   Fri, 25 Aug 2023 21:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] riscv: support arch_has_hw_pte_young()
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Jinyu Tang <tjytimi@163.com>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        yuzhao@google.com, conor.dooley@microchip.com,
        ajones@ventanamicro.com, guoren@kernel.org, tongtiangen@huawei.com,
        anup@brainfault.org, akpm@linux-foundation.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
References: <20230129064956.143664-1-tjytimi@163.com>
 <CAMWQL2gBj84qhBopi=YKmHaUose2ggALKtOWqb6adDiuvS5xcg@mail.gmail.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAMWQL2gBj84qhBopi=YKmHaUose2ggALKtOWqb6adDiuvS5xcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong-Xuan,


On 25/08/2023 07:42, Yong-Xuan Wang wrote:
> Hi Jinyu,
>
> It seems like it has been a while since the last release of this patch. Do
> you have any plans for the patch recently? Or, do you mind sharing any
> internal progress on the patch?
>
> We are starting to work on the Svadu extension of pte A/D bit feature on
> Linux.


This task was assigned to me on the RISE kernel spreadsheet, if you 
indeed take over, I'll change it to your name: any objection?


Thanks,


Alex


> Do you find any places where we may potentially work together to
> get things moving? Also, I am willing to base on top of your work and
> continue sending the series (by keeping all the credits from the original
> work)
>
> Please let me know if you have any thoughts, thanks :)
>
> Regards,
> Yong-Xuan
>
> On Sun, Jan 29, 2023 at 2:53 PM Jinyu Tang <tjytimi@163.com> wrote:
>> The arch_has_hw_pte_young() is false for riscv by default. If it's
>> false, page table walk is almost skipped for MGLRU reclaim. And it
>> will also cause useless step in __wp_page_copy_user().
>>
>> RISC-V Privileged Book says that riscv have two schemes to manage A
>> and D bit.
>>
>> So add a config for selecting, the default is true. For simple
>> implementation riscv CPU which just generate page fault, unselect it.
>>
>> Signed-off-by: Jinyu Tang <tjytimi@163.com>
>> ---
>>   arch/riscv/Kconfig               | 10 ++++++++++
>>   arch/riscv/include/asm/pgtable.h |  7 +++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index e2b656043abf..17c82885549c 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -180,6 +180,16 @@ config PAGE_OFFSET
>>          default 0x80000000 if 64BIT && !MMU
>>          default 0xff60000000000000 if 64BIT
>>
>> +config ARCH_HAS_HARDWARE_PTE_YOUNG
>> +       bool "Hardware Set PTE Access Bit"
>> +       default y
>> +       help
>> +         Select if hardware set A bit when PTE is accessed. The default is
>> +         'Y', because most RISC-V CPU hardware can manage A and D bit.
>> +         But RISC-V may have simple implementation that do not support
>> +         hardware set A bit but only generate page fault, for that case just
>> +         unselect it.
>> +
>>   config KASAN_SHADOW_OFFSET
>>          hex
>>          depends on KASAN_GENERIC
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 4eba9a98d0e3..1db54ab4e1ba 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -532,6 +532,13 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>>           */
>>          return ptep_test_and_clear_young(vma, address, ptep);
>>   }
>> +#ifdef CONFIG_ARCH_HAS_HARDWARE_PTE_YOUNG
>> +#define arch_has_hw_pte_young arch_has_hw_pte_young
>> +static inline bool arch_has_hw_pte_young(void)
>> +{
>> +       return true;
>> +}
>> +#endif
>>
>>   #define pgprot_noncached pgprot_noncached
>>   static inline pgprot_t pgprot_noncached(pgprot_t _prot)
>> --
>> 2.30.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
