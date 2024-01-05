Return-Path: <linux-kernel+bounces-18360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D234C825C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E57D1F244E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956492D7B2;
	Fri,  5 Jan 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="elURLvWM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8735890
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [192.168.1.114] (unknown [185.145.125.130])
	by mail.ispras.ru (Postfix) with ESMTPSA id A64A440F1DF8;
	Fri,  5 Jan 2024 21:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A64A440F1DF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1704489208;
	bh=FlEa4522VZdZ1YxHNtrr3RlZjAu47jub/SKcUbhgne0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=elURLvWM2R+W2sXvbnDz4yjHrY16N8IpFq79W7EMGRzvJoEc8dMrCRctSn9sjd0+U
	 /woxhCucAlP8rtdCMojyX0PLD0O7WYXL1/+YZoyTSc244W6+kLdA4+9UngmQis0J9r
	 3gDjd+wITq/RuM4RGxvSF+N+t0Nj6UZ/ClSeD2HE=
Subject: Re: [PATCH] tvnv17.c: Adding a NULL pointer check.
To: Andrey Shumilin <shum.sdl@nppct.ru>, Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20231116065159.37876-1-shum.sdl@nppct.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <5609ce98-9bbb-29f4-0c4c-a4d3654152f7@ispras.ru>
Date: Fri, 5 Jan 2024 21:33:07 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231116065159.37876-1-shum.sdl@nppct.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit

> Subject: tvnv17.c: Adding a NULL pointer check.

As

$ git log --oneline drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
874ee2d67fc9 drm/nouveau: Remove unnecessary include statements for
drm_crtc_helper.h
80ed86d4b6d7 drm/connector: Rename drm_mode_create_tv_properties
1fd4a5a36f9f drm/connector: Rename legacy TV property
09838c4efe9a drm/nouveau/kms: Search for encoders' connectors properly
2574c809d7c0 drm/nouveau/kms/nv04-nv4x: Use match_string() helper to
simplify the code
...

shows, a better prefix should be
drm/nouveau:
and there should not be a dot at the end.

e.g.
drm/nouveau: Avoid NPE in nv17_tv_get_XX_modes()

On 16.11.2023 09:51, Andrey Shumilin wrote:
> It is possible to dereference a null pointer if drm_mode_duplicate() returns NULL.

I would suggest to add a little bit more details:

drm_mode_duplicate() may return NULL in case of error, e.g. if memory
allocation fails. It leads to NULL pointer dereference in
nv17_tv_get_ld_modes() and nv17_tv_get_hd_modes(), since they do not
check if drm_mode_duplicate() succeeds.

Otherwise, looks good.

Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>


> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> index 670c9739e5e1..1f0c5f4a5fd2 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> @@ -209,7 +209,8 @@ static int nv17_tv_get_ld_modes(struct drm_encoder *encoder,
>  		struct drm_display_mode *mode;
>  
>  		mode = drm_mode_duplicate(encoder->dev, tv_mode);
> -
> +		if (mode == NULL)
> +			continue;
>  		mode->clock = tv_norm->tv_enc_mode.vrefresh *
>  			mode->htotal / 1000 *
>  			mode->vtotal / 1000;
> @@ -258,6 +259,8 @@ static int nv17_tv_get_hd_modes(struct drm_encoder *encoder,
>  		if (modes[i].hdisplay == output_mode->hdisplay &&
>  		    modes[i].vdisplay == output_mode->vdisplay) {
>  			mode = drm_mode_duplicate(encoder->dev, output_mode);
> +			if (mode == NULL)
> +				continue;
>  			mode->type |= DRM_MODE_TYPE_PREFERRED;
>  
>  		} else {
> 


