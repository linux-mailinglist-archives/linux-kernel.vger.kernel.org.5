Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F17FF04A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345582AbjK3Nht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbjK3Nhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:37:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED7EE6;
        Thu, 30 Nov 2023 05:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701351473; x=1732887473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5rtCX17/k+zofij+xAALMQsx8mdwkuAUwBhFCZtCfjg=;
  b=N7d27TCtAR3rU6j1c+hFtMd+TX4ujpz5hyfoAvRZIDab4Kq4cGNuaTD1
   oRKod6BFpSj/EIo1DJZI/F2vcEiNHhrA/wkSE6/CwbEW5FdgfemVS6Bgg
   5En8H8WIen1xNiXtElhZC8LP+4oOms5QformSMXmXg2JMxjd1EYTEBb5i
   Pk0aH0iY2MsE/Uc2V4k2PomupRvgXeNmB+NYl/PDUtZRRqWWS50eoiLVW
   SLx2RM09Ha4vJh1nPOOKOZ8LypbVx9nweR43FIprzhC8eHYFFlZSnVPYl
   mRvSI0wzoJPBYoELKiv7H6k/HTkpqqe5OtZ+KoqRCbtPKm1CBJ65iqUjI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="396129814"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="396129814"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 05:37:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887242847"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="887242847"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 05:37:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8hEi-00000000i0k-3FKZ;
        Thu, 30 Nov 2023 15:37:48 +0200
Date:   Thu, 30 Nov 2023 15:37:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sim: implement the dbg_show() callback
Message-ID: <ZWiQLEz6P3vbZgx0@smile.fi.intel.com>
References: <20231130104023.11885-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130104023.11885-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:40:23AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Provide a custom implementation of the dbg_show() callback that prints
> all requested lines together with their label, direction, value and
> bias. This improves the code coverage of GPIOLIB.

...

> +#else
> +#define gpio_sim_dbg_show NULL
> +#endif /* CONFIG_DEBUG_FS */

I;m wondering if you can use PTR_IF() instead of this ugly ifdeffery.

-- 
With Best Regards,
Andy Shevchenko


