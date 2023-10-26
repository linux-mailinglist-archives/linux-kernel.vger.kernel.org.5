Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A654C7D801A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjJZJ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjJZJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:56:24 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14731A2;
        Thu, 26 Oct 2023 02:56:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1D7D1C0002;
        Thu, 26 Oct 2023 09:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698314177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLpdKu5C0fYSPbxSc3YHWPnQqBl6qyVkCmCpGHs4+QQ=;
        b=J3BWVAytJd2WnybC3NmZ82R6PhfkKM824u1c139GxFwgy5rv2QRuDb/bNnD8rUMGuaiPWD
        K4uVIt4Yig3m0x6Vzf3PxnHTCVTt/wKE3EjlOHDUG6ubUuu4FkPthqm3cwaIkwk8dBRF4y
        +sMGkDaaSqGbPv7kYzYWZUriecU4EAbk6AhaKL2jIpxpqHUjJrtumhMGjuxwyaWRPqWtv+
        AU9nHATD+O5l5Nclrk8Sdnp7TGPdJWsyePOUKNw/4eiNSPufg0mS4zXkrOGwPz22h00tnh
        xDhzHiQl147R2RPdblcN0LmgRE723QGOJseRRErVkHTugpgC6JkgXApXtLYP6g==
Date:   Thu, 26 Oct 2023 11:56:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add hiz-output
 property
Message-ID: <202310260956166bdcb845@mail.local>
References: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
 <20231024-topic-pcf85363_hiz_output-v1-2-50908aff0e52@wolfvision.net>
 <20231025222327c0b5d460@mail.local>
 <2f17c031-30f6-4242-b2a1-1628402b3091@wolfvision.net>
 <1c4a6185-fe09-45d1-900a-10abf48e3fc9@wolfvision.net>
 <20231026005008b8255799@mail.local>
 <8fec6c89-548b-43b5-8361-869663a58573@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fec6c89-548b-43b5-8361-869663a58573@wolfvision.net>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 11:41:47+0200, Javier Carrasco wrote:
> 
> On 26.10.23 02:50, Alexandre Belloni wrote:
> > On 26/10/2023 01:23:21+0200, Javier Carrasco wrote:
> >>>>> +  hiz-output:
> >>>>> +    description:
> >>>>> +      Use enabled if the output should stay in high-impedance. This
> >>>>> +      mode will mask the output as an interrupt source.
> >>>>> +      Use sleep if the otuput should be only active in sleep mode.
> >>>>> +      This mode is compatible with any other output configuration.
> >>>>> +      The disabled value acts as if the property was not defined.
> >>>>> +    enum:
> >>>>> +      - enabled
> >>>>> +      - sleep
> >>>>> +      - disabled
> >>>>> +    default: disabled
> >>>>> +
> >>>>
> >>>> If instead of using a custom property, you consider this as what it
> >>>> actually is: pinmuxing, then everything else comes for free. With
> >>>> pinctrl, you can define different states for runtime and sleep and they
> >>>> will get applied automatically instead of open coding in the driver.
> >>
> >> I am not sure if your solution would cover all my needs:
> >>
> >> 1.- With pinctrl I can model the SoC pins, right? That would not stop
> >> the RTC output though, so the 32 kHz signal would be generated anyways
> >> even though the SoC would ignore it. That is one of the things I want to
> >> avoid.
> >>
> > 
> > No, you would model the INTA pin.
> I am sorry for insisting on this topic, but if I get you right, I would
> be modeling an interrupt pin (INTA) to keep it from generating a clock
> signal when the RTC itself offers a high-impedance mode i.e. avoiding to
> use the RTC feature.
> 
> Is that not a misuse of the INTA pin in the first place? If there was no
> other option, that would be an easy fix, but why would we not implement
> the hi-Z mode when it is available? If I see a pinctrl-* modeling an
> interrupt pin, it is not obvious that I am doing that to stop the clock
> signal and I would have to clarify it explicitly, especially if I am not
> interested in the interrupt.
> 
> I would rather implement and document the hi-Z mode the RTC offers
> instead of using another mode like INTA which actually can trigger
> interrupts. If the implementation must be different is of course another
> topic.

There is a pin named INTA, it can mux 4 different functions:

 - clock output
 - battery mode indication
 - interrupt
 - HiZ

with pinmuxing, you can select which function you want for the pin. I'm
not sure what is misused there.

Can you explain what is your actual use case? I'm starting to understand
that what you want is simply disable clock out because you are not using
the interrupt.

If we assume we are never going to use battery mode, then we could
simply used the CCF for this like the other RTC drivers.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
