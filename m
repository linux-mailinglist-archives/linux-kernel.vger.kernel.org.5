Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984BE7851B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjHWHhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjHWHg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:36:59 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1CE4E61;
        Wed, 23 Aug 2023 00:36:36 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8BxY_ADt+Vk_SMbAA--.55458S3;
        Wed, 23 Aug 2023 15:36:35 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX88At+VkqyBhAA--.39583S3;
        Wed, 23 Aug 2023 15:36:33 +0800 (CST)
Subject: Re: [PATCH v3 2/2] gpio: loongson: add firmware offset parse support
To:     andy.shevchenko@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-3-zhuyinbo@loongson.cn>
 <ZNqhM18XoaqNdN99@surfacebook.localdomain>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <04c72d20-6f4d-b957-ee77-6bcbe279f8b2@loongson.cn>
Date:   Wed, 23 Aug 2023 15:36:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZNqhM18XoaqNdN99@surfacebook.localdomain>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX88At+VkqyBhAA--.39583S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi andy,

Sorry, I lost this email due to issues with my company's email server. I
will adopt your suggestion in v5 version.

ÔÚ 2023/8/15 ÉÏÎç5:48, andy.shevchenko@gmail.com Ð´µÀ:
> Mon, Aug 07, 2023 at 03:40:43PM +0800, Yinbo Zhu kirjoitti:
>> Loongson GPIO controllers come in multiple variants that are compatible
>> except for certain register offset values.  Add support for device
>> properties allowing to specify them in ACPI or DT.
> 
>> +	if (device_property_read_u32(dev, "ngpios", &ngpios) || !ngpios)
>> +		return -EINVAL;
>> +
>> +	ret = DIV_ROUND_UP(ngpios, 8);
>> +	switch (ret) {
>> +	case 1 ... 2:
>> +		io_width = ret;
>> +		break;
>> +	case 3 ... 4:
>> +		io_width = 0x4;
>> +		break;
>> +	case 5 ... 8:
>> +		io_width = 0x8;
>> +		break;
>> +	default:
>> +		dev_err(dev, "unsupported io width\n");
>> +		return -EINVAL;
>> +	}
> 
> Why? We have bgpio_init() handle this.
> https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/commit/?h=gpio/for-next&id=55b2395e4e92adc492c6b30ac109eb78250dcd9d


okay, I got it.

> 
> ...
> 
>> +	lgpio->chip.can_sleep = 0;
> 
> It's boolean, use boolean initializer.


okay, I got it.

> 
> ...
> 
>> +	if (lgpio->chip_data->label)
>> +		lgpio->chip.label = lgpio->chip_data->label;
>> +	else
>> +		lgpio->chip.label = kstrdup(to_platform_device(dev)->name, GFP_KERNEL);
> 
> No error check? Not a devm_*() variant, so leaking memory?


This code had been removed in v4.

> 
> ...
> 
>> +	{
>> +		.id = "LOON0007",
>> +	},
> 
> How does DSDT excerpt for this device look like?


LOON0007 and LOON000A are similar, LOON000A is for 2k2000 gpio0.

      Device (GPO0)
         {
             Name (_HID, "LOON000A")  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
             Name (_UID, One)  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource 
Settings
             {
                 QWordMemory (ResourceConsumer, PosDecode, MinFixed, 
MaxFixed, NonCacheable, ReadWrite,
                     0x0000000000000000, // Granularity
                     0x000000001FE00500, // Range Minimum
                     0x000000001FE00520, // Range Maximum
                     0x0000000000000000, // Translation Offset
                     0x0000000000000021, // Length
                     ,, , AddressRangeMemory, TypeStatic)
             })
             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
             {
                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* 
Device Properties for _DSD */,
                 Package (0x01)
                 {
                     Package (0x02)
                     {
                         "ngpios",
                         0x20
                     }
                 }
             })
         }


Thanks,
Yinbo

