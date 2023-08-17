Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4777F407
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349920AbjHQKDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349885AbjHQKD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:03:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA28173F;
        Thu, 17 Aug 2023 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692266607; x=1723802607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bOMVKVIhDrLQfNR2KI5p28svytC8+8UPx7CiwqE8lTo=;
  b=IyJzCPw2WK++dGtK4Ks1CWQd5/cA/bnkyenllJaT7RFrCEgWMIsH6KIq
   kTBd8p1PpMCwaQygiKF0KyGJFcnretwxxvLvCCIWjqCoCGOLgoDEn+v4n
   psRWGEQrORW5OccqAkrbhrwNpj/jf1IPfKBKpYYJ1bsvJ67exilpWGKFc
   IOEJi+2ZN2MXiMs883UjrI/BGYQzrhvLEMvZ61aCegJeHaF+XC2mpzoQ6
   fAEqsI9yMOCeD6RzRDtD6hwHskwnMq9oHqWn14CNULX0SqYJtVFqeacRY
   0KHgRhXCmeYFf1ezrLJlGBhksHwImkqU1GNSnZgAI2YIOO9ljoKK5h7vn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352355974"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="352355974"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 03:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="858177291"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="858177291"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2023 03:03:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZqc-006ND8-1W;
        Thu, 17 Aug 2023 13:03:22 +0300
Date:   Thu, 17 Aug 2023 13:03:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5] gpio: consumer: new virtual driver
Message-ID: <ZN3wauUBENDd7aRU@smile.fi.intel.com>
References: <20230815185650.152968-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815185650.152968-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:56:50PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The GPIO subsystem has a serious problem with undefined behavior and
> use-after-free bugs on hot-unplug of GPIO chips. This can be considered a
> corner-case by some as most GPIO controllers are enabled early in the
> boot process and live until the system goes down but most GPIO drivers
> do allow unbind over sysfs, many are loadable modules that can be (force)
> unloaded and there are also GPIO devices that can be dynamically detached,
> for instance CP2112 which is a USB GPIO expender.
> 
> Bugs can be triggered both from user-space as well as by in-kernel users.
> We have the means of testing it from user-space via the character device
> but the issues manifest themselves differently in the kernel.
> 
> This is a proposition of adding a new virtual driver - a configurable
> GPIO consumer that can be configured over configfs (similarly to
> gpio-sim).
> 
> The configfs interface allows users to create dynamic GPIO lookup tables
> that are registered with the GPIO subsystem. Every config group
> represents a consumer device. Every sub-group represents a single GPIO
> lookup. The device can work in three modes: just keeping the line
> active, toggling it every second or requesting its interrupt and
> reporting edges. Every lookup allows to specify the key, offset and
> flags as per the lookup struct defined in linux/gpio/machine.h.
> 
> The module together with gpio-sim allows to easily trigger kernel
> hot-unplug errors. A simple use-case is to create a simulated chip,
> setup the consumer to lookup one of its lines in 'monitor' mode, unbind
> the simulator, unbind the consumer and observe the fireworks in dmesg.
> 
> This driver is aimed as a helper in tackling the hot-unplug problem in
> GPIO as well as basis for future regression testing once the fixes are
> upstream.

...

> +	struct gpio_consumer_device *dev = lookup->parent;
> +
> +	guard(mutex)(&dev->lock);
> +
> +	return sprintf(page, "%s\n", lookup->key);

...

> +static ssize_t
> +gpio_consumer_lookup_config_offset_show(struct config_item *item, char *page)
> +{
> +	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
> +	struct gpio_consumer_device *dev = lookup->parent;
> +	unsigned int offset;
> +
> +	scoped_guard(mutex, &dev->lock)
> +		offset = lookup->offset;
> +
> +	return sprintf(page, "%d\n", offset);

Consistently it can be simplified same way

	guard(mutex)(&dev->lock);

	return sprintf(page, "%d\n", lookup->offset);

BUT. Thinking about this more. With guard() we put sprintf() inside the lock,
which is suboptimal from runtime point of view. So, I think now that all these
should actually use scoped_guard() rather than guard().

> +}

...

> +	guard(mutex)(&dev->lock);
> +
> +	return lookup->flags;

...

> +static ssize_t
> +gpio_consumer_lookup_config_transitory_show(struct config_item *item,
> +					    char *page)
> +{

> +	enum gpio_lookup_flags flags;
> +
> +	flags = gpio_consumer_lookup_get_flags(item);

This is perfectly one line < 80 characters.

> +	return sprintf(page, "%s\n", flags & GPIO_TRANSITORY ? "1" : "0");
> +}

-- 
With Best Regards,
Andy Shevchenko


