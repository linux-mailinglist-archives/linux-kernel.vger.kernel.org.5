Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0473178ADFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjH1KyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjH1Kxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:53:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500CDD;
        Mon, 28 Aug 2023 03:53:28 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F37BA6B5;
        Mon, 28 Aug 2023 12:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693219835;
        bh=urchrIa5bibTdqbDKSnaOSwnMIAFoyrrFQmDtnh6exM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bo4EHvlqFzoLdyiH67p6WzYo9CsyU2bibJMxXL1mDq37g/YtVc01Egl2FU6asOMJr
         WtZUY8FxR4tPpChgMR/YCO3UUdfV5D7lOIAlrDcR2qG58YqXR6RmvmvAv5N+n9d02g
         IzILXe7ZZpePA1/OHC4Q4UUNLlE7ZdaLcLFKtwzk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <rveb47frebdzhpcxdt4jnyasiztrhfnee3pzgl5ndafh2jbrsf@za4o23cw3lch>
References: <084fdd562690c08f1ee72bc08e63e8ee576dc86a.1693001599.git.christophe.jaillet@wanadoo.fr> <rveb47frebdzhpcxdt4jnyasiztrhfnee3pzgl5ndafh2jbrsf@za4o23cw3lch>
Subject: Re: [PATCH] media: i2c: max9286: Fix some redundant of_node_put() calls
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?utf-8?q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Date:   Mon, 28 Aug 2023 11:51:53 +0100
Message-ID: <169321991310.137962.4278774029844229066@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacopo Mondi (2023-08-28 08:34:40)
> Hi Christophe
>=20
> On Sat, Aug 26, 2023 at 12:13:40AM +0200, Christophe JAILLET wrote:
> > This is odd to have a of_node_put() just after a for_each_child_of_node=
()
> > or a for_each_endpoint_of_node() loop. It should already be called
> > during the last iteration.
>=20
> Let's unwrap the calls:
>=20
> #define for_each_child_of_node(parent, child) \
>      for (child =3D of_get_next_child(parent, NULL); child !=3D NULL; \
>           child =3D of_get_next_child(parent, child))
>=20
> static struct device_node *__of_get_next_child(const struct device_node *=
node,
>                                                 struct device_node *prev)
> {
>         struct device_node *next;
>=20
>         if (!node)
>                 return NULL;
>=20
>         next =3D prev ? prev->sibling : node->child;
>         of_node_get(next);
>         of_node_put(prev);
>         return next;
> }
>=20
> Let's express the C for loop semantic as a while to help following the
> code:
>=20
>         child =3D of_get_next_child(parent, NULL);
>         while (child !=3D NULL)
>                 child =3D of_get_next_child(parent, child);
>=20
> I concur that the last loop iteration the call to
> __of_get_next_child() will expand to
>=20
>         next =3D NULL;
>         of_node_get(NULL);
>         of_node_put(prev)
>=20
> So it seems to me it is not necessary to put the node after
> for_each_child_of_node() ?
>=20
> In facts none of the other usages of for_each_child_of_node() in the
> kernel (the ones i checked at least) have a put() after the loop.

I agree. As long as the loops don't use any break statement - there
shouldn't be any _put() after the completion of the loop.

That would make a good cocci script - make sure these iterators do not
use 'break' internally - as that would then conflict!


Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

>=20
> >
> > Remove these calls.
> >
> > Fixes: 66d8c9d2422d ("media: i2c: Add MAX9286 driver")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>=20
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>=20
> Thanks
>   j
>=20
> > ---
> > /!\  This patch is speculative, review with case  /!\
> > ---
> >  drivers/media/i2c/max9286.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
> > index 20e7c7cf5eeb..f27a69b1b727 100644
> > --- a/drivers/media/i2c/max9286.c
> > +++ b/drivers/media/i2c/max9286.c
> > @@ -1450,7 +1450,6 @@ static int max9286_parse_dt(struct max9286_priv *=
priv)
> >
> >               i2c_mux_mask |=3D BIT(id);
> >       }
> > -     of_node_put(node);
> >       of_node_put(i2c_mux);
> >
> >       /* Parse the endpoints */
> > @@ -1514,7 +1513,6 @@ static int max9286_parse_dt(struct max9286_priv *=
priv)
> >               priv->source_mask |=3D BIT(ep.port);
> >               priv->nsources++;
> >       }
> > -     of_node_put(node);
> >
> >       of_property_read_u32(dev->of_node, "maxim,bus-width", &priv->bus_=
width);
> >       switch (priv->bus_width) {
> > --
> > 2.34.1
> >
