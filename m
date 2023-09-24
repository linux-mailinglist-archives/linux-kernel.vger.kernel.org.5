Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA37ACBC6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjIXUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXUBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 16:01:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FFBA6;
        Sun, 24 Sep 2023 13:01:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bfea381255so85964581fa.3;
        Sun, 24 Sep 2023 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695585688; x=1696190488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/sEzFSU1WeZTVMeaZJF4z8FtiU96nb3S95OQlSjSS0=;
        b=J04It9k9+XJZJ1aGzfPobSFbmASAnh3nI9LdU1IO6rZ8yPcb9N64fiOu43oSZ/TUYB
         mgu+t0utjIrmyl6l8O4PTJtZc6upAUeR/vI7q3JosOgxs6WR+yiZxSAeuFfev64DNrdf
         bhJuEY0ljY/dXHwzvo6fabHHV0KPJEnRyjmYmwxwIDZT3mZBEBvDgvlxGZhlIOvmjFQD
         yp/BtFreRquq2ac96AHGtotqJWpkbvbsQivLKAHy7eiLDODfBp5BeWdCc6YaZFAXHc5q
         LbKfpzf8ya8DTl0i4vxua+9CGOD3TmRDNcFcmZggiRWlV6MwfiiBR37groVW+XcfsvkP
         6cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695585688; x=1696190488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/sEzFSU1WeZTVMeaZJF4z8FtiU96nb3S95OQlSjSS0=;
        b=Ew3Khn7lnwbSAOt/Kg+QbVExcAsVcSdm8B9C2ACEQ3PyIju8ZyrMyrWNbBEG+104eI
         sDGL8mGHp5S1HmlNJpvcgZ8NJU+7IfD6rg2b7mijVaVvcOGUnPEM4UQtJyH5/Q1KhP2A
         xb143Kp4y/Lth+ns0o1xk9A0qAj2O4pY1Hwhwv/v/gl6tlmpl7G+ONCx0daCBQ+xmgMj
         eLXFPkXRdi0kU46Cq3qEnd9+2lhK/Wz8lT/2VCsylF/OYzvQMT0IDgbEni5syPDogLg7
         whlYok3m/iBNWYs4V3PNRgi4K93jIwWYEKpVUGjpWEDMg/mUO+Dunkk7GNQcgp0MGCUZ
         xTzg==
X-Gm-Message-State: AOJu0YyROiLKdFeo1lCM6xFOzQ6GhL1MkN8kcZAW9fOHzWegt55trMok
        +YV63+jlNI17E4kFo9iF4qY=
X-Google-Smtp-Source: AGHT+IHXra175J8cJCP1mYtvO6y1HC5Qd13x962DSEgj/v3iYxK9Qz6wXvUiRAobb0w7iX71A52zWA==
X-Received: by 2002:a2e:b78f:0:b0:2bf:cf44:dde5 with SMTP id n15-20020a2eb78f000000b002bfcf44dde5mr4102294ljo.30.1695585688175;
        Sun, 24 Sep 2023 13:01:28 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id l15-20020a1709067d4f00b009920a690cd9sm5340296ejp.59.2023.09.24.13.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 13:01:27 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] phy: sun4i-usb: Fix a W=1 compilation failure
Date:   Sun, 24 Sep 2023 22:01:26 +0200
Message-ID: <3520089.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <0bc81612171baaa6d5dff58c8e009debc03e1ba8.1693735840.git.christophe.jaillet@wanadoo.fr>
References: <0bc81612171baaa6d5dff58c8e009debc03e1ba8.1693735840.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 03. september 2023 ob 12:11:06 CEST je Christophe JAILLET napi=
sal(a):
> With gcc 12.3.0, when this file is built, we get errors such as:
>=20
> drivers/phy/allwinner/phy-sun4i-usb.c: In function =E2=80=98sun4i_usb_phy=
_probe=E2=80=99:
> drivers/phy/allwinner/phy-sun4i-usb.c:790:52: error: =E2=80=98_vbus=E2=80=
=99 directive output may be truncated writing 5 bytes into a region of size=
 between 2 and 12 [-Werror=3Dformat-truncation=3D]
>   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
>       |                                                    ^~~~~
> drivers/phy/allwinner/phy-sun4i-usb.c:790:17: note: =E2=80=98snprintf=E2=
=80=99 output between 10 and 20 bytes into a destination of size 16
>   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Because of the possible value of 'i', this can't be an issue in real world
> application, but in order to have "make W=3D1" work correctly, give more
> space for 'name'.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinne=
r/phy-sun4i-usb.c
> index ec551464dd4f..e53a9a9317bc 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -782,7 +782,7 @@ static int sun4i_usb_phy_probe(struct platform_device=
 *pdev)
> =20
>  	for (i =3D 0; i < data->cfg->num_phys; i++) {
>  		struct sun4i_usb_phy *phy =3D data->phys + i;
> -		char name[16];
> +		char name[32];
> =20
>  		if (data->cfg->missing_phys & BIT(i))
>  			continue;
>=20




