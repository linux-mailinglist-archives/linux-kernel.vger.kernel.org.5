Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6907B4F4E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbjJBJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjJBJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:44:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4265791;
        Mon,  2 Oct 2023 02:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696239865; x=1727775865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YjDtKD15C5wYw2UlLbCaVNumylNRVOL/0RAdrwts2Ac=;
  b=Rtlat9rFf5fF8gUqogLbO6gdg/TuyWuHAjYX6y300hHc9TlONDiduI2r
   UHxe3FMu/FIuSCXtSbLAs9gThJu74E/7ygs5ahRKd+Hoa+mgZcj8r18ck
   NjG7yS8UbUWYDZvfzWgHIL2BU5MeYbW9tAG1cDdshu++/zbDaWgX6l2Uw
   9zWvTzPr72fc2YsVT8L2iENhwhh+UjRA4ZbaV45du43A25rkEsgpdPUSj
   9mGf0JLfc2rdjulZ6KTRKIQsoqJ6+8rJrVw7KJ56bB3ydnSoS3Lm7c5AB
   ypK7B4yZqydwjClzrV8Il5r2U1yxSxuQsUSjONwqxLZ37UqYSpN97xkCF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="382516840"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382516840"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:44:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081592085"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1081592085"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:44:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnFTQ-000000027eh-1cMI;
        Mon, 02 Oct 2023 12:44:20 +0300
Date:   Mon, 2 Oct 2023 12:44:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 04/11] gpiolib: provide gpio_device_find_by_label()
Message-ID: <ZRqQ9KZe619vx7pz@smile.fi.intel.com>
References: <20230927142931.19798-1-brgl@bgdev.pl>
 <20230927142931.19798-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927142931.19798-5-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 04:29:24PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> By far the most common way of looking up GPIO devices is using their
> label. Provide a helpers for that to avoid every user implementing their
> own matching function.

...

> +struct gpio_device *gpio_device_find_by_label(const char *label)
> +{
> +	return gpio_device_find((void *)label, gpio_chip_match_by_label);
> +}

Are we expecting that data referenced by the first parameter to the
gpio_device_find() can be altered? If not, why not using const void *
there and here as well?

-- 
With Best Regards,
Andy Shevchenko


