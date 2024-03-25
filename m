Return-Path: <linux-kernel+bounces-116740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E59488A32F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354981F3CD24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212C145336;
	Mon, 25 Mar 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kp8pD+1Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEAB1EB2A;
	Mon, 25 Mar 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358595; cv=none; b=LZNuvjoUVpQksM2IUDFNgh1ANmRd/ir+i1a6VQ1KTpxHrq/1oLG43X5yfrAn7I4txRQ+t5mluB/kIfYLzJ4OOaGBagcIkJ1YtbalUPYLUQc+3AR/uUFyg6noyUUEjNgzNQn0tvXBr3I2sg7JmXh+30dgCq1ywF/MVpM7zcVTEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358595; c=relaxed/simple;
	bh=+Rntwbb4YW9HjwZqjkH2HwaBZOT1e6Wg4co+NigZDyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4aYrSy4js/LbnrDM+YX414UpM9QoWrJTac/K8BFjlbo9LwVsOu+BxHRRcB1hTsdqurnNL+vX1DOo8rpFwjad+jpGyKOdkani4ggupYAfeBkAls4P9CdsMcsR1aHTMpnXRkbcxJvltSjxKfJmJKpinm24pfeswbYWX9OXD+yJyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kp8pD+1Q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711358594; x=1742894594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Rntwbb4YW9HjwZqjkH2HwaBZOT1e6Wg4co+NigZDyo=;
  b=Kp8pD+1QQVc0bxOc72i6QGVpMyLh0TmLJxawJlcCptezf77RdMbY3DBy
   6WVLHwKt4X3t11e+wJHm7b3jdtplysF3rF32oCGla3JwA3hcg9jTQWB7g
   J/2csaferj9H+KDHhRwDqk4H56toy2tapXjTrhCMM6yvSi2FuyU7ogrcs
   NVZ8wirrJ4cTld/bPTAMUBheZS851J26K0gNz1OnF5fTpFvXk4pXoV6hZ
   BQo03AFMVPcbz4ipAOKtI7gJLKL+eElgdbskTo52eG+gFvDnc5Plt7lTt
   Wy4oun4vDQXDe9P95JgAFnl8sJztKTZoUeRX2nCd87I5XBhy6vAgUrM6V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6533060"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6533060"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 02:23:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914837483"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="914837483"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 02:23:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rogXr-0000000Fvfn-1Ds7;
	Mon, 25 Mar 2024 11:23:07 +0200
Date: Mon, 25 Mar 2024 11:23:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] net: wan: framer: Add missing static inline qualifiers
Message-ID: <ZgFCe39GJEARc9g4@smile.fi.intel.com>
References: <20240325082505.29385-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325082505.29385-1-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 09:25:05AM +0100, Herve Codina wrote:
> Compilation with CONFIG_GENERIC_FRAMER disabled lead to the following
> warnings:
>   framer.h:184:16: warning: no previous prototype for function 'framer_get' [-Wmissing-prototypes]
>   184 | struct framer *framer_get(struct device *dev, const char *con_id)
>   framer.h:184:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   184 | struct framer *framer_get(struct device *dev, const char *con_id)
>   framer.h:189:6: warning: no previous prototype for function 'framer_put' [-Wmissing-prototypes]
>   189 | void framer_put(struct device *dev, struct framer *framer)
>   framer.h:189:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   189 | void framer_put(struct device *dev, struct framer *framer)

Always try to minimize the warnings/backtraces/etc to the point. In this case
it's enough to have:

  warning: no previous prototype for function 'framer_get' [-Wmissing-prototypes]
  warning: no previous prototype for function 'framer_put' [-Wmissing-prototypes]

> Add missing 'static inline' qualifiers for these functions.

Code wise looks good,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



