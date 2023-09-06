Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962C9793F83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbjIFOu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIFOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:50:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9759610D0;
        Wed,  6 Sep 2023 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694011853; x=1725547853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HjAh8SMqCXR1Rjl9aKlTDFEP6jadc3qGb5loq/FNe5w=;
  b=nV2Ae7tMzwJ0UFkb8VXzx4aLELs4XcFC8Tx6esfxmJnKju5I8HCIwGPQ
   Zh2Pb73DYK9LepwQeEuxE60nANVte35K4BvnyoN0QT4IPsM8kjcq+Yaqw
   EUuE4vgSFB98ydqIXgNUVs2TQebEoZAhTcJ6Jb89ieQspuXQTd172ZziI
   fhjvWS4DVcbyhDrgYhHYrWA180MzcXlDflagOdM6+64QMKvubHDnh7/5o
   F+A015cRogv3hxKWI8fTgg4r239ajwPyOzstDlFHijzru4UAeA7vlCsOU
   7zj1qQrvzoqTY1U+kVlZsZmmLaTuGGHW9VVXtl/KaNrNzP6T5jGk5PJnV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="375986346"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="375986346"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:50:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="831691131"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="831691131"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:50:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdtrg-006y3r-0f;
        Wed, 06 Sep 2023 17:50:44 +0300
Date:   Wed, 6 Sep 2023 17:50:43 +0300
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
Subject: Re: [PATCH 18/21] gpio: acpi: replace gpiochip_find() with
 gpio_device_find()
Message-ID: <ZPiRw5fyx3iZQMDx@smile.fi.intel.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-19-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905185309.131295-19-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:53:06PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the ACPI GPIO code.

...

> -	return gpiochip_get_desc(chip, pin);
> +	return gpiochip_get_desc(gdev->chip, pin);

gpio_device_get_desc() ?

-- 
With Best Regards,
Andy Shevchenko


