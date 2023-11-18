Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C56C7F030E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 22:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjKRVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 16:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRVuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 16:50:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D627192
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 13:50:36 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9d10972e63eso431931366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 13:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700344235; x=1700949035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIuycvwcOtzj5a92tHoVOAi7oenZudHbZIioAcVhUH8=;
        b=iO43L0XGFqCJlmP21QHBqfH40cSOZFcUBg9fGGAg5H7cCyuuwl3npcmjrVcl+an7/+
         Og4XXDfGixq5BF8qbBLetM0CzKM3WaHN1oBMVbeus5xbX6Raah4OEAEUvkvLmSDVvqyO
         gj2TlA/tEp1uClVOk3i67tGBQSET5v5GhTsma42PaNW4pTJfHN3MBx5z8aZ/OoFpFsck
         LS80uPNujvHWatUEGgaje6aXgV9zAuy7QYBhozDGMgDlvL+ojkKfknRJNVfIOoX9YERN
         5r+XlzSKvd3R+jw13gss7/rZfBexCI73V00elXPQBGnkFnYdgRPpGe20GLXKrDOPnE/K
         IJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700344235; x=1700949035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIuycvwcOtzj5a92tHoVOAi7oenZudHbZIioAcVhUH8=;
        b=fnTHFD9Xytcka0nDltp1hJsrmVJa7pZUQWClv+8+UR53ymsCO0dHXSBUekzWWE23I5
         B6gtOa2Q525IZ41BTyPobk3u6I7Wdvyw1khC2bemiRMu7s+/V/uO2gm+kNDam4aAGHzY
         VM/qqifIuka6VPji9bmpMr5oh+QBw+L+WzpUE9HiMbmlbjw+RmR9Edtl5MahI5DS92H5
         Lk+3oY3yDGfbjV2Z6b1Jl4yU/5N2M5GBHomFv7Dtm04qV3SGJmerZ7BH2Jg24OP+fQdh
         OgXPZWLinoRl/SWUqHOhDK0tZ+gCSvUoV+dnSe+sOoW8XVAMM3RMjdFeIgwEsJcqd6Bi
         bAbQ==
X-Gm-Message-State: AOJu0Yxt+DWR3pZVptOy2vUKKrz3f8e7T9otvHNlev3qFG3Ph6VSiP2O
        UdMnMQRm2V/FfR+1JkiPwzI=
X-Google-Smtp-Source: AGHT+IHiK+AbaxW1Wc75IyiNhOW9ArhXV2tF0E1iEFOC758dB4Re3ICn5guoVvHiY5DBe7czrLcFtg==
X-Received: by 2002:a17:906:4356:b0:9c7:4d3e:1e50 with SMTP id z22-20020a170906435600b009c74d3e1e50mr2139036ejm.76.1700344234769;
        Sat, 18 Nov 2023 13:50:34 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id m8-20020a170906234800b009bf94de8971sm2250339eja.70.2023.11.18.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 13:50:34 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 06/12] bus: sun50i-de2: Convert to platform remove callback
 returning void
Date:   Sat, 18 Nov 2023 22:50:33 +0100
Message-ID: <5727528.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20231109202830.4124591-7-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
 <20231109202830.4124591-7-u.kleine-koenig@pengutronix.de>
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

Dne =C4=8Detrtek, 09. november 2023 ob 21:28:36 CET je Uwe Kleine-K=C3=B6ni=
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
>  drivers/bus/sun50i-de2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/bus/sun50i-de2.c b/drivers/bus/sun50i-de2.c
> index 414f29cdedf0..3339311ce068 100644
> --- a/drivers/bus/sun50i-de2.c
> +++ b/drivers/bus/sun50i-de2.c
> @@ -24,10 +24,9 @@ static int sun50i_de2_bus_probe(struct platform_device=
 *pdev)
>  	return 0;
>  }
> =20
> -static int sun50i_de2_bus_remove(struct platform_device *pdev)
> +static void sun50i_de2_bus_remove(struct platform_device *pdev)
>  {
>  	sunxi_sram_release(&pdev->dev);
> -	return 0;
>  }
> =20
>  static const struct of_device_id sun50i_de2_bus_of_match[] =3D {
> @@ -37,7 +36,7 @@ static const struct of_device_id sun50i_de2_bus_of_matc=
h[] =3D {
> =20
>  static struct platform_driver sun50i_de2_bus_driver =3D {
>  	.probe =3D sun50i_de2_bus_probe,
> -	.remove =3D sun50i_de2_bus_remove,
> +	.remove_new =3D sun50i_de2_bus_remove,
>  	.driver =3D {
>  		.name =3D "sun50i-de2-bus",
>  		.of_match_table =3D sun50i_de2_bus_of_match,
>=20




