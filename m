Return-Path: <linux-kernel+bounces-59778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF6F84FBA8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9FA1C211A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B405B7EEF5;
	Fri,  9 Feb 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1dZFx/+"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D617F495
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502281; cv=none; b=jdXvY2EU5d5mdBwZZ3c0Z4WF1gOH5Qgh5qrXcx4LJDMO4Q9E+qxRvdX+HKZ14i24UV6EgS+oaauLrXyUMHWqIfxWpsfMNNNf5HWNOT6Ddei9R87bpGIfTjHHGvPLlJAbYgfApiJ9ABuLsKB7GJGOE5EIk6gJ+rIScJCU4Fw4cgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502281; c=relaxed/simple;
	bh=t2Uy7j+N50s0xLHY/qoxYE0z5Oe3+S36hol8St2T+vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2xNM0wk/4uOx7t1K2PuTfB3tUNacdY7VnWOWyTAdvFNarTIPcbxPh0c6fa3AEnBgXJrxsDTxL3EEVZ19CFBTWkHE8CCkQkLSzyBms68hkzJ9y1oH8uZB/UWL0lL/tPUlYZ7D0m+vu1qy5o4VtrYpSf5Me4eSR4E6NgDTl6PdTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1dZFx/+; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e12d0af927so779621a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 10:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707502277; x=1708107077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4ya9imxm+TuQuQYyUyALfBi5EmklrNTGbvgYwUYgc8=;
        b=R1dZFx/+imFf2vltHg9cDla9Ramc7ZChtxprTZLhMy6Jx3PePcgtEPR5HQizdpBZFW
         lQMrDWnJD536Db9XVzkNho0ifA3jd1+BO3dphGRPnCIKMWmYRcWl1OVY84qAfGYW3RJb
         c/807eKttkhkfSi52PQmeSDk8oNNWZG7fSty0ILadi2HJlaQrmmb2ZsYvyf+UZTr5Nt0
         +BUKCOCxjQzLqUJiOyTLz4FKCGIyrz5xWpjeBudPmhTveFXeoWtQaEUCJPpnc+u0FUWb
         4lhNXmCmhzmdbSPGUHhLCKH1fL1rUZJ+SW5MUjoh5UiLR/isIC4a0TFGP2nXWjtG7LFg
         jBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707502277; x=1708107077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4ya9imxm+TuQuQYyUyALfBi5EmklrNTGbvgYwUYgc8=;
        b=Bk5eQSBFRh4UxJchTt3JYWcDCVak3W9lose7Amz4395sV4wgE7WRm0X/i6QVdMtWJa
         nlrAtzbvvmrrLQ2KAEQ8yNRYxJo21BQG27xPt1hc/L83NqKv7uldT+s67vmcxKwBh85E
         DYyO0++IB1AoDNQD59O3kIgSaHfc4rDk+5FsCibSohy/KrDy12JOPY43kTJdGCFQKQgW
         o1uS22zlQPjs/u3vwSmT7EeE8DMB6tExFnq2QGVjvejdyywG4qFJxDvP/Sj9ZWH9CEhj
         odkhd2Y/EXcLZHs1/VBiyWgncAj5mi+3yeCei3vXHUu79kEjfwYQ3GDbHyvoFhmGR0gJ
         gnmA==
X-Forwarded-Encrypted: i=1; AJvYcCVCvmyuWKGJuJc3vWxyx/SFeyFgNInBvz4f2hJTKdgrp6XQesf8C4zmALSy9dDYToRH0/y1dxu5BxhJd7hxMoNVlpcWZU6xwolA7Rpr
X-Gm-Message-State: AOJu0YxwMVmMy+k5ddmLsd/qZkU3/DdMZ6pUBniYNQDo7y2HlJ9JwXtA
	di8QFGLr+koCtvMguk/LtSVQJwVLyMuor6Xbphi68REPN3a3CoP39GN/2TjVMEWx8tY+SYP/3FT
	N6Ar8yEZfNPzThOtS0ugP7geWgUjCPhMx
X-Google-Smtp-Source: AGHT+IHjbqI0G2xXOJ3F6PHDREr7s65q7Y+7GFw1OkWfxUwFoS3FacLdVLGrqBP9xfDmK0z+HtY1ppgkxEPUle1apt8=
X-Received: by 2002:a05:6870:b50b:b0:219:88b7:f9cb with SMTP id
 v11-20020a056870b50b00b0021988b7f9cbmr2890691oap.28.1707502277452; Fri, 09
 Feb 2024 10:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206165056.47116-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240206165056.47116-1-n.zhandarovich@fintech.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Feb 2024 13:11:06 -0500
Message-ID: <CADnq5_Mj5aj10VyamcXUDuijDPYm9-nmrqR6z1YDhuYmiN7fkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Tue, Feb 6, 2024 at 11:51=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> Since 'adev->dm.dc' in amdgpu_dm_fini() might turn out to be NULL
> before the call to dc_enable_dmub_notifications(), check
> beforehand to ensure there will not be a possible NULL-ptr-deref
> there.
>
> Also, since commit 1e88eb1b2c25 ("drm/amd/display: Drop
> CONFIG_DRM_AMD_DC_HDCP") there are two separate checks for NULL in
> 'adev->dm.dc' before dc_deinit_callbacks() and dc_dmub_srv_destroy().
> Clean up by combining them all under one 'if'.
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d292f290cd6e..46ac3e6f42bb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1938,17 +1938,15 @@ static void amdgpu_dm_fini(struct amdgpu_device *=
adev)
>                 adev->dm.hdcp_workqueue =3D NULL;
>         }
>
> -       if (adev->dm.dc)
> +       if (adev->dm.dc) {
>                 dc_deinit_callbacks(adev->dm.dc);
> -
> -       if (adev->dm.dc)
>                 dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
> -
> -       if (dc_enable_dmub_notifications(adev->dm.dc)) {
> -               kfree(adev->dm.dmub_notify);
> -               adev->dm.dmub_notify =3D NULL;
> -               destroy_workqueue(adev->dm.delayed_hpd_wq);
> -               adev->dm.delayed_hpd_wq =3D NULL;
> +               if (dc_enable_dmub_notifications(adev->dm.dc)) {
> +                       kfree(adev->dm.dmub_notify);
> +                       adev->dm.dmub_notify =3D NULL;
> +                       destroy_workqueue(adev->dm.delayed_hpd_wq);
> +                       adev->dm.delayed_hpd_wq =3D NULL;
> +               }
>         }
>
>         if (adev->dm.dmub_bo)
> --
> 2.25.1
>

