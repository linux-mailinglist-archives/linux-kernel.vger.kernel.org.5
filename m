Return-Path: <linux-kernel+bounces-127929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304148952D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7982816D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810D77F30;
	Tue,  2 Apr 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qK5BPooC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE7757EA;
	Tue,  2 Apr 2024 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060511; cv=none; b=gWV7UhQ/I6ed0+VpJUyfTMMvKJ1ykxJH7TWvR51C9nYJ7oxdquwAMZULZ2HhLqCS5TrlgSbLsV7Bhj3Pt2eHHW0Y/drcpovu54hjTGfVt940kCsSiavswjqQ6NQbqvBR6nhS+LFkHG24ojshZTZkYfSiyqcqcKjZQwYXTV2RALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060511; c=relaxed/simple;
	bh=7SXXtWFFK3yJiK34x7w4K4HBICcMgAm0cuEQJNBk8zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ae5SoIu6wgCCLvJrNaEdEx1aurKk1ZjnwBdxYa6ZM0sto+jfFrZl2cZQW/VC/LV3SAdPcbRnxVX0D20woUKrZ/TxQdwap6fePt7RTBxDMgxCyv+qiGVYdhYcC20e3AvOpsq+obuqpB8bIMxxblQKDOcJBtdnmZLdKofv/KxZV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qK5BPooC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712060508;
	bh=7SXXtWFFK3yJiK34x7w4K4HBICcMgAm0cuEQJNBk8zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qK5BPooCkBTx/paRFFHqxxAzlajZdrTTdIIQYVqoOWIJGP9uL2nxbav/2zGeR9yur
	 ePCLBQjf0JEeorEIryqKNOy2Vw0sG3eZjAziCea2Chx1GnPFTAhO6Vvtqfi54OFqYr
	 z0SK7Iy99E7crqg08txt7caUB1nqnsumKyqI8afIrW/pUH3BJ8UpF2KYF/jbUCPyIK
	 qt4rH0lXbAX3cnEMoi61bsgSM1qQGHm4ihQl0wULPu+ntuztrdpIDlww/ArzkXv7Uj
	 U/Lqd75k/0S8+Rr/+86CENrigOYIySEKr6cn8w1V7/xGAskag1YYUfmGOSGF2AXiV4
	 XiENTbu4PwHLw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7E34E3781144;
	Tue,  2 Apr 2024 12:21:47 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:21:46 +0200
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
Message-ID: <20240402142146.58a438c9@collabora.com>
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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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


