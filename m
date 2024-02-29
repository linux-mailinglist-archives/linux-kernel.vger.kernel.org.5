Return-Path: <linux-kernel+bounces-86955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC9986CD84
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF84287822
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F45153BF5;
	Thu, 29 Feb 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0YaKCf7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46EB152E09;
	Thu, 29 Feb 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221746; cv=none; b=BtsbustdgHLkTg/AA1qldEGEa6LkNjD+D0WsQ/nPRHAQcK5kqw61jckZyjIoty4wEP+PEvm1Vm+xPGyuMJ1iV2iEjQCSCQ8cHYkq/HwH+aXntBbVGGgXy310sRrLl+VmQufijQE7M4vQZWPOTJs+QT6gMzE1cXjyVABld1c6KPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221746; c=relaxed/simple;
	bh=B6z1QKOE3x2nI2mPVwteO/iiaGfW/JzMEnxrnKdy4d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+4OuZFFPU7x/Esye2ldUFy0f0zTquviW86CHh8rXsqnOGZmgF4RSpieRM1VcXyZCg56TV3LfDQXc2/iVLXVF/UYre7CDIiqztS4/gLKEAwVHPioaOxU1qJFzdDxVvKsdSHQo305U1HQ+w7e+xFUI0QZq+iLaAPJjSipOiZgskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0YaKCf7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709221745; x=1740757745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B6z1QKOE3x2nI2mPVwteO/iiaGfW/JzMEnxrnKdy4d8=;
  b=M0YaKCf7wrEqGNkQvVmKkRt3w9EowrK9ik4NW3nMRmt+3RVUikYrGZwh
   kS2RBzqeq4yp3OcQdep1dgOXpBARDFhHMxFFFJ2r+n+OHR0Ss6XX79yDU
   g5Mb2VJVO8wIQGIu1tUBkDTMoYMk6FgpEZZv7iwoYOp/f6rcc/MjIVBw4
   JdOaEvRoTYv2wARdFyr4YccclwSTXx755AO6Ww7jls0P5jCpsIx6AWiwi
   KRPkn1GP4Rf+rARbyUdmZVawOJcqOxh3byFCcPkuNnBDB+aaznGgXj5cv
   HEWjNnYCnGfDDZXHCDfUSiQjKYeYSd79n9nYYzki22Tl/HgIWJF4lmZDe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3554474"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3554474"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913985020"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913985020"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:48:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfieV-00000008i4q-1m6A;
	Thu, 29 Feb 2024 17:48:55 +0200
Date: Thu, 29 Feb 2024 17:48:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v8 03/10] clk: eyeq5: add platform driver, and init
 routine at of_clk_init()
Message-ID: <ZeCnZ0Py62EyKI9Z@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-3-c57fbda7664a@bootlin.com>
 <Zd4X3NnBoEl0wu2H@smile.fi.intel.com>
 <CZGSB2O8P572.28HK6WFT43N6S@bootlin.com>
 <ZeBnX2upNRN0xXH4@smile.fi.intel.com>
 <CZHMSNWMH4KJ.2J6ZMWKMSZYH2@bootlin.com>
 <ZeCbvgWY6x1o17Kq@smile.fi.intel.com>
 <CZHOCV35A23S.14HL07U73EH6X@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZHOCV35A23S.14HL07U73EH6X@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 04:40:25PM +0100, Théo Lebrun wrote:
> On Thu Feb 29, 2024 at 3:59 PM CET, Andy Shevchenko wrote:
> > On Thu, Feb 29, 2024 at 03:27:01PM +0100, Théo Lebrun wrote:
> > > On Wed, Feb 28, 2024 at 03:33:29PM +0100, Théo Lebrun wrote:
> > > > On Tue Feb 27, 2024 at 6:11 PM CET, Andy Shevchenko wrote:
> > > > > On Tue, Feb 27, 2024 at 03:55:24PM +0100, Théo Lebrun wrote:

[...]

> > > > > > > +	u32		reg;	/* next 8 bytes are r0 and r1 */
> > > > > >
> > > > > > Not sure this comments gives any clarification to a mere reader of the code.
> > > > > > Perhaps you want to name this as reg64 (at least it will show that you have
> > > > > > 8 bytes, but I have no clue what is the semantic relationship between r0 and
> > > > > > r1, it's quite cryptic to me). Or maybe it should be reg_0_1?
> > > > > 
> > > > > Clocks are defined by two 32-bit registers. We only store the first
> > > > > register offset because they always follow each other.
> > > >
> > > > > I like the reg64 name and will remove the comment. This straight forward
> > > > > code is found in the rest of the code, I don't think it is anything
> > > > > hard to understand (ie does not need a comment):
> > > > > 
> > > > > 	u32 r0 = readl(base_plls + pll->reg);
> > > > > 	u32 r1 = readl(base_plls + pll->reg + sizeof(r0));
> > > >
> > > > Btw, why readq()/writeq() (with probably the inclusion of io-64-nonatomic-lo-hi.h)
> > > > can be used in this case? It will be much better overall and be aligned with
> > > > reg64 name.
> > > 
> > > The doc talks in terms of 32-bit registers. I do not see a reason to
> > > work in 64-bit. If we get a 64-bit value that we need to split we need
> > > to think about the endianness of our platform, which makes things more
> > > complex than just reading both values independently.
> >
> > 1) Would be nice to test on the real HW to confirm it doesn't accept 64-bit IO.
> 
> Just tested, it works. No error on the memory bus. And checked assembly
> generated was a single 64-bit instructions.
> 
> It might not work on other hardware revisions though. I can't remember
> if memory bus is changing across them.
> 
> > 2) Still I see a benefit from using lo_hi_readq() and friends directly.
> 
> So it is:
> 
> 	u32 r0 = readl(base_plls + pll->reg64);
> 	u32 r1 = readl(base_plls + pll->reg64 + sizeof(r0));
> 
> vs:
> 
> 	u64 r = lo_hi_readq(base_plls + pll->regs64);

> 	u32 r0 = r;
> 	u32 r1 = r >> 32;

It depends to the semantics of these two. How hard do they coupled to each
other semantically? I.o.w. can they always be considered as 64-bit register
with the respective bitfields? (And note FIELD_GET() here is your friend.)

> One is straight forward, the other uses an obscure helper that code
> readers must understand and follows that with bit manipulation.

[...]

> There are two errors to handle, that makes a mess out of the code.
> Having a little bit of repetition but straight forward code is nicer in
> my opinion. At least we tried!

Yes! Perhaps you can add a couple of words into commit message to explain
this detail of implementation (that code in two parts is not so identical
to be easily deduplicated).

-- 
With Best Regards,
Andy Shevchenko



