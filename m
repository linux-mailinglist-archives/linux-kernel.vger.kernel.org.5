Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A7178081A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358994AbjHRJRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358993AbjHRJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:16:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4944D3AA3;
        Fri, 18 Aug 2023 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692350190; x=1723886190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0wHf4VrQH/L2Yv1AiBtq3AKNfxAlp1F/0fQlCPokzfg=;
  b=VVYG3oI3JqBEREQ6QJWGxdS22juko09lsnPYjGWreDBshBllLglPglnz
   v/CDhs7HTcNzpbRC/frAwX/1CE3yGQZn1vvY9BmHUQ2Nh9eXKVveDbjj9
   wGxuMwSX8JMzdSfUK+Crm3wX15UFbR5eYKbbAK72kBDmcWm4vijdVQIgq
   YujmA+kICNWh0XW78B2G6+LbUlj+nUXge6qFdKDOqA0C1QykbYvfAPH3A
   R+ycSciGxayy0ShEuWkJb5XNFWonVOb4jJf8klMlpzfXZMmf7reyh6Glh
   at8J7bwAa9Pwy5/ZCuJKYpQs2ReRkkgH1V1r6DG+cpmuKr2LdURxhAw5n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="404041190"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="404041190"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 02:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065667475"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="1065667475"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2023 02:16:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWvak-001Ek9-15;
        Fri, 18 Aug 2023 12:16:26 +0300
Date:   Fri, 18 Aug 2023 12:16:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6] gpio: consumer: new virtual driver
Message-ID: <ZN826UBEktlq42bE@smile.fi.intel.com>
References: <20230817184356.25020-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817184356.25020-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 08:43:56PM +0200, Bartosz Golaszewski wrote:
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

> @@ -46,6 +46,7 @@ obj-$(CONFIG_GPIO_BT8XX)		+= gpio-bt8xx.o
>  obj-$(CONFIG_GPIO_CADENCE)		+= gpio-cadence.o
>  obj-$(CONFIG_GPIO_CLPS711X)		+= gpio-clps711x.o
>  obj-$(CONFIG_GPIO_SNPS_CREG)		+= gpio-creg-snps.o
> +obj-$(CONFIG_GPIO_CONSUMER)		+= gpio-consumer.o

Order?

>  obj-$(CONFIG_GPIO_CRYSTAL_COVE)		+= gpio-crystalcove.o
>  obj-$(CONFIG_GPIO_CS5535)		+= gpio-cs5535.o
>  obj-$(CONFIG_GPIO_DA9052)		+= gpio-da9052.o

...

> +		return dev_err_probe(dev, ret,
> +				     "Failed to read GPIO line names\n");

With one line it takes 83 characters (and note, that long before checkpatch
went for 100, the string literals at the end of a long line were accepted)...

...

> +				return dev_err_probe(dev, ret,
> +						"Failed to request GPIO line interrupt\n");

And here with broken indentation you got 91.
Can you be consistent?

(I prefer as you know less LoCs)

...

> +static ssize_t
> +gpio_consumer_lookup_config_drive_store(struct config_item *item,
> +					const char *page, size_t count)
> +{
> +	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
> +	struct gpio_consumer_device *dev = lookup->parent;
> +
> +	guard(mutex)(&dev->lock);
> +
> +	if (gpio_consumer_device_is_live_unlocked(dev))
> +		return -EBUSY;
> +
> +	if (sysfs_streq(page, "push-pull")) {
> +		lookup->flags &= ~(GPIO_OPEN_DRAIN | GPIO_OPEN_SOURCE);
> +	} else if (sysfs_streq(page, "open-drain")) {
> +		lookup->flags &= ~GPIO_OPEN_SOURCE;
> +		lookup->flags |= GPIO_OPEN_DRAIN;
> +	} else if (sysfs_streq(page, "open-source")) {
> +		lookup->flags &= ~GPIO_OPEN_DRAIN;
> +		lookup->flags |= GPIO_OPEN_SOURCE;
> +	} else {

> +		count = -EINVAL;

Strictly speaking this is incorrect.
You need

	ssize_t ret;
	...
	ret = count;
	if (...)
		ret = -EINVAL;

> +	}
> +
> +	return count;
> +}

> +static ssize_t
> +gpio_consumer_lookup_config_pull_store(struct config_item *item,
> +				       const char *page, size_t count)
> +{

As per above.

> +}

...

> +		curr->chip_hwnum = lookup->offset < 0 ?
> +					U16_MAX : lookup->offset;

I found this way better

		curr->chip_hwnum =
			lookup->offset < 0 ? U16_MAX : lookup->offset;


...

> +	return ret ?: count;

Also possible way in the above mentioned cases.

...


I'm not going to bikeshed, I believe you can fix above accordingly,
either way

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


