Return-Path: <linux-kernel+bounces-29700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49BA831200
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B162821ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE56C7497;
	Thu, 18 Jan 2024 04:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WHj93cAr"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3A6138
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705550735; cv=none; b=k1mtTq0YoYfOz0Jfqsz6wDAzC1tTUVecVNqkEkyqiyKSgY5A5kf3p407oA53lWLwOlNo7+4DAp3CXY7G/3gwwTs66wNRabfDDOuvVXXfOaASNqSildPDGx1yel6c9PYDNegVdyCV/h21j3qHiRA2O5zd5FG+HXKntmxhaUBdieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705550735; c=relaxed/simple;
	bh=IERpslg8SjVtS8I8A3Q+sRIZxC9LSYkmeCcMh4SOxes=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=MN0s88t4pEKNItpVy0NhOXKnbGWiMV+DInuOIVWqI24jblFXeRCVrKZEkVtSmjpEFi3JOLvB7ELbI7x0xNk6Miodx6k2NY2mUyFzGtFZWr2tHMB7CCMM++6IdzFgdcNAgsCPx/akbtJluDzCZVDMIIrfM36xc2kSHvy/xIdxX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WHj93cAr; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3608402ab93so43164855ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705550732; x=1706155532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asTdxJmyObxm04mvJhTbWbygZcovAb5nq215Cf2XjJM=;
        b=WHj93cArTfGurb52ta4Eves8Mr2GNOXlOh4qiAfk9lrflH7bgXzpZwncxfPgEM+iuX
         A7v/PKPissRUivtQ4dg4KE4mxY7ZE6G00PFenGBx+UoaOKrnITPUJihHr/4OJ+DQoWyg
         cFV1VVTWWSKBpuRLGB6TmlgJg1S8WOBymzm8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705550732; x=1706155532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asTdxJmyObxm04mvJhTbWbygZcovAb5nq215Cf2XjJM=;
        b=aL+qbbD4RL+xJMtQrI9hTXES2jJPxSYNcbdTzg01FrOPoPbRlfX9JtWdmemR3tGHHB
         U8Q72g1UajvUfoY0uaskhbo6RApJYDF5VPdA5CCTy8ru61j0AoHLqloEoZwVL4dHtlOz
         NT13B6HXYZHYjnfKLbDgcvAqXzvteWykQeWc4fnmfoFkDQIzeoHje7j4BkOT0VXSG3Pv
         BQjtrlNlbhnrhPo8TBZEhT/IHcsKfgzXhqyCx9EBAMAxH5y+KeyYh2RlJE28uwdp7Jmn
         WS2W+GHM9J7Z0n+1eY+Kc8WF5lUqspNZuCRkMx2cDVv3j8iA9V/CyW2btVag05qsxffG
         wJUg==
X-Gm-Message-State: AOJu0Ywx8IHhk1uRi28iAUiNNj1BqlrTjOeeGBLkIiAt5jRamrPsagFl
	Ns9h4m1VRGSOSIcyISs/xIK0/2XA4rRJSBfb0wDf8x/0jmhlPTJ4qJ+96YZeGieyXgamUCjay8p
	jyu1vkI7Y7t3rqR8pGaN9LWwiZez2cTmf/bsr
X-Google-Smtp-Source: AGHT+IG5ucfMFmFlTrDHrJb/JovTtn4mj3zDimrIQZlTx0qfYqVqP/F+o9BhS85iZH+iMkRwjUKlwP4UzbmWo0pSqPo=
X-Received: by 2002:a92:c10a:0:b0:361:9554:d307 with SMTP id
 p10-20020a92c10a000000b003619554d307mr372847ile.45.1705550732669; Wed, 17 Jan
 2024 20:05:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118015916.2296741-1-hsinyi@chromium.org>
In-Reply-To: <20240118015916.2296741-1-hsinyi@chromium.org>
From: Pin-yen Lin <treapking@chromium.org>
Date: Thu, 18 Jan 2024 12:05:21 +0800
Message-ID: <CAEXTbpc2JUh8-_4sqJEGYXH-4QCuTJgRDviPVwv=3Kz_tfxjow@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Ensure bridge is suspended in disable()
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-Yi,

On Thu, Jan 18, 2024 at 9:59=E2=80=AFAM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Similar to commit 26db46bc9c67 ("drm/bridge: parade-ps8640: Ensure bridge
> is suspended in .post_disable()"). Add a mutex to ensure that aux transfe=
r
> won't race with atomic_disable by holding the PM reference and prevent
> the bridge from suspend.
>
> Also we need to use pm_runtime_put_sync_suspend() to suspend the bridge
> instead of idle with pm_runtime_put_sync().
>
> Fixes: 3203e497eb76 ("drm/bridge: anx7625: Synchronously run runtime susp=
end.")
> Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid through a=
ux channel")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Tested-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 7 ++++++-
>  drivers/gpu/drm/bridge/analogix/anx7625.h | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index ef31033439bc..29d91493b101 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1762,6 +1762,7 @@ static ssize_t anx7625_aux_transfer(struct drm_dp_a=
ux *aux,
>         u8 request =3D msg->request & ~DP_AUX_I2C_MOT;
>         int ret =3D 0;
>
> +       mutex_lock(&ctx->aux_lock);
>         pm_runtime_get_sync(dev);
>         msg->reply =3D 0;
>         switch (request) {
> @@ -1778,6 +1779,7 @@ static ssize_t anx7625_aux_transfer(struct drm_dp_a=
ux *aux,
>                                         msg->size, msg->buffer);
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_put_autosuspend(dev);
> +       mutex_unlock(&ctx->aux_lock);
>
>         return ret;
>  }
> @@ -2474,7 +2476,9 @@ static void anx7625_bridge_atomic_disable(struct dr=
m_bridge *bridge,
>         ctx->connector =3D NULL;
>         anx7625_dp_stop(ctx);
>
> -       pm_runtime_put_sync(dev);
> +       mutex_lock(&ctx->aux_lock);
> +       pm_runtime_put_sync_suspend(dev);
> +       mutex_unlock(&ctx->aux_lock);
>  }
>
>  static enum drm_connector_status
> @@ -2668,6 +2672,7 @@ static int anx7625_i2c_probe(struct i2c_client *cli=
ent)
>
>         mutex_init(&platform->lock);
>         mutex_init(&platform->hdcp_wq_lock);
> +       mutex_init(&platform->aux_lock);
>
>         INIT_DELAYED_WORK(&platform->hdcp_work, hdcp_check_work_func);
>         platform->hdcp_workqueue =3D create_workqueue("hdcp workqueue");
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/=
bridge/analogix/anx7625.h
> index 66ebee7f3d83..39ed35d33836 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> @@ -475,6 +475,8 @@ struct anx7625_data {
>         struct workqueue_struct *hdcp_workqueue;
>         /* Lock for hdcp work queue */
>         struct mutex hdcp_wq_lock;
> +       /* Lock for aux transfer and disable */
> +       struct mutex aux_lock;
>         char edid_block;
>         struct display_timing dt;
>         u8 display_timing_valid;
> --
> 2.43.0.381.gb435a96ce8-goog
>

Reviewed-by: Pin-yen Lin <treapking@chromium.org>

