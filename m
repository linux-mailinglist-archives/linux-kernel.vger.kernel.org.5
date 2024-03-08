Return-Path: <linux-kernel+bounces-97088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4DE876556
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FC61F246EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8413BBF5;
	Fri,  8 Mar 2024 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBWANleu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03DC2209E;
	Fri,  8 Mar 2024 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904721; cv=none; b=ppSGywWGFmNrGwggfIM9gOQTHyYTlsXwm4K5R5ZMHEYrZYUYPEdjwp0bmxn0vLfrm9e0LeJCvHz88VvWLh7ErRkoXXg3yWUBl6Qe2AMbAQxOt2Xb1fpvvFvSsv4JoXG1cQsal4GRcTbCH7Kpaw5HA7VaX+BFeUVDd4SPChRXvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904721; c=relaxed/simple;
	bh=ZaAWTlPgDjUoN2kouy32uLLLJsHht4DaN06qV24JYmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDtLmOXf9B8kSbc8i4DyLToz8D/1q7EJnJEAcLDtDbhjjsRGn+9fLtFs4XwUcs37AUZAXVIlC0sWPMcrxU/OTQQFauERbXLFwaXJSWeCnCZrCiJn8zZWcACRVxJCrgao2cS2jBA/7Lo8gNPixaQRu7B9OGgGdQP9Ee3ujM0ApLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBWANleu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904720; x=1741440720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZaAWTlPgDjUoN2kouy32uLLLJsHht4DaN06qV24JYmM=;
  b=SBWANleuZbihzNWYF7B6U7PZtkr50J+22H8d3S2xaIE0CFV8pnJHCvFO
   3jXTIOWoo9E+GKTSW8xuq8Udoenc6yQkcuSWjUZWFiK+GKwSyXVUnPXSF
   3zEzZ4TsLZf9WFoEvmf9yS47tCK9I+ZZ6lSGL00T19YW2eq2mHo1hv9PC
   b5hfayPM0lAoGcPfF3xOUwmRsjngGrPgwIfWmEy5sPf8Sj+3uarBvexYZ
   hrNH2kzpuQM9NFDItyTrnOj3CrrDP97pdoSqNLFXlkZ6WLpZO04sxV5m2
   8RdDEZy1Yei3rumt6do/yTonUjcM2Oo8C2FFDUf13+fzrOX1YwiuM7omp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4492977"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4492977"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914246667"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914246667"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:31:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riaKJ-0000000AqmE-13GA;
	Fri, 08 Mar 2024 15:31:55 +0200
Date: Fri, 8 Mar 2024 15:31:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 3/3] spi: xilinx: Make num_chipselect 8-bit in the
 struct xspi_platform_data
Message-ID: <ZesTS2LDEYz_bbPK@smile.fi.intel.com>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-4-andriy.shevchenko@linux.intel.com>
 <f7a882c8-5858-4d6b-8a70-0702c3170661@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a882c8-5858-4d6b-8a70-0702c3170661@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 09:20:23AM +0100, Michal Simek wrote:
> On 3/7/24 16:43, Andy Shevchenko wrote:

..

> >   struct xspi_platform_data {
> > -	u16 num_chipselect;
> > -	u8 bits_per_word;
> > -	struct spi_board_info *devices;
> > -	u8 num_devices;
> >   	bool force_irq;
> > +	u8 num_chipselect;
> > +	u8 bits_per_word;
> > +	u8 num_devices;
> 
> all above have 32bits. It means on 64bit cpu you have 32bit gap here.

> > +	struct spi_board_info *devices;

On all architectures? I mean do all 64-bit architecture ABIs _require_
the pointer to be aligned at 8-byte boundary? Even if so, the struct
itself can be aligned on 4-byte boundary.

> It means this should be like this and then there is no gap between on
> 32bit/64bit systems.
> 
> struct xspi_platform_data {
> 	struct spi_board_info *    devices;              /*     0     8 */
> 	bool                       force_irq;            /*     8     1 */
> 	u8                         num_chipselect;       /*     9     1 */
> 	u8                         bits_per_word;        /*    10     1 */
> 	u8                         num_devices;          /*    11     1 */
> 
> 	/* size: 16, cachelines: 1, members: 5 */
> 	/* padding: 4 */
> 	/* last cacheline: 16 bytes */
> };

-- 
With Best Regards,
Andy Shevchenko



