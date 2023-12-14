Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFD481338A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573536AbjLNOtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573312AbjLNOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:49:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D6EBD;
        Thu, 14 Dec 2023 06:49:45 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2213382"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="2213382"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:49:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="767629176"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="767629176"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:49:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDn1j-00000005s2k-2Jqg;
        Thu, 14 Dec 2023 16:49:27 +0200
Date:   Thu, 14 Dec 2023 16:49:27 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
Message-ID: <ZXsV96xhuvVSyc1f@smile.fi.intel.com>
References: <20231207100723.15015-1-tychang@realtek.com>
 <20231207100723.15015-3-tychang@realtek.com>
 <ZXHMbZRXLXGa_tq8@smile.fi.intel.com>
 <989146448858478b975c66899b8f3fed@realtek.com>
 <ZXm0MIub8X2q_lnp@smile.fi.intel.com>
 <23574204547646779d02f0109c20b3ff@realtek.com>
 <ZXsKAyIlY3y3tgUi@smile.fi.intel.com>
 <0f0b3b65a838aea6797ae78c47d6af49@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f0b3b65a838aea6797ae78c47d6af49@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 03:35:18PM +0100, Michael Walle wrote:

> > > >> >> This driver enables configuration of GPIO direction, GPIO values,
> > > >> >> GPIO debounce settings and handles GPIO interrupts.
> > > >> >
> > > >> >Why gpio-regmap can't be used?
> > > >>
> > > >> I will try to use gpio-remap in the next version.
> > > >
> > > >If it appears that it makes code uglier / complicated, please add the note
> > > >somewhere to answer the above question.
> > > 
> > > I've traced the gpio-regmap.c file. It appears that for the driver
> > > to register
> > > gpio_irq_chip, it must create the irq_domain and add it into
> > > gpio_regmap_config.
> > > Additionally, the driver needs to register the irq handler by itself.
> > > However, this process can be managed by the gpiolib if the driver
> > > fills in the struct
> > > gpio_irq_chip inside struct gpio_chip before invoking
> > > gpiochip_add_data.
> > 
> > Hmm... I thought this is solvable issue.
> > Michael, is there a limitation in GPIO regmap that this driver can't be
> > converted?
> 
> gpio-regmap is designed that regmap-irq (drivers/base/regmap/irq.c) can be
> used. So, if regmap-irq fit this driver, then it can be used together with
> gpio-regmap.
> 
> From a quick glance at the patch, it looks like the gpio portion might fit
> gpio-regmap.
> 
> > > Moreover, apart from managing the registers for gpio direction and
> > > value, there
> > > are several other registers that require access(interrupt enable,
> > > debounce...).
> > > The GPIO IRQ status registers are located at different base
> > > addresses and are
> > > not contiguous. It may need to create an additional regmap and
> > > assign the access
> > > table to this regmap.
> > 
> > AFAIK this is not a problem as you can provide your own xlate function
> > that
> > will take care about register mapping.
> 
> Just for the gpio part. IIRC regmap has it own translation (regmap fields).
> 
> > > With the above consideration, I tend to keep using the existing
> > > method.
> > 
> > I would like to hear from Michael if it's indeed a big obstacle.
> 
> So, regarding the irq portion, again, it must fit the regmap-irq. For the
> additional requirement to set the debounce, you can add a .set_config to
> gpio_regmap_config and supply your own set_config callback. See also [1].

Thank you, Michael, for the prompt answer. It's insightful to me, I will try to
remember these aspects for the future reviews.

> [1]
> https://lore.kernel.org/linux-gpio/d4a6a640c373b6d939e147691efa596c@walle.cc/

-- 
With Best Regards,
Andy Shevchenko


