Return-Path: <linux-kernel+bounces-106106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C6687E93D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF90B2167F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D2381B0;
	Mon, 18 Mar 2024 12:21:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013DFA2A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764500; cv=none; b=qgpuDkCDRQZG0/OuyZd97M7Pd/pPaSOnzdLFtco6Br+wAvsWczN+fmwIHQLgrv1uBtjzTlBvXIiqcsdlVje23a7/0Z9ZSF89YPxNpSSAtptWOKW15IkOe3MTi+t7eXDIFkq6VqtiLq5inb8EbCRQd+ZnIFsTLAAD02NIhWR/gRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764500; c=relaxed/simple;
	bh=QJgUMhgnGoBqLU3vlvcKVDzr6lGw90lJFubuJOd9aNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTA6j2h4ZR3/NB0Q3IbTkoQ19vsPG5PdB7wQQUdm62f4YHGnhcWE4OeHVoUagkN37lwFV2fk/qKDQ+UiGcmHyyoPeFNBs9PoIZ0Z5gNWYgEA6SIiLjqzleLKIb3cJx2vTGUtDGdSYg7geLtBeR+cgqYiO5HIre5NlnsPJ0KKgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CAD0DA7;
	Mon, 18 Mar 2024 05:22:12 -0700 (PDT)
Received: from [10.57.12.69] (unknown [10.57.12.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 073553F762;
	Mon, 18 Mar 2024 05:21:34 -0700 (PDT)
Message-ID: <794bff85-4b59-42e5-ad6c-2a39609fe74f@arm.com>
Date: Mon, 18 Mar 2024 12:21:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Only display fdinfo's engine and cycle tags
 when profiling is on
Content-Language: en-GB
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240316231306.293817-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20240316231306.293817-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/03/2024 23:13, Adrián Larumbe wrote:
> If job accounting is disabled, then both fdinfo's drm-engine and drm-cycle
> key values will remain immutable. In that case, it makes more sense not to
> display them at all to avoid confusing user space profiling tools.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index eec250114114..ef9f6c0716d5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -550,10 +550,12 @@ static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
>  	BUILD_BUG_ON(ARRAY_SIZE(engine_names) != NUM_JOB_SLOTS);
>  
>  	for (i = 0; i < NUM_JOB_SLOTS - 1; i++) {
> -		drm_printf(p, "drm-engine-%s:\t%llu ns\n",
> -			   engine_names[i], panfrost_priv->engine_usage.elapsed_ns[i]);
> -		drm_printf(p, "drm-cycles-%s:\t%llu\n",
> -			   engine_names[i], panfrost_priv->engine_usage.cycles[i]);
> +		if (pfdev->profile_mode) {
> +			drm_printf(p, "drm-engine-%s:\t%llu ns\n",
> +				   engine_names[i], panfrost_priv->engine_usage.elapsed_ns[i]);
> +			drm_printf(p, "drm-cycles-%s:\t%llu\n",
> +				   engine_names[i], panfrost_priv->engine_usage.cycles[i]);
> +		}
>  		drm_printf(p, "drm-maxfreq-%s:\t%lu Hz\n",
>  			   engine_names[i], pfdev->pfdevfreq.fast_rate);
>  		drm_printf(p, "drm-curfreq-%s:\t%lu Hz\n",
> 
> base-commit: 97252d0a4bfbb07079503d059f7522d305fe0f7a


