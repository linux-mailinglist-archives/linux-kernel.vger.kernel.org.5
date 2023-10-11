Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612787C59F2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbjJKRER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjJKREQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:04:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08EAB0;
        Wed, 11 Oct 2023 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697043852; x=1728579852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ePh04Na6ms40UGUVjEcx0AciBqEAGwUgPoKQ8ajHuPg=;
  b=AcVRNWfaDcTAKLfkgbr19E8NjGs4EXMD5uyNBHcdKiS4Yn6PA4zfPodo
   CiR/3ZT1yWWQfrg6EhcCJEd+o8cixBC+Gymo3gQRCyFf0h8FHT0M0XgfP
   GQ/eGxPvkVFZc5IAZLKyqIeFc2xqaQ1i0kL0Gtr0+bLZwICXVv7r0LV6s
   UgRAF6NjnSJkH52uY+8angYtCuHeOwWw5vQk0WG+DjruLAzx5dlLECzIx
   Vax9Z3ACmQjePWCgImNdwfkZf6skHprF1EJK62VLXAE8lIHWmq9lxtxhp
   hzIOrdmlH7gJ6QH9Wn443/3WmbnDxAhVtYae4fr5qmGa9pF/+bYB/geHT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="384567730"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="384567730"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 10:04:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="1001195052"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="1001195052"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 10:04:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqccv-00000004n80-1umS;
        Wed, 11 Oct 2023 20:04:05 +0300
Date:   Wed, 11 Oct 2023 20:04:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 00/62] pinctrl: don't use GPIOLIB global numberspace
 in helpers
Message-ID: <ZSbVhao44Gjftxyh@smile.fi.intel.com>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 02:07:28PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We have a set of pinctrl helpers for GPIOLIB drivers that take a number
> from the global GPIO numberspace as argument. We are trying to get rid
> of this global numbering. Let's rework these helpers to use the
> recommended gpio_chip + controller-relative offset instead.
> 
> This work is split into phases: first let's introduce the new variants
> of the helpers. Next: let's convert all users one-by-one for easier
> review. After that let's remove the old helpers and rename the new
> variants to take the place of the old ones. Finally convert static
> functions in pinctrl/core.c to using the same signature and to top it
> off, let's remove now redundant wrappers around the pinctrl_helpers.
> 
> This series introduces no functional changes in drivers so I decided to
> not spam every single driver maintainer anymore.

...

>   pinctrl: intel: use new pinctrl GPIO helpers

If it's going to be a separate patch at the end, please split it even more, so
we will have a lean history for each driver.

...

>   pinctrl: change the signature of pinctrl_gpio_direction()
>   pinctrl: change the signature of pinctrl_get_device_gpio_range()
>   pinctrl: change the signature of pinctrl_match_gpio_range()
>   pinctrl: change the signature of gpio_to_pin()
>   pinctrl: change the signature of pinctrl_ready_for_gpio_range()

For the above
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>   pinctrl: intel: drop the wrappers around pinctrl_gpio_direction_input()

I believe this one can always be done on the driver basis, please split it
to three.

-- 
With Best Regards,
Andy Shevchenko


