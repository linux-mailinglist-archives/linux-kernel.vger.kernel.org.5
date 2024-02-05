Return-Path: <linux-kernel+bounces-53817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A40E84A6EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151E71F297F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B965B5BF;
	Mon,  5 Feb 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tandGiOX"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC15B5AA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161163; cv=none; b=Sd9cUYEdmhV0eU8xATJL8MnXMKo4KcKcx4VMctPEkb4ImJqEO0x0MGHEcCBffy0Hqf933L2z75Zx/G5MbofPxCuoAZyRTJBj1WVgZZSvRHw+3RpzYJJknIC1PH6uZCRJb47bYJe3+S4YifSz/P+xz8hP02H8XJ8Y76gi0jb/wyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161163; c=relaxed/simple;
	bh=v26TJIeofXWL3lICUs41/lphOWSbyFMFuW6E5FR1cKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrzzGAbslYb/wIebqF3SZSinCYo9zvzoboH6+/WauJNL37imeklSgB3/vf7sq8zAApRhpIt0eXdfIC+BQcUsBYpslkQC/3zGanpzs/CuYg+5ZhCjZoUKzLYtkpPoC4KjvrKnEu+8bI5aA9KB2XKkWdzmkU1Zmqv+gS0AZev1MGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tandGiOX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42a7765511bso67811cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707161159; x=1707765959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ppprwmXY+lQkPET/t8skne59PoMO37SNUfd0LceXQU=;
        b=tandGiOXpWFyLngMesciQqBYLPpmYR3isuroSfeLKhxdQcb8tHq+2MTmmo1gqrufjA
         eG3Mms9HjevTITf4RajTLEPaBHYHEy6hIfc2Gu33l7AylHDgPtw0TcfQoxjyowjHBEtw
         okcQM7iJnlSF4wj+qhfrIIcAKdVuxMpWfBnhY7nrJ7VlAGNdSU5GQOQCz1UOKLRcZaWY
         +H1vXcYqMV1uFwmVmB5ymP/9TWF9QYxluzqD1Qb2oY2WKPkHjd+e1xyZ5fPuXmsusIA1
         ghrabl2l6Xz2bKv0q9CL5d7Vphfs4nVyjhi1s7MoEdbB5JL4viay0xF84JguMbNodrHk
         JHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161159; x=1707765959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ppprwmXY+lQkPET/t8skne59PoMO37SNUfd0LceXQU=;
        b=RGTP7DFuyshfsUKohNL6wbgYy3zzLvec7B8VIg+VnX3CAWeatewbYRrb5p4/XNEW6T
         BtW7WN6+KF+aL7gLlfueVeaKJUWugEt6uIE6UbOnceuuFt2VZLd2WM5uc7GqXeOpemoj
         WPdQ0vmW4iNKCw56j1H+NaMohsW/XiO/oI6X7HA4/iwk+O7l3L+YdD9LDseF7Ajr0Etj
         H00M0bx5RyXguoqNmAUt98gJ4hcJZy+YHD9T4A6Jrue/UG8rdQQnwQuGCukB21Jw7g1D
         QXxuZheLyp2FKqvS1mxNy91ZSSkao3LAjK9loczlWsOL/G7muTo9LaZIohS14jDDK7p6
         QcRw==
X-Gm-Message-State: AOJu0Yy1UNxjn5v3DCKBkBePLDHK/2VdIu6uam1hiedPAow1uA5C2gcd
	Pd+k3hFgVZqs0QSqeqXabqQFnY3/4kiyf4s+/ejNT6Kw3qkDaJu4Woruu/YINZ5rcCZpzOUQopG
	zY8+vLEKEjI9NBC6kiLSzsM+d3mXd9BEnddqI
X-Google-Smtp-Source: AGHT+IEl0lq8aKcbsnaIqDKoAMlgwVA7mdT76W+6lk9KKfi6qJdNLQaFhdMt2D7OuL+7bWfKEmfh8elDb5IO6Eg2zeA=
X-Received: by 2002:ac8:678a:0:b0:42a:5890:b258 with SMTP id
 b10-20020ac8678a000000b0042a5890b258mr45446qtp.16.1707161159238; Mon, 05 Feb
 2024 11:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123014517.5787-1-mcpratt@pm.me> <20240123014517.5787-3-mcpratt@pm.me>
In-Reply-To: <20240123014517.5787-3-mcpratt@pm.me>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 5 Feb 2024 11:25:20 -0800
Message-ID: <CAGETcx8S6B09T==dSp38-vX+rYjRyTaRwVqF0c2Nh-KxwDFAtw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] driver core: fw_devlink: Link to supplier ancestor
 if no device
