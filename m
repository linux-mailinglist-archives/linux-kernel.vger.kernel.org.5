Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47BA778EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjHKML3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjHKML1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:11:27 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA5125
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:11:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7B3740007;
        Fri, 11 Aug 2023 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691755884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nr36dDOCOUqTZ2oiA2rtqnHJ7XBkFlEscuS+OrYMfhs=;
        b=kI/2qwbqQxUIyXxLRGmY9GwDGq0KsaD/Nn7x9XmiFOlpeMXQPgn5jQXjJQf8S+yB4C6Qsv
        BaEDY6vQetIWLzyjipkZRBvyyXBrKrggrLq+nQI9aRPPNCdb6hAImWl1X/3eCyvmrzJVpn
        8DnpMRy4sJ61eabZYFFCTaYdirhfoebTFOLAl+lIami+zXKAGy0QU+mut7hAdzTZhjxCy6
        vTv5x9CCS4QScTFBttgDBPFsmhbQ9EwC4ldQ2kNCtnC8yEFJz7um/k+TCPuTPDfSomOkbD
        ZA7kdkYSi68MRk6GiFXmvGolRQan/UMFp8s9yTUQfEpahb4IbyXegdFTBQBr9Q==
Date:   Fri, 11 Aug 2023 14:11:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v9 1/7] nvmem: core: Create all cells before adding the
 nvmem device
Message-ID: <20230811141122.7921df1d@xps-13>
In-Reply-To: <05aea50f-6692-962e-abe7-765197815f03@linaro.org>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
        <20230808062932.150588-2-miquel.raynal@bootlin.com>
        <b49f8d07-9de9-48b5-27bd-fce02a82c515@linaro.org>
        <20230808092433.039e2f48@xps-13>
        <05aea50f-6692-962e-abe7-765197815f03@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Fri, 11 Aug 2023 12:11:19 +0100:

> On 08/08/2023 08:24, Miquel Raynal wrote:
> > Hi Srinivas,
> >=20
> > srinivas.kandagatla@linaro.org wrote on Tue, 8 Aug 2023 07:56:47 +0100:
> >  =20
> >> On 08/08/2023 07:29, Miquel Raynal wrote: =20
> >>> Let's pack all the cells creation in one place, so they are all creat=
ed
> >>> before we add the nvmem device.
> >>>
> >>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>> ---
> >>>    drivers/nvmem/core.c | 12 ++++++------
> >>>    1 file changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> >>> index 3f8c7718412b..48659106a1e2 100644
> >>> --- a/drivers/nvmem/core.c
> >>> +++ b/drivers/nvmem/core.c
> >>> @@ -998,12 +998,6 @@ struct nvmem_device *nvmem_register(const struct=
 nvmem_config *config)
> >>>    	if (rval)
> >>>    		goto err_remove_cells; =20
> >>>    > -	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->=
name); =20
> >>> -
> >>> -	rval =3D device_add(&nvmem->dev);
> >>> -	if (rval)
> >>> -		goto err_remove_cells;
> >>> -
> >>>    	rval =3D nvmem_add_cells_from_fixed_layout(nvmem);
> >>>    	if (rval)
> >>>    		goto err_remove_cells;
> >>> @@ -1012,6 +1006,12 @@ struct nvmem_device *nvmem_register(const stru=
ct nvmem_config *config)
> >>>    	if (rval)
> >>>    		goto err_remove_cells; =20
> >>>    > +	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->=
name); =20
> >>> +
> >>> +	rval =3D device_add(&nvmem->dev);
> >>> +	if (rval)
> >>> +		goto err_remove_cells; =20
> >>
> >> All the error handling paths are now messed up with this patch, put_de=
vice() in error path will be called incorrectly from multiple places. =20
> >=20
> > I'm not sure what this means. Perhaps I should additionally call
> > device_del() after device_add was successful to mimic the
> > device_unregister() call from the remove path. Is that what you mean? =
=20
>=20
>=20
> This looks perfectly fine, no change required. This also fixes a bug of m=
issing device_del() in err path.
>=20
> pl, Ignore my old comments.

nvmem_register() calls device_initialize() and later device_add(),
which is exactly the content of device_register(). Upon error
after device_add(), we currently call device_put(), whereas
device_unregister would call both device_del() and device_put().

I would expect device_del() to be first called upon error before
device_put() *after* device_add() has succeded, no?

> > I also see the layout_np below should be freed before jumping in the
> > error section. =20
>=20
> you mean missing of_node_put()?

Yes, I need to call of_node_put() before jumping into the error path.

Thanks,
Miqu=C3=A8l
