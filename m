Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5067B66A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjJCKpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjJCKpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:45:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187AAAC;
        Tue,  3 Oct 2023 03:45:10 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362215516"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="362215516"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 03:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="786058702"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="786058702"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 03:45:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andy@kernel.org>)
        id 1qnctg-00000002SXq-1k5x;
        Tue, 03 Oct 2023 13:45:00 +0300
Date:   Tue, 3 Oct 2023 13:45:00 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Ceclan Dumitru-Ioan <mitrutzceclan@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <ZRvwrDcT770sJXkd@smile.fi.intel.com>
References: <20230928125443.615006-1-mitrutzceclan@gmail.com>
 <20230928125443.615006-2-mitrutzceclan@gmail.com>
 <20230930150531.083c51d4@jic23-huawei>
 <c52afe87-eaa0-eb7f-090f-b22aec95e49d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c52afe87-eaa0-eb7f-090f-b22aec95e49d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 01:33:36PM +0300, Ceclan Dumitru-Ioan wrote:
> On 9/30/23 17:05, Jonathan Cameron wrote:
> > On Thu, 28 Sep 2023 15:54:43 +0300
> > Dumitru Ceclan <mitrutzceclan@gmail.com> wrote>> +config AD7173
> >> +	tristate "Analog Devices AD7173 driver"
> >> +	depends on SPI_MASTER
> >> +	select AD_SIGMA_DELTA
> >> +	select GPIO_REGMAP
> > If you are selecting it, why does it have if guards in the driver.
> > I prefer the select here, so drop this if guards.
> 
> From what i checked, selecting GPIO_REGMAP does not select GPIOLIB but only REGMAP.
> 
> Also, in the thread from V1 Arnd Bergmann suggested:
> 	" I think the best way to handle these is to remove both
> 	 the 'select' and the #ifdef in the driver and instead use
> 	 'if (IS_ENABLED(CONFIG_GPIOLIB))' to handle optional gpio
> 	 providers in the code. "

Why not simply to be dependent on GPIOLIB like other drivers do in this folder?


-- 
With Best Regards,
Andy Shevchenko


