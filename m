Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C507729DA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjHGPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHGPx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:53:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228EDF0;
        Mon,  7 Aug 2023 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691423609; x=1722959609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+UzN1I+zo6325mqToFRf2BWfOYgOdV+CV3FDUEYzuF8=;
  b=Mt89/nP+hmLIsh+4nklMCFxQhPf1cHpDhiuUcrIyE/tlBTvrkOSNVbdy
   LO9RH7TT0QZcyo2MPmoZHff2HVZC4C3hZFcYDZJqZORJOhLHX8a3JgDys
   CuXyLzU/GmvHcoxDpUDBqwQRvjL9bdz/ckym3vkVrnes2MRa1irTPVJ9A
   rliVAsUksZgU4mKw46IHcpDtwoOV4AKJHL1JH9PIN6LmpQhDKJ5uHVsKN
   n87PRN6Plud17lWzeAB91QOkwSHatIWIonk50aJQMhfCGihOVZcgUpOZS
   17h/dJv/5ZDdKif+qde48PWyIN/BGmgvaC+HpUonFoWnir7sjSVnINYhJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="436910322"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="436910322"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="800982081"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="800982081"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2023 08:53:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT2Xp-000eEK-2q;
        Mon, 07 Aug 2023 18:53:21 +0300
Date:   Mon, 7 Aug 2023 18:53:21 +0300
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
Subject: Re: [PATCH v3 2/2] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZNETcVNsEmvK0KKH@smile.fi.intel.com>
References: <20230807071831.4152183-1-marcus.folkesson@gmail.com>
 <20230807071831.4152183-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807071831.4152183-2-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 09:18:31AM +0200, Marcus Folkesson wrote:
> Microchip does have many similar chips, add support for those.
> 
> The new supported chips are:
>   - microchip,mcp3910
>   - microchip,mcp3912
>   - microchip,mcp3913
>   - microchip,mcp3914
>   - microchip,mcp3918
>   - microchip,mcp3919

...

> +#define MCP3910_STATUSCOM_DRHIZ         BIT(20)

Is it deliberately using spaces? If so, why?

...

> +static int mcp3910_get_osr(struct mcp3911 *adc, int *val)
> +{
> +	int ret, osr;
> +
> +	ret = mcp3911_read(adc, MCP3910_REG_CONFIG0, val, 3);

> +	osr = FIELD_GET(MCP3910_CONFIG0_OSR, *val);
> +	*val = 32 << osr;
> +	return ret;

I believe this is wrong order. Or bad code. The rule of thumb is not pollute
the output variable if we know the error happened.

Same applies to another function.

> +}

...

> -	ret = mcp3911_config(adc);
> +	ret = device_property_read_u32(&adc->spi->dev, "microchip,device-addr", &adc->dev_addr);

Why not spi->dev? Ditto for other uses like this.

-- 
With Best Regards,
Andy Shevchenko


