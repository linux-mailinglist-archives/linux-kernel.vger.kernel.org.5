Return-Path: <linux-kernel+bounces-129148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B48965E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D229F282DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AC45B1E2;
	Wed,  3 Apr 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hZ4AFfBi"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8B58208;
	Wed,  3 Apr 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128576; cv=none; b=HLIEfA/Ae8nsHrthY/rv9WB3Gk+x0fNo54JynwvcTDy1cXeAPKRajeTancJ8yXVT/vHowXVOxpcD2sRUO8nd1Zy04eE4TsCVNo+TxmZPjokFcZFx+Zp4OwgOU006uk0JCToC86SlA1DOsBVZDy0WMaO1UzSkDD+cu1x8X4i3+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128576; c=relaxed/simple;
	bh=sB1qXVz1eeVM+HiE6NVmhSVeeFBp77JSys4100PgG/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQSRQschG+Tw8C3ltEcWLS+rVMuBBMLkeRFHCs3DwyrweWJkpyeBPdjmW/9azluRcNtFyiSpMrs9Y4CYtmAES5USk1b3po55tgHtViF2wSo+m2K0uJvrgXJLg62RtU3gSU5bl0xeIKG7ljkGI1BuSgP8kY5UsUDzP6SiSHskR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hZ4AFfBi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712128573;
	bh=sB1qXVz1eeVM+HiE6NVmhSVeeFBp77JSys4100PgG/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZ4AFfBiaybD4gNHpmJErMdrcwcqS1PLMMr9pe3w2AbqbnIU9CHUVLeOhOWtrKg1d
	 arHlo10g5PTt84CLRkZ9VSgZGA7lAYpXcvn+nd5ACLCRILZWY8MtfT4gAQOdTGwUlT
	 uKPBFg44xr2bz9DHR81h7BoVlwgnEmIxLZP+ZpJQOKhiAlKoklhhEN6hLBOkvqTgtz
	 QXGN4vEDHTMKQ1iLGExShcvkHGYlWmhSawkO9+CM0hAE3FyHDjnx9/xxaybm6FfAnV
	 +2RgsbWgwzYPzUbradSTD+x4UIDk2vPgFpNSoe2PDY/XhfeyTbZ2agya9TwUqPA4lZ
	 DBkLatkYvfORA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9DB3F37820F1;
	Wed,  3 Apr 2024 07:16:12 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:16:11 +0200
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
Message-ID: <20240403091611.7fa45916@collabora.com>
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

Queued to drm-misc-next.

Thanks,

Boris

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


