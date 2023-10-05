Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252637BA014
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjJEOc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjJEObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7F927B3D;
        Thu,  5 Oct 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513473; x=1728049473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R/dDDcKZGfPfb/XVYbaUQl8M19BfdQjLxL+jfR/Q0Vs=;
  b=YPqctBFks9fMn+kccYkeM1f9cnbHWQVZj8dgHfkvCUnAKeBkGJIA/zdx
   nRcJgjY6Wp+bYAyY2P4krIZoqrMpyQhiCL/LJcdcyra9oLCM872rcsw4r
   MV5eJXJvWDqik2giKloqjb9Ix8jis2egk69t3HupicaWpFxZMTIbTGCRP
   BV76Nh7dI7AFAzV3ZDnPKwRSL1Kr2BBePSR1S7ZXmY/LVhoeQnX8OBgMQ
   An3WCE1j4PnBuixpJsWW9OKtKnNcd9Soekq5kPC7nqqxMWJ2ytIHTczjV
   CpqDcAUlhlWK+DKyHVdd7Ei1o2uKJdf9E2B2ScFWHk7jpHaPNx5ADBFns
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="387323339"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="387323339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 02:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="701593202"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="701593202"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 02:10:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qoKN4-00000002z21-44P4;
        Thu, 05 Oct 2023 12:10:14 +0300
Date:   Thu, 5 Oct 2023 12:10:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] spi: bcm2835: add a sentinel at the end of the lookup
 array
Message-ID: <ZR59dsxK1QBIJoI3@smile.fi.intel.com>
References: <20231004183906.97845-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004183906.97845-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 08:39:06PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> GPIOLIB expects the array of lookup entries to be terminated with an
> empty member. We need to increase the size of the variable length array
> in the lookup table by 1.

Right and seems we (used to?) have the same mistake spread over the kernel.
Perhaps a helper at some point?

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


