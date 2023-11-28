Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEB7FC2E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjK1Q3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjK1Q3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:29:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FB4D4B;
        Tue, 28 Nov 2023 08:29:16 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="11654321"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="11654321"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:29:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797625148"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="797625148"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:29:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1r80xT-00000000D0T-0zzl;
        Tue, 28 Nov 2023 18:29:11 +0200
Date:   Tue, 28 Nov 2023 18:29:10 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        bstruempfel@ultratronik.de
Subject: Re: [PATCH v2] gpiolib: sysfs: Fix error handling on failed export
Message-ID: <ZWYVVvB0O-CBIbos@smile.fi.intel.com>
References: <20231128141321.51669-1-boerge.struempfel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128141321.51669-1-boerge.struempfel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:13:21PM +0100, Boerge Struempfel wrote:
> If gpio_set_transitory() fails, we should free the gpio again. Most

gpio --> GPIO descriptor
(I already mentioned capitalization in v1 review)

> notably, the flag FLAG_REQUESTED has previously been set in
> gpiod_request_commit(), and should be reset on failure.
> 
> To my knowledge, this does not affect any current users, since the
> gpio_set_transitory() mainly returns 0 and -ENOTSUPP, which is converted
> to 0. However the gpio_set_transitory() function calles the .set_config()
> function of the corresponding gpio chip and there are some gpio drivers in

gpio --> GPIO

> which some (unlikely) branches return other values like -EPROBE_DEFER,
> and EINVAL. In these cases, the above mentioned FLAG_REQUESTED would not

-EINVAL

> be reset, which results in the pin being blocked until the next reboot.

Fixes tag?
(`git log --no-merges --grep "Fixes:" will show you examples)

-- 
With Best Regards,
Andy Shevchenko


