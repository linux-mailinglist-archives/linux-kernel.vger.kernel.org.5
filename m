Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C10876A94E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjHAGj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjHAGj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:39:56 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89F5F98;
        Mon, 31 Jul 2023 23:39:53 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Cxruu3qMhky+YNAA--.30050S3;
        Tue, 01 Aug 2023 14:39:51 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxniO1qMhkHphDAA--.4219S3;
        Tue, 01 Aug 2023 14:39:50 +0800 (CST)
Subject: Re: [PATCH v2 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Conor Dooley <conor@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230731091059.17323-1-zhuyinbo@loongson.cn>
 <20230731091059.17323-2-zhuyinbo@loongson.cn>
 <20230731-setback-such-61815ee3ef51@spud>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <041bf8a6-8d91-c2ce-6752-aa7255f946c7@loongson.cn>
Date:   Tue, 1 Aug 2023 14:39:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230731-setback-such-61815ee3ef51@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxniO1qMhkHphDAA--.4219S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/31 下午11:55, Conor Dooley 写道:
> On Mon, Jul 31, 2023 at 05:10:58PM +0800, Yinbo Zhu wrote:
>> Add parsing GPIO configure, input, output, interrupt register offset
>> address and GPIO control mode support.
> 
> This reeks of insufficient use of SoC specific compatibles. Do GPIO
> controllers on the same SoC have different register offsets?


Yes,

> Where are the users for this?


For example, ls2k500 contains multiple GPIO chips with different
(configure, input, output, interrupt) offset addresses, but all others
are the same.

> 
> Cheers,
> Conor.
> 
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   .../bindings/gpio/loongson,ls-gpio.yaml       | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> index fb86e8ce6349..cad67f8bfe6e 100644
>> --- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> @@ -29,6 +29,33 @@ properties:
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
>> @@ -39,6 +66,11 @@ required:
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
>> @@ -54,6 +86,11 @@ examples:
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

