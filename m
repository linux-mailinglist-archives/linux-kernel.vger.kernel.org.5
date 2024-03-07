Return-Path: <linux-kernel+bounces-95014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EF8874825
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02684B21662
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4FE1CAAD;
	Thu,  7 Mar 2024 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9UMZa/F"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7591CA8A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792680; cv=none; b=ig/8Hf97WWHThc5ba6qUj1k50iOVlaPJLXiVsI+X9ztQ+rWEh7VaBoBGvujUUDy1nb3Oiyj6Z1g4b3kn1Ni5f79JppeokgQQkys4GOd+RFUZX7HQs3oz5l1qyXGNOWKpRvl8/gDEimDtO9lThcMBYzTwpj/XSOiXoSqUs6neNAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792680; c=relaxed/simple;
	bh=BhEIhzNEdJb6eH1u3NWSXY6vsbNzA8dmMw1+NV+QvqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4V1RMKAZraQwFVVcV/nN4O5QcagXdsVMN4BYj1+HN8vIky70ae1KO+ZulelRrO9vLFE+41EnLInKipHH6rUFT2t6uSCGfUASvCZkTNfrUHkALuE2fTzhFc63+jbW7Qjk/FTmgOXB2r4I26AfoBg0gMZVeB1mPot6+xgOGJWI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M9UMZa/F; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d3f962a9dfso4541691fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 22:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709792677; x=1710397477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJJx6XhDRfgPt/8OwU1WYfWX5sGRnhgvN/CrlZDuL1I=;
        b=M9UMZa/FOyXH7sre2zOAov7cQeeHozAIrb5a81LFagFBZ1HJvszWMPbAJ1kMaYTmpS
         M7UH3Q+snyZ9CMCQfRTpS3fA4USzmjdU0ZtjSj3wVe1rSwVc8XDtBv8KJYT8yRmn9s4x
         MUfIQ3+imciOiNbfV6f0JWkERrtwzowAQ90SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709792677; x=1710397477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJJx6XhDRfgPt/8OwU1WYfWX5sGRnhgvN/CrlZDuL1I=;
        b=vOMKDsJx4k4P3ev6b+EyDI503IVI4fitgAYSAnd5vgYbIaR2mlF1KYKqbhxiOFhGu3
         grD//btJ93nd2PW+tp0c7FOPYaSEVeIo6tetQ/cUzRgPcH/r/ND4pAaFfzPuwSrJyotX
         TIFhJ1HMIS2yjUXjkFOjn/8niyQ3x4TItGC6woDJJzBAsgcWI17ajwKSag8GGfVE8uAS
         Zg7AWsxnsTz053iHwueK8QYvev7Jvm5nb3YKQu6Y8h+/FjANhKyAReM96SLC9JgU3iMJ
         BuXjmGE5vhGheLTWwyH5WbqzKYxL9IbDji7x5Z5EBIWgtKkluxxKyztBJSjJdiAzaXP0
         0EYA==
X-Forwarded-Encrypted: i=1; AJvYcCWCIghakh44ql/ZQ3WhuqQkDpUfbq4ixQbVGbAl/Q1p3ZYrA2UbZA0oieg0ZapD+/lwUg/FDyPwTTwCSnz2SHFFy/8ERvL0W1wXG03J
X-Gm-Message-State: AOJu0YwD2ktK0kcJGqOlu4pIr7PgdeIPSX5s5T5IEFwl54m+KGhlbx+7
	jztilPVJlKa3hePTWZeuS8iRrqz+z577UTUzpD9XtsQvazjUzg+O/sPk5mrmmaSb1rotdfbHByB
	aysrp5FNdtbUruhXQ2bkhlswO/mSn/7+1RcD/
X-Google-Smtp-Source: AGHT+IG9bL7mKM9ZtwISH72C9rWzwjWBxEKgo4y0KjtnQ28PVSCnbnBN4WWhE3QRZh9KOHDhdEgcunbfDEypG1Rp+yk=
X-Received: by 2002:a05:651c:198c:b0:2d3:ffa0:8782 with SMTP id
 bx12-20020a05651c198c00b002d3ffa08782mr718856ljb.43.1709792676971; Wed, 06
 Mar 2024 22:24:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-anx7625-v3-1-9034263bf530@chromium.org>
In-Reply-To: <20240306-anx7625-v3-1-9034263bf530@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 7 Mar 2024 14:24:25 +0800
Message-ID: <CAGXv+5GWjChTxLaTXiq5JnwFmWu=hg6Gy6+qjYxofXqVXxETPw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: anx7625: Update audio status while detecting
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 5:59=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.or=
g> wrote:
>
> Previously, the audio status was not updated during detection, leading
> to a persistent audio despite hot plugging events. To resolve this
> issue, update the audio status during detection.
>
> Fixes: 566fef1226c1 ("drm/bridge: anx7625: add HDMI audio function")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
> Changes in v3:
> - Add Fixes tag.
> - Link to v2: https://lore.kernel.org/r/20240306-anx7625-v2-1-7138e00b25b=
f@chromium.org
>
> Changes in v2:
> - Add a space after the colons in the subject line.
> - Link to v1: https://lore.kernel.org/r/20240305-anx7625-v1-1-83ed3ccfa64=
c@chromium.org
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

