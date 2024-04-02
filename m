Return-Path: <linux-kernel+bounces-128039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37578895548
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA31C2116F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE583CB8;
	Tue,  2 Apr 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R8R/6ORe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0360B96;
	Tue,  2 Apr 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064325; cv=none; b=M0UFhFHERvSKG6sprXifxNknz+iBVLWzKAKOrmiP5uUIOqv5Y+g+VfvYwNc1tBEZDDXPBFRlPUEGyejaD/fpXceNu6oHIxu95wcf7AnLmEWT5WPiZyDa7XzkZeb1MFB+FIjCuH5+UI+WNkeMkwCfqebJKO8AXf04BP4VYZ2TVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064325; c=relaxed/simple;
	bh=1v3QOGppWekBTgTfFoLAKTfSV10L40o6xnBh0P7fjL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAvuDyFV7ZQWv1T1Q4R2ZZ5faXZnYGsRQLAykrXmfcWsTBF044GMUaUtseDfsfU/rya5f+W2LXPfc00hZEWziFTaMWGznzxds/xUwxvhfG8qYSyd3Qva1txYXSAjV6GzPALpy3wQL3C1/htUE7uhJokfOX+FVGQR7IQAEFZMo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R8R/6ORe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712064321;
	bh=1v3QOGppWekBTgTfFoLAKTfSV10L40o6xnBh0P7fjL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R8R/6OReSj3ByQgzd3vxsKtogZ5GbkeQBrvpi3a/j0l9wQ+nheeHI6vakJINpccrK
	 KLaq1HJ4DL7v/yhhbQWgsLF0D6veDhRG7zk1gqspBV8l6To9kHfvSmisv47IH4DQAa
	 lJ4fTeqBqz/TjNcKDPcmYNDS9Whw9Mv9NmohCu9oVB7yRqkTRNLaEC1cgdpofiCqC1
	 97jkafuwt1ka6HF/uED/rmxxDpb4WebgrZGuJP7eraFkQT9wVEE6uq8dr6zWxCH1wK
	 DuyYGVLrGDal4vogDxbHQgC4AGA6mP+YZN7tWWLjuVW4mCejJaCz5SrmC+kp1DPjBU
	 PMNPH3caza43w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6F7F937803EE;
	Tue,  2 Apr 2024 13:25:20 +0000 (UTC)
Date: Tue, 2 Apr 2024 15:25:19 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
 kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] drm/panthor: Fix NULL vs IS_ERR() bug in
 panthor_ioctl_tiler_heap_destroy()
Message-ID: <20240402152519.48857445@collabora.com>
In-Reply-To: <99b0bc65-a3ce-4522-a1dd-a304498fc453@oracle.com>
References: <20240402103358.1689379-1-harshit.m.mogalapalli@oracle.com>
	<20240402143337.38e864e9@collabora.com>
	<99b0bc65-a3ce-4522-a1dd-a304498fc453@oracle.com>
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

On Tue, 2 Apr 2024 18:52:12 +0530
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Hello Boris,
> 
> On 02/04/24 18:03, Boris Brezillon wrote:
> > Hello Harshit,
> > 
> > On Tue,  2 Apr 2024 03:33:58 -0700
> > Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
> >   
> >> panthor_vm_get_heap_pool() returns ERR_PTR on failure.
> >>
> >> Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
> >> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> >> ---
> >> This is spotted by smatch and the patch is only compile tested
> >> ---
> >>   drivers/gpu/drm/panthor/panthor_drv.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> >> index 11b3ccd58f85..050b905b0453 100644
> >> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> >> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> >> @@ -1090,8 +1090,8 @@ static int panthor_ioctl_tiler_heap_destroy(struct drm_device *ddev, void *data,
> >>   		return -EINVAL;
> >>   
> >>   	pool = panthor_vm_get_heap_pool(vm, false);
> >> -	if (!pool) {
> >> -		ret = -EINVAL;
> >> +	if (IS_ERR(pool)) {
> >> +		ret = PTR_ERR(pool);  
> > 
> > Actually, panthor_vm_get_heap_pool() will return NULL if there's no
> > heap pool attached to this VM and create=false, so this was correct.
> > This being said, I'm fine making that consistent by returning
> > ERR_PTR(-ENOENT) instead of NULL in that case. This way we don't have
> > two different semantics based on the 'create' value.
> >   
> 
> Thanks for explaining. I missed the case where create is false and there 
> is no heap pool attached, so panthor_vm_get_heap_pool() can return NULL.
> 
> 1878  *
> 1879  * Return: A valid pointer on success, an ERR_PTR() otherwise.
> 1880  */
> 1881 struct panthor_heap_pool *panthor_vm_get_heap_pool(struct 
> panthor_vm *vm, bool create)
> 
> The documentation says it returns ERR_PTR() on failure, so is it worth 
> doing something like:
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c 
> b/drivers/gpu/drm/panthor/panthor_mmu.c
> index fdd35249169f..e1285cdb09ff 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1893,6 +1893,8 @@ struct panthor_heap_pool 
> *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
>                          vm->heaps.pool = panthor_heap_pool_get(pool);
>          } else {
>                  pool = panthor_heap_pool_get(vm->heaps.pool);
> +               if (!pool)
> +                       pool = ERR_PTR(-ENOENT);
>          }
>          mutex_unlock(&vm->heaps.lock);
> 
> 
> and change all callers of panthor_vm_get_heap_pool() to only check for 
> IS_ERR() ?

Yep, that's what I had in mind.

> 
> 
> > Oh, and please merge everything into a single patch instead of one patch
> > per call-site.
> >   
> 
> Sure, I noticed one after the other. I will fix them together in v2.

Great!

Thanks,

Boris

