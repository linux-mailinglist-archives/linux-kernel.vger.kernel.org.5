Return-Path: <linux-kernel+bounces-116771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD5D88A3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20111F3DA34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB116EC1A;
	Mon, 25 Mar 2024 10:43:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916F10A3C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362499; cv=none; b=HQ4ebSqXZIFO9x6TIgPrBfgOamF8xXaqaLLNG8nkVDjBtglS9ovLTOTy1Nb+eV1vN2clZg2XcqQrpgyRWY0kD7b7rjwdXq5i1OF65N0WGZhGRvB8PvEHvdyduoX9aEYJh7hfNwZ+iF5igIGU7xW600eH6dNa8wsnETEAXEir9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362499; c=relaxed/simple;
	bh=Nsg5DTB9FmEllyTeXNhd2P7XdwJT0Qf+yploy0EirU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=blmYTIAkqQvNEIFwTkJAFLZQdC4V+dpFGmM8G3l/w26KeX56brZg3VVfobIkNxRtGDrZ7uhmImGzu4E6GGqrJmPwl9vfbVRYEJQNjz7BVmT7KPGnrjjct3KGbZ8HY/tdTFjFUvvplxDJFhGsXHWYthQ1L7AZ+mSW107tjcuwHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0F20C15;
	Mon, 25 Mar 2024 03:28:50 -0700 (PDT)
Received: from [10.57.15.178] (unknown [10.57.15.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 085F33F67D;
	Mon, 25 Mar 2024 03:28:14 -0700 (PDT)
Message-ID: <bad16bba-5469-4f20-bf23-7f3c2953edc5@arm.com>
Date: Mon, 25 Mar 2024 10:28:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: fix power transition timeout warnings
To: Christian Hewitt <christianshewitt@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240322164525.2617508-1-christianshewitt@gmail.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20240322164525.2617508-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 16:45, Christian Hewitt wrote:
> Increase the timeout value to prevent system logs on Amlogic boards flooding
> with power transition warnings:
> 
> [   13.047638] panfrost ffe40000.gpu: shader power transition timeout
> [   13.048674] panfrost ffe40000.gpu: l2 power transition timeout
> [   13.937324] panfrost ffe40000.gpu: shader power transition timeout
> [   13.938351] panfrost ffe40000.gpu: l2 power transition timeout
> ...
> [39829.506904] panfrost ffe40000.gpu: shader power transition timeout
> [39829.507938] panfrost ffe40000.gpu: l2 power transition timeout
> [39949.508369] panfrost ffe40000.gpu: shader power transition timeout
> [39949.509405] panfrost ffe40000.gpu: l2 power transition timeout
> 
> The 2000 value has been found through trial and error testing with devices
> using G52 and G31 GPUs.

How close to 2ms did you need in your trial and error testing? I'm
wondering if we should increase it further in case this might still
trigger occasionally?

kbase seems to have a 5s (5000ms!) timeout before it will actually
complain. But equally it doesn't busy wait on the registers in the same
way as panfrost, so the impact to the rest of the system of a long wait
is less.

But 2ms doesn't sound an unreasonable timeout so:

Reviewed-by: Steven Price <steven.price@arm.com>

> Fixes: 22aa1a209018 ("drm/panfrost: Really power off GPU cores in panfrost_gpu_power_off()")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 9063ce254642..fd8e44992184 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -441,19 +441,19 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
>  
>  	gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);
>  	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_PWRTRANS_LO,
> -					 val, !val, 1, 1000);
> +					 val, !val, 1, 2000);
>  	if (ret)
>  		dev_err(pfdev->dev, "shader power transition timeout");
>  
>  	gpu_write(pfdev, TILER_PWROFF_LO, pfdev->features.tiler_present);
>  	ret = readl_relaxed_poll_timeout(pfdev->iomem + TILER_PWRTRANS_LO,
> -					 val, !val, 1, 1000);
> +					 val, !val, 1, 2000);
>  	if (ret)
>  		dev_err(pfdev->dev, "tiler power transition timeout");

As Angelo points out the tiler probably doesn't need such a long
timeout, but I can't see the harm in consistency so I'm happy with this
change. If my memory of the hardware is correct then the tiler power off
actually does very little and so I wouldn't expect it to take very long.

Steve

>  	gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present);
>  	ret = readl_poll_timeout(pfdev->iomem + L2_PWRTRANS_LO,
> -				 val, !val, 0, 1000);
> +				 val, !val, 0, 2000);
>  	if (ret)
>  		dev_err(pfdev->dev, "l2 power transition timeout");
>  }


