Return-Path: <linux-kernel+bounces-127698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F09894FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4931C212DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C468459B56;
	Tue,  2 Apr 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFm6dblF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1755E72;
	Tue,  2 Apr 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052658; cv=none; b=PRdkadZQsxGiAOu2I+RI5JDfTgFuv2iP0Lc8n/+oPQGMIAo4l/cDj+0xd3kwKcJoX3C6d4e8KwZyN2nt9BTDqOJDgFmkNyP6ggrv2I4288PkzSJmHke/VOXF6UFfTpkk3SXsuSgMoccsozJDMGDA/+Fhj6fg26ikcBYcvkDwinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052658; c=relaxed/simple;
	bh=JeZSu8B31jDUOjALAzuYLuNiUkxwby08+7uq9G+Ehlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnHtf9fiQhRoeab10Tqu3QgnV6bv6egHnuonlCzHGDCMnySHkbdrwMzcZdERFHlhYllzYBIm1Y+BnW5qY6SMUBXzH1c+VCGbFl0ajcRaxp0jK+mcpIg+8b04tW2VCoon1PUaSdu4tQgr21sm9tdpXUKlD4YvDpBzaHCa8+z0s1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFm6dblF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712052657; x=1743588657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JeZSu8B31jDUOjALAzuYLuNiUkxwby08+7uq9G+Ehlk=;
  b=TFm6dblFuKvXNI2AO/PaizDiV8P2CGy9h6Mg5S8bBmcudwiXPPcvXgc6
   EC1pqgpSEa5O4YseuCbzXrqtk5877mgrp4INZHCyLoTAZlER9mN/amMIq
   dUuTnwFnkD+xf6adzUNt393rZprFFZCVO2jY/bI+q7dXcva6avjQQWB/B
   S+he155+RGfid1QpJ5WuZTL887QOSiHH7Yps3i/25S0N0AURcLEzgRI1Z
   EYZU/uGMwXVpEFvJGmEVMDOvYwE+VL3PoTJeW0m0f+eKjY/+vDrnuzkFG
   IXQfcloRo4DsbXlAF0rd3AJtOp3iVnSwx+4+FNwb3Qd0uSUZ+mU0Q1HWi
   Q==;
X-CSE-ConnectionGUID: sagVaCdmRXOedEriNaOw3g==
X-CSE-MsgGUID: EHxVxZ/MQwmyon7hZahAhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="24669953"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="24669953"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="937083266"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="937083266"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Apr 2024 03:10:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Apr 2024 13:10:51 +0300
Date: Tue, 2 Apr 2024 13:10:51 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ran Wang <ran.wang_1@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: phy: fsl-usb: drop driver owner assignment
Message-ID: <ZgvZq6DIr1jTbezG@kuha.fi.intel.com>
References: <20240327174609.519252-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327174609.519252-1-krzysztof.kozlowski@linaro.org>

On Wed, Mar 27, 2024 at 06:46:08PM +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/phy/phy-fsl-usb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
> index 79617bb0a70e..1ebbf189a535 100644
> --- a/drivers/usb/phy/phy-fsl-usb.c
> +++ b/drivers/usb/phy/phy-fsl-usb.c
> @@ -1005,7 +1005,6 @@ struct platform_driver fsl_otg_driver = {
>  	.remove_new = fsl_otg_remove,
>  	.driver = {
>  		.name = driver_name,
> -		.owner = THIS_MODULE,
>  	},
>  };
>  
> -- 
> 2.34.1

-- 
heikki

