Return-Path: <linux-kernel+bounces-86885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA53D86CC40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5841C22FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88783137C21;
	Thu, 29 Feb 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqcFT4Bq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314113775A;
	Thu, 29 Feb 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218762; cv=none; b=BprcXcZvMCf3VJB1zmnmGl6Q2an2ekIMTARVEQrmVrJ0RSjrCpHg7nCa9WGDC76MZvnDx2n/V22dtaN0tvh24fYrUiCIv6Prb7lWtoZY9MS0vdKHDJTYVDsyuY1xxf8KHFjkg8PZPLkdbblvuxD8XPkpW6fC2u/b85nRmgXpjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218762; c=relaxed/simple;
	bh=pL6jYa+vJnfd7vnNeJo8DWyR6G2DvoCi67myfzLlv4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKLMHMFaxTcF2dAkhL6CkVIcXfXJsAWXigmGaBsW4OunMXU4dZW+TmUO8J48uOxAJfKdY1TTtxQsKkiIekzWVvb+06BA6ahsjC8mflGCTahxA1hdgQsdDSOp4FXcKvti3gj0GqgsB+obmwA2kkWUexfdAorDexVWCl7v/lXPQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqcFT4Bq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709218761; x=1740754761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pL6jYa+vJnfd7vnNeJo8DWyR6G2DvoCi67myfzLlv4E=;
  b=kqcFT4BqlhfcqpAA72B0d5H7bHZQPu3XGOgO1G0kKFbM9Tn4gfLM4n4j
   ohB7SIfb0vS4MqIXr+rFPeKjZV+IJeKlAI8KfPcA4pVeQwf1KmFhKBL3w
   b6ph1c9nQzdc2ySR5fFvWuToxa/7RfFausUK3ulP+vyzwg9mRRrnzy08m
   Wipj8/+lmiIWcyIPn5HfKFs1lUEa6SC5HYvAwbEtwGeN4QyoyKMXbLB1C
   xO/J6zjPqTT6e5e1jq10Dsq2TI59nmVBz+NrNyQk7rhhgI6Pwy91ZLEn4
   qozJqHXtwCH8FWFXLYPhc6iw0qZ3u7sMFaSMY4uYlgmlRHxm0bDVBR61l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7471806"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7471806"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913983949"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913983949"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:59:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfhsN-00000008hQC-1bcJ;
	Thu, 29 Feb 2024 16:59:11 +0200
Date: Thu, 29 Feb 2024 16:59:10 +0200
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
Message-ID: <ZeCbvgWY6x1o17Kq@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-3-c57fbda7664a@bootlin.com>
 <Zd4X3NnBoEl0wu2H@smile.fi.intel.com>
 <CZGSB2O8P572.28HK6WFT43N6S@bootlin.com>
 <ZeBnX2upNRN0xXH4@smile.fi.intel.com>
 <CZHMSNWMH4KJ.2J6ZMWKMSZYH2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZHMSNWMH4KJ.2J6ZMWKMSZYH2@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 03:27:01PM +0100, Théo Lebrun wrote:
> On Wed, Feb 28, 2024 at 03:33:29PM +0100, Théo Lebrun wrote:
> > On Tue Feb 27, 2024 at 6:11 PM CET, Andy Shevchenko wrote:
> > > On Tue, Feb 27, 2024 at 03:55:24PM +0100, Théo Lebrun wrote:

[...]

> > > > > +	u32		reg;	/* next 8 bytes are r0 and r1 */
> > > >
> > > > Not sure this comments gives any clarification to a mere reader of the code.
> > > > Perhaps you want to name this as reg64 (at least it will show that you have
> > > > 8 bytes, but I have no clue what is the semantic relationship between r0 and
> > > > r1, it's quite cryptic to me). Or maybe it should be reg_0_1?
> > > 
> > > Clocks are defined by two 32-bit registers. We only store the first
> > > register offset because they always follow each other.
> >
> > > I like the reg64 name and will remove the comment. This straight forward
> > > code is found in the rest of the code, I don't think it is anything
> > > hard to understand (ie does not need a comment):
> > > 
> > > 	u32 r0 = readl(base_plls + pll->reg);
> > > 	u32 r1 = readl(base_plls + pll->reg + sizeof(r0));
> >
> > Btw, why readq()/writeq() (with probably the inclusion of io-64-nonatomic-lo-hi.h)
> > can be used in this case? It will be much better overall and be aligned with
> > reg64 name.
> 
> The doc talks in terms of 32-bit registers. I do not see a reason to
> work in 64-bit. If we get a 64-bit value that we need to split we need
> to think about the endianness of our platform, which makes things more
> complex than just reading both values independently.

1) Would be nice to test on the real HW to confirm it doesn't accept 64-bit IO.
2) Still I see a benefit from using lo_hi_readq() and friends directly.

[...]

> > > > I didn't get. If eq5c_init() was finished successfully, why do you need to
> > > > seems repeat what it already done? What did I miss?
> > > 
> > > The key here is that eq5c_init() iterates on eq5c_early_plls[] while
> > > eq5c_probe() iterates on eq5c_plls[]. I've tried to hint at this in the
> > > commit message:
> > > 
> > > > Two PLLs are required early on and are therefore registered at
> > > > of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for the
> > > > UARTs.
> > > 
> > > Doing everything in eq5c_init() is not clean because we expect all new
> > > clock provider drivers to be standard platform drivers. Doing
> > > everything from a platform driver probe doesn't work because some
> > > clocks are required earlier than platform bus init. We therefore do a
> > > mix.
> >
> > Am I missing something or these two pieces are using the same IO resources?
> > This looks like a lot of code duplication without clear benefit. Perhaps
> > you can have a helper?
> 
> There are two subtle differences that make creating a helper difficult:
> 
>  - Logging, pr_*() vs dev_*(). Second option is preferred but only
>    available once a device is created.

Some code uses (yeah, arguable that it's better, but depends on how much
the real deduplication takes)

	if (dev)
		dev_*(...);
	else
		pr_*(...);

>  - Behavior on error: we stop the world for early clocks but keep going
>    for normal clocks.

..(..., bool skip_errors)
{
	...
}

(with the same caveat)?

-- 
With Best Regards,
Andy Shevchenko



