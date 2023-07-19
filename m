Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E265759B50
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGSQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGSQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:48:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B66891;
        Wed, 19 Jul 2023 09:48:08 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346825108"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346825108"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 09:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867547426"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jul 2023 09:48:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qMALK-001MwS-2U;
        Wed, 19 Jul 2023 19:48:02 +0300
Date:   Wed, 19 Jul 2023 19:48:02 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/4] gpio: sifive: Look up IRQs only once during probe
Message-ID: <ZLgTwiTzykDhCd5w@smile.fi.intel.com>
References: <20230719163446.1398961-1-samuel.holland@sifive.com>
 <20230719163446.1398961-3-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719163446.1398961-3-samuel.holland@sifive.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:34:43AM -0700, Samuel Holland wrote:
> of_irq_count(), or eqivalently platform_irq_count(), simply looks up
> successively-numbered IRQs until that fails. Since this driver needs to
> look up each IRQ anyway to get its virq number, use that existing loop
> to count the IRQs at the same time.

...

> -	ngpio = of_irq_count(node);
> -	if (ngpio > SIFIVE_GPIO_MAX) {
> -		dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
> -			SIFIVE_GPIO_MAX);
> -		return -ENXIO;

Do we still need this check?

> -	}

...

> +	for (ngpio = 0; ngpio < SIFIVE_GPIO_MAX; ngpio++) {
> +		ret = platform_get_irq_optional(pdev, ngpio);
>  		if (ret < 0)
> -			return ret;
> -		chip->irq_number[i] = ret;
> +			break;
> +		chip->irq_number[ngpio] = ret;
>  	}

If so, here we need something like

	ret = platform_get_irq_optional(pdev, ngpio);
	if (ret > 0) {
		dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
			SIFIVE_GPIO_MAX);
		return -ENXIO;
	}

Otherwise you need to mention this relaxation in the commit message.

-- 
With Best Regards,
Andy Shevchenko


