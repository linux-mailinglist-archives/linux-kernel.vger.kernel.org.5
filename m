Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E457FC2AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbjK1QI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjK1QI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:08:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48C1BC;
        Tue, 28 Nov 2023 08:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701187743; x=1732723743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bUDTt3o1DE03wIRYkYueaBcLdCqYQmU2dGzx0wmGR44=;
  b=n/GbhaiQbdnyPWod7LuIbCwAATzIdEUefqGmTkarLRJwivHZTa9W6eb4
   xmZt4Y3qlUAhlx/PBIww5pZmHy1BoXA+hUUAm284WVYUQqTW4cbepGMma
   x34gm27LBfHhqkW4RoncSpL7z46udZftAGtdRGdLpYGxUrs6g7PzbEf1S
   F+Tp8A/fR0zMGXiJPfe0yOaoKusmj0plFu2C9oqLoraxcoGVQi4VNSZDV
   fN4uunE+svXDuEHwB/QIcIGnvbUuzGrfX5g9eNOM2x/t94sVvHECAv19m
   fMBEDnIsENS90UQ9DcDgAZLZEvMO3zunXLLjrQlK8kov8f/kKKwr9Qf14
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="373123836"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="373123836"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:09:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1100152703"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="1100152703"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:09:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r80du-00000000ClQ-2Zof;
        Tue, 28 Nov 2023 18:08:58 +0200
Date:   Tue, 28 Nov 2023 18:08:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: use a mutex to protect the list of GPIO devices
Message-ID: <ZWYQmpe7UxnJW0_g@smile.fi.intel.com>
References: <20231127193716.63143-1-brgl@bgdev.pl>
 <20231127193716.63143-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127193716.63143-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 08:37:16PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The global list of GPIO devices is never modified or accessed from
> atomic context so it's fine to protect it using a mutex. Add a new
> global lock dedicated to the gpio_devices list and use it whenever
> accessing or modifying it.
> 
> While at it: fold the sysfs registering of existing devices into
> gpiolib.c and make gpio_devices static within its compilation unit.

...

> +	scoped_guard(mutex, &gpio_devices_lock) {

This is a lot of churn with this because of switching to RAII.
Can the body be firstly moved to a helper?

> +		/*
> +		 * TODO: this allocates a Linux GPIO number base in the global
> +		 * GPIO numberspace for this chip. In the long run we want to
> +		 * get *rid* of this numberspace and use only descriptors, but
> +		 * it may be a pipe dream. It will not happen before we get rid
> +		 * of the sysfs interface anyways.
> +		 */

...

>  	list_for_each_entry(gdev, &gpio_devices, list)
> +		if (index-- == 0)
>  			return gdev;

I believe this is better with outer {}.

-- 
With Best Regards,
Andy Shevchenko


