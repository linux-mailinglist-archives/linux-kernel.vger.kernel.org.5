Return-Path: <linux-kernel+bounces-44738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574FE8426C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091A51F28314
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0CC6DD0F;
	Tue, 30 Jan 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNfZKvm+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4746D1CB;
	Tue, 30 Jan 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624308; cv=none; b=r20I7HJgnkSbjV7dK6hZ/9so6tLPcsE2oiaR+qQl2LfVaDIPgu04DV77qud8wqKw/LT+jS/Y+EOjbv35JJL12vPNqp05T7DUIVXP/xZCQdMKkcNJJgvNTZrt7ZHc7iesCrbHr/crvghVY+tp4lJOrhamslXW5xnyAVb1gF9lShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624308; c=relaxed/simple;
	bh=q0WEDdDgkh1ySBxXkcgnRrKlAyINrxCu6xtYMLDmiS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEbstrNT4xIhqzkeQxxENd00KIMxAR2Vi9mm9JeHvr+UIJQOIeqmu8v8W7MIZOg9BOe1mw5nl+Od6FP3kvTJJnSPNk4lqZLm3SgavZ/jIkfaorbeDjtzvd7o7vPOIMgsVruJA6eWATh5CaIE9n+FH4h2Ag3LnFx7Krp9TmyuV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNfZKvm+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706624308; x=1738160308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q0WEDdDgkh1ySBxXkcgnRrKlAyINrxCu6xtYMLDmiS0=;
  b=XNfZKvm+wiUlyCTbpiFyen/a+r8YmlKfHGALd7IsbFJKKSZsbAiQ53lp
   pkK1JHgqNIsjccYVkQg0KSgsK+SYxdnsMtZFTcL/hO5dtsVs7+djiw9zk
   DEplvl25R8oZUSem7RaKBZE3t6JOPn4OxPlMnImfCDRxT0OH7Q0bFkljZ
   r2SyGn+PqnaO6kfj/2DtEU5r/Br6vDGG1WlFXVMeGrGqYw9JJa6YkdNR3
   t31dcnCwgYFAO8VcJ/wrV4T57FRx/EBJsaxosymNIB//TAZUEbXCwrU0Z
   dVvxNM4AdyX+vN+Y2+XymnBiNLhW71Eojw1fPXrZgcpSkVzdCWE0sUBKA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="21809643"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="21809643"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="931464088"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="931464088"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Jan 2024 06:18:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Jan 2024 16:18:23 +0200
Date: Tue, 30 Jan 2024 16:18:23 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: ulpi: Fix debugfs directory leak
Message-ID: <ZbkFL53fU+q7FHEU@kuha.fi.intel.com>
References: <20240126223800.2864613-1-sean.anderson@seco.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126223800.2864613-1-sean.anderson@seco.com>

On Fri, Jan 26, 2024 at 05:38:00PM -0500, Sean Anderson wrote:
> The ULPI per-device debugfs root is named after the ulpi device's
> parent, but ulpi_unregister_interface tries to remove a debugfs
> directory named after the ulpi device itself. This results in the
> directory sticking around and preventing subsequent (deferred) probes
> from succeeding. Change the directory name to match the ulpi device.
> 
> Fixes: bd0a0a024f2a ("usb: ulpi: Add debugfs support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
>  drivers/usb/common/ulpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index 84d91b1c1eed..0886b19d2e1c 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -301,7 +301,7 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  		return ret;
>  	}
>  
> -	root = debugfs_create_dir(dev_name(dev), ulpi_root);
> +	root = debugfs_create_dir(dev_name(&ulpi->dev), ulpi_root);
>  	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_fops);
>  
>  	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
> -- 
> 2.35.1.1320.gc452695387.dirty

-- 
heikki

