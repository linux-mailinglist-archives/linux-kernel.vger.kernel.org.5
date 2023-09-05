Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F39792685
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348765AbjIEQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354507AbjIEMF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:05:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00214AC;
        Tue,  5 Sep 2023 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693915522; x=1725451522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JZkQmLtsdvjeiIiR+qBnIuO3R7CEPwo2RofTy+2Ty9Y=;
  b=cnHrd8VDYAxnFM3bumRT+khy8lEy3JWbf8dY4GG2/c8TBmYFtSxUSNt7
   xD2qRxomlztiX2mofE6CkdSfe76t+r9wlmkEIWEsGzgAeuzbCXtbBn4M0
   1Rr79b/jIn6DgB4BCKoo1bN1QeEfBqAYiJvm62acnNJ89LGDw5J4rS0IQ
   jTpzLhhCYTjUuW0/PxfLcoKzgHucgr51+u6ieCqoP7Fmk7VW2bw07ZbtI
   EHw5MiT6KJP6lC9AaKVI6wA3QwHHYlnbhUzE9eK9LlNcl881q9QGnm3yU
   CJ18uy58DQBQPtmhCtngKQMTfAhJOxRKiQwqdqS+Ec/3Q2/qa6+qG6un0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="374167122"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="374167122"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:05:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="914817844"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="914817844"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:05:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdUo1-006g4r-11;
        Tue, 05 Sep 2023 15:05:17 +0300
Date:   Tue, 5 Sep 2023 15:05:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZPcZfd5UtzMmIUvm@smile.fi.intel.com>
References: <20230905082413.21954-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905082413.21954-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 10:24:13AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We access internals of struct gpio_device and struct gpio_desc because
> it's easier but it can actually be avoided and we're working towards a
> better encapsulation of GPIO data structures across the kernel so let's
> start at home.
> 
> Instead of checking gpio_desc flags, let's just track the requests of
> GPIOs in the driver. We also already store the information about
> direction of simulated lines.
> 
> For kobjects needed by sysfs callbacks: we can iterate over the children
> devices of the top-level platform device and compare their fwnodes
> against the one passed to the init function from probe.
> 
> While at it: fix one line break and remove the untrue part about
> configfs callbacks using dev_get_drvdata() from a comment.

...

> v2 -> v3:
> - don't use fwnode internal fields, instead: iterate over the platform
>   device's children and locate the GPIO device

Thank you!

...

> @@ -181,7 +178,7 @@ static int gpio_sim_get_direction(struct gpio_chip *gc, unsigned int offset)

>  static int gpio_sim_set_config(struct gpio_chip *gc,
> -				  unsigned int offset, unsigned long config)
> +			       unsigned int offset, unsigned long config)

Looking at other prototypes, it can be

static int gpio_sim_set_config(struct gpio_chip *gc, unsigned int offset,
			       unsigned long config)

...

> +static int gpio_sim_chip_set_device(struct device *dev, void *data)
> +{
> +	struct gpio_sim_chip *chip = data;

> +	if (chip->swnode == dev->fwnode) {

Please do not dereference fwnode from the struct device, we have an API!
device_match_fwnode()

> +		chip->dev = dev;
> +		return 1;
> +	}
> +
> +	return 0;
> +}

...

> +	chip->swnode = swnode;
> +	ret = device_for_each_child(dev, chip, gpio_sim_chip_set_device);
> +	if (!ret)
> +		return -ENODEV;

Can bus_find_device_by_fwnode() be used here?

-- 
With Best Regards,
Andy Shevchenko


