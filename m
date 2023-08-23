Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F38785D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjHWQ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjHWQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:26:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F9BE68;
        Wed, 23 Aug 2023 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692807974; x=1724343974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uh40LslCjNWpAlM1qtjuXk8TRQEreFpGEUbxgUCgHFM=;
  b=aZEOiUylEelIEgIx6urGXdQ9Z5tax7rvEWI/G3/MNqLeZocQz0I24DZl
   NKh5uJ1fn3Fbymd77V2iBmEs0RWNUD44cUayZtgYwke+VHrBNAWMmziXn
   dMRcXYhEqBebF2DBHVbdrs4Lu2hmaB7YEZo8pUxiNFF9+GgQMq0wVv03U
   Jawg1wylVfwwH+DBnQ1nck5B7CrrbXvgeoCUSaI1z5lc4+kvqx6eoHzLu
   dsQWzOSjEnLPfM9Lvmdd887MSNowv+GmyzIhcJaCb5pmhEcx4KSsxLipl
   W1YkOWwbzXLakoOXAdlu2DiBiqcUKyELfnbdpPidEUYw+DtIwbPMVAZhl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="376933148"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="376933148"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="826791632"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="826791632"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2023 09:26:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYqgM-00FI6w-2p;
        Wed, 23 Aug 2023 19:26:10 +0300
Date:   Wed, 23 Aug 2023 19:26:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Allow multiple chips id
 per family of devices
Message-ID: <ZOYzIvrvZGjQldDe@smile.fi.intel.com>
References: <cover.1692805377.git.ang.iglesiasg@gmail.com>
 <7bdfbfeb106acc5560e6cb090131f105b2d2e418.1692805377.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bdfbfeb106acc5560e6cb090131f105b2d2e418.1692805377.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 05:58:06PM +0200, Angel Iglesias wrote:
> Improve device detection in certain chip families known to have various
> chip ids.

IDs

...

>  #include <linux/completion.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
> +#include <linux/overflow.h>

Please, preserve ordering.

...

>  	struct bmp280_data *data;
>  	struct gpio_desc *gpiod;
>  	unsigned int chip_id;
> -	int ret;
> +	int ret, i;

	unsigned int i;

...

> +	if (i == data->chip_info->num_chip_id) {
> +		size_t nbuf;
> +		char *buf;
> +
> +		// 0x<id>, so four chars per number plus one space + ENDL

> +		if (check_mul_overflow(5, data->chip_info->num_chip_id, &nbuf))
> +			return ret;
> +
> +		buf = kmalloc_array(nbuf, sizeof(char), GFP_KERNEL);

We almost never do a array allocation for byte sizes. Instead of the above you
need to use

		buf = kmalloc_array(data->chip_info->num_chip_id, 5, GFP_KERNEL);

> +		if (!buf)

This check assumes that num_chip_id is never 0, so...

> +			return ret;
> +
> +		for (i = 0; i < data->chip_info->num_chip_id; i++)
> +			snprintf(&buf[i*5], nbuf, "0x%x ", data->chip_info->chip_id[i]);

> +		buf[nbuf-1] = '\0';

...this is redundant assignment. sprintf() guarantees the NUL termination.

> +
> +		dev_err(dev, "bad chip id: expected [ %s ] got 0x%x\n", buf, chip_id);

"...expected one of..."

> +		kfree(buf);
> +		return ret;

Oh, I didn't get that you allocated memory only to print a message...


>  	}

-- 
With Best Regards,
Andy Shevchenko


