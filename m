Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297087FA7CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjK0RPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjK0RPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:15:12 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5FA19D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:15:18 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E127E40007;
        Mon, 27 Nov 2023 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701105317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pm9QkYO7sIE1cvNwftqV0IeYYA7ljroCFyKvUGzvpns=;
        b=AHNUEPyk2CsVQoBiKX7RRJj9d5Y60GGD6k/QJLD1GWRmA3Emi4jmkhigJ2S/5PrzOjFanF
        Lu7ynAgrGG8UWc5dMlubATvYbTwDmt5pYNa/bkW4WusB2saJbkyRrrPG2CTVrkTCQvD1yO
        jgDJf965nI5Khti8qFXl8FIeMZRZA+LwyIX/pn8rqGBT3gyYue+RxrUDpYV4rqQvggQtuc
        VqyFnRtw4pgI84xTeV6/Du7TzDnN1ykodtwS/N03SjqvH7T3dqhGBDubf/q6/3I2PdF1GF
        hIbzYocs5pbWATDTfWbqhsoJ2ebOBprvxKOqAcuLA/vw6I1W7MkACBIEbTRP0w==
Date:   Mon, 27 Nov 2023 18:15:14 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     michael@walle.cc, jaimeliao.tw@gmail.com, jaimeliao@mxic.com.tw,
        pratyush@kernel.org, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: stop printing superfluous debug info
Message-ID: <20231127181514.19b99d2e@xps-13>
In-Reply-To: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
References: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

tudor.ambarus@linaro.org wrote on Mon, 27 Nov 2023 16:59:08 +0000:

> The mtd data can be obtain with the mtd ioctls and the SPI NOR
> flash name can be determined interrogating the sysfs entries.
> Stop polluting the kernel log.

Actually I like these prints when developing/fixing stuff, it's a clear
indication of what's been discovered that is available even if for some
reason my rootfs is not available (which is common when the rootfs is
on a spi-nor).

So I would not trash all these lines personally... I believe the
dev_info can be lowered if you prefer, but dev_dbg is already meant for
debugging purposes and will anyway be discarded by default.

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/core.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 25a64c65717d..6de76fd009d1 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3517,25 +3517,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *=
name,
>  	/* No mtd_info fields should be used up to this point. */
>  	spi_nor_set_mtd_info(nor);
> =20
> -	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
> -			(long long)mtd->size >> 10);
> -
> -	dev_dbg(dev,
> -		"mtd .name =3D %s, .size =3D 0x%llx (%lldMiB), "
> -		".erasesize =3D 0x%.8x (%uKiB) .numeraseregions =3D %d\n",
> -		mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
> -		mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
> -
> -	if (mtd->numeraseregions)
> -		for (i =3D 0; i < mtd->numeraseregions; i++)
> -			dev_dbg(dev,
> -				"mtd.eraseregions[%d] =3D { .offset =3D 0x%llx, "
> -				".erasesize =3D 0x%.8x (%uKiB), "
> -				".numblocks =3D %d }\n",
> -				i, (long long)mtd->eraseregions[i].offset,
> -				mtd->eraseregions[i].erasesize,
> -				mtd->eraseregions[i].erasesize / 1024,
> -				mtd->eraseregions[i].numblocks);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(spi_nor_scan);


Thanks,
Miqu=C3=A8l
