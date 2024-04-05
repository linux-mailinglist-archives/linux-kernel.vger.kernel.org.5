Return-Path: <linux-kernel+bounces-133465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C089A41D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BFD28C4D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05914171E7B;
	Fri,  5 Apr 2024 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqzsBt6s"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8656171E47
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341264; cv=none; b=CSr1PCu4RLbo0D7MfPcJIEyAgx7awFLadCNyN2sk5tmbFjn72UCDsNJ1zlrzkstTraC6ilTwBrJ/E4fgR70+2hSXv+3Q8uOi/VtlFta+qa66ZSLQ0TwByFUpKrcUns4T1QgUGqelZFxRpZNHDEsF3W2MxvRA1iQIbR3thrBblxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341264; c=relaxed/simple;
	bh=gE75rtpTvZRnUSJ6xctoCFOXk2fH+DWGzh0IgmMEylg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wmhim0qQpSXUJjXnk8MbEasRUR6o+aLeenJd3fEvMKpw2MO3Z5tsC2L51LwHPF3gBi+wauteRo5b2MXXoF9YVtJ76QdwIHCcOgY73wdFbXry96E1kEqwz63fmkgVQC2O1GiSmsgJoEPp6MZt7A9euqm0sCisiokllZ2QP5wuRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqzsBt6s; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6152088aa81so26644177b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712341262; x=1712946062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6FshVhZKcqJky0lBiOIixXGsQBzKhd/9O9LkN4VAwkM=;
        b=RqzsBt6sMz01dLchQoBSwVLYg469vbMyHHKIvqr9PiO0Nw0vz8uUpS3JADeiHD5Oie
         WN6n3ry5TLqkddcZJhmwbFfekym63ABhTT3vCYVkkqqLPIDLjwGUDm3GA6XJ+5h7TCYQ
         8b3KxGYM3C0vUduCZWAe90/dnbT5JHQU/x9ZMm4n0cjtQazOVZhp+0jzfnB1dimHBJqM
         lPnLfbNPBixJk2xH0i+AheQnSyC4T17Z2PR0EhDpCkshBQThaP86bzvL/579DoOJ2yvC
         lua+gYKWXbfyO7zs0udZAi2qqFHxebn6DWcc1tLxUJjpu6nTA7n9TOuPtwf/3HT+zKZE
         cB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712341262; x=1712946062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FshVhZKcqJky0lBiOIixXGsQBzKhd/9O9LkN4VAwkM=;
        b=BjjDqVEBjf6vZXo/HXGBvpcbWszPRGWyHKYjLCbbRYGzBxYw7sKIJEmEYzGFKL+Wc/
         xl1NSBW9wxM3yLXbI+Thv1oyvQjgvjxITpMPcL9iUnPL+5+PQf0DAeZWmZp8hB/NZwtl
         AN0MPBwV6XI2uAyWHlUaSRzkFqDPG06jiZOYzg+BJCceEwXidJlZT/PW79X1PmEoQ130
         NyMW+KqPmPd0k1JodnyTW2O4aKf95MM+EksQTJ/G1m9uy/xf1DDYPjwlZgXjwDuAWIlZ
         BUmTrqpJnZoH/JPmlcQDgpt9k7vn8C19xgcU88QFeJ1J9gc7wsgFc1QavGYfmw/AezHN
         dz9w==
X-Forwarded-Encrypted: i=1; AJvYcCUA9Mo8mXA0PUauEBoVw6qK+T76yA7qUjfLdk4Zlag26AGHMAZmgCD3CGimQ8HUcfg9dj8TQ6wDRx/xMj6Hx+ErScfHEZf7pgEvZ1hs
X-Gm-Message-State: AOJu0YzqsaHWUMkFc37itgt/ZCjSphKFCUEQM22ko6q6a0kFVDTAJNg9
	kYnXf6ftfVyBzYtvfdg4MpNTDKesxMV7xWx+KuYHDFjM/4UAP3IH6imu7JjiNby4L0z28cLQQGO
	eJKh6Ylnn4p0FLhnDFyf9inGkhsZ6fgLBAJhXRQ==
X-Google-Smtp-Source: AGHT+IHUuUqv9XGZ9bYt/6FB0DSxASTzs7ENjMecr4yFUOen3MARyohRguewr1dgCgDY1mFhRU/AKlGWEip8NUHr6ww=
X-Received: by 2002:a25:8250:0:b0:dcd:5bfa:8184 with SMTP id
 d16-20020a258250000000b00dcd5bfa8184mr2366149ybn.39.1712341261719; Fri, 05
 Apr 2024 11:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405155855.3672853-1-arnd@kernel.org>
In-Reply-To: <20240405155855.3672853-1-arnd@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 5 Apr 2024 21:20:50 +0300
Message-ID: <CAA8EJpoVmyJhyrRz0p-8Ue0sa-XG+rSFwCajuR8b6GQVxBDM0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: remove an unused-but-set variable
To: Arnd Bergmann <arnd@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 18:59, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The modification to a6xx_get_shader_block() had no effect other
> than causing a warning:
>
> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error: variable 'out' set but not used [-Werror,-Wunused-but-set-variable]
>         u64 out = dumper->iova + A6XX_CD_DATA_OFFSET;
>
> Revert this part of the previous patch.
>
> Fixes: 64d6255650d4 ("drm/msm: More fully implement devcoredump for a7xx")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Unfortunately this fix is not correct. The proper patch is present at
https://patchwork.freedesktop.org/patch/584955/?series=131663&rev=1

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> index 1f5245fc2cdc..d4e1ebfcb021 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -840,7 +840,6 @@ static void a6xx_get_shader_block(struct msm_gpu *gpu,
>                 struct a6xx_crashdumper *dumper)
>  {
>         u64 *in = dumper->ptr;
> -       u64 out = dumper->iova + A6XX_CD_DATA_OFFSET;
>         size_t datasize = block->size * A6XX_NUM_SHADER_BANKS * sizeof(u32);
>         int i;
>
> @@ -853,8 +852,6 @@ static void a6xx_get_shader_block(struct msm_gpu *gpu,
>
>                 in += CRASHDUMP_READ(in, REG_A6XX_HLSQ_DBG_AHB_READ_APERTURE,
>                         block->size, dumper->iova + A6XX_CD_DATA_OFFSET);
> -
> -               out += block->size * sizeof(u32);
>         }
>
>         CRASHDUMP_FINI(in);
> --
> 2.39.2
>


-- 
With best wishes
Dmitry

