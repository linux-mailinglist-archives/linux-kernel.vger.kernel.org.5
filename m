Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77A47F187B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjKTQVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKTQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:21:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24979ED;
        Mon, 20 Nov 2023 08:21:15 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371825473"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="371825473"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 08:21:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="836767261"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="836767261"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 08:21:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1r571G-0000000Fb43-06bt;
        Mon, 20 Nov 2023 18:21:06 +0200
Date:   Mon, 20 Nov 2023 18:21:05 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH v4 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <ZVuHcaUQL6xnchK-@smile.fi.intel.com>
References: <20231116134655.21052-1-user@HYB-hhAwRlzzMZb>
 <20231116134655.21052-2-user@HYB-hhAwRlzzMZb>
 <ZVtYeWZmcDZ_SMPo@smile.fi.intel.com>
 <5cf3824f-6375-4c76-86ff-c5389ddf4196@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf3824f-6375-4c76-86ff-c5389ddf4196@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:55:12PM +0200, Ceclan Dumitru wrote:
> On 11/20/23 15:00, Andy Shevchenko wrote:
> > On Thu, Nov 16, 2023 at 03:46:55PM +0200, mitrutzceclan wrote:

...

> >> +struct ad7173_channel_config {
> >> +	bool live;
> >> +	u8 cfg_slot;
> >> +	/* Following fields are used to compare equality. Bipolar must be first */
> >> +	bool bipolar;
> >> +	bool input_buf;
> >> +	u8 odr;
> >> +	u8 ref_sel;
> > 
> > If you group better by types, it might save a few bytes on the architectures /
> > compilers where bool != byte.
> >
> Grouping by type will result in not being able to use memcmp() for
> comparing configs. But then there is the issue that I was under the
> assumption that bool=byte. If that is not the case, the config equality
> check might be comparing padding bytes.

It's most likely the case, BUT... it is not guaranteed by the C standard.

> In this case what do you suggest:
> - using the packed attribute
> - using only u8
> - drop memcmp, manually compare fields

Use struct_group() to show explicitly the group of members. If it's not an ABI
in any sense, then memcmp() is fine.

...

> >> +	cmp_size = sizeof(*cfg) - offset;
> > 
> > sizeof_field() from the above mentioned header?
> 
> This computes the size of multiple fields, following cfg_slot. Better to
> group the fields that need to be compared into another struct then use
> sizeof_field()?

See above.

...

> >> +	return vref / (MICRO/MILLI);
> > 
> > What does the denominator mean and why you can't simply use MILL?
> 
> Original vref values are in micro, I considered that it was adequate to
> represent the conversion from MICRO to MILLI as a fraction.
> 
> >> +		*val = st->info->sinc5_data_rates[reg] / (MICRO/MILLI);
> >> +		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO/MILLI);
> > 
> > Same Q about denominator.
> > 
> Here, a misunderstanding on my part of a suggestion from Jonathan in V2,
> will be removed.

You need to clarify with him that.

-- 
With Best Regards,
Andy Shevchenko


