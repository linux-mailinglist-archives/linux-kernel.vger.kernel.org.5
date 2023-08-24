Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859E3786E85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbjHXLzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbjHXLzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:55:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D91F198B;
        Thu, 24 Aug 2023 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692878144; x=1724414144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EtMJWCpQgqm1YfQxm3Dui0oxAoD0oovwXpijZ/43xVc=;
  b=LeL29O3tJ8rZvP/qmckq19+xGh0vpYkoBbH63V5fNE7SpuIqTePvAg6u
   ly3FbKPKnrEkBx2bJAiO1mz85Tn04vn6TaE6KbjbNgmLrCtGZEi4xvN6q
   hqztDAXjoKZMlxfFsOYpXleW+p0IFpejYua0r+0unxbKhLMtEJ7WVkvCl
   Ay8U6368dXyyXuoN6dVasCoiHain+tXwdnyjVod+CO2tiWen+HrLpIHeX
   YzibTKqRF3Wst6GJE4co0H7R+TpN7DuQkmhWiyZ65uh8r5RwgHeFiD0vt
   Hf/Va5Ij0Enjhh8GILmkYwKqCViYJlXnhws2npWqSLXoRuwJKcvDFVlUx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="359402107"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359402107"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="827095503"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827095503"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2023 04:55:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZ8w7-002A2V-0j;
        Thu, 24 Aug 2023 14:55:39 +0300
Date:   Thu, 24 Aug 2023 14:55:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZOdFOobezrVoMYJn@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <8ff0761f3912491d1d31f2f096e24423ad04140b.1692824815.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff0761f3912491d1d31f2f096e24423ad04140b.1692824815.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:16:39PM +0200, Mehdi Djait wrote:
> Add the chip_info structure to the driver's private data to hold all
> the device specific infos.
> Refactor the kx022a driver implementation to make it more generic and
> extensible.

...

> +	chip_info = device_get_match_data(&i2c->dev);
> +	if (!chip_info) {
> +		const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
> +
> +		chip_info = (const struct kx022a_chip_info *)id->driver_data;
> +		if (!chip_info)
> +			return -EINVAL;
> +	}

There is a new API for that, please use it.

...

> +/* kx022a Regmap configs */

regmap

...

>  		irq = fwnode_irq_get_byname(fwnode, "INT2");
>  		if (irq <= 0)

= 0 case is fixed now, means should never appear here,
but it's a material for another, separate change.

>  			return dev_err_probe(dev, irq, "No suitable IRQ\n");

-- 
With Best Regards,
Andy Shevchenko


