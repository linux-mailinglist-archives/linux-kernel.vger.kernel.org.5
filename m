Return-Path: <linux-kernel+bounces-58431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDFE84E674
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4256F2880C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CADE80C05;
	Thu,  8 Feb 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jz2kKRJp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA17B3C2;
	Thu,  8 Feb 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412540; cv=none; b=WssO38IZlcoLhmN8UGWEXYM/plDFJusCzGFhQZuopDl251ctdDZH1R6qeNamTUwuWS1MS5mW/uqtBIrDT3KtMsf1DGryuV6/OCNqRtnHm7VElIWxS0+gzHDSIWmdRdzSqZWEl3sCH+ofDaXgRaat4GLZjvpsr2YACkccqiAE4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412540; c=relaxed/simple;
	bh=p76xqtocPXxIASp/RvwQN97YAIQh0QlwZC10TmxGnq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7E4fT68Ay9gcHD4F4tm9o16fdPG5xcNwKapfrQZJnFN2L9mSiOjElSJekdXX7Io9xDsR+fhrDT1xtHYlPE2uZXENADmtFHNUpTwWqvruFn5xR/z1MBR7ofwJofBnw+5EAq9laxc7GW9aFnKo4+kOkQ9L/4ql6IPRO+HUCsxVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jz2kKRJp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412540; x=1738948540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p76xqtocPXxIASp/RvwQN97YAIQh0QlwZC10TmxGnq0=;
  b=jz2kKRJpJZRqmgKHolbk+geF9tcOM5CkaAyv1Is2zCoeOKzu3X/6JX2f
   dB7+I/zHv/4fC74iGlbGY+GyQXa7yEPCVsCdoEQY+/DeH6qb49na2oJ4F
   hTzGd4LDZogVBWiVMzyXhX8cWOdStJVl2ZdtFvvEAM+3y+j9usu41f3Q/
   MYy9sTo5aEG9CFV9WV1B30ON+424STbuixiLraMCfnGnRHUwcXELQXyU8
   aZpkkaNBisOt7SjZAdfmSzlHTnILm0Pbr4eAUikeR0Oz4jTsLWle7Z5e5
   BU6xUMC3bOHJSHS0mIU50CyjxrOiCmFhysvgA0Zkji/B/Ts35BI0wo0TX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11841737"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11841737"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:15:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910429976"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910429976"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:15:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY7zn-00000002vyu-3v1g;
	Thu, 08 Feb 2024 19:15:31 +0200
Date: Thu, 8 Feb 2024 19:15:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
 platforms
Message-ID: <ZcUMMyV_vBTNw8Rz@smile.fi.intel.com>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
 <20240208113425.GK689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208113425.GK689448@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 11:34:25AM +0000, Lee Jones wrote:
> On Thu, 01 Feb 2024, Andy Shevchenko wrote:

..

> >   backlight: mp3309c: Utilise temporary variable for struct device

(1)

> Set no longer applies.  Please rebase, thanks.

I got a contradictory messages:
1) email that says that all had been applied;
2) this email (that tells the complete opposite);
3) the repository where the first two were applied.

While you can amend your scripts, I think I need to rebase only the last patch
(1) that may not be found in your tree currently.

-- 
With Best Regards,
Andy Shevchenko



