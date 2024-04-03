Return-Path: <linux-kernel+bounces-129152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B568965F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AC8283E89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A2D58AB2;
	Wed,  3 Apr 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fpzKnh7x"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C855E4C;
	Wed,  3 Apr 2024 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128654; cv=none; b=jvmA24E/yrnEI3gGo31xWv+cAD1Uym2ZHSqHDVa44h+g7blfKVnlQg4cX+JH7n/feZkJQ/0K/ZeInlH2QiHdJGExnGB4TqC+qCJIMlPPYF+FMGAR2jCgt+afd9CeGX2INNZ9mw71scy9RLHXU1XnRNt2GF4ubevoEJg6ccuTgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128654; c=relaxed/simple;
	bh=giI6NaojbtQUk1Eg3/a0cqsEEDAa0RKQuXJtER1B5oU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3NSoQhAd4TR3EpN19vuow3sCGFF6FpmWNbBOVhHIAjo6LN39hW/hQcuL+eySDiOm5WugDfEF1TKDRQJUcNsa8fhFQEeLjIGG/ZIxwfXgB8pqpQft1OLa1MVxTKJJA6PaDuvkxbjPyYqhMKGeLXMG7bkRsVuwH0Ct4DLBqxUwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fpzKnh7x; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712128651;
	bh=giI6NaojbtQUk1Eg3/a0cqsEEDAa0RKQuXJtER1B5oU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fpzKnh7x9C6DJv84MTk62JBdoVhIv0+ptCjICXqx2R1qHS2oyYm8VOptNdJnWhUbB
	 WgUiLGzCque7hnwZwrEwU30mo3Q3i6YUKRRcwboAh55v3NzEKS0DxCX51v19dUpR1a
	 d7Ny+lGui8Zwn7sfsBH5tpDKTGUaLVvz5XJnqEgcICr9NJKEy3FtXd0awSR77jgbAZ
	 DjerolkyMkMDhBgh6kcixbn3XgajpidlDRwvWtS7k9wIBP5tGEqzF8m/wd2yoi/TWm
	 fB/e9Sc3DAdJsBz2dfzd5WBWuNYBBFiQKhvgm1haKoGmOAhVci+lYDVOnE8cJ+E9P1
	 XvYAip/rPURmg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 06C8D378003D;
	Wed,  3 Apr 2024 07:17:30 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:17:29 +0200
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
Subject: Re: [PATCH v3] drm/panthor: Fix couple of NULL vs IS_ERR() bugs
Message-ID: <20240403091729.3100a6a1@collabora.com>
In-Reply-To: <20240402141412.1707949-1-harshit.m.mogalapalli@oracle.com>
References: <20240402141412.1707949-1-harshit.m.mogalapalli@oracle.com>
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

On Tue,  2 Apr 2024 07:14:11 -0700
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Currently panthor_vm_get_heap_pool() returns both ERR_PTR() and
> NULL(when create is false and if there is no poool attached to the
> VM)
> 	- Change the function to return error pointers, when pool is
> 	  NULL return -ENOENT
> 	- Also handle the callers to check for IS_ERR() on failure.
> 
> Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Queued to drm-misc-next with the following commit message:

"
drm/panthor: Don't return NULL from panthor_vm_get_heap_pool()
    
The kernel doc says this function returns either a valid pointer
or an ERR_PTR(), but in practice this function can return NULL if
create=false. Fix the function to match the doc (return
ERR_PTR(-ENOENT) instead of NULL) and adjust all call-sites
accordingly.
"

Thanks,

Boris

> ---
> This is spotted by smatch and the patch is only compile tested
> 
> v1->v2: Fix the function panthor_vm_get_heap_pool() to only return error
> pointers and handle the caller sites [Suggested by Boris Brezillon]
>         - Also merge these IS_ERR() vs NULL bugs into same patch
> 
> v2->v3: pull out error checking for devm_drm_dev_alloc() failure.
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c   | 4 ++--
>  drivers/gpu/drm/panthor/panthor_mmu.c   | 2 ++
>  drivers/gpu/drm/panthor/panthor_sched.c | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 11b3ccd58f85..050b905b0453 100644
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


