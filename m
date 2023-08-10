Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3354A777B89
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjHJPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHJPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:03:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43526A0;
        Thu, 10 Aug 2023 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691679829; x=1723215829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V85F3zyG99YKOhkzHvVj9aWIEqnjsPogkM5v3EvHQhU=;
  b=jS/trbSfnR3Iu5igLTKdKt39ENvnkayFi6TQAAUYRLVCfy7h+k8AH0Ej
   kB+dD4oftltZkRZoC9a5YHEeBslFLM3dJLTekldkhTUErKrLbIZ7CWBD7
   wQNXKIv5ZQ9FuFqze+116fHzbNbNgAXcE89jXT54qYQFy2RUTGJj14ZLb
   rS6f4fh2/llbb2PxAM12pM22GwCRHP+kZqLqQhEpjtVd95VLW43+QYEnc
   Qg0SdNVYQsvOyRgUN7GP0nyhRf2hLlcTsKBFHQT3I0yxtX5QgeXtVfjLu
   kznLRTUmuXaJHVoahtX4eAmjTuksRiJCfkTDpW2+XYCbBPi1oMq7etvvF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375138428"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="375138428"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="732289598"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="732289598"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2023 08:03:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU7CS-00625D-00;
        Thu, 10 Aug 2023 18:03:44 +0300
Date:   Thu, 10 Aug 2023 18:03:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3] gpio: consumer: new virtual driver
Message-ID: <ZNT8T1n0IeJ1uzl6@smile.fi.intel.com>
References: <20230809142709.28042-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809142709.28042-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 04:27:09PM +0200, Bartosz Golaszewski wrote:
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

> +static void gpio_consumer_on_timer(struct timer_list *timer)
> +{
> +	struct gpio_consumer_timer_data *timer_data = to_timer_data(timer);
> +
> +	timer_data->val = timer_data->val ? 1 : 0;

I guess it should be 0 : 1.

> +	gpiod_set_value_cansleep(timer_data->desc, timer_data->val);
> +	mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(1000));
> +}

...

> +static ssize_t
> +gpio_consumer_lookup_config_key_show(struct config_item *item, char *page)
> +{
> +	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
> +	struct gpio_consumer_device *dev = lookup->parent;

> +	int ret;

Why is it needed now? Seems you were too fast to send v3, look at my comments
in v2 thread.

> +	scoped_guard(mutex, &dev->lock)
> +		ret = sprintf(page, "%s\n", lookup->key);
> +
> +	return ret;
> +}

...

> +static ssize_t
> +gpio_consumer_lookup_config_key_store(struct config_item *item,
> +				      const char *page, size_t count)
> +{
> +	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
> +	struct gpio_consumer_device *dev = lookup->parent;
> +	char *key __free(kfree) = NULL;
> +	char *stripped;
> +
> +	key = kstrndup(page, count, GFP_KERNEL);

skip_spaces() will allow you to get rid of memmove().

> +	if (!key)
> +		return -ENOMEM;
> +
> +	stripped = strstrip(key);
> +	memmove(key, stripped, strlen(stripped) + 1);

And this become something like

	/* Get rid of trailing newline and spaces */
	strim(key);

> +	guard(mutex)(&dev->lock);
> +
> +	if (gpio_consumer_device_is_live_unlocked(dev))
> +		return -EBUSY;
> +
> +	kfree(lookup->key);
> +	lookup->key = no_free_ptr(key);
> +
> +	return count;
> +}

...

> +static enum gpio_lookup_flags
> +gpio_consumer_lookup_get_flags(struct config_item *item)
> +{
> +	struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
> +	struct gpio_consumer_device *dev = lookup->parent;
> +	enum gpio_lookup_flags flags;
> +
> +	scoped_guard(mutex, &dev->lock)

> +		flags = lookup->flags;
> +
> +	return flags;

	guard()
	return lookup->flags;

?

> +}

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
> +	guard(mutex)(&dev->lock);
> +
> +	if (live == gpio_consumer_device_is_live_unlocked(dev))
> +		ret = -EPERM;

		return ... ?

> +	else if (live)

	if () ?

> +		ret = gpio_consumer_device_activate_unlocked(dev);

> +	else

drop it ?

> +		gpio_consumer_device_deactivate_unlocked(dev);
> +
> +	return ret ?: count;
> +}

-- 
With Best Regards,
Andy Shevchenko


