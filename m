Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939B17EE85D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjKPUeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPUeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:34:06 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C21A7;
        Thu, 16 Nov 2023 12:34:01 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r3j3m-0005kq-K3; Thu, 16 Nov 2023 21:33:58 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] docs: dt-bindings: add DTS Coding Style document
Date:   Thu, 16 Nov 2023 21:33:57 +0100
Message-ID: <7592981.EvYhyI6sBW@phil>
In-Reply-To: <d8363bac-df41-416a-9043-f6212ad61e13@linaro.org>
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
 <3266223.44csPzL39Z@phil> <d8363bac-df41-416a-9043-f6212ad61e13@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. November 2023, 21:23:20 CET schrieb Krzysztof Kozlowski:
> On 16/11/2023 21:03, Heiko Stuebner wrote:
> 
> >>> I guess the only thing I do have questions about is the part
> >>>
> >>>> +4. All properties with values
> >>>> +5. Boolean properties
> >>>
> >>> Is there a rationale for it? Because with it things like regulator-*
> >>> properties then end up in two different blocks.
> >>
> >> Good point. It is only a matter of style that this:
> >>
> >> foo {
> >> 	compatible = "foo";
> >> 	reg = <0x1>;
> >> 	clocks = <&clk>;
> >> 	wakeup-source;
> >> 	key-autorepeat;
> >> }
> >>
> >> looks better to me than:
> >>
> >>
> >> foo {
> >> 	compatible = "foo";
> >> 	reg = <0x1>;
> >> 	key-autorepeat;
> >> 	wakeup-source;
> >> 	clocks = <&clk>;
> >> }
> >>
> >> But you have good point that similar properties should be usually
> >> grouped together.
> >>
> >> About which regulator properties are you thinking now? You mean the
> >> supplies or the provider?
> > 
> > I was thinking about the provider. There are 
> > 	regulator-min-microvolt = <>;
> > and friends, but also
> > 	regulator-boot-on;
> 
> These are in regulator provider nodes and above guideline would keep
> logical order:
> 
> 	regulator-name = "vdd_kfc";
> 	regulator-min-microvolt = <800000>;
> 	regulator-max-microvolt = <1500000>;
> 	regulator-always-on;
> 	regulator-boot-on;
> 
> 	regulator-state-mem {
> 		regulator-off-in-suspend;
> 	};
> 
> What exactly would be here misordered?

going with the vcc5v0_host regulator of the rk3588-quartzpro64 and

+1. compatible
+2. reg
+3. ranges
+4. All properties with values
+5. Boolean properties
+6. status (if applicable)
+7. Child nodes

we'd end up with

        vcc5v0_host: vcc5v0-host-regulator {
/* 1. */        compatible = "regulator-fixed";
/* 4. */        gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
                pinctrl-names = "default";
                pinctrl-0 = <&vcc5v0_host_en>;
                regulator-min-microvolt = <5000000>;
                regulator-max-microvolt = <5000000>;
                regulator-name = "vcc5v0_host";
                vin-supply = <&vcc5v0_usb>;
/* 5. */        enable-active-high;
                regulator-always-on;
                regulator-boot-on;
        };      

which I find somewhat counter-intuitive ;-) .


Heiko


