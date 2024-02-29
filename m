Return-Path: <linux-kernel+bounces-86636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B3686C825
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B324E28A150
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14137C6F0;
	Thu, 29 Feb 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3bDFSxa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5B7C094;
	Thu, 29 Feb 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206541; cv=none; b=PsUBWx0VuQfpHYG9MKi6n4iJe22ZD+abkIx8joR51SmJzHazp/44P4XKhG7nP62DBKGn4KYzaaBxceZ+QTXh8e6LRyQmHD4Jufb/O8q6NPVYmzlT9zV9e5Yu6FN5PJgyC3zzPwVBSN/TEAlSLsdyzmbVgaLpYkGgHc/39gto4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206541; c=relaxed/simple;
	bh=YogPyO3rk3PZUkIl0xYeP/jXMy5FnEdsJGaoXJDB1do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+pIRfWhw4DBCW3zZEOeynHARtonKo8gsoJaQXZ0IGDX/BEvVUmH2aMgEC/wqZ85RvXo/F42z4DrpRpmESUe0GbqY0l5jvvA8T7y9Ro7ebvuhbl9E7dcy2J/36eJaQZZtPLarM7bHdUZNetccQjVrPONPwOlU4btyjpDU0FzehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3bDFSxa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709206539; x=1740742539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YogPyO3rk3PZUkIl0xYeP/jXMy5FnEdsJGaoXJDB1do=;
  b=e3bDFSxaOGnQu1yXls3lnzL5jkOfL3fkXHPerw7otkXGfv0BikZBKK0M
   IA79SvFkm3b4O1liqAMlyEzIPPy3ewjEDJCLQ6hsYUJc2Yc527QU2JPNc
   WzcwhtWxXpFi9KQh8T10BtmCPNdPF9okBx6SlVKQ+M9drE3l3vrX5mcnw
   1thGU/qGaRzoHw9Z/7crzE3n5YIlpAOqWBAHalIJw4UhSFkL4vdmR6lFe
   kvTnbop/hjUk0L+Cmwaa5YmelkGHhBXdh5jcT/Byupfw6Q2UniYMhMjfk
   Bk4AujITD7QG1bxKTk1IrzEpV33wdXQiHJENeLSwHOZp9aYOFOskXp0rm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14821303"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14821303"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 03:35:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913979814"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913979814"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 03:35:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfehG-00000008ef0-0MRt;
	Thu, 29 Feb 2024 13:35:30 +0200
Date: Thu, 29 Feb 2024 13:35:29 +0200
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
Message-ID: <ZeBsAbPRr5IPkVZj@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-5-c57fbda7664a@bootlin.com>
 <Zd4moVd_-bY6Z_kL@smile.fi.intel.com>
 <CZGX0TSYLOH4.DZHG351R9KFZ@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZGX0TSYLOH4.DZHG351R9KFZ@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 07:15:12PM +0100, Théo Lebrun wrote:
> On Tue Feb 27, 2024 at 7:14 PM CET, Andy Shevchenko wrote:
> > On Tue, Feb 27, 2024 at 03:55:26PM +0100, Théo Lebrun wrote:

..

> > > +	bool "Mobileye EyeQ5 pinctrl driver"
> >
> > Can't be a module?
> 
> It theory it could, I however do not see why that would be done. Pinctrl
> is essential to the platform capabilities. The platform is an embedded
> one and performance-oriented; boot-time is important and no user will
> ever want to load pinctrl as a module.

I can argue. The modularization can give a better granularity in the exactly
embedded world when the memory resource (flash/RAM) is limited or fragmented
(for one or another reason). Having less weighty kernel at boot makes it smaller
to fit, for example, faster read only memory block which is not so uncommon.

The rule of thumb is to make modules if, otherwise, it's not so critical for
the boot process (and even for some cases we still may have it done as a module
with help of deferred probe mechanism).

[...]

> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/pinctrl/pinconf-generic.h>
> > > +#include <linux/pinctrl/pinconf.h>
> > > +#include <linux/pinctrl/pinctrl.h>
> > > +#include <linux/pinctrl/pinmux.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/seq_file.h>
> >
> > Semi-random list of the inclusions. Please, fix it.
> > While doing that, group out pinctrl/* ones as it's done in other drivers.
> 
> Here is my new list:
> 
> #include <linux/array_size.h>
> #include <linux/bits.h>
> #include <linux/bug.h>
> #include <linux/device.h>
> #include <linux/err.h>
> #include <linux/errno.h>
> #include <linux/io.h>
> #include <linux/mod_devicetable.h>
> #include <linux/platform_device.h>
> #include <linux/seq_file.h>
> #include <linux/slab.h>
> #include <linux/types.h>
> 
> #include <linux/pinctrl/pinconf-generic.h>
> #include <linux/pinctrl/pinconf.h>
> #include <linux/pinctrl/pinctrl.h>
> #include <linux/pinctrl/pinmux.h>
> 
> #include "core.h"
> #include "pinctrl-utils.h"

Thanks, looks much better to me!

[...]

> > > +	if (WARN_ON(offset > 31))
> > > +		return false;
> >
> > When this condition can be true?
> 
> If there is a bug in the code. Defensive programming.
> 
> There is this subtle conversion of pin numbers => offset inside of a
> bank. If one function forgets doing this then eq5p_test_bit() gets
> called with a pin number.
> 
> In this GPIO series I fixed such a bug in a 10 year old driver:
> https://lore.kernel.org/lkml/20240228-mbly-gpio-v2-5-3ba757474006@bootlin.com/
> 
> The whole "if it can happen it will happen" mantra. We'll get a warning
> in the logs using pinctrl-eyeq5.

My point here that we have mechanisms to avoid such issues, for example in GPIO
we have valid_mask field and GPIO library takes care to avoid such conditions
from happening. Please, double check that you really need these in your driver.
I prefer to avoid them until it's proven that they are real cases.

..

> > > +static const struct pinctrl_ops eq5p_pinctrl_ops = {
> > > +	.get_groups_count	= eq5p_pinctrl_get_groups_count,
> > > +	.get_group_name		= eq5p_pinctrl_get_group_name,
> > > +	.get_group_pins		= eq5p_pinctrl_get_group_pins,
> > > +	.pin_dbg_show		= eq5p_pinctrl_pin_dbg_show,
> >
> > > +	.dt_node_to_map		= pinconf_generic_dt_node_to_map_pin,
> > > +	.dt_free_map		= pinctrl_utils_free_map,
> >
> > ifdef is missing for these... But the question is, isn't these a default when
> > OF is in use?
> 
> Doesn't look like it is. In drivers/pinctrl/devicetree.c:
> 
> 	static int dt_to_map_one_config(struct pinctrl *p,
> 					struct pinctrl_dev *hog_pctldev,
> 					const char *statename,
> 					struct device_node *np_config)
> 	{
> 		// ...
> 
> 		/*
> 		 * Call pinctrl driver to parse device tree node, and
> 		 * generate mapping table entries
> 		 */
> 		ops = pctldev->desc->pctlops;
> 		if (!ops->dt_node_to_map) {
> 			dev_err(p->dev, "pctldev %s doesn't support DT\n",
> 				dev_name(pctldev->dev));
> 			return -ENODEV;
> 		}
> 
> 		// ...
> 	}
> 
> And I see nowhere that puts a value if ->dt_node_to_map is empty.
> 
> For dt_free_map, it is an optional value. If the field is NULL nothing
> is done. See dt_free_map() in the same file.

If we drop OF dependency, these fields might not be present in the structure
(by definition). Compilation won't succeed. Am I mistaken?

[...]

> > > +	mask = BIT(offset);
> > > +	val = is_gpio ? 0 : U32_MAX;
> >
> > I think you meant something else (semantically) than U32_MAX.
> > Perhaps GENMASK(31, 0)?
> 
> To me the semantic of U32_MAX is the same.

Not at all. When we speak hardware we speak bits, bitfields, etc. We almost
never speaks software types and their limits (u32 is a pure software concept).

> I see where you are coming
> from. A better alternative however would be:
> 
> 	mask = BIT(offset);
> 	val = is_gpio ? 0 : mask;
> 
> That way the desire is clear and the code is simpler.

Yes, please follow the latter, much better than integer limits.

..

> > > +	case PIN_CONFIG_DRIVE_STRENGTH:
> > > +		offset *= 2; /* two bits per pin */
> > > +		if (offset >= 32) {
> > > +			val_ds = readl(pctrl->base + eq5p_regs[bank][EQ5P_DS_HIGH]);
> > > +			offset -= 32;
> > > +		} else {
> > > +			val_ds = readl(pctrl->base + eq5p_regs[bank][EQ5P_DS_LOW]);
> > > +		}
> >
> > I'm wondering why you can't use your helpers before multiplication?
> 
> I'm unsure what helpers you are talking about?

Which give you the MMIO addresses.

> If the question is about why multiply before if-condition: I feel like
> multiplying first allows having the if condition be "offset >= 32".
> That explicits why we readl HIGH vs LOW regs.

[...]

> > > +	if (arg > 3) {
> >
> > Magic number.
> 
> Would 0b11 explicit why? The value is two bits wide, so 0 thru 3.

No, the

#define FOO_SELF_EXPLAING	GENMASK(1, 0) // or 3 or 0b11

will.

..

> > Similar comments as per previous function.
> 
> So GENMASK(1, 0) rather than 0b11. Or GENMASK(offset+1, offset).

Definitely not the latter one, it will generate awful code.

> Something else?

if it was another comment, I don't see in the context here...

-- 
With Best Regards,
Andy Shevchenko



