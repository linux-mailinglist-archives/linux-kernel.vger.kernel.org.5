Return-Path: <linux-kernel+bounces-127928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C6C8952D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355871C230C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04487C6DF;
	Tue,  2 Apr 2024 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tVizRN1e"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4257764E;
	Tue,  2 Apr 2024 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060484; cv=none; b=P4Cf7D9J/9EWpUm6nyw7YlH3AX8TQse0T76dD8fzzpjMqy5ABlfMETiGmYIX5o3q3NcvjoRvTXzxd9SuKZsoF+o3xq3Bt4UPVt9C8lklCoFEGFhk/uBLlTqucbI75+o8mPhyUoV90aQxUGRBbr5vx/a8GzCA1Nmw/+93zChzuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060484; c=relaxed/simple;
	bh=HfpmeKZnkkFXaCQeRtGNvX0DALTE60IDykW4I9/bvKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECCf3+T3XCFELYwb7k8lMyX01OlSQGA02cKZmxhyJXBXiq5gR55tiuyZgAuSNbwGqBcG3A0LwldgpFbqX8YMC3hM2qH5tFWTM/idnLdSuUGeviQpeuc5ZZkzGeUFhal+nleQnxe3WdYkrK/bj+ruWqV1lQ54Bg58y/xgl56smh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tVizRN1e; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712060480;
	bh=HfpmeKZnkkFXaCQeRtGNvX0DALTE60IDykW4I9/bvKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tVizRN1eaG/A4k20L4YfTkZgs+JGOXCVd1K8Vq0dFZlAvnMmJ08sAA2gXSIfJ2+vG
	 EqSIWOY/xh7ZFbTpTU9Xk5t9TzcjgGKWIZhUarLwPkPSexkexlrIb/nxGoAJ6sbPeJ
	 Yh8F02PTp9oFl05I2bmYZ6RLi6CtEz7nRDL5Ydb0gzQ1IzhYKutA8cGYOX8fGMOvhX
	 BL5bDBWg6tSwRsx1nyAJTfvgxjZzFvsQ2vBNiIAdOLJ6SLAYBLpKZvE4tvDydyhmyT
	 IB9myNMIf3Edp7t9hqgk41FZru2H923YDBBagB1K0Bt8pvYoMM0horwhFk3ezEFG4J
	 GqCnhb00u9bNQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E67F3781144;
	Tue,  2 Apr 2024 12:21:20 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:21:19 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix off by one in
 panthor_fw_get_cs_iface()
Message-ID: <20240402142119.436dcfb6@collabora.com>
In-Reply-To: <62835c16-c85c-483d-a8fe-63be78d49d15@moroto.mountain>
References: <62835c16-c85c-483d-a8fe-63be78d49d15@moroto.mountain>
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

On Tue, 2 Apr 2024 12:56:42 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The ->iface.streams[csg_slot][] array has MAX_CS_PER_CSG elements so
> this > comparison needs to be >= to prevent an out of bounds access.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 33c87a59834e..181395e2859a 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -308,7 +308,7 @@ panthor_fw_get_csg_iface(struct panthor_device *ptdev, u32 csg_slot)
>  struct panthor_fw_cs_iface *
>  panthor_fw_get_cs_iface(struct panthor_device *ptdev, u32 csg_slot, u32 cs_slot)
>  {
> -	if (drm_WARN_ON(&ptdev->base, csg_slot >= MAX_CSGS || cs_slot > MAX_CS_PER_CSG))
> +	if (drm_WARN_ON(&ptdev->base, csg_slot >= MAX_CSGS || cs_slot >= MAX_CS_PER_CSG))
>  		return NULL;
>  
>  	return &ptdev->fw->iface.streams[csg_slot][cs_slot];


