Return-Path: <linux-kernel+bounces-48059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4038456C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6846B28C3A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B3C15B984;
	Thu,  1 Feb 2024 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="embjLUcr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1AD4D9E7;
	Thu,  1 Feb 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788996; cv=none; b=jiWiYuN7tNEbhIOFWkCMHYhnNq02Q6c5eaE389ZINv6IYyAnXu2aisTq9Qp5cRuXT2Ip6wj5nhjtWMBbSd1OHdcHw0TQuZqSQlHQha+9y1ydnswxtzEYF+GoAe2kKLWuhkXCGl2nxkXyGUAZjHFghmEh0yhYueCdzuEGJ1zyF+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788996; c=relaxed/simple;
	bh=Dy6YfzeYz5+kG2DcPp827T0bxKzrA+4hsfyIKLG5kQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUKmIuaPb3WJb+qOw0vkqWD7QxSNys+UdvTlohsD0/agxtJHJ9M7Yqc66lKLzCUQX7ccyIUqJ0ihrg+qbWtLWHMUsy/AlgeCNQ1avj9n8mRANezWujPeUViZDFYntatxUstmakTpWDl4PRQdjmgGZGZ3MGWS0LGp0mU4GDtVL3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=embjLUcr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706788995; x=1738324995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dy6YfzeYz5+kG2DcPp827T0bxKzrA+4hsfyIKLG5kQc=;
  b=embjLUcryl49odafBApUcwGPLIaToB2YGtPS7Gt+w60Wer8llTW4Wpx7
   M+Ui2U5CWY833/5L8WkdiAOT2sYZYs56Y+mNfLAi3MAiEgxCP8WWyNQs9
   Po9HBnOTHvLELJAcWgPNMUK/Pa/ic3ygggBmqMr2HbKgi1QvR0sq8IL/n
   d0HeCZ/kFfj8aw3nb2fva7pMNuNeZ74ya/N3SpP7g6xH4EG3Sb/fDgpOf
   4lr7Gh4YpLuXuzwfvny0EA74F0KjBvITtrBf6GOgKsrU1zpI7J7KgGatN
   Y46na22lhQEbLCYGrN6ooXqhZMxr0OhqUgGMazBgwYjw0cPays1R51aDQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10531536"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10531536"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="738410569"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="738410569"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVOb-00000000ots-0my3;
	Thu, 01 Feb 2024 13:38:17 +0200
Date: Thu, 1 Feb 2024 13:38:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Liam Beguin <liambeguin@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <ZbuCqEWqpDadeF_v@smile.fi.intel.com>
References: <20231213094722.31547-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.27993507-256d-4b05-88df-c8643e7f1a68@emailsignatures365.codetwo.com>
 <20231213094722.31547-2-mike.looijmans@topic.nl>
 <ZXnF72wJCAeYWA8X@smile.fi.intel.com>
 <406d445a-3ce3-4253-8966-de2dac6f7c23@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406d445a-3ce3-4253-8966-de2dac6f7c23@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 31, 2024 at 05:10:08PM +0100, Mike Looijmans wrote:
> On 13-12-2023 15:55, Andy Shevchenko wrote:
> > On Wed, Dec 13, 2023 at 10:47:22AM +0100, Mike Looijmans wrote:

First of all, please remove unneeded context, don't make me waste time on doing
that for you!

..

> > 		*val = sign_extend32(get_unaligned_be24(priv->rx_buffer + chan->address),
> > 				     23);
> 
> Doesn't fit, first line is 83 characters by my count...

Is it a problem?


-- 
With Best Regards,
Andy Shevchenko



