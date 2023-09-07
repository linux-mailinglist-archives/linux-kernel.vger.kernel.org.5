Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F634797B9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242868AbjIGSWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245195AbjIGSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:21:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 970CC91;
        Thu,  7 Sep 2023 11:21:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABB771595;
        Thu,  7 Sep 2023 03:06:41 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D0A83F64C;
        Thu,  7 Sep 2023 03:06:01 -0700 (PDT)
Date:   Thu, 7 Sep 2023 11:05:52 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "oleksii_moisieiev@epam.com" <oleksii_moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
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
Message-ID: <ZPmggEmba6-c8N7d@pluto>
References: <20230824070611.3335107-1-peng.fan@oss.nxp.com>
 <CACRpkdYU7MRXRV3Uw1w300sdxv=9XT=P1vFFarHfpSM6BT20Hg@mail.gmail.com>
 <DU0PR04MB9417B3CB9638F936DF19C523881DA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CACRpkdZKMsC1Wyi+nOf7idAWMTUe8w2XbtpWnbDKrCLD75ND1g@mail.gmail.com>
 <DU0PR04MB94178923DFC8E71287E560E888E3A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZO8sRknW-6vdKoDd@pluto>
 <DU0PR04MB941726AF86EEB0BBB55B9A2A88E6A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZO9GLG5tQynYyAvR@pluto>
 <ZPgRkgkFj7rICE0h@octopus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPgRkgkFj7rICE0h@octopus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 02:43:46PM +0900, AKASHI Takahiro wrote:
> On Wed, Aug 30, 2023 at 02:37:48PM +0100, Cristian Marussi wrote:
> > On Wed, Aug 30, 2023 at 12:48:37PM +0000, Peng Fan wrote:
> > > Hi Cristian,
> > > 
> > 
> > Hi,
> > 

Hi,

> > > > Subject: Re: [RFC] scmi: pinctrl: support i.MX9
> > > > 
> > > > On Fri, Aug 25, 2023 at 08:43:38AM +0000, Peng Fan wrote:
> > > > > > Subject: Re: [RFC] scmi: pinctrl: support i.MX9
> > > > > >
> > > > > > On Thu, Aug 24, 2023 at 2:47 PM Peng Fan <peng.fan@nxp.com> wrote:
> > > > > > > Me:
> > > > 
> > > > Hi Peng,
> > > > 
> > > > > >
> > > > > > >> it is merely making things more complex and also slower
> > > > > > > > bymaking the registers only accessible from this SCMI link.
> > > > > > >
> > > > > > > This is for safety reason, the pinctrl hardware must be handled by
> > > > > > > a system manager entity. So mmio direct access not allowed from
> > > > > > > Cortex-A side.
> > > > > >
> > > > > > Yeah I understood as much. But I don't think that the firmware is
> > > > > > really filtering any of the access, it will just poke into any
> > > > > > pinctrl register as instructed anyway so what's the point. Just looks like a
> > > > layer of indirection.
> > > > >
> > > > > No, the firmware has a check on whether a pin is allowed to be
> > > > > configured by the agent that wanna to configure the pin.
> > > > >
> > > > > > But I'm not your system manager, so it's not my decision.
> > > > > >
> > > > > > > The SCMI firmware is very straightforward, there is no group or
> > > > > > > function.
> > > > > > >
> > > > > > > It just accepts the format as this:
> > > > > > > MUX_TYPE, MUX VALUE, CONF_TYPE, CONF_VAL, DAISY_TYPE, DAISY
> > > > ID,
> > > > > > > DAISY_CFG, DAISY_VALUE.
> > > > > > >
> > > > > > > Similar as linux MMIO format.
> > > > > > >
> > > > > > > Our i.MX95 platform will support two settings, one with SCMI
> > > > > > > firmware, one without SCMI. These two settings will share the same
> > > > > > > pinctrl header file.
> > > > > > >
> > > > > > > And to simplify the scmi firmware design(anyway I am not owner of
> > > > > > > the firmware), to make pinctrl header shared w/o scmi, we take the
> > > > > > > current in-upstream freescale imx binding format.
> > > > > >
> > > > > > The SCMI people will have to state their position on this.
> > > > > > Like what they consider conformance and what extensions are allowed.
> > > > > > This is more a standardization question than an implementation
> > > > > > question so it's not really my turf.
> > > > >
> > > > > The i.MX95 SCMI firmware uses OEM extension type. So I just follow
> > > > > what the firmware did and support it in linux. Anyway let's wait
> > > > > Sudeep's reply.
> > > > >
> > > > 
> > > > So my unsderstanding on this matter as of now is that:
> > > > 
> > > > 1. the current SCMI Pinctrl specification can support your usecase by using
> > > >    OEM Types and multiple pins/values CONFIG_GET/SET commands
> > > 
> > > Yes, based on the Oleksii patchset with my local multiple configs support.
> > > 
> > 
> > Yes, I know, I pointed out on his series that the protocol has still to
> > be fixed to be aligned with the latest BETA2 spec (we changed the spec
> > on the fly while he was already posting indeed..)
> > 
> > > > 
> > > > 2. the Kernel SCMI protocol layer (driver/firmware/arm_scmi/pinctrl.c)
> > > >    is equally fine and can support your usecase, AFTER Oleksii fixes it to
> > > >    align it to the latest v3.2-BETA2 specification changes.
> > > >    IOW, this means that, using the SCMI Pinctrl protocol operations
> > > >    exposed in scmi_protocol.h, from somewhere, you are able to properly
> > > >    configure multiple pins/values with your specific OEM types.
> > > 
> > > Yes.
> > 
> > Good.
> > 
> > > 
> > > > 
> > > > 3. The SCMI Pinctrl driver (by Oleksii) built on top of the pinctrl protocol
> > > >    operations is instead NOT suitable for your usecase since it uses the Linux
> > > >    Generic Pinconf and IMX does not make use of it, and instead IMX has
> > > >    its own bindings and related parsing logic.
> > > 
> > > Yes.
> > > 
> > > > 
> > > > Am I right ?
> > > 
> > > You are right.
> > > 
> > > > 
> > > > If this is the case, I would NOT try to abuse the current SCMI Pinctrl Generic
> > > > driver (by Oleksii) by throwing into it a bunch of IMX specific DT parsing,
> > > > also because you'll end-up NOT using most of the generic SCMI Pinctrl driver
> > > > but just reusing a bit of the probe (customized with your own DT maps
> > > > parsing)
> > > 
> > > Only DT map to parse the dts and map to config array. Others are same,
> > > so need to export some symbols for pinctrl-scmi-imx.c driver if build imx
> > > scmi driver.
> > >
> > 
> > Yes, but you are basically using some exported symbol to parse the DT in
> > your way and then you do not use anything of the various
> > functions/groups stuff...you just leverage some of the probing stuff and
> > then issue you OEM Type configs....I mean most of the picntrl-scmi
> > driver would be unused anyway in this scenario.
> > 
> > > > 
> > > > Instead, given that the spec[1.] and the protocol layer[2.] are fine for your
> > > > use case and you indeed have already a custom way to parse your DT
> > > > mappings, I would say that you could just write your own custom SCMI
> > > > driver ( ? pinctrl-imx-scmi), distinct and much more simple than the generic
> > > > one, that does its own IMX DT parsing and calls just the SCMI protocol
> > > > operations that it needs in the way that your platform expects: so basically
> > > > another Pinctrl SCMI driver that does not use the generic pinconf DT
> > > > configuration BUT DO USE the underlying SCMI Pinctrl protocol (via its
> > > > exposed protocol operations...)
> > > 
> > > I am ok with this approach, but I need use the other ID, saying 0x99, not 0x19,
> > > because 0x19 will bind with the pinctrl-scmi.c driver, I could not reuse
> > > this ID for i.MX pinctrl-scmi-imx driver. Otherwise there will be issue if both
> > > driver are built in kernel image.
> > > 
> > 
> > Ok here I lost you.
> > 
> > The protocol ID 0x19 is bound to the protocol layer and identifies the
> > standard Pinctrl protocol: usually you use a 0x99 to define and describe
> > you own specific NEW vendor protocol, BUT here you are saying you are fine to
> > use std Pinctrl spec AND the protocol operations as exposed in pinctrl.c, so
> > I dont see why you should use a new vendor protocol_id to basically
> > expose the same operations. (and I also dont see how you can do that
> > without hacks in the current codebase)
> > 
> > You CAN have multiple SCMI drivers using the same protocol at the same
> > time (even more than one protocol at the same time), even though we try
> > to avoid it if there are no good reason to have more than one driver, there
> > is nothing in the spec or in the current SCMI platform or agent stacks that
> > inhibits such scenario (and I use iot heavily for my offline testing
> > indeed.)
> > 
> > Look at:
> > 
> >  - drivers/hwmon/scmi-hwmon 
> >  - drivers/iio/common/scmi_sensors/scmi_iio.c
> > 
> > and you'll see that these 2 drivers uses the same SENSOR protocol, just for
> > different sensor types so they do not interfere one with each other.
> 
> Then, how are those two devices identified in a device tree?

