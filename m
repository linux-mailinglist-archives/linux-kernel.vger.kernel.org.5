Return-Path: <linux-kernel+bounces-90483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC4D86FFDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170C7284613
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37BA39AE8;
	Mon,  4 Mar 2024 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXmpRFRn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A36383B9;
	Mon,  4 Mar 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550560; cv=none; b=SSO6KBxPv6Dpp6e0wi8ad3pknkJBkVF3aRCGnz7BDHtDNjdJaCyYlsNq8Owtvli1iktQShDFx32vfZiqhGu8fNt/55pV8mpT7OBZKnFBHjl7JiBcaVBFPm4Y2Ab7e2GaWK7RwiK4pYGfS2Fok8WaWeXkhdNJ7+FB+DeiuIn1nSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550560; c=relaxed/simple;
	bh=KXv3Q2iupm09gepMI0TpXGJCp9MnBfLCvS53P06EY2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbrY8v5Whk7jhb3FS28VdAPQyeImDOgdOUBdDTGTbW60P5ir8QPN45SBklkrRq1/yuILox/xSmMTrkCbI76mREOqpvGVD/NRyM6G+y66YflmT4HrRtsdMRogqvAG9ZvDUcKPdWX4KtFqEx500THpOnVeC1cEEPbBT7NCkahVssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXmpRFRn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709550559; x=1741086559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KXv3Q2iupm09gepMI0TpXGJCp9MnBfLCvS53P06EY2k=;
  b=OXmpRFRnlz4JhY6eMUcydd+QD+OZiaGVneBjNu0zd5WqeO4v0k6l+URC
   Tc3t/4AmXYkUjuXA1QgB4oDVg+oQ7OtnlzAxrZEHm6u8Vnu/4kn3zz8pv
   WZ2D7MYE1qOTQNPxkhQuOl91AZKt4YwllBT/Yjv3wjZrN1Sfkc7sprC0V
   PvYGT9M9X9cgNI1hSGBen8DYjG1rvPLV4PQwF8NXgqWbkFi4kvdd6mzhk
   d6aCfEBOumht1fTbSEvEjRv7zHHfTtGGWdfkDhOk+C0WnjxjetkKjDv92
   eBVWC2pIPjAb5n/qZ1VBSnkVaRxDDPN216VeJ3XJc03UjLMb0oVkJqT2i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4202222"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4202222"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:09:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="914102864"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914102864"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:09:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rh6Bw-00000009hG5-1IAi;
	Mon, 04 Mar 2024 13:09:08 +0200
Date: Mon, 4 Mar 2024 13:09:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 03/14] serial: port: Introduce a common helper to read
 properties
Message-ID: <ZeWr06YWj5cDHfWL@smile.fi.intel.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
 <20240226142514.1485246-4-andriy.shevchenko@linux.intel.com>
 <2024030259-playback-starlit-a472@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030259-playback-starlit-a472@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 02, 2024 at 09:58:53PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 26, 2024 at 04:19:19PM +0200, Andy Shevchenko wrote:

..

> > + * uart_read_port_properties - read firmware properties of the given UART port
> 
> I like, but:
> 
> > + * @port: corresponding port
> > + * @use_defaults: apply defaults (when %true) or validate the values (when %false)
> 
> Using random booleans in a function is horrid.  Every time you see the
> function call, or want to call it, you need to go and look up what the
> boolean is and means.
> 
> Make 2 public functions here, one that does it with use_defaults=true
> and one =false and then have them both call this one static function,
> that way the function names themselves are easy to read and understand
> and maintain over time.

Okay! I'll redo that.

..

> > +EXPORT_SYMBOL(uart_read_port_properties);
> 
> EXPORT_SYMBOL_GPL()?  I have to ask :)

No clue, the rest in this file is EXPORT_SYMBOL, but I admit I followed the
cargo cult. I'll check the modified code and see if I may use _GPL version.

Thank you for review!

-- 
With Best Regards,
Andy Shevchenko



