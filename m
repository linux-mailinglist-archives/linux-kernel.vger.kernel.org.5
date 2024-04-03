Return-Path: <linux-kernel+bounces-129147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADC88965E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAC41C22407
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573A5A105;
	Wed,  3 Apr 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IRwv3E0S"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBBD5A10A;
	Wed,  3 Apr 2024 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128567; cv=none; b=IBoBO9V3IHaUdVjfY6feV4g1vCaukcfX3DLjd8WTnuOkTspKnidS5x+hbvlBP0q1BZ6r6DAZXM86+G0EEb7u1gYToc4rKdv9aUNW+3m8x2XnIJeTW7Os1QF+Q9p02jgs1K2a2yTeJak2+TeW4HCd5nWl8DrE0tZ6Le0H+e8cqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128567; c=relaxed/simple;
	bh=lPEY9LAq6rCazZ/wYlUXoq5Wg9ti2sF5LYYoNELnQPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjOR+mZUd+rPuMR5dDR30vTbRgTYGS7grKu1a8LyhD4LM6BLgq38sRjWZVSaf3jibDfZbQTZDfKcEHeQDzMvdIYJUPBnGgEMOpq4G+kL6EPOZ+qkrVwbby925A6F6sVu+0Hx2v3/bLGsdFPz5TfPQx6PqO88xaRx8TTBZBK30TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IRwv3E0S; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712128564;
	bh=lPEY9LAq6rCazZ/wYlUXoq5Wg9ti2sF5LYYoNELnQPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IRwv3E0SZFUeFmQ8eJY2qltl5wtndpp2A7fMPHVx3hSqmBYPDqifOE2Oos81fcLxz
	 5flzyqrtCeOWJPs2JymYu9Letwf7lZF0ryY0OjGcGkuCgRyt2BRhEiki1VNmF40MXe
	 NkimKeRKo5rlerauUOuAtrfvvCGh/9FdLwD3CI+d5eL22MuvSUG9F3GCoek/D2D60c
	 fze0MuEZ1GZO6UKsku0AehTcoLmVWftu0NyIOBKrbtLsuYaA8mrLRIw89Jsq0bJY1b
	 fpk4COw6Tv4E4eUt8wYk2umfWClmi5L7shJtdTTF2ald0LIhoBWc+RdWoTKstMLzbJ
	 Qbiklu9CtWOGg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ACC3F37813DC;
	Wed,  3 Apr 2024 07:16:03 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:16:02 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Grant Likely
 <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix a couple -ENOMEM error codes
Message-ID: <20240403091602.52e887b3@collabora.com>
In-Reply-To: <cf5bbba5-427e-4940-b91e-925f9fa71f8d@moroto.mountain>
References: <cf5bbba5-427e-4940-b91e-925f9fa71f8d@moroto.mountain>
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

On Tue, 2 Apr 2024 12:58:09 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> These error paths forgot to set the error code to -ENOMEM.
> 
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Queued to drm-misc-next.

Thanks,

Boris

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index fdd35249169f..a26b40aab261 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1264,8 +1264,10 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	op_ctx->rsvd_page_tables.pages = kcalloc(pt_count,
>  						 sizeof(*op_ctx->rsvd_page_tables.pages),
>  						 GFP_KERNEL);
> -	if (!op_ctx->rsvd_page_tables.pages)
> +	if (!op_ctx->rsvd_page_tables.pages) {
> +		ret = -ENOMEM;
>  		goto err_cleanup;
> +	}
>  
>  	ret = kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
>  				    op_ctx->rsvd_page_tables.pages);
> @@ -1318,8 +1320,10 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  		op_ctx->rsvd_page_tables.pages = kcalloc(pt_count,
>  							 sizeof(*op_ctx->rsvd_page_tables.pages),
>  							 GFP_KERNEL);
> -		if (!op_ctx->rsvd_page_tables.pages)
> +		if (!op_ctx->rsvd_page_tables.pages) {
> +			ret = -ENOMEM;
>  			goto err_cleanup;
> +		}
>  
>  		ret = kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
>  					    op_ctx->rsvd_page_tables.pages);


