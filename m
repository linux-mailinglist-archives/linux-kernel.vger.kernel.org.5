Return-Path: <linux-kernel+bounces-74329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B153785D2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03081C2287A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD903CF52;
	Wed, 21 Feb 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RAIbUh6v"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5A3B793;
	Wed, 21 Feb 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505504; cv=none; b=Ul2kZSw0edmbRtFpGVNwaXgTGD0td83a+wIbXSW1KM3ZAAM9Er1Q/Y/qKwT2TisnpBjbC5+eYMuBnZW+VcfX0WYsZGASDGAJRg9K9tqvdXEqpbfF0yZtUNh9XKbgxq2kb0h5cnO69AjmCJ2PMRq2SruLiGQQdT4PW4hOCg00dCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505504; c=relaxed/simple;
	bh=U2xKP1+FG6hj5j28nPiVq6aHy746t6BeNF5UKoKkyV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtggKT19aFmdAkU2EjX7avjsNWpdLy9Mw2xIQzAAy0ZJpErLjMx/3+Z6SunwVibIWFRDVSb2gyJPwDWUg9MYophUavRlr3d82zTuodpdGnpV2PlM1axjVVcNHk9zfkrqR7ugDI3eo889s0wliyWcbZy+9ZJwfVB+HxSukqqzGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RAIbUh6v; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27C72FF80B;
	Wed, 21 Feb 2024 08:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708505499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewzG+Or2vfRP7XY3UgnYiV6tCm6wiDunEr+A5LjqZBQ=;
	b=RAIbUh6vKDDmDDi8DhhbecTdObckBkSaotTDLNFMSD82+GpZQdPnFTyNUG+9KoWw2eerM/
	/KzfjFYFy8tJWWuB07pnVGxNJ+s7e+5WemC2q958COberQ25Lbhhl908SPRWIMHpI2GRJ8
	IqHX/pUtpRBLIVh54jA5WgWfBa4BGHCnhA2bBv42Mx+85G98nHILJQqlxSvSxzlndZVKNX
	cIAErcPer/aV9iFka3EthukZq8c+/WRF7QmAT3LvE7fCSl08mXL3I4nn/lUEjjEFBjZqDh
	Wg9rAYmFU+VleC4c0cRVHniAv+vguQ2qrYH1Djvive0dYkFjWQWZ1nnkcX9z8g==
Date: Wed, 21 Feb 2024 09:51:37 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Wolfram Sang
 <wsa@kernel.org>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Fix links to supplier
 when created from phandles
Message-ID: <20240221095137.616d2aaa@bootlin.com>
In-Reply-To: <CAGETcx_xkVJn1NvCmztAv13N-7ZGqZ+KfkFg-Xn__skEBiYtHw@mail.gmail.com>
References: <20240220111044.133776-1-herve.codina@bootlin.com>
	<20240220111044.133776-3-herve.codina@bootlin.com>
	<CAGETcx_xkVJn1NvCmztAv13N-7ZGqZ+KfkFg-Xn__skEBiYtHw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Saravana,

