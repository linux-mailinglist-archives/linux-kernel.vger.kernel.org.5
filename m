Return-Path: <linux-kernel+bounces-86929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B086CD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6FC1F24E14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A846145FF9;
	Thu, 29 Feb 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4Af6Lyt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B713EFF6;
	Thu, 29 Feb 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220770; cv=none; b=uC4YHY06HHIVwuVzeNiqH2pXmp4PyDOGJqVOZ8P1mFRD8iHEU4DlSmxaYxlbUx4mV/zRG4HSOwOJ5bW99zUDgzWsaRHpzq+yNkMW51J7PHzO26dvBK1FlRhaawoieF4bL+/Ji/sfSAfzdsBKJSM7ibEGv+Pb67ypynU7TrzqqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220770; c=relaxed/simple;
	bh=xt+PgzxRSPIXI+lUwP9wsR2d9PWJuIwdO2KjxmYQstw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4yplu/RkcmKKBPL0OJHtS3KPjR6iWgoIorRScX9/bLWWS1n7vIEiKBcSNrbPSZNSCpmEvEg5KAZL409SUFpW3YtDfuDYRLi+w/4U0vK6EGsbGj7s+ujPhKKrcCq17tlw5GFS1WrtdOimC7lcr/ZTOkyHMeZAV4uVXL0y7ic/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4Af6Lyt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709220768; x=1740756768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xt+PgzxRSPIXI+lUwP9wsR2d9PWJuIwdO2KjxmYQstw=;
  b=g4Af6LytsLgX57YSO3XFm1s3MU2spWuJnHApqN3zI3jTkzvxKOzNaT2Y
   Dcf2oZK5FObkrVD8PHAxy5YbNtqNodXiHYveEViDjUYE++v8bs8DhNWOA
   ZE6SOvn4T9mSeELn0uzGW34TSMrA5jXzwYmsGZCw//+2jJRn7A3NPgnto
   UxMjcKIgJP5MsJJCKmxojTjFunP6e1cIFHrYXY2356VKw28im8IWcSS0J
   fHldoamSqWde7yuOfWlkV/YdxXSpetPoew5F8VO9ZTaR4AICcsSVm9je8
   kMCxLheVPKCasUEao4A8pJxju8eBs/lo9ZryB8ju/TTc+vTxWdgFR/yHR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3552531"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3552531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913984645"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913984645"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:32:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfiOh-00000008hqd-1cE5;
	Thu, 29 Feb 2024 17:32:35 +0200
Date: Thu, 29 Feb 2024 17:32:35 +0200
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
Subject: Re: [PATCH v8 05/10] pinctrl: eyeq5: add platform driver
Message-ID: <ZeCjk9QgtCWb8Ecy@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-5-c57fbda7664a@bootlin.com>
 <Zd4moVd_-bY6Z_kL@smile.fi.intel.com>
 <CZGX0TSYLOH4.DZHG351R9KFZ@bootlin.com>
 <ZeBsAbPRr5IPkVZj@smile.fi.intel.com>
 <CZHNS29NK9RR.13G019Y9ZY6IO@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZHNS29NK9RR.13G019Y9ZY6IO@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 04:13:15PM +0100, Théo Lebrun wrote:
> On Thu Feb 29, 2024 at 12:35 PM CET, Andy Shevchenko wrote:
> > On Wed, Feb 28, 2024 at 07:15:12PM +0100, Théo Lebrun wrote:
> > > On Tue Feb 27, 2024 at 7:14 PM CET, Andy Shevchenko wrote:
> > > > On Tue, Feb 27, 2024 at 03:55:26PM +0100, Théo Lebrun wrote:

..

> > > > > +	bool "Mobileye EyeQ5 pinctrl driver"
> > > >
> > > > Can't be a module?
> > > 
> > > It theory it could, I however do not see why that would be done. Pinctrl
> > > is essential to the platform capabilities. The platform is an embedded
> > > one and performance-oriented; boot-time is important and no user will
> > > ever want to load pinctrl as a module.
> >
> > I can argue. The modularization can give a better granularity in the exactly
> > embedded world when the memory resource (flash/RAM) is limited or fragmented
> > (for one or another reason). Having less weighty kernel at boot makes it smaller
> > to fit, for example, faster read only memory block which is not so uncommon.
> 
> I can argue back. :-) Granularity brought from modules is useful either
> in (1) resource constrained boot context or (2) for peripherals which
> some people might want to do without. We are not in case 1 nor case 2.
> 
> > The rule of thumb is to make modules if, otherwise, it's not so critical for
> > the boot process (and even for some cases we still may have it done as a module
> > with help of deferred probe mechanism).
> 
> I'd call SoC pin control a critical resource for the boot process.
> 
> I also like the simplicity of builtin better for such a resource.
>  - If we tristate pinctrl-eyeq5 and there is a bug, there is a bug (in a
>    context that we have no reason to support).
>  - If we do not allow it and there is a bug, there is no bug.
>    Plus, it makes one less choice for people configuring the kernel.

