Return-Path: <linux-kernel+bounces-97118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979828765B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB4F1C217A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87639446DE;
	Fri,  8 Mar 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFDe9mKk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9F4086D;
	Fri,  8 Mar 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906116; cv=none; b=nTY+EMNflgX0YLnNrxS0k8oTCiOsxLNiM8KJ13YZCoZpDoaQH9KbdNFsT/8u40k9ofwQoYcv3Cm6CaBKWAxURVx2QFL7C5kSBNwkJ9SvI5quTqfSYhTqDqz+JMBj5LjyA/InZnlc7aXgmfWo0uAiiUn+cFPOjV8zwNQZhvKMpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906116; c=relaxed/simple;
	bh=AGDElk8B3tL42Shz+clnRrV4J7k7xruCRry267aVvvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMY4gswgIs6vDDbhBC1ZlsBLxoKZHrGrSqp+/KqB+SWg5IRfXCpgfcJO0J8xfNM+dmThuDFtYPaA7s0Iqh85ouZTgCYQsWDLJURevJlhVH/52iA90Z2DBLVn7yWoZvJukRFmP0n9/OYzwDyTYu0YXjRjzgF4O3Z9FCzAU/WG0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFDe9mKk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709906115; x=1741442115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AGDElk8B3tL42Shz+clnRrV4J7k7xruCRry267aVvvs=;
  b=MFDe9mKk+p6h42vGFqImOdnFvY154m/2I5DJLLQKFzOMf8BPAjPoJ4Ya
   rcSXJD9QZFYO1eQqg4U2fqfqFb8xaIraB5kAMEOL1Cxe0SI92K4UWx28c
   61nFlid47CxttTI8efoAI26YX1f38bsux3N6lHuQSq8SgEQZziHz3AZ2P
   H7G1WYvsY6QY44FgrUc5hINDIzGLrmDEe2IojUAcgpTQAvkQ7qZObUlMH
   NB8kcLwJqX9Cc7AUFdXWIpEvWu2t6lrT/ujhFOvsdN5RtaTgLBQkxAyn0
   ukLLJBl6GFAQkB8b6llbkQpf9ZbF/INY3VOWrOXCA/iOjd3dV1KQXqFwm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4495046"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4495046"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:55:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914247235"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914247235"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:55:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riago-0000000Ar4c-2OQL;
	Fri, 08 Mar 2024 15:55:10 +0200
Date: Fri, 8 Mar 2024 15:55:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 3/3] spi: xilinx: Make num_chipselect 8-bit in the
 struct xspi_platform_data
Message-ID: <ZesYvnwiSMPMq98s@smile.fi.intel.com>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-4-andriy.shevchenko@linux.intel.com>
 <f7a882c8-5858-4d6b-8a70-0702c3170661@amd.com>
 <ZesTS2LDEYz_bbPK@smile.fi.intel.com>
 <1e35a288-0a11-4df6-b7c5-82e5cb6e1d3c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e35a288-0a11-4df6-b7c5-82e5cb6e1d3c@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 02:48:04PM +0100, Michal Simek wrote:
> On 3/8/24 14:31, Andy Shevchenko wrote:
> > On Fri, Mar 08, 2024 at 09:20:23AM +0100, Michal Simek wrote:
> > > On 3/7/24 16:43, Andy Shevchenko wrote:

..

> > > >    struct xspi_platform_data {
> > > > -	u16 num_chipselect;
> > > > -	u8 bits_per_word;
> > > > -	struct spi_board_info *devices;
> > > > -	u8 num_devices;
> > > >    	bool force_irq;
> > > > +	u8 num_chipselect;
> > > > +	u8 bits_per_word;
> > > > +	u8 num_devices;
> > > 
> > > all above have 32bits. It means on 64bit cpu you have 32bit gap here.
> > 
> > > > +	struct spi_board_info *devices;
> > 
> > On all architectures? I mean do all 64-bit architecture ABIs _require_
> > the pointer to be aligned at 8-byte boundary? Even if so, the struct
> > itself can be aligned on 4-byte boundary.
> 
> I am not able to tell if toolchain enforce 8byte alignment by default/by
> setup on all 64bit systems.
> I am using pahole to check this which was recommended by Greg in past which
> reports gap in the middle.

I see, thanks for explanation.

Yes, it's likely that in some cases it will be a gap on 64-bit platforms, but
after this patch no gap on 32-bit. Do you still want me to reshuffle that as
you suggested?

-- 
With Best Regards,
Andy Shevchenko



