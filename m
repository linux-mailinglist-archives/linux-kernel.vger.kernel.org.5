Return-Path: <linux-kernel+bounces-64706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE618541C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3D4B22082
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1D6B64A;
	Wed, 14 Feb 2024 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKVl96KF"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC58F59
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707880763; cv=none; b=W1TG643kty9FQB41TyXuF4dNvetRWqOXJx3FzTsbOR5HCBfKdDZBxclBDwALdysAKtkJr4Vi+lnsX/ftYsfELGZBfF7rNpdHZDnNRqmGOv/AlIYpj/10VoDsupoewv++SrA5G1GsNxlKufPEIgOfjs+TXYug1u2zhzC7WeCNkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707880763; c=relaxed/simple;
	bh=69Rxxi2EKAhMQyUucC5cwSxnuGaoDRibaHawy8tkJls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlEss1S4k1tWX1zprPVQXveD5Qg4QAtsIW2QkdMPwlTolXGl773xvpgoLlMr5Br0/cs0jYyETwGHXXCdEX8Z6HOpmlgD8Gm5hPYrQmfWZUIeeXWW6ImroUkWhmObGVzBPzP2SvlvfcwE0QtM996KPa7dZqhUoy7lw60ObZgbgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKVl96KF; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a99dc9085so260841cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707880761; x=1708485561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57bVfLp5qWcmTWfkRj5+xYHg+ux1DaNl30cWWz8YFtI=;
        b=pKVl96KFc4a4a3srQl7ql3qwRORZwVdd8a+zMya9nL6gHIVoMAfll5/hKtkiBPnMYe
         vxRDcoalJN0NtfohTDWqg8zK5xd5L3sZI6RcSXbivE9HOJGamiyoLUeVe3GuaZUw5sYQ
         Yt3rrPd+UTJcKa+5wDRuXfZEXW4J9szQ4gIxLqh6uaJSnCugPIYCLjhCRkY8XgG1Y11/
         f3fLZTY0IEt9X5v+1vu1BbpuuWn3Pavb/CLj/C4jLK2TblLsUeDWONbN+7cPumMUxtAn
         G1fz/71yvNRYXThqT9tAVegQFJkJJoM8Q55ghn5wdCSFzOT12/dWn7E81lF0GxTOUQLZ
         0e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707880761; x=1708485561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57bVfLp5qWcmTWfkRj5+xYHg+ux1DaNl30cWWz8YFtI=;
        b=dpIF9l2WQlUwdYe0y1rnxHCa/t9eumxywG4l4htu04obiG1Y5sR0rSLNsyG6EAS0j4
         i4OpopMzaJCYlaCJlyhXaWm2B/iul1wUocw/nAm/VoF6dLPCaDWz9wCmlNfaIBjWssKj
         DYO6hC3p/Sah2g8vn1BaUPsn4ahcSGgCCHfJZEZxErykWC96yCHtiyDPvFfa2UNtlItY
         k449ypKWsKWsb/Uctg2t6UjY+F0n0RB36iPM9TQXU2gzmvKdfWDL75RFc1MoZrtrtGRi
         bKtMGazWBl0QZts6Ub4VwNADH2t8tPQWLeP5jlZqYAcKVa9dKXfqindzio5sGq3Z2gjv
         FmZA==
X-Forwarded-Encrypted: i=1; AJvYcCVqc7XL7XaT0fl31eEIZ4Bt6b9dJJS3snzPFaptmVDPqNs1fw/ImwhmKU/tHbC75UzDut/Z1k1i+uCt8tfVTLX6OxTm1IwLPXdUH74R
X-Gm-Message-State: AOJu0Yz710T2AzDyOzY68c11Z9eOeqWL0xDHKsmOLWJXWOytLhZrGtGK
	02GXiXPGmUST5pbISvckcQz7kOdg7wmph3dXZJLcIFKbM/9QsFZJobSDsC0OWis1aEsn0F1B47V
	x50BM3hHqSuiPb9hyVpcCPDxmnzGp0diYItgf
