Return-Path: <linux-kernel+bounces-61541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36FF85137C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1AB283EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF839FD7;
	Mon, 12 Feb 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLijL2Df"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE41864C;
	Mon, 12 Feb 2024 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740586; cv=none; b=B39AQCVkFdfx4bSyn8t3sD16KgJheidVItS7ela7VogpzI0n8dUwsyq8upJe64MiUJ7yfgY3PZxHiK6jxJlpVU6D0EeFSuN9ni3zhF0SDNgamOQPO2dAYA1ACBmNpDut79QR7/Pysk6z61pFiGvsgEaijU+Sc+wh6yg4ZMPy8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740586; c=relaxed/simple;
	bh=6pomjPZGL7vlncXPUaxh6XTFSH56FoFdulJV9sKaXDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWtNZpDBlnTtV5B7cv1HONt1RPdlB314yG3SjLoTMUjmzmS+TLr8Y4CLPtPrR1J7jKDM8fLTwYyjejmkC9WNd46477gMTP2KiZgaeMxG48P3uPgCfqmrhcgAwkMfpApUf92nFodp5AXenC/X/H5qvDWdyereNNXpMzPIqRd9iDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLijL2Df; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707740585; x=1739276585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6pomjPZGL7vlncXPUaxh6XTFSH56FoFdulJV9sKaXDQ=;
  b=MLijL2Df3q3yaFKIMh8DpAm2p99SzLxguhalgDBSUGLTcUqhzxteLeWP
   COw7kwZkMLTzHuKogzgy92zqK6KtPFgDBmexw1yxHq8qOFQNvqTmswGuO
   MzJPxFzfzEUGxdab2bEf0/xEz7/jA/SuJZtCPZgWLvNr4zDFEerOiR7JB
   SIH7MHd6OY138yh8kmrXuwLi2FfDz87hkZ8Z/d0uumjQDJ1vyA0xLSn2A
   ZqFuU01Y0QLFO81Q6nxEP0iVLAhrNzePTsB7bXzvsNo4G0eR3owKFcvnx
   ptFzIbj4oh667a7kvxjHcndLBqwwAkxepjsX5/pZ0PvSEvIEBT1syF67r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1591672"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1591672"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911467880"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911467880"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:23:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZVKr-00000003tHa-1I5A;
	Mon, 12 Feb 2024 14:22:57 +0200
Date: Mon, 12 Feb 2024 14:22:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 RESEND 1/6] net: wan: Add support for QMC HDLC
Message-ID: <ZcoNoDRF6h2C7TQd@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
 <20240212075646.19114-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212075646.19114-2-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 08:56:29AM +0100, Herve Codina wrote:
> The QMC HDLC driver provides support for HDLC using the QMC (QUICC
> Multichannel Controller) to transfer the HDLC data.

..

> +#include <linux/dma-mapping.h>
> +#include <linux/hdlc.h>
> +#include <linux/module.h>

> +#include <linux/of.h>
> +#include <linux/of_platform.h>

I do not see how these are being used, am I right?
What's is missing OTOH is the mod_devicetable.h.

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

+ Blank line?

> +#include <soc/fsl/qe/qmc.h>

-- 
With Best Regards,
Andy Shevchenko



