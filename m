Return-Path: <linux-kernel+bounces-45848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE2D843705
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C176A1C20E61
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862050A66;
	Wed, 31 Jan 2024 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3GwvPrU"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7B4F608;
	Wed, 31 Jan 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684100; cv=none; b=L+7KyZCDrwj+Ge9A+8qnpOdUD2yK1Wu2O9p0toRQLOB2wTrnLayJXeYcW5PyU57dd1KCsUb0yHdUrX7Ffs0bfBq7HSgp+SfbTtcWvAHo8rKfQkGgeGPRnzmY2qAQxTO2hOEEcF/nVLKEcgjk0PbNO54KJpNpg8s13Qe6xNULzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684100; c=relaxed/simple;
	bh=LYkyIfkAfWvMactjAyROuDyPF2pvc83xQkc4eG04G1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZFAnTZvNsfnIsJPsi6Cvc48wyw9HMR9+EHMyreDeG77FdCR5J18mE0E+K7vHdqqB/guCpH3F/j/jd6ivQzzZk9rUU+oNtIfWytOf4dQTAlssawRHdpYRPw+GYHm4ntrNWymTJ6G4aRsp1RezxX3y275xTTadYqLXrzQLfrsRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3GwvPrU; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706684098; x=1738220098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LYkyIfkAfWvMactjAyROuDyPF2pvc83xQkc4eG04G1w=;
  b=f3GwvPrUWBVuwvD12AN5XwKID0K6fOMPURkB7pKrguicyipi39VvhDan
   HnTM23cZBqxjfgmzweHLPyEWSD0WSL30tel/LdAxef8s48Q55LZEaiHxF
   v57UCIxjgPcPn4lf8z2k4aS3o9Uq8GKVCQcz6tBFnFEt5NZfCIoIq0qFe
   lhGtZcCQZ5OdKHHf8NhRFireacW5yxDRrpz9vw9UwaE+WBecC4YaVVO9f
   WVJa0Mky/UPGXxkY5ET7ITOrTHTcECA/C364rksruojwFYRDntfemWZTJ
   CkDtrUxhotkD0kJa5zXWy+bt3qY7lQsC96ZoBhzxYghndjxpXk24oUi+p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403130818"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="403130818"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="911692836"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="911692836"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:54:55 -0800
Date: Wed, 31 Jan 2024 08:54:52 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
	lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] pwm: dwc: use to_pci_dev() helper
Message-ID: <Zbnum_TLEGGlHWbp@black.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-4-raag.jadav@intel.com>
 <ZbZo2A3qU9RIz568@smile.fi.intel.com>
 <q5mde3tak2mpqnkphue7vdez33l4bh2urjqryljzzpvz556yjw@2gmnudzle3my>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q5mde3tak2mpqnkphue7vdez33l4bh2urjqryljzzpvz556yjw@2gmnudzle3my>

On Sun, Jan 28, 2024 at 05:55:00PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Jan 28, 2024 at 04:46:48PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 22, 2024 at 08:32:38AM +0530, Raag Jadav wrote:
> > > Use to_pci_dev() helper to get pci device reference.
> > 
> > PCI
> > 
> > ...
> > 
> > >  static int dwc_pwm_suspend(struct device *dev)
> > >  {
> > > -	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > >  	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
> > >  	int i;
> > >  
> > > @@ -120,7 +120,7 @@ static int dwc_pwm_suspend(struct device *dev)
> > >  
> > >  static int dwc_pwm_resume(struct device *dev)
> > >  {
> > > -	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > >  	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
> > >  	int i;
> > 
> > I don't see how pdev is being used. That said, why dev_get_drvdata() is not
> > suffice?
> 
> I would even consider using dev_get_drvdata() a nice cleanup given that
> pci_get_drvdata() works because dwc_pwm_alloc() called dev_set_drvdata()
> (and not pci_set_drvdata()).

Makes sense. Will update in v2.

Raag

