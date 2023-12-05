Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE157804D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjLEJFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLEJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:05:02 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A661A138
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:05:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14476E0003;
        Tue,  5 Dec 2023 09:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701767105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQ6L0iYnf9qAUnI5X5j3KYZuPXhLHFsRIqvKMaspN/4=;
        b=iHfSpdpxXaXNZQp1y42w9bsjtCoNMZvfl+tYRRsfyK696yaAvRWdBCP3m0J7Z6G+Na4hC+
        yaIhrzhHMvQremDZym2//Kqn+CBhe6EYi99siCll/IRSmTyaOJwB13GwvY3NUPimisvv4v
        aa4iKRS81yTCskc+X9y45LdUdRXIJDKyprQ+EZqd6bxj8hDG3f/YBHTin6rtEX3jlwyj4g
        kd346CnF4bDuNFII3rwGcDAgcV3t1dxRhhzTf2KBHKodXpjQ8g4K2oOlztysxp3iyXwf+7
        6NN6X4TTxtIVjmyroVC/YzsMydlgADzJZm5CZQrFBhIK+/rH7cIy29M6q3oSGA==
Date:   Tue, 5 Dec 2023 10:05:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] nvmem: fix issue within nvmem_register with
 fixed-layout.
Message-ID: <20231205100502.623863ff@xps-13>
In-Reply-To: <16c4c272-1a19-4fb8-8a2d-b2cf61ba37f2@leica-geosystems.com>
References: <20231130162922.2989774-1-catalin.popescu@leica-geosystems.com>
        <16c4c272-1a19-4fb8-8a2d-b2cf61ba37f2@leica-geosystems.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

+ GKH
+ Luca (who initially reported this issue)

catalin.popescu@leica-geosystems.com wrote on Tue, 5 Dec 2023 08:48:27
+0000:

> Adding more people.
>=20
> On 30.11.23 17:29, Catalin Popescu wrote:
> > fixed-layout is natively supported by NVMEM framework.
> > Yet, it's not been declared as a supported layout. As a
> > result, nvmem_register always returns -EPROBE_DEFER if
> > configuration has no layout and the NVMEM provider DT
> > uses a fixed layout.
> >
> > As a fix, declare fixed-layout as a supported layout
> > and use add_cells callback to parse the cells. This adds
> > consistency over layouts parsing as fixed-layout parsing
> > is handled in the same way than others nvmem layouts.

I believe this patch (not taken yet) should fix your issue and should be
queued to fixes.

Link: https://lore.kernel.org/lkml/20231124193814.360552-1-miquel.raynal@bo=
otlin.com/

However I like your approach which should probably be taken into
consideration for the next cycle, as I think it fits Rafal's
original idea pretty well.

> >
> > Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> > ---
> >   drivers/nvmem/core.c | 24 +++++++++++++++++-------
> >   1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index bf42b7e826db..3467c94207e8 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -746,7 +746,9 @@ static int nvmem_add_cells_from_legacy_of(struct nv=
mem_device *nvmem)
> >   	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
> >   }
> >  =20
> > -static int nvmem_add_cells_from_fixed_layout(struct nvmem_device *nvme=
m)
> > +static int nvmem_add_cells_from_fixed_layout(struct device *dev,
> > +					     struct nvmem_device *nvmem,
> > +					     struct nvmem_layout *layout)

I've sent another series (on top of the fix mentioned above) to
simplify a bit this list of parameters, so both will conflict. But that
will be easy to solve.

Link: https://lore.kernel.org/lkml/20231129163737.698317-1-miquel.raynal@bo=
otlin.com/

> >   {
> >   	struct device_node *layout_np;
> >   	int err =3D 0;
> > @@ -755,8 +757,7 @@ static int nvmem_add_cells_from_fixed_layout(struct=
 nvmem_device *nvmem)
> >   	if (!layout_np)
> >   		return 0;
> >  =20
> > -	if (of_device_is_compatible(layout_np, "fixed-layout"))
> > -		err =3D nvmem_add_cells_from_dt(nvmem, layout_np);
> > +	err =3D nvmem_add_cells_from_dt(nvmem, layout_np);
> >  =20
> >   	of_node_put(layout_np);
> >  =20
> > @@ -1003,10 +1004,6 @@ struct nvmem_device *nvmem_register(const struct=
 nvmem_config *config)
> >   			goto err_remove_cells;
> >   	}
> >  =20
> > -	rval =3D nvmem_add_cells_from_fixed_layout(nvmem);
> > -	if (rval)
> > -		goto err_remove_cells;
> > -
> >   	rval =3D nvmem_add_cells_from_layout(nvmem);
> >   	if (rval)
> >   		goto err_remove_cells;
> > @@ -2126,6 +2123,19 @@ const char *nvmem_dev_name(struct nvmem_device *=
nvmem)
> >   }
> >   EXPORT_SYMBOL_GPL(nvmem_dev_name);
> >  =20
> > +static const struct of_device_id fixed_layout_of_match_table[] =3D {
> > +	{ .compatible =3D "fixed-layout", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, fixed_layout_of_match_table);
> > +
> > +static struct nvmem_layout fixed_layout =3D {
> > +	.name =3D "NVMEM fixed layout",
> > +	.of_match_table =3D fixed_layout_of_match_table,
> > +	.add_cells =3D nvmem_add_cells_from_fixed_layout,
> > +};
> > +module_nvmem_layout_driver(fixed_layout);
> > +
> >   static int __init nvmem_init(void)
> >   {
> >   	return bus_register(&nvmem_bus_type); =20
>=20
>=20

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu=C3=A8l