At SCMI probe time the SCMI core stack creates one device for each
'protocol_id/name' as provided by the registered SCMI drivers in
their respective scmi_device_id/id_tableS, as long as the requested
protocol is active in the DT (protocol@XX defined) and the 'name'
is not duplicated; each of these devices, sharing the same SCMI
protocol, are created sharing also the same DT node protocol@XX.

Their respective SCMI drivers are subsequently separately matched on
protocol_id/name and then probed as usual: it is up to the drivers not
to step on each other feet by competing for the same SCMI resources...
...like issuing comflicting request for the same reosurce domain
on the same protocol.

I suppose, though, a lot depends on how the respective drivers interact
with their subsystems, like IIO SCMI does not really need any info
from DT, and the hwmon uses just the phandle to pick the sensor_domain_id
to associate, as an example, to thermal sensors.

> That is the point in Peng's case and why he wants to have a dedicated
> protocol id (I don't agree to this, though.)
> If we follow Cristian's idea, we may want to have two dt nodes, say
> pinctrl-scmi-generic and pinctrl-scmi-imx, as phandles for other device
> nodes to refer to pins, respectively.
> I think there is currently no mechanism (or binding?) to allow this
> except adding a protocol id.
>

Beside the uglyness of having 2 different DT bindings schemas for 2
different drivers coexisting in the same parent protocol node, it is
still not clear to me why this cant be done technically without the need
of a new dummy 0x99 protocol_node, given that each driver can use its
own parsing logic in its probe, which is what Peng is doing in
dt_node_to_map indeed ...even though, maybe, the result would be so
ugly and/or not accepatble from bindings point of view that we will
not want to do it at the end anyway....I mean maybe it is just the
attempt itself to combine the Generic Pinctrl approach with the highly
specific IMX approach that inevitably leads to these clashes...

...I maybe missing something, though, so I'll made some experiments on
my side about this before I'll keep on blabbing :P

Thanks,
Cristian
