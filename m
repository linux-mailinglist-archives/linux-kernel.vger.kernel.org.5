Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4866A811AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378960AbjLMR3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjLMR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:28:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A6B99
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702488544; x=1734024544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FNvpn5+0nNGuccdgyMS9bQ80deCKqQhRJFYG39AGC/A=;
  b=U0DUnF52/kYnk3sJXUFFxAMMknkl4BaEAGD/RNkvlSEmowQ1kXMbzkJt
   5kQohTlIaynLS6fDc1Q3tugyHDilkBZWhxVlrG6jEK2hV4023vCA4vMHP
   nAr4ZUYK+HD5AfwG2mCdny9JSVLr/RUuEjVo8BVMoCiKEDNzmjaBSUSSc
   E5JEvzDIlj2XRf1zGzgDMHKlVTuLSe9KlRI9UXEwN2/xw6I5/qs2vINKH
   iW4qLClRalNt+INhpK5k7eDfklMmXIXi/EntHDYPEWe23YwIQE8Bs+ENt
   HHdM/uY/o+nNRf6IdrqBDVKXdgrh7btE4SX+IJahgcpbC9jDFK/8hOXX8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375149711"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="375149711"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:29:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="892091550"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="892091550"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:29:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rDT2Z-00000005ayF-32y5;
        Wed, 13 Dec 2023 19:28:59 +0200
Date:   Wed, 13 Dec 2023 19:28:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 03/40] ARM: ep93xx: add regmap aux_dev
Message-ID: <ZXnp284IpfVEZX6A@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-3-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-3-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:20:20AM +0300, Nikita Shubin wrote:
> The following driver's should be instantiated by ep93xx syscon driver:
> 
> - reboot
> - pinctrl
> - clock
> 
> They all require access to DEVCFG register with a shared lock held, to
> avoid conflict writing to swlocked parts of DEVCFG.
> 
> Provide common resources such as base, regmap and spinlock via auxiliary
> bus framework.

...

>  struct platform_device;
> +struct regmap;

Perhaps more to add. See below.

...

> +enum ep93xx_soc_model {
> +	EP93XX_9301_SOC,
> +	EP93XX_9307_SOC,
> +	EP93XX_9312_SOC

It doesn't look like a termination, so leave trailing comma.

> +};

...

> +#include <linux/spinlock.h>

I don't see a user for this. Am I missing something?

-- 
With Best Regards,
Andy Shevchenko


