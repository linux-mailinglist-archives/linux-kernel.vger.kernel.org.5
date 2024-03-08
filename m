Return-Path: <linux-kernel+bounces-97201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D214B8766EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8A21C214C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F124A63B8;
	Fri,  8 Mar 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PARWNaS0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E6322A;
	Fri,  8 Mar 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910026; cv=none; b=EuzYJhnxFvm5H/eh2nKk39GlDh3j9Kz+JcfMXgZ2uuhnfM+UKXNHGVkbJJpZtt7g9w+kJm6dGgg2+0+5kJgzIQ0DkkjpKPITuosm8bXJVECgCp5u14f3Y6rQCGQA5leZVmOlru1AcYM4DUNchmLvensF0tU8UBqr3j316Y1w2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910026; c=relaxed/simple;
	bh=BnUs1fzkqy1oP/qNZLXd9NhbFn0nErneJsbGwNTukCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogfdq3X/JxeCRkbAV05m/fG4+fGtgvf3j5e8iTIMnVMEWSvn+ZoY6XDmizlFXQ1R7TAdpO/vYUotc3GmAD5wFFUg4VTrn++A1d2jRG995azogMCaYccWDBLpqkWXaSZ7n9JGnkOOl+gY5ccUuRfCb3L27JzBeMGSnJ/3+G6dNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PARWNaS0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709910024; x=1741446024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BnUs1fzkqy1oP/qNZLXd9NhbFn0nErneJsbGwNTukCI=;
  b=PARWNaS0ialo6joXAIT8uMRm4cJ8CqIVIr9ssJYWp++noIOYOHAL7aUV
   JuJC/0snW0eo0wZSwABtZHYOk+c5MYcUUp028pZ3PMyCbQFaw0WQb4Tba
   HM9UwI+sWH4tEx+eQwc7/LdcfLeoSnnOS6u+/TkfY+80u01cX9snXmO7l
   fGFUfrHTRm/z+zfIzv3OWmoyNeQ//X4jG6WFiJ/YabKHV0xCTQMQC2ZLs
   APM+sgsnkLpnDbYfb+SUvwo412OHEbNONDw8JgXpTWrqamdOzh/b8yTxc
   K4YGI/wLxOJCX23Wf5PgqlXQZN7xr5GDAsZPGkHZ1e9hDqSxr2acRlQ5Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4500205"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4500205"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:00:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914248405"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914248405"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:00:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ribhs-0000000Arsw-057J;
	Fri, 08 Mar 2024 17:00:20 +0200
Date: Fri, 8 Mar 2024 17:00:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/3] spi: xilinx: Add necessary inclusion and forward
 declaration
Message-ID: <ZesoAxvS7y8VCxZT@smile.fi.intel.com>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-3-andriy.shevchenko@linux.intel.com>
 <a3aca544-dc6b-4812-b82e-dd1f9cc04871@amd.com>
 <ZesZKbdIo6z-AfIT@smile.fi.intel.com>
 <d479cda0-3c3f-4cf7-acee-bcacbb9cc5f5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d479cda0-3c3f-4cf7-acee-bcacbb9cc5f5@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 03:02:01PM +0100, Michal Simek wrote:
> On 3/8/24 14:56, Andy Shevchenko wrote:
> > On Fri, Mar 08, 2024 at 09:21:32AM +0100, Michal Simek wrote:
> > > On 3/7/24 16:43, Andy Shevchenko wrote:
> > > > xilinx_spi.h is mnissing inclusion and forward declaration, add them.

..

> > > > diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
> > > >    #define __LINUX_SPI_XILINX_SPI_H
> > > > +#include <linux/types.h>
> > > > +
> > > > +struct spi_board_info;
> > > > +
> > > >    /**
> > > >     * struct xspi_platform_data - Platform data of the Xilinx SPI driver
> > > >     * @num_chipselect:	Number of chip select by the IP.
> > > 
> > > Likely correct but forget how to check it with tools.
> > 
> > I'm not sure which tools we have to check this.
> > 
> > The types.h is needed for uXX
> > The forward declaration for the pointer to the mentioned type.
> > 
> > All this has been derived from reading the file.
> 
> No issue with it. But I am quite sure there was a tool which was able to
> find it out and report it. But forgot which one was it.

You mean iwyu? If so, it needs a lot of tuning before being able to be used
in Linux kernel.

-- 
With Best Regards,
Andy Shevchenko



