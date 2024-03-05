Return-Path: <linux-kernel+bounces-91782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F092F871683
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D417B21895
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9937A7E583;
	Tue,  5 Mar 2024 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="3xnEyCNc"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974F7D41B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622895; cv=none; b=a/thNkS5oRLI1/ijSuBILN9cvUGEdWlmPBC0WilePTRj+O/Psbc7kPYk/wQnialLXXDJAVJFHFIaYVNVpPkIDrxVm+yQKOToQRGLeiLXq+OcQwj7+r4n6kfoljIQ3VZUXUwhlc8UdoJQhLUrptL4hTipjGDuB9cFs5rDh18kwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622895; c=relaxed/simple;
	bh=y6zaOZvJ4cIVJ2qepjnDrcV6r6n/r5jEVFp4o5JpDlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rx6wkrrZOlepq23Gs0yXHbH6d7tve+BceXh4g729RiiR84fRPXBhJo4BKctWp2as2glr/iLpccjjJyuMw0uDQtzBJLsTUrpLiBz+jm/hlHvmMFhwDJu1JrvMg9w3G2i7OgX2Mc7FogPXZI1LbZN/pW7s6aAgpjwsh1/2Lx4YZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3xnEyCNc; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42ee0c326e8so192571cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 23:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709622893; x=1710227693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ6lNE1/SlOo2Yjm5/u+OE6lkumtZM5XSJ/KqzGtJ3Q=;
        b=3xnEyCNcWJdP9DBGCyKMyXRkWAta2A7CR4YbXMJtqFYtXj4AbHlzTF5Tn8dlgDjT95
         uVAnjebeVBOiWclGVltKar/0R+bkxlChJt6hUxvLDnZ7EKdS/3UIBSKYMjbzjl05ZB28
         FwlWiJgLinGOtx3NQPaeIH26RDfZKVLQMAoSUf52Og0PwL/Ztrh7V7lm9hZaly4lADVF
         rBUdIXvUu7bcGCLu+uL0pun0GspLW0iIjyBEU2vWGZNbQKf8iyc5DZT680JFPYHPIxV+
         LJODNuGLqJndvM2ChUMy1WqQ3W2DGvRCZZqkKPR12iJzJpPfRxwuFniVlaKtrHcrD2Dt
         ssfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709622893; x=1710227693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ6lNE1/SlOo2Yjm5/u+OE6lkumtZM5XSJ/KqzGtJ3Q=;
        b=bXq37xgNmNVGESTXc77B1FIlJbSjcpjghjToy72eFRusqKWsmlqLqdfBBYFgiXbomE
         8BsEF4WTVG0L+H/EvIn+w1dtQOunMW9XW2A37X6l6zo1jyuXhyiVROFiKYXEoneXqpbv
         gw8hxuuwDedDZNUpwOg8cGC3z/kp00zK3Nj72lRViRD8sFOjq0dt8+/fc8wRRF7Lm8R1
         X4b2GT5Gi2zS1phaPAJ3BYkx60ItwYXc230j8FRIozz64ZUPNOBw1tu4TYBMRKu/REjj
         wUXlyJeWoDT0uVeCU0p4Mv0roGcpWWCXxg4lwQn0AMaUczTD6nBbrjBWnDiv20BkJ9NT
         ddVw==
X-Forwarded-Encrypted: i=1; AJvYcCUhnRZuKU4kR0VSy3YTgpLulFDawUdFVonGKzwRknYaZF9gHWPPX01LDhSkhFeF523DSQtZNTR3Bs9m9j5pQeVMVqgI5DaTvJHwzzhW
X-Gm-Message-State: AOJu0YxPN+XncXDQW8kZj4h0QjvLVik7uzCLgifxV8NboJLqna4nJ+q8
	aErqgwVRHQeZy5UZGb333m0KymNX38ZlGHx1sr9BdruILFn/tJcUx0cjn9WmspaQvqg0gJfEpuL
	wokK+AeIOgn2/41CQLvAoOUS2Zf3dBpGJ0BN9
X-Google-Smtp-Source: AGHT+IEFOU5j+ArF55fdfXdcl8hFaVcAq2CRoTSvDHrwXdk+TBzUqq588pPOFFn7BNfYvwZzsxzAIGsV46EFXvApyc0=
X-Received: by 2002:ac8:5c85:0:b0:42e:fa0e:2592 with SMTP id
 r5-20020ac85c85000000b0042efa0e2592mr103522qta.12.1709622892609; Mon, 04 Mar
 2024 23:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111044.133776-1-herve.codina@bootlin.com>
 <20240220111044.133776-3-herve.codina@bootlin.com> <CAGETcx_xkVJn1NvCmztAv13N-7ZGqZ+KfkFg-Xn__skEBiYtHw@mail.gmail.com>
 <20240221095137.616d2aaa@bootlin.com>
