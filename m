Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFBD7FD462
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjK2Khc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjK2KhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:37:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765E42700;
        Wed, 29 Nov 2023 02:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701254213; x=1732790213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ikdfcRthHSVHK5eH0ftRbdlFQHawb8smszowG2uXl14=;
  b=L7CM9PcRD4CIe1AIag0ldMZA//itcwF/wdc47z7wTu7vkvYC1SWv0XKn
   JPU6kBE9K1hi0UoTORdpsy1Zk0ylCiIofhwXSxeiFwelLzC69RXaCpzjT
   ldCslfb5OCKG3ZL9LvM9LSu1/EJcKxI5eaHW2/H+uQfC9o8Jx5pDHrf3c
   HUv4zn1MvcfMN0oKR3OMFDrqbfeFHeiuPKX51QgjtTCciVEGP710EJvz9
   oQYqYqpCIhDYG2ufz1Xz3YOOj0FKnnqhJ6793o/b6nnIkTs5+Q131KwIe
   OOGwiM5gZy3pGnz6z6cuXvHvFR4qik4w65FC0WSDJdCAvurFa7UKGShZY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6355889"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="6355889"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:36:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="745217778"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="745217778"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:36:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8Hvy-00000000Pte-3znv;
        Wed, 29 Nov 2023 12:36:46 +0200
Date:   Wed, 29 Nov 2023 12:36:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <ZWcUPkzfGqxYsysp@smile.fi.intel.com>
References: <20231129070452.1521-1-petre.rodan@subdimension.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129070452.1521-1-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:04:49AM +0200, Petre Rodan wrote:
> Adds driver for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors.
> Communication is one way. The sensor only requires 4 bytes worth of
> clock pulses on both i2c and spi in order to push the data out.
> The i2c address is hardcoded and depends on the part number.
> There is no additional GPIO control.

Thank you for an update!

Much better now, only one important thing is left unaddressed, see below.

...

> +	if (strncmp(triplet, "NA", 2) == 0) {

str_has_prefix()

...

> +		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
> +			if (strncmp(hsc_range_config[index].triplet,
> +				    triplet,
> +				    HSC_PRESSURE_TRIPLET_LEN - 1) == 0) {
> +				hsc->pmin = hsc_range_config[index].pmin;
> +				hsc->pmax = hsc_range_config[index].pmax;
> +				found = 1;
> +				break;
> +			}
> +		}
> +		if (hsc->pmin == hsc->pmax || !found)
> +			return dev_err_probe(dev, -EINVAL,
> +				"honeywell,pressure-triplet is invalid\n");

This one is important. I think I told already twice that this is NIH
device_property_match_property_string(). Please, use this API directly.

...

> +	tmp = div_s64(((s64)(hsc->pmax - hsc->pmin)) * MICRO,
> +		      hsc->outmax - hsc->outmin);
> +	hsc->p_scale = div_s64_rem(tmp, NANO, &hsc->p_scale_dec);
> +	tmp = div_s64(((s64)hsc->pmin * (s64)(hsc->outmax - hsc->outmin)) *
> +		      MICRO, hsc->pmax - hsc->pmin);

I would leave MICRO on the previous line for better understanding the code.

...

> +#ifndef _HSC030PA_H
> +#define _HSC030PA_H

> +#include <linux/mutex.h>

> +#include <linux/property.h>

Is not used here.

> +#include <linux/types.h>

...

> +/*
> + * get all conversions (4 bytes) in one go
> + * since transfers are not address-based
> +*/

Missing space at the last line and missing capitalization and grammar period.

...

> +int hsc_common_probe(struct device *dev, void *client,
> +	hsc_recv_fn recv_fn, const char *name);

Indentation is unusual on the second line, also you can use just "recv" as
parameter name. But both are minor and I leave them to you and maintainer.

...

> +static const struct of_device_id hsc_spi_match[] = {
> +	{.compatible = "honeywell,hsc030pa"},

I believe Jonathan asks for inner spaces, like { ...foo... }.

> +	{}
> +};

...

> +static const struct spi_device_id hsc_spi_id[] = {
> +	{"hsc030pa"},

Ditto.

> +	{}
> +};

-- 
With Best Regards,
Andy Shevchenko


