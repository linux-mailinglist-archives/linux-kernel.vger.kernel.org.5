Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AB2775423
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjHIHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjHIH3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:29:50 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2CD52129;
        Wed,  9 Aug 2023 00:29:06 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8BxpPApQNNkn6UTAA--.42873S3;
        Wed, 09 Aug 2023 15:28:41 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxniMnQNNkxd9QAA--.31150S3;
        Wed, 09 Aug 2023 15:28:40 +0800 (CST)
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
 <91f57b0d-a6e9-c039-40b6-0a1a9af5f7a0@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <78c5a043-3e2a-48d6-88bd-2f91cc6d1347@loongson.cn>
Date:   Wed, 9 Aug 2023 15:28:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <91f57b0d-a6e9-c039-40b6-0a1a9af5f7a0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxniMnQNNkxd9QAA--.31150S3
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



在 2023/8/8 下午11:05, Krzysztof Kozlowski 写道:
> On 07/08/2023 09:40, Yinbo Zhu wrote:
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
> I have no clue what does it mean. Is it only 0 or 1? Then it should be
> enum or even bool.


Yes, it only 0 or 1, and I will use bool type.

Byte mode is to access by byte, such as gpio3, the base address of the
gpio controller is offset by 3 bytes as the access address of gpio3.

The bit mode is the normal mode that like other platform gpio and it is
to access by bit.

> 
>> +
>> +  loongson,gpio-inten-offset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      This option indicate this GPIO interrupt enable register offset
>> +      address.
>> +
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
> 
> No, you cannot add them as required to every other device. First, there
> is no single need. Second, it breaks the ABI.


Okay, I will remove it in required paragraph.

> 
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
> 
> I still think that you just embed the programming model into properties,
> instead of using dedicated compatible for different blocks. It could be
> fine, although I would prefer to check it with your DTS

Okay, I got it,  and if I understand correctly, you seem to agree with
me adding attributes like this.

And, if using this method that programming model into dts properites,
then when adding a new platform's GPIO,  there is no longer a need to
modify the driver because gpio controller is compatible and different
platform can use a same compatible.

> 
> Where is your DTS?


Sorry, the dts containing gpio nodes are only available in the product
code and have not been sent to the community yet.

2k500, 2k2000, and 3a5000's gpio dts node have been listed in v2, which
gpio dts node will be added in upstream dts.


Thanks,
Yinbo.

