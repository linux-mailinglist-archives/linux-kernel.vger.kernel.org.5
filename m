Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DCA7D520F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbjJXNnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjJXNnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:43:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB7DD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:43:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9d132d92cso8561025ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698154983; x=1698759783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llE/A+xwdvnmuUTq+C1r2sdJnt3pwBP1QiuNoEB548A=;
        b=bD3PbT0hQ1dVD+iDsHeJ2mlcykXCE8UIGyAqM43nFIuBix2pW20Lm5G2HtF1ERhOXM
         ZMNyfx442D+cwbUGB4pHUFgN3m9uju1GeE7zYajeIFQ+UTvSivAe0B8f9eHFu35AcsK1
         sUXnLfK2oivsbqMkYvogMnddmBFdF/jUGyVldQPf/YYe/5ye6sjxjmFZEEI6+6IsZL1+
         eWOSov7frJ2Yt2EBqiuXFjQyvqrfAiO8uS6HcrSzUeU1lPeK+XtOApBcH6ayhKa8xnRE
         7NKI9yr1SDXibE66M8J+JutmS0VMRbVD0VmefjO0kFwy427AHlNAz7Z6SH3o715TgzI8
         prow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698154983; x=1698759783;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llE/A+xwdvnmuUTq+C1r2sdJnt3pwBP1QiuNoEB548A=;
        b=GzbdvclzC0N7ZjWGk5DdkaTNfL+ECukOsSmR6nPWASPWDi4UiXnWj9lTyEt9FhmEb7
         C38rdL8mqptrOVJbxBpyRy+iGK8L7AozYShZb2d+8CvksKxOgm4yp3/1VX2CE0/F/EYP
         Uh+t/U4PPsR4iWlycQg+yaKyQo0Rp0fsSGUmGltXgYWaIpNnDKlkm1tDrMQBEsrbcBYd
         HGh6IclMMNs0XAhSr+rZ9PKV1DpmRvew0WjcPyLa/D8Bv15N/vF4KfGaSXgAaoL/nv59
         sVgRzDsC96yNTez2JNrSBrQ9jKdSzrPJAiwmYqtNxfAW/92gQKbrxR6w/SJYI4kQEOb7
         p4+Q==
X-Gm-Message-State: AOJu0YzocTjxjjlQCxuqyGRzFdjziS+UaVwhIvLNIwwuWIImeUq/05cF
        2oqaREXKmHvH3Pny+7iYnjuawi3ZbY1un0GdFUuusw==
X-Google-Smtp-Source: AGHT+IGO3UGtt2ntifIx9N2oGOGvNFeTOoA1Q+nxYUjFjDT1CwynHW+luQG8rzi0DgBIyG+IUHTKdg==
X-Received: by 2002:a17:903:6c7:b0:1ca:85b4:b962 with SMTP id kj7-20020a17090306c700b001ca85b4b962mr11793079plb.4.1698154982724;
        Tue, 24 Oct 2023 06:43:02 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:7c15:610f:1205:f10c])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b001c71ec1866fsm7416507plx.258.2023.10.24.06.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:43:02 -0700 (PDT)
Date:   Tue, 24 Oct 2023 22:42:57 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
Message-ID: <ZTfJ4b7VdTkA0sxo@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
 <ZSTgTC4cFFpofYAk@octopus>
 <CACRpkdYD6pkccYoy90AfzV3KT7oYkBPD2_4ZW-AXzT1eUVpchA@mail.gmail.com>
 <ZS3yK/f12Mxw9rXe@octopus>
 <CACRpkdarDrVkPmyDawhZ+H94S4F=dtDSDVuKegi-eNfQNDY3rg@mail.gmail.com>
 <ZTduWx7CH1ifI5Uc@octopus>
 <CACRpkdba=echR=rZYKVbROfaOp4mzjTQ9RphHFyzqSNgE1jZqg@mail.gmail.com>
 <ZTemAK/jBtv9b5xP@octopus>
 <CACRpkdY-5uS9EeXfDFVOiRKiFmwwSn3jRVGhT-n4JMqesHEumw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY-5uS9EeXfDFVOiRKiFmwwSn3jRVGhT-n4JMqesHEumw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:12:51PM +0200, Linus Walleij wrote:
> On Tue, Oct 24, 2023 at 1:10???PM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> 
> > As far as I understand, there is only one way for SCMI gpio driver
> > to know which pins are actually GPIO pins; Calling PINCNTRL_CONFIG_GET
> > command with "Input-mode" or "Output-mode" configuration type
> > against *every* pin-controller's pins.
> > (Here I assume that the command would fail with INVALID_PARAMETERS or
> > NOT_SUPPORTED if configuring the given pin as a GPIO input or output
> > is not possible. But the specification seems to be a bit ambiguous.)
> 
> As I also wrote in the reply to Christian, I expect the SCMI firmware
> to consider GPIO a function on the pins, and either individual pins
> (groups with just one pin in it) or entire groups of pins can be switched
> to perform the "gpio function". ("gpio function" is akin to "i2c function"
> or "HDMI function" etc.)

First of all, there is no pre-defined naming convention either for
pins, groups or functions. SCMI firmware can give them any names.

Secondly, What you said in the above is already implemented in
my RFC patch. Please remember the example that I gave:

>     gpio-ranges = <&scmi_pinctrl 6 0 0>;
>     gpio-ranges-group-names = "pinmux_gpio";
> 
> means that SCMI *group*, "pinmux_gpio", are mapped to this driver's
> gpio range which starts with 5. If "pinmux_gpio" indicates SCMI *pin*
> range [20..24],
> 
>     baa-gpios = <&gpio0 7>;
> will refer to gpio pin#7 that is actually SCMI's 22 (=20 + (7-5)).

Given the fact there is no naming convention, we need to explicitly
specify an associated group name in "gpio-ranges-group-names" in any way.

What my driver doesn't care for now is the case where a group of GPIO pins
are multiplexed with other functions (UART, I2C or whatever else).
In this case, we need to configure "pinconf" setup prior to using those
pins as GPIO anyway. Simply, it is out of scope of my driver.
(We can still use existing generic GPIO interfaces to operate them once
set up, though.)

After all, I still believe we need "gpio-ranges" property in most of
all use cases (The only exception is, as I mentioned, to unconditionally
map all pinctrl's pins to GPIO (if possible) when SCMI firmware provides
only GPIO function for all pins. I think it is a simple and yet likely
use case.

Thanks,
-Takahiro Akashi


> 
> If the SCMI protocol considers GPIO usage to be something else
> than a function of a pin, that is going to be a problem. Then the SCMI
> protocol need some other way of determining that the pin is in
> GPIO mode, and perhaps something would need to be added to
> the protocol for that.
> 
> The reason is that in practice a lot of hardware has to decouple
> the pin from any internal function in order to use it as GPIO, and
> connect it to the GPIO block that can drive the line high and low.
> And we don't select that as a function, how is the firmware going
> to know that it needs to do this? Implicitly from the call requesting
> the line to be output perhaps. But if the firmware can be altered
> to do that, the firmware can just as well be altered to present
> GPIO as a proper function.
> 
> Using a function makes most sense, because the board firmware
> knows which pins are GPIO lines and what they are used for
> (such as a LED or camera flash) and at boot certainly put them
> into GPIO function and drive them high/low or set them as
> input (high impedance).
> 
> > It means that, if SCMI firmware has 100 pinctrl pins, the driver needs
> > to call the command 200 times in order to get the answer.
> 
> I think we should only need to check which function each pin
> has and those that are in the GPIO function we put into the ranges.
> 
> Yours,
> Linus Walleij
