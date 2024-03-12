Return-Path: <linux-kernel+bounces-100096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055208791BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BCF1F22F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58EA78675;
	Tue, 12 Mar 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFeqpWRd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3418C33994;
	Tue, 12 Mar 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238485; cv=none; b=rT9+H4+4D+1y29biZ+bJl2KY7g8BRdAnOblL4PdMOBCIEJ+OI43ogSe/WoSLfBFLCOnXfHI4PGiAM/hsMqDDwHbf6tykUucczyd3RzjrFPpnpd/vJ0810DSxVe50C8sK6RLjXYvjx0gvcrEKqcLCbVIx4IAoGvht3dkzy82BJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238485; c=relaxed/simple;
	bh=wIUAc2qgkzT7cnhyJzvz5zQcdINhp4KvcvR0AsIld1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0F/5MwUZ/U2ZL/N23TfC3JMXa8+LUknW2El2I4qq2K2/8uAGkufahORNt57BmKV/75avUNQKcOwl1IH1Ybdc4S9aKIjzEo7Hw8vpcgP0wNHUKPze8RZjRMvR00DAB4mSFNr5hrQCQM+XFH4djCMTtZR7EHXq0QnGQy8bAHXfxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFeqpWRd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710238483; x=1741774483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wIUAc2qgkzT7cnhyJzvz5zQcdINhp4KvcvR0AsIld1s=;
  b=BFeqpWRd9tJmav8uOrb3Q7GoyyDhpG2st84pzs0erqetDi95YJrSLg8U
   0ozMGyvdsjzfQVGbIX/IE5o7UMrW+lQC9Fr5jJlR57aL/PP4HR6X6uN6R
   QitdEV4WIy3rq3espQLP1DPBdLW1uU7ajWiSM9p6X0pHeEFdk9K7yOIM+
   dU9BnPsm66pg290jycEULu4g9QWKwsPZIm2C86XwtEMNzyeKBxSTbfVoJ
   CMHtc/aogugWars4TItGVMnC6KMG5CIlONy/KhvnSJSfASpiORnA7obSN
   Qo5HThypdoRtLdLLvareRA4xRnLnVPq/XeIO9MpL8jvAqHjcg6ekM5AuS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4794360"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4794360"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 03:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051635"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051635"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 03:14:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 12:14:39 +0200
Date: Tue, 12 Mar 2024 12:14:39 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Bo Liu <liubo03@inspur.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: stusb160x: convert to use maple tree
 register cache
Message-ID: <ZfArD+j5+CwyDBeb@kuha.fi.intel.com>
References: <20240309071757.3152-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309071757.3152-1-liubo03@inspur.com>

On Sat, Mar 09, 2024 at 02:17:57AM -0500, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/stusb160x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
> index 3ab118df1bd4..f3140fc04c12 100644
> --- a/drivers/usb/typec/stusb160x.c
> +++ b/drivers/usb/typec/stusb160x.c
> @@ -234,7 +234,7 @@ static const struct regmap_config stusb1600_regmap_config = {
>  	.readable_reg	= stusb160x_reg_readable,
>  	.volatile_reg	= stusb160x_reg_volatile,
>  	.precious_reg	= stusb160x_reg_precious,
> -	.cache_type	= REGCACHE_RBTREE,
> +	.cache_type	= REGCACHE_MAPLE,
>  };
>  
>  static bool stusb160x_get_vconn(struct stusb160x *chip)
> -- 
> 2.18.2

-- 
heikki

