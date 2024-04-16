Return-Path: <linux-kernel+bounces-146760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7738A6A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74AD2822D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FC812AAF4;
	Tue, 16 Apr 2024 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCyyr7pv"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898E12AAC9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269725; cv=none; b=nw27sv7vsMITO5hgsrfNaPKE2nkZJvPAOZsVNdKkO89MR9IZpLgoBBhgtKZzqPci/o7HS8TF0J1UMHQxvpWjNGZsPsHxW/ZPi9a18RekaMyynQmSxKmZN/Ku32CIbczTkNxAztll9hCKrY+E1gWC2H66dlGvMRb5EoPkKheiwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269725; c=relaxed/simple;
	bh=wrKI7QZ6HanmjwtzPADRvU6WaXyrFt9p6yXSrd3Udu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzQmhZrH/vZCfFy1sE6BlvpHyl4jz26scLMPXwDJJ4SiCsopwMWwMXfIiOgEkaYxlxpFHBn6l09aY8YH4W/ZvBCCRcyUJHWKkNVWtiUDWxfX44NyNJvIYwiREuzhz4NKY6syG0rLCLuIn88woE8CNySf+7865c6p+sAXMSZB/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCyyr7pv; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so2829667a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713269723; x=1713874523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlWFv7cOcND2wnTqRNzMBr2pMz9vnQZWAIMjfeiHzPY=;
        b=SCyyr7pvkiW3U1u49nwW/xzY4yN0hrZaQ8l0pC4bO6gb2h/BLaz6Au7luNhlzRQIQf
         ei/ATG1ovBIU3Nsz1aoKQ7yYjeS6tL3JvTfan/QMhZlY06B4dqhjuc4d/8F7D7jfd+VN
         mFNJl3noiXwuc1GTXa0QRbMeiZuv0iiYS/D7gbt7Qm5snf1ny/gIOGOHGXGfhNm42qkv
         F21bCc9cIJegyT/iwcZtF+ls85nc7hIzb+Rfsol1zFKAiPfSJYeIHoI5Yfn0SEevksA5
         KD4gTc+/wYI5aDUN9vnkkOG/W7qa6am5OhMKvSuSrTIBbTCJzdnzvzRrOFEQ46QpZ5N8
         dxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269723; x=1713874523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlWFv7cOcND2wnTqRNzMBr2pMz9vnQZWAIMjfeiHzPY=;
        b=Ix9YtCucRlj197dLTTrZ2HU87+QBEF8ykH5didlP78EtlI2E5eKD1iO9RA6gjOfCwc
         xyH51jDlfFbGRoW9mR0od7sqLzjR/Q6F/X8aUAtWAbnL/rjds2MBYfDDRVYzuy12424Y
         sRH0Go3u2dW+f4gTOf7QanrRjMIBxqeRlFxkiCzZS0vnvlLjiMbuubeCOU8HzG/LDemE
         xvw22HpdLpvliu/lmwCPmp0gLFb9sOP7kU+Jjdm8wSvkHHot33bxkCRJ7vP0AKl/w6uY
         e7wujKwZqROV7CI47omDX4UEbQ9rJ2S5mEE4y/EeZdKgHCqLq/WZ45C9xsKlNln0oPN2
         jPbA==
X-Forwarded-Encrypted: i=1; AJvYcCVi1zSfJYFgrYnKGZveTXLH4A4TlRSF/Z4zANscekEolE5OJLgdY3WTsNTdSj0z0TFDUylcc9y9281jMmMvdMdCjGxPGQ8zhOFUKkkD
X-Gm-Message-State: AOJu0YwSOIzQ82cTr41nPDqTqtKBKdSZ+xGRcMawYNLHon/LkR5efAj3
	Vskq/2xE1PybHM1DqOWjNIMMOmLc7voeMwWo2uMYlqXYOMlqzLGBxHGHS6FFUq0q0GxiHzjqe6A
	qp0pdGcAc2G/jyir8dKT/m5QqLvM=
X-Google-Smtp-Source: AGHT+IG9hOFw3v1uT3o6QNr5qi+vZ+K75rWTQ53HPPqtkAcjF7Uht+4xETvra13YCmgVQ5ljS387JCgjPcZmuOU008s=
X-Received: by 2002:a17:90b:4b48:b0:2a2:227a:50fc with SMTP id
 mi8-20020a17090b4b4800b002a2227a50fcmr9557932pjb.41.1713269722636; Tue, 16
 Apr 2024 05:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211230931.188194-1-aford173@gmail.com> <20240211230931.188194-2-aford173@gmail.com>
In-Reply-To: <20240211230931.188194-2-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 16 Apr 2024 07:15:10 -0500
Message-ID: <CAHCN7x+9YUj9xW-ytUqPeQBdwaRE0T5VVJyiL9cTss-EyihK8Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
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
> When using video sync pulses, the HFP, HBP, and HSA are divided between
> the available lanes if there is more than one lane.  For certain
> timings and lane configurations, the HFP may not be evenly divisible.
> If the HFP is rounded down, it ends up being too small which can cause
> some monitors to not sync properly. In these instances, adjust htotal
> and hsync to round the HFP up, and recalculate the htotal.
>

Marek V and Marek S,

Would either of you be willing to test that this doesn't break your
applications?

thanks

adam

> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.=
MX8MM with HDMI monitor
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  No changes
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 8476650c477c..52939211fe93 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1606,6 +1606,27 @@ static int samsung_dsim_atomic_check(struct drm_br=
idge *bridge,
>                 adjusted_mode->flags |=3D (DRM_MODE_FLAG_PHSYNC | DRM_MOD=
E_FLAG_PVSYNC);
>         }
>
> +       /*
> +        * When using video sync pulses, the HFP, HBP, and HSA are divide=
d between
> +        * the available lanes if there is more than one lane.  For certa=
in
> +        * timings and lane configurations, the HFP may not be evenly div=
isible.
> +        * If the HFP is rounded down, it ends up being too small which c=
an cause
> +        * some monitors to not sync properly. In these instances, adjust=
 htotal
> +        * and hsync to round the HFP up, and recalculate the htotal. Thr=
ough trial
> +        * and error, it appears that the HBP and HSA do not appearto nee=
d the same
> +        * correction that HFP does.
> +        */
> +       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->lane=
s > 1) {
> +               int hfp =3D adjusted_mode->hsync_start - adjusted_mode->h=
display;
> +               int remainder =3D hfp % dsi->lanes;
> +
> +               if (remainder) {
> +                       adjusted_mode->hsync_start +=3D remainder;
> +                       adjusted_mode->hsync_end   +=3D remainder;
> +                       adjusted_mode->htotal      +=3D remainder;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 2.43.0
>

