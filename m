Return-Path: <linux-kernel+bounces-126594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C952893A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5351C20FD0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9FF17548;
	Mon,  1 Apr 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUZ0YZfK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AFA111A9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711967211; cv=none; b=ppNlM0uxMHd1bj5PPYc7BiO9KcmyoczT9vCKjpkO6FDkHL2a0RtAv34JvMJ2ota7Zql9vlQrD5qNEc53/IPRg6M/ufY1dS1gtwv5Tzn8EZJ4bcjO3IO29bEcfF62rtsEicppP2NCutVqFrhd34aWuv7Z3ADWxAvPrTQQ+sHnmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711967211; c=relaxed/simple;
	bh=fkSe66/Q1Go+FddjcHg7uLOKDrXljh1xezXarfXBsNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iwhl20UnXu/40jnB0YBalOE2W3Z63fEsDQFmPCw3eROjA06sQr7aAkUVkIhba+nPy9BKAoLKKRUa/1OJwmjtnIhoQMuYl9pzbYiSIhemjMm2gadadZo7Q4xdeTMZwX/2Hse98Cw/i2ePlpIXkATkKXxLpOWCrxGPuLwNO26kx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUZ0YZfK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ea7f2d093aso3608416b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711967210; x=1712572010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JjwzJvN7Hav8Gfx5C17pz9b7G+QKQ828bVeZeg9IPps=;
        b=TUZ0YZfKFOSB50aLlKBagsNzqXojuFIvoQbZ6OI07Awx7X+y+UFA8PfbJ9GH4mBT/d
         Ap83I3uP8LqiHkOof4/Cpdy/2Pem9loRhQQRj6o/DOP0yJ5nxJKbrGYSyT9e2VSmhI9H
         Vt+Ffbc3cHgVuLztQIK8gs5lJzIQpql9j0G7khl0YvpmIxcxBdjIre74Fd8hngPUY+FI
         PKlErgr/oATFbxCO0tg72byp20cfyXEKlw2LeGTtHmuqzzJQbnZFHa+17qb7zTltoL5N
         upF7YGucQikDwh7skCZ9nNGK7CZwzcaaIVT5b0e212NbpGGnY3gA+kt3eXkcW/umKfm6
         TKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711967210; x=1712572010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjwzJvN7Hav8Gfx5C17pz9b7G+QKQ828bVeZeg9IPps=;
        b=wshhsmnQWkamL25i+QWAM9rpHfkyPYIg/cKZaI5wDN3lglgzsvVNuOYD1x6kXdiZda
         cOPMlcPuU0TktJLxso0tuEcSeRktYtCvaE+e8zFiLiZ9tUkxo6pPcAevVeHC3nFF0xHO
         5RanxsYwDtVUJesoH8Drg6oGjFaXzXNnOVje8OT0gLUvyjBWF5gr36H+6nksXUMZPij9
         3hkCF3XT/crD+EqXIzuc3J9+BwCk3SP85h3cxNzA83V02coO7a4hQ0XERMqAZtSb+ZfO
         MhM4npngAIEM9PErU+OT0Byd1zYOkBpRpJffZ1f4cVvMCv4zffaozP937pDh4LDItIQ6
         kVkw==
X-Forwarded-Encrypted: i=1; AJvYcCVNU5UaqToHG+R9EIGfIR0CJmn4w6y+BYokMcZl/SjtaPRQurojbsVY/8F5IcGipWSAC+JIQcjRDbqB8nggvoLTNpTd1AwhkaPOD+7o
X-Gm-Message-State: AOJu0Yz8nPgUBx/E9Of+lflziN383JD/pd3hd7tpJnvttgaBEldt2x4l
	81dKMR2t3eDfIKMaY/llviYBqPhlWHhA1rh6o7M+lVdd5FJhrHDB1bE2S1V8Eab66yMXfFPQVWU
	MInU3CPDG7pn6V22vMbB37ZseJCA=
X-Google-Smtp-Source: AGHT+IGYkH5Sb7GgjlSrymSb6EhYbcInrAsRHLbXoz9xykBVamWmNo/n2ubQhgDjpR+t6aXA3b/qp3QyHjPWtzIsMW4=
X-Received: by 2002:a05:6a21:a58a:b0:1a3:dc27:1f01 with SMTP id
 gd10-20020a056a21a58a00b001a3dc271f01mr8646378pzc.11.1711967209548; Mon, 01
 Apr 2024 03:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330205241.92711-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240330205241.92711-1-krzysztof.kozlowski@linaro.org>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 1 Apr 2024 12:26:37 +0200
Message-ID: <CAH9NwWfU5eaBRSqhgJgHwgphtL+KUAiX3Tx_7vO11N_BV7qUQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.  Whatever is set here will be anyway overwritten by
> main driver calling platform_driver_register().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 734412aae94d..87b31cfee41d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1995,7 +1995,6 @@ static const struct dev_pm_ops etnaviv_gpu_pm_ops = {
>  struct platform_driver etnaviv_gpu_driver = {
>         .driver = {
>                 .name = "etnaviv-gpu",
> -               .owner = THIS_MODULE,
>                 .pm = pm_ptr(&etnaviv_gpu_pm_ops),
>                 .of_match_table = etnaviv_gpu_match,
>         },
> --
> 2.34.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

