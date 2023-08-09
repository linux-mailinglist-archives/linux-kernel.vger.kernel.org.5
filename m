Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21840775467
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjHIHsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHIHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:48:01 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91B1B172A;
        Wed,  9 Aug 2023 00:47:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8CxNvGsRNNkb6oTAA--.43075S3;
        Wed, 09 Aug 2023 15:47:56 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX8+rRNNk6utQAA--.5974S3;
        Wed, 09 Aug 2023 15:47:55 +0800 (CST)
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Conor Dooley <conor@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
 <20230808-amount-urban-9a6eb09852ca@spud>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <536a9062-65b2-5518-5c50-1a61e23870ee@loongson.cn>
Date:   Wed, 9 Aug 2023 15:47:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230808-amount-urban-9a6eb09852ca@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX8+rRNNk6utQAA--.5974S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/8 下午8:05, Conor Dooley 写道:
> Hey,
> 
> On Mon, Aug 07, 2023 at 03:40:42PM +0800, Yinbo Zhu wrote:
>> Loongson GPIO controllers come in multiple variants that are compatible
>> except for certain register offset values. Add support in yaml file for
>> device properties allowing to specify them in DT.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   .../bindings/gpio/loongson,ls-gpio.yaml       | 40 ++++++++++++++++++-
>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> index fb86e8ce6349..fc51cf40fccd 100644
>> --- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> @@ -14,6 +14,7 @@ properties:
>>       enum:
>>         - loongson,ls2k-gpio
>>         - loongson,ls7a-gpio
>> +      - loongson,ls2k1000-gpio
> 
> If you're adding new compatibles that depend on the new offset
> properties to function, they could be set up with the existing
> "ls2k-gpio" as a fallback, so that further driver changes are not
> required when you add ones for the 2k500 etc.


okay, I got it.

> 
>>   
>>     reg:
>>       maxItems: 1
>> @@ -29,6 +30,33 @@ properties:
>>   
>>     gpio-ranges: true
>>   
>> +  loongson,gpio-conf-offset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      This option indicate this GPIO configuration register offset address.
>> +
>> +  loongson,gpio-out-offset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      This option indicate this GPIO output register offset address.
>> +
>> +  loongson,gpio-in-offset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      This option indicate this GPIO input register offset address.
>> +
>> +  loongson,gpio-ctrl-mode:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      This option indicate this GPIO control mode, where '0' represents
>> +      bit control mode and '1' represents byte control mode.
> 
> How is one supposed to know which of these modes to use?


Byte mode is to access by byte, such as gpio3, the base address of the
gpio controller is offset by 3 bytes as the access address of gpio3.

The bit mode is the normal mode that like other platform gpio and it is
to access by bit.

If both modes are supported, it is recommended to prioritize using byte
mode that according to spec.

> 
>> +  loongson,gpio-inten-offset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      This option indicate this GPIO interrupt enable register offset
>> +      address.
>> +
> 
> tbh, I want to leave the final say on this stuff to Krzysztof or Rob.
> I'm not really sure what the best way to do to support your GPIO
> controllers is & I don't understand your hardware sufficiently to come
> up with an approach that I would use had I been in your shoes.
> 


okay, I got it.

Thanks,
Yinbo

> 
>>     interrupts:
>>       minItems: 1
>>       maxItems: 64
>> @@ -39,6 +67,11 @@ required:
>>     - ngpios
>>     - "#gpio-cells"
>>     - gpio-controller
>> +  - loongson,gpio-conf-offset
>> +  - loongson,gpio-in-offset
>> +  - loongson,gpio-out-offset
>> +  - loongson,gpio-ctrl-mode
>> +  - loongson,gpio-inten-offset
>>     - gpio-ranges
>>     - interrupts
>>   
>> @@ -49,11 +82,16 @@ examples:
>>       #include <dt-bindings/interrupt-controller/irq.h>
>>   
>>       gpio0: gpio@1fe00500 {
>> -      compatible = "loongson,ls2k-gpio";
>> +      compatible = "loongson,ls2k1000-gpio";
>>         reg = <0x1fe00500 0x38>;
>>         ngpios = <64>;
>>         #gpio-cells = <2>;
>>         gpio-controller;
>> +      loongson,gpio-conf-offset = <0>;
>> +      loongson,gpio-in-offset = <0x20>;
>> +      loongson,gpio-out-offset = <0x10>;
>> +      loongson,gpio-ctrl-mode = <0>;
>> +      loongson,gpio-inten-offset = <0x30>;
>>         gpio-ranges = <&pctrl 0 0 15>,
>>                       <&pctrl 16 16 15>,
>>                       <&pctrl 32 32 10>,
>> -- 
>> 2.20.1
>>

