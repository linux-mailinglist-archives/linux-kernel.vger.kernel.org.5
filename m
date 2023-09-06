Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F5D793E75
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjIFONf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjIFONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:13:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18813CF;
        Wed,  6 Sep 2023 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694009611; x=1725545611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDnUPIn2SR7PPT+yx17NZwjwnlF2gGHn7F4nZ5dZw5o=;
  b=d1PJl3crDFtjg+1l7gfERvFHqUrCbx19ZjEckQ7CMzt1W12sz++PRDWM
   HQ9yltzbi41BuxsDLn/sUzBWpKtw5XMkmppEQV9/EsI9cI6UnTSZ10W8x
   O7yUn4wc83oT1LDepdX8z6JOQkuCMMkZobpMUZh34pLxNlgqp8Zlp1rOd
   WbsPc+TptO73CGiD9ULLVVLeCddNaVLVIOXqSyfhIEv0MAMkVnRx0YkAB
   X7T4IxnUZiwgzDB0m8Szsm4oMnYUXVXpcQIp6SEabcxhFXuFm3TTdKkIW
   Rq/zbYA67XIvFMu9CAF81vW0+ntZUMYApfLdi0Avj3GUFSJHAbuTTxiQf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362106876"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="362106876"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="831679120"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="831679120"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:13:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdtHU-006xaj-2B;
        Wed, 06 Sep 2023 17:13:20 +0300
Date:   Wed, 6 Sep 2023 17:13:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 03/21] gpiolib: provide gpio_device_find_by_label()
Message-ID: <ZPiJAHj3T9yhWXRG@smile.fi.intel.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905185309.131295-4-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:52:51PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> By far the most common way of looking up GPIO devices is using their
> label. Provide a helpers for that to avoid every user implementing their
> own matching function.

...

> +/**
> + * gpio_device_find_by_label() - wrapper around gpio_device_find() finding the
> + *                               GPIO device by its backing chip's label
> + * @label: Label to lookup
> + *
> + * Returns:
> + * Reference to the GPIO device or NULL. Reference must be released with

> + * ``gpio_device_put``.

Out of a sudden different format to refer the function.
Should be gpio_device_put(), so kernel-doc makes a hyperlink.

> + */

So, please, render all your kernel docs and look at the end result.

...

> +	return gpio_device_find((void *)label, gpio_chip_match_by_label);

This casting is a bit awkward... But I have no good proposal for a change.

-- 
With Best Regards,
Andy Shevchenko


