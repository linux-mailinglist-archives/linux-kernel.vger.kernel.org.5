Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C87A7BB8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjJFNPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjJFNPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:15:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F97EA6;
        Fri,  6 Oct 2023 06:15:04 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="383639098"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="383639098"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 06:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="781655164"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="781655164"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 06:15:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andy@kernel.org>)
        id 1qokfS-00000003IrP-0WWv;
        Fri, 06 Oct 2023 16:14:58 +0300
Date:   Fri, 6 Oct 2023 16:14:57 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC/RFT PATCH] gpiolib: reverse-assign the fwnode to struct
 gpio_chip
Message-ID: <ZSAIUVAQ6ifi8LTL@smile.fi.intel.com>
References: <20231006115147.18559-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006115147.18559-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 01:51:47PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> struct gpio_chip is not only used to carry the information needed to
> set-up a GPIO device but is also used in all GPIOLIB callbacks and is
> passed to the matching functions of lookup helpers.
> 
> In that last case, it is currently impossible to match a GPIO device by
> fwnode unless it was explicitly assigned to the chip in the provider
> code.

That's expected behaviour.

> If the fwnode is taken from the parent device, the pointer in
> struct gpio_chip will remain NULL.

> If we have a parent device but gc->fwnode was not assigned by the
> provider, let's assign it ourselves so that lookup by fwnode can work in
> all cases.

I don't think this is a good change. We paper over the real issue where
we and callers need to understand what they are looking for.

...

> This is something that Dipen reported with one of the tegra drivers where
> a GPIO lookup by fwnode does not work because the fwnode pointer in struct
> gpio_chip is NULL. This patch addresses this use-case.

I am not sure I understand the problem here. All these should have been
addressed already, no?

So, the GPIOLIB should use dev_fwnode(&gdev->dev) inside it, outside it
the GPIO drivers are free to use gc->fwnode as long as they understand
the lifetime of the respective object.


-- 
With Best Regards,
Andy Shevchenko


