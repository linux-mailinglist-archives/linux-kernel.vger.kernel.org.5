Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF77DB578
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjJ3IvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjJ3IvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:51:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 262859D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:51:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxpPCFbj9lVrQ1AA--.39661S3;
        Mon, 30 Oct 2023 16:51:17 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx7tyBbj9lBuU2AA--.52806S3;
        Mon, 30 Oct 2023 16:51:15 +0800 (CST)
Message-ID: <292f7c44-a19a-4e0d-a73d-ca621ec26813@loongson.cn>
Date:   Mon, 30 Oct 2023 16:50:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/loongson: Support to infer DC reversion from
 CPU's PRID value
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231029194607.379459-1-suijingfeng@loongson.cn>
 <20231029194607.379459-8-suijingfeng@loongson.cn>
 <CAA8EJpqrWV1f_pFqZt1Evo+WrZfy1mOynaTQ85uY9o4tVPZJPw@mail.gmail.com>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <CAA8EJpqrWV1f_pFqZt1Evo+WrZfy1mOynaTQ85uY9o4tVPZJPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bx7tyBbj9lBuU2AA--.52806S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF13Gr15XrW7AFykKry5WrX_yoWrZrykpF
        W3AF1FkryDGw12k3sxZr18AF1aya4fXFWfuFs7Kw1qk34DAw17WFyUAF4Y9rZxZryxAry2
        vr95KFWY9anIk3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
        XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
        vjDU0xZFpf9x07jbDGOUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/10/30 07:19, Dmitry Baryshkov wrote:
> On Sun, 29 Oct 2023 at 21:46, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>> Due to the fact that the same display IP core has been integrated into
>> different platform, there is a need to differentiate them on the runtime.
>> The DC in LS7A1000/LS2K1000 has the PCI vendor & device ID of 0x0014:0x7A06
>> The DC in LS7A2000/LS2K2000 has the PCI vendor & device ID of 0x0014:0x7A36
>>
>> Because the output ports and host platform of the DC IP varies, without a
>> revision information we can't achieve fine-grained controls. The canonical
>> approach to do such a thing is to read reversion register from the PCIe
>> device. But LS2K1000 SoC was taped out at 2017, it is rather old. Our BIOS
>> engineer don't assign a different revision ID to it, probably because of
>> ignorance.
>>
>> LS2K2000 SoC was newly taped on 2023, we strictly force the BIOS engineer
>> assign a different revision ID(0x10) to it. But the problem is that it is
>> too casual, there is no formal convention or public documented rule
>> established. For Loongson LS2K series SoC, the display controller IP is
>> taped togather with the CPU core. For Loongson LS7A series bridge chips,
>> the display controller IP is taped togather with the bridge chips itself.
>> Consider the fact the all Loongson CPU has a unique PRID, this patch choose
>> to infer DC reversion from CPU's PRID value.
>>
>>   - LS3A4000/LS3A5000 has 0xC0 as its processor ID.
>>   - LS2K2000 has 0xB0 as its processor ID.
>>   - LS2K2000LA has 0xA0 as its processor ID.
>>
>> The provided approach has no dependency on DT or ACPI, thus is preferfed.
>> Besides, this approach can be used to acquire more addtional HW features.
>> So the provided method has the potential to bring more benifits.
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_drv.h   |  2 ++
>>   drivers/gpu/drm/loongson/lsdc_probe.c | 35 +++++++++++++++++++++++++++
>>   drivers/gpu/drm/loongson/lsdc_probe.h |  2 ++
>>   3 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.h b/drivers/gpu/drm/loongson/lsdc_drv.h
>> index 46ba9b88a30d..e1f4a2db2a0a 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_drv.h
>> +++ b/drivers/gpu/drm/loongson/lsdc_drv.h
>> @@ -42,6 +42,8 @@
>>   enum loongson_chip_id {
>>          CHIP_LS7A1000 = 0,
>>          CHIP_LS7A2000 = 1,
>> +       CHIP_LS2K1000 = 2,
>> +       CHIP_LS2K2000 = 3,
>>          CHIP_LS_LAST,
>>   };
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_probe.c b/drivers/gpu/drm/loongson/lsdc_probe.c
>> index 48ba69bb8a98..f49b642d8f65 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_probe.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_probe.c
>> @@ -54,3 +54,38 @@ unsigned int loongson_cpu_get_prid(u8 *imp, u8 *rev)
>>
>>          return prid;
>>   }
>> +
>> +enum loongson_chip_id loongson_chip_id_fixup(enum loongson_chip_id chip_id)
>> +{
>> +       u8 impl;
>> +
>> +       if (loongson_cpu_get_prid(&impl, NULL)) {
>> +               /*
>> +                * LS2K2000 only has the LoongArch edition.
>> +                */
>> +               if (chip_id == CHIP_LS7A2000) {
>> +                       if (impl == LOONGARCH_CPU_IMP_LS2K2000)
>> +                               return CHIP_LS2K2000;
>> +               }
>> +
>> +               /*
>> +                * LS2K1000 has the LoongArch edition(with two LA264 CPU core)
>> +                * and the Mips edition(with two mips64r2 CPU core), Only the
>> +                * instruction set of the CPU are changed, the peripheral
>> +                * devices are basically same.
>> +                */
>> +               if (chip_id == CHIP_LS7A1000) {
>> +#if defined(__loongarch__)
>> +                       if (impl == LOONGARCH_CPU_IMP_LS2K1000)
>> +                               return CHIP_LS2K1000;
>> +#endif
>> +
>> +#if defined(__mips__)
>> +                       if (impl == LOONGSON_CPU_MIPS_IMP_LS2K)
>> +                               return CHIP_LS2K1000;
>> +#endif
> Can you drop the ifdefs here? The code blocks do not seem to conflict
> with each other.

OK, no problem. Will be fixed at the next version.

>> +               }
>> +       }
>> +
>> +       return chip_id;
>> +}
>> diff --git a/drivers/gpu/drm/loongson/lsdc_probe.h b/drivers/gpu/drm/loongson/lsdc_probe.h
>> index 8bb6de2e3c64..8c630c5c90ce 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_probe.h
>> +++ b/drivers/gpu/drm/loongson/lsdc_probe.h
>> @@ -9,4 +9,6 @@
>>   /* Helpers for chip detection */
>>   unsigned int loongson_cpu_get_prid(u8 *impl, u8 *rev);
>>
>> +enum loongson_chip_id loongson_chip_id_fixup(enum loongson_chip_id chip_id);
>> +
>>   #endif
>> --
>> 2.34.1
>>
>

