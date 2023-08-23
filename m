Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E783785C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbjHWPiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbjHWPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:38:18 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A023710CC;
        Wed, 23 Aug 2023 08:38:15 -0700 (PDT)
Received: from p5dcc3441.dip0.t-ipconnect.de ([93.204.52.65] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qYpvt-002xI2-3t; Wed, 23 Aug 2023 17:38:09 +0200
Date:   Wed, 23 Aug 2023 17:38:07 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Rob Herring <robh@kernel.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: add TWL6032 32K clocks
Message-ID: <20230823173807.0b80a70a@aktux>
In-Reply-To: <20230821205745.GA2270173-robh@kernel.org>
References: <20230819134147.456060-1-andreas@kemnade.info>
        <20230819134147.456060-2-andreas@kemnade.info>
        <20230821205745.GA2270173-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 15:57:45 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sat, Aug 19, 2023 at 03:41:45PM +0200, Andreas Kemnade wrote:
> > To be able to be referenced from a future yaml-version of
> > mfd/twl-family.txt depending on toplevel compatible have a separate
> > file for the 6032  
> 
> Really, the parent needs to be done first...
> 
well, for some other subdevices, a yaml is already in the tree
and Krzysztof recently added a R-By to another one.

But if the clocks should not have a node, then it is obvious.
What would be the route to conversion here: Is a conversion
of mfd/twl-family.txt without specifying subnodes ok for the first step,
maybe with additionalProperties: yes?


> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  .../bindings/clock/ti,twl6032-clk.yaml        | 38
> > +++++++++++++++++++ 1 file changed, 38 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
> > b/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml new
> > file mode 100644 index 0000000000000..aebd9f8d761a2 --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/ti,twl6032-clk.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Clocks of the TWL6032 PMIC
> > +
> > +maintainers:
> > +  - Andreas Kemnade <andreas@kemnade.info>
> > +
> > +description:
> > +  The TWL6032 has some 32Khz clock outputs which can be
> > controlled.  
> 
> outputs? Seems like only 1 with no clock cells to specify which one.
> 
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,twl6032-clk32kaudio
> > +      - ti,twl6032-clk32kg  
> 
> Or is it 1 output per compatible? I hope not.
> 
yes, it is. It was inspired by the clk-palmas driver:
$ grep palmas.*32 arch/arm/boot/dts/ti/omap/omap5-*
arch/arm/boot/dts/ti/omap/omap5-board-common.dtsi:
clk32kgaudio: palmas_clk32k@1 {
arch/arm/boot/dts/ti/omap/omap5-board-common.dtsi:
	compatible = "ti,palmas-clk32kgaudio";

Well, we have the CLK_IGNORE_UNUSED, so if we use #clock-cells = 1,
an unused clock will not be touched by the kernel, right?

> > +
> > +  '#clock-cells':
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    twl {
> > +        clk32kaudio {
> > +            compatible = "ti,twl6032-clk32kaudio";
> > +            #clock-cells = <0>;
> > +        };  
> 
> You don't need a child node to be a clock provider. Just add 
> #clock-cells to the parent node.
> 
hmm, we have child nodes there for every subdevice in that family,
even if I doubt it is totally technically required.
So why should the clk device be an exception? 

Regards,
Andreas