On Tue, 20 Feb 2024 18:40:40 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Tue, Feb 20, 2024 at 3:10 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Since commit 1a50d9403fb9 ("treewide: Fix probing of devices in DT
> > overlays"), when using device-tree overlays, the FWNODE_FLAG_NOT_DEVICE
> > is set on each overlay nodes. This flag is cleared when a struct device
> > is actually created for the DT node.
> > Also, when a device is created, the device DT node is parsed for known
> > phandle and devlinks consumer/supplier links are created between the
> > device (consumer) and the devices referenced by phandles (suppliers).
> > As these supplier device can have a struct device not already created,
> > the FWNODE_FLAG_NOT_DEVICE can be set for suppliers and leads the
> > devlink supplier point to the device's parent instead of the device
> > itself.
> >
> > Avoid this situation clearing the supplier FWNODE_FLAG_NOT_DEVICE just
> > before the devlink creation if a device is supposed to be created and
> > handled later in the process.
> >
> > Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/of/property.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 641a40cf5cf3..ff5cac477dbe 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1097,6 +1097,7 @@ static void of_link_to_phandle(struct device_node *con_np,
> >                               struct device_node *sup_np)
> >  {
> >         struct device_node *tmp_np = of_node_get(sup_np);
> > +       struct fwnode_handle *sup_fwnode;
> >
> >         /* Check that sup_np and its ancestors are available. */
> >         while (tmp_np) {
> > @@ -1113,7 +1114,20 @@ static void of_link_to_phandle(struct device_node *con_np,
> >                 tmp_np = of_get_next_parent(tmp_np);
> >         }
> >
> > -       fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
> > +       /*
> > +        * In case of overlays, the fwnode are added with FWNODE_FLAG_NOT_DEVICE
> > +        * flag set. A node can have a phandle that references an other node
> > +        * added by the overlay.
> > +        * Clear the supplier's FWNODE_FLAG_NOT_DEVICE so that fw_devlink links
> > +        * to this supplier instead of linking to its parent.
> > +        */
> > +       sup_fwnode = of_fwnode_handle(sup_np);
> > +       if (sup_fwnode->flags & FWNODE_FLAG_NOT_DEVICE) {
> > +               if (of_property_present(sup_np, "compatible") &&
> > +                   of_device_is_available(sup_np))
> > +                       sup_fwnode->flags &= ~FWNODE_FLAG_NOT_DEVICE;
> > +       }
> > +       fwnode_link_add(of_fwnode_handle(con_np), sup_fwnode);  
> 
> Nack.
> 
> of_link_to_phandle() doesn't care about any of the fwnode flags. It
> just creates links between the consumer and supplier nodes. Don't add
> more intelligence into it please. Also, "compatible" doesn't really
> guarantee device creation and you can have devices created out of
> nodes with no compatible property. I finally managed to get away from
> looking for the "compatible" property. So, let's not add back a
> dependency on that property please.
> 
> Can you please give a real example where you are hitting this? I have
> some thoughts on solutions, but I want to understand the issue fully
> before I make suggestions.
> 

I detected the issue with this overlay:
--- 8< ---
&{/}
{
	reg_dock_sys_3v3: regulator-dock-sys-3v3 {
		compatible = "regulator-fixed";
		regulator-name = "DOCK_SYS_3V3";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		gpios = <&tca6424_dock_1 5 GPIO_ACTIVE_HIGH>; // DOCK_SYS3V3_EN
		enable-active-high;
		regulator-always-on;
	};
};

&i2c5 {
	tca6424_dock_1: gpio@22 {
		compatible = "ti,tca6424";
		reg = <0x22>;
		gpio-controller;
		#gpio-cells = <2>;
		interrupt-parent = <&gpio4>;
		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
		interrupt-controller;
		#interrupt-cells = <2>;
		vcc-supply = <&reg_dock_ctrl_3v3>;
	};
};
--- 8< ---

The regulator uses a gpio.
The supplier for the regulator was not the gpio chip (gpio@22) but the i2c bus.

I first tried to clear always the flag in of_link_to_phandle() without any check
to a "compatible" string and in that case, I broke pinctrl.

All devices were waiting for the pinctrl they used (child of pinctrl device
node) even if the pinctrl driver was bound to the device.

For pinctrl, the DT structure looks like the following:
--- 8< ---
{
	...
	pinctrl@1234 {
		reg = <1234>;
		compatible = "vendor,chip";

		pinctrl_some_device: grp {
			fsl,pins = < ... >;
		};
	};

	some_device@4567 {
		compablile = "foo,bar";
		reg = <4567>;
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_some_device>;
		...
	};
};
--- 8< ---
		
In that case the link related to pinctrl for some_device needs to be to the
'pinctrl_some_device' node parent (i.e. the pinctrl@1234 node).


Best regards,
Hervé

