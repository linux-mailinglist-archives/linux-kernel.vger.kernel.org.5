Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEC8769B03
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjGaPpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGaPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:45:12 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BDDE57
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:45:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D39B1FF808;
        Mon, 31 Jul 2023 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690818309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FSIAqeOuayaaKRncvVUn+1XDuP+hp1ypNaupfCM5SM=;
        b=fcgKkc8x3RLFYjGjA3iMwYuPa3RXERO4PvbkifpA+X+sHvhNY40AteS47Hw448DXV3e+Rj
        w/tlSmSfUkVIXf/MNCRlsO2GHay90FU/lita5D0sUHe83F7Y9Uj0UBL21rp5pQGBu2+H66
        L5kd//FLoHxl7KQXftccr/Oq8MFT7z30mNA1YTtEC4L5OH0pZWmsR92w1Q4lcLumBgRr4u
        Jy4thZahsQwo6QzukqWWZRnJwpzOdyGnGXuDzM9e1KBh+3C6ffjFaeJTdjk/ASMF3/pAYA
        01SedJQJ169RGkMxDDLjwBYJiz+lrLlO3v1WfwxxymtzJabVjP1Sk7xOyCJ2CQ==
Date:   Mon, 31 Jul 2023 17:45:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: core: append offset to cell name in sysfs
Message-ID: <20230731174506.00368411@xps-13>
In-Reply-To: <ZLaZ7fzUSsa0Igx1@makrotopia.org>
References: <ZLaZ7fzUSsa0Igx1@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

daniel@makrotopia.org wrote on Tue, 18 Jul 2023 14:55:57 +0100:

> The device tree node names are not required to be unique. Append the
> offset to the name to make cell nodes with identical names become
> accessible via sysfs and avoid kernel stackdump caused by
> sysfs: cannot create duplicate filename '...'
>=20
> Fixes: 757f8b3835c9 ("nvmem: core: Expose cells through sysfs")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/nvmem/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 70e951088826d..90fe9dc30f8ba 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -480,7 +480,9 @@ static int nvmem_populate_sysfs_cells(struct nvmem_de=
vice *nvmem)
>  	/* Initialize each attribute to take the name and size of the cell */
>  	list_for_each_entry(entry, &nvmem->cells, node) {
>  		sysfs_bin_attr_init(&attrs[i]);
> -		attrs[i].attr.name =3D devm_kstrdup(&nvmem->dev, entry->name, GFP_KERN=
EL);
> +		attrs[i].attr.name =3D devm_kasprintf(&nvmem->dev, GFP_KERNEL,
> +						    "%s@%d", entry->name,
> +						    entry->offset);

Shouldn't we use %s@%x instead to match the DT descriptions?

>  		attrs[i].attr.mode =3D 0444;
>  		attrs[i].size =3D entry->bytes;
>  		attrs[i].read =3D &nvmem_cell_attr_read;

I plan another version of the series which triggered these patches, if
you don't mind I will squash patch 1 into my patches and pick this one
as a preparation change (likely with the above fix if you agree and
without the Fixes tag).

Thanks,
Miqu=C3=A8l
