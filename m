Return-Path: <linux-kernel+bounces-159780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD188B33DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC5B22232
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41A13E052;
	Fri, 26 Apr 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HQTUOZDY"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040D13C838
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123512; cv=none; b=c8KrZDGqeTl9kqeZYhqy2iGO2tWWqDqw7c2AHX9OllQV0vBn5XujmtVVh5IMWorRhqxg0vLwFHeamQFUJM+HihjOPBvVRSvNr+j2TLeneIbhBioqtQCMVNNVCe2dOjlylNnhpFysdJNJlWve4VJd5K+IQQ479EDnsduDT6bnnZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123512; c=relaxed/simple;
	bh=4sk3SkM9lTZY2JBkhhraAd6ifVIO1oEjvKtMkIamMGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsM84CG4IwhLaoDXX2te+s/VqAFULm0LddokO1bPIr0xtcDsaqF7FnfGQqKBtTGHBhilFZVUyrRfGc+nDnjN4DTkYdYT0xmS9yQzC51Kfete7Us6dQF/pe/l6yygirWnt67Mv0fDCr1BuQ2SqgDLzQ7Mwb4g9EWNTGuf8Crj+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HQTUOZDY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 114E466B;
	Fri, 26 Apr 2024 11:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714123455;
	bh=4sk3SkM9lTZY2JBkhhraAd6ifVIO1oEjvKtMkIamMGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQTUOZDYmjmdlbB0bcbZ2NEqb+R83Hd10+hCsRKTTuc2aXnYepiQVDrzkOdEXdpbe
	 d2lnDfNujb83VAOOpY4k7/HArtBk6L/7WL5hbogkzkdBm72Uem8gGBt7ditsbS1n7Y
	 GED8BGTR2J/2mgslVwPguHMUvptabgDXo0R3XAsM=
Date: Fri, 26 Apr 2024 12:25:00 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vishal Sagar <vishal.sagar@amd.com>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Subject: Re: [PATCH] drm: xlnx: zynqmp_dpsub: Fix missing drm_bridge_add()
 call
Message-ID: <20240426092500.GA4524@pendragon.ideasonboard.com>
References: <20240312-xilinx-dp-lock-fix-v1-1-1698f9f03bac@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312-xilinx-dp-lock-fix-v1-1-1698f9f03bac@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Tue, Mar 12, 2024 at 10:51:15AM +0200, Tomi Valkeinen wrote:
> The driver creates a bridge, but never calls drm_bridge_add() when
> non-live input is used. This leaves the bridge's hpd_mutex
> uninitialized, leading to:
> 
> WARNING: CPU: 0 PID: 9 at kernel/locking/mutex.c:582 __mutex_lock+0x708/0x840
> 
> Add the bridge add & remove calls so that the bridge gets managed
> correctly.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Fixes: 561671612394 ("drm: xlnx: zynqmp_dpsub: Add support for live video input")
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c    | 4 ++++
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index a0606fab0e22..9f750740dfb8 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1761,6 +1761,8 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
>  
>  	dpsub->dp = dp;
>  
> +	drm_bridge_add(dpsub->bridge);
> +

This means that the bridge will be exposed to users before
zynqmp_disp_probe() is called, opening the door to a potential
use-before-init. The risk is mostly theoretical at this point I believe,
but it's still not a direction I'd like to that. Could you call
drm_bridge_add() in zynqmp_dpsub_probe(), between zynqmp_disp_probe()
and zynqmp_dpsub_drm_init() ?

>  	dev_dbg(dp->dev, "ZynqMP DisplayPort Tx probed with %u lanes\n",
>  		dp->num_lanes);
>  
> @@ -1789,4 +1791,6 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
>  
>  	zynqmp_dp_phy_exit(dp);
>  	zynqmp_dp_reset(dp, true);
> +
> +	drm_bridge_remove(dpsub->bridge);
>  }
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> index 88eb33acd5f0..3933c4f1a44f 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> @@ -260,8 +260,6 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>  		ret = zynqmp_dpsub_drm_init(dpsub);
>  		if (ret)
>  			goto err_disp;
> -	} else {
> -		drm_bridge_add(dpsub->bridge);
>  	}
>  
>  	dev_info(&pdev->dev, "ZynqMP DisplayPort Subsystem driver probed");
> @@ -288,8 +286,6 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
>  
>  	if (dpsub->drm)
>  		zynqmp_dpsub_drm_cleanup(dpsub);
> -	else
> -		drm_bridge_remove(dpsub->bridge);
>  
>  	zynqmp_disp_remove(dpsub);
>  	zynqmp_dp_remove(dpsub);
> 
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240312-xilinx-dp-lock-fix-cf68f43a7bab

-- 
Regards,

Laurent Pinchart