X-Google-Smtp-Source: AGHT+IHj3we2hhKYiF4yaGsT774ZtxKPXust7boogLjJxzLlcpesmXv91EXUg+DHUIJLk2J1CAa84d5e0vUqK7OlvJo=
X-Received: by 2002:a05:622a:85:b0:42d:a974:5b65 with SMTP id
 o5-20020a05622a008500b0042da9745b65mr152539qtw.17.1707880760686; Tue, 13 Feb
 2024 19:19:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123014517.5787-1-mcpratt@pm.me> <20240123014517.5787-3-mcpratt@pm.me>
 <CAGETcx8S6B09T==dSp38-vX+rYjRyTaRwVqF0c2Nh-KxwDFAtw@mail.gmail.com>
In-Reply-To: <CAGETcx8S6B09T==dSp38-vX+rYjRyTaRwVqF0c2Nh-KxwDFAtw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 13 Feb 2024 19:18:43 -0800
Message-ID: <CAGETcx9pVa=SyymOmkEtvZHuCs93QxjOADhK=JRpy32YDTje+Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] driver core: fw_devlink: Link to supplier ancestor
 if no device
To: Michael Pratt <mcpratt@pm.me>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mtd@lists.infradead.org, Abel Vesa <abel.vesa@linaro.org>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Maksim Kiselev <bigunclemax@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Colin Foster <colin.foster@in-advantage.com>, 
	Daniel Scally <djrscally@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fabio Estevam <festevam@gmail.com>, Maxim Kochetkov <fido_max@inbox.ru>, 
	Frank Rowand <frowand.list@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	heikki.krogerus@linux.intel.com, Sascha Hauer <kernel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, 
	Luca Weiss <luca.weiss@fairphone.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Martin Kepplinger <martin.kepplinger@puri.sm>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Ansuel Smith <ansuelsmth@gmail.com>, Richard Weinberger <richard@nod.at>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Doug Anderson <dianders@chromium.org>, 
	Jean-Philippe Brucker <jpb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 11:25=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Mon, Jan 22, 2024 at 5:46=E2=80=AFPM Michael Pratt <mcpratt@pm.me> wro=
te:
> >
> > Driver core currently supports linking to the next parent fwnode,
> > but is not yet handling cases where that parent
> > is also a firmware child node not representing a real device,

Can you tell me why you say this? Because as far as I can tell, I did
take into account climbing all the way up to find the actual struct
device that encompasses a fwnode and then create a device link to that
struct device.

> > which can lead to an indefinite deferred probe in some cases.
> > In this case, the fwnode that should actually be linked to
> > is multiple ancestors up which presents a challenge where
> > it is unknown how many ancestors up the node that
> > represents the real probing device is.

The goal is to find the device. Not "the probing device". That device
IS the one providing the functionality of the fwnode. If you never use
that device, don't create it? If you never probe the device, then use
a class instead of a bus?

> > This makes the usage of
> > fwnode_get_next_parent_dev() insufficient because the real device's
> > fwnode may or may not be an ancestor of the next parent fwnode as well.

It is doing what it's supposed to do. Finding the parent device. Not
the next probing parent device. This becomes even more relevant when
we start talking about suspend/resume. Too much to explain about
suspend/resume and it's not relevant to your case. So I'll leave that
as an exercise to the reader.

