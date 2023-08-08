Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B7C77419B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjHHRYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjHHRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:23:57 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB831FC88
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:10:00 -0700 (PDT)
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 0A09CD39DD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 07:24:42 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 398731BF20B;
        Tue,  8 Aug 2023 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691479477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDRXGZrFxcrqIVQFTqu7OIFNyRPE4XGA6YwnsV/FCAg=;
        b=HD4Amxuyv6+a3yyzqLIy0t+Fyxsl/qTnAiuUtftt85ZqODENjhdmWX+G5DqTCwXIqGUyE1
        KXLpei6fPf2NtJKixkMWetdH1TIfqNHPsT4l/HKKeotU/DeLe+JtbLztArVSh/Z6Xnqk7Y
        3I1wUWrvAZMhnSLhli/3KbbY/rBQ6RIttCvQoxP7zFS84DDB8VKdMMqj0l55Ye14/CA7nz
        2J/gfogOjw+U96+IL5hHKLrP2XHeVw4rWQzPu+51rqM0u9SBaWoJ7V2/+1t724yYlqnnoy
        LZTHf8VauCbglN9o9o8aU37Ysmt4TOxaMzi9VDowCEAOPexlcEUBn+H8AMLvBw==
Date:   Tue, 8 Aug 2023 09:24:33 +0200
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
Message-ID: <20230808092433.039e2f48@xps-13>
In-Reply-To: <b49f8d07-9de9-48b5-27bd-fce02a82c515@linaro.org>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
        <20230808062932.150588-2-miquel.raynal@bootlin.com>
        <b49f8d07-9de9-48b5-27bd-fce02a82c515@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Tue, 8 Aug 2023 07:56:47 +0100:

> On 08/08/2023 07:29, Miquel Raynal wrote:
> > Let's pack all the cells creation in one place, so they are all created
> > before we add the nvmem device.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >   drivers/nvmem/core.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 3f8c7718412b..48659106a1e2 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -998,12 +998,6 @@ struct nvmem_device *nvmem_register(const struct n=
vmem_config *config)
> >   	if (rval)
> >   		goto err_remove_cells; =20
> >   > -	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->nam=
e); =20
> > -
> > -	rval =3D device_add(&nvmem->dev);
> > -	if (rval)
> > -		goto err_remove_cells;
> > -
> >   	rval =3D nvmem_add_cells_from_fixed_layout(nvmem);
> >   	if (rval)
> >   		goto err_remove_cells;
> > @@ -1012,6 +1006,12 @@ struct nvmem_device *nvmem_register(const struct=
 nvmem_config *config)
> >   	if (rval)
> >   		goto err_remove_cells; =20
> >   > +	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->nam=
e); =20
> > +
> > +	rval =3D device_add(&nvmem->dev);
> > +	if (rval)
> > +		goto err_remove_cells; =20
>=20
> All the error handling paths are now messed up with this patch, put_devic=
e() in error path will be called incorrectly from multiple places.

I'm not sure what this means. Perhaps I should additionally call
device_del() after device_add was successful to mimic the
device_unregister() call from the remove path. Is that what you mean?

I also see the layout_np below should be freed before jumping in the
error section.

Is there anything else I missed? Because you said "from multiple
places", and I don't see this.

Thanks,
Miqu=C3=A8l
