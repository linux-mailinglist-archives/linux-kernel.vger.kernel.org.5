Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EE4786E94
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbjHXL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbjHXL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:58:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82295198B;
        Thu, 24 Aug 2023 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692878285; x=1724414285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bAYzHLuFAeGqKxkWSClnB0qv/1uootV3ro6JSV7uZfc=;
  b=IX4Tq+5lsQINYeS6HnLhSvyUhzvexRP9DRBD0hgl9B+9BKoOvnFIFvWi
   mJuKgEXFtNfyu3BJfk7TJHMbCpiPZOjrY/sJK3BnbMDUXzHtDNJL/UofR
   5TT0SLrmsWLqAoYvVwQTEhQbN8Rw8rikGHZR9+ss/j3RkIFFRW2BXRPBD
   hCMGezduV3ZiIWqS00ilmSjjpBxXIEhgzg+ZI+TqQke4Ny6jrYEFpLi2Y
   pTCLzUtN2TOEPAHzXz1nLa/sHqaXrePSCcBLiMWCcQlmp+Ut8PKR0UYeV
   DWKa4hoekRBYaXzLPpTsLNbHAi2aJzqxJkHLfuUPipOH/YzIvL7yEdlnF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="354747632"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354747632"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="807103087"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="807103087"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2023 04:58:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZ8yP-002FA2-0H;
        Thu, 24 Aug 2023 14:58:01 +0300
Date:   Thu, 24 Aug 2023 14:58:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <ZOdFyKHBc6BcOgZw@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:16:40PM +0200, Mehdi Djait wrote:
> Since Kionix accelerometers use various numbers of bits to report data, a
> device-specific function is required.
> Implement the function as a callback in the device-specific chip_info structure

...

> +	int ret, fifo_bytes;
> +
> +	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> +	if (ret) {
> +		dev_err(data->dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
> +		return KX022A_FIFO_MAX_BYTES;
> +
> +	return fifo_bytes;

This will be called each time ->get_fifo_bytes() called.
Do you expect the fifo_bytes to be changed over times?
Shouldn't we simply cache the value?

...

> +	fifo_bytes = data->chip_info->get_fifo_bytes(data);

>  

Now this blank line becomes redundant.

>  	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
>  		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");


-- 
With Best Regards,
Andy Shevchenko


