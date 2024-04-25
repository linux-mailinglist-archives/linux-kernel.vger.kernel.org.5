Return-Path: <linux-kernel+bounces-158333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697A98B1E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318AC289354
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797FF8529B;
	Thu, 25 Apr 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Joh2gjQi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1A06AFB6;
	Thu, 25 Apr 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038694; cv=none; b=nrdqei+j30O4jv/2xNBWoTInAFKImijSqvbbqsf8LBQE8FxTMsMfHye2uAeK+iGx8DQ91R05FtVI17FRYgJr6TTpsMmGcWiMf6L9slJEUpNIDE0eYZ2ZkObnv8CADVqx3ibfpA6/Hggm885Nvh00i0dhw/fgYIJc/81/2HQ/NHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038694; c=relaxed/simple;
	bh=ZtrikWN1khsLOYBb47MFnWoLnhVQt3gs3zS1wmjQmRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9pwD2hLEUyLqBriwjKJsK5M5E03zXImmsMBwxqcdJ1llpR+CfB6Xcji7g7Rv/qEeBkTp81eZgoXz2zqKnb+w5x8NvoeRTrPqIjefXxB6Dygn4jvaDgjLHxWTDUq1jQxdRPDANioledaFv2PNZPgsagajQ3HQD8waGX8rcuHrnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Joh2gjQi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714038693; x=1745574693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZtrikWN1khsLOYBb47MFnWoLnhVQt3gs3zS1wmjQmRs=;
  b=Joh2gjQi6j0ptyDmk/3U/OpSY7Cj3oEKUqtQ5lM1atO7UF13mt3Rpk3b
   QEuAY+RjBNQ1usRBmJI3CYkfurXWVr04dDUkF394yHmuGT2jTqjSmkYIO
   /7NyW7CNEJykT0r14FRXtxmnLIoiNuGWXSZaVI0DZ0pmPpqoQz4t7TC9k
   68GlKiW5v5eoifHHVXusZEoeXIwikxLim02nniXEd3IijPd01MnKdwsY3
   k7NGnI8r6QAo3rOuBvKnlbRw29GXmDtR+vPVSLyRvSEG3uSsPuMDJThmh
   eOOctSHBpxC+tfrdBRWtOqXS2N0rwZH0/CVAz9BP8xAzXzC/2lAmlGR2q
   A==;
X-CSE-ConnectionGUID: dZPfilrQSAGVVk8kDw6NNA==
X-CSE-MsgGUID: mavx0dwAS5uPPwoCzsGaPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9583073"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9583073"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:51:32 -0700
X-CSE-ConnectionGUID: JeKzxkwjQ3yliVGE8lqt6g==
X-CSE-MsgGUID: +cKS2glkRbC+ZB78m4Npfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25640282"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:51:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzvlF-00000000x8n-2GLl;
	Thu, 25 Apr 2024 12:51:25 +0300
Date: Thu, 25 Apr 2024 12:51:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com,
	l.sanfilippo@kunbus.com, tglx@linutronix.de,
	geert+renesas@glider.be, ulf.hansson@linaro.org, peng.fan@nxp.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFT PATCH v2] serial: core: Call device_set_awake_path() for
 console port
Message-ID: <Zionncg1uUAb9BDP@smile.fi.intel.com>
References: <20240425070936.547100-1-claudiu.beznea.uj@bp.renesas.com>
 <ZionWJ7ods60zuYX@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZionWJ7ods60zuYX@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 12:50:16PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 25, 2024 at 10:09:36AM +0300, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

..

> > [1] https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pmdomain/renesas/rmobile-sysc.c#L116
> > [2] https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pmdomain/imx/scu-pd.c#L357
> 
> No need to have the HTTP links into the kernel sources, you may simply refer to
> the files in the source tree.
> 
> [1] drivers/pmdomain/renesas/rmobile-sysc.c:L116
> [2] drivers/pmdomain/imx/scu-pd.c:L357

Should be without 'L' to follow the `git grep -n` output format.

-- 
With Best Regards,
Andy Shevchenko



