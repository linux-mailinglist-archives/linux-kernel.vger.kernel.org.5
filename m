Return-Path: <linux-kernel+bounces-94205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F48B873B50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC52281DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9287A135A6C;
	Wed,  6 Mar 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lj9C1aaF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054C5DF3C;
	Wed,  6 Mar 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740555; cv=none; b=MSTFxkf32qWRRGFgipDEenqEB80MyqCeQzCvml7++Qv8rCO2ZW91v1vbFA/m0Ixy3OpI1ogN4+tcpXdxvljxVyuj9jTbGSyY7e2aUfP9h9oO3hMZtmx1T/lcS+DMNvMh28q55/sStyalOz3J3MgC6VnLHeawl27gD6h1YzNdjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740555; c=relaxed/simple;
	bh=DWLsQTYRY4NV202mbVOUcPSKxCp8J/1ljk2rS3jeIHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1F69fdSTo4l/C41Jn7r2qUCydFiiXc6vtECGW90quK/iUM0kKseYav1n7Oe6zQb6UvefzYD6qJRBachaOqT47TV8cLUcYGTV7nebuQYM1vKRfmq4CjUR8ofdCMMyxv/nThNh/KCU6m2exfpLOxXbUAmy/FxZr0c533CQjOKqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lj9C1aaF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709740554; x=1741276554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DWLsQTYRY4NV202mbVOUcPSKxCp8J/1ljk2rS3jeIHY=;
  b=Lj9C1aaFQFlCKmUjGwH+DYcY88GHnm8nCX92u2VesKc/VCaKskp2M87D
   rfYNBNX7sJbyG04olI03pNT0JFjBZZ+hBf7UzX0YOdFOwFL0iJtsegB+A
   jGSiekBoS8jOrEe98/8CNoQ+ob/itfGuEJvufa9dGn1VsK9i2O2e66ucC
   1mRN04bjnuGKiv3oH4VAODLnZ61Bgvb4u4MrT7cg+Qzm4vYNzrx1wtOfi
   ztAC1pdI3lO7CYKL5RiR715/6SN4mF0TqjebVUqfdLYth5hy/LOcESBxQ
   Wx5e1DUdk/xwPQXKpUHVSDyZP34HNVnJ9X4eMFHIRtzwM6zda9Y8Rddwg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4541549"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4541549"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 07:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="914182389"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="914182389"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 07:55:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhtcQ-0000000AItQ-22Eu;
	Wed, 06 Mar 2024 17:55:46 +0200
Date: Wed, 6 Mar 2024 17:55:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 4/5] net: wan: fsl_qmc_hdlc: Add runtime timeslots
 changes support
Message-ID: <ZeiSArlb24aSp-CJ@smile.fi.intel.com>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
 <20240306080726.167338-5-herve.codina@bootlin.com>
 <ZehqRMZwtazTf6P6@yury-ThinkPad>
 <Zehy6K0Sj-cqcxZE@smile.fi.intel.com>
 <20240306164311.735ded83@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306164311.735ded83@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 06, 2024 at 04:43:11PM +0100, Herve Codina wrote:
> On Wed, 6 Mar 2024 15:43:04 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Mar 06, 2024 at 05:06:12AM -0800, Yury Norov wrote:
> > > On Wed, Mar 06, 2024 at 09:07:20AM +0100, Herve Codina wrote:  

..

> > > > +	DECLARE_BITMAP(ts_mask_avail, 64);
> > > > +	DECLARE_BITMAP(ts_mask, 64);
> > > > +	DECLARE_BITMAP(map, 64);  
> > 
> > 
> > > > +	bitmap_from_u64(ts_mask_avail, ts_info->rx_ts_mask_avail);
> > > > +	bitmap_from_u64(map, slot_map);  
> > 
> > > We've got a BITMAP_FROM_U64() for this:
> > > 
> > > 	DECLARE_BITMAP(ts_mask_avail, 64) = { BITMAP_FROM_U64(ts_info->rx_ts_mask_avail) };
> > > 	DECLARE_BITMAP(map, 64) = { BITMAP_FROM_U64(slot_map) };  
> > 
> > This looks ugly. Can we rather provide a macro that does this under the hood?
> > 
> > Roughly:
> > 
> > #define DEFINE_BITMAP_64(name, src)				\
> > 	DECLARE_BITMAP(name, 64) = { BITMAP_FROM_U64(src) }
> > 
> 
> Well, the construction I used:
> 	DECLARE_BITMAP(foo, 64);
> 	...
> 	bitmap_from_u64(foo, init_value);
> 	...
> can be found in several places in the kernel.
> 
> Having the DEFINE_BITMAP_64() macro can be a way to remove this
> construction but I am not sure that this should be done in this
> series.

I also think that this can be done later, above is just a pure suggestion how.

> IMHO, a specific series introducing the macro and updating pieces of
> code in the kernel everywhere it is needed to replace this construction
> would make much more sense.

Right.

-- 
With Best Regards,
Andy Shevchenko



