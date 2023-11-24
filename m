Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD22A7F843B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbjKXTZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXTZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:25:08 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496C52D4E;
        Fri, 24 Nov 2023 11:25:14 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC79A40003;
        Fri, 24 Nov 2023 19:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700853912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0CyzQpV4Tyz2xY0O2TZItXXhN4Ys6YBAT2N8EGMIrM=;
        b=efr+Q17dRJ0Y2etkZfLFho/qiX0F5TpoxJh45ARs1YK5SJ7RQNcHwDOlm63CEkPRe483QS
        dQ/cHDfkQjXOQAS99yW//xyxCEcCwSbjduiZ97rvD2K7WRp9snjh/VPNuaWsAxz7HxfkbO
        Wyfu/jSfRXtPpA19gk21doMdg5EFqa6ibhDxCRlDn/L7b1ZG4RFVY3lNF2zWz903xVVtWE
        aQlhKotHb0CT+kdtLVP6KLqPUT+wsmGNGDya5sqTLD0/L+PUEAiVqmuaNT56h5Fg760hAK
        MFbCEdHidB8vpMyCkH72HqEJEy/NIWMP83+y8ybr6HXaS6u74LrtqagFP7LBzg==
Date:   Fri, 24 Nov 2023 20:25:08 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v13 4/6] nvmem: core: Rework layouts to become regular
 devices
Message-ID: <20231124202508.48a00fc5@xps-13>
In-Reply-To: <20231122224553.cfklcv6rew6ktixj@pengutronix.de>
References: <20231011111529.86440-1-miquel.raynal@bootlin.com>
        <20231011111529.86440-5-miquel.raynal@bootlin.com>
        <20231122220240.4jg245vblnh6d5zy@pengutronix.de>
        <20231122224553.cfklcv6rew6ktixj@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

m.felsch@pengutronix.de wrote on Wed, 22 Nov 2023 23:45:53 +0100:

> Hi Miquel,
>=20
> sorry for answering to my own mail, I forgot something I noticed later.

No problem :)

> On 23-11-22, Marco Felsch wrote:
> > Hi Miquel,
> >=20
> > thanks a lot for your effort on this. Please see my comments inline.
> >=20
> > On 23-10-11, Miquel Raynal wrote: =20
> > > Current layout support was initially written without modules support =
in
> > > mind. When the requirement for module support rose, the existing base
> > > was improved to adopt modularization support, but kind of a design fl=
aw
> > > was introduced. With the existing implementation, when a storage devi=
ce
> > > registers into NVMEM, the core tries to hook a layout (if any) and
> > > populates its cells immediately. This means, if the hardware descript=
ion
> > > expects a layout to be hooked up, but no driver was provided for that,
> > > the storage medium will fail to probe and try later from
> > > scratch. Even if we consider that the hardware description shall be
> > > correct, we could still probe the storage device (especially if it
> > > contains the rootfs).
> > >=20
> > > One way to overcome this situation is to consider the layouts as
> > > devices, and leverage the existing notifier mechanism. When a new NVM=
EM
> > > device is registered, we can:
> > > - populate its nvmem-layout child, if any
> > > - try to modprobe the relevant driver, if relevant =20
>=20
> I'm not sure why we call of_request_module() the driver framework should
> handle that right?

Actually that's right, it is no longer needed, we would expect udev to
do that now. Thanks for the pointer.

> > > - try to hook the NVMEM device with a layout in the notifier =20
>=20
> The last part is no longer true since you don't use the notifier
> anymore.

True, I've re-written this part.

> > > And when a new layout is registered:
> > > - try to hook all the existing NVMEM devices which are not yet hooked=
 to
> > >   a layout with the new layout
> > > This way, there is no strong order to enforce, any NVMEM device creat=
ion
> > > or NVMEM layout driver insertion will be observed as a new event which
> > > may lead to the creation of additional cells, without disturbing the
> > > probes with costly (and sometimes endless) deferrals.
> > >=20
> > > In order to achieve that goal we need:
> > > * To keep track of all nvmem devices
> > > * To create a new bus for the nvmem-layouts with minimal logic to mat=
ch
> > >   nvmem-layout devices with nvmem-layout drivers.
> > > All this infrastructure code is created in the layouts.c file.
> > >=20
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Tested-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> =20
>=20
> ...
>=20
> > > @@ -944,19 +872,6 @@ struct nvmem_device *nvmem_register(const struct=
 nvmem_config *config)
> > >  			goto err_put_device;
> > >  	}
> > > =20
> > > -	/*
> > > -	 * If the driver supplied a layout by config->layout, the module
> > > -	 * pointer will be NULL and nvmem_layout_put() will be a noop.
> > > -	 */
> > > -	nvmem->layout =3D config->layout ?: nvmem_layout_get(nvmem);
> > > -	if (IS_ERR(nvmem->layout)) {
> > > -		rval =3D PTR_ERR(nvmem->layout);
> > > -		nvmem->layout =3D NULL;
> > > -
> > > -		if (rval =3D=3D -EPROBE_DEFER)
> > > -			goto err_teardown_compat;
> > > -	} =20
>=20
> Since this logic will be gone and the layout became a device the fixup
> hook for the layout is more than confusing. E.g. the imx-ocotp driver
> uses the layout to register a fixup for a cell which is fine but the
> hook should be moved from the layout[-dev] to the config. Please see
> below.

That is true.

>=20
> > > -
> > >  	if (config->cells) {
> > >  		rval =3D nvmem_add_cells(nvmem, config->cells, config->ncells);
> > >  		if (rval)
> > > @@ -975,7 +890,7 @@ struct nvmem_device *nvmem_register(const struct =
nvmem_config *config)
> > >  	if (rval)
> > >  		goto err_remove_cells;
> > > =20
> > > -	rval =3D nvmem_add_cells_from_layout(nvmem);
> > > +	rval =3D nvmem_populate_layout(nvmem);
> > >  	if (rval)
> > >  		goto err_remove_cells; =20
>=20
> Also why do we populate the nvmem-layout device infront of the nvmem
> device?

I'm not sure I get the question, there is nothing abnormal that stands
out to my eyes.

...

> >  =20
> > > -	const char *name;
> > > -	const struct of_device_id *of_match_table;
> > > +	struct device dev;
> > > +	struct nvmem_device *nvmem;
> > >  	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem,
> > >  			 struct nvmem_layout *layout);
> > >  	void (*fixup_cell_info)(struct nvmem_device *nvmem,
> > >  				struct nvmem_layout *layout,
> > >  				struct nvmem_cell_info *cell); =20
>=20
> I speak about this hook. This should be moved into the config, maybe
> also renamed to fixup_dt_cell_info() or so to not confuse the users. If
> we move that hook and remove the add_cells hook there are only two
> members left for the cross-link.

It's not a bad idea, I've included this change in my series (for v14,
sic). I like your rename as well. Thanks for the hint.

Thanks,
Miqu=C3=A8l
