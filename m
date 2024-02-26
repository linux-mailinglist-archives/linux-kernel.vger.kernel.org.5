Return-Path: <linux-kernel+bounces-81553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7086776F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3ADC1F2B5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0437129A6A;
	Mon, 26 Feb 2024 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWvl7R0w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560061292EE;
	Mon, 26 Feb 2024 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956071; cv=none; b=Q311BOpG6z7vXUnlnhGKsF3EtytmNl9wXMyr9xpCnWfAieJd0dUxiSn6omNH1u8iWSohXMY0wK5nRsEOuiFtR9EDcoNFfsrHSUlEbJ4jULQI11cQGJMth0c++cAcqAkJcO4P7WqniZ0CPwZG1rphtzsTPqCljSR3Lw2XvPHgL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956071; c=relaxed/simple;
	bh=zmzcQJz2EU0rskFy7vCYo51U8a1+VZhLaYJLp6NSbKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK19xddEBNqYojxCHsj2jZTrw+HHrrYn1qCCXBrDmqrVX5GHdXLAIYMyKAnH2dDYwy3gP/5y76tdGwFTCyRDUqDCNIhS5qKY91uFXpvzqQ7SxLsvUgFqmpJir19khFUWL0v/f9Lz7bpoRxbvAXiXqWxxcMLuOpfJbvWFQPMDZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWvl7R0w; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708956069; x=1740492069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zmzcQJz2EU0rskFy7vCYo51U8a1+VZhLaYJLp6NSbKs=;
  b=SWvl7R0wz9mnfSqiHfmxH+CqNoCm7Ei87e2NnNGkbCPuCtWYzss5meGG
   3S706k+gMah3IW1BQJCM6pW/jYzD17KMbXGLQ7ayi+EyxjkTWQZD0mtFO
   5+gNOvn00+g+VSUghvKZBE0/BDAP3diudgzXVbBMzIVOkOiAJslD6h76c
   TtJvT74pBHLdcJ0Ity/voaywCdyVNGXGRGE7bZ1ANqCoRk9Zw/jlcVX/q
   iZtCXZ2yXDCl9V/oxGReuZcb7Xw5gpLwXMrgwYL6sVrV2GU6x66lh/sR7
   vmlAJ+r/SmuDglIXs7sj9ciYBFwpdyESMXhLeDYpzcPRM9Q12/BPpzxkm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6186627"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6186627"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913871289"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913871289"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:01:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rebXS-00000007hE8-1U8V;
	Mon, 26 Feb 2024 16:01:02 +0200
Date: Mon, 26 Feb 2024 16:01:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: fabio.estevam@nxp.com, linus.walleij@linaro.org, brgl@bgdev.pl,
	u.kleine-koenig@pengutronix.de, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: 74x164: Enable output pins after registers are
 reset
Message-ID: <ZdyZnqS_jKelbs6G@smile.fi.intel.com>
References: <20240226134656.608559-1-arturas.moskvinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226134656.608559-1-arturas.moskvinas@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 03:46:56PM +0200, Arturas Moskvinas wrote:
> Move output enabling after chip registers are cleared.

Does this fix anything? If so, maybe elaborate a bit the potential behavioural
changes on the real lines.

-- 
With Best Regards,
Andy Shevchenko



