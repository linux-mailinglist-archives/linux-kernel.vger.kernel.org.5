Return-Path: <linux-kernel+bounces-129529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F8896C32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C11F27496
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26BB13776F;
	Wed,  3 Apr 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVrtIds9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70143259C;
	Wed,  3 Apr 2024 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139892; cv=none; b=EzYaMPDfsvpYY8kykEzqmD1DE1lBYUlMhGT2YHHmlmiNZJBFcuV9863cy+WM3BuUmAnjDZGP9AHC7tWLfhSGH8IabUyWl4W14whKnCNB0uS+EmB1dp8GFCBucbFXZtriW/vWhISUpqkst7TZWvKqHRMl7kb/Il9ma2ZY0Ldh2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139892; c=relaxed/simple;
	bh=ESt8CZC/Qd2eEHRQmlwIpFHD3SOwTUjqLs41t4VZMsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9UMFrNGITbGpLWJzjAgOSu99x7Hfcv7U2G2JFFx0FCVedFmkQszpNtNBJA+T9xrs6h8rXIGum1oOpoTqAhrKS/1gGohfuZR5c1oKmeb55mOA77Z5jMKjzz0e1Epg6Kfi/wlU5NmAdpmkrT3RhHDbEo4sJboCySSdJ6+WxqpjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVrtIds9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712139890; x=1743675890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ESt8CZC/Qd2eEHRQmlwIpFHD3SOwTUjqLs41t4VZMsQ=;
  b=kVrtIds9BKpFmlLpTWnKbdKsN7/055CsbdT9NLMUy82QflRZB4xPcU6i
   g35itYOp9g+f8ealeMdUvBKSRi5/KkFZqwcM1w1Lcby4mukp8pOqPfaN9
   Hq+Slpf7uo50WshknxDSLH+PfpFYWrVxMt7DavY8FSwLoovriqLuMMrtO
   3ySHlBH5Et/quztDBoTwmXzOh8OeL6Erl/yAkb1xqdP4DtiYJA6BCXNbZ
   PfcrryBgWkWcX3whNNTAYOyHjTZrRPc52Q81ceWrAhTVW4H65fvy7VHIN
   EhRZNETk1Qy1JxWmqphxuJ1ZoObt+GUIYKQ4Lhs0bag3rzSrt+TiSkp2M
   A==;
X-CSE-ConnectionGUID: yqti+/tdQS+o3Dbb8qrvWA==
X-CSE-MsgGUID: wzI0/46kTniFkeBQgW6c9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7282964"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7282964"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:24:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084818"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084818"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Apr 2024 03:24:46 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Apr 2024 13:24:45 +0300
Date: Wed, 3 Apr 2024 13:24:45 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ran Wang <ran.wang_1@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: nvidia: drop driver owner assignment
Message-ID: <Zg0ubZ9P9sCVLOrX@kuha.fi.intel.com>
References: <20240331091737.19836-1-krzk@kernel.org>
 <20240331091737.19836-2-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331091737.19836-2-krzk@kernel.org>

On Sun, Mar 31, 2024 at 11:17:36AM +0200, Krzysztof Kozlowski wrote:
> Core in typec_altmode_register_driver() already sets the .owner, so
> driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> 1. None
> ---
>  drivers/usb/typec/altmodes/nvidia.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/nvidia.c b/drivers/usb/typec/altmodes/nvidia.c
> index c36769736405..fe70b36f078f 100644
> --- a/drivers/usb/typec/altmodes/nvidia.c
> +++ b/drivers/usb/typec/altmodes/nvidia.c
> @@ -35,7 +35,6 @@ static struct typec_altmode_driver nvidia_altmode_driver = {
>  	.remove = nvidia_altmode_remove,
>  	.driver = {
>  		.name = "typec_nvidia",
> -		.owner = THIS_MODULE,
>  	},
>  };
>  module_typec_altmode_driver(nvidia_altmode_driver);
> -- 
> 2.34.1

-- 
heikki

