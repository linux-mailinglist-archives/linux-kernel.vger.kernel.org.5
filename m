Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C597A6989
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjISRXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjISRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:23:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400CDC6;
        Tue, 19 Sep 2023 10:22:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a9f139cd94so813740366b.2;
        Tue, 19 Sep 2023 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695144178; x=1695748978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcXUnksJwhyRAlze+kKPMXIvfRdnYvFyu340idGgApY=;
        b=mcb7KxwM0kl/LX+7huW+YDEGd7jIXe/qM5z3XzF2ICbLF5Udokt0PFT15htEulhigZ
         XtaksEjj7KQQvmf0AQDHWmkWVg4cBgTtyvFn17ICp330CreeefUbhEx2lD2wArJrlH6u
         Vxuj5snNu0JteSzCiwUfFMA5rWeO4AjC987wyvhJDfKXt+BY4Eerz4QeDzPg1zNUPOBm
         b1GYnoKkbSbo/JSPbjxz/bgIb+l+mWYnj40D6nGDGTCzJ1SJwEe8Jh+K+SwFEgDNtvRu
         16UQ7EyvR8i66w19dDSmaunlupvCQDgPIUTwtw6x5whXrjnJxPptH/ziT66f7FDAMBrI
         x1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695144178; x=1695748978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcXUnksJwhyRAlze+kKPMXIvfRdnYvFyu340idGgApY=;
        b=L4d1frGVqacUEZ0mFbTtvzQEk9BHEN/h2NNMv60L8VJQVOaOJhey1O7VZ7K/Zat69O
         AX0bCBJbCHzIsNO4cIoaNoKp5ECwkWOLKhrK608vD5seLvJubZpyaL5mWR9njVQsystJ
         UPi20feYyc8ah7qdPAxaYrMZTTwrSQHZf8xI+49gRty8njBR9Wvz9n6ugCqCG7bDm5mv
         g5t8UqKU+HFauvOt7G0NnFtGh7UKMJWuXUPtZ8a/MsUlJqrHZ1E4zIUMw7x9geyFoSMI
         r6Cnbd0BQUK3Uw1aNxqPS/5esZ4cQk0muvt07II7QzSZRcLyur64FJMRL3XonhJkTW1R
         Ta+w==
X-Gm-Message-State: AOJu0YxfhUOCFJQHxKp2adnJ7/i3fEWMTp9/h1EagwXDD9vcof9EZQAW
        9bOQ4Xcg54PQIKEsbCz2YbI=
X-Google-Smtp-Source: AGHT+IF1Q4adU0rIcBVlI48STfiiF389ivz0W8cymo4KGMc3SHlL5K2MmpfuORVbO6ik0/JbKkDBjw==
X-Received: by 2002:a17:906:1de:b0:9ae:3f3a:828d with SMTP id 30-20020a17090601de00b009ae3f3a828dmr53646ejj.21.1695144177494;
        Tue, 19 Sep 2023 10:22:57 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id jp27-20020a170906f75b00b0099bd046170fsm8115171ejb.104.2023.09.19.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:22:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 18/19] net: mdio: sun4i: Convert to platform remove
 callback returning void
Date:   Tue, 19 Sep 2023 19:22:55 +0200
Message-ID: <8276262.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20230918195102.1302746-19-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
 <20230918195102.1302746-19-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 18. september 2023 ob 21:51:01 CEST je Uwe Kleine-K=F6nig=20
napisal(a):
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/net/mdio/mdio-sun4i.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/mdio/mdio-sun4i.c b/drivers/net/mdio/mdio-sun4i.c
> index f798de3276dc..4511bcc73b36 100644
> --- a/drivers/net/mdio/mdio-sun4i.c
> +++ b/drivers/net/mdio/mdio-sun4i.c
> @@ -142,7 +142,7 @@ static int sun4i_mdio_probe(struct platform_device
> *pdev) return ret;
>  }
>=20
> -static int sun4i_mdio_remove(struct platform_device *pdev)
> +static void sun4i_mdio_remove(struct platform_device *pdev)
>  {
>  	struct mii_bus *bus =3D platform_get_drvdata(pdev);
>  	struct sun4i_mdio_data *data =3D bus->priv;
> @@ -151,8 +151,6 @@ static int sun4i_mdio_remove(struct platform_device
> *pdev) if (data->regulator)
>  		regulator_disable(data->regulator);
>  	mdiobus_free(bus);
> -
> -	return 0;
>  }
>=20
>  static const struct of_device_id sun4i_mdio_dt_ids[] =3D {
> @@ -166,7 +164,7 @@ MODULE_DEVICE_TABLE(of, sun4i_mdio_dt_ids);
>=20
>  static struct platform_driver sun4i_mdio_driver =3D {
>  	.probe =3D sun4i_mdio_probe,
> -	.remove =3D sun4i_mdio_remove,
> +	.remove_new =3D sun4i_mdio_remove,
>  	.driver =3D {
>  		.name =3D "sun4i-mdio",
>  		.of_match_table =3D sun4i_mdio_dt_ids,




