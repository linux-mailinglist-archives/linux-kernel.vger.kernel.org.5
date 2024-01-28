Return-Path: <linux-kernel+bounces-41662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E837683F5FF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3032D1C21C2B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A28B23748;
	Sun, 28 Jan 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCHu8FHX"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AC208A5;
	Sun, 28 Jan 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454184; cv=none; b=dUMuXTELDeWqzJiey72gshc1QY6yBe5RC6z6MiwhHkN6dK9oKvET36EbXMXlJ/rLtHdGR8O1CGf8iZfmOzUJwy27cwXhhPXohXp+MxjBjH/nsu7BAsoyH2xX89S1DfENfzot+Mn31lgWhuKcUFTNWdUyGpTfqa+daCh4viDdk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454184; c=relaxed/simple;
	bh=kx6bsX0OE3XS8U8hsFaidy9FE0hwsYAbgmFip0JKzNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZulVKOCy0+9VUxDeivBlP6sVnG3ecaI8iKyOzWkc2XdckXS4O6wts7JqgxPJBaSCPQiBR8dLlPOizfaY1z0cQJed7rOduoHZYwo7HveQCxNLOt6KxuLg9aTSh9iMOkKfAHO1PK1zGdZIk5wBMPTKr1HOT/81ClqvrH1xjLW9exE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCHu8FHX; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706454183; x=1737990183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kx6bsX0OE3XS8U8hsFaidy9FE0hwsYAbgmFip0JKzNY=;
  b=SCHu8FHXfJlp7BeZdXkIkaeObPUTxE0RqeLfC079MJHRJV+uc1R0nzUL
   kdzTLZOacsnD/4E2oFdr6/DNqgsYKSZwuQhXFCIYsPuxlBeGnri6NaZaJ
   CNEiRTEljxhH/+AFl74K60Im3O4APVYPd4leP7wZt/lXOS5Me6xbbbhLC
   B5U9UfWEGG0plU5PaAGZ0OYmoTZAhOYWucSC+bzVeEEETOAK9RRXqrYkN
   LJ9zD89zfGUIa+3WYw/Q0TBUtmwv+QigxBT1ab0ImRICPb3/jxI/aX71I
   A5XcZyhXN5aDMnNbX5DxqEOyDHAvHdTlFn0nDGDQjKeHA/Cj6YHplYNO5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="433942732"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="433942732"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="960672159"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="960672159"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:03:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU6Qq-0000000HTxG-3LXC;
	Sun, 28 Jan 2024 16:46:48 +0200
Date: Sun, 28 Jan 2024 16:46:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] pwm: dwc: use to_pci_dev() helper
Message-ID: <ZbZo2A3qU9RIz568@smile.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-4-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122030238.29437-4-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 22, 2024 at 08:32:38AM +0530, Raag Jadav wrote:
> Use to_pci_dev() helper to get pci device reference.

PCI

..

>  static int dwc_pwm_suspend(struct device *dev)
>  {
> -	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
>  	int i;
>  
> @@ -120,7 +120,7 @@ static int dwc_pwm_suspend(struct device *dev)
>  
>  static int dwc_pwm_resume(struct device *dev)
>  {
> -	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
>  	int i;

I don't see how pdev is being used. That said, why dev_get_drvdata() is not
suffice?

-- 
With Best Regards,
Andy Shevchenko



