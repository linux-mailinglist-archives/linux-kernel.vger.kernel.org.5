Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BB7793F43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbjIFOrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbjIFOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:47:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4441733;
        Wed,  6 Sep 2023 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694011641; x=1725547641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+wfY4dLBSqJqYH1eCxjcFAXhA4C/3J/082gICwAh3j0=;
  b=ghK7etziZqPENMCNQvwzCS7ygAOgdueW+tE38+Ww6ksvDkA4qr5BpEhc
   OBu9qxG4lVgsYl31tAU5j2fEv/Qee3UXEUmX8EWFfEP34EhmmC9nrzCwS
   kjTCf+ROOrc2zkByGx49ivz5NWiJaRe0BCoOFyv+5IucD4JiB9neSQS5t
   PP9X5LLbDbV+31IlXGNwfSPZrZkkGNx0cHQuQBIkkDulGRC9YsK2ut3ux
   d/lcyKoQBsLWYLh/87LCdCHBzIcNROzqv1Rm5+KnfsS35y75hp1u7k21g
   1qg/kJ1IQlF5ZGvjrJLV+/QzC0aYoxQ/ZWySObnynBJm8WaO9hvblY8z9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="408088687"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="408088687"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:47:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="856460670"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="856460670"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:47:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdto5-006y0f-0Q;
        Wed, 06 Sep 2023 17:47:01 +0300
Date:   Wed, 6 Sep 2023 17:47:00 +0300
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
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
Message-ID: <ZPiQ5AvmjCiudnWK@smile.fi.intel.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-15-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905185309.131295-15-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:53:02PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Using struct gpio_chip is not safe as it will disappear if the
> underlying driver is unbound for any reason. Switch to using reference
> counted struct gpio_device and its dedicated accessors.

...

> +	struct gpio_device *gdev __free(gpio_device_put) = NULL;

Using this requires cleanup.h to be included.
Does any of the included GPIO headers guarantee that inclusion implicitly?
Even though, it's a good practice to include headers of what we are using
independently if other (library) headers include them. I.o.w. we can rely
only on our headers (here HTE framework related) to guarantee any inclusions
implicitly.

This also applies to other users of the same construct.

...

>  static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
>  {
>  	return chip->fwnode == of_node_to_fwnode(data);
>  }

Not sure how many users of this kind of match, but it might be useful to have
it by GPIO library

	gpio_device_find_by_fwnode()

-- 
With Best Regards,
Andy Shevchenko


