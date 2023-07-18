Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8468F757E53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGRNzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjGRNzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:55:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A3D135;
        Tue, 18 Jul 2023 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689688543; x=1721224543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V7uObewKKMsSFKcANEcQ6EZsbUKYMZQzdkpGT+xME/c=;
  b=iQsKPcpXfE/c07KBnfQ2BDwNCXr+4+nFDCXSq6yK/qVIn5XJR6KVxx0y
   9qcRJ999as8l0YPJP2h7nkjxe7YVNW5b6mlvW4v3GPw/IcXr8Sggd1dEP
   mCoOiJRYdpJVEtHPzCw2MnKua6uQhjWqY5pSTpOMkzvTDJQ2qp57Dck8d
   dGFBPxbvAUEsEw8REH8lABAOqE9DQYrWShk8H4TuFYioAHPkmSEyzgvZl
   O1UwFbe4bGSfsXAnvP1N9IV8FhYBjbzp6Jn0NJcjqOtZ0ARYgp9N9IzIH
   0cA/Vh/WbP5MipJdvdUFyHjIILtHZBUAKDsIUpYs/2V6hN2xLVRRJaBuP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345803877"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345803877"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="793630354"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="793630354"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2023 06:55:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLlAr-00FzOP-0Z;
        Tue, 18 Jul 2023 16:55:33 +0300
Date:   Tue, 18 Jul 2023 16:55:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
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
        linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sean Wang <sean.wang@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 05/10] pinctrl: lynxpoint: Make use of pm_ptr()
Message-ID: <ZLaZ1NLcACjqB02i@smile.fi.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-6-andriy.shevchenko@linux.intel.com>
 <20230718110620.0000218e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718110620.0000218e@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:06:20AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Jul 2023 20:28:16 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Cleaning up the driver to use pm_ptr() and *_PM_OPS() macros that
> > make it simpler and allows the compiler to remove those functions
> > if built without CONFIG_PM and CONFIG_PM_SLEEP support.

> Those macros

I believe you meant here "The SYSTEM_SLEEP... macro..."

Or is runtime PM also altered? Hmm...

> add a load more callbacks... Whilst that may well be fine,
> you should definitely mention that in this patch description.

Sure.

-- 
With Best Regards,
Andy Shevchenko


