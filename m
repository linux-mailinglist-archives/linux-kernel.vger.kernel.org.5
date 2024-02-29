Return-Path: <linux-kernel+bounces-86915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581A386CCBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D63284E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A5813EFF6;
	Thu, 29 Feb 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOQWrQkU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB086275;
	Thu, 29 Feb 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220070; cv=none; b=E7c3/N140WQh7eKsUZ2CrbG60BHruom+LnAx8cRi83SBBcgrwy0r6XajdVBQyCoGwIbABt07T6TEmGlOEC2enGvFLVq7w1hRV5lYHSx8htBUyYoeddm4Lbrlqt6Alt0izesxE3TcQNxZAgNIOfCwm1VSqI/01GACcBQI4GNi/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220070; c=relaxed/simple;
	bh=mtw1Are5X4Bl/MyGWxpW8u5oJvyM4o2l4h/oPvehucM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjXZ1i6o7GVH3/+Z5yLbMX/70yFN4E54bb6fRTsQSwhECNOT5PTJPhbO39IeN1auHwUxcfwDJJeKn8dQpNC12YQZi9KAFStuEldRGXUqBEAWhzILh/4cu2pTBD6XywMZkOp0LW+vJRWijg/5J+0pDZrgIZOKUncE1Bhhk1ATyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOQWrQkU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709220068; x=1740756068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mtw1Are5X4Bl/MyGWxpW8u5oJvyM4o2l4h/oPvehucM=;
  b=AOQWrQkUmDn2qo6scC606kMUiVfLcFkcnLj+VdBd2J3qQ07WEMWbpVJ6
   +SIhy5QeiFIIrTO2umDPe6HBvcewBgyvcwFfTcxBF4FObl2nYCYYlKtcU
   O/cmgDRA56ZkZxCr3fJsp8cMc6r7mJpoNYZFx9g1/8mZRsqNglscIXPYp
   gt/hOLHhxIxGZ9hCh0LmjbtHS85SkRp+2OQFQObHfUc3TKk7r5zQrMcmu
   YLBoNZkErhSPwHBut8ziEvv3pLpbHb5z2q96J7XlNk1GMHWUL3+iEDXws
   Ku5fE09bKsn0H7eV+mDk5cmMnXYZCYRmwXySgykOz3snKHLjAQSDiOvZK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3574679"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3574679"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913984387"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913984387"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:21:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfiDT-00000008hgQ-3rit;
	Thu, 29 Feb 2024 17:20:59 +0200
Date: Thu, 29 Feb 2024 17:20:59 +0200
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
Subject: Re: [PATCH v5 4/5] net: wan: fsl_qmc_hdlc: Add runtime timeslots
 changes support
Message-ID: <ZeCg24Iv8qDmxNV9@smile.fi.intel.com>
References: <20240229141554.836867-1-herve.codina@bootlin.com>
 <20240229141554.836867-5-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229141554.836867-5-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 03:15:52PM +0100, Herve Codina wrote:
> QMC channels support runtime timeslots changes but nothing is done at
> the QMC HDLC driver to handle these changes.
> 
> Use existing IFACE ioctl in order to configure the timeslots to use.

..

> +	bitmap_scatter(ts_mask, map, ts_mask_avail, 64);

Wondering if we may have returned value more useful and hence having something like

	n = bitmap_scatter(...);

> +	if (bitmap_weight(ts_mask, 64) != bitmap_weight(map, 64)) {

	if (n != ...) {

?

> +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots %64pb -> (%64pb, %64pb)\n",
> +			map, ts_mask_avail, ts_mask);
> +		return -EINVAL;
> +	}

..

> +	bitmap_gather(map, ts_mask, ts_mask_avail, 64);
> +
> +	if (bitmap_weight(ts_mask, 64) != bitmap_weight(map, 64)) {
> +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots (%64pb, %64pb) -> %64pb\n",
> +			ts_mask_avail, ts_mask, map);
> +		return -EINVAL;
> +	}

Ditto.

-- 
With Best Regards,
Andy Shevchenko



