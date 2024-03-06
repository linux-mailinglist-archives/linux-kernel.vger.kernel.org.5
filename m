Return-Path: <linux-kernel+bounces-93263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80D872D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA324285B53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAE2DF49;
	Wed,  6 Mar 2024 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VSIZXhl7"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869336FBD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694461; cv=none; b=A7Uee92gGFVKnGSWZUFGAHff/Gd8VdqrzN8LjNzf5jwyv/0wTOUXqBc6v8dYvKLsQ4w6n8JmMBPhb/FoFVKHdaYvae/5o84Abk1a8iZnAv6rJC7NubuprgMlHtTJc4DU1yP+Pcw2pRFw/JAfGSXyFa7rgINaxaspENfeQ7F+htQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694461; c=relaxed/simple;
	bh=6B1nkuOxoST/+lT2hJKGS+JnQ1uuTVGEHk5JkbzMaMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXTqm21Ysem4b9JgkV62gWcd8dkjwYn+2yII9lCmZ1RAlC9y2oFhv7CgYhH84GfUTChboM5odCSClIdrWZbHERmd07XoFzbk8SrjY1JstMcb9f8pKHtQ6a6paXn77BhRecFKM7bDVUWWUZ+WffQhBb3poFlke2TQ59BBUPOhWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VSIZXhl7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so91727521fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 19:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709694457; x=1710299257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3G5ilIgHzJp9EnFwdcrT7Tr1Dh0x/+SLzMuY+cXrdc=;
        b=VSIZXhl73Qt11fRTHrwMG24y89AHLhWlo+7Swvx5TksNxwuo/z+XGuHZKZ870QdYOf
         gtoKEvXX+vbGbM9TAmikuBdU5Yjgnqm5OA1ZFWP1Px9AzW9wnXC0SS5MbWEHI2z2N3GL
         /+b3GPkHbe9e/siHx7qq3vxVbnyU4iuAjHhyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709694457; x=1710299257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3G5ilIgHzJp9EnFwdcrT7Tr1Dh0x/+SLzMuY+cXrdc=;
        b=duGuYs5xQ3hvo3IlR0xtn2Sr3MmtBWqA37UxILmZ6dTRkwUfIrZfMl+4bwHidPUvcH
         wCnUXTcHdd/Qygq23booqkYwnoQrC2NKwDBNyIH6PeDf++mYpcvbALMBovoQU0BweOva
         DU5WK7SOJEVsgwTt9dHFuCp8Uq3HnwaASbBPGnmu5dwb97sVSlynIAXEK686EXOPQf+N
         3CTCksBPVnh8uORHKHn+4ghHDsIpWIUIyXPMTKL7U8xWAGZazrueB+9MRKcruQwD3rXy
         ML/soxmJYF9uuUTvpNPGtvu2Q2vnSGejIVp6mY0iybtK+vpGBCmd99P54x4UcvIkur41
         9HwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzDYpildDJfNXJCCidSoMsB5hHMf8+J3xGxXsivYBg4pRzlz4FTN8RE5vhSAzYzj2ti8IX4S74Z2mLViiZfEXz9MG/UxevR0rBDwU4
X-Gm-Message-State: AOJu0YxhxnYCInI2Wcci50iQXClvi1RqvsK4C7NqIsW4cG5vk4gZyNVH
	NgRm8+KW07Y//TWymz4Lm/J5RUp7zvhFtrFK3wy6YMD4VK3w/Jr4DoYSgM0gVsjS/JZA9IZIfL2
	wIAq+7fPF32YEgzuRhFTPwkJZm76zLUdFpZHt
X-Google-Smtp-Source: AGHT+IFd4fYrH7VT+oC7ZfIpSRkqSnwMMbSguOpGCTPqEmdBUEJov0MCaZASXOwtSpdb28dWKW8lrLtkXDn42JRqQ8M=
X-Received: by 2002:a2e:9e16:0:b0:2d2:d32b:dabf with SMTP id
 e22-20020a2e9e16000000b002d2d32bdabfmr2332926ljk.22.1709694457516; Tue, 05
 Mar 2024 19:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305-anx7625-v1-1-83ed3ccfa64c@chromium.org>
In-Reply-To: <20240305-anx7625-v1-1-83ed3ccfa64c@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 6 Mar 2024 11:07:26 +0800
Message-ID: <CAGXv+5GdgECuCeXGX3MJJRMr3XyMdZkJPyH7e5V+041ViQEi-g@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge:anx7625:Update audio status while detecting
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Please add a space after the colons in the subject line.

On Tue, Mar 5, 2024 at 8:32=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.or=
g> wrote:
>
> Previously, the audio status was not updated during detection, leading
> to a persistent audio despite hot plugging events. To resolve this

                       ^ it feels like this sentence is incomplete.

> issue, update the audio status during detection.

Please add a Fixes: tag.

> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index 29d91493b101a..9f0d0c5b8ebf5 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2481,15 +2481,22 @@ static void anx7625_bridge_atomic_disable(struct =
drm_bridge *bridge,
>         mutex_unlock(&ctx->aux_lock);
>  }
>
> +static void
> +anx7625_audio_update_connector_status(struct anx7625_data *ctx,
> +                                     enum drm_connector_status status);
> +
>  static enum drm_connector_status
>  anx7625_bridge_detect(struct drm_bridge *bridge)
>  {
>         struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);
>         struct device *dev =3D ctx->dev;
> +       enum drm_connector_status status;
>
>         DRM_DEV_DEBUG_DRIVER(dev, "drm bridge detect\n");
>
> -       return anx7625_sink_detect(ctx);
> +       status =3D anx7625_sink_detect(ctx);
> +       anx7625_audio_update_connector_status(ctx, status);

Nit: add an empty line here.

> +       return status;
>  }
>
>  static struct edid *anx7625_bridge_get_edid(struct drm_bridge *bridge,
>
> ---
> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> change-id: 20240305-anx7625-fe16d3a9d37d
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>