The problem is that you reduce the flexibility. Nobody prevents you from having
it built-in while tristate. But completely different situation when it's bool.

So my argument still stays. I think new code shouldn't be boolean by default.
The only exceptional cases can do that (like PMIC driver or critical clock one).

[...]

> > > > > +	if (WARN_ON(offset > 31))
> > > > > +		return false;
> > > >
> > > > When this condition can be true?
> > > 
> > > If there is a bug in the code. Defensive programming.
> > > 
> > > There is this subtle conversion of pin numbers => offset inside of a
> > > bank. If one function forgets doing this then eq5p_test_bit() gets
> > > called with a pin number.
> > > 
> > > In this GPIO series I fixed such a bug in a 10 year old driver:
> > > https://lore.kernel.org/lkml/20240228-mbly-gpio-v2-5-3ba757474006@bootlin.com/
> > > 
> > > The whole "if it can happen it will happen" mantra. We'll get a warning
> > > in the logs using pinctrl-eyeq5.
> >
> > My point here that we have mechanisms to avoid such issues, for example in GPIO
> > we have valid_mask field and GPIO library takes care to avoid such conditions
> > from happening. Please, double check that you really need these in your driver.
> > I prefer to avoid them until it's proven that they are real cases.
> 
> Whatever the subsystem does to protect us (like only calling callbacks
> with valid IDs), it will not protect us from bugs inside the driver's
> callbacks.
> 
> I do no see a reason to avoid such code. I do not trust myself to write
> perfect code.

Perfect is enemy of good. ;)

> Its aim is to protect ourselves from our own mistakes. If
> such an issue occurs, understanding that this is what happened would be
> really hard (especially if it occurs on someone else's boards).

Yes, but we usually don't put a dead code into the kernel. So, can you confirm
that warning can appear IRL? If yes, there is another red flag or question:
why WARN()? This is easily becomes a panic and/or reboot (depending to the kernel
command line) and hence may give unresponsive system. Was this considered?

..

> > > > > +static const struct pinctrl_ops eq5p_pinctrl_ops = {
> > > > > +	.get_groups_count	= eq5p_pinctrl_get_groups_count,
> > > > > +	.get_group_name		= eq5p_pinctrl_get_group_name,
> > > > > +	.get_group_pins		= eq5p_pinctrl_get_group_pins,
> > > > > +	.pin_dbg_show		= eq5p_pinctrl_pin_dbg_show,
> > > >
> > > > > +	.dt_node_to_map		= pinconf_generic_dt_node_to_map_pin,
> > > > > +	.dt_free_map		= pinctrl_utils_free_map,
> > > >
> > > > ifdef is missing for these... But the question is, isn't these a default when
> > > > OF is in use?
> > > 
> > > Doesn't look like it is. In drivers/pinctrl/devicetree.c:
> > > 
> > > 	static int dt_to_map_one_config(struct pinctrl *p,
> > > 					struct pinctrl_dev *hog_pctldev,
> > > 					const char *statename,
> > > 					struct device_node *np_config)
> > > 	{
> > > 		// ...
> > > 
> > > 		/*
> > > 		 * Call pinctrl driver to parse device tree node, and
> > > 		 * generate mapping table entries
> > > 		 */
> > > 		ops = pctldev->desc->pctlops;
> > > 		if (!ops->dt_node_to_map) {
> > > 			dev_err(p->dev, "pctldev %s doesn't support DT\n",
> > > 				dev_name(pctldev->dev));
> > > 			return -ENODEV;
> > > 		}
> > > 
> > > 		// ...
> > > 	}
> > > 
> > > And I see nowhere that puts a value if ->dt_node_to_map is empty.
> > > 
> > > For dt_free_map, it is an optional value. If the field is NULL nothing
> > > is done. See dt_free_map() in the same file.
> >
> > If we drop OF dependency, these fields might not be present in the structure
> > (by definition). Compilation won't succeed. Am I mistaken?
> 
> struct pinctrl_ops has both ->dt_node_to_map and ->dt_free_map fields in
> any case. See include/linux/pinctrl/pinctrl.h which declares the
> struct. The function pointers we put are also under no conditional
> compilation.

Indeed, I mixed it with something else (probably GPIO library and one of its
core structures) where it's the case.

-- 
With Best Regards,
Andy Shevchenko



