Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2A879D010
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjILLen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjILLd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:33:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633241735;
        Tue, 12 Sep 2023 04:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694518410; x=1726054410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qge0WJ2cBuoFvgLtL3HtbO+nV9mLGdIGcXhkSHjGwN4=;
  b=WTXbN7rTcrzOt+id6MeP6Vdd/sYKpEIVZj9Yz1U3HpCc7/RwnwSwePDZ
   y34xVB52QeZsjZQoaoHIUSIL0FUbxy1SRb9Am74FhD9c030ktMn2Sod/k
   9NG3HqJLiRTEC63c8sQf3fH//XMlBlYFnGcBkiL5gL56FoqkWLJmqsE/0
   o1Z98MsyCl2luifCzeNwQQOzcUcyKbsfLwhPn6vGStPwNocsEX3Zg58cs
   hZVeNKK74mPxREUIlIXvyFI3vekgPOsgGj4jvF833tIuRM9HFnvCCtV3G
   FA7obGQvO84E9KA0+zEENTtV29AXb8CLLz8UoUCjj4M7IuIG9CROFDj4a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="382158379"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="382158379"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="1074516733"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="1074516733"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:33:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qg1e0-008Zb8-3A;
        Tue, 12 Sep 2023 14:33:24 +0300
Date:   Tue, 12 Sep 2023 14:33:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 02/11] gpiolib: add support for scope-based management
 to gpio_device
Message-ID: <ZQBMhAAgXw0LYa0Y@smile.fi.intel.com>
References: <20230912100727.23197-1-brgl@bgdev.pl>
 <20230912100727.23197-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912100727.23197-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:07:18PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> As the few users that need to get the reference to the GPIO device often
> release it right after inspecting its properties, let's add support for
> the automatic reference release to struct gpio_device.

...

> +DEFINE_FREE(gpio_device_put, struct gpio_device *, if (_T) gpio_device_put(_T));

Looks like this should be

	if (!IS_ERR_OR_NULL(_T))

(with linux/err.h included).

-- 
With Best Regards,
Andy Shevchenko


