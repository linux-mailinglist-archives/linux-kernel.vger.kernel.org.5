Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C762F757E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjGRNxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjGRNxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:53:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C251D99;
        Tue, 18 Jul 2023 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689688419; x=1721224419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ophA10kUFzoNAqizRgztDPJPsGfNIY1vmJXIIYiDlc=;
  b=Y8YvhyqVPA1qHR0TnpJUsZPlfS/Dd9z2AnZMrJblXfFFm3Iqwrb6pU9l
   WkPMHCN56uK0gyw6B2wVRoV2Q3rLPPzSI/xrpqI+BhQQUv8GnZT65HXOX
   JKt2Dajs03neBM+4dCXxeXBpfEBY3fidyl1SArrQJc2oGVbKl70XLY+F+
   WGlTTHueeI7if3U3Evz8DZ58k4i5wkBQ/jQ3pYA+SNxHTCfI/7jfjmvX2
   vWRpyNwMm/q73Ay4UpzzItnZ+LFXHFw6Nam58SxFZGZNTD47Y+HfAvRVt
   FNrabsyTfCiLI3SkDoir3sBSs6XOauXzKmeVyA1zyLWYLN4A9iWSFLcEX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345803481"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345803481"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847708035"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847708035"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2023 06:53:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLl8r-00Fuul-36;
        Tue, 18 Jul 2023 16:53:29 +0300
Date:   Tue, 18 Jul 2023 16:53:29 +0300
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
Subject: Re: [PATCH v2 04/10] pinctrl: intel: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
Message-ID: <ZLaZWcyJAnQMK87f@smile.fi.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-5-andriy.shevchenko@linux.intel.com>
 <20230718110451.00001227@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718110451.00001227@Huawei.com>
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

On Tue, Jul 18, 2023 at 11:04:51AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Jul 2023 20:28:15 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> >  EXPORT_SYMBOL_GPL(intel_pinctrl_resume_noirq);
> 
> Can you check if this is successfully removed?  I think it won't be.
> Not immediately obvious how to tidy that up given these are used
> in a macro called from lots of drivers.

That's what Paul noticed I think with his proposal to export only the ops
variable and make these to be static.

> Maybe just leaving the ifdef is best we can do here.

See above.

-- 
With Best Regards,
Andy Shevchenko


