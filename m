Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF80F78CCCB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjH2TSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbjH2TSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96951A8;
        Tue, 29 Aug 2023 12:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BC7463857;
        Tue, 29 Aug 2023 19:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0D2C433C8;
        Tue, 29 Aug 2023 19:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693336687;
        bh=w3R5HwmaOTLQ6o9Upqa19a5YfiYuqgNDGW3hqQIlJUg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mDm+0gNGtAf83UVWfpfsACkjGQL47mdAohm4MFyFTEBSfiSK3vLhvkmGXXzGXPzhv
         5au7kmX++DSxlB/GZZNR1lgeabnXErkOYKK70u1XS29hL5kkHdY3bABV1PKSJN7r+y
         LgNHEMcce29E9pVR2tKljjKtrsyL9OwAJvKP2QyaI3wIVUCRowBQ0sdGE6B8OcIE8O
         E5sTZTgkvjS5jLJAevVAhpsXeV12B20w9Ai4w4WLewRJ0kR05kI3RNspo/OZHw35rS
         gmT+R9xuy3dXv5evrVnqekDG9MSJlCcvFLl2+bG2svNoFj/uw44evyDQy1qqZAvIg8
         hi2m7WZCeJQbg==
Message-ID: <c70c08b4-be67-14da-be25-5473ffd0ca7d@kernel.org>
Date:   Wed, 30 Aug 2023 04:18:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
 <af247603-6a8d-7c05-4342-c6f615a7f508@kernel.org>
 <2df3dc449c894e50b126a1b6941eb4d7@realtek.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <2df3dc449c894e50b126a1b6941eb4d7@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanley,

On 23. 8. 29. 20:15, Stanley Chang[昌育德] wrote:
> Hi Chanwoo,
> 
>>> +static int rtd129x_switch_type_c_plug_config(struct type_c_data *type_c,
>>> +                                          int dr_mode, int cc)
>>> +{
>>> +     void __iomem *reg = type_c->reg_base + USB_TYPEC_CTRL_CC1_0;
>>> +     int val_cc;
>>> +
>>> +#define TYPE_C_EN_SWITCH BIT(29)
>>> +#define TYPE_C_TXRX_SEL (BIT(28) | BIT(27))
>>> +#define TYPE_C_SWITCH_MASK (TYPE_C_EN_SWITCH | TYPE_C_TXRX_SEL)
>>> +#define TYPE_C_ENABLE_CC1 TYPE_C_EN_SWITCH
>>> +#define TYPE_C_ENABLE_CC2 (TYPE_C_EN_SWITCH | TYPE_C_TXRX_SEL)
>>> +#define TYPE_C_DISABLE_CC ~TYPE_C_SWITCH_MASK
>>> +
>>> +     val_cc = readl(reg);
>>
>> I'd like you to use regmap interface to access the register
>> by using regmap_read, regmap_write. You can create the regmap instance
>> via devm_regmap_init_mmio() on probe instead of using 'type_c->reg_base'
>> at the multipe point.
>>
>> For example,
>>         struct regmap_config rtk_regmap_config = {
>>                 .reg_bits = 32,
>>                 .val_bits = 32,
>>         };
>>
>>         void __iomem *base;
>>
>>         base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>>         if (IS_ERR(base))
>>                 return PTR_ERR(base);
>>
>>         regmap = devm_regmap_init_mmio(dev, base,
>> &rtk_regmap_config);
>>
>>         ---
>>
>>         And then just call regmap_read without any calculation between
>>         base address and specific register.
>>
>>         regmap_read(regmap, USB_TYPEC_CTRL_CC1_0)
>>
> 
> I studied mmio's regmap.
> 
> It only changed one encoding method. And simplifies the calculation between the base address and the specific register.

The regmap provides the consistent interface to access register
regardless of mmio/i2c/spi and so on. It is the advantage of regmap.

And regmap provides the like register dump via debugfs,
is able to specify the kind of register like writable, readable, volatile type.
It is possible to specify the more detailed register information in device driver
in order to improve the readability. It allows you to express more detail of this device
than just working.


> If the register is 32-bit aligned, other operations look the same as readl/writel.
> I think regmap is more simplified if the read registers are not 32-bit aligned, e.g. nvmem read/write.

I'm sorry. I don't understand of what is accurate meaning.
Could you please explain your opinion more detailed with example of this patch?

> So it would be more intuitive for me to keep writel/readl here
> 
>>
>>> +     val_cc &= ~TYPE_C_SWITCH_MASK;
>>> +
>>> +     if (cc == DISABLE_CC) {
>>> +             val_cc &= TYPE_C_DISABLE_CC;
>>> +     } else if (cc == ENABLE_CC1) {
>>> +             val_cc |= TYPE_C_ENABLE_CC1;
>>> +     } else if (cc == ENABLE_CC2) {
>>> +             val_cc |= TYPE_C_ENABLE_CC2;
>>> +     } else {
>>> +             dev_err(type_c->dev, "%s: Error cc setting cc=0x%x\n",
>> __func__, cc);
>>> +             return -EINVAL;
>>> +     }
>>> +     writel(val_cc, reg);
>>> +
> 
> Thanks,
> Stanley

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

