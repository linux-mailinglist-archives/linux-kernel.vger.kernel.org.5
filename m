Return-Path: <linux-kernel+bounces-63698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763EB853369
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BED287005
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010E357898;
	Tue, 13 Feb 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QW+u9o2N"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0B5647F;
	Tue, 13 Feb 2024 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835383; cv=none; b=gxbWFSTrR8crvSTZwhb8sp1ZBunLx2f1oDeybS9dzWVm3iQTcS2gHgzlextWIK/GI1VSM6T60McXL3BXnoEJuSeFutpfPfa9HVWcOTwYHGjfkDmfk74N/GDibc/08YlP9mVaHq0tEtUVHJn1WWV9E49tHZj2p8CLy+0KF/7VSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835383; c=relaxed/simple;
	bh=hBY4Przzr9r9vbICCXsAtnHmOm199MIsVifivtT0k6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbwPAhpf2RSgBlnyBXQDLvDH1QdSMGR/yFaUbjLuk1yga/B3384OzEwDUMfBtKxTr6vwiFL0Z6x3BhGAa5eNlEGMcWu9OVHSQA5d1LB0dfaVpgvPcbuYavIbURjaOjJjMetqjS/UlZQqjWQpTARibnFdbthS3ATd63llpKUTyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QW+u9o2N; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707835381; x=1739371381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hBY4Przzr9r9vbICCXsAtnHmOm199MIsVifivtT0k6g=;
  b=QW+u9o2NCmFpJbLt4TDLq9mpaR3AMrmzj+XHYdU654K+pC1FS4lCDuLA
   Z9wVETTsqK0FLb23/11xfnP3bXmylNDBdLuYl/IFnKdGwwc5JThTgHp+1
   FcdLVTNSrOUUHSG6HoHXObt6JVs3oviKBYmRvqRz1G8QTMeiSjbOAC8pj
   f40ksGlF0QaXUg9KggAsc1F6pkIWBau4a544ihyVr9n3WbwUDZwqsD/5/
   DXF7/qPaJL1hQ0o4snvxR8i/haVPY0Q0yLtP20JoqYUs32rB6l9qBgI8g
   aAjRO29tAStQW7ARZ0B0+eDiUwWs8ePo2OR/3eWtOqDBj5n8EipEGZyIa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="396278108"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="396278108"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 06:43:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911802315"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911802315"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 06:42:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZtzq-00000004F4c-15OT;
	Tue, 13 Feb 2024 16:42:54 +0200
Date: Tue, 13 Feb 2024 16:42:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] gpio: initialize descriptor SRCU structure before adding
 OF-based chips
Message-ID: <Zct_7YcJk5-sg2pT@smile.fi.intel.com>
References: <20240212213920.49796-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213920.49796-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 10:39:20PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In certain situations we may end up taking the GPIO descriptor SRCU read
> lock in of_gpiochip_add() before the SRCU struct is initialized. Move
> the initialization before the call to of_gpiochip_add().

..

This is a bit unclear why you moved to that place and how it had been tested.

> @@ -991,10 +991,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	if (ret)
>  		goto err_cleanup_gdev_srcu;
>  
> -	ret = of_gpiochip_add(gc);
> -	if (ret)
> -		goto err_free_gpiochip_mask;
> -
>  	for (i = 0; i < gc->ngpio; i++) {
>  		struct gpio_desc *desc = &gdev->descs[i];
>  

>  		if (ret) {
>  			for (j = 0; j < i; j++)
>  				cleanup_srcu_struct(&gdev->descs[j].srcu);
> -			goto err_remove_of_chip;
> +			goto err_free_gpiochip_mask;
>  		}
>  
>  		if (gc->get_direction && gpiochip_line_is_valid(gc, i)) {

>  		}
>  	}
>  
> -	ret = gpiochip_add_pin_ranges(gc);
> +	ret = of_gpiochip_add(gc);
>  	if (ret)
>  		goto err_cleanup_desc_srcu;
>  
> +	ret = gpiochip_add_pin_ranges(gc);
> +	if (ret)
> +		goto err_remove_of_chip;
> +
>  	acpi_gpiochip_add(gc);

My logic tells me that if you need to call gpiochip_add_pin_ranges() before
calling of_gpiochip_add(). It won't collide right now, but allows to cleanup
further (with the gpio-ranges parser be generalized for fwnodes and be moved
to gpiolib.c from gpiolib-of.c).

-- 
With Best Regards,
Andy Shevchenko



