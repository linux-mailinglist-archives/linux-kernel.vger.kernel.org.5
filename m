Return-Path: <linux-kernel+bounces-93994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88385873804
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1793EB23C21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9195131745;
	Wed,  6 Mar 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lO6/IRrN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0112D208;
	Wed,  6 Mar 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732593; cv=none; b=bQJR28wd7wraaKlAB3y1dBnpfAaF5sfVIeHWQc4OJb5qFsbYBDZPwPRVOP/MrzfhZDE8N05CgXM98XA9rPVkMHNJHQrOras8rdChchHG6eUcNyfNtoENcZB2yKMZYCqiVW9D2weN5io8bLzhXqVeFXX8m1FXHvMkbEh4XtCrrX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732593; c=relaxed/simple;
	bh=Dpzqs+qEHnXZBkM+HHklxhqynUa//LfFylt3W/ZJSLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4NwWFv1wZRdl5pzfrA4q1derXkKHjr1M+9ZDKtrXw5YJDRiHcCZySR6A5pbiJd+DLpzVjcbovgX+SVqLY0KP9msdAAfT1BHav/gFsqZUlVFpv1qBocwG7w6r+wHjkrFBJ3K+XU/yVEAbndtfBo01Wwg+8idlSe4FUhd6xkaOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lO6/IRrN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709732592; x=1741268592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dpzqs+qEHnXZBkM+HHklxhqynUa//LfFylt3W/ZJSLw=;
  b=lO6/IRrN1I/owSGFBqu7dStThbzAlvDaULQ2cKK3qbaC3LX6HecYOUEI
   DhtirinkA1SD3C3Pu/MRSNUUceyucPpUYiBwxBu4ZZwsmoB6wWhAF+5+s
   eIf8gUHik6M0cwy1/FWtdB1Rcn7DmwEsoTXfl0+7qvxuZEHCUibuddci6
   qnxcXHpElwsWBI4MnRPAe47QPOaQX121F1DxuLYRfLMbJu9b2dV6THz3E
   wpwB3BC8ro2jCv89J+8CTmadRqhq/UQ/Nf89qGGHm7Dtaa5zHtLYPdaqu
   y8C4vwLDPDaJ1q6c4BnT29DRoGoVULHzn0s2Lp5SsOzH0lrk4tqv7tYNU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4208297"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4208297"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="914178807"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="914178807"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:43:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhrY0-0000000AHKB-1gCu;
	Wed, 06 Mar 2024 15:43:04 +0200
Date: Wed, 6 Mar 2024 15:43:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
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
Message-ID: <Zehy6K0Sj-cqcxZE@smile.fi.intel.com>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
 <20240306080726.167338-5-herve.codina@bootlin.com>
 <ZehqRMZwtazTf6P6@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZehqRMZwtazTf6P6@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 06, 2024 at 05:06:12AM -0800, Yury Norov wrote:
> On Wed, Mar 06, 2024 at 09:07:20AM +0100, Herve Codina wrote:

..

> > +	DECLARE_BITMAP(ts_mask_avail, 64);
> > +	DECLARE_BITMAP(ts_mask, 64);
> > +	DECLARE_BITMAP(map, 64);


> > +	bitmap_from_u64(ts_mask_avail, ts_info->rx_ts_mask_avail);
> > +	bitmap_from_u64(map, slot_map);

> We've got a BITMAP_FROM_U64() for this:
> 
> 	DECLARE_BITMAP(ts_mask_avail, 64) = { BITMAP_FROM_U64(ts_info->rx_ts_mask_avail) };
> 	DECLARE_BITMAP(map, 64) = { BITMAP_FROM_U64(slot_map) };

This looks ugly. Can we rather provide a macro that does this under the hood?

Roughly:

#define DEFINE_BITMAP_64(name, src)				\
	DECLARE_BITMAP(name, 64) = { BITMAP_FROM_U64(src) }

-- 
With Best Regards,
Andy Shevchenko



