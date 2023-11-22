Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27487F4553
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbjKVMEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbjKVMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:03:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F791;
        Wed, 22 Nov 2023 04:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700654636; x=1732190636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m040tgcegxw5h4wMsOHvsYLUwbk5maPB4/Q2K6ePJs0=;
  b=ZftmQJouaUR2JgpkYlZ0Kan0Q4bYpYqHHXngiBA9V2H178JT4icrVyNt
   Q1gKK+JzF7rF3O9L3riVSJOdzOUDUPAn/TgY/J+24kWHC21jjfF+YXiCO
   Ahojdatia8wJ8IjDLdKDVWJtNGXSJgbzh19MWGVrgxcQDA7lYPz9fZbtX
   gO/RVU/Ir82xH67Nenl6zKMLkBADo93nCDWgLshoduZH8POZ0Iewc3ktw
   MDazyqwSzeRb9bSnVuxQdutNKB3IXYNvcsBQiKPiFYjEFpfeq/rh2g20/
   67JAmrn9nrTsbMfH+zE7NXb5SvdoL1fK19EVA/Rj5ye8A0X9wo/uhTWM4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="372218021"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="372218021"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014210364"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="1014210364"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:03:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r5lnj-0000000G516-3Yml;
        Wed, 22 Nov 2023 13:53:51 +0200
Date:   Wed, 22 Nov 2023 13:53:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5 05/39] power: reset: Add a driver for the ep93xx reset
Message-ID: <ZV3rz8-AGGEGGi1g@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-5-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-5-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:59:43AM +0300, Nikita Shubin wrote:
> Implement the reset behaviour of the various EP93xx SoCS in drivers/power/reset.
> 
> It used to be located in arch/arm/mach-ep93xx.

...

> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/notifier.h>

> +#include <linux/of.h>

I believe I already had commented in one of the previous rounds that this cargo
cult of adding of.h (esp. if it's used as a proxy) is not a good idea. Please,
revisit _ALL_ (and I mean it) your patches for this kind of issues.

...

> +#include <linux/reboot.h>
> +
> +#include <linux/soc/cirrus/ep93xx.h>

You see, here is a blank line, so I suggest keep it in all your patches for
consistency's sake.

-- 
With Best Regards,
Andy Shevchenko