In-Reply-To: <20240221095137.616d2aaa@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 4 Mar 2024 23:14:13 -0800
Message-ID: <CAGETcx9eFuqwJTSrGz9Or8nfHCN3=kNO5KpXwdUxQ4Z7FxHZug@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Fix links to supplier when
 created from phandles
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 12:51=E2=80=AFAM Herve Codina <herve.codina@bootlin=
com> wrote:
>
> Hi Saravana,
>
> On Tue, 20 Feb 2024 18:40:40 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>
> > On Tue, Feb 20, 2024 at 3:10=E2=80=AFAM Herve Codina <herve.codina@boot=
lin.com> wrote:
> > >
> > > Since commit 1a50d9403fb9 ("treewide: Fix probing of devices in DT
> > > overlays"), when using device-tree overlays, the FWNODE_FLAG_NOT_DEVI=
CE
> > > is set on each overlay nodes. This flag is cleared when a struct devi=
ce
> > > is actually created for the DT node.
> > > Also, when a device is created, the device DT node is parsed for know=
n
> > > phandle and devlinks consumer/supplier links are created between the
> > > device (consumer) and the devices referenced by phandles (suppliers).
> > > As these supplier device can have a struct device not already created=
,
> > > the FWNODE_FLAG_NOT_DEVICE can be set for suppliers and leads the
> > > devlink supplier point to the device's parent instead of the device
> > > itself.
> > >
> > > Avoid this situation clearing the supplier FWNODE_FLAG_NOT_DEVICE jus=
t
> > > before the devlink creation if a device is supposed to be created and
> > > handled later in the process.
> > >
> > > Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays=
")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > ---
> > >  drivers/of/property.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 641a40cf5cf3..ff5cac477dbe 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1097,6 +1097,7 @@ static void of_link_to_phandle(struct device_no=
de *con_np,
> > >                               struct device_node *sup_np)
> > >  {
> > >         struct device_node *tmp_np =3D of_node_get(sup_np);
> > > +       struct fwnode_handle *sup_fwnode;
> > >
> > >         /* Check that sup_np and its ancestors are available. */
> > >         while (tmp_np) {
> > > @@ -1113,7 +1114,20 @@ static void of_link_to_phandle(struct device_n=
ode *con_np,
> > >                 tmp_np =3D of_get_next_parent(tmp_np);
> > >         }
> > >
> > > -       fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(su=
p_np));
> > > +       /*
> > > +        * In case of overlays, the fwnode are added with FWNODE_FLAG=
_NOT_DEVICE
> > > +        * flag set. A node can have a phandle that references an oth=
er node
> > > +        * added by the overlay.
> > > +        * Clear the supplier's FWNODE_FLAG_NOT_DEVICE so that fw_dev=
link links
> > > +        * to this supplier instead of linking to its parent.
> > > +        */
> > > +       sup_fwnode =3D of_fwnode_handle(sup_np);
> > > +       if (sup_fwnode->flags & FWNODE_FLAG_NOT_DEVICE) {
> > > +               if (of_property_present(sup_np, "compatible") &&
> > > +                   of_device_is_available(sup_np))
> > > +                       sup_fwnode->flags &=3D ~FWNODE_FLAG_NOT_DEVIC=
E;
> > > +       }
> > > +       fwnode_link_add(of_fwnode_handle(con_np), sup_fwnode);
> >
> > Nack.
> >
> > of_link_to_phandle() doesn't care about any of the fwnode flags. It
> > just creates links between the consumer and supplier nodes. Don't add
> > more intelligence into it please. Also, "compatible" doesn't really
> > guarantee device creation and you can have devices created out of
> > nodes with no compatible property. I finally managed to get away from
> > looking for the "compatible" property. So, let's not add back a
> > dependency on that property please.
> >
> > Can you please give a real example where you are hitting this? I have
> > some thoughts on solutions, but I want to understand the issue fully
> > before I make suggestions.
> >
>
> I detected the issue with this overlay:
> --- 8< ---
> &{/}
> {
>         reg_dock_sys_3v3: regulator-dock-sys-3v3 {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "DOCK_SYS_3V3";
>                 regulator-min-microvolt =3D <3300000>;
>                 regulator-max-microvolt =3D <3300000>;
>                 gpios =3D <&tca6424_dock_1 5 GPIO_ACTIVE_HIGH>; // DOCK_S=
YS3V3_EN
>                 enable-active-high;
>                 regulator-always-on;
>         };
> };
>
> &i2c5 {
>         tca6424_dock_1: gpio@22 {
>                 compatible =3D "ti,tca6424";
>                 reg =3D <0x22>;
>                 gpio-controller;
>                 #gpio-cells =3D <2>;
>                 interrupt-parent =3D <&gpio4>;
>                 interrupts =3D <1 IRQ_TYPE_EDGE_FALLING>;
>                 interrupt-controller;
>                 #interrupt-cells =3D <2>;
>                 vcc-supply =3D <&reg_dock_ctrl_3v3>;
>         };
> };
> --- 8< ---
>
> The regulator uses a gpio.
> The supplier for the regulator was not the gpio chip (gpio@22) but the i2=
c bus.

Thanks for the example. Let me think about this a bit on how we could
fix this and get back to you.

Please do ping me if I don't get back in a week or two.

-Saravana

>
> I first tried to clear always the flag in of_link_to_phandle() without an=
y check
> to a "compatible" string and in that case, I broke pinctrl.
>
> All devices were waiting for the pinctrl they used (child of pinctrl devi=
ce
> node) even if the pinctrl driver was bound to the device.
>
> For pinctrl, the DT structure looks like the following:
> --- 8< ---
> {
>         ...
>         pinctrl@1234 {
>                 reg =3D <1234>;
>                 compatible =3D "vendor,chip";
>
>                 pinctrl_some_device: grp {
>                         fsl,pins =3D < ... >;
>                 };
>         };
>
>         some_device@4567 {
>                 compablile =3D "foo,bar";
>                 reg =3D <4567>;
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&pinctrl_some_device>;
>                 ...
>         };
> };
> --- 8< ---
>
> In that case the link related to pinctrl for some_device needs to be to t=
he
> 'pinctrl_some_device' node parent (i.e. the pinctrl@1234 node).
>
>
> Best regards,
> Herv=C3=A9

