Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661167FB52A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjK1JDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjK1JDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:03:12 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57C81B5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:03:17 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3278FF81E;
        Tue, 28 Nov 2023 09:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701162196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WD8wV/VANG0qms5+pgg5WkXkGCgPD0uOURm4uNYIcnk=;
        b=G0Ldjj+UYdmXqluksI3HIMDa7/JFXW5tsMHkFdZwUvvmwMR4bGZzbO/AyN/6Ee45f8dXAW
        prN9ilgyPrL0jo860pD/sNUENUaV6uf1tpoX+r50wA4LYx5GlvygxG6DtFhEvxqLRkjZN2
        XWZcqOqo/qwJSa+PSvWnPu4aXEaMcbaY+9rTXEXjJ5kaXSZH7BhPYEWULg3KknGYKl047U
        Bv5gcURtFFW8n+waV7V6wh/GWUcPmjdfYzJ8KfA9h0n2DO3whU5hFabN0UNYFFTITGmTzz
        TVtQDcmWv25BGEYN1Ibf7xFRP+tfyRuk76vteWsg6aWWZGj75ZKaixodJweRzA==
Date:   Tue, 28 Nov 2023 10:03:13 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>, jaimeliao.tw@gmail.com,
        jaimeliao@mxic.com.tw, pratyush@kernel.org, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: stop printing superfluous debug info
Message-ID: <20231128100313.3c990f69@xps-13>
In-Reply-To: <42c96d63d1ea4f7e8f16a3c8eb0a4cf1@walle.cc>
References: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
        <42c96d63d1ea4f7e8f16a3c8eb0a4cf1@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

michael@walle.cc wrote on Tue, 28 Nov 2023 09:47:28 +0100:

> Hi,
>=20
> > The mtd data can be obtain with the mtd ioctls and the SPI NOR
> > flash name can be determined interrogating the sysfs entries.
> > Stop polluting the kernel log.
> >=20
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >=20
> > ---
> >  drivers/mtd/spi-nor/core.c | 19 -------------------
> >  1 file changed, 19 deletions(-)
> >=20
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 25a64c65717d..6de76fd009d1 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3517,25 +3517,6 @@ int spi_nor_scan(struct spi_nor *nor, const char=
 > *name,
> >  	/* No mtd_info fields should be used up to this point. */
> >  	spi_nor_set_mtd_info(nor);
> >=20
> > -	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
> > -			(long long)mtd->size >> 10); =20
>=20
> I'd lower this to dev_dbg() and print the jedec id. It might come in
> handy for a quick glance during bootup if debug is enabled.

Ack. Although, your boot time will almost be unaffected if you don't
print the info messages to the console. What takes the most time is not
writing to the kernel buffer, it's to display the lines on a serial
console, and dev_info() are by default discarded, you need to select a
lower log level manually, and if you do that it means you're not
looking for quick boot times but rather more for additional information.

> > -	dev_dbg(dev,
> > -		"mtd .name =3D %s, .size =3D 0x%llx (%lldMiB), "
> > -		".erasesize =3D 0x%.8x (%uKiB) .numeraseregions =3D %d\n",
> > -		mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
> > -		mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
> > -
> > -	if (mtd->numeraseregions)
> > -		for (i =3D 0; i < mtd->numeraseregions; i++)
> > -			dev_dbg(dev,
> > -				"mtd.eraseregions[%d] =3D { .offset =3D 0x%llx, "
> > -				".erasesize =3D 0x%.8x (%uKiB), "
> > -				".numblocks =3D %d }\n",
> > -				i, (long long)mtd->eraseregions[i].offset,
> > -				mtd->eraseregions[i].erasesize,
> > -				mtd->eraseregions[i].erasesize / 1024,
> > -				mtd->eraseregions[i].numblocks);
> >  	return 0; =20
>=20
> Part of this is already available through the spi-nor debugfs, although n=
ot
> the actual mtd properties. These I think, should go into the mtdcore
> itself if really needed. Either through dev_dbg() or debugfs.

Maybe we don't need this at all, as long as one message remains about
the JEDEC ID, but keep in mind that spi-nors are commonly storing the
rootfs and if your spi-nor does not boot you don't have a userspace yet
and all the debugfs entries are purely useless.

Thanks,
Miqu=C3=A8l
