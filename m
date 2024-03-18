Return-Path: <linux-kernel+bounces-106417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B087EE60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170E91F222FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD14054FAF;
	Mon, 18 Mar 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="i3kvDuWk"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED554BFA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781576; cv=none; b=Cr5eK5asd5udx2n2bABHrB0DTaC8ctItZ+GD6A2fgM2gNXy/almisBorcWzL6zsUKteRzear8myJUd2dFseoq5L3ES+jtwrjXDFsTvgJ88D2HnGk2jmFC47jjFvSi4V4pyqYRGvwZvdj3nmNK9Z4+DpzRU8mOYFhflxpR1uRRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781576; c=relaxed/simple;
	bh=eKN5dVb6S67RCse9OvAtbGcBmvx7pJXmDkiVK8Z0e+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnGH/8rfX0A2nerr9Pi1FlSPDlT/qlrPr5Rx+Gy6ETars554TuyT/8EKzJSTlp4KH2fFxNJR7Vym74U7Iu4bjtdVXaF5NEYcljGQWggNH5uX4zEBR4+Z+bbqqhlckzzz5pcBX2kxDQxRnZ77wfzx81zum/N8ukkLm8N+Kd0l1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=i3kvDuWk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 559FC7E9;
	Mon, 18 Mar 2024 18:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710781546;
	bh=eKN5dVb6S67RCse9OvAtbGcBmvx7pJXmDkiVK8Z0e+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3kvDuWkLq/GiBhR3QIPVDrAbeGf2rohEQFoFP1kp3E1QlJMGQVq8dCZ/1/LqZaTq
	 s7O6fu5qm2u4JCv8LYulyvpFUdqx/eBygmA+76O2MKUFbGbdcJPhFJ0gtvb3r4PqIG
	 y5gEEKwAIOGStoEixXkaiqURFWsFiXWwoXy1dG4E=
Date: Mon, 18 Mar 2024 19:06:09 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/6] drm: zynqmp_dp: Adjust training values per-lane
Message-ID: <20240318170609.GI13682@pendragon.ideasonboard.com>
References: <20240315230916.1759060-1-sean.anderson@linux.dev>
 <20240315230916.1759060-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315230916.1759060-3-sean.anderson@linux.dev>

Hi Sean,

Thank you for the patch.

On Fri, Mar 15, 2024 at 07:09:12PM -0400, Sean Anderson wrote:
> The feedback we get from the DPRX is per-lane. Make changes using this
> information, instead of picking the maximum values from all lanes. This
> results in more-consistent training on marginal links.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 98a32e6a0459..8635b5673386 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -605,28 +605,21 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
>  				   u8 link_status[DP_LINK_STATUS_SIZE])
>  {
>  	u8 *train_set = dp->train_set;
> -	u8 voltage = 0, preemphasis = 0;
>  	u8 i;
>  
>  	for (i = 0; i < dp->mode.lane_cnt; i++) {
> -		u8 v = drm_dp_get_adjust_request_voltage(link_status, i);
> -		u8 p = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
> +		u8 voltage = drm_dp_get_adjust_request_voltage(link_status, i);
> +		u8 preemphasis =
> +			drm_dp_get_adjust_request_pre_emphasis(link_status, i);
>  
> -		if (v > voltage)
> -			voltage = v;
> +		if (voltage >= DP_TRAIN_VOLTAGE_SWING_LEVEL_3)
> +			voltage |= DP_TRAIN_MAX_SWING_REACHED;
>  
> -		if (p > preemphasis)
> -			preemphasis = p;
> -	}
> +		if (preemphasis >= DP_TRAIN_PRE_EMPH_LEVEL_2)
> +			preemphasis |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
>  
> -	if (voltage >= DP_TRAIN_VOLTAGE_SWING_LEVEL_3)
> -		voltage |= DP_TRAIN_MAX_SWING_REACHED;
> -
> -	if (preemphasis >= DP_TRAIN_PRE_EMPH_LEVEL_2)
> -		preemphasis |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
> -
> -	for (i = 0; i < dp->mode.lane_cnt; i++)
>  		train_set[i] = voltage | preemphasis;
> +	}

I don't have enough DP knowledge to review this :-(

>  }
>  
>  /**

-- 
Regards,

Laurent Pinchart

