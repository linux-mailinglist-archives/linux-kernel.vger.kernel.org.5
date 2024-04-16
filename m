Return-Path: <linux-kernel+bounces-146895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3407A8A6C98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E401D282B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF512D749;
	Tue, 16 Apr 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AduxKibg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38212C49A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274430; cv=none; b=UpP+jnAimcdRslAmQgDU4hvXwVG2ZUPvMNrW50s2qGy+vh+RMhbwUOv99k/XERb/EkpR3D9rrNZEEVK98LRlIGdPNRTKRGCARzJbI1ysQtEQwftF2hBkQf6SpeWT/lKHiQtjWG/Bb2YFo2zIqXxbp73KFQD+dhDnLur1neDnkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274430; c=relaxed/simple;
	bh=y44+MXwINffl7FTl3NXZCF8gOj5eIknEcj0Cw0D79Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBMJ5McgcRMJ5kpXxXLrfI17zJG80JRmaRYoy3Z9vnUxbM9rT+0Ojnyeqd1LodQYNU9Cyjl/sjdnv3h9NptbnbXFXhOkZm8BFRAS4ASNm5043jpDbua5zB0Kqk8tOtcUf1ZIO6MPPIdv+ey1+nKlPXd5t2LM066ZKeJ6i2fTgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AduxKibg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA28C2BD11
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713274430;
	bh=y44+MXwINffl7FTl3NXZCF8gOj5eIknEcj0Cw0D79Fw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AduxKibg/vDcJqZusYFbU/zYf17VVlXSEFHn3n7QO/hCx88Ljde5kSw+tNICWDatO
	 WmUe/X8pXd56vuO4c4NJE1vMjbcKr8U7jAIP/TomPMRWpK8CXnF9qxodnm3ur9Es9u
	 H7WJyeDxrgks62NFh0ITi1mbvxsLomydGOle69YtFNokanT2uO//ukWLqTncHJuohQ
	 fwM+sfVlGzrc7TcZN0NxDsJjtkcJBqOxQ7wTWuvq4rD1X3++4xy0zlGizYwQ66C3e2
	 wyUyWQ5oBRXvNFlVO43OaiWbNcOes7TPP25yYojZ6E/VNZzKAl/A+hznbZ6QHF32v/
	 XYezOy3HXHjMw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb77e56b20so1908071a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:33:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkrUEPoOWlRkWhP52oPv4z9CU421K88bb1SCMMcGEQGt/66fndOGZwMaSg5JLfSSHVPS0qGkqvc4LGdJgEldGs9vn1iTybVLMjPEJl
X-Gm-Message-State: AOJu0YyrWoZJkndrqp3vQeCMwoE0sqVKGkvCb9EYsUWt2BpIN8PKQIbi
	L5u1hokE6LSwy0Wba9K/swD5Wr+mOJayWv6M+CKtCeySh0DsdtFlrZTyZRs9jbik5VuMPpftyOQ
	RfzoOTBkF8wKbQxyZ12GXYFG9hNgLRfkk0IYggA==
X-Google-Smtp-Source: AGHT+IG4v+6Or3Vouic5yjwN06PSJ/2CUtWhHztGEiynLqWQPPJkcyjNAFlV67Bmhg5GCxwfvftcKG0C7q8GH+b4z7g=
X-Received: by 2002:a25:c54f:0:b0:dd9:20d6:fd2 with SMTP id
 v76-20020a25c54f000000b00dd920d60fd2mr10893104ybe.27.1713274409056; Tue, 16
 Apr 2024 06:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412083532.11540-1-amishin@t-argos.ru>
In-Reply-To: <20240412083532.11540-1-amishin@t-argos.ru>
From: Robert Foss <rfoss@kernel.org>
Date: Tue, 16 Apr 2024 15:33:18 +0200
X-Gmail-Original-Message-ID: <CAN6tsi6kGCGU5_zQD17-tELy94w6W5hU0nzfeR2KPhEztCayNQ@mail.gmail.com>
Message-ID: <CAN6tsi6kGCGU5_zQD17-tELy94w6W5hU0nzfeR2KPhEztCayNQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Swapnil Jakhade <sjakhade@cadence.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Tomi Valkeinen <tomi.valkeinen@ti.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Nikhil Devshatwar <nikhil.nd@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Jani Nikula <jani.nikula@intel.com>, 
	Rob Herring <robh@kernel.org>, Zhu Wang <wangzhu9@huawei.com>, 
	Yuti Amonkar <yamonkar@cadence.com>, Jyri Sarha <jsarha@ti.com>, 
	Quentin Schulz <quentin.schulz@free-electrons.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Aleksandr,

On Fri, Apr 12, 2024 at 10:40=E2=80=AFAM Aleksandr Mishin <amishin@t-argos.=
ru> wrote:
>
> In cdns_mhdp_atomic_enable(), the return value of drm_mode_duplicate() is
> assigned to mhdp_state->current_mode, and there is a dereference of it in
> drm_mode_set_name(), which will lead to a NULL pointer dereference on
> failure of drm_mode_duplicate().
>
> Fix this bug by adding a check of mhdp_state->current_mode.
>
> Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/D=
P bridge")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v2: Fix a mistake where the mutex remained locked
>
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index e226acc5c15e..5b831d6d7764 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2059,6 +2059,11 @@ static void cdns_mhdp_atomic_enable(struct drm_bri=
dge *bridge,
>         mhdp_state =3D to_cdns_mhdp_bridge_state(new_state);
>
>         mhdp_state->current_mode =3D drm_mode_duplicate(bridge->dev, mode=
);
> +       if (!mhdp_state->current_mode) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +

This chunk no longer applies on drm-misc-next.

I think the approach here is still better than what is in
drm-misc-next since it unlocks link_mutex.

Can you rebase + reword the commit message and send that out as v3?

>         drm_mode_set_name(mhdp_state->current_mode);
>
>         dev_dbg(mhdp->dev, "%s: Enabling mode %s\n", __func__, mode->name=
);
> --
> 2.30.2
>

