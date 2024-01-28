Return-Path: <linux-kernel+bounces-41659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8C83F5F6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BFB1C21B6B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CCA219E5;
	Sun, 28 Jan 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIAOT+Ok"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480721E521;
	Sun, 28 Jan 2024 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706453303; cv=none; b=OeqVgBnD4X+9P5vxRowxy9qy6x2rUw/qg3kKuL9UVhL+0H3OrjkLXBSuMchUohtDt2KhnekMNIK/i0e9pjp72UKbhq9w2fgvijfksUaxbsUSgVTRYeXb9oT4qhmN1dzJ1+7Ym3KWCUD0WQEhcYSiLR3iNcNV71SuGPvAUnC2Oco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706453303; c=relaxed/simple;
	bh=DW13tZN6c+m58d9dFkxbVPlRiqjS6lW/WuCth1mXG/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDBCJFmXvB/c65AQebySTf4Pgx3tKm6OPHO4Np9/TY/i/q7zyKQ4+knM2MgW30/UUDRiXZiacYlX8GVHGFQwKpzNkKJ1XITUrjXMSP2pyYxxMez3/Q9ML/3GOA91NyakRS4ggcgN0TZ9qyP/ITG11sU/U0pz6V/ELli+D5+Uatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIAOT+Ok; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706453302; x=1737989302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DW13tZN6c+m58d9dFkxbVPlRiqjS6lW/WuCth1mXG/c=;
  b=BIAOT+OkQhshPn5xYLbsoDsf2SJdI4030Msc0BgSK04oHfNzBHlUfl95
   rQ6WFdq/+TZcIt+HGxllO+45ZWwb5aVmiMWC4nSBil5xj/V/0nRq/KIHe
   KC3tDfsrO9h4C1qPdpnXdXn3mrlZXRzgRjA+Y0l3qNv6EgdbjX96N6gLJ
   QuHHZYCThMZPT0svEuOl5/Jv8B7n2Tdn8vDyVaVw9vhLNLI3cJAoDjat8
   Cb1nbMSXCeMgWvwd86LkpW64MfZ3+TOK9ZBMZ2f1aBHP/gKvdaJ+gzSQu
   r2hTqe0lTmtHa2TgZ76X3Aoj5VDYmK53fjdlMA+GPjXz7+18C7aNHMfBc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="1713457"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="1713457"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 06:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="1118702503"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="1118702503"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 06:48:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU6SH-0000000HTye-19bL;
	Sun, 28 Jan 2024 16:48:17 +0200
Date: Sun, 28 Jan 2024 16:48:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] pwm: dwc: simplify error handling
Message-ID: <ZbZpMO9b7L-DNIcb@smile.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-3-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122030238.29437-3-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 22, 2024 at 08:32:37AM +0530, Raag Jadav wrote:
> Simplify error handling in ->probe() function using dev_err_probe() helper.

..

>  	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> -	if (ret) {
> -		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
>  
>  	base = pcim_iomap_table(pci)[0];

> -	if (!base) {
> -		dev_err(dev, "Base address missing\n");
> -		return -ENOMEM;
> -	}
> +	if (!base)
> +		return dev_err_probe(dev, -ENOMEM, "Base address missing\n");

This check is bogus. Just remove it completely.

The pcim_iomap_table() fails IFF pcim_iomap_regions() fails.
You have checked the latter already.

-- 
With Best Regards,
Andy Shevchenko



