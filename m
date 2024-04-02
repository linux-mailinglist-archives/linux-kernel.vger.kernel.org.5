Return-Path: <linux-kernel+bounces-128096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8058189560F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FE8284729
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D211186AE6;
	Tue,  2 Apr 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aynbUfgX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFCA86266;
	Tue,  2 Apr 2024 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066552; cv=none; b=OSw4uTE5xG1rmt9SWSdOSuzT60mc8iQuPg7fZHvk75C57STISI5Y1l7BYtkSAq1vi3N4vOpsr7ZhlK2snUFa/SqNJG4Rx8qeOjeAZ+pwQEWTDGaOkLOzzT9Fv8XiwpUtjihzSvRl+86zuldhAtyd7KnmZs1gHYPG8ECQlJ/uAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066552; c=relaxed/simple;
	bh=+5RKOetbmxrtVOG6OyPkEeOWhTsHnv/SA812/SjWp1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIIzsc03SrGJ1UbJJ9z2eMbr4m5wJMDgWYaPYx0ki5+JbnW0nwlxdCAwvAVZoBywc2rd/4Sln2hWGQfSiuFRLkfrrV7omn3KE7fL16weYWa47mWXHB76uOTxmkMJU9uL45v1PRixq5Zs2wbgU1uL2JMJ3ubnwkl/dYecb9DF2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aynbUfgX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712066548;
	bh=+5RKOetbmxrtVOG6OyPkEeOWhTsHnv/SA812/SjWp1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aynbUfgXtmFBI2TkptFysjrYmTBYsmBpzDAsaLfwmUIC7bzDKk3tRel1qxR3Yd2PO
	 7wn1yQ9mDlU942oV1kE7MudRx9/gFwjYYkewplyD7Gdmcouah6y6wdTXzrd/rhF5yl
	 /blDxRT+es9nJHjkpXG71Hr1+ytOFUCJN89m3J9WXRFageVYQpJjQvDYhDH1r2muks
	 a5WiQKUJs1+V+bkYNyYL9HRfgLvA+OVO4HtqYOhkDg+juj3jdmaPXDjwM+qaig6QAl
	 heJYINY1FBgn3/3E7+u8Wxsyg4F76rvXqPuZUhQ1OPbG4BvoVBumCsNONcdEtVwEoA
	 WLFXE366ysDZw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 981343780624;
	Tue,  2 Apr 2024 14:02:27 +0000 (UTC)
Date: Tue, 2 Apr 2024 16:02:26 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
Subject: Re: [PATCH v2] drm/panthor: Fix couple of NULL vs IS_ERR() bugs
Message-ID: <20240402160226.4a1ac2d1@collabora.com>
In-Reply-To: <20240402134709.1706323-1-harshit.m.mogalapalli@oracle.com>
References: <20240402134709.1706323-1-harshit.m.mogalapalli@oracle.com>
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

On Tue,  2 Apr 2024 06:47:08 -0700
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> 1. The devm_drm_dev_alloc() function returns error pointers.
>    Update the error handling to check for error pointers instead of NULL.
> 2. Currently panthor_vm_get_heap_pool() returns both ERR_PTR() and
>    NULL(when create is false and if there is no poool attached to the
>    VM)
> 	- Change the function to return error pointers, when pool is
> 	  NULL return -ENOENT
> 	- Also handle the callers to check for IS_ERR() on failure.
> 
> Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is spotted by smatch and the patch is only compile tested
> 
> v1->v2: Fix the function panthor_vm_get_heap_pool() to only return error
> pointers and handle the caller sites [Suggested by Boris Brezillon]
> 	- Also merge these IS_ERR() vs NULL bugs into same patch
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c   | 6 +++---
>  drivers/gpu/drm/panthor/panthor_mmu.c   | 2 ++
>  drivers/gpu/drm/panthor/panthor_sched.c | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 11b3ccd58f85..c8374cd4a30d 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1090,8 +1090,8 @@ static int panthor_ioctl_tiler_heap_destroy(struct drm_device *ddev, void *data,
>  		return -EINVAL;
>  
>  	pool = panthor_vm_get_heap_pool(vm, false);
> -	if (!pool) {
> -		ret = -EINVAL;
> +	if (IS_ERR(pool)) {
> +		ret = PTR_ERR(pool);
>  		goto out_put_vm;
>  	}
>  
> @@ -1385,7 +1385,7 @@ static int panthor_probe(struct platform_device *pdev)
>  
>  	ptdev = devm_drm_dev_alloc(&pdev->dev, &panthor_drm_driver,
>  				   struct panthor_device, base);
> -	if (!ptdev)
> +	if (IS_ERR(ptdev))
>  		return -ENOMEM;
>  

Sorry, that one deserves a separate patch.

>  	platform_set_drvdata(pdev, ptdev);
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index fdd35249169f..e1285cdb09ff 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1893,6 +1893,8 @@ struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
>  			vm->heaps.pool = panthor_heap_pool_get(pool);
>  	} else {
>  		pool = panthor_heap_pool_get(vm->heaps.pool);
> +		if (!pool)
> +			pool = ERR_PTR(-ENOENT);
>  	}
>  	mutex_unlock(&vm->heaps.lock);
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5f7803b6fc48..617df2b980d0 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1343,7 +1343,7 @@ static int group_process_tiler_oom(struct panthor_group *group, u32 cs_id)
>  	if (unlikely(csg_id < 0))
>  		return 0;
>  
> -	if (!heaps || frag_end > vt_end || vt_end >= vt_start) {
> +	if (IS_ERR(heaps) || frag_end > vt_end || vt_end >= vt_start) {
>  		ret = -EINVAL;
>  	} else {
>  		/* We do the allocation without holding the scheduler lock to avoid


