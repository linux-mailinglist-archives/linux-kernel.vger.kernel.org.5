Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440F67FF583
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjK3Q3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjK3Q3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:29:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713C1B4;
        Thu, 30 Nov 2023 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701361770; x=1732897770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gmD3LE2z0jUpdnArYGsTj+eKG7b3T+oQqD9agoBcs0Q=;
  b=T4SvUEJlfTCCBGwKFG32ipy3v0Fm1NHjgiAnTOUcFJ+dt4VJwTTOIh69
   vfOqtDAleHMydN24ccl/Pw79LbDQc2MCeSpiFadnGO129Bjl9kwAh1+Pd
   nZWzfL6/cEA9x4KraKQHrpWjFEAlID7g63oKnLXwyO226c5qOhgtq46/k
   1ltADH4keFxdrsh2fLFpdLbdzaKJsQx+IuSejxHGlYeXWgc+8ueMqyCLM
   eBrPn48ZYIC0KeIhktyPJpNBDw2VVOIiAy9mmtphB/hEb4KS8N5hgo0so
   9EzLb/wAbYzeDvc23MnF1lnLypOt0cXFWMDavpug5AzIB8ilPn1NAWuFN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="390513241"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="390513241"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:29:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="798350197"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="798350197"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:29:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8jun-00000000kIk-2RUz;
        Thu, 30 Nov 2023 18:29:25 +0200
Date:   Thu, 30 Nov 2023 18:29:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 03/10] gpio: wm8994: use gpiochip_dup_line_label()
Message-ID: <ZWi4ZRtTRJEN5rSx@smile.fi.intel.com>
References: <20231130134630.18198-1-brgl@bgdev.pl>
 <20231130134630.18198-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130134630.18198-4-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 02:46:23PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the new gpiochip_dup_line_label() helper to safely retrieve the
> descriptor label.

...

> -		seq_printf(s, " gpio-%-3d (%-20.20s) ", gpio, label);
> +		seq_printf(s, " gpio-%-3d (%-20.20s) ", gpio,
> +			   label ?: "Unrequested");

Haha, see previous comment (in previous email).

-- 
With Best Regards,
Andy Shevchenko


