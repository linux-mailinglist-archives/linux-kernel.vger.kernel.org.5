Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A391B7AEF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjIZP0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIZPZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:25:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C854719F;
        Tue, 26 Sep 2023 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695741947; x=1727277947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vO3V74pLbxic9FFO7VML2YcaNM9LDDY8ad/I/959DY=;
  b=jok1+y8w+QGgrcHn4h7xIxXjmSWzv1bTRaMvgY0NE/BgEFPGg1HVCiZ6
   7Xrv8lJgZh9FQOZ0n1fg01U69FVJz4iJoXkX7XY2pE82Exqvqr6KyhR3I
   KR3IpNyyHFeeYDnoALSOOUeo4a7N39XSl1NtmFy8uleOcXjP7A2F0E/8a
   aivIojmi9l1Ip/iMBN5plCoW+ujEghnzYm2yed7uViewmwgwyD91FayUW
   1mpILUd2vlOiqbuPSMa2xHxqnMmI89ojlsGgmyfxH+4WesKirroTkGcs9
   0d9XP8TNL8fZIy8HOh/sye6cs15TJ/zu/qATiN9c3G/L6X7T5ejAzTOMQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361842886"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="361842886"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819061642"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="819061642"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:25:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ql9wS-00000000eJg-3zdT;
        Tue, 26 Sep 2023 18:25:40 +0300
Date:   Tue, 26 Sep 2023 18:25:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH 1/4] platform/x86: int3472: provide a helper for
 getting GPIOs from lookups
Message-ID: <ZRL39PPuXJqnHpkN@smile.fi.intel.com>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <20230926145943.42814-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926145943.42814-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 04:59:40PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpiod_toggle_active_low() should have never existed in the first place
> and once it was added, it should have never been used outside the MMC
> slot code.
> 
> Stop using it in the int3472 driver and use temporary lookup tables
> instead. First: add a helper wrapping the common code in one function.

>  #include <linux/clk-provider.h>

...

> +#include <linux/device.h>

No need to have this in the header, use forward declaration instead.

-- 
With Best Regards,
Andy Shevchenko


