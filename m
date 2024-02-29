Return-Path: <linux-kernel+bounces-87282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C70486D226
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B571C21B23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653070AFF;
	Thu, 29 Feb 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jceeR8wy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C687A125;
	Thu, 29 Feb 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231115; cv=none; b=RbPEwk7R/fS6i1sL9h08l3Q9xStclSXZuu5vM4eiHnRfqjGDgVxVEHWmjAVqVkXJcmbYjjI240Jx1pwI3WXixLp2sRvi7mLaLCieFVvPSClRHryemJrLpaF9c4Aw215FcbbDx/KoVXO4TakNALoNnWM8mxPAeAaBN8Wko6j55n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231115; c=relaxed/simple;
	bh=WG/auPH2LiN1tdBcctW2J/dMlONAGBdtn2uJtuc97aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpXK1GigbXArTx5QyzICHq3dwhs/6LFoZ7JlYIN+fIcMKLAf1QxLdgdBOyikGtxAB5kSGKh2KckBYcnLevOcg2lfaJBFmxgyGFIN1RYOBUy6Pm9VSUnwLbq+AHjp7GLROQiL0prxSCVYiRai7XJj7Em7Bw7BGJtocNwspL5lMsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jceeR8wy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709231114; x=1740767114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WG/auPH2LiN1tdBcctW2J/dMlONAGBdtn2uJtuc97aw=;
  b=jceeR8wyBK4XLLDoRY+wgKzloD/pRfl+5DAeO+xvKOdwq2hEDusKw7Kb
   ck+5qRza8dNCuyAVsHul3JyvG3VRfV9I7oTzb/XEqMEJ+dem6H5IAlcF0
   1TUH+re1dA2NPR8w0NokzoJlpzZKbiOt2H4l1jrL53TDeauceRvo0KxKO
   xsgpHXSiJaiSbEaeGDslTzInD7zmZnRV1OyrIJzxNNC09xW3wHaTjMDQV
   i4kQsWseLQxRcH45YjkM1tpF4gkxpSZXZhbJw9L/3C4Wpxr1VZNHt+DeQ
   +nrM7WLP7rG/nkxZV+uKd7vg6Ths4alyTq9SnygglRT9oo9obf+MbZJcT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3898978"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3898978"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:25:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913988804"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913988804"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:25:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfl5f-00000008kDa-3ai1;
	Thu, 29 Feb 2024 20:25:07 +0200
Date: Thu, 29 Feb 2024 20:25:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linus.walleij@linaro.org,
	u.kleine-koenig@pengutronix.de, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: 74x164: Enable output pins after registers are
 reset
Message-ID: <ZeDMA373a7pieSOO@smile.fi.intel.com>
References: <20240229084555.43701-2-arturas.moskvinas@gmail.com>
 <CAMRc=MfTo7MnfMhRQsjeFsLv3yjEtP0C3ytqACN+nuGw0Sr-Bg@mail.gmail.com>
 <15e6e45f-7398-4703-8154-35e769bac94a@gmail.com>
 <CAMRc=Mf__-sbAV0xuC2hsxm_-kQWqgxSLRYLKqt9-ce+8_Kf_w@mail.gmail.com>
 <f9e90eb2-60e5-4ae8-9f3f-92922294e981@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9e90eb2-60e5-4ae8-9f3f-92922294e981@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 07:24:09PM +0200, Arturas Moskvinas wrote:
> On 2/29/24 15:25, Bartosz Golaszewski wrote:
> > On Thu, Feb 29, 2024 at 1:23 PM Arturas Moskvinas
> > <arturas.moskvinas@gmail.com>  wrote:
> > > Chip outputs are enabled[1] before actual reset is performed[2] which might
> > > cause pin output value to flip flop if previous pin value was set to 1
> > > in chip.
> > > Fix that behavior by making sure chip is fully reset before all outputs are
> > > enabled.
> > > 
> > > Bartosz, does this look better?
> > ... if previous pin value was set to 1 period
> Andriy, Bartosz, is commit message ok?

LGTM! Please, send a v3 with it.

-- 
With Best Regards,
Andy Shevchenko



