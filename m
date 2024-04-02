Return-Path: <linux-kernel+bounces-127927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004498952D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C171F22DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB42C7EF12;
	Tue,  2 Apr 2024 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="glnejwao"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D478B63;
	Tue,  2 Apr 2024 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060466; cv=none; b=QopZshPSoUzaPcHgNvulzwtONc7uVl6Rho6OWPL965StdGnHHDhTmWCHyOK1jJRwSbXMV0TKfuY2/HvOfWOG0qaGf5gMHmh5XU+ZtWPDdwJ24n2PxVXVz86cMlpA8tMtiwm/M9As5GPYvo3/Lc025wQdUNKnqGOiZONPlMdjffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060466; c=relaxed/simple;
	bh=xyAFVVSrUaZelYKAVF4nMxj60RRWxZjPtQr6WMey4Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqV2aoidKoBZYUroqxybYMAp/w3/GdLYgCUDc1jm5ABm+y/V8HfSTOnGcgmwsUJ0ymijaWrWbwnuprOg7KrqTSNQjOpz1DJggdRqQHRFgvnP6P0y30f/rcgPj19Kl9hSQoclCvHCB6NtNkaIrvTYQsXdOuTI2AvZWs8nE44AJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=glnejwao; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712060460;
	bh=xyAFVVSrUaZelYKAVF4nMxj60RRWxZjPtQr6WMey4Mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=glnejwaovaa1DO8cccp6ZRvs2DNHxoE3trZF+FEuDKp8m43onB4hwOknMkYcQ7yYj
	 aTXzdvcnAilQ+WznEWbbl/6vkY8v7R4ksPGclv/lcjQVwd56tOTohiseugslKDp1eZ
	 +yrnjF9WQuNuD5qvTrTLloHtZ6mNbXgo8vwc+eKgFNB38j/yAt0nF93MFhpiiMeU9B
	 hQEEEShmHXDeZOvYBSDOR33tAYOzpKt1TH53/EMULZOeq8WLHBsca3gY1pbFOPjWHC
	 Owng3d9WO3P4AHfQCIheDlq0ptGb92pDoakhxqEjGUi3e5WLS/CBgS+cdmkDH7aNre
	 Y09oy5O2JEVAA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CFAD03781144;
	Tue,  2 Apr 2024 12:20:59 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:20:58 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix error code in panthor_gpu_init()
Message-ID: <20240402142058.5477a9bf@collabora.com>
In-Reply-To: <d753e684-43ee-45c2-a1fd-86222da204e1@moroto.mountain>
References: <d753e684-43ee-45c2-a1fd-86222da204e1@moroto.mountain>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 12:56:19 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> This code accidentally returns zero/success on error because of a typo.
> It should be "irq" instead of "ret".  The other thing is that if
> platform_get_irq_byname() were to return zero then the error code would
> be cmplicated.  Fortunately, it does not so we can just change <= to
> < 0.
> 
> Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 0f7c962440d3..5251d8764e7d 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -211,8 +211,8 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  		return ret;
>  
>  	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "gpu");
> -	if (irq <= 0)
> -		return ret;
> +	if (irq < 0)
> +		return irq;
>  
>  	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
>  	if (ret)


