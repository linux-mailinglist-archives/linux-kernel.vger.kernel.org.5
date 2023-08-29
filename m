Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC7378C34C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjH2L1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjH2L1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:27:48 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87C49109;
        Tue, 29 Aug 2023 04:27:43 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8CxyOgr1u1kxr0cAA--.22945S3;
        Tue, 29 Aug 2023 19:27:39 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX88p1u1khW1mAA--.50881S3;
        Tue, 29 Aug 2023 19:27:38 +0800 (CST)
Subject: Re: [PATCH v4 2/2] gpio: loongson: add more gpio chip support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230823033427.23072-1-zhuyinbo@loongson.cn>
 <20230823033427.23072-3-zhuyinbo@loongson.cn>
 <CACRpkdZJVjwOCGYhmzaPLWbcX0rgrDD-d2OX=TnmYs0F56fGug@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <fd2290b1-66d4-f646-c3c8-b65567eae74a@loongson.cn>
Date:   Tue, 29 Aug 2023 19:27:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZJVjwOCGYhmzaPLWbcX0rgrDD-d2OX=TnmYs0F56fGug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX88p1u1khW1mAA--.50881S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/23 下午8:29, Linus Walleij 写道:
> Hi Yinbo,
> 
> thanks for the new patch, it's starting to look really good!
> The main point with offsets in the match data is very nice.
> 
> On Wed, Aug 23, 2023 at 5:34 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> 
>> This patch was to add loongson 2k0500, 2k2000 and 3a5000 gpio chip
>> driver support.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> (...)
> 
> 
>>   static int loongson_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
>>   {
>> +       unsigned int u;
>>          struct platform_device *pdev = to_platform_device(chip->parent);
>> +       struct loongson_gpio_chip *lgpio = to_loongson_gpio_chip(chip);
>> +
>> +       if (lgpio->chip_data->mode == BIT_CTRL_MODE) {
>> +               u = readl(lgpio->reg_base + lgpio->chip_data->inten_offset + offset / 32 * 4);
>> +               u |= BIT(offset % 32);
>> +               writel(u, lgpio->reg_base + lgpio->chip_data->inten_offset + offset / 32 * 4);
> 
> This offset / 32 * 4 is really hard to read.
> What about
> 
> /* Get the register index from offset then multiply by bytes per register */
> (offset / 32) * 4


okay, I will add it.

> 
>>          lgpio->reg_base = reg_base;
>> +       if (device_property_read_u32(dev, "ngpios", &ngpios) || !ngpios)
>> +               return -EINVAL;
>> +
>> +       ret = DIV_ROUND_UP(ngpios, 8);
>> +       switch (ret) {
>> +       case 1 ... 2:
>> +               io_width = ret;
>> +               break;
>> +       case 3 ... 4:
>> +               io_width = 0x4;
>> +               break;
>> +       case 5 ... 8:
>> +               io_width = 0x8;
>> +               break;
>> +       default:
>> +               dev_err(dev, "unsupported io width\n");
>> +               return -EINVAL;
>> +       }
> 
> Is it really a good idea to infer the register width from ngpios?
> 
> What about just putting this into the struct loongson_gpio_chip_data
> as well? Certainly it will be fixed for a certain device.
> 


Andy's suggestion seems to look better, We have bgpio_init() handle
this switch case. I will remove this switch case.
https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/commit/?h=gpio/for-next&id=55b2395e4e92adc492c6b30ac109eb78250dcd9d

Thanks,
Yinbo