> > Introduce flag FWNODE_FLAG_PARENT_IS_DEV
> > in order to mark child firmware nodes of a device
> > as having a parent device that can probe.
> >
> > Allow fwnode link creation to the original supplier fwnode's ancestors
> > when the original supplier fwnode and any fwnodes in between are flagge=
d
> > as FWNODE_FLAG_NOT_DEVICE and/or FWNODE_FLAG_PARENT_IS_DEV
> > with a new function __fwnode_link_add_parents() which then creates
> > the fwnode link to a real device that provides the supplier's function.
> >
> > This depends on other functions to label a supplier fwnode
> > as not a real device, which must be done before the fwnode links
> > are created, and if after that, relevant links to the supplier
> > would have to be deleted and have links recreated, otherwise,
> > the fwnode link would be dropped before the device link is attempted
> > or a fwnode link would not be able to become a device link at all,
> > because they were created before these fwnode flags can have any effect=
.
> >
> > It also depends on the supplier device to actually probe first
> > in order to have the fwnode flags in place to know for certain
> > which fwnodes are non-probing child nodes
> > of the fwnode for the supplier device.
> >
> > The use case of function __fw_devlink_pickup_dangling_consumers()
> > is designed so that the parameters are always a supplier fwnode
> > and one of it's parent fwnodes, so it is safer to assume and more speci=
fic
> > that the flag PARENT_IS_DEV should be added there, rather than
> > declaring the original supplier fwnode as NOT_DEVICE at that point.
> > Because this function is called when the real supplier device probes
> > and recursively calls itself for all child nodes of the device's fwnode=
,
> > set the new flag here in order to let it propagate down
> > to all descendant nodes, thereby providing the info needed later
> > in order to link to the proper fwnode representing the supplier device.
> >
> > If a fwnode is flagged as FWNODE_FLAG_NOT_DEVICE
> > by the time a device link is to be made with it,
> > but not flagged as FWNODE_FLAG_PARENT_IS_DEV,
> > the link is dropped, otherwise the device link
> > is still made with the original supplier fwnode.
> > Theoretically, we can also handle linking to an ancestor
> > of the supplier fwnode when forming device links, but there
> > are still cases where the necessary fwnode flags are still missing
> > because the real supplier device did not probe yet.

It's still not clear why you need FWNODE_FLAG_PARENT_IS_DEV, but
considering patch 1 is a definite no-go, I'll stop here.

-Saravana

