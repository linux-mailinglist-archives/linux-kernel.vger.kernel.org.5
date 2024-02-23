Return-Path: <linux-kernel+bounces-78563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA4861516
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7619286636
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC51B8003B;
	Fri, 23 Feb 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9pHssy9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05429AF;
	Fri, 23 Feb 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700620; cv=none; b=aadnKTJzLnYY25d9DHqiwY7YfYtPpKmc4sqvcr5gV8sIbuGDwD5cKOlJRcit/uaKeeFYmwhxLEeAr6Xj55mEVwz41x5WWDzPZTGraJ+Ms4YKACr7ngS6IJsNwOXRCdXN4qUPfPq64bMnfeJvur2d6y3E/3Cpnm45UEmbeymNK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700620; c=relaxed/simple;
	bh=XJ4uK049YbYNUUHoL7aPqziogI3mOCKCzfvXZt0+OhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrVDZlbFJGkolMUaIBcNd6ietRAiMoWl3xhICiyr3VbGuhHL7FJbi5sARWpYIuZVYqhVDB0Pb46JZnTf1MLzoIV6fV/wECB4QxWuv89kONYIkCMfK4/P+qJuvSJlDBYX9cusGagozlc0XmcXCcqirs7jX7OfvKcKUtlMxR3ceQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9pHssy9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708700619; x=1740236619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XJ4uK049YbYNUUHoL7aPqziogI3mOCKCzfvXZt0+OhQ=;
  b=F9pHssy9YJIaILwjvrSej5aVFCT9XhR0Br2TpsLhjlo+FoAlIDtey8B8
   m4x1YohYv3zbD9BKWrpBOTjAAmg2l1cCtZM1sTWZ0k8rUvISUk9pdV8Yq
   cAGseRWLVh55t3yWOcSRUsfjEmQtX9jyJQgBh67RRHZ69FtLsKHvCKEoP
   Z9V2R5jDsFd33ihk2jJG+2FcyRyr5P5vcpZ23maEKMIVDuCxPfvonokRl
   Do+ijkRUoo8kIuj0PYF888Lm8pJfuXTE4kkQHhcIyb2WaGNvyQp8KMe/M
   FfNIquHdIQopare3kwMB43VqK6m66JfuPdTuvUCK1br/q0RFAuS2KFGE3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6833945"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6833945"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:02:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913748390"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913748390"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:02:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdX4H-00000006vhH-3v03;
	Fri, 23 Feb 2024 17:02:29 +0200
Date: Fri, 23 Feb 2024 17:02:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v1 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
Message-ID: <ZdizhVPfwFp72ioI@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
 <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
 <ZddKzHplwOX7naLv@smile.fi.intel.com>
 <Zdd5m2xIPlGI0_Qv@smile.fi.intel.com>
 <Zdd6lnXwvpPPUhRR@smile.fi.intel.com>
 <e5fd9d8b-84eb-4ef9-82ab-ff4ecc41c0d5@broadcom.com>
 <ad91eec0-39da-4b9c-8da7-f1e98bb4565b@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad91eec0-39da-4b9c-8da7-f1e98bb4565b@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 11:54:46AM -0800, Florian Fainelli wrote:
> On 2/22/24 09:39, Florian Fainelli wrote:
> > On 2/22/24 08:47, Andy Shevchenko wrote:

..

> > Thanks, on 8250_bcm7271.c with the above hunk applied, I did not spot
> > any differences between the values returned by stty or a cat
> > /sys/class/tty/ttyS0/* before or after, the console remained fully
> > functional. I will see if I can run an additional test where I removed
> > the DT's "clocks" property and confirm that the fall back to
> > "clock-frequency" works.
> 
> Also appears to work properly on a Raspberry Pi 4 with the console using the
> bcm2835-aux driver, will provide Tested-by tags on the next submission,
> thanks!

Thank you for prompt testing on real HW!

-- 
With Best Regards,
Andy Shevchenko



