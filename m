Return-Path: <linux-kernel+bounces-78562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E406E861510
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B0C1F23DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E0621364;
	Fri, 23 Feb 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfQQQc40"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051138BE7;
	Fri, 23 Feb 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700566; cv=none; b=ppwXRWI5YYhqCj6wPgA8vsCgKuez96Rrr12ENFzseceSlCCw2tOy8rppQNdZBYrCnny9/Qa1mnR3ddKZH/PqzD3B5Az7nDBilQsHI/c2ghUGf/NaAn4aI7JoVqfrlE3NfN20wYEfd3G/h9IHLS9siA5YYBsgeJ8o/zwsZS3Q5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700566; c=relaxed/simple;
	bh=FLcUOtGk9O9iSiLBqxraYsFBaH+S3qMsBm4QVDsOq3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhKdvoETIvFijFDDzF/xRgf/T0Y/4Jd1dpH6B4+S8HdWb4cLymE0KNoI8hVEEPTCQRINL/OEYd60K+V2RSro+/2ftCn3mcplMSTtgiWTTM3HYwKu0pRZJnKRMf6KgloYAgFi2e9TdlesxhpjCsDRW2bQCk0XAfx2Cd3IUL5JTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfQQQc40; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708700565; x=1740236565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FLcUOtGk9O9iSiLBqxraYsFBaH+S3qMsBm4QVDsOq3E=;
  b=SfQQQc400sJWeb+1vGnLtS2hdmas89tlD7fpO8VwNEBcy7XgaOKRK4Wi
   bVVd5+BfDQ+vLn5MPK1pLmoTsjUK6Mc3K8l/npoeWfX1wr3RwjgFKWYuz
   LKaz2q28zy8Wdlm14jBzVYJ8JA10CswyHyGGFQboemCz0iRfWvyPYobel
   35A+VWFY6PYwJSD5onGVnDTapLB6l2yEPQ3V21RmQBJNIIPxig6nBEY9A
   cJgPAyOB2G4omyUfqh6ExCGA9pnMqrTpYpgZpXnG1q77a6HQgsENMiaT8
   F7qHZKLQNl2U9YqEa+EBmgxJfSu2W0GmzxaceCaueKhX3HEbQI/ndJa6P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6833564"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6833564"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:01:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913748372"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913748372"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:01:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdX3Y-00000006vfp-0F1g;
	Fri, 23 Feb 2024 17:01:44 +0200
Date: Fri, 23 Feb 2024 17:01:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v1 06/14] serial: 8250_bcm7271: Switch to use
 uart_read_port_properties()
Message-ID: <ZdizV7sbAtCZ4AyO@smile.fi.intel.com>
References: <20240221183442.4124354-7-andriy.shevchenko@linux.intel.com>
 <202402231238.AWqLyIoM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402231238.AWqLyIoM-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 12:14:38PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build warnings:

> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402231238.AWqLyIoM-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 

>    In file included from arch/hexagon/include/asm/io.h:328:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      547 |         val = __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^

Okay, the above is well known issue with hexagon arch, not related to the series.

> >> drivers/tty/serial/8250/8250_bcm7271.c:938:22: warning: unused variable 'np' [-Wunused-variable]
>      938 |         struct device_node *np = pdev->dev.of_node;
>          |                             ^~

This one is a good catch! Will be fixed in a new version.

-- 
With Best Regards,
Andy Shevchenko



