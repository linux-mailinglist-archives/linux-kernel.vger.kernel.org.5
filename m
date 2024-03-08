Return-Path: <linux-kernel+bounces-97202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E368766EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330B32839AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C660563B8;
	Fri,  8 Mar 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hK63DX3p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF115AF;
	Fri,  8 Mar 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910086; cv=none; b=XiZbNdZEVEfdBJD1UIP93vpw2vplCnpIw01drs4dXeFmBSQIpbo1t4MRbUs6b/asoUI9zyldkBZUhrofV/F6cG7krntLq9rP5FDvegYJRmn3w/Qy8pBrn+6DADiCcr/e+gvIiVNiSJnwT8pUsP2YYgCB4+71ANPMsAjEA7DQwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910086; c=relaxed/simple;
	bh=5rIXEhWDQMbkuKjMq7leuyhnVkYnqFlg12KNyns3grg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtkKv7v/jHKQNr0sLLYF7Ola+mvsF55IJvk8sx0kGGWK3nXKGvCwPPXO+hpRWNf4Z/ezR1g0Xj+y6lQtcikEv44eu1HuvXXAJT+/ImsIthbYg4lTvf0bpo/6u+X8nMNFuwmQmCdvyCO/o4o7ROthgJvMNBQJkRl+CPqNKzsEY7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hK63DX3p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709910084; x=1741446084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5rIXEhWDQMbkuKjMq7leuyhnVkYnqFlg12KNyns3grg=;
  b=hK63DX3p0YIrf3onr9wSoHzytXYQ+cNU0WIyuuLsM6yc1OufIGTFCxPV
   5IhzK1xa008cY39cQjtlt2ZkcaIaKkz+Bw/G67aJBwy0T5uglE/BJIDvQ
   xiPUbjIQMygvuDb+RzOwPE+oPMcSY5IP5tRHHtDk12LPtw0QGfHhy+kC2
   PDqxcED4FH1EuNpXH8XKue+HdtIe+ucxrR8iS9NUM1AWL5WUhuAixDLrS
   vcVSIUs7zpl9MW7ZB3HmTfmYLbesT2xCqIPu157IlG3mb9RCOqFidT0Cy
   RymhNcDoIcrdRbn3mbUPwuLhYefMMx61CAmTm7f3DI3CbuinczNGoKmp6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4500350"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4500350"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:01:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914248433"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914248433"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:01:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ribiq-0000000Artm-0LUO;
	Fri, 08 Mar 2024 17:01:20 +0200
Date: Fri, 8 Mar 2024 17:01:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 3/3] spi: xilinx: Make num_chipselect 8-bit in the
 struct xspi_platform_data
Message-ID: <ZesoP_XL7MQ_Wh51@smile.fi.intel.com>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-4-andriy.shevchenko@linux.intel.com>
 <f7a882c8-5858-4d6b-8a70-0702c3170661@amd.com>
 <ZesTS2LDEYz_bbPK@smile.fi.intel.com>
 <1e35a288-0a11-4df6-b7c5-82e5cb6e1d3c@amd.com>
 <ZesYvnwiSMPMq98s@smile.fi.intel.com>
 <58dca460-d363-432d-9ea7-7f29ec9c4050@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58dca460-d363-432d-9ea7-7f29ec9c4050@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 03:00:55PM +0100, Michal Simek wrote:
> On 3/8/24 14:55, Andy Shevchenko wrote:
> > On Fri, Mar 08, 2024 at 02:48:04PM +0100, Michal Simek wrote:
> > > On 3/8/24 14:31, Andy Shevchenko wrote:
> > > > On Fri, Mar 08, 2024 at 09:20:23AM +0100, Michal Simek wrote:
> > > > > On 3/7/24 16:43, Andy Shevchenko wrote:

..

> > > > > >     struct xspi_platform_data {
> > > > > > -	u16 num_chipselect;
> > > > > > -	u8 bits_per_word;
> > > > > > -	struct spi_board_info *devices;
> > > > > > -	u8 num_devices;
> > > > > >     	bool force_irq;
> > > > > > +	u8 num_chipselect;
> > > > > > +	u8 bits_per_word;
> > > > > > +	u8 num_devices;
> > > > > 
> > > > > all above have 32bits. It means on 64bit cpu you have 32bit gap here.
> > > > 
> > > > > > +	struct spi_board_info *devices;
> > > > 
> > > > On all architectures? I mean do all 64-bit architecture ABIs _require_
> > > > the pointer to be aligned at 8-byte boundary? Even if so, the struct
> > > > itself can be aligned on 4-byte boundary.
> > > 
> > > I am not able to tell if toolchain enforce 8byte alignment by default/by
> > > setup on all 64bit systems.
> > > I am using pahole to check this which was recommended by Greg in past which
> > > reports gap in the middle.
> > 
> > I see, thanks for explanation.
> > 
> > Yes, it's likely that in some cases it will be a gap on 64-bit platforms, but
> > after this patch no gap on 32-bit. Do you still want me to reshuffle that as
> > you suggested?
> 
> Yes I would prefer to do that change when you are doing cleanup.

Can you give your tag? Then I prepare a new version with addressed comments
against last patch.

-- 
With Best Regards,
Andy Shevchenko



