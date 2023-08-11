Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D58D778A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjHKJq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjHKJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:46:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBC12728;
        Fri, 11 Aug 2023 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691747184; x=1723283184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GfM6LFRnkm8QU2AlvTqOJ4q6NoQlTqqbu9cz4ujRsCY=;
  b=FpeTja50Wb8B9n9sghwl09hGSiRz8DiSVaTn0noE2VT+ZqcGFBCMs0KQ
   9yhInJfgcq6fy3wXAOqwaZYrRx6IWchzUSka4l4dVtnOgPqnvy80Zi2Rq
   MWxDqnmQKcXDeVpUKKQwqz7jswn/dycxGcF6PlHdEFHX5HryqvWY1+Tgb
   U74qOWQ/DktElCGX6Qd3Ns3SFJR4VCWSDQBRiwaW3fXsYR6HmyWgNjOYZ
   np54sZSq/VZmkh6hcjBAqn/8q8HyVRVHAESVVu1azhxwasfKfsqkhztPY
   MySdrAGC7St8bzxFUBeb+fPdu4iK4UnmLtdcV267nPzq5udIxJE0GzPr9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369111748"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="369111748"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="979184854"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="979184854"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2023 02:46:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUOip-009A3Y-35;
        Fri, 11 Aug 2023 12:46:19 +0300
Date:   Fri, 11 Aug 2023 12:46:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZNYDa+Un5bl5y9vT@smile.fi.intel.com>
References: <cover.1691607526.git.mehdi.djait.k@gmail.com>
 <8fb74f21bda4949a862bcb4bb1ed4f0acb135948.1691607526.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb74f21bda4949a862bcb4bb1ed4f0acb135948.1691607526.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:11:36PM +0200, Mehdi Djait wrote:
> Add the chip_info structure to the driver's private data to hold all
> the device specific infos.
> Refactor the kx022a driver implementation to make it more generic and
> extensible.

...

> +	chip_info = device_get_match_data(&i2c->dev);
> +	if (!chip_info) {
> +		const struct i2c_device_id *id = i2c_client_get_device_id(i2c);

Missing blank line.

> +		chip_info = (const struct kx022a_chip_info *)id->driver_data;
> +		if (!chip_info)
> +			return -EINVAL;
> +	}

...

> -	if (val > KX022A_FIFO_LENGTH)
> -		val = KX022A_FIFO_LENGTH;
> +	val = min_t(unsigned int, data->chip_info->fifo_length, val);

min_t() is a beast. Please, use min() if no special requirement for
min_t() here, otherwise explain why.

...

> +	data->fifo_buffer = kmalloc(data->chip_info->fifo_length *
> +				    KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);

kmalloc_array()

> +	if (!data->fifo_buffer)
> +		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


