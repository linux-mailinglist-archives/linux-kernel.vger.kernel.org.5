Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623317AE742
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjIZICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:02:15 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C89EB8;
        Tue, 26 Sep 2023 01:02:08 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53EF0C0006;
        Tue, 26 Sep 2023 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695715326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uC/2kLEOqWjHhkqWNdblzqZqROUZmT9ZCKkUFCorqtY=;
        b=cl008PAW3HgvFdBznq2sahoqBDsP8MviZ8w7HJpW/+jZwMdZahu8CNADdHZr+YWNSxBI60
        TXZCZ0Ig8KxogrEgJ5zSjNN+uLAQ5bRKbjgR2dA4MoSrsI9Z5FjFbJcRP14zcShisJucXB
        d8EW8JPara8d9CVyPJgBlURdaKUblYDOdH36lUV97x0dxCMkh/UKXLwbwTlDhXkh10fBmF
        9O/skoVKFZMZ1qo4K4a7A7I7lYl1kVD6PHBCRzA/WjZ9PKmlKXfOxRw1XbIBxHNJf+ScWu
        +tVm8AmmvLqvYs4RsYYK+0ax+SnhqeDjhmcjIj+TTvdG8cyBPR/JJnZsqPzeAQ==
Date:   Tue, 26 Sep 2023 10:02:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Harry Morris <harrymorris12@gmail.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ieee802154: ca8210: Fix a potential UAF in
 ca8210_probe
Message-ID: <20230926100202.011ab841@xps-13>
In-Reply-To: <20230926032244.11560-1-dinghao.liu@zju.edu.cn>
References: <20230926032244.11560-1-dinghao.liu@zju.edu.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinghao,

dinghao.liu@zju.edu.cn wrote on Tue, 26 Sep 2023 11:22:44 +0800:

> If of_clk_add_provider() fails in ca8210_register_ext_clock(),
> it calls clk_unregister() to release priv->clk and returns an
> error. However, the caller ca8210_probe() then calls ca8210_remove(),
> where priv->clk is freed again in ca8210_unregister_ext_clock(). In
> this case, a use-after-free may happen in the second time we call
> clk_unregister().
>=20
> Fix this by removing the first clk_unregister(). Also, priv->clk could
> be an error code on failure of clk_register_fixed_rate(). Use
> IS_ERR_OR_NULL to catch this case in ca8210_unregister_ext_clock().
>=20
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")

Missing Cc stable, this needs to be backported.

> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>=20
> Changelog:
>=20
> v2: -Remove the first clk_unregister() instead of nulling priv->clk.
> ---
>  drivers/net/ieee802154/ca8210.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8=
210.c
> index aebb19f1b3a4..b35c6f59bd1a 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -2759,7 +2759,6 @@ static int ca8210_register_ext_clock(struct spi_dev=
ice *spi)
>  	}
>  	ret =3D of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
>  	if (ret) {
> -		clk_unregister(priv->clk);
>  		dev_crit(
>  			&spi->dev,
>  			"Failed to register external clock as clock provider\n"

I was hoping you would simplify this function a bit more.

> @@ -2780,7 +2779,7 @@ static void ca8210_unregister_ext_clock(struct spi_=
device *spi)
>  {
>  	struct ca8210_priv *priv =3D spi_get_drvdata(spi);
> =20
> -	if (!priv->clk)
> +	if (IS_ERR_OR_NULL(priv->clk))
>  		return
> =20
>  	of_clk_del_provider(spi->dev.of_node);

Alex, Stefan, who handles wpan and wpan/next this release?

Thanks,
Miqu=C3=A8l
