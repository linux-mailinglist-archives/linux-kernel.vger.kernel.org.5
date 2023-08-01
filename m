Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5883576BA18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjHAQzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjHAQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:54:55 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349272684
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:54:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A0151BF203;
        Tue,  1 Aug 2023 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690908891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3jHMGbJP3QoNz+rczliCDsMkczh5HGRrxCqzcgnveo=;
        b=L0LEpiaWM546go+iQHmp9rh1i2Yg5K61mkwNPerpxzqAlx4f3khZ4bJBL6iFmQZEjCi+xU
        YsEUV/68G6Vp9+N9YN4AeLybuk44fWbn9SI0V+8G1y56B7QP/QfgAih+WGwJj8+nVirCQ5
        OK1qaFJF2FKFGawoxH1xcJmiUSc4z7B1EmqoOk/DSmKga840HiaS9stCveYL1tbT08E/xr
        hTPxaNpmChcxpLwAmwz29vfS6KemfblRl3lOJ+fVRrhKZLu7pq5BJh08BIkdZUgPjJoj6+
        GVzPYq4Ha4IxkoWi5HWU2hAvi4Yl5B8kdp9HTMfufH/4rg9UCmV+fzpaAqBQ6Q==
Date:   Tue, 1 Aug 2023 18:54:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 3/3] nvmem: core: Expose cells through sysfs
Message-ID: <20230801185449.5088c8d4@xps-13>
In-Reply-To: <2023080125-renovate-uptake-86f0@gregkh>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
        <20230717075147.43326-4-miquel.raynal@bootlin.com>
        <2023071717-channel-supernova-4cc9@gregkh>
        <20230717183323.49a55ad0@xps-13>
        <2023071724-twiddling-morale-157e@gregkh>
        <20230731164642.49fea651@xps-13>
        <2023080125-renovate-uptake-86f0@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

gregkh@linuxfoundation.org wrote on Tue, 1 Aug 2023 11:56:40 +0200:

> On Mon, Jul 31, 2023 at 05:33:13PM +0200, Miquel Raynal wrote:
> > Hi Greg,
> >=20
> > gregkh@linuxfoundation.org wrote on Mon, 17 Jul 2023 18:59:52 +0200:
> >  =20
> > > On Mon, Jul 17, 2023 at 06:33:23PM +0200, Miquel Raynal wrote: =20
> > > > Hi Greg,
> > > >=20
> > > > gregkh@linuxfoundation.org wrote on Mon, 17 Jul 2023 16:32:09 +0200:
> > > >    =20
> > > > > On Mon, Jul 17, 2023 at 09:51:47AM +0200, Miquel Raynal wrote:   =
=20
> > > > > > The binary content of nvmem devices is available to the user so=
 in the
> > > > > > easiest cases, finding the content of a cell is rather easy as =
it is
> > > > > > just a matter of looking at a known and fixed offset. However, =
nvmem
> > > > > > layouts have been recently introduced to cope with more advanced
> > > > > > situations, where the offset and size of the cells is not known=
 in
> > > > > > advance or is dynamic. When using layouts, more advanced parser=
s are
> > > > > > used by the kernel in order to give direct access to the conten=
t of each
> > > > > > cell, regardless of its position/size in the underlying
> > > > > > device. Unfortunately, these information are not accessible by =
users,
> > > > > > unless by fully re-implementing the parser logic in userland.
> > > > > >=20
> > > > > > Let's expose the cells and their content through sysfs to avoid=
 these
