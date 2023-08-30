Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A86178DF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjH3TGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbjH3Lr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:47:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 957051B0;
        Wed, 30 Aug 2023 04:47:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEE552F4;
        Wed, 30 Aug 2023 04:48:02 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD9893F64C;
        Wed, 30 Aug 2023 04:47:20 -0700 (PDT)
Date:   Wed, 30 Aug 2023 12:47:18 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "oleksii_moisieiev@epam.com" <oleksii_moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        cristian.marussi@arm.com, Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC] scmi: pinctrl: support i.MX9
Message-ID: <ZO8sRknW-6vdKoDd@pluto>
References: <20230824070611.3335107-1-peng.fan@oss.nxp.com>
 <CACRpkdYU7MRXRV3Uw1w300sdxv=9XT=P1vFFarHfpSM6BT20Hg@mail.gmail.com>
 <DU0PR04MB9417B3CB9638F936DF19C523881DA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CACRpkdZKMsC1Wyi+nOf7idAWMTUe8w2XbtpWnbDKrCLD75ND1g@mail.gmail.com>
 <DU0PR04MB94178923DFC8E71287E560E888E3A@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB94178923DFC8E71287E560E888E3A@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 08:43:38AM +0000, Peng Fan wrote:
> > Subject: Re: [RFC] scmi: pinctrl: support i.MX9
> > 
> > On Thu, Aug 24, 2023 at 2:47 PM Peng Fan <peng.fan@nxp.com> wrote:
> > > Me:

Hi Peng,

> > 
> > >> it is merely making things more complex and also slower
> > > > bymaking the registers only accessible from this SCMI link.
> > >
> > > This is for safety reason, the pinctrl hardware must be handled by a
> > > system manager entity. So mmio direct access not allowed from Cortex-A
> > > side.
> > 
> > Yeah I understood as much. But I don't think that the firmware is really
> > filtering any of the access, it will just poke into any pinctrl register as
> > instructed anyway so what's the point. Just looks like a layer of indirection.
> 
> No, the firmware has a check on whether a pin is allowed to be configured
> by the agent that wanna to configure the pin. 
> 
> > But I'm not your system manager, so it's not my decision.
> > 
> > > The SCMI firmware is very straightforward, there is no group or
> > > function.
> > >
> > > It just accepts the format as this:
> > > MUX_TYPE, MUX VALUE, CONF_TYPE, CONF_VAL, DAISY_TYPE, DAISY ID,
> > > DAISY_CFG, DAISY_VALUE.
> > >
> > > Similar as linux MMIO format.
> > >
> > > Our i.MX95 platform will support two settings, one with SCMI firmware,
> > > one without SCMI. These two settings will share the same pinctrl
> > > header file.
> > >
> > > And to simplify the scmi firmware design(anyway I am not owner of the
> > > firmware), to make pinctrl header shared w/o scmi, we take the current
> > > in-upstream freescale imx binding format.
> > 
> > The SCMI people will have to state their position on this.
> > Like what they consider conformance and what extensions are allowed. This
> > is more a standardization question than an implementation question so it's
> > not really my turf.
> 
> The i.MX95 SCMI firmware uses OEM extension type. So I just follow
> what the firmware did and support it in linux. Anyway let's
> wait Sudeep's reply.
> 

So my unsderstanding on this matter as of now is that:

1. the current SCMI Pinctrl specification can support your usecase by using
   OEM Types and multiple pins/values CONFIG_GET/SET commands

2. the Kernel SCMI protocol layer (driver/firmware/arm_scmi/pinctrl.c)
   is equally fine and can support your usecase, AFTER Oleksii fixes it to
   align it to the latest v3.2-BETA2 specification changes.
   IOW, this means that, using the SCMI Pinctrl protocol operations
   exposed in scmi_protocol.h, from somewhere, you are able to properly
   configure multiple pins/values with your specific OEM types.

3. The SCMI Pinctrl driver (by Oleksii) built on top of the pinctrl protocol
   operations is instead NOT suitable for your usecase since it uses the Linux
   Generic Pinconf and IMX does not make use of it, and instead IMX has
   its own bindings and related parsing logic.

Am I right ?

If this is the case, I would NOT try to abuse the current SCMI Pinctrl
Generic driver (by Oleksii) by throwing into it a bunch of IMX specific DT
parsing, also because you'll end-up NOT using most of the generic SCMI
Pinctrl driver but just reusing a bit of the probe (customized with your
own DT maps parsing)

Instead, given that the spec[1.] and the protocol layer[2.] are fine for
your use case and you indeed have already a custom way to parse your DT
mappings, I would say that you could just write your own custom SCMI
driver ( ? pinctrl-imx-scmi), distinct and much more simple than the generic one,
that does its own IMX DT parsing and calls just the SCMI protocol operations
that it needs in the way that your platform expects: so basically another
Pinctrl SCMI driver that does not use the generic pinconf DT
configuration BUT DO USE the underlying SCMI Pinctrl protocol (via its
exposed protocol operations...)

Not sure what Sudeep thinks about supporting multiple SCMI driver for the
same protocol (we did it already for Sensors hwmon && iio), and if this
approach won't need some sort of mutual exclusion mechanism in Kconfig to
avoid loading both the generic and the custom IMX (even though they should
be able to co-exist from the SCMI kernel/fw stack pint of view, as long as
you dont mess-up the DTs and mixup generic pins with custom IMX pins...)

Instead, adding an IMX-custom extension to what it was supposed to be a generic
driver (as you propose) seems to me like a stretch of the generic Pinctrl driver
that is not really worth, since you'll end up polluting the generic driver with
some highly custom and specific IMX bits. while really NOT reusing so much of
the generic driver at all.

Thanks,
Cristian

