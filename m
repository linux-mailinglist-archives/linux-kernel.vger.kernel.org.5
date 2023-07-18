Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC89757E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjGRNvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGRNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:51:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA93E5;
        Tue, 18 Jul 2023 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689688308; x=1721224308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ek4HQDqASP1346ScIwRLDWKoFoS68Rokb5r5BxIupU=;
  b=D9pzTJmiotiBgdPXEw+LM9Hoo0YTi4nWzttl9/AS+vDDdb9jgfZpzWlx
   KC0A5O7oeAkDP9eptyFwDuTFh9lB+yPa8X5wRr26lF/J3tdxkuVpNMDJt
   lhPNJ1JsXqjH80ZULlvU0FwWQd/0i6bQQe1o82p0EMUbTlglujlXXM0w2
   LBxjqx7B6HoE1Hf9QDMCoNT7VD1c4CrfHPGLPtJyX3nKfK/XzyGVFuT81
   dAV/5PCmZhFGOZ5G2AHYGEtl+Rv5v7RsGQzulo9KDOAWSXPB63CSd82UM
   KhlpsTnFxv+Qo8PmkqGTT2DzFFdiPSUbUMRzRIdhDi5Ajc3VQpF101Zlw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345803138"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345803138"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847707771"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847707771"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2023 06:51:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLl74-00FrDv-32;
        Tue, 18 Jul 2023 16:51:38 +0300
Date:   Tue, 18 Jul 2023 16:51:38 +0300
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
Subject: Re: [PATCH v2 03/10] pinctrl: cherryview: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
Message-ID: <ZLaY6vAahWPatEIV@smile.fi.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-4-andriy.shevchenko@linux.intel.com>
 <20230718105453.00004dc3@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718105453.00004dc3@Huawei.com>
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

On Tue, Jul 18, 2023 at 10:54:53AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Jul 2023 20:28:14 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

...

> > + static DEFINE_NOIRQ_DEV_PM_OPS(chv_pinctrl_pm_ops, chv_pinctrl_suspend_noirq, chv_pinctrl_resume_noirq);
> 
> Very long line and readability not hurt by breaking it.

Sure.

-- 
With Best Regards,
Andy Shevchenko


