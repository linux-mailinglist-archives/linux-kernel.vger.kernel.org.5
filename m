Return-Path: <linux-kernel+bounces-97203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A888766EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6795B21392
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB00568A;
	Fri,  8 Mar 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pi4dB69e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C41D554;
	Fri,  8 Mar 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910123; cv=none; b=MD24qxGO+BjwV631EeFpK0Km1zeqTKjfMpsmb48ZHxSlT2nbps4Js2Mv0ewhS+oHshUWjGNXL9JOl9LBSOcF+8MlhBQS55XcvNQ+ZQVfT81eVZDOTJhn2EitM2G0fOcaoV2sXQVQ93FKa8gYU72hq04tNTorJuQ/U8maT2HkcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910123; c=relaxed/simple;
	bh=P+x+xLkSp5CqqyIjHEEQvg/4G2G7oevzxOV2YHyMIhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4zYsE+ISkO3q9cWoLkwIkOlSvcg9SrM3+GSS+WIhq6MiMEpalpop4Tfh9btyt/ARx1N1dleDFwi/jj3Lx2z6TitTBw0d23+y1v9R353d+74stOyRXruCSG5xKa8I6phbZ/AL9CFfv8wnvOBUU/iJKWmhVel/I0aVRRehl2c2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pi4dB69e; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709910122; x=1741446122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P+x+xLkSp5CqqyIjHEEQvg/4G2G7oevzxOV2YHyMIhE=;
  b=Pi4dB69e/jP39zPnIQ4gulCpKDf8lGLYYxkzeidxB1jYlHUp2CCEVkkb
   gaJU3k76qc/YhSC9kRTIRAXeHkBoDZc/Uw+t9161U6pd5i1s7aXjlQX51
   PLMWJGkn1KdtVmfIrzUzpvxKYeC3YSFLJAtnkqOtT9Tjqfut2sfrOi0qX
   Xsrl9OIbjgTVHvK7nuMd5FfvvjC9cTTRGexOwDEuloWiIuualXGm8bDwg
   eCGCEocgn8O8mA8yI6tX68eOe/YjMngYHYmcwgjuBKwt263K5lGD/OW50
   7Fm3RSUCvaqPwa3D+6XYF0f4rrytg2MNlBqg1QTKAeoajjHF17W2amY5f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4500484"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4500484"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:02:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914248458"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914248458"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:01:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ribjR-0000000AruW-0AG6;
	Fri, 08 Mar 2024 17:01:57 +0200
Date: Fri, 8 Mar 2024 17:01:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 3/3] spi: xilinx: Make num_chipselect 8-bit in the
 struct xspi_platform_data
Message-ID: <ZesoZKAZda7XkGhj@smile.fi.intel.com>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-4-andriy.shevchenko@linux.intel.com>
 <f7a882c8-5858-4d6b-8a70-0702c3170661@amd.com>
 <ZesTS2LDEYz_bbPK@smile.fi.intel.com>
 <1e35a288-0a11-4df6-b7c5-82e5cb6e1d3c@amd.com>
 <ZesYvnwiSMPMq98s@smile.fi.intel.com>
 <58dca460-d363-432d-9ea7-7f29ec9c4050@amd.com>
 <ZesoP_XL7MQ_Wh51@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZesoP_XL7MQ_Wh51@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 05:01:20PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 08, 2024 at 03:00:55PM +0100, Michal Simek wrote:
> > On 3/8/24 14:55, Andy Shevchenko wrote:
> > > On Fri, Mar 08, 2024 at 02:48:04PM +0100, Michal Simek wrote:
> > > > On 3/8/24 14:31, Andy Shevchenko wrote:
> > > > > On Fri, Mar 08, 2024 at 09:20:23AM +0100, Michal Simek wrote:
> > > > > > On 3/7/24 16:43, Andy Shevchenko wrote:

..

> > > > > > >     struct xspi_platform_data {
> > > > > > > -	u16 num_chipselect;
> > > > > > > -	u8 bits_per_word;
> > > > > > > -	struct spi_board_info *devices;
> > > > > > > -	u8 num_devices;
> > > > > > >     	bool force_irq;
> > > > > > > +	u8 num_chipselect;
> > > > > > > +	u8 bits_per_word;
> > > > > > > +	u8 num_devices;
> > > > > > 
> > > > > > all above have 32bits. It means on 64bit cpu you have 32bit gap here.
> > > > > 
> > > > > > > +	struct spi_board_info *devices;
> > > > > 
> > > > > On all architectures? I mean do all 64-bit architecture ABIs _require_
> > > > > the pointer to be aligned at 8-byte boundary? Even if so, the struct
> > > > > itself can be aligned on 4-byte boundary.
> > > > 
> > > > I am not able to tell if toolchain enforce 8byte alignment by default/by
> > > > setup on all 64bit systems.
> > > > I am using pahole to check this which was recommended by Greg in past which
> > > > reports gap in the middle.
> > > 
> > > I see, thanks for explanation.
> > > 
> > > Yes, it's likely that in some cases it will be a gap on 64-bit platforms, but
> > > after this patch no gap on 32-bit. Do you still want me to reshuffle that as
> > > you suggested?
> > 
> > Yes I would prefer to do that change when you are doing cleanup.
> 
> Can you give your tag?

I mean for the other patch, not this one :-)

> Then I prepare a new version with addressed comments
> against last patch.

-- 
With Best Regards,
Andy Shevchenko



