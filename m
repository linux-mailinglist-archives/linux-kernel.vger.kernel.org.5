Return-Path: <linux-kernel+bounces-129145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E98468965D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514B9283687
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4557321;
	Wed,  3 Apr 2024 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ViAfPzC1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450054909;
	Wed,  3 Apr 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128543; cv=none; b=N6asX5B1gKUW7i1zP/LYNYnYOhPymu2hzWKEfu4FbRpbX6LtrxG09VDYCdWdVAoMfA54Or62KCA690oh3ZtlD3YHAcldJam0jaHwsCdNBotqE5Lme9jkLhtjPHd7DmD4VUaKrnQLxRHCVqFE8RTkQ0wtjqLJWfLOzxjczouzZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128543; c=relaxed/simple;
	bh=O2Nzrqa1UBTMb8L+eVoapV/8MuTe2W1MsZDuTz8sSHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFhv8zNz5/DF6C1sIgt5fgqfyKNa6n/uzD8FL7K8O8auPMz4GYGUfsiU4d9BsepvO+E652QS7xL7zDn/BLRsj/f28vLUpH9lXiFSzgSgn/rATokedGHnyGjAsOltDtHhrGLkVATtwUUAX0ZL0p5nBif7TVdA9gun6bPx43sjPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ViAfPzC1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712128540;
	bh=O2Nzrqa1UBTMb8L+eVoapV/8MuTe2W1MsZDuTz8sSHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ViAfPzC17nr2LDYMZ6/FxnERiwG3pLNtEQ1PhWB3lBg4eqEx/rNxSY2FGP4+P5IKo
	 xcwLa4vQiJoE5g6opA/TB04PVtK1hxoyxc17ROithVL6mJgFYM6c7ipDie2lqBS5NV
	 N7taljBXd72ojJvAVzcGTF9S0hyN3SlwIzln4ZiES8NCrb9Ds73SYHIi8PY9wtDe4l
	 YT4UcYDUpqwc8fiiH0twCSpSAEIk7cF/W1ILel1D7L6SuNaqBFfCZ3nynWrGzrUsED
	 S20AqxcjXw1rbd8uM1tq/pNoRf7s2niM+KTIEAqYk2jSQMUJXS2BuXLYiGPM+jGSR2
	 k6lz9WKCHC58g==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6464F37813DC;
	Wed,  3 Apr 2024 07:15:39 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:15:38 +0200
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
Message-ID: <20240403091538.1b958019@collabora.com>
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

Queued to drm-misc-next.

Thanks,

Boris

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


