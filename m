Return-Path: <linux-kernel+bounces-94376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1C873E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D501C216CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7D13C9C9;
	Wed,  6 Mar 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWKTSgt6"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BFC1361C1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748445; cv=none; b=LXUonbJmfgfss2V8Xgm1fSPhe0JNiFKM2mq5kpQjJEGn9jx/mJqbCgNlmb8buIFXqWyCibYcNfdD6GGOO55k2raD1FvLgIWF109EIc/n4+u/rwOZ/Y7I4bam4soLLBH3VaNQVINGiPRSREYdP7n7VMipLijOqsgHKq/P9ipXcUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748445; c=relaxed/simple;
	bh=8plUTdb6Fv6GLhziZ7ALvzF8vSm83xETHbpXVJSIzMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsaXMJ7eMClQuZb6zhAjAeDI1I2WtfktYzk1udyB8iaLOxCAkpa6HajK9QnMlPUWkLdoE3Cx+zYfTbq6doOIh4BFTrscRxQp+k7ESFLnE05sCciCHGcPMU2zCLIithalmVhQlg0ovJxLR/76lnqCZNCpUXm0938J/zuqDhJCrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWKTSgt6; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1ea59cf81so2032387b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709748443; x=1710353243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQwUmBSggnRD0pcG/xZbZRZTuuiVEi9qcHO+7tcjts0=;
        b=RWKTSgt6FcRardZi2Z61W3VOaCpDvgy4ntwR1Rk52xMwNSsDMu8SmWpVEaiN80PFmP
         DM6EPg6QsvDkWIA9FAG2LtrfO7Nonqec0rm8K4hLAl2q3Z8CLZqhYdoSw0Hunn45fwIQ
         0/QrnoFji9eIA93Wrf22YIO1uSc0BU0asWU3BbWOAkoi6Rg/sNCvby3eB9abhErGGHSR
         kbSNLUpWjANNHzooQ2cDthROQ9lMI/PQMsKZdQrVZvjPbFu6XrWvuza7VaRh8oxVVg33
         aPz5RVSxGiKpzo+bzrmssrchYEHAaFdVnHuChPh8x7gZYv8iXebmyzH0AOvhjz9C9V6o
         +2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709748443; x=1710353243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQwUmBSggnRD0pcG/xZbZRZTuuiVEi9qcHO+7tcjts0=;
        b=Z0Q6L17OcGfiDgqggwnr/3oOhQFjTDIyKSmtu4f01IkkwumMT782B1rANNkE16G/Uk
         HQxIF4gHfKkhq8mOQBKjJGBl4TwFVWi5dSEuFrSCvbMmOG+FdmH8MOCVkrD6P0O8upUx
         J/tEKCsjwwr86JVwJw7/AQuvClgvfSHRJspNVqnRg7pSeJ/SAmBuEeoVqSaYuCiBmBmr
         QQQwTvlzFGt2CVBdAZjs4/GWdyWwaREhXDqoqMzL0SO22y0P9lvNJFAFReMxS/L4YEYL
         p/XrhHKgwOoDjQsL1FVlMZMK7606dVqKkOdHKBoTo16fpawh5SfDWp9sfjgqSRn/lFav
         2Rng==
X-Forwarded-Encrypted: i=1; AJvYcCULKSmiiM9LzLd6OcB/GKyjuXuaLqSNg5K4EFj6YyzCHqexfUmauSp1WdDf0XCz+rwcgzwAP5AOuLwHDf0PAto0J/XEHIdYfTrERFBp
X-Gm-Message-State: AOJu0YyrpEWoT/NxVWchKqdAFonTwzYaVmneClyJ80hF9fkp5dmMejDv
	0gOMt9eQOINNg0iNIS0Krsuckn0Gs1ovl+CK8dFqWxDgxt25gGs2B9V3J8GpS104jTHMOHkKJDJ
	E2UM5zWDPwlX5a7ZkQJH4u9TIQM0=
X-Google-Smtp-Source: AGHT+IGPrOh7Nxf2XCNqNWJRrgy482/ux2E59iFt0t+DK4BrB5tNqimAy468jOtXO5UB4zF2DYDQvfbz5R4CL5EqVyY=
X-Received: by 2002:a05:6808:2985:b0:3c2:1f27:832c with SMTP id
 ex5-20020a056808298500b003c21f27832cmr1561706oib.1.1709748442874; Wed, 06 Mar
 2024 10:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306032414.18488-1-prosunofficial@gmail.com>
In-Reply-To: <20240306032414.18488-1-prosunofficial@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Mar 2024 13:07:09 -0500
Message-ID: <CADnq5_Nnx47dQCCyWrx9sNExFjZAOR=qt+nPdN0cqj1zyRLYRg@mail.gmail.com>
Subject: Re: [PATCH] Removed redundant @ symbol to fix kernel-doc warnings in
 -next repo
To: R SUNDAR <prosunofficial@gmail.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, rdunlap@infradead.org, 
	mario.limonciello@amd.com, mwen@igalia.com, swarupkotikalapudi@gmail.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixed up patch title prefix and applied.

Thanks!

Alex

On Tue, Mar 5, 2024 at 10:48=E2=80=AFPM R SUNDAR <prosunofficial@gmail.com>=
 wrote:
>
> For linux-next repository.
>
> ./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured =
comments found
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use=
 of kernel-doc format:          * @@overlap_only: Whether overlapping of di=
fferent planes is allowed.
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use=
 of kernel-doc format:          * @@overlap_only: Whether overlapping of di=
fferent planes is allowed.
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1: warning: no structured c=
omments found
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use=
 of kernel-doc format:          * @@overlap_only: Whether overlapping of di=
fferent planes is allowed.
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:162: warning: Function para=
meter or struct member 'pre_multiplied_alpha' not described in 'mpcc_blnd_c=
fg'
>
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/dr=
m/amd/display/dc/inc/hw/mpc.h
> index ba9b942ce09f..34a398f23fc6 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> @@ -110,9 +110,8 @@ struct mpcc_blnd_cfg {
>          */
>         enum mpcc_alpha_blend_mode alpha_mode;
>
> -       /***
> -        * @@pre_multiplied_alpha:
> -        *
> +       /**
> +        * @pre_multiplied_alpha:
>          * Whether pixel color values were pre-multiplied by the alpha ch=
annel
>          * (MPCC_ALPHA_MULTIPLIED_MODE).
>          */
> @@ -129,7 +128,7 @@ struct mpcc_blnd_cfg {
>         int global_alpha;
>
>         /**
> -        * @@overlap_only: Whether overlapping of different planes is all=
owed.
> +        * @overlap_only: Whether overlapping of different planes is allo=
wed.
>          */
>         bool overlap_only;
>
> --
> 2.34.1
>