> > > > > > situations. Of course the relevant NVMEM sysfs Kconfig option m=
ust be
> > > > > > enabled for this support to be available.
> > > > > >=20
> > > > > > Not all nvmem devices expose cells. Indeed, the .bin_attrs attr=
ibute
> > > > > > group member will be filled at runtime only when relevant and w=
ill
> > > > > > remain empty otherwise. In this case, as the cells attribute gr=
oup will
> > > > > > be empty, it will not lead to any additional folder/file creati=
on.
> > > > > >=20
> > > > > > Exposed cells are read-only. There is, in practice, everything =
in the
> > > > > > core to support a write path, but as I don't see any need for t=
hat, I
> > > > > > prefer to keep the interface simple (and probably safer). The i=
nterface
> > > > > > is documented as being in the "testing" state which means we ca=
n later
> > > > > > add a write attribute if though relevant.
> > > > > >=20
> > > > > > There is one limitation though: if a layout is built as a modul=
e but is
> > > > > > not properly installed in the system and loaded manually with i=
nsmod
> > > > > > while the nvmem device driver was built-in, the cells won't app=
ear in
> > > > > > sysfs. But if done like that, the cells won't be usable by the =
built-in
> > > > > > kernel drivers anyway.     =20
> > > > >=20
> > > > > Wait, what?  That should not be an issue here, if so, then this c=
hange
> > > > > is not correct and should be fixed as this is NOT an issue for sy=
sfs
> > > > > (otherwise the whole tree wouldn't work.)
> > > > >=20
> > > > > Please fix up your dependancies if this is somehow not working pr=
operly.   =20
> > > >=20
> > > > I'm not sure I fully get your point.
> > > >=20
> > > > There is no way we can describe any dependency between a storage de=
vice
> > > > driver and an nvmem layout. NVMEM is a pure software abstraction, t=
he
> > > > layout that will be chosen depends on the device tree, but if the
> > > > layout has not been installed, there is no existing mechanism in
> > > > the kernel to prevent it from being loaded (how do you know it's
> > > > not on purpose?).   =20
> > >=20
> > > Once a layout has been loaded, the sysfs files should show up, right?
> > > Otherwise what does a "layout" do?  (hint, I have no idea, it's an odd
> > > term to me...) =20
> >=20
> > Sorry for the latency in responding to these questions, I'll try to
> > clarify the situation.
> >=20
> > We have:
> > - device drivers (like NAND flashes, SPI-NOR flashes or EEPROMs) which
> >   typically probe and register their devices into the nvmem
> >   layer to expose their content through NVMEM.
> > - each registration in NVMEM leads to the creation of the relevant
> >   NVMEM cells which can then be used by other device drivers
> >   (typically: a network controller retrieving a MAC address from an
> >   EEPROM through the generic NVMEM abstraction). =20
>=20
>=20
> So is a "cell" here a device in the device model?  Or something else?

It is not a device in the device model, but I am wondering if it should
not be one actually. I discussed with Rafal about another issue in the
current design (dependence over a layout driver which might defer
forever a storage device probe) which might be solved if the core was
handling these layouts differently.

> > We recently covered a slightly new case: the NVMEM cells can be in
> > random places in the storage devices so we need a "dynamic" way to
> > discover them: this is the purpose of the NVMEM layouts. We know cell X
> > is in the device, we just don't know where it is exactly at compile
> > time, the layout driver will discover it dynamically for us at runtime.=
 =20
>=20
> So you then create the needed device when it is found?

We don't create devices, but we match the layouts with the NVMEM
devices thanks to the of_ logic.

> > While the "static cells" parser is built-in the NVMEM subsystem, you
> > explicitly asked to have the layouts modularized. This means
> > registering a storage device in nvmem while no layout driver has been
> > inserted yet is now a scenario. We cannot describe any dependency
> > between a storage device and a layout driver. We cannot defer the probe
> > either because device drivers which don't get access to their NVMEM
> > cell are responsible of choosing what to do (most of the time, the idea
> > is to fallback to a default value to avoid failing the probe for no
> > reason).
> >=20
> > So to answer your original question:
> >  =20
> > > Once a layout has been loaded, the sysfs files should show up, right?=
 =20
> >=20
> > No. The layouts are kind of "libraries" that the NVMEM subsystem uses
> > to try exposing cells *when* a new device is registered in NVMEM (not
> > later). The registration of an NVMEM layout does not trigger any new
> > parsing, because that is not how the NVMEM subsystem was designed. =20
>=20
> So they are a type of "class" right?  Why not just use class devices
> then?
>=20
> > I must emphasize that if the layout driver is installed in
> > /lib/modules/ there is no problem, it will be loaded with
> > usermodehelper. But if it is not, we can very well have the layout
> > driver inserted after, and this case, while in practice possible, is
> > irrelevant from a driver standpoint. It does not make any sense to have
> > these cells created "after" because they are mostly used during probes.
> > An easy workaround would be to unregister/register again the underlying
> > storage device driver. =20
>=20
> We really do not support any situation where a module is NOT in the
> proper place when device discovery happens.

Great, I didn't know. Then there is no issue.

>  So this shouldn't be an
> issue, yet you all mention it?  So how is it happening?

Just transparency, I'm giving all details I can.

I'll try to come with something slightly different than what we have
with the current approach.

Thanks,
Miqu=C3=A8l
