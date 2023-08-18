Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCBD780A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357691AbjHRKeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376513AbjHRKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:33:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8595744AF;
        Fri, 18 Aug 2023 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692354715; x=1723890715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Byca6THECZtZOOnmm+rZ0HVlbluVYVo867XEr0ivojQ=;
  b=eqY5FQ6FUI5IWPLaKg4b+ugfC6YLb6fNCm7yRlTfbacOR3+HYN/84sS/
   oGRBL+4X4S0Er1I/ujQD1q4KaeywFEq/QXJDVHy0zAih1E/+xxt7N9t4j
   vwCysBF6MjHT5PGF3wdEcOusQ/CJZsMjDJ02+oD0i5ksptxHa/4/gQ0oD
   a6QXyGz73XwqcWl5OetEKRt+HtIQC7Q5fo29mbjvdGozJjfvzdg0wQZx5
   yyNaw7Ud9Fps2fTx52YqCxU/k4C38R+e496gXhoY0qlpjOwofyUjzsCgJ
   0Vmu0pG0vIqWLd2bIU9EKB28GizESGTWhCRGCVnr1hX6KVtk0nfCy8r3K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363229865"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="363229865"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800430517"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="800430517"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2023 03:31:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWwks-003m3e-0P;
        Fri, 18 Aug 2023 13:30:58 +0300
Date:   Fri, 18 Aug 2023 13:30:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 4/6] gpio: cdev: wake up chardev poll() on device
 unbind
Message-ID: <ZN9IYYgD6q/H3EuG@smile.fi.intel.com>
References: <20230817184958.25349-1-brgl@bgdev.pl>
 <20230817184958.25349-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817184958.25349-5-brgl@bgdev.pl>
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

On Thu, Aug 17, 2023 at 08:49:56PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a notifier block to the gpio_chardev_data structure and register it
> with the gpio_device's device notifier. Upon reception of an event, wake
> up the wait queue so that the user-space be forced out of poll() and need
> to go into a new system call which will then fail due to the chip being
> gone.

...

> +	struct gpio_chardev_data *cdev = container_of(nb,
> +						      struct gpio_chardev_data,
> +						      device_unregistered_nb);

	struct gpio_chardev_data *cdev =
		container_of(nb, struct gpio_chardev_data, device_unregistered_nb);

?

-- 
With Best Regards,
Andy Shevchenko


