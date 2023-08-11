Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1732A778639
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjHKDuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHKDug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:50:36 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE7082D70;
        Thu, 10 Aug 2023 20:50:34 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8AxFvEIsNVkJ0YVAA--.45296S3;
        Fri, 11 Aug 2023 11:50:32 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxniMGsNVkDExUAA--.38354S3;
        Fri, 11 Aug 2023 11:50:32 +0800 (CST)
Subject: Re: [PATCH v3 2/2] gpio: loongson: add firmware offset parse support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-3-zhuyinbo@loongson.cn>
 <CACRpkdZfx8BGHxj4OyS7HG9=mq5DrVHzHKhehxV1nfKwyMHpwQ@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <768426b7-7192-8902-1d93-189a7fd64214@loongson.cn>
Date:   Fri, 11 Aug 2023 11:50:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZfx8BGHxj4OyS7HG9=mq5DrVHzHKhehxV1nfKwyMHpwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxniMGsNVkDExUAA--.38354S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/10 下午4:27, Linus Walleij 写道:
> Hi Yinbo,
> 
> thanks for your patch!
> 
> On Mon, Aug 7, 2023 at 9:41 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> 
>> Loongson GPIO controllers come in multiple variants that are compatible
>> except for certain register offset values.  Add support for device
>> properties allowing to specify them in ACPI or DT.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> 
> (...)
>> @@ -26,6 +26,7 @@ struct loongson_gpio_chip_data {
>>          unsigned int            conf_offset;
>>          unsigned int            out_offset;
>>          unsigned int            in_offset;
>> +       unsigned int            inten_offset;
> 
> Consider just changing all of these from unsigned int to u32.


okay, I got it.

> 
> (...)
>> +       if (device_property_read_u32(dev, "loongson,gpio-conf-offset", (u32 *)&d->conf_offset)
>> +           || device_property_read_u32(dev, "loongson,gpio-in-offset", (u32 *)&d->in_offset)
>> +           || device_property_read_u32(dev, "loongson,gpio-out-offset", (u32 *)&d->out_offset)
>> +           || device_property_read_u32(dev, "loongson,gpio-ctrl-mode", (u32 *)&d->mode))
> 
> Because then you can get rid of this annoying forest of cast.


Change offset to u32 and here still need use a (u32 *) cast, because the
chip_data is const type so &chip_data->offset will be (const u32 *) type
and need a (u32 *) cast.

> 
> I'm fine with doing this change in this patch without a need for a separate
> refactoring, as it's just a contained driver and clearly just about typing.


okay, I got it.

Thanks,
Yinbo.


