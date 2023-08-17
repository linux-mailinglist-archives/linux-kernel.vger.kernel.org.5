Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFC77F6B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350957AbjHQMsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351000AbjHQMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:48:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917D32D72;
        Thu, 17 Aug 2023 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692276494; x=1723812494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MjBfQN3jOFuXOD6P2yNP6VXz41MVbn2o5Ripo0GN4xc=;
  b=NGm0BgRWUPSur4BY2lRy1Z82HDTTaLVRxv4jilZpqJN6WYrKJkYkaA61
   1krKDtbInDQBOTUTRgDHd93q5TvzGsN2NjbQT4uRdbScLUAAb+WVq05G6
   +7gp7rhxcid7RA6VkT9oSb+CC0tsAKlyFj05xYi5gTvrTEanGzvM4P40b
   liqcjW/HXIiWMzBc7vWi+z3p9gCkmx6q1Sqmx9bTS93RIWCm+jHPBD8RV
   Py1bM29BFQQUMqOD/wmo6kVc1HOVL3pJw5vvirxA8aEt9n9w7AVMR4nLx
   +sCTeLs/6GSYquop4D2+5FW9LmM6Edrc64ecOVMSqlplYM8uDWSh9IGQj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="459156560"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="459156560"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878217235"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2023 05:48:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWcQ3-00C2H1-1A;
        Thu, 17 Aug 2023 15:48:07 +0300
Date:   Thu, 17 Aug 2023 15:48:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/6] iio: adc: mcp3911: simplify usage of spi->dev
Message-ID: <ZN4XBzoIwjC5V5Pv@smile.fi.intel.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
 <20230817120518.153728-3-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817120518.153728-3-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:05:15PM +0200, Marcus Folkesson wrote:
> Replace the usage of `adc->spi->dev` with `dev` to make the code prettier.

...

> @@ -277,9 +278,7 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)

>  		ret = regulator_get_voltage(adc->vref);
>  		if (ret < 0) {
> -			dev_err(&adc->spi->dev,
> -				"failed to get vref voltage: %d\n",
> -			       ret);
> +			dev_err(dev, "failed to get vref voltage: %d\n", ret);

So, this can be part of the previous patch as this function is the part of the
->probe() stage.

>  			return ret;
>  		}

...

> @@ -396,12 +395,10 @@ static int mcp3911_config(struct mcp3911 *adc)
>  	if (ret)
>  		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
>  	if (adc->dev_addr > 3) {
> -		dev_err(&adc->spi->dev,
> -			"invalid device address (%i). Must be in range 0-3.\n",
> -			adc->dev_addr);
> +		dev_err(dev, "invalid device address (%i). Must be in range 0-3.\n", adc->dev_addr);
>  		return -EINVAL;

Ditto.

>  	}

...

> +		adc->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						   indio_dev->name,
> +						   iio_device_id(indio_dev));

Seem you already switched to longer lines, hence this can be compressed
to two lines.

>  		if (!adc->trig)
>  			return -ENOMEM;

...

> +		ret = devm_request_irq(dev, spi->irq,
> +				       &iio_trigger_generic_data_rdy_poll,

In the similar way as above.

> +				       IRQF_NO_AUTOEN | IRQF_ONESHOT,
> +				       indio_dev->name, adc->trig);
>  		if (ret)
>  			return ret;


-- 
With Best Regards,
Andy Shevchenko


