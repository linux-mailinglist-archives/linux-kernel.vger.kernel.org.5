Return-Path: <linux-kernel+bounces-12116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D481F039
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBEC1C219E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B340345C0B;
	Wed, 27 Dec 2023 16:18:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042346420;
	Wed, 27 Dec 2023 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="399246276"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="399246276"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:17:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="1109673536"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="1109673536"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:17:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rIWbN-00000009Sb9-3quq;
	Wed, 27 Dec 2023 18:17:49 +0200
Date: Wed, 27 Dec 2023 18:17:49 +0200
From: Andy Shevchenko <andy@kernel.org>
To: =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
Message-ID: <ZYxOLXiV6IQQ7IlD@smile.fi.intel.com>
References: <20231222075812.6540-1-tychang@realtek.com>
 <20231222075812.6540-3-tychang@realtek.com>
 <ZYWLdG9kxm2ql0uf@smile.fi.intel.com>
 <63983de33ce2415abb8b5b745db58911@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63983de33ce2415abb8b5b745db58911@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 26, 2023 at 07:34:37AM +0000, TY_Chang[張子逸] wrote:
> >On Fri, Dec 22, 2023 at 03:58:12PM +0800, Tzuyi Chang wrote:

...

> >> +static int rtd_gpio_gpa_offset(struct rtd_gpio *data, unsigned int
> >> +offset) {
> >> +     return data->info->gpa_offset[offset / 31]; }
> >> +
> >> +static int rtd_gpio_gpda_offset(struct rtd_gpio *data, unsigned int
> >> +offset) {
> >> +     return data->info->gpda_offset[offset / 31]; }
> >
> >The / 31 so-o-o counter intuitive, please add a comment in each case to explain
> >why [it's not 32 or other power-of-2].
> >
> 
> In our hardware design, the bit 0 of the gpda and gpa status registers does not correspond to a GPIO.
> If bit 0 is set to 1, the other bit can be set to 1 by writing 1.
> If bit 0 is set to 0, the other bit can be clear to 0 by writing 1.
> 
> Therefore, each status register only contains the status of 31 GPIOs. I will add the comment for this.

Yes, please add in all places, while it's a dup, it helps understanding
the point without looking around for a while.

...

> >> +     for (i = 0; i < data->info->num_gpios; i += 31) {
> >
> >Same, add explanation why 31.
> >
> >Note, I actually prefer to see use of valid_mask instead of this weirdness.
> >Then you will need to comment only once and use 32 (almost?) everywhere.
> >
> 
> The reason remains consistent with the previous explanation. Each status
> register exclusively holds the status of 31 GPIOs.

As per above, add a comment.

> >> +             reg_offset = get_reg_offset(data, i);
> >> +
> >> +             status = readl_relaxed(data->irq_base + reg_offset) >> 1;
> >> +             writel_relaxed(status << 1, data->irq_base +
> >> + reg_offset);
> >> +
> >> +             for_each_set_bit(j, &status, 31) {
> >> +                     hwirq = i + j;
> >
> >Nice, but you can do better
> >
> >                /* Bit 0 is special... bla-bla-bla... */
> >                status = readl_relaxed(data->irq_base + reg_offset);
> >                status &= ~BIT(0);
> >                writel_relaxed(status, data->irq_base + reg_offset);
> >
> >                for_each_set_bit(j, &status, 32) {
> >                        hwirq = i + j - 1;
> >
> 
> Given that each status register accommodates the status of only 31 GPIOs, I
> think utilizing the upper format and including explanatory comments would be
> appropriate. It can indicate the status registers only contains 31 GPIOs.
> Please correct me if my understanding is incorrect.

The above is just a code hack to help bitops to optimise. 32 is power-of-2
which might be treated better by the compiler and hence produce better code.

Yet, it's an interrupt handler where we want to have the ops as shorter as
possible, so even micro-optimizations are good to have here (I don't insist
to follow the same idea elsewhere).

> >> +                     }
> >> +             }
> >> +     }

-- 
With Best Regards,
Andy Shevchenko



