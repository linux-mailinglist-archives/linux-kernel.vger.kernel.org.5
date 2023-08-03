Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE2676E715
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjHCLjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjHCLjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:39:06 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D826269E;
        Thu,  3 Aug 2023 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691062744; x=1722598744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oTULVA+13wHM2OEIzh4Wew41qjk8II1H64d+QsGY4yU=;
  b=UNtTyZwUYiSYwD+tYw+FCXRHn0zrOS0vblTaoeO0r0ZZhFiaFfryCiSb
   326+8T4aL7KmiWpVg7p3tT4QjL2Cd7psDZn60KHOIbarPVAla59Z1uBTQ
   tJ4GtL75EjM+HjRIHGQwPggSldVt7K1PQeIwXhS4BPyT+/Uh+F/yOaZz4
   j1v5CYhQ8IvnuOnu5DiTyIpiPBnVtzw7My1MQmEaDk4AAHo23loc7EeI0
   xJgknis6hAJ6Q3uAajGizx1baTpr+mdseaz8SGcY1+Mb4oYk+onFsqTmt
   lT9rsrT+O8pqplclPOHRzV5blN6HZ7qC3zBTkTn98L2j6btTAYbLtdyE/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="354765739"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="354765739"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="819607546"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="819607546"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2023 04:38:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRWfR-00AWI1-2i;
        Thu, 03 Aug 2023 14:38:57 +0300
Date:   Thu, 3 Aug 2023 14:38:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC PATCH] gpio: consumer: new virtual driver
Message-ID: <ZMuR0W303WCbS1K0@smile.fi.intel.com>
References: <20230802152808.33037-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802152808.33037-1-brgl@bgdev.pl>
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

On Wed, Aug 02, 2023 at 05:28:08PM +0200, Bartosz Golaszewski wrote:
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

> @@ -1796,6 +1796,13 @@ config GPIO_SIM
>  	  This enables the GPIO simulator - a configfs-based GPIO testing
>  	  driver.
>  
> +config GPIO_CONSUMER
> +	tristate "GPIO Consumer Testing Module"
> +	select CONFIGFS_FS
> +	help
> +	  This enables the configurable, configfs-based virtual GPIO consumer
> +	  testing driver.

I believe the agreement (as mentioned in this file) is to keep sorted by config
names, so CONSUMER is definitely should be earlier than SIM.

...

> +#include <linux/completion.h>
> +#include <linux/configfs.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/machine.h>
> +#include <linux/idr.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/limits.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>

> +#include <linux/of_platform.h>

Wrong header. Use mod_devicetable.h.

> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/timer.h>

And general recommendation is to revisit this block and refine it accordingly.

...

> +enum gpio_consumer_function {

> +	GPIO_CONSUMER_FUNCTION_ACTIVE = 0,

= 0 is guaranteed by C standard, why do you need it be explicit?

> +	GPIO_CONSUMER_FUNCTION_TOGGLE,
> +	GPIO_CONSUMER_FUNCTION_MONITOR,
> +	__GPIO_CONSUMER_FUNCTION_LAST,

No comma in terminator line.

> +};

...

> +static void gpio_consumer_on_timer(struct timer_list *timer)
> +{
> +	struct gpio_consumer_timer_data *timer_data = to_timer_data(timer);

> +	timer_data->val = timer_data->val == 0 ? 1 : 0;

	timer_data->val = timer_data->val ? 0 : 1;

is shorter, but what is showing better the intention is

	timer_data->val ^= 1;

> +	gpiod_set_value_cansleep(timer_data->desc, timer_data->val);
> +	mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(1000));
> +}

...

