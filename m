Return-Path: <linux-kernel+bounces-127940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44249895309
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09562822B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB8678285;
	Tue,  2 Apr 2024 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MPao5FQW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F60BE5E;
	Tue,  2 Apr 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061223; cv=none; b=oTaWGB3G8Xw872e27q05OBhO/xJdrA8hTA8S0blpELecWJpPUZIXethjS9WSbUtDAi3GwWu9LWPbAP7RsMr4qlONO5WWfULOEZsOYVROrpetFlHQAziaEw+N0vugvUyOyzUIrltieu0U0oLHmL97K1UyPSKQoi1+iPc1rZzuung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061223; c=relaxed/simple;
	bh=JLmZSWuKKx+DVDXAfY3j+SHJ7sahDXjArNMQEbFiR2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJr5WE6ebX4xZ/IQS9ui8B8ZmZxQgFZmZZgoDsQf1HU67ZIvhGj2wjXuMTIYvdQil4EQyiqoUlp+bnTviz8tBY0B+x6Hvk1vVhaejWmdUlrTbLDOrem5qEHXwWEV+wOVKYJkluRq7Vj/T8fuzOn3LgbT6cuUiYdot/ej6iNR7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MPao5FQW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712061220;
	bh=JLmZSWuKKx+DVDXAfY3j+SHJ7sahDXjArNMQEbFiR2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MPao5FQWlgblzY4+H4T7w1x53Xgi2A22qSAWdaDILfOuL0LXfVA7Ebap+eNPpKBCu
	 ovvfKyrcDo8wWY8OOLpZLu8qAfNNwyv7vgWJKw66R4NWee0dPjZnBEUUyKf1enABbS
	 ofcyWYPSxJ0XpbPG9AkzQVTbEiE1SWojFlRLTcBNbgDTOlovCMgxx2lZwYuYRUbM2f
	 F5TLUFOpRqUpQuNJX3dc2myKejsI/JPKOCalAnSU88jdmyVRo9M6xKTWPkIdvVJBlx
	 U63np1fBvPCJEm8q9HZ1OqjGSZnwEVQKUDp0vaHrcBCtKU77bOUtkO1h7fellVI6/i
	 tQOFBfmce5LwQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3DC1A3781144;
	Tue,  2 Apr 2024 12:33:39 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:33:37 +0200
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
Message-ID: <20240402143337.38e864e9@collabora.com>
In-Reply-To: <20240402103358.1689379-1-harshit.m.mogalapalli@oracle.com>
References: <20240402103358.1689379-1-harshit.m.mogalapalli@oracle.com>
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

Hello Harshit,

On Tue,  2 Apr 2024 03:33:58 -0700
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> panthor_vm_get_heap_pool() returns ERR_PTR on failure.
> 
> Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is spotted by smatch and the patch is only compile tested
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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

Actually, panthor_vm_get_heap_pool() will return NULL if there's no
heap pool attached to this VM and create=false, so this was correct.
This being said, I'm fine making that consistent by returning
ERR_PTR(-ENOENT) instead of NULL in that case. This way we don't have
two different semantics based on the 'create' value.

Oh, and please merge everything into a single patch instead of one patch
per call-site.

Regards,

Boris

>  		goto out_put_vm;
>  	}
>  


