Return-Path: <linux-kernel+bounces-86935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78D986CD30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3FD1C21F03
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F214A089;
	Thu, 29 Feb 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/TLlltU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3B7E0E3;
	Thu, 29 Feb 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221021; cv=none; b=giX26Lyl/Xf5QG3FDrzRjPnUqpYHfoGvy9WfMglEpxLA5LvJxJMbj2NDI3pKXyIikVg1KLWPamAz5cZg3rnAWqNBF0LOhkUYUqpCDutKlmc5KfgYTSa757Eb64CSKQvUncVrOheNYL2OpCMmoEalfTxK65iKYAIrzLVBiY7ThlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221021; c=relaxed/simple;
	bh=AojVvot83WPpWLD2fpeVDx3Um/Z0rvl/iig7btLCMSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4igevAjyOpijO09rARh1LnbiC7Oncs55++wb8fZIep4B2m1IwKz9IN6CNYOQYWd3Qt6DRV4WmGwD5v8Adj9c8JdGzHWVpv9B/p3VnGRVC4DevdkP1xQzQ53T34ZU1chpE/dnpc9hgSPLwSNrj5TqkhSjQzryKRQ1Skq/bAgA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/TLlltU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709221020; x=1740757020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AojVvot83WPpWLD2fpeVDx3Um/Z0rvl/iig7btLCMSo=;
  b=b/TLlltUCZfC2VStdVC9eXgyppeg8C62iml9BIQ9Uq5O0A2TMwyA9ZBa
   TV195116MVmG7NNRrk9bsndttsSMH/nLOpIiBqMzF2T9ykwseX7kwoSSd
   esxVfV4uACwM8gH8NLSCJ6lj+mo6Y9CXdlgMLollcFygxTZREUgr/sIaG
   g9vRY4UNu+DAcVxcKHkpj22pJ8/+7Sm2Hkfrwv/ZNn6JNOELUyrbYB+G2
   +3fKzGyS75UmF8PUTT70l8fSJF49nhb0h0K0UzjXlFqVt6RwiwtRd/HdQ
   oBXNkLheFgvlT1fnIjIbbvUV7n9Bw8HDxVYf1OBQBOFdhSJ9+y7bKLHhd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3553155"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3553155"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913984737"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913984737"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:36:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfiSp-00000008hwl-00dB;
	Thu, 29 Feb 2024 17:36:51 +0200
Date: Thu, 29 Feb 2024 17:36:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v8 04/10] reset: eyeq5: add platform driver
Message-ID: <ZeCkkoNMioo-VOC6@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
 <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
 <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
 <ZeBo4N204gLO0eUd@smile.fi.intel.com>
 <CZHK1ZCSROM5.X4WYN7SAZJTH@bootlin.com>
 <ZeCLS17PhKPuGvkm@smile.fi.intel.com>
 <959414f110463d5de87c84a986c7894a03afcf4e.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <959414f110463d5de87c84a986c7894a03afcf4e.camel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 04:28:42PM +0100, Philipp Zabel wrote:
> On Do, 2024-02-29 at 15:48 +0200, Andy Shevchenko wrote:
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
> For context, there have been initial patches for this, that turned out
> not to be necessary later on:
> 
> https://lore.kernel.org/lkml/20220324141237.297207-1-clement.leger@bootlin.com/
> 
> At this point, there still is no real use case for non-DT reset
> controls on the horizon.

I can argue on that if we have something like reset-gpio (and we have a such).

With this in place the ACPI can also provide descriptions for that.

-- 
With Best Regards,
Andy Shevchenko



