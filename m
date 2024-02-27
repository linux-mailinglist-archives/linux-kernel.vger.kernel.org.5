Return-Path: <linux-kernel+bounces-83437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C44E86993A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD3E1C216E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3662C1420D2;
	Tue, 27 Feb 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQtFXRPr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065114534D;
	Tue, 27 Feb 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045730; cv=none; b=MpdxyW6bn8gx/dRstWYBW3uf3pwRZnjSh1l+FcqoG5mdMODn6WPld/vHjNNMSbT0IYasZXsSDy3NdM0kmHudggblfmpwG98HlQKVKraZHkAOxGI5smj2O6p4hl8xB3GPyCCxzDjOipAkBDxAHQkgFCSShidtfPdqU6Se5TIuqew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045730; c=relaxed/simple;
	bh=1tJ/As6WZY8z7QkR0Ar4Lvs7/0YUFMld1vGtVN0TiGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7UtZNdYB/VM4MY82aACEpw5RTq7Ij/tnuWDQGhvtIlPb8wuPoWNU/ruPqZDdNp5UUgwAR37rHHiMAYuv2LheagqZFsclrKcQ0V2OhW3QhroqRzf+Sjae2/TNqEEe0dwKv8T30HPvGrO6jACykoCeMqSMCELHDDW5aF5TuQyxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQtFXRPr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709045729; x=1740581729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1tJ/As6WZY8z7QkR0Ar4Lvs7/0YUFMld1vGtVN0TiGc=;
  b=fQtFXRPrI0u2Bt0y3L46jYtojEE2B0hYV9ZQygjS03oFmCtcecu3eiq2
   D1Vu58pj/w4XKvFyT3cD0RLZgV4efQE6Fd6V/HxNNrBXY5UJI/EuP6m84
   RnFhScHYS6vuAYPKkPuJw4Ox09Q0pDMPZ7MbizdxGBk8bZ4Ax9bLDBVwL
   5RVgOM+sl4d5+MsppDqXx0fqayWqbSNpp1OZ23rdNSl4OejNCR2wwEPQt
   x0jMYBhmWKl4pOoprV86dxePMY8PpfgZ+glJLvE9ABM18b3DLIOSpOuHL
   Zhw7eAHOfZlFPtKIMKHtXnEd3B+RGA6eG1kLz5pEwUJHpI2uKqoIjog18
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14537570"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14537570"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913914289"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="913914289"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:55:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1reyrW-00000007yFU-0wjj;
	Tue, 27 Feb 2024 16:55:18 +0200
Date: Tue, 27 Feb 2024 16:55:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v2 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
Message-ID: <Zd331VOwxzU5YUCO@smile.fi.intel.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
 <20240226142514.1485246-11-andriy.shevchenko@linux.intel.com>
 <caa79772-6a54-48fd-ada2-5e7647b597ba@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa79772-6a54-48fd-ada2-5e7647b597ba@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 10:24:30AM -0800, Florian Fainelli wrote:
> On 2/26/24 06:19, Andy Shevchenko wrote:
> > Since we have now a common helper to read port properties
> > use it instead of sparse home grown solution.
> > 
> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thank you for testing!

-- 
With Best Regards,
Andy Shevchenko



