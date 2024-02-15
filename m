Return-Path: <linux-kernel+bounces-67584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E40856DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2133A1C21918
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527C13959E;
	Thu, 15 Feb 2024 19:31:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796C1386AE;
	Thu, 15 Feb 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025519; cv=none; b=E06TDUG/bst5tDXtpXBN2Mfn8v0tLExUHPfIZ7QuRItUUfzmaIB1cSQ65K6f7b8bfKwPrdgAQx3fe62kbPNuutPtgi7IjAoDJPec7aVMst1guYg5cRXzD+u4vW61DExwlmYXP3vYsLbY8MU5y41Fy96vR9rhMYf3WANk4XhNNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025519; c=relaxed/simple;
	bh=MnSo1q8rMmJ6PMGoNVyO+jWjy3+KYCta88vMYLLozKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCHvVcQ0aqsY36hEoCgxkFI94KtnEc91xfL5pjbvYcoYyFQ7PreZ8N7cG9OsfuRbAxouEcw21+HwkFM8mguBWecBBNz79mkxKxY2JIeImBbpWX2qKBojikMGBC+djeJLrHcADzf8fr+wCuURy+OUPoHUMEP/4jJHtf0fxxT6DUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5947579"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5947579"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:31:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912217335"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912217335"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:31:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rahSb-00000004sHo-0ZsV;
	Thu, 15 Feb 2024 21:31:53 +0200
Date: Thu, 15 Feb 2024 21:31:52 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: dw: Add a number of native CS auto-detection
Message-ID: <Zc5mqLS34XIEo36F@smile.fi.intel.com>
References: <20240215180102.13887-1-fancer.lancer@gmail.com>
 <20240215180102.13887-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215180102.13887-3-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 09:00:47PM +0300, Serge Semin wrote:
> Aside with the FIFO depth and DFS field size it's possible to auto-detect
> a number of native chip-select synthesized in the DW APB/AHB SSI IP-core.
> It can be done just by writing ones to the SER register. The number of
> writable flags in the register is limited by the SSI_NUM_SLAVES IP-core
> synthesize parameter. All the upper flags are read-only and wired to zero.
> Based on that let's add the number of native CS auto-detection procedure
> so the low-level platform drivers wouldn't need to manually set it up
> unless it's required to set a constraint due to platform-specific reasons
> (for instance, due to a hardware bug).

..

> +	/*
> +	 * Try to detect the number of native chip-selects if the platform
> +	 * driver didn't set it up. There can be up to 16 lines configured.
> +	 */
> +	if (!dws->num_cs) {
> +		u32 ser;
> +
> +		dw_writel(dws, DW_SPI_SER, 0xffff);

GENMASK() ?

> +		ser = dw_readl(dws, DW_SPI_SER);
> +		dw_writel(dws, DW_SPI_SER, 0);

Would it actually change the physical line state? If so, we may not do this.

> +		dws->num_cs = hweight16(ser);

Why 16 and not u16 & dw_writew()/readw()?

> +	}

I'm wondering why this can't be the default

	num_cs = ...autodetected...
	device_property_read(..., &num_cs);

-- 
With Best Regards,
Andy Shevchenko



