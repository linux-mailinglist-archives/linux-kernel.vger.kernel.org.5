Return-Path: <linux-kernel+bounces-86777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0407486CAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02532872FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A81350F9;
	Thu, 29 Feb 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQ7nlbzH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF2412FB03;
	Thu, 29 Feb 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214550; cv=none; b=H3xlMcI7A8oenXGDIW30qRJTpLX3cVUBvfxQquOrkejStTu8X7I35lulYH3I9jch4vRnWaVV5a+6Tz3I256H2BIQuBQD3cnJmbKNAo/3CYn04EweemA09wX4DylYTxSidJhbhU2zvbd3MpyZxvf9zFj0Tz2ZMl143KeoHKJWgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214550; c=relaxed/simple;
	bh=gGCDaO4bQHTt76a5KiiGRQz41mE60d5yevJypV2fKy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HntfsRdxtTXNPtTrrxgYHcprqoBP8wZWvSBAWmDj2+QgwSUCSj5I8qBcutfALpt+Yhd2xGIYuYYX8aahcsyrEK5SfXePhTcedGDCOgapAXdL4Sn3hqO/bwErznw2biC/sa/MU9Q0B9t7Ue+twM0MBDln0wTrrDRZ0Qp2GC0YQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQ7nlbzH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709214549; x=1740750549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gGCDaO4bQHTt76a5KiiGRQz41mE60d5yevJypV2fKy4=;
  b=CQ7nlbzHEqcTTk1BuQ9TudiEnW/KETfAgDKq8qEmxJsmmiDHq175w3Kl
   Ekc18km2qvQ1EdRj6l+kkk4Tz97AunyUJonmGYNmQPfRQhxULDrwA0RZR
   YHBaBIUUBAWaHlac6Rfc2xRqgLoWjGJGL9UW5ihAVOyo/jjmtVDdYA7T+
   yK+nAIMjpG5BUgM+L6ctv6h67+HxUfV4DyoLSDvYfQwJf6BU3ZJR3dnB3
   0ZqyPTwfDveVRBKHCWdIL/RHaOmKOciBhLWC7c9BBgiAg3UJWYJZqFT+o
   BdPCKGkhLuYQtvU5SPfbMivYBxbpeu8XylY68scTEYJKQ7j4hZHgoHan0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14835089"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14835089"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:49:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913982565"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913982565"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:49:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfgmR-00000008gMs-3Ien;
	Thu, 29 Feb 2024 15:48:59 +0200
Date: Thu, 29 Feb 2024 15:48:59 +0200
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
Message-ID: <ZeCLS17PhKPuGvkm@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
 <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
 <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
 <ZeBo4N204gLO0eUd@smile.fi.intel.com>
 <CZHK1ZCSROM5.X4WYN7SAZJTH@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZHK1ZCSROM5.X4WYN7SAZJTH@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 01:18:08PM +0100, Théo Lebrun wrote:
> On Thu Feb 29, 2024 at 12:22 PM CET, Andy Shevchenko wrote:
> > On Wed, Feb 28, 2024 at 06:04:47PM +0100, Théo Lebrun wrote:
> > > On Tue Feb 27, 2024 at 6:27 PM CET, Andy Shevchenko wrote:
> > > > On Tue, Feb 27, 2024 at 03:55:25PM +0100, Théo Lebrun wrote:

..

> > > > > +	priv->rcdev.of_node = np;
> > > >
> > > > It's better to use device_set_node().
> > > 
> > > I don't see how device_set_node() can help? It works on struct device
> > > pointers. Here priv->rcdev is a reset_controller_dev struct. There are
> > > no users of device_set_node() in drivers/reset/.
> >
> > No users doesn't mean it's good. The API is relatively "new" and takes
> > care of two things:
> > 1) it uses agnostic interface;
> > 2) it doesn't require any firmware node direct dereference.
> >
> > The 2) is most important here as allows us to refactor (firmware node) code
> > in the future.
> 
> I think I get the point of device_set_node(). I still do not understand
> how it could help me fill the ->of_node field in a reset_controller_dev
> structure?

Exactly why I put the above comment as recommendation. And then I elaborated
that entire reset framework should rather move towards fwnode.

> Should I be using device_set_node() to fill the struct device pointer
> and the reset subsystem, by some magic, will pick this up and use it
> for its own of_node field? I've not seen any magic/code doing that.

At bare minimum it will give beneficial things:
1) less burden in the drivers conversion in case fwnode happens (and I believe
   it's just matter of time) in reset framework;
2) hiding fwnode/of_node implemetation details (which is currently is layering
   violation to some extend (as we have a lot of *of_*() APIs to avoid direct
   access to of_node field in struct device).

The downside is that you will need to include property.h for this only thing.
And I don't see other code that can be converted to fwnode right away here.

-- 
With Best Regards,
Andy Shevchenko



