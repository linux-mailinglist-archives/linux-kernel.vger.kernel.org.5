Return-Path: <linux-kernel+bounces-129149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100368965E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFFD1F26727
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4D5B698;
	Wed,  3 Apr 2024 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jorrmBy+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D059167;
	Wed,  3 Apr 2024 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128586; cv=none; b=uvAscvimj81lZHIWYHs+7/ZtHh+Oq57dN7KgQxER/szNuHYBc0bEhXCezNnsxW0De0piky3Af6/A55srwncpIXIu5Ivz1NuWcVAhBXYMMG2YWAqSKOLFnYtMYgD3DdJwwBQz3S+X5uIUxWiRXJaHZ4pIB3a3uNBK6BHf2iej8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128586; c=relaxed/simple;
	bh=tQNrSIQZaUNiT99nJmQcFMOdFkIJCNIcfgUU7cMY014=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eO+zi8+ZNHn9vFHmFL768+1aIrpX0bjO1YJhDdHRUMv2ZL0teQOBusa3+ctFk57glP33GAPz9CNChA+9Eqg4CxRhAXSbG9SMzQPKmVGY5O5D86k9AJGLWUXz0IMAxkHG4hiBNHVYPLugg1c+8MDt8aeS7dFTezhX3aZzkQ5XG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jorrmBy+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712128583;
	bh=tQNrSIQZaUNiT99nJmQcFMOdFkIJCNIcfgUU7cMY014=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jorrmBy+xuAHaTUDZDC3n8cN2n+mOsfFW2Mapxt096gNM5ok2AFePSCjKR4SpcHiw
	 yEgEsnuxsQDebvznavMawWl+3r17M4KAPJuTo6yBTdJ6G1BtglWCfdxWoyGzW6jsLS
	 /LtTmEMmLCgzJaMKEo/nQN4LcwEDFmo7aVi8rNqZm+qq8BVYPHAMqs+wCugZZFPrNz
	 341fNCzUBgzTR9cEibMqFsmiKEip2yFFfaY61W+wBg/EIG4UGSa/opkOlVkNznDO8A
	 Whxf548DTN01baAjAl+A6ajvnbQedbTzVBhtJPc1npwmItAoasXdV91+4LQI7/+wjI
	 uY49GHa0JJaEQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A207137813DC;
	Wed,  3 Apr 2024 07:16:22 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:16:21 +0200
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
Message-ID: <20240403091621.4b084d6f@collabora.com>
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

Queued to drm-misc-next.

Thanks,

Boris

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


