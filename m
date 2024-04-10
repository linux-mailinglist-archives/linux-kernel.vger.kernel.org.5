Return-Path: <linux-kernel+bounces-138271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA0789EF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AFB283B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82F155A33;
	Wed, 10 Apr 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="udK/rG0n"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D27155389
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742130; cv=none; b=i0BahlUVCPhv12/5mblS8v7kS1drtmtI5jJvrWEWjoOSP0h3kV5SHuqkglOYghkmQ4Xc1SFDLmaMi1THzYcUc7L6lrBBeF8OxcW+PnC1tGZwwXT/zl+t9rB8PV2AS4YuOby1xK2BGQfgjlFHhVwnWogEVew2DOTDkeoEhD56DaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742130; c=relaxed/simple;
	bh=SlWlS7H0aUQSC4n6ZXDLoMoSWHoI0l2KPMobmU3Wrpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzckCcWO+Ed77cbPLKBBL5hDOUEPm9Dns18sHKCX607wkrLJyYYrn0VzSjLGGnMhlr4OqdugS/vci3d+P9RQRB9Rj6saYn9dlfP6q6VLuhjEucrgTn1OSD9ZMaO+somdp3+8cAI/eEgtAYEDOLV8us7a2NBB7m+vtFP938NPFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=udK/rG0n; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a526803fccso1949742a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712742127; x=1713346927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6mq+XWVQezektM76wlJCZqJNDL7tm6/6S+c5eJ1L7E=;
        b=udK/rG0nj7QyF3Yfwm3RA26LrsvQJVY/lWpB7VO0zSO5EnixwuKoKJkVvw1gOTBXgx
         4ExME/D8yXDYfycr6xhSMKFgaefa4yQmXraYL5yENqyGl/EukMMOqGmpy1xeaP+iUo4/
         juvEhWXRiMAwYSi36ArNTwf3aK7UxcmFfcmXybd1ZxvubPnX9ENfULIDIIr7QyeS9ndT
         mtnwCraKqFD0t/TNJAZG/I+I9Us+S9SgYrUjR4UqjKf06zAxi0vb2l18n3mUMKl7lKv9
         s2YioLZACBdo2twjYB7slUjNDjQF8+7Ym3MijhEi1hB70pKlFkIa5NWmhxzxCadi2BoF
         vNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712742127; x=1713346927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6mq+XWVQezektM76wlJCZqJNDL7tm6/6S+c5eJ1L7E=;
        b=Z4c6boeKJ24l7DfqclAaaK+Ii1mS36ahBD9o4MUCgjW/g+QINv05n2YTLTgBLu8LyG
         9HTw7J/q6yHssB3ZgdN5a/CjthqleIsA1dZjtUOyMwOa8EK8KBMhCseenosa8JEeHCGM
         i50nk34X1rIZ0w5abmuwmoZLT12x54/XDUJNfL5F5TJy5c3ibKpoLloK1K65f1EbxX5T
         tT68E078TlR/GRWgrcjokZFpnpvkQfJDRLVLQ0ShMd+ngtlIeDcDfVPiRnrJ+/m1cAZT
         96fiega0JyZzX5oCWX9X0DjDCb9uU2+sDMijvG/8buS/iqn316lsEtqpxA7Beu/9aVkW
         SIdw==
X-Forwarded-Encrypted: i=1; AJvYcCWM98zFkVjKHvFkIG67GN/TqPpcgwhzz9Yp3YDvQsYey1H6SVZarnO5c4aUF4BXlky0hEBDBKp/IGtwcBZyFdKIrxsbSYoSOLobC3Z6
X-Gm-Message-State: AOJu0YzSI8ucClNQ5l29CX8Kx8QzSzJ7depoGdNDazcJ3lgnIwgzHz/M
	R9EN41Yj170vjbX/KNXSJ0iVzUuMaArEjZh/nFG24wCaHrx/CdfV5Y0aA1xZ0Nl/LO+LF5q95lm
	/G5VEQrevMnNFCjVw7iHKenoo21jd0IhiviihCw==
X-Google-Smtp-Source: AGHT+IGxW+1SQOW/hjBi7o8UbjyT2DcaFkvuNfI2f6FK1ZRsStq18tyXZyZ9KYXHh22zEmmhmUKOswcUmQ4A1Q7/6qI=
X-Received: by 2002:a17:90b:3b87:b0:2a0:4495:1f3d with SMTP id
 pc7-20020a17090b3b8700b002a044951f3dmr2595254pjb.0.1712742127619; Wed, 10 Apr
 2024 02:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
 <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-4-99ecdfdc87fc@linaro.org>
In-Reply-To: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-4-99ecdfdc87fc@linaro.org>
From: Nicolas Belin <nbelin@baylibre.com>
Date: Wed, 10 Apr 2024 11:41:56 +0200
Message-ID: <CAJZgTGE10CZiHvahxDu2mf8C0JS9UgQ_x-XCH-G8Vvjfp3CUCg@mail.gmail.com>
Subject: Re: [PATCH v12 4/7] drm/meson: gate px_clk when setting rate
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jagan Teki <jagan@amarulasolutions.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 3 avr. 2024 =C3=A0 09:46, Neil Armstrong
<neil.armstrong@linaro.org> a =C3=A9crit :
>
> Disable the px_clk when setting the rate to recover a fully
> configured and correctly reset VCLK clock tree after the rate
> is set.
>
> Fixes: 77d9e1e6b846 ("drm/meson: add support for MIPI-DSI transceiver")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/=
meson/meson_dw_mipi_dsi.c
> index a6bc1bdb3d0d..a10cff3ca1fe 100644
> --- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> @@ -95,6 +95,7 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
>                 return ret;
>         }
>
> +       clk_disable_unprepare(mipi_dsi->px_clk);
>         ret =3D clk_set_rate(mipi_dsi->px_clk, mipi_dsi->mode->clock * 10=
00);
>
>         if (ret) {
> @@ -103,6 +104,12 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
>                 return ret;
>         }
>
> +       ret =3D clk_prepare_enable(mipi_dsi->px_clk);
> +       if (ret) {
> +               dev_err(mipi_dsi->dev, "Failed to enable DSI Pixel clock =
(ret %d)\n", ret);
> +               return ret;
> +       }
> +
>         switch (mipi_dsi->dsi_device->format) {
>         case MIPI_DSI_FMT_RGB888:
>                 dpi_data_format =3D DPI_COLOR_24BIT;
>
> --
> 2.34.1
>

Looks good to me

Reviewed-by: Nicolas Belin <nbelin@baylibre.com>

