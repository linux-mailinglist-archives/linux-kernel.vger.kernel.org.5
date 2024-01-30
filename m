Return-Path: <linux-kernel+bounces-44242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5236841F63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA29B2DA10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB059148;
	Tue, 30 Jan 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wa8blGB5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84D5821A;
	Tue, 30 Jan 2024 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606490; cv=none; b=tlL0bXZBRfKCF4NP5zO42/0bSnqSQBG8uSGoGYgl8rL1/hKDq14Cmr98YfBelcG+puJwNE38wmJaXXZ4TEtH6ytFFopSy6iV02W1J4W/M8i6yPOZIfkZlBiJ0+pmH36AaT34t+D1n5sjzJZGDkre7r2r5PiuEH+ZenqhsiQH+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606490; c=relaxed/simple;
	bh=ifAlKUG+CxYISCTy0oT7pt8UtA4YNwpiVo6jZ1ymT/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaVwDhBP8G9dgXqHSFh8zw98vJFN41lnuq0EoqNv2a6dVT30FruDPFtx5yPa0v7mn+EG8hJHyO4Rl7s1nuFxM/DlO58/A5aH7FJcSzq6tVPUHt8fvrzepecSl5wTXyDJCT4S/8AFH4zULbHrqUqWGKjzpq9CdlWR9p5mcW3p/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wa8blGB5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706606489; x=1738142489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifAlKUG+CxYISCTy0oT7pt8UtA4YNwpiVo6jZ1ymT/U=;
  b=Wa8blGB5KLyjj0pjJxyWB2dZrrDAyNFQIGJ19R/mm3a7FYPNHxhv1J0W
   FsfRifQC4hwOOXr+bIaCEZ7bqdDkR6knvpIyLlRc6Yp6fjbdvpGG42Vzh
   /eUvDmz+iyqj3t4dntAwuu6y0eppuFINIqcN50LPm73nPwRQD8746w7rc
   PbI5PtzLfdp9KQ5L5Hnp2r2MzT7PPPKCjX6O/tFxqf09VZwGMTJEm4JgA
   HwRHz0hgjxSmZX+lRttsBGoafoMS0Nitg1LTarr7O9S4B8Igh32WoAJtk
   XwH+UyZ7w7O0GTR7zR/a3TRkIgP790P4ZFHoPOrFX2ARRWXwEUEJiz3D+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3078810"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3078810"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:21:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="1119198673"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="1119198673"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2024 01:21:25 -0800
Date: Tue, 30 Jan 2024 17:18:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: remove redundant checks for bridge ops
Message-ID: <Zbi+yJC7KNvl9med@yilunxu-OptiPlex-7050>
References: <20240124152408.88068-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124152408.88068-1-marpagan@redhat.com>

On Wed, Jan 24, 2024 at 04:24:07PM +0100, Marco Pagani wrote:
> Commit 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class
> driver") introduced a check in fpga_bridge_register() that prevents
> registering a bridge without ops, making checking on every call
> redundant.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/fpga-bridge.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index a024be2b84e2..e0a5ef318f5e 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -30,7 +30,7 @@ int fpga_bridge_enable(struct fpga_bridge *bridge)
>  {
>  	dev_dbg(&bridge->dev, "enable\n");
>  
> -	if (bridge->br_ops && bridge->br_ops->enable_set)
> +	if (bridge->br_ops->enable_set)
>  		return bridge->br_ops->enable_set(bridge, 1);
>  
>  	return 0;
> @@ -48,7 +48,7 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
>  {
>  	dev_dbg(&bridge->dev, "disable\n");
>  
> -	if (bridge->br_ops && bridge->br_ops->enable_set)
> +	if (bridge->br_ops->enable_set)
>  		return bridge->br_ops->enable_set(bridge, 0);
>  
>  	return 0;
> @@ -401,7 +401,7 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
>  	 * If the low level driver provides a method for putting bridge into
>  	 * a desired state upon unregister, do it.
>  	 */
> -	if (bridge->br_ops && bridge->br_ops->fpga_bridge_remove)
> +	if (bridge->br_ops->fpga_bridge_remove)
>  		bridge->br_ops->fpga_bridge_remove(bridge);

Also for state_show()?

Thanks,
Yilun

>  
>  	device_unregister(&bridge->dev);
> 
> base-commit: c849ecb2ae8413f86c84627cb0af06dffce4e215
> -- 
> 2.43.0
> 
> 

