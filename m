Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675D793E96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbjIFOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbjIFOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:18:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D228171C;
        Wed,  6 Sep 2023 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694009879; x=1725545879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QX645dZFdhQ+ioOhTLWdP6mcq9wvGo1tSmPXl3L039c=;
  b=gNC90ADs/1zsHVsvjoBzDKmx5jLNyf5f/G4HmtXCobgbijx41RdUogVt
   2VW/NVvzj8DTgRfmHYS/6Uv2JjmHCRweHd6dcb5dzroLWFd0/ve0h6Fbg
   Mbb3Z1ux7FVHoXPrlTJpE4c2NzmruOZWDsGD06ZOb3BNWk7Cgi760VtVx
   yPMCMkgbk75ShhHVFAjBPdqXoauxBtYfY1EnP7tdJ60B3vUtYinOmjcYD
   DuipNCjZ4oqgLfON3DLkcKWqtRuXBWjOu1iXfdjbc21z542cXbnoSkeax
   P7EJrKMuW7EMSAS0s/xKLsHaonT6qKXZdht4tjkDZKwobyzVN9osloIik
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="380873572"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="380873572"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="741562051"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="741562051"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:17:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdtLo-006xeT-2c;
        Wed, 06 Sep 2023 17:17:48 +0300
Date:   Wed, 6 Sep 2023 17:17:48 +0300
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
Subject: Re: [PATCH 06/21] gpiolib: provide gpiod_to_device()
Message-ID: <ZPiKDOg+dyesjaz8@smile.fi.intel.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905185309.131295-7-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:52:54PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> struct gpio_desc is opaque so provide a way for users to retrieve the
> underlying GPIO device.

...

> +/**
> + * gpiod_to_device() - Return the GPIO device owning this descriptor
> + * @desc: GPIO descriptor
> + *
> + * Returns:
> + * Pointer to the opaque struct gpio_device object. This function does not
> + * increase the reference count of gpio_device.

GPIO device.

> + */

-- 
With Best Regards,
Andy Shevchenko


