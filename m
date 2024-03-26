Return-Path: <linux-kernel+bounces-119679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD2D88CBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAAD32219D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B58627B;
	Tue, 26 Mar 2024 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7mVdm6o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48D86246;
	Tue, 26 Mar 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477387; cv=none; b=qZUJPItIums4zyC4XD7IHXKxvLcRZ2nhCiZnfafNf/DakkgKmHt187eoncT6XEpX75XFWAnUiWFqBsrUbN/Ohz/eD69iUWNhnCqdWEVodnqWA4+6lE0X5lHsXbEZVnVh8yhQKVmFufFQ96Hf0+x20ow0tsxd9ItJUTRUFLyFRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477387; c=relaxed/simple;
	bh=ovm4D3iXnxQ6zr4Ox8BpY0X8+EBVACIUdLnzTt2U7Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEnRvgBmtXPxZTRpBED9/sqWTXEiO98UW66Z0H79J/Ew687ZCoopVrhvnB+F6Un4z4VthhgshY9Ts1B0baNnd0SKfuiSWT6TADsufCQbdMKB5YZ0BHKUdXKLYBTZFfca0iAMxktwbi9s06a2qnXNldHc0WwCBJ6wMVDUyv8WTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7mVdm6o; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711477385; x=1743013385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ovm4D3iXnxQ6zr4Ox8BpY0X8+EBVACIUdLnzTt2U7Mk=;
  b=j7mVdm6oqZ+wmDFPFhquEisP/K/c7jKx+u7NvLFb1Ihw6v1SKmHpH4EM
   r1FdA5CvKAOpw/72hrTkN45lFMragJjDHouXUOQztX4Dbz/DB7bZTFu8n
   L8gMiBaxqH0vaJq/zju/ofPMuH9f9t7wa1YxSMjbA1+4+4emY/Vx+4EXg
   bS5S3i195fZtWc13fztHvUM9XytloWNFrBzY74+2eYjK894SNP4pdNbhX
   v6x9sDcqe7CBt76hW2lcxguI98vJMnciCx5FQ3n3cViPSRtRxoe7XC75D
   cPimg1mmJ4FNfCCO3KMthrl3SxtwCQpnM+AusaPGOOU8vFHYndIZ9+TU5
   g==;
X-CSE-ConnectionGUID: iAUJG2PjSPOmtsDb2yB6zg==
X-CSE-MsgGUID: A0gXSbnlRFeNPKC3zN26Pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6740890"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6740890"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:23:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914887365"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914887365"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:23:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpBRr-0000000GQ4R-3RDS;
	Tue, 26 Mar 2024 20:22:59 +0200
Date: Tue, 26 Mar 2024 20:22:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
 <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 06:16:28PM +0000, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 08:07:51PM +0200, Andy Shevchenko wrote:
> > Drop rather useless use of ACPI_PTR() and of_match_ptr().
> > It also removes the necessity to be dependent on ACPI and
> > of.h inclusion.
> 
> I think the ACPI dependency there is as much about hiding the device on
> irrelevant platforms as anything else, might be better replaced with an
> x86 dependency though.

The whole idea behind ACPI_PTR() (which seems following the of_match_ptr()
implementation) looks premature. Now we have a lot of patches from DT people to
remove of_match_ptr(), i.o.w. make the ID visible even on non-OF platforms.

Having the list of supported IDs is not bad thing anyway as it might help
to google for a device elsewhere, for example.

-- 
With Best Regards,
Andy Shevchenko



