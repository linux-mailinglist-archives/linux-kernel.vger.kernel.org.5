Return-Path: <linux-kernel+bounces-135972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E089CE67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E24F1F2357C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A48A149C78;
	Mon,  8 Apr 2024 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX5ftAe6"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346814884C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615308; cv=none; b=KbFV2wnt057/+WVMuEMeH0U7c1uygWPyqLWlYpD5wlinEF64uZs0JjklGr0XJMOw7Kru/3V6UDbodA2HFAVI8jqmRzRtBm2WOgqIhFNky+WkI4Ds6jQq2twluLfu8o9+KKq3TMFhtkA9EO8LCMmWeUnASgyzKrOZSh0j9C0tBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615308; c=relaxed/simple;
	bh=ujKTRH85yegZIc7K7n1h7eI+5YSehLJ3E5k5mZXbXqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oo/zrYUbgpo9995Io5Svt5XuxmA089/8VIMyDHRMhO72cJqXShbcq4YXmadcivI+P2ovafTIGJk/CysswICPmyvJ+km+p6W/La+v6eDy1jA1FrxM+lxp359UYlBr0Mz/m/AVwC0UGuz9D6jy6MDYHBVybXrupyt/7QHklUP6rEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX5ftAe6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e67286bf5so1831310a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712615305; x=1713220105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QGCVo4CTXBLwTYH+iiI/NIF2pRRvzU2RZ76rFTzzLEo=;
        b=bX5ftAe6e8woZ2ekjwPeA7L3gpUiLLIpol10mUBYBhUqbbtQmS+slvIxpafGcn5dQM
         JpqEciYZCBhrZkWqQfzV1gFP9iS719QI9uS8604hVzwtMT/TwHm98zCAzfcWMYxrhZhp
         912yLJtuFKSUv1DxfPGvqil01bQcXUOzYoaYjN8wlaNivSTVKqx/l92frZp4hAExRg84
         YPBhP11aBIUFxDwHq0VpGZAE6HXUWxRzpxI+35m8IUJLPGvhoyN89rz7Q5rfBuarjSuY
         DoFKfES7Zk3fbG/HhxrpT8tiTYvpzMkKVucR6DmI3Nh3X8n75skVqeJzPxpaUfYB3Yru
         iF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712615305; x=1713220105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGCVo4CTXBLwTYH+iiI/NIF2pRRvzU2RZ76rFTzzLEo=;
        b=m/v5dguDEvJ7nP6PBeIxEHENaTzbOX2CiklM6PdYb+MuNIE/HkBTCoNmH26Ax2QU3x
         oW6N+8sIBlEq25mQXQXy1PvpTuqHzBHX2ycf3Pjrx1Luqp8WbNYhw90RM1WymS14GT1O
         Alq+NV0AWu+IoVuIPDjJDxF7tOtK7CnAwRljYOYOn8qU3cH8dD14rsCRyR0pP6kD3qsb
         8N/qdnJsAgOPlf9yo7mjh/xEgsqgKswm72W4m7lAMckVEe0l0K/Gd67bsll3xP8aaaFP
         w3yxrQWapsxs9RupGjUftfXmxNnNBD8wSA3TDIKFc12MoSi+MrcHkv8DFLQPffJQxSlS
         UfLA==
X-Forwarded-Encrypted: i=1; AJvYcCX9bYOEcQESel9LlueerCUunI6MV4Z5elHgyPqeRrKNG4KtC4d1dfoKHsGDuHOHICubPmYO620R2BAcD7nkB0AbVWuLLjXxT6FQIJbz
X-Gm-Message-State: AOJu0YyRLodmQbsgdWx2ayscSXiTV+7zLnHVz+VXlR2F37bnn8uxQy2W
	/EU6FMEQu6F4QMYv+HfegW2d12xZ8xtJMOfx50V/s92HkfXOGuDLAswQoAI5oU17Tv+1RaJQcrL
	i9n4tDAN2hfMzuNfAXLe6fZnQ4y0=
X-Google-Smtp-Source: AGHT+IGEgHggUKRJS6kEApnOO0TdYyJ8yYoQMQXYMTy+aSEO7rQgl7Xwa4KDmwUZYs+d9EYIdW7qHtqfjtn0F9QggOw=
X-Received: by 2002:a50:9fc9:0:b0:56d:f29d:c80d with SMTP id
 c67-20020a509fc9000000b0056df29dc80dmr762183edf.5.1712615304926; Mon, 08 Apr
 2024 15:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404233736.7946-1-lyude@redhat.com> <20240404233736.7946-2-lyude@redhat.com>
In-Reply-To: <20240404233736.7946-2-lyude@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 9 Apr 2024 08:28:11 +1000
Message-ID: <CAPM=9twXXx9c9O7GFBHMhANOuMqt_tUKr97-2cPCwzZoJFtH0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/nouveau/kms/nv50-: Disable AUX bus for
 disconnected DP ports
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Karol Herbst <kherbst@redhat.com>, Danilo Krummrich <dakr@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 09:37, Lyude Paul <lyude@redhat.com> wrote:
>
> GSP has its own state for keeping track of whether or not a given display
> connector is plugged in or not, and enforces this state on the driver. In
> particular, AUX transactions on a DisplayPort connector which GSP says is
> disconnected can never succeed - and can in some cases even cause
> unexpected timeouts, which can trickle up to cause other problems. A good
> example of this is runtime power management: where we can actually get
> stuck trying to resume the GPU if a userspace application like fwupd tries
> accessing a drm_aux_dev for a disconnected port. This was an issue I hit a
> few times with my Slimbook Executive 16 - where trying to offload something
> to the discrete GPU would wake it up, and then potentially cause it to
> timeout as fwupd tried to immediately access the dp_aux_dev nodes for
> nouveau.
>
> Likewise: we don't really have any cases I know of where we'd want to
> ignore this state and try an aux transaction anyway - and failing pointless
> aux transactions immediately can even speed things up. So - let's start
> enabling/disabling the aux bus in nouveau_dp_detect() to fix this. We
> enable the aux bus during connector probing, and leave it enabled if we
> discover something is actually on the connector. Otherwise, we just shut it
> off.
>
> This should fix some people's runtime PM issues (like myself), and also get
> rid of quite of a lot of GSP error spam in dmesg.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>


For the two patches,

Reviewed-by: Dave Airlie <airlied@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nouveau_dp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
> index fb06ee17d9e54..8b1be7dd64ebe 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> @@ -232,6 +232,9 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
>             dpcd[DP_DPCD_REV] != 0)
>                 return NOUVEAU_DP_SST;
>
> +       // Ensure that the aux bus is enabled for probing
> +       drm_dp_dpcd_set_powered(&nv_connector->aux, true);
> +
>         mutex_lock(&nv_encoder->dp.hpd_irq_lock);
>         if (mstm) {
>                 /* If we're not ready to handle MST state changes yet, just
> @@ -293,6 +296,13 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
>         if (mstm && !mstm->suspended && ret != NOUVEAU_DP_MST)
>                 nv50_mstm_remove(mstm);
>
> +       /* GSP doesn't like when we try to do aux transactions on a port it considers disconnected,
> +        * and since we don't really have a usecase for that anyway - just disable the aux bus here
> +        * if we've decided the connector is disconnected
> +        */
> +       if (ret == NOUVEAU_DP_NONE)
> +               drm_dp_dpcd_set_powered(&nv_connector->aux, false);
> +
>         mutex_unlock(&nv_encoder->dp.hpd_irq_lock);
>         return ret;
>  }
> --
> 2.44.0
>

