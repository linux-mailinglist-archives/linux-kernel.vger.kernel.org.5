Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5B47AF0C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjIZQdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:32:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C584B3;
        Tue, 26 Sep 2023 09:32:52 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384389707"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="384389707"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778188774"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="778188774"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:32:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1qlAmR-00000000f0W-3RkJ;
        Tue, 26 Sep 2023 19:19:23 +0300
Date:   Tue, 26 Sep 2023 19:19:23 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/6] ARM: pxa: Convert Spitz hsync to GPIO
 descriptors
Message-ID: <ZRMEi6pACEx5HQZ/@smile.fi.intel.com>
References: <20230926-pxa-gpio-v2-0-984464d165dd@skole.hr>
 <20230926-pxa-gpio-v2-5-984464d165dd@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926-pxa-gpio-v2-5-984464d165dd@skole.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 05:46:26PM +0200, Duje Mihanović wrote:
> Sharp's Spitz still uses the legacy GPIO interface in its
> wait_for_hsync() function.
> 
> Convert it to use the GPIO descriptor interface.

...

> +static struct gpio_desc *hsync = NULL;

Assignment is redundant.

...

>  	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
>  	gpiod_add_lookup_table(&spitz_spi_gpio_table);
> +	hsync = gpiod_get(NULL, "hsync", GPIOD_IN);
> +	if (IS_ERR(hsync)) {
> +		pr_err("Failed to get hsync GPIO: %ld\n", PTR_ERR(hsync));
> +		return;
> +	}
>  	pxa2xx_set_spi_info(2, &spitz_spi_info);
>  	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));

Yeah, but the question is, if GPIO request fails, can we instantiate at least
one device and move on?

-- 
With Best Regards,
Andy Shevchenko


