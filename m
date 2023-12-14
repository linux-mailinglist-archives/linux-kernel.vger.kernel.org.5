Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD109813335
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573510AbjLNOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573505AbjLNOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:35:15 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78675115;
        Thu, 14 Dec 2023 06:35:20 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 711003AF;
        Thu, 14 Dec 2023 15:35:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1702564518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+Xi2xa3RNrJtFpkg486v39REZonzsV1FXE9gDFjBxY=;
        b=g3Lza4epRiuQ2jTvpphPjZoq8XhgvlU0duoNfiNvaz+QSZo3DEjdaCOuI9dEzVsXPYvCmO
        Is77hlxOSz0X/ogZkX7fV3Wku80MP2Fb9ENujYzgDB/aFLmdYkpZ7AOvV7OrQvaQfinrCJ
        rxQK8Obe/A+poz8FWsFDpuJpOv1cqbsMZ0k9E1RN4OugyWI9az82iOxayHG/qw1P5nyIAf
        XEePHJTE+ZVA87rPf7iyA14xWrhdv+3WPv99sdwgwHTQZUM1Qjbgr9jMD6SfETRlhpeD/0
        d6UEVSDNVHGshTwP3ayoSFWk5ehad4szdiCePvyHwldcxWYxfOyC9fJzhRTUHA==
MIME-Version: 1.0
Date:   Thu, 14 Dec 2023 15:35:18 +0100
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andy@kernel.org>,
        =?UTF-8?Q?TY=5FChang=5B=E5=BC=B5?=
         =?UTF-8?Q?=E5=AD=90=E9=80=B8=5D?= <tychang@realtek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
In-Reply-To: <ZXsKAyIlY3y3tgUi@smile.fi.intel.com>
References: <20231207100723.15015-1-tychang@realtek.com>
 <20231207100723.15015-3-tychang@realtek.com>
 <ZXHMbZRXLXGa_tq8@smile.fi.intel.com>
 <989146448858478b975c66899b8f3fed@realtek.com>
 <ZXm0MIub8X2q_lnp@smile.fi.intel.com>
 <23574204547646779d02f0109c20b3ff@realtek.com>
 <ZXsKAyIlY3y3tgUi@smile.fi.intel.com>
Message-ID: <0f0b3b65a838aea6797ae78c47d6af49@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> >> >> This driver enables configuration of GPIO direction, GPIO values,
>> >> >> GPIO debounce settings and handles GPIO interrupts.
>> >> >
>> >> >Why gpio-regmap can't be used?
>> >>
>> >> I will try to use gpio-remap in the next version.
>> >
>> >If it appears that it makes code uglier / complicated, please add the note
>> >somewhere to answer the above question.
>> 
>> I've traced the gpio-regmap.c file. It appears that for the driver to 
>> register
>> gpio_irq_chip, it must create the irq_domain and add it into 
>> gpio_regmap_config.
>> Additionally, the driver needs to register the irq handler by itself.
>> However, this process can be managed by the gpiolib if the driver 
>> fills in the struct
>> gpio_irq_chip inside struct gpio_chip before invoking 
>> gpiochip_add_data.
> 
> Hmm... I thought this is solvable issue.
> Michael, is there a limitation in GPIO regmap that this driver can't be 
> converted?

gpio-regmap is designed that regmap-irq (drivers/base/regmap/irq.c) can 
be
used. So, if regmap-irq fit this driver, then it can be used together 
with
gpio-regmap.

 From a quick glance at the patch, it looks like the gpio portion might 
fit
gpio-regmap.

>> Moreover, apart from managing the registers for gpio direction and 
>> value, there
>> are several other registers that require access(interrupt enable, 
>> debounce...).
>> The GPIO IRQ status registers are located at different base addresses 
>> and are
>> not contiguous. It may need to create an additional regmap and assign 
>> the access
>> table to this regmap.
> 
> AFAIK this is not a problem as you can provide your own xlate function 
> that
> will take care about register mapping.

Just for the gpio part. IIRC regmap has it own translation (regmap 
fields).

>> With the above consideration, I tend to keep using the existing 
>> method.
> 
> I would like to hear from Michael if it's indeed a big obstacle.

So, regarding the irq portion, again, it must fit the regmap-irq. For 
the
additional requirement to set the debounce, you can add a .set_config to
gpio_regmap_config and supply your own set_config callback. See also 
[1].

-michael

[1] 
https://lore.kernel.org/linux-gpio/d4a6a640c373b6d939e147691efa596c@walle.cc/