> +	ret = match_string(gpio_consumer_function_strings, -1, function_prop);
> +	if (ret < 0)
> +		return dev_err_probe(dev, -EINVAL,

Why not

		return dev_err_probe(dev, ret,

?

> +				     "Invalid consumer function: '%s'\n",
> +				     function_prop);

...

> +	flags = function == GPIO_CONSUMER_FUNCTION_MONITOR ?
> +					GPIOD_IN : GPIOD_OUT_HIGH;
> +	for (i = 0; i < num_lines; i++) {
> +		desc = devm_gpiod_get(dev, lines[i], flags);
> +		if (IS_ERR(desc))
> +			return dev_err_probe(dev, PTR_ERR(desc),
> +					     "Failed to get GPIO '%s'\n",
> +					     lines[i]);

Would it make sense to request GPIOs via devm_gpiod_get_array() and then try
the rest on them in a loop?

> +		}

...

> +static int gpio_consumer_bus_notifier_call(struct notifier_block *nb,
> +					   unsigned long action, void *data)
> +{
> +	struct gpio_consumer_device *consumer;
> +	struct device *dev = data;
> +	char devname[32];
> +
> +	consumer = container_of(nb, struct gpio_consumer_device, bus_notifier);
> +	snprintf(devname, sizeof(devname), "gpio-virtual-consumer.%d",
> +		 consumer->id);

> +	if (strcmp(dev_name(dev), devname) == 0) {

	if (strcmp(dev_name(dev), devname))
		return NOTIFY_DONE;

?

> +		switch (action) {
> +		case BUS_NOTIFY_BOUND_DRIVER:
> +			consumer->driver_bound = true;
> +			break;
> +		case BUS_NOTIFY_DRIVER_NOT_BOUND:
> +			consumer->driver_bound = false;
> +			break;
> +		default:
> +			return NOTIFY_DONE;
> +		}
> +
> +		complete(&consumer->probe_completion);
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}

...

> +static ssize_t
> +gpio_consumer_lookup_config_offset_store(struct config_item *item,
> +					 const char *page, size_t count)
> +{
> +	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
> +	struct gpio_consumer_device *dev = lookup->parent;
> +	int offset, ret;
> +
> +	ret = kstrtoint(page, 0, &offset);
> +	if (ret)
> +		return ret;
> +
> +	/* Use -1 to indicate lookup by name. */
> +	if (offset > (U16_MAX - 1))
> +		return -EINVAL;

So, offset here may be negative. Is it okay?

> +	mutex_lock(&dev->lock);
> +
> +	if (gpio_consumer_device_is_live_unlocked(dev)) {
> +		mutex_unlock(&dev->lock);
> +		return -EBUSY;
> +	}
> +
> +	lookup->offset = offset;
> +
> +	mutex_unlock(&dev->lock);
> +
> +	return count;
> +}

...

> +	if (flags & GPIO_OPEN_DRAIN)
> +		repr = "open-drain";
> +	else if (flags & GPIO_OPEN_SOURCE)
> +		repr = "open-source";

Can it be both flags set?

> +	else
> +		repr = "push-pull";

...

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
> +	}

I prefer to see some kind of the array of constant string literals and do
sysfs_match_string() here

	lookup->flags &= ~(GPIO_OPEN_DRAIN | GPIO_OPEN_SOURCE);
	flag = sysfs_match_string(...);
	if (flag < 0)
		count = flag
	else
		lookup->flags |= flag;

(or something similar). And respectively indexed access above.

...

> +	flags = gpio_consumer_lookup_get_flags(item);
> +
> +	if (flags & GPIO_PULL_UP)
> +		repr = "pull-up";
> +	else if (flags & GPIO_PULL_DOWN)
> +		repr = "pull-down";
> +	else if (flags & GPIO_PULL_DISABLE)
> +		repr = "pull-disabled";
> +	else
> +		repr = "as-is";

...

> +	if (sysfs_streq(page, "pull-up")) {
> +		lookup->flags &= ~(GPIO_PULL_DOWN | GPIO_PULL_DISABLE);
> +		lookup->flags |= GPIO_PULL_UP;
> +	} else if (sysfs_streq(page, "pull-down")) {
> +		lookup->flags &= ~(GPIO_PULL_UP | GPIO_PULL_DISABLE);
> +		lookup->flags |= GPIO_PULL_DOWN;
> +	} else if (sysfs_streq(page, "pull-disabled")) {
> +		lookup->flags &= ~(GPIO_PULL_UP | GPIO_PULL_DOWN);
> +		lookup->flags |= GPIO_PULL_DISABLE;
> +	} else if (sysfs_streq(page, "as-is")) {
> +		lookup->flags &= ~(GPIO_PULL_UP | GPIO_PULL_DOWN |
> +				   GPIO_PULL_DISABLE);
> +	} else {
> +		count = -EINVAL;
> +	}

The above is more tricky, but still consider similar approach.

...

> +	num_entries = list_count_nodes(&dev->lookup_list);
> +	table = kzalloc(sizeof(*table) + num_entries * sizeof(*table->table),

struct_size() ?

> +			GFP_KERNEL);
> +	if (!table)
> +		return -ENOMEM;

...

> +	if (list_empty(&dev->lookup_list))
> +		return -ENODATA;

Instead you may count nodes here and if 0, return an error, otherwise pass it
to the callee.

> +	swnode = gpio_consumer_make_device_swnode(dev);
> +	if (IS_ERR(swnode))
> +		return PTR_ERR(swnode);

...

> +static ssize_t
> +gpio_consumer_device_config_live_store(struct config_item *item,
> +				       const char *page, size_t count)
> +{
> +	struct gpio_consumer_device *dev = to_gpio_consumer_device(item);
> +	bool live;
> +	int ret;
> +
> +	ret = kstrtobool(page, &live);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&dev->lock);
> +
> +	if ((!live && !gpio_consumer_device_is_live_unlocked(dev)) ||
> +	    (live && gpio_consumer_device_is_live_unlocked(dev)))

	if (live ^ gpio_consumer_device_is_live_unlocked(dev))

?


> +		ret = -EPERM;
> +	else if (live)
> +		ret = gpio_consumer_device_activate_unlocked(dev);
> +	else
> +		gpio_consumer_device_deactivate_unlocked(dev);
> +
> +	mutex_unlock(&dev->lock);
> +
> +	return ret ?: count;
> +}

...

> +static int __init gpio_consumer_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&gpio_consumer_driver);
> +	if (ret) {
> +		pr_err("Failed to register the gpio-consumer platform driver: %d\n",

Isn't name will be duplicated via pr_fmt()?

> +		       ret);

If yes, can be shortened to

		pr_err("Failed to register the driver: %d\n", ret);

> +		return ret;
> +	}
> +
> +	config_group_init(&gpio_consumer_config_subsys.su_group);
> +	mutex_init(&gpio_consumer_config_subsys.su_mutex);
> +	ret = configfs_register_subsystem(&gpio_consumer_config_subsys);
> +	if (ret) {
> +		pr_err("Failed to register the '%s' configfs subsystem: %d\n",
> +		       gpio_consumer_config_subsys.su_group.cg_item.ci_namebuf,
> +		       ret);
> +		mutex_destroy(&gpio_consumer_config_subsys.su_mutex);
> +		platform_driver_unregister(&gpio_consumer_driver);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


