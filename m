Return-Path: <linux-kernel+bounces-86933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447C86CD28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D1E28A56D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BE814AD15;
	Thu, 29 Feb 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/2kS/ie"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED9145B20;
	Thu, 29 Feb 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220918; cv=none; b=C0geB7mVQ2OHwYngcTAJZLgeQbevb4rQWwl7GiLKOx9RBiHfldB8MZfEnr7kYNCSswseqvR4+fNV3oyKJy1rFlQ7gJctd/qVnjJowCVXN2bSHw1AuAnlOjySWYOZwho06iTKGDOSPQZkHy38ZYuixiXHYr5eio0G50cERdvb74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220918; c=relaxed/simple;
	bh=VyLF2sZrx+sakktPpGpYEkXykCZGegYDpKq0Eu7radg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcI6SbexUatPE/t8rAkuIXs1lhtAIiW2tI814l5E0DD2p/ijU5ZrDKtTPtomO4KxASZJMXPA5i/fcCzd+uRe0Kuv5zvco6johcB3FHbODzsBGVOh/W3BRyGDjXwhwYWy7FCF/TBCw7wMNRBI6KNMzYwLlDjckuVpj5FC7fQu9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/2kS/ie; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709220916; x=1740756916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VyLF2sZrx+sakktPpGpYEkXykCZGegYDpKq0Eu7radg=;
  b=P/2kS/ieY68sNAtfoJGf5L4gOfKSHs8vHf75P20oYLu62hAvVqPhUv8r
   a181lFN1oEVV/5FyOVc5ZuZafCA5gEq06KKAJcdWh+DCt9RBZE9WOLFZT
   tIjXUh4c9PvGP4wRO6LxlG7LeVn6SvNboy5OygRMTMs76d2KLge0DWpuD
   jp1YOZxKsK8Kkq5IPYVZ9W/jMtURBg58ESjl/ZQEp0xpxcmhu1uJNZaSN
   rsvw8yryhxhQ9Jct3ImfN+g5BwW7DwqTNKJWPWJsvLyHQ8e0QtiISZ1TF
   pGYdu2UJrjUZeRIrcNVYQCVPQXtEhJ9VKJAbrgvvsEe35nFPPMA0FEzZl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3552795"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3552795"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:33:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913984676"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913984676"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:33:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfiPn-00000008hrW-21W4;
	Thu, 29 Feb 2024 17:33:43 +0200
Date: Thu, 29 Feb 2024 17:33:43 +0200
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
Subject: Re: [PATCH v8 04/10] reset: eyeq5: add platform driver
Message-ID: <ZeCj13CekGTO62Be@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
 <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
 <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
 <ZeBo4N204gLO0eUd@smile.fi.intel.com>
 <CZHK1ZCSROM5.X4WYN7SAZJTH@bootlin.com>
 <ZeCLS17PhKPuGvkm@smile.fi.intel.com>
 <CZHNZJJ600CC.1WV7Q2520ZSKU@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZHNZJJ600CC.1WV7Q2520ZSKU@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 04:23:01PM +0100, Théo Lebrun wrote:
> On Thu Feb 29, 2024 at 2:48 PM CET, Andy Shevchenko wrote:
> > On Thu, Feb 29, 2024 at 01:18:08PM +0100, Théo Lebrun wrote:
> > > On Thu Feb 29, 2024 at 12:22 PM CET, Andy Shevchenko wrote:
> > > > On Wed, Feb 28, 2024 at 06:04:47PM +0100, Théo Lebrun wrote:
> > > > > On Tue Feb 27, 2024 at 6:27 PM CET, Andy Shevchenko wrote:
> > > > > > On Tue, Feb 27, 2024 at 03:55:25PM +0100, Théo Lebrun wrote:

..

> > > > > > > +	priv->rcdev.of_node = np;
> > > > > >
> > > > > > It's better to use device_set_node().
> > > > > 
> > > > > I don't see how device_set_node() can help? It works on struct device
> > > > > pointers. Here priv->rcdev is a reset_controller_dev struct. There are
> > > > > no users of device_set_node() in drivers/reset/.
> > > >
> > > > No users doesn't mean it's good. The API is relatively "new" and takes
> > > > care of two things:
> > > > 1) it uses agnostic interface;
> > > > 2) it doesn't require any firmware node direct dereference.
> > > >
> > > > The 2) is most important here as allows us to refactor (firmware node) code
> > > > in the future.
> > > 
> > > I think I get the point of device_set_node(). I still do not understand
> > > how it could help me fill the ->of_node field in a reset_controller_dev
> > > structure?
> >
> > Exactly why I put the above comment as recommendation. And then I elaborated
> > that entire reset framework should rather move towards fwnode.
> 
> OK now I get it. One question: would using fwnode abstractions make
> sense for a driver that is devicetree-only, and will stay that way?

In my opinion, yes. But less beneficial from it.

> However this sounds out-of-scope of such a driver addition. I also am
> not familiar enough (yet?) with the reset subsystem and/or fwnode to be
> able to bring this kind of changes upstream.

Right.

-- 
With Best Regards,
Andy Shevchenko



