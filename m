Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2367D7B4F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjJBJmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjJBJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:42:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BDDA7;
        Mon,  2 Oct 2023 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696239733; x=1727775733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SWeFo/AW06duwWAYJncQ5ko3aVNmWFyeSa2D5HzoNmg=;
  b=P84uRqLFrwsm6iMK7QMMWqP3tK15BgZb6gV7ZF4EnqUaAQfl2jWLcbov
   EQlD3G9hwiTqEpXOXek/c5L7M2P0btCjSJK84QmlzRJLnomhvs7Fbp/1h
   4lJ9cbhyrzFN8iuf2LtBKAsrMcxQQGbq05HlRBldb9ZVjaujczZBafcwO
   0Yt9XUOEghR0i/bvlldYg2fEE2ZDXnXs6a1ACGCB0gfxPN1syaRobkrJQ
   8K6J+7/1nQ9U1qgJqJHF4sOsQwgWKehRac4l+vhYKswk0u6NGO0a8mxxf
   w0J79rdDX/ho3KbEOEeXB8jQY1LTcQe4fQB7rFvfLrx5oZL5MqohWdNYI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="381494535"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="381494535"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="744064474"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="744064474"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:42:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnFRH-000000027d5-2bzu;
        Mon, 02 Oct 2023 12:42:07 +0300
Date:   Mon, 2 Oct 2023 12:42:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 03/11] gpiolib: provide gpio_device_find()
Message-ID: <ZRqQbzbcNHOtJm7z@smile.fi.intel.com>
References: <20230927142931.19798-1-brgl@bgdev.pl>
 <20230927142931.19798-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927142931.19798-4-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 04:29:23PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpiochip_find() is wrong and its kernel doc is misleading as the
> function doesn't return a reference to the gpio_chip but just a raw
> pointer. The chip itself is not guaranteed to stay alive, in fact it can
> be deleted at any point. Also: other than GPIO drivers themselves,
> nobody else has any business accessing gpio_chip structs.
> 
> Provide a new gpio_device_find() function that returns a real reference
> to the opaque gpio_device structure that is guaranteed to stay alive for
> as long as there are active users of it.

...

>  struct gpio_chip *gpiochip_find(void *data,
>  				int (*match)(struct gpio_chip *gc,

> +struct gpio_device *gpio_device_find(void *data,
> +				     int (*match)(struct gpio_chip *gc,
> +						  void *data))

Why not

typedef int (*gpio_chip_match_fn)(struct gpio_chip *gc, void *data);

?

-- 
With Best Regards,
Andy Shevchenko