To: Michael Pratt <mcpratt@pm.me>
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
	abel.vesa@linaro.org, alexander.stein@ew.tq-group.com, 
	andriy.shevchenko@linux.intel.com, bigunclemax@gmail.com, brgl@bgdev.pl, 
	colin.foster@in-advantage.com, djrscally@gmail.com, 
	dmitry.baryshkov@linaro.org, festevam@gmail.com, fido_max@inbox.ru, 
	frowand.list@gmail.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, 
	kernel@pengutronix.de, linus.walleij@linaro.org, linux@roeck-us.net, 
	luca.weiss@fairphone.com, magnus.damm@gmail.com, martin.kepplinger@puri.sm, 
	miquel.raynal@bootlin.com, rafal@milecki.pl, ansuelsmth@gmail.com, 
	richard@nod.at, sakari.ailus@linux.intel.com, sudeep.holla@arm.com, 
	tglx@linutronix.de, tony@atomide.com, vigneshr@ti.com, dianders@chromium.org, 
	jpb@kernel.org, rafael@kernel.org, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 5:46=E2=80=AFPM Michael Pratt <mcpratt@pm.me> wrote=
:
>
> Driver core currently supports linking to the next parent fwnode,
> but is not yet handling cases where that parent
> is also a firmware child node not representing a real device,
> which can lead to an indefinite deferred probe in some cases.
> In this case, the fwnode that should actually be linked to
> is multiple ancestors up which presents a challenge where
> it is unknown how many ancestors up the node that
> represents the real probing device is. This makes the usage of
> fwnode_get_next_parent_dev() insufficient because the real device's
> fwnode may or may not be an ancestor of the next parent fwnode as well.
>
> Introduce flag FWNODE_FLAG_PARENT_IS_DEV
> in order to mark child firmware nodes of a device
> as having a parent device that can probe.
>
> Allow fwnode link creation to the original supplier fwnode's ancestors
> when the original supplier fwnode and any fwnodes in between are flagged
> as FWNODE_FLAG_NOT_DEVICE and/or FWNODE_FLAG_PARENT_IS_DEV
> with a new function __fwnode_link_add_parents() which then creates
> the fwnode link to a real device that provides the supplier's function.
>
> This depends on other functions to label a supplier fwnode
> as not a real device, which must be done before the fwnode links
> are created, and if after that, relevant links to the supplier
> would have to be deleted and have links recreated, otherwise,
> the fwnode link would be dropped before the device link is attempted
> or a fwnode link would not be able to become a device link at all,
> because they were created before these fwnode flags can have any effect.
>
> It also depends on the supplier device to actually probe first
> in order to have the fwnode flags in place to know for certain
> which fwnodes are non-probing child nodes
> of the fwnode for the supplier device.
>
> The use case of function __fw_devlink_pickup_dangling_consumers()
> is designed so that the parameters are always a supplier fwnode
> and one of it's parent fwnodes, so it is safer to assume and more specifi=
c
> that the flag PARENT_IS_DEV should be added there, rather than
> declaring the original supplier fwnode as NOT_DEVICE at that point.
> Because this function is called when the real supplier device probes
> and recursively calls itself for all child nodes of the device's fwnode,
> set the new flag here in order to let it propagate down
> to all descendant nodes, thereby providing the info needed later
> in order to link to the proper fwnode representing the supplier device.
>
> If a fwnode is flagged as FWNODE_FLAG_NOT_DEVICE
> by the time a device link is to be made with it,
> but not flagged as FWNODE_FLAG_PARENT_IS_DEV,
> the link is dropped, otherwise the device link
> is still made with the original supplier fwnode.
> Theoretically, we can also handle linking to an ancestor
> of the supplier fwnode when forming device links, but there
> are still cases where the necessary fwnode flags are still missing
> because the real supplier device did not probe yet.
>
> Signed-off-by: Michael Pratt <mcpratt@pm.me>

NACK for a bunch of reasons.

1. This logic should not be in fwnode_link_add(). That's supposed to
do the exact linking that the firmware meant. This logic should be
where the fwnode links are converted to device links or deferred
probing decision is done.

2. If we handle one parent above correctly, it should be easy to
handle multiple parents above too. So why not fix it where we handle
multiple parents above?

Btw, I'm happy to fix this or help you fix this once I understand the
issue. Just wanted to give a quick NACK to avoid people spending
cycles on this patch in its current state.

-Saravana


