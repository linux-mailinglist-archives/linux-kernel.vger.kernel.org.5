Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0241B77498C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjHHT5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjHHT4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:56:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458CA15A8C6;
        Tue,  8 Aug 2023 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691518281; x=1723054281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FpZCxvND5fkfOA2Tn8DTYkZZj2XkJLbkMfoPEuaWbCY=;
  b=TbpVCmtxdPU+2E+TA5wqUVBVbG7e3bokRoSYWvm3J1Fof01K8MreuVvN
   2Hbj2BinbcpGD5HfIG8QYZxfrScUoODWdI3L6NSEAWjXS6lldsbw6oWQm
   9AdbuPsEY797MNKgRRQXym53aVJp/GQJfLhxpDuQK6dNXRVQEtEQW2+kh
   Gg7IUZMEk34kEyFSHAOLfn2U2rrZMhVSaDl5A8tTxSD7SOsbvjuYhRqt5
   L2w3wFgZat3ItfUny2bWiX8FNye8VkhpnJ+kY/3dMZhvjqD7sMkl0uBpu
   8myRrF4DsC35x0zIOWu5WAuFez5Ws1HGZORU7wn+n6mbWsE+KotwD1jgq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373677735"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="373677735"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 10:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801403549"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="801403549"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2023 10:23:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTQQn-000Bdk-0A;
        Tue, 08 Aug 2023 20:23:41 +0300
Date:   Tue, 8 Aug 2023 20:23:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio: consumer: new virtual driver
Message-ID: <ZNJ6HCOV0bzlaoXX@smile.fi.intel.com>
References: <20230808145605.16908-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808145605.16908-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 04:56:05PM +0200, Bartosz Golaszewski wrote:
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

I'll read documentation later. Some code comments below.

...

> +static void gpio_consumer_on_timer(struct timer_list *timer)
> +{
> +	struct gpio_consumer_timer_data *timer_data = to_timer_data(timer);

> +	timer_data->val = timer_data->val == 0 ? 1 : 0;

Can be

	timer_data->val = timer_data->val ? 0 : 1;

But again, why not

	timer_data->val ^= 1;

?

> +	gpiod_set_value_cansleep(timer_data->desc, timer_data->val);
> +	mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(1000));
> +}

...

> +	key = kstrndup(page, count, GFP_KERNEL);
> +	if (!key)
> +		return -ENOMEM;

> +	stripped = strstrip(key);
> +	memmove(key, stripped, strlen(stripped) + 1);

This can be avoided by

	key = kstrndup(skip_spaces(page), count, GFP_KERNEL);

no?

...

> +	ret = kstrtoint(page, 0, &offset);
> +	if (ret)
> +		return ret;
> +
> +	/* Use -1 to indicate lookup by name. */

This comment is unclear as offset can be -1 given by the user.
What does above mean in that context?

> +	if (offset > (U16_MAX - 1))

And how does it related to this -1 if related at all?

> +		return -EINVAL;

...

> +static struct config_group *
> +gpio_consumer_config_make_device_group(struct config_group *group,
> +				       const char *name)
> +{
> +	struct gpio_consumer_device *dev;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev->id = ida_alloc(&gpio_consumer_ida, GFP_KERNEL);
> +	if (dev->id < 0) {
> +		kfree(dev);

Wondering if you can utilize cleanup.h.

> +		return ERR_PTR(dev->id);
> +	}
> +
> +	config_group_init_type_name(&dev->group, name,
> +				    &gpio_consumer_device_config_group_type);
> +	mutex_init(&dev->lock);
> +	INIT_LIST_HEAD(&dev->lookup_list);
> +	dev->bus_notifier.notifier_call = gpio_consumer_bus_notifier_call;
> +	dev->function = GPIO_CONSUMER_FUNCTION_ACTIVE;
> +	init_completion(&dev->probe_completion);
> +
> +	return &dev->group;
> +}

-- 
With Best Regards,
Andy Shevchenko


