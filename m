Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F07782EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjHURAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHURAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:00:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F0010F;
        Mon, 21 Aug 2023 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692637218; x=1724173218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n7S/UFEeowdzIZmbsuVfPC9j0Vf3rJq/KFb1fvy2s7A=;
  b=m0OiH4fvmlXCOg8qHcR9OuNUs9bOoFVFdJYAIS7UGNVK78ZYJfh6nUB3
   n2r7Ri4anQbzS9BO7vhJ8LSkgSQomGbopYrcO+k+3V6hS8LIalT1hXWnq
   M7rtqTqDL62hdjPTIZtiCk08u2I7cCEDoQZp84YqyPGXVoAeVeV7LPu58
   L7WdVhdF/DaFx1GUxRygbxu2eYCYBwa5gkBqwFfbNb9E3FHqGxdcG8g47
   7gMxp2sEaps5mahBLHsLflERFcrmqwdvatsIS6OXyJNP9hpxO4VjKpjdP
   14NS/ZvFwTj60kQzVpEC3EQa/y8lOKMB/4lYhVIBqO/uX0HY8cFVkoJ2c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="372546682"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="372546682"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 10:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826004434"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="826004434"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Aug 2023 10:00:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY8G7-005X2E-2I;
        Mon, 21 Aug 2023 20:00:07 +0300
Date:   Mon, 21 Aug 2023 20:00:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 00/10] pinctrl: Provide NOIRQ PM helper and use it
Message-ID: <ZOOYFxDktwce79Yc@smile.fi.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 08:28:11PM +0300, Andy Shevchenko wrote:
> Intel pin control drivers use NOIRQ variant of the PM callbacks.
> Besides that several other drivers do similar. Provide a helper
> to make them smaller and less error prone against different
> kernel configurations (with possible defined but not used variables).
> 
> The idea is to have an immutable branch that PM tree can pull as well as
> main pin control one. We also can do other way around, if Rafael prefers
> that.

I have partially applied the series to my review and testing queue with
the following changes (besides the tags added):
- split pm_ptr() patches to be first with lynxpoint commit message updated
- fixed wording in the pm.h comment
- amended cherryview to wrap long line
- explained __maybe_unused and pm_ptr() changes in at91 commit message
- added pm_sleep_ptr() and explained that in the tegra commit message
- renesas and mvebu went as is
- intel and mediatek left aside for better rework

 drivers/pinctrl/intel/pinctrl-baytrail.c    | 11 +++--------
 drivers/pinctrl/intel/pinctrl-cherryview.c  | 10 +++-------
 drivers/pinctrl/intel/pinctrl-lynxpoint.c   |  7 +++----
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 14 +++-----------
 drivers/pinctrl/pinctrl-at91.c              | 10 ++++------
 drivers/pinctrl/renesas/core.c              | 16 +++++++---------
 drivers/pinctrl/tegra/pinctrl-tegra.c       |  5 +----
 drivers/pinctrl/tegra/pinctrl-tegra210.c    |  2 +-
 include/linux/pm.h                          |  9 +++++++++
 9 files changed, 34 insertions(+), 50 deletions(-)


-- 
With Best Regards,
Andy Shevchenko


