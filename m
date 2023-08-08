Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4A7741CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjHHR2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjHHR2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:28:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B08120D31;
        Tue,  8 Aug 2023 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691511129; x=1723047129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a5Pu3te7+j3RrMvIgzbzB1S8YTDD+wuRl/+kr86b66k=;
  b=aBP+M7ABiZJCUQs7jUGR34jdzHc+a8fI8LAXlKnMyFWCK8jHEgI+nxf9
   4aBl9t+Ys7bUSw1soiWAG+s1WO14AuyZWzXwPJQ0vzFLEgIDJxh419uln
   70Kg+RVEeDwJ9pCXvWuEeOyZfKkBc7MZlIcM+txcwudriZXiFx7FIMc7i
   z6i/Ymbp17Ym/4OD9rFHA5ZnE01mTytc1SickX0X4oI711noaR9QH5hPc
   qL8ndxI1W15wYhziU33UQhhGQbtZDe6DEq5af/0ETg0DG8LtGKg++uH5B
   Hw4LsR49smx0/QDhb3m1k6kv3w9LbpnChpJAaIlpa4YFDmrUN96UYxm+l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="355767105"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="355767105"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 07:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845490938"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="845490938"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2023 07:08:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTNNV-00B7YT-1f;
        Tue, 08 Aug 2023 17:08:05 +0300
Date:   Tue, 8 Aug 2023 17:08:05 +0300
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
Subject: Re: [PATCH v4 2/4] iio: adc: mcp3911: simplify usage of spi->dev in
 probe function
Message-ID: <ZNJMReTpBOQ9FA2p@smile.fi.intel.com>
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
 <20230808110432.240773-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808110432.240773-2-marcus.folkesson@gmail.com>
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

On Tue, Aug 08, 2023 at 01:04:30PM +0200, Marcus Folkesson wrote:
> Replace the usage of adc->spi->dev with spi->dev to make the code prettier.

Suggested-by: ?

> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

...

> -	adc->vref = devm_regulator_get_optional(&adc->spi->dev, "vref");
> +	adc->vref = devm_regulator_get_optional(&spi->dev, "vref");

Why not

	struct device *dev = &spi->dev;

and all the rest accordingly?

>  	if (IS_ERR(adc->vref)) {
>  		if (PTR_ERR(adc->vref) == -ENODEV) {
>  			adc->vref = NULL;
>  		} else {
> -			dev_err(&adc->spi->dev,
> +			dev_err(&spi->dev,
>  				"failed to get regulator (%ld)\n",
>  				PTR_ERR(adc->vref));
>  			return PTR_ERR(adc->vref);

Actually, you may first to switch to dev_err_probe() with the above introduced

	struct device *dev = &spi->dev;
	...
			return dev_err_probe(dev, PTR_ERR(adc->vref),
					     "failed to get regulator\n",

and in the second patch do what you are doing here.

Will be much less changes and neater code at the end.

-- 
With Best Regards,
Andy Shevchenko


