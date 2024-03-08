Return-Path: <linux-kernel+bounces-97120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1238A8765C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381091C21822
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2B3BBEC;
	Fri,  8 Mar 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BV0Ub539"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8E3FB80;
	Fri,  8 Mar 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906231; cv=none; b=u7Fw/EwTKqeB5UPFJorS1D3lzVSJX9h29PGuwIPoytzPd04MMGMqlJfFin36UhIa87Ni0lK7kXA3TUj0RtvUmpEZKz2VEsxnwvp2AK8LtFxgmLfLjD97ixEaoi1zR+VYZtzzP7yd+Ks8jfIKi0jLIwWavPM+rRLZsRiX62kDhs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906231; c=relaxed/simple;
	bh=SuY5egYOzjPLsITo+2ZsFaeeMcoN0sKe3znQfgvoQbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvtQzAkBNncb806x5VJ+OYyqCeZ7jMQelSndfUK0dat6Boji2/dHn8dHw6ZIlbB89HUCA9StmmJvdvak7pJ0QQlVSVzjMo7sVlMMREdLH2jLcZcPVeiplopk+KT84zu7FkXtj2aM4UfWqH0biPsKZ4tUdSQQCb3sgkcie6OXrRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BV0Ub539; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709906229; x=1741442229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SuY5egYOzjPLsITo+2ZsFaeeMcoN0sKe3znQfgvoQbc=;
  b=BV0Ub539ZHfPJqxNsSIngWMgxRPmUlxL+TnCo0YozwugPsR282EGEFlE
   7AXVIruj4sJ6Y4NWkt+voNRJGHX5vUinZfj3e8o2NWeIljyLz9jSYd3BQ
   FQ66QSvHIIPkaDiiRwV+plG45xE4ekDL+TjxJrssJxuMpbBSkUKtoGfQy
   sM0lns7UJcyv1IvF2uf/EMShBnyiwum0wTh/OpJZpgJf/gD4O1DNdFdIH
   zmXkUlTfilpGPY2xnyfrkhJWYp+Z9cqJs0nQwJ6v+iodqGbTXt1Fl2b80
   AO5UpKS9yhMhccLxv+9Kv5uPb/jTtjrWX9gdr23mu5HvMy2ArHmZGKmA1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4495267"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4495267"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:57:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914247276"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914247276"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:57:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riaiX-0000000Ar5c-3lGP;
	Fri, 08 Mar 2024 15:56:57 +0200
Date: Fri, 8 Mar 2024 15:56:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/3] spi: xilinx: Add necessary inclusion and forward
 declaration
Message-ID: <ZesZKbdIo6z-AfIT@smile.fi.intel.com>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-3-andriy.shevchenko@linux.intel.com>
 <a3aca544-dc6b-4812-b82e-dd1f9cc04871@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3aca544-dc6b-4812-b82e-dd1f9cc04871@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 09:21:32AM +0100, Michal Simek wrote:
> On 3/7/24 16:43, Andy Shevchenko wrote:
> > xilinx_spi.h is mnissing inclusion and forward declaration, add them.

..

> > diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
> >   #define __LINUX_SPI_XILINX_SPI_H
> > +#include <linux/types.h>
> > +
> > +struct spi_board_info;
> > +
> >   /**
> >    * struct xspi_platform_data - Platform data of the Xilinx SPI driver
> >    * @num_chipselect:	Number of chip select by the IP.
> 
> Likely correct but forget how to check it with tools.

I'm not sure which tools we have to check this.

The types.h is needed for uXX
The forward declaration for the pointer to the mentioned type.

All this has been derived from reading the file.

-- 
With Best Regards,
Andy Shevchenko