> ---
>  drivers/base/core.c    | 49 ++++++++++++++++++++++++++++++++++++------
>  include/linux/fwnode.h |  4 ++++
>  2 files changed, 47 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index c05a5f6b0641..7f2652cf5edc 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -92,13 +92,45 @@ static int __fwnode_link_add(struct fwnode_handle *co=
n,
>         return 0;
>  }
>
> +static int __fwnode_link_add_parents(struct fwnode_handle *con,
> +                                    struct fwnode_handle *sup,
> +                                    u8 flags, bool loop)
> +{
> +       int ret =3D -EINVAL;
> +       struct fwnode_handle *parent;
> +
> +       fwnode_for_each_parent_node(sup, parent) {
> +               /* Ignore the root node */
> +               if (fwnode_count_parents(parent) &&
> +                   fwnode_device_is_available(parent) &&
> +                 !(parent->flags & FWNODE_FLAG_NOT_DEVICE) &&
> +                 !(parent->flags & FWNODE_FLAG_PARENT_IS_DEV)) {
> +                       ret =3D __fwnode_link_add(con, parent, flags);
> +               }
> +
> +               if (!loop && !ret) {
> +                       fwnode_handle_put(parent);
> +                       return 0;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
>  int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup=
)
>  {
>         int ret;
>
>         mutex_lock(&fwnode_link_lock);
> -       ret =3D __fwnode_link_add(con, sup, 0);
> +
> +       if ((sup->flags & FWNODE_FLAG_NOT_DEVICE) &&
> +           (sup->flags & FWNODE_FLAG_PARENT_IS_DEV))
> +               ret =3D __fwnode_link_add_parents(con, sup, 0, false);
> +       else
> +               ret =3D __fwnode_link_add(con, sup, 0);
> +
>         mutex_unlock(&fwnode_link_lock);
> +
>         return ret;
>  }
>
> @@ -218,7 +250,8 @@ static void __fwnode_links_move_consumers(struct fwno=
de_handle *from,
>   * MANAGED device links to this device, so leave @fwnode and its descend=
ant's
>   * fwnode links alone.
>   *
> - * Otherwise, move its consumers to the new supplier @new_sup.
> + * Otherwise, flag descendants of @fwnode as having a parent fwnode for =
a device
> + * that has probed and move bad fwnode consumer links from @fwnode to @n=
ew_sup.
>   */
>  static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle =
*fwnode,
>                                                    struct fwnode_handle *=
new_sup)
> @@ -228,8 +261,11 @@ static void __fw_devlink_pickup_dangling_consumers(s=
truct fwnode_handle *fwnode,
>         if (fwnode->dev && fwnode->dev->driver)
>                 return;
>
> -       fwnode->flags |=3D FWNODE_FLAG_NOT_DEVICE;
> -       __fwnode_links_move_consumers(fwnode, new_sup);
> +       if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> +               __fwnode_links_move_consumers(fwnode, new_sup);
> +
> +       fwnode->flags |=3D FWNODE_FLAG_PARENT_IS_DEV;
> +       new_sup->flags &=3D ~(FWNODE_FLAG_PARENT_IS_DEV);
>
>         fwnode_for_each_available_child_node(fwnode, child)
>                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
> @@ -2071,8 +2107,9 @@ static int fw_devlink_create_devlink(struct device =
*con,
>                 device_links_write_unlock();
>         }
>
> -       if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
> -               sup_dev =3D fwnode_get_next_parent_dev(sup_handle);
> +       if ((sup_handle->flags & FWNODE_FLAG_NOT_DEVICE) &&
> +          !(sup_handle->flags & FWNODE_FLAG_PARENT_IS_DEV))
> +               return -EINVAL;
>         else
>                 sup_dev =3D get_dev_from_fwnode(sup_handle);
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 2a72f55d26eb..3ed8ba503062 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -30,6 +30,9 @@ struct device;
>   * BEST_EFFORT: The fwnode/device needs to probe early and might be miss=
ing some
>   *             suppliers. Only enforce ordering with suppliers that have
>   *             drivers.
> + * PARENT_IS_DEV: The fwnode is a child of a fwnode that is or will be p=
opulated as a
> + *               struct device, which is more suitable for device links
> + *               than the fwnode child which may never have a struct dev=
ice.
>   */
>  #define FWNODE_FLAG_LINKS_ADDED                        BIT(0)
>  #define FWNODE_FLAG_NOT_DEVICE                 BIT(1)
> @@ -37,6 +40,7 @@ struct device;
>  #define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD   BIT(3)
>  #define FWNODE_FLAG_BEST_EFFORT                        BIT(4)
>  #define FWNODE_FLAG_VISITED                    BIT(5)
> +#define FWNODE_FLAG_PARENT_IS_DEV              BIT(6)
>
>  struct fwnode_handle {
>         struct fwnode_handle *secondary;
> --
> 2.30.2
>
>

