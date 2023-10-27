Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0449B7D96FF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbjJ0Lx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345783AbjJ0Lxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:53:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0EFC0;
        Fri, 27 Oct 2023 04:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698407632; x=1729943632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yAWlPgimqmg3JNcrg00oJ4He6AAR6VZ3gQfthjQSD9g=;
  b=ZKyRhVaCmqSf5BbLqMl4ktSoqjYafzXarOUmwW0X8kejBIGIQCo9+apU
   ESufCarDbxssty1O5oSJG3jXnbHoc/9b8NaB5e0s8WI5c3a9Ow48jgboY
   IWUoLu/vlgS7gmY6K8UI6v47DQ/2I7bnM+mBkrAUpqafzKgW1sK1ROihL
   Xencz+Fi9Wckx6YGfUcoGJm6BsTZY/+I5nWKkx9pXBB4/XbPNbzvAZAwz
   KKQh6vU6TNc0y8RzZiSOmFa14/u/tGBo4m2HFBkihD296WKtUkP3tn3dV
   ZufmXUBP18/Dpk9K4tmi7PB9RT0mCerZu/mhlv2bl4JvezttHiLo7MnbW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="552749"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="552749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="850225868"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="850225868"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:53:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qwLIZ-000000098KG-0oqS;
        Fri, 27 Oct 2023 14:46:43 +0300
Date:   Fri, 27 Oct 2023 14:46:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Stoll, Eberhard" <eberhard.stoll@kontron.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Eberhard Stoll <estl@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Schrempf, Frieder" <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: AW: [PATCH 1/4] spi: Add parameter for clock to rx delay
Message-ID: <ZTujIs2O+GYKIPlU@smile.fi.intel.com>
References: <20231026152316.2729575-1-estl@gmx.net>
 <20231026152316.2729575-2-estl@gmx.net>
 <20231027005643.4b95f17e@xps-13>
 <DB9PR10MB82468A8BD333B12D3FCB3C43F1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB82468A8BD333B12D3FCB3C43F1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 08:38:54AM +0000, Stoll, Eberhard wrote:

...

> > Can you be more specific? I am wondering how big the need is.
> 
> In our case it's a QSPI NAND chip (Winbond W25N02KV). This device
> can operate at 104MHz SPI clock. But it also has a tCLQV value of 7ns.
> The tCLQV value limits the SPI clock speed for this device to 2x7ns
> (if it is not adjustable in the SPI controller) which is approximately
> 70MHz.
> 
> Without the ability to set the tCLQV value, the SPI clock has to be
> limited to 70MHz in device tree for this bus.
> 
> In our case the Winbond W25N02KV chip is a replacement of an
> older chip. The older chip can operate at 104MHz and does not
> have the tCLQV restrictions as this new one.
> The new chip is mostly is better than the data sheet and meet the
> timing requirements for 104MHz. But on higher temperatures
> devices fail.
> 
> In device tree QSPI NAND chips are configured by a compatible
> property of 'spi-nand'. The mtd layer detects the real device
> and fetches the properties of this device from the appropriate
> driver.
> 
> So for our case (boards containing the old and new chip) we well
> have to reduce the SPI clock for the entire QSPI bus to 70MHz, even
> for the elder chips which can operate well also with 104MHz. 

So, to me sounds like device tree source issue. I.e. you need to provide
different DT(b)s depending on the platform (and how it should be).
The cleanest solution (as I see not the first time people I trying quirks like
this to be part of the subsystems / drivers) is to make DT core (OF) to have
conditionals or boot-time modifications allowed.

This, what you are doing, does not scale and smells like an ugly hack.

-- 
With Best Regards,
Andy Shevchenko


