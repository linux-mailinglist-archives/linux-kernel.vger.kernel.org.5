Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12067F030F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 22:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjKRVvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 16:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRVvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 16:51:21 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CDB192
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 13:51:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso4509970a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 13:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700344272; x=1700949072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Sxr/0cg0TxZRHR6aK8VgbLOF1wZHnjhGaQVl3ixHFI=;
        b=OQtiBXU8hzG4i2RYby6dKdU4yF/hv3SlvFtVvr0SCJmhDD3vFPf91qPE1JplnrRsYD
         nyAw25JrPC/CTHuWpF7gD1gxG9ELzlb9OU7/GI4Lqq3vV7spq/WDYuz5LxWEf9142YQn
         XOOzuICRdBBmTE9BZSm6MVe5a+amP6A+vZouji0Hde3UK1F/2ix1katilukhXvAsj+VI
         nyCpWdg4UVbc4MWJyNjm2RDFntccTj5F+Ua1PbJD/k+dXPWl0pzB/0jj2Yh+2HXEoAcg
         gaabWwCHlyyNk5DVUwJCEE2FqbLWbae2ObFDUsCQ6oTYt/xVTF52Z6a4JO4joz841wfd
         +UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700344272; x=1700949072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Sxr/0cg0TxZRHR6aK8VgbLOF1wZHnjhGaQVl3ixHFI=;
        b=bOfPNK6MO+hoDUcTFAq0LFuno1UjQ+y3sRQbeIm67GLzeaV8L8dY6ds+GrEyKHoFsV
         RFdCid1lrTbN9kNMor2hipMa8sFRBeOd5x/ZPbJ+VJdY4b8GbivrYbVnW2RRpq9l/t+M
         C+jyfzBPvvDtzT8999f8a87MnhPU+hegiasENhV4Js/pmSg6QGUZBzl6FgPyFBDQmOBp
         lOzpysuyXu/MccdgAKqpm1HYAPHQaDgjeHM4bGJEyKG4V8/bGf83dwqAWAQaIFpCdfRQ
         xOVRBCUtSQS8Vc6iZkWzpu8O6WjY4jsj++DHjlvEZyGgOHiyw4R3D1lrEAaceTemVruO
         VqIg==
X-Gm-Message-State: AOJu0Yx7Gth7TguYeMjq3dsmFudoxjEcP6+KIr4//ardp+mLZ9gGlyZk
        gHmYJh4Qck7k4NZTTYGftB8=
X-Google-Smtp-Source: AGHT+IFBW03ms2SVzWJ0idpdO5YHqO6UUeWsYN0Xb97W07gJzbyMEt21UBvSnXPxGvaMVI6VuPps7Q==
X-Received: by 2002:aa7:c490:0:b0:541:2476:d23e with SMTP id m16-20020aa7c490000000b005412476d23emr2622831edq.28.1700344272439;
        Sat, 18 Nov 2023 13:51:12 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id s16-20020aa7cb10000000b00544f8271b5fsm2012886edt.8.2023.11.18.13.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 13:51:12 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Rob Herring <robh@kernel.org>, Yangtao Li <frank.li@vivo.com>,
        Yuan Can <yuancan@huawei.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 07/12] bus: sunxi-rsb: Convert to platform remove callback
 returning void
Date:   Sat, 18 Nov 2023 22:51:10 +0100
Message-ID: <4874510.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20231109202830.4124591-8-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
 <20231109202830.4124591-8-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 09. november 2023 ob 21:28:37 CET je Uwe Kleine-K=C3=B6ni=
g napisal(a):
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/bus/sunxi-rsb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index db0ed4e5d315..fd3e9d82340a 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -817,15 +817,13 @@ static int sunxi_rsb_probe(struct platform_device *=
pdev)
>  	return 0;
>  }
> =20
> -static int sunxi_rsb_remove(struct platform_device *pdev)
> +static void sunxi_rsb_remove(struct platform_device *pdev)
>  {
>  	struct sunxi_rsb *rsb =3D platform_get_drvdata(pdev);
> =20
>  	device_for_each_child(rsb->dev, NULL, sunxi_rsb_remove_devices);
>  	pm_runtime_disable(&pdev->dev);
>  	sunxi_rsb_hw_exit(rsb);
> -
> -	return 0;
>  }
> =20
>  static const struct dev_pm_ops sunxi_rsb_dev_pm_ops =3D {
> @@ -842,7 +840,7 @@ MODULE_DEVICE_TABLE(of, sunxi_rsb_of_match_table);
> =20
>  static struct platform_driver sunxi_rsb_driver =3D {
>  	.probe =3D sunxi_rsb_probe,
> -	.remove	=3D sunxi_rsb_remove,
> +	.remove_new =3D sunxi_rsb_remove,
>  	.driver	=3D {
>  		.name =3D RSB_CTRL_NAME,
>  		.of_match_table =3D sunxi_rsb_of_match_table,
>=20