> >
> > Signed-off-by: Michael Pratt <mcpratt@pm.me>
>
> NACK for a bunch of reasons.
>
> 1. This logic should not be in fwnode_link_add(). That's supposed to
> do the exact linking that the firmware meant. This logic should be
> where the fwnode links are converted to device links or deferred
> probing decision is done.
>
> 2. If we handle one parent above correctly, it should be easy to
> handle multiple parents above too. So why not fix it where we handle
> multiple parents above?
>
> Btw, I'm happy to fix this or help you fix this once I understand the
> issue. Just wanted to give a quick NACK to avoid people spending
> cycles on this patch in its current state.
>
> -Saravana
>
>
> > ---
> >  drivers/base/core.c    | 49 ++++++++++++++++++++++++++++++++++++------
> >  include/linux/fwnode.h |  4 ++++
> >  2 files changed, 47 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index c05a5f6b0641..7f2652cf5edc 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -92,13 +92,45 @@ static int __fwnode_link_add(struct fwnode_handle *=
con,
> >         return 0;
> >  }
> >
> > +static int __fwnode_link_add_parents(struct fwnode_handle *con,
> > +                                    struct fwnode_handle *sup,
> > +                                    u8 flags, bool loop)
> > +{
> > +       int ret =3D -EINVAL;
> > +       struct fwnode_handle *parent;
> > +
> > +       fwnode_for_each_parent_node(sup, parent) {
> > +               /* Ignore the root node */
> > +               if (fwnode_count_parents(parent) &&
> > +                   fwnode_device_is_available(parent) &&
> > +                 !(parent->flags & FWNODE_FLAG_NOT_DEVICE) &&
> > +                 !(parent->flags & FWNODE_FLAG_PARENT_IS_DEV)) {
> > +                       ret =3D __fwnode_link_add(con, parent, flags);
> > +               }
> > +
> > +               if (!loop && !ret) {
> > +                       fwnode_handle_put(parent);
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *s=
up)
> >  {
> >         int ret;
> >
> >         mutex_lock(&fwnode_link_lock);
> > -       ret =3D __fwnode_link_add(con, sup, 0);
> > +
> > +       if ((sup->flags & FWNODE_FLAG_NOT_DEVICE) &&
> > +           (sup->flags & FWNODE_FLAG_PARENT_IS_DEV))
> > +               ret =3D __fwnode_link_add_parents(con, sup, 0, false);
> > +       else
> > +               ret =3D __fwnode_link_add(con, sup, 0);
> > +
> >         mutex_unlock(&fwnode_link_lock);
> > +
> >         return ret;
> >  }
> >
> > @@ -218,7 +250,8 @@ static void __fwnode_links_move_consumers(struct fw=
node_handle *from,
> >   * MANAGED device links to this device, so leave @fwnode and its desce=
ndant's
> >   * fwnode links alone.
> >   *
> > - * Otherwise, move its consumers to the new supplier @new_sup.
> > + * Otherwise, flag descendants of @fwnode as having a parent fwnode fo=
r a device
> > + * that has probed and move bad fwnode consumer links from @fwnode to =
@new_sup.
> >   */
> >  static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handl=
e *fwnode,
> >                                                    struct fwnode_handle=
 *new_sup)
> > @@ -228,8 +261,11 @@ static void __fw_devlink_pickup_dangling_consumers=
(struct fwnode_handle *fwnode,
> >         if (fwnode->dev && fwnode->dev->driver)
> >                 return;
> >
> > -       fwnode->flags |=3D FWNODE_FLAG_NOT_DEVICE;
> > -       __fwnode_links_move_consumers(fwnode, new_sup);
> > +       if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > +               __fwnode_links_move_consumers(fwnode, new_sup);
> > +
> > +       fwnode->flags |=3D FWNODE_FLAG_PARENT_IS_DEV;
> > +       new_sup->flags &=3D ~(FWNODE_FLAG_PARENT_IS_DEV);
> >
> >         fwnode_for_each_available_child_node(fwnode, child)
> >                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
> > @@ -2071,8 +2107,9 @@ static int fw_devlink_create_devlink(struct devic=
e *con,
> >                 device_links_write_unlock();
> >         }
> >
> > -       if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
> > -               sup_dev =3D fwnode_get_next_parent_dev(sup_handle);
> > +       if ((sup_handle->flags & FWNODE_FLAG_NOT_DEVICE) &&
> > +          !(sup_handle->flags & FWNODE_FLAG_PARENT_IS_DEV))
> > +               return -EINVAL;
> >         else
> >                 sup_dev =3D get_dev_from_fwnode(sup_handle);
> >
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index 2a72f55d26eb..3ed8ba503062 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -30,6 +30,9 @@ struct device;
> >   * BEST_EFFORT: The fwnode/device needs to probe early and might be mi=
ssing some
> >   *             suppliers. Only enforce ordering with suppliers that ha=
ve
> >   *             drivers.
> > + * PARENT_IS_DEV: The fwnode is a child of a fwnode that is or will be=
 populated as a
> > + *               struct device, which is more suitable for device link=
s
> > + *               than the fwnode child which may never have a struct d=
evice.
> >   */
> >  #define FWNODE_FLAG_LINKS_ADDED                        BIT(0)
> >  #define FWNODE_FLAG_NOT_DEVICE                 BIT(1)
> > @@ -37,6 +40,7 @@ struct device;
> >  #define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD   BIT(3)
> >  #define FWNODE_FLAG_BEST_EFFORT                        BIT(4)
> >  #define FWNODE_FLAG_VISITED                    BIT(5)
> > +#define FWNODE_FLAG_PARENT_IS_DEV              BIT(6)
> >
> >  struct fwnode_handle {
> >         struct fwnode_handle *secondary;
> > --
> > 2.30.2
> >
> >

