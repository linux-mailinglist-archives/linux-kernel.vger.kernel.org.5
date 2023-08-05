Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5C7712F4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 00:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjHEWvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 18:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEWvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 18:51:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B600F1732;
        Sat,  5 Aug 2023 15:51:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 396A11FB;
        Sat,  5 Aug 2023 15:52:12 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8296A3F6C4;
        Sat,  5 Aug 2023 15:51:27 -0700 (PDT)
Date:   Sat, 5 Aug 2023 23:50:30 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Martin Botka <martin.botka@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: make interrupt
 optional for more chips
Message-ID: <20230805235030.35bed33c@slackpad.lan>
In-Reply-To: <TY3P286MB26117478116BEF63AE1548FF980EA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <20230802141829.522595-1-andre.przywara@arm.com>
        <TY3P286MB26117478116BEF63AE1548FF980EA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2023 23:43:35 +0800
Shengyu Qu <wiagn233@outlook.com> wrote:

Hi Shengyu,

> No, you can't only add the binding stuff. The PEK driver would crash when
> there's no IRQ config in dts.

Well, that's strictly speaking a problem of the existing Linux driver
then, which cannot cope with this new updated binding yet. But the
binding needs to be updated first in any case, so this patch needs
to come first.

But yeah, indeed this is missing the extension of the "IRQ > 0"  check
from the 15060 MFD code, I will send a patch shortly to extend this to
the AXP305 and AXP313a.

Thanks for the heads up!

Cheers,
Andre

> Best regards,
> 
> Shengyu
> 
> > All X-Powers PMICs described by this binding have an IRQ pin, and so
> > far (almost) all boards connected this to some NMI pin or GPIO on the SoC
> > they are connected to.
> > However we start to see boards that omit this connection, and technically
> > the IRQ pin is not essential to the basic PMIC operation.
> > The existing Linux driver allows skipping an IRQ pin setup for some
> > chips already, so update the binding to also make the DT property
> > optional for these chips, so that we can actually have DTs describing
> > boards with the PMIC interrupt not wired up.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> > Hi,
> >
> > arguably the IRQ functionality is optional for many more PMICs,
> > especially if a board doesn't use GPIOs or a power key.
> > So I wonder if the interrupts property should become optional for all?
> > After all it's more a board designer's decision to wire up the IRQ pin
> > or not, and nothing that's really related to a particular PMIC.
> >
> > Cheers,
> > Andre
> >
> >   Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > index 9ad55746133b5..06f1779835a1e 100644
> > --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > @@ -67,7 +67,10 @@ allOf:
> >           properties:
> >             compatible:
> >               contains:
> > -              const: x-powers,axp305
> > +              enum:
> > +                - x-powers,axp15060
> > +                - x-powers,axp305
> > +                - x-powers,axp313a
> >   
> >       then:
> >         required:  

