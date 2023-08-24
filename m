Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965FB786EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbjHXMD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbjHXMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:02:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E41993;
        Thu, 24 Aug 2023 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692878566; x=1724414566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7l+45aZuDPCBqNHBG172GCHD6wE4+ZCgsf7zR7CryYw=;
  b=Twdgx734olgG1bPRJiIc1bk5APn/d09ORdV3f+EPmZNPI70f6qYLSWII
   jltp59JcNKf7KGMxytU8t+ZMU1Tr9STjVWgRoKnedqm3WawxwDRdWC/z9
   AqqdU/e/m7W/POFxDt7MWXDOYWeG+/ynQ95SoVdSOLdnQW2vVSgl3L6eV
   IACTDdF7hqxd51dwadVC1pArKIfnRDa74xwsQHs8WsvgvJ2eivL0Xm3K5
   XEk4Vu3+HTB0lQOhluNaHY7VIqW4q2hl0YMNlzCFDMhuflZWTCoZMYAki
   oiBt3XwtQg1+xH/y44+wmD/MZbJIqc3P9le22P1GmSijyTy7qEOYqnY3K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="371825530"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="371825530"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="1067796099"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1067796099"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2023 05:02:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZ92l-002OWW-1H;
        Thu, 24 Aug 2023 15:02:31 +0300
Date:   Thu, 24 Aug 2023 15:02:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 7/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <ZOdG1wFo892bJU53@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <c41ed69af6432298cbd82896328333f31d41dda0.1692824815.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c41ed69af6432298cbd82896328333f31d41dda0.1692824815.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:16:41PM +0200, Mehdi Djait wrote:
> Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> ranges from ±2G to ±16G, digital output through I²C/SPI.
> Add support for basic accelerometer features such as reading acceleration
> via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.

...

>  	help
> -	  Enable support for the Kionix KX022A digital tri-axis
> -	  accelerometer connected to I2C interface.
> +	  Enable support for the Kionix KX022A, KX132-1211 digital tri-axis
> +	  accelerometers connected to SPI interface.

I know I have given a tag, but since it most likely require a new version,
this can be amended for the better maintenance as

	  Enable support for the Kionix digital tri-axis accelerometers
	  connected to SPI interface. Supported devices are:
	    KX022A, KX132-1211

...

>  	help
> -	  Enable support for the Kionix KX022A digital tri-axis
> -	  accelerometer connected to I2C interface.
> +	  Enable support for the Kionix KX022A, KX132-1211 digital tri-axis
> +	  accelerometers connected to I2C interface.

Ditto.

...

> +static const struct regmap_access_table kx132_volatile_regs = {
> +	.yes_ranges = &kx132_volatile_ranges[0],


This should be the same as

	.yes_ranges = kx132_volatile_ranges,

> +	.n_yes_ranges = ARRAY_SIZE(kx132_volatile_ranges),
> +};

Ditto for the following.

> +static const struct regmap_access_table kx132_precious_regs = {
> +	.yes_ranges = &kx132_precious_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx132_precious_ranges),
> +};

> +static const struct regmap_access_table kx132_ro_regs = {
> +	.no_ranges = &kx132_read_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(kx132_read_only_ranges),
> +};

> +static const struct regmap_access_table kx132_wo_regs = {
> +	.no_ranges = &kx132_write_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(kx132_write_only_ranges),
> +};

> +static const struct regmap_access_table kx132_nir_regs = {
> +	.yes_ranges = &kx132_noinc_read_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx132_noinc_read_ranges),
> +};

-- 
With Best Regards,
Andy Shevchenko


