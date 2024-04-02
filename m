Return-Path: <linux-kernel+bounces-128097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB8895613
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2421C228D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0577F85930;
	Tue,  2 Apr 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eYMHzK4k"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA384039;
	Tue,  2 Apr 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066613; cv=none; b=owHOQTgzyiUh6X/0N68oRHKiC4WlI3o1XbxyCtTalLg/b6q95+4zvbV1KJA9NdKLt1YUHg8I7+lfopzRDH7/FHCVHYQ3Iyw3dy95ASPEr5u+49JFiYRekNAEXNQDnShWPAJ2FoCCwlJ4bAFkCoCEdPsJfrR6ndgMDwIpvJwAEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066613; c=relaxed/simple;
	bh=z1W91oM6IDFMd2omLyWaXgA51zALzHBgu6g0WR/MbWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehFjdyzgiYdRDYH08+YA4KmS2D3TtQgzvEfPpkQDrZZd1YaYHHF5cwV+HcHRHQAZLa3qWdEOhwFzixDXGA6B/ozK8n3bwx9IfMHUC0dAEvS1wbIPqNtmnoO+1xcqOhODLPxRKrN/Z28iecrDBs+X3iTnDnATe9YJ0QDeLFzXYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eYMHzK4k; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712066610;
	bh=z1W91oM6IDFMd2omLyWaXgA51zALzHBgu6g0WR/MbWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eYMHzK4knUz5a3tzw3v+SkKfX0frmiqXbgQ+PKSZKmE/nymmMHvXW7yMR2KdB8cFp
	 MoyE5iNxkEM9eqYC+UFCjNw4I9c36qgt9jmPvn3fAdH3tI2bkWOgLlTskMnqe1BuWE
	 LheD8y3Fa7CsB7xEpGNlI2piwXYxDbU5rsQyMB2nwsTKJ/NhqTWoeMl50/gCxzC7QP
	 HU2ylw2XWO7zM75gtdtNuHQ/nftAjbEXBBPKi30KtLj1xg/sxR3wTVoxMOGVvqcmW3
	 1CbSZ8zhCKDQWdhZ0xsmFniFVbKScDJYaBLXulxn+ICOrGRPVOj3xCvwEz93d58MLx
	 Zo728tQpyDGFA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4D215378201D;
	Tue,  2 Apr 2024 14:03:29 +0000 (UTC)
Date: Tue, 2 Apr 2024 16:03:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Grant Likely
 <grant.likely@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
 kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] drm/panthor: Fix NULL vs IS_ERR() bug in
 panthor_probe()
Message-ID: <20240402160327.60fb37e8@collabora.com>
In-Reply-To: <20240402104041.1689951-1-harshit.m.mogalapalli@oracle.com>
References: <20240402104041.1689951-1-harshit.m.mogalapalli@oracle.com>
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

On Tue,  2 Apr 2024 03:40:40 -0700
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> The devm_drm_dev_alloc() function returns error pointers.
> Update the error handling to check for error pointers instead of NULL.
> 
> Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> This is spotted by smatch and the patch is only compile tested
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 11b3ccd58f85..1b588b37db98 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1385,7 +1385,7 @@ static int panthor_probe(struct platform_device *pdev)
>  
>  	ptdev = devm_drm_dev_alloc(&pdev->dev, &panthor_drm_driver,
>  				   struct panthor_device, base);
> -	if (!ptdev)
> +	if (IS_ERR(ptdev))
>  		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, ptdev);


