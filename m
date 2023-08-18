Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1647805CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357915AbjHRGED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357717AbjHRGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:03:55 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4599030E1;
        Thu, 17 Aug 2023 23:03:51 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8BxuOjFCd9kh8wZAA--.17256S3;
        Fri, 18 Aug 2023 14:03:50 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxriPFCd9kk2ldAA--.57484S3;
        Fri, 18 Aug 2023 14:03:49 +0800 (CST)
Message-ID: <175ba9b3-d667-f887-e04c-f19ad15a57e4@loongson.cn>
Date:   Fri, 18 Aug 2023 14:03:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ACPI: processor_core: LoongArch: Get physical id from
 MADT table
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230717022258.2579631-1-maobibo@loongson.cn>
 <fbe94cf6-0fd0-fbb5-4308-e1730e3af214@loongson.cn>
 <CAJZ5v0iU0iQR=s2Df2E8wNnSLDvTAkxGfRrBAowmLEZ9yQKRsA@mail.gmail.com>
Content-Language: en-US
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <CAJZ5v0iU0iQR=s2Df2E8wNnSLDvTAkxGfRrBAowmLEZ9yQKRsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxriPFCd9kk2ldAA--.57484S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw18WrW5trW8Cw47Aw4kZrc_yoW5Zw4kpF
        y8Ka4Yk3WUWF12gw1Sq3WYgFyFv3y8Ca4fWFs7Gry3K3ZYkryfXFWUXryagryUAF4Fk3y0
        vr1UtFZrWFWFvFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
        AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtx
        DUUUU
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/18 00:40, Rafael J. Wysocki 写道:
> On Tue, Jul 25, 2023 at 2:32 AM bibo mao <maobibo@loongson.cn> wrote:
>>
>> slightly ping :)
>>
>> 在 2023/7/17 10:22, Bibo Mao 写道:
>>> With ACPI Spec 6.5 chapter 5.2.12.20, each processor in LoongArch
>>> system has a Core Programmable Interrupt Controller in MADT table,
>>> value of its type is 0x11 in the spec and defined as enum variable
>>> ACPI_MADT_TYPE_CORE_PIC in Linux kernel. Physical id can be parsed
>>> from MADT table for LoongArch system, also it can be parsed from
>>> MAT table for hotplug cpu. This patch adds physical id parsing for
>>> LoongArch system.
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>> Changes in v2:
>>>  Refresh the changelog and add detailed description of acpi spec
>>>  about MADT table for LoongArch system.
>>>
>>>  Add comments in function map_core_pic_id.
>>>
>>> ---
>>>  drivers/acpi/processor_core.c | 29 +++++++++++++++++++++++++++++
>>>  1 file changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
>>> index d6606a9f2da6..7dd6dbaa98c3 100644
>>> --- a/drivers/acpi/processor_core.c
>>> +++ b/drivers/acpi/processor_core.c
>>> @@ -132,6 +132,30 @@ static int map_rintc_hartid(struct acpi_subtable_header *entry,
>>>       return -EINVAL;
>>>  }
>>>
>>> +/*
>>> + * Retrieve LoongArch CPU physical id
>>> + */
>>> +static int map_core_pic_id(struct acpi_subtable_header *entry,
>>> +             int device_declaration, u32 acpi_id, phys_cpuid_t *phys_id)
>>> +{
>>> +     struct acpi_madt_core_pic *core_pic =
>>> +             container_of(entry, struct acpi_madt_core_pic, header);
>>> +
>>> +     if (!(core_pic->flags & ACPI_MADT_ENABLED))
>>> +             return -ENODEV;
>>> +
>>> +     /* device_declaration means Device object in DSDT, in LoongArch
>>> +      * system, logical processor acpi_id is required in _UID property
>>> +      * of DSDT table, so we should check device_declaration here
>>> +      */
>>> +     if (device_declaration && (core_pic->processor_id == acpi_id)) {
>>> +             *phys_id = core_pic->core_id;
>>> +             return 0;
>>> +     }
>>> +
>>> +     return -EINVAL;
>>> +}
>>> +
>>>  static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
>>>                                  int type, u32 acpi_id)
>>>  {
>>> @@ -165,6 +189,9 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
>>>               } else if (header->type == ACPI_MADT_TYPE_RINTC) {
>>>                       if (!map_rintc_hartid(header, type, acpi_id, &phys_id))
>>>                               break;
>>> +             } else if (header->type == ACPI_MADT_TYPE_CORE_PIC) {
>>> +                     if (!map_core_pic_id(header, type, acpi_id, &phys_id))
>>> +                             break;
>>>               }
>>>               entry += header->length;
>>>       }
>>> @@ -216,6 +243,8 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>>>               map_x2apic_id(header, type, acpi_id, &phys_id);
>>>       else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
>>>               map_gicc_mpidr(header, type, acpi_id, &phys_id);
>>> +     else if (header->type == ACPI_MADT_TYPE_CORE_PIC)
>>> +             map_core_pic_id(header, type, acpi_id, &phys_id);
>>>
>>>  exit:
>>>       kfree(buffer.pointer);
>>
> 
> Sorry for the delay.
> 
> Applied (under a slightly edited subject) as 6.6 material, thanks!

Thanks for applying the patch.

