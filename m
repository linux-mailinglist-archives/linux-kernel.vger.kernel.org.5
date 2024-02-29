Return-Path: <linux-kernel+bounces-86622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27E86C7F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915541F25138
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8719A7B3F7;
	Thu, 29 Feb 2024 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEBj7hY0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB15645B;
	Thu, 29 Feb 2024 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205738; cv=none; b=S4izfrr5yGHJcoerFLC4z0TjPz3Uj9X+1HDs2fA608k4Tbobs9T/FKwKWA+t6zcOitIoPKTwNZUAcMnV+VH/kby0We85OfxwnBUvi/df0YqqdSdORfbqfZlekAv/25xGGOJ9/zEimXUShA37Let0VQkUvF138jhHmTj77L7jdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205738; c=relaxed/simple;
	bh=zXIJ6DTK4aEHeV8T/EFA1AVFJ0y+J9Z6QWdm47NHplo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erjUHKgCgRd+XmFPrv3VP68Pe0Y5zwRYcSPWPX0zKNfuzveOtdme0fwysshddjWI8U2+qH1aZGV0j8un7vqNjl8Wyj6Jl526W5+88MdCVc3mv4VgNT/5kO4CWFZU+0jOIQddM1Ot9PziIhXjI32pDPJXnuZa2MJ6dvS3zCF2vwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEBj7hY0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709205737; x=1740741737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zXIJ6DTK4aEHeV8T/EFA1AVFJ0y+J9Z6QWdm47NHplo=;
  b=jEBj7hY0NKj+2zMqXjlgbKFXKMb+ZTJERQJqcDXIkLriMSmdHIAT3j7a
   IjHnZvl1HQoHvhOv+4ULh17IvYkzb9MmSOtILQUcTFHgk6/riuHJXuzm8
   eqVll2OpmytiDq9zZj0DErEBaCSa5BtlHn335Wxa5Y7aOQucRrUF5sAUa
   K2SaeqYdcGy/jdECi7gcqqaBszW3BLzkhNISheQ0lwDx/mvch4E3rsM3g
   4z1NCRSj7XBauUa4dfW9/L6Zmd+5K4ToVZLpym1SNxu6ku09trcZ3B2MN
   ymy1KKxjo/EVwWV7XfEaLChMRvKqtaG5HmdUWaDSOgYSMvfy1TSQYT3mB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3791751"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3791751"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 03:22:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913979556"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913979556"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 03:22:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfeUK-00000008eVP-2iSE;
	Thu, 29 Feb 2024 13:22:08 +0200
Date: Thu, 29 Feb 2024 13:22:08 +0200
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
Message-ID: <ZeBo4N204gLO0eUd@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
 <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
 <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 06:04:47PM +0100, Théo Lebrun wrote:
> On Tue Feb 27, 2024 at 6:27 PM CET, Andy Shevchenko wrote:
> > On Tue, Feb 27, 2024 at 03:55:25PM +0100, Théo Lebrun wrote:

..

> > > +	u32 offset = id & GENMASK(7, 0);
> > > +	u32 domain = id >> 8;
> >
> > Perhaps
> >
> > 	u32 offset = (id & GENMASK(7, 0)) >> 0;
> > 	u32 domain = (id & GENMASK(31, 8)) >> 8;
> >
> > for better understanding the split?
> 
> Do the additional zero-bit-shift and GENMASK() help understanding? My
> brain needs time to parse them to then notice they do nothing and
> simplify the code in my head, back to the original version.

In my opinion yes, as you exactly showing the split.
But. The better is to use FIELD_GET().

> I personally like the simplest version (the original one). But otherwise
> FIELD_GET() with two globally-defined masks could be a solution as
> well.

Oh, yes, that's what just came to my mind without even looking here.

> I still prefer the original version better. Less symbols, less
> complexity.

[...]

> > > +	priv->rcdev.of_node = np;
> >
> > It's better to use device_set_node().
> 
> I don't see how device_set_node() can help? It works on struct device
> pointers. Here priv->rcdev is a reset_controller_dev struct. There are
> no users of device_set_node() in drivers/reset/.

No users doesn't mean it's good. The API is relatively "new" and takes
care of two things:
1) it uses agnostic interface;
2) it doesn't require any firmware node direct dereference.

The 2) is most important here as allows us to refactor (firmware node) code
in the future.

> > > +	priv->rcdev.of_reset_n_cells = 2;
> > > +	priv->rcdev.of_xlate = eq5r_of_xlate;

However, ideally these should be also translated to use fwnode as IIO did,
for example.

..

> > > +		priv->rcdev.nr_resets += __builtin_popcount(eq5r_valid_masks[i]);
> >
> > Please, use corresponding hweightXX() API.
> 
> Noted. I did not find this keyword even though I searched quite a bit
> for it. "popcount" sounds more logical to me. :-)

Hmm... But it's fundamental, it's called Hamming weight.
https://en.wikipedia.org/wiki/Hamming_weight

-- 
With Best Regards,
Andy Shevchenko



