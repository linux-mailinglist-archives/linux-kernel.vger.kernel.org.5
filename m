Return-Path: <linux-kernel+bounces-71306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5617A85A334
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B62B248BF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE792AD39;
	Mon, 19 Feb 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9niwD0w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62D28DBF;
	Mon, 19 Feb 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345692; cv=none; b=gnjkfZPvzkustS2oapB4PgOJ0q4eBmudXKdmza56L2/tnkoBgu6wlC6s/eTryPnmMw4XzhyuVSCq0WiWQmS3ai77Keyb94LA6E/jXDbBo7AJ9Jsyou4MULNRiFFFtPKaOnPuHzWrb1q6Es8JaS+hpyqjaHiDS19y8S7hKxFm1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345692; c=relaxed/simple;
	bh=it1Tistn1sJEwMWIAWLGZANrDgy48BdgJy8fXAyeYMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3X2GkCrB3UQuBrSX8Qbk/0/bLXEXdejbnfQTPB3xsYkEosweQb9bHtfGpMeZxR3SlJDE1mHNfv7jAG4eEm5DqpECfpFNDFmQ8Mh0pcLY9U0faDVm7hLXjM/wFQl0Yp0CidZPOA4gA1P4FoL1bizaChR9dXA1rr25TeqSdTA48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9niwD0w; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708345690; x=1739881690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=it1Tistn1sJEwMWIAWLGZANrDgy48BdgJy8fXAyeYMM=;
  b=J9niwD0wIUUDkmuUvJLiDUkF6Zv4cVEszF/3z6pxKuKl7/m2CioC7CpB
   d/rC2c6woR+/R5RZhrIyrRKlhDxDi0ZurTT16WZBFzu3fozZHwTFq/klD
   EpKjvIchRlNQ8HhYiUX5WqTtaNXIxdkf3OXzw8N6JFjqAO8igLouyk3ir
   wL0kUUpWlhaUsQ8yTbGemfvxMpxk2SaVzY6BvmCNJwfCbxckIuC7x8uAM
   6tUPPex51mqU+RoxY2734vj6lTfrz45AeDBMPFjULKfEHY+v+ytewcof0
   zmGmmd7CUgnbhxl/sdqFJ/+C78PZUm7rs9vIY3NyEbhEo8BjJNpSXD1A9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2545100"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2545100"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:28:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="936286215"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936286215"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:28:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc2kX-00000005opQ-3pKm;
	Mon, 19 Feb 2024 14:27:57 +0200
Date: Mon, 19 Feb 2024 14:27:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <ZdNJTTy3j90mL8CJ@smile.fi.intel.com>
References: <20240219065026.578517-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.ec4cd694-3b45-4b64-9a96-fc1ccc42fc68@emailsignatures365.codetwo.com>
 <20240219065026.578517-2-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219065026.578517-2-mike.looijmans@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 19, 2024 at 07:50:26AM +0100, Mike Looijmans wrote:
> Skeleton driver for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.

This version seems good enough,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



