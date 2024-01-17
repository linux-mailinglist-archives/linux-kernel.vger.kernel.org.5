Return-Path: <linux-kernel+bounces-29369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1532830D55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D04DB2441F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D38F249F3;
	Wed, 17 Jan 2024 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hzC6adFO"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218231E877
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520349; cv=none; b=kO0B+80JVqpHKGINO5Nq92m6wLSOn7yQwzBOL5rxAuqSEam9QqVEiMXhTRWB6lB2xBniBIsxVYx0NVWwEM0lsvTULy/OjgJZ5MIMPO1aTlZpuRA1DUDm9Ny/15C4jLcyUIAVFzoimQisHYiRzZKLju2WOSTkam7LjJ7bGkU+YNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520349; c=relaxed/simple;
	bh=jrjn3NC6NorunAtxuwbpds3Mq7BV0m/tHvQeaRNhu14=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Fsih3i9bDXlC7MDrEZIqb/4EWCQ0xW/MmuLSIRFMroifDpRPElZVm2wyLBcpGSSZC6NDNEFjpV1dV/za7EQGNqn+scpxVjNInuNt67kkZd0ruQnl+3ca2Y3E/ij8U+zNi+6LAB2KeShw00ha6ND/IZATnHPMkcgnjHbVFl9GOoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hzC6adFO; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dddcf525f0so4017a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705520347; x=1706125147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6jKjCd8cxNvuyTvHeVd3uoTbVR5rb6TebJjLMiKkIw=;
        b=hzC6adFOW26xtIv6lP8nODmMJFuen1RuNpycs9BQyFsoqvBxCCcWXpxgIuVDpBIHmr
         ImIWpgUGZ15r2nvq9wlocAa5PXGkSYzTcMlX7kAma1QC6A5WxWVSn1LfOKq4PLYFnGbO
         Znm5cOY/NsqKrn62yM/ZZ7xa0PGSRv6Sak/m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705520347; x=1706125147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6jKjCd8cxNvuyTvHeVd3uoTbVR5rb6TebJjLMiKkIw=;
        b=uQ/XNn0Z7DqhYHVZGcm7fRBBjC6QzjLoWSFntyNqK/k3wSk3HiKNSKdWrRN2bSO5j9
         w2Eg6dLHcoblNhGJ8Kuu0DsTzULDLcEaAC0n7xxPFlOg7oXjlJwjVbik0ueqhhuMyNUO
         eLAY7JUlPPUMyRX49kKOHDlMmMGv2Ow0Hk0EgiO36YE5KBdKSZu/mgi9/13gadgqd3LB
         fm9yW1zRWO47VlX6mmARbSmm1wh4gXNgUW/LhO8FT9WS7oX/WyOOZdMXb0mrGrDo00t8
         fMQ6dJ0jAg92UqwInysPXYBp7YWXqX/OfyFaw5hLKmqF51t5iFJwcSDIOVR9dBlfYdGM
         bYLA==
X-Gm-Message-State: AOJu0YyZOqqS/qj5fYv8luRbCDp8LdRCPbMh21vf2OppYoH8gVO+uqaL
	z52DD49L+2Z+XBxZkVbvuJ8yMJJcwJHSWZAcYrCqB/6++ydq
X-Google-Smtp-Source: AGHT+IGH9stHtp4vFELGxHWV6sZJ5VLgX2UrJI9VZ6g5lxacI7FFdFqxVb2ZT4UmOppnd/g7oFSkYQYXplKjNDdRHqY=
X-Received: by 2002:a9d:63ce:0:b0:6db:ff8b:724e with SMTP id
 e14-20020a9d63ce000000b006dbff8b724emr548346otl.3.1705520347212; Wed, 17 Jan
 2024 11:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117103502.1.Ib726a0184913925efc7e99c4d4fc801982e1bc24@changeid>
In-Reply-To: <20240117103502.1.Ib726a0184913925efc7e99c4d4fc801982e1bc24@changeid>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 17 Jan 2024 11:38:41 -0800
Message-ID: <CAJMQK-j_gEfZqWppG3oVNWBopH9uVK-NrzXvoSr=ijF2pMycDA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Make sure we drop the AUX
 mutex in the error case
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Pin-yen Lin <treapking@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:35=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> After commit 26db46bc9c67 ("drm/bridge: parade-ps8640: Ensure bridge
> is suspended in .post_disable()"), if we hit the error case in
> ps8640_aux_transfer() then we return without dropping the mutex. Fix
> this oversight.
>
> Fixes: 26db46bc9c67 ("drm/bridge: parade-ps8640: Ensure bridge is suspend=
ed in .post_disable()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Sorry for missing this in my review! :( Given that this is really
> simple and I'd rather the buggy commit not be there for long, if I can
> get a quick Reviewed-by tag on this patch I'll land it without the
> typical stewing period.
>

Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

>  drivers/gpu/drm/bridge/parade-ps8640.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index 166bfc725ef4..14d4dcf239da 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -351,11 +351,13 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_au=
x *aux,
>         ret =3D _ps8640_wait_hpd_asserted(ps_bridge, 200 * 1000);
>         if (ret) {
>                 pm_runtime_put_sync_suspend(dev);
> -               return ret;
> +               goto exit;
>         }
>         ret =3D ps8640_aux_transfer_msg(aux, msg);
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_put_autosuspend(dev);
> +
> +exit:
>         mutex_unlock(&ps_bridge->aux_lock);
>
>         return ret;
> --
> 2.43.0.381.gb435a96ce8-goog
>

