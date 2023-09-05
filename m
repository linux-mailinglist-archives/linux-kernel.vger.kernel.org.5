Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D52792C11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353570AbjIERGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354374AbjIELFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:05:46 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96202132
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:05:42 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8AxlPCFC_dko4cfAA--.63534S3;
        Tue, 05 Sep 2023 19:05:41 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3yOEC_dkhcpsAA--.24938S3;
        Tue, 05 Sep 2023 19:05:40 +0800 (CST)
Message-ID: <c8339828-daa8-2426-49cb-dd59aa1487bb@loongson.cn>
Date:   Tue, 5 Sep 2023 19:05:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] LoongArch: Use static defined zero page rather than
 allocated
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230905080147.1625448-1-maobibo@loongson.cn>
 <20230905080147.1625448-3-maobibo@loongson.cn>
 <CAAhV-H6DR7huH+c9ox9vsHDaQf5BAOvhvZtpKY5rKUQsEpbVOA@mail.gmail.com>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H6DR7huH+c9ox9vsHDaQf5BAOvhvZtpKY5rKUQsEpbVOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx3yOEC_dkhcpsAA--.24938S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurWkur1kXr48JFy5JFyDXFc_yoWrJrWrpF
        9rAF1vgF4rGr97Aryxt3sxur1kJanxKF4IgF12yF98uF9FqryvkF1ktrykXFyjv3yxGFW0
        qF4rJwnIvF1DJabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/5 18:59, Huacai Chen 写道:
> Hi, Bibo,
> 
> On Tue, Sep 5, 2023 at 4:01 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Like other popular architectures, zero page is defined in kernel
>> BSS code segment, rather than dynamically alloted page. It is
>> simpler.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>  arch/loongarch/include/asm/mmzone.h  |  2 --
>>  arch/loongarch/include/asm/pgtable.h |  6 ++----
>>  arch/loongarch/kernel/numa.c         |  1 -
>>  arch/loongarch/mm/init.c             | 21 +--------------------
>>  4 files changed, 3 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/mmzone.h b/arch/loongarch/include/asm/mmzone.h
>> index fe67d0b4b33d..2b9a90727e19 100644
>> --- a/arch/loongarch/include/asm/mmzone.h
>> +++ b/arch/loongarch/include/asm/mmzone.h
>> @@ -13,6 +13,4 @@ extern struct pglist_data *node_data[];
>>
>>  #define NODE_DATA(nid) (node_data[(nid)])
>>
>> -extern void setup_zero_pages(void);
>> -
>>  #endif /* _ASM_MMZONE_H_ */
>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
>> index 342c5f9c25d2..70bd57daf42a 100644
>> --- a/arch/loongarch/include/asm/pgtable.h
>> +++ b/arch/loongarch/include/asm/pgtable.h
>> @@ -70,10 +70,8 @@ struct vm_area_struct;
>>   * for zero-mapped memory areas etc..
>>   */
>>
>> -extern unsigned long empty_zero_page;
>> -
>> -#define ZERO_PAGE(vaddr) \
>> -       (virt_to_page((void *)(empty_zero_page)))
>> +extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>> +#define ZERO_PAGE(vaddr)       ((void)(vaddr), virt_to_page(empty_zero_page))
> Can we simply use virt_to_page(empty_zero_page) here? Only x86 does it
> like this now.
will do in next patch.

Regards
Bibo Mao
> 
> Huacai
>>
>>  /*
>>   * TLB refill handlers may also map the vmalloc area into xkvrange.
>> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
>> index 708665895b47..6f464d49f0c2 100644
>> --- a/arch/loongarch/kernel/numa.c
>> +++ b/arch/loongarch/kernel/numa.c
>> @@ -470,7 +470,6 @@ void __init mem_init(void)
>>  {
>>         high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
>>         memblock_free_all();
>> -       setup_zero_pages();     /* This comes from node 0 */
>>  }
>>
>>  int pcibus_to_node(struct pci_bus *bus)
>> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
>> index 8ec668f97b00..628ebe42b519 100644
>> --- a/arch/loongarch/mm/init.c
>> +++ b/arch/loongarch/mm/init.c
>> @@ -35,27 +35,9 @@
>>  #include <asm/pgalloc.h>
>>  #include <asm/tlb.h>
>>
>> -unsigned long empty_zero_page;
>> +unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
>>  EXPORT_SYMBOL(empty_zero_page);
>>
>> -void setup_zero_pages(void)
>> -{
>> -       unsigned int order, i;
>> -       struct page *page;
>> -
>> -       order = 0;
>> -
>> -       empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>> -       if (!empty_zero_page)
>> -               panic("Oh boy, that early out of memory?");
>> -
>> -       page = virt_to_page((void *)empty_zero_page);
>> -       split_page(page, order);
>> -       for (i = 0; i < (1 << order); i++, page++)
>> -               mark_page_reserved(page);
>> -
>> -}
>> -
>>  void copy_user_highpage(struct page *to, struct page *from,
>>         unsigned long vaddr, struct vm_area_struct *vma)
>>  {
>> @@ -99,7 +81,6 @@ void __init mem_init(void)
>>         high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
>>
>>         memblock_free_all();
>> -       setup_zero_pages();     /* Setup zeroed pages.  */
>>  }
>>  #endif /* !CONFIG_NUMA */
>>
>> --
>> 2.27.0
>>
>>

