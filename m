Return-Path: <linux-kernel+bounces-84122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5705686A25D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A09283B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED7A153516;
	Tue, 27 Feb 2024 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTdqBMvd"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679BC153505
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072591; cv=none; b=ipK11bl8EQfS1sNSJMDLIMCuH00GKwcn+cNpKBrh1/aUNrQM9AH82PP83EBQ25gbSxNe7XpvRMzMO1Ahdpb4LyuGCwupsPJV+WQZvGBLIxyE3w7h/WxovXB8t5orN39Df6pa1+4bdz1cjGgdvnUUaepzX6HRkFF+7lTZxkCWLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072591; c=relaxed/simple;
	bh=W987F2lw7DZ6CfZxkj3mmWWtpGRPhagLEMOMFD7lhlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/BMtr5TB21bxL6RaCIsWvB070LkUm8J/ePZZNwRXFvkg4rwfGXvQYh72fJmPBLwRQBKVEZntYdMo5FeUCZLHfcDPwoRa04wyS4tUvgdXNBsYOm0U8QCwNgoGA3a9IMGydsOupnRZ7qEoocVHZx+J9/uquAWbsAoVHQZHs2POZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTdqBMvd; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c7b9b25ba6so103222239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709072589; x=1709677389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T84DJzlc2Vb2bGOPPEYZE74DuxKJ5ir0iAcI6l/RK84=;
        b=hTdqBMvdh6GYZG0YwCXhpjOtQrFyY4woEpL2wZvCjjR9FAmLlh1y4kATkafV5xpkgs
         tWKhzu14BgAMG+pYrerrihj2FwbmdLUuZJfR4neP9AgXVeIF2gpE+XW+UVpDzfY2jqxJ
         244dd0L0hQZgRV5uwljhc4uX3fLFPcboPu1t32CxgDMbN6ozxHah6sUiZRkgkTaMHzrF
         itSdBZc/6T6vYtCzDH3P2E8AxPBNM8fedEoXcRRNI6c42/w8520mqWexquR8KhFauM9w
         DSbxh2YkqGtlx+P7XaDPLhsD1vRWaInzuhvylwH6e5Vax8nJCH9Y1393RSJveLU8y3iA
         Radg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072589; x=1709677389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T84DJzlc2Vb2bGOPPEYZE74DuxKJ5ir0iAcI6l/RK84=;
        b=Te9xdn2nNgxekh+Ex2QD9S5wacfZKi6Vgi2m3/+d4u2YQzLINBjbn3TtIehuok5vF2
         FAHK5Gp6kosTq2OodOW6IQtXEjGBbAawDykz6gUelibbzR/1NKjR8EWAHgwPefy7icyD
         17blKAn/9hAf0U3cuD2N+HYMrEGD81hsW7IUlQIc2Er585qPeU0NdYdrixTUqhSiERHS
         gPf1ZeCEX2kU0u8xgSRLdAuUPriKnZ1468d0GoXfjPPTdrUi9OWK1/y9bZPX8Mzu7Isc
         w8s7+j27r9kXY0vGW0w8N9lIWE5/jfk96NzFCCIXd9kxLxDkV9xZJ5eMcUh8UBzy83lv
         3BTA==
X-Forwarded-Encrypted: i=1; AJvYcCUd4pjNCzFXCuXgkedWUowfs0zfJQ8Lwd2S4L5B7TUa3UCoiIaaugHQUkjnmXT0nRBEBFrLnKiS/CdfZ9xR3QaHASe4Sg25Q2dMpuyu
X-Gm-Message-State: AOJu0Yyq3uZu0Dopz1fqjp6xgGRzq3OwT96E3G+hsgsOwGIOsLosq/Pt
	j/bfK0TrfMzyj4VK2vNGEIXwcOpi9NQl38jgNqpoMIgr4S1oIBPX9Sbmymu4Bdlf53U1rdfH5i5
	9975ruecJtgi/arBjWIxG+JORf/U=
X-Google-Smtp-Source: AGHT+IEq56I5yr0ik9b2MfIeKBMvAOUTaaozwsSphBH4otN9KGlgcKuJuz8rBBaxRE0MJMDJ+pB/UFxJBYdO9rp+RUA=
X-Received: by 2002:a05:6e02:219b:b0:365:1d57:6da0 with SMTP id
 j27-20020a056e02219b00b003651d576da0mr16576687ila.26.1709072589416; Tue, 27
 Feb 2024 14:23:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211230931.188194-1-aford173@gmail.com>
In-Reply-To: <20240211230931.188194-1-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 27 Feb 2024 16:22:57 -0600
Message-ID: <CAHCN7xK-LZHEDrrke80=fO=GN+3wTwAig5_H7JaNW3vt4h1jyw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] drm/bridge: samsung-dsim: Set P divider based on
 min/max of fin pll
To: dri-devel@lists.freedesktop.org
Cc: marex@denx.de, aford@beaconembedded.com, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Marco Felsch <m.felsch@pengutronix.de>, Michael Tretter <m.tretter@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 5:09=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The P divider should be set based on the min and max values of
> the fin pll which may vary between different platforms.
> These ranges are defined per platform, but hard-coded values
> were used instead which resulted in a smaller range available
> on the i.MX8M[MNP] than what was possible.
>
> As noted by Frieder, there are descripencies between the reference
> manuals of the Mini, Nano and Plus, so I reached out to my NXP
> rep and got the following response regarding the varing notes
> in the documentation.
>
> "Yes it is definitely wrong, the one that is part of the NOTE in
> MIPI_DPHY_M_PLLPMS register table against PMS_P, PMS_M and PMS_S is
> not correct. I will report this to Doc team, the one customer should
> be take into account is the Table 13-40 DPHY PLL Parameters and the
> Note above."
>
> With this patch, the clock rates now match the values used in NXP's
> downstream kernel.
>

Inki,

Any change either or both of these patches could get applied?  It's
been several months since the first submission.

Fabio - Do you have an 8MP-evk that you could test to see if there is
any impact?  Between these two patches, it fixes the 720p@60  and
likely others too.

adam
> Fixes: 846307185f0f ("drm/bridge: samsung-dsim: update PLL reference cloc=
k")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> V2:  Only update the commit message to reflect why these values
>      were chosen.  No code change present
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 95fedc68b0ae..8476650c477c 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -574,8 +574,8 @@ static unsigned long samsung_dsim_pll_find_pms(struct=
 samsung_dsim *dsi,
>         u16 _m, best_m;
>         u8 _s, best_s;
>
> -       p_min =3D DIV_ROUND_UP(fin, (12 * MHZ));
> -       p_max =3D fin / (6 * MHZ);
> +       p_min =3D DIV_ROUND_UP(fin, (driver_data->pll_fin_max * MHZ));
> +       p_max =3D fin / (driver_data->pll_fin_min * MHZ);
>
>         for (_p =3D p_min; _p <=3D p_max; ++_p) {
>                 for (_s =3D 0; _s <=3D 5; ++_s) {
> --
> 2.43.0
>

