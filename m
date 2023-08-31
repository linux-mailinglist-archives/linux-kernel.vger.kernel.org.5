Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACF878F628
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347879AbjHaX1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjHaX1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:27:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C680E54;
        Thu, 31 Aug 2023 16:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693524438; x=1725060438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zIMAKVYuQmt5GVkK6/Ob7caWcJVvf0FTlR0pIKcm4vM=;
  b=GL8tzFeQO1gUQPId2Wn8wxoXWVT+Rq+VJ4aUdBOWiNIpFhPtocMJSFmE
   iW/Xa5HtQwRQlmyP7pHWBsaCOHypi0f3xTl31wmVpBDhAEe6KdAsegIoj
   QnX0IqNMSYjMU36OhkMmv2rnPmcDdom0eKLIYNrArrmlHghuUrzc3OoNO
   Ycjf7CX0nISMPVCPSQYcPlBnfEuf8osd+igkHeOzhWNUqKIsShSBVy/TM
   daku38oY4gpPbsuFdqg9+nIrtn2TN8w0qxX4zBOATeaZfSdVWKl0SF+gq
   WG4VKOvQvoLVA4y351de7LedQajrnbThf04ByRA2KjoFAm4x6QfGi5DmR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356404589"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="356404589"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:27:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="774780009"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="774780009"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:27:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbr49-005WoC-2b;
        Fri, 01 Sep 2023 02:27:09 +0300
Date:   Fri, 1 Sep 2023 02:27:09 +0300
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] spi: bcm2835: reduce the abuse of the GPIO API
Message-ID: <ZPEhzXYn8KPMF1Gr@smile.fi.intel.com>
References: <20230831194934.19628-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831194934.19628-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:49:34PM +0200, Bartosz Golaszewski wrote:

> This is only build-tested. It should work, but it would be great if
> someone from broadcom could test this.

Side note: Seems your build test setup misses kernel-doc validation.
With `scripts/kernel-doc -v -none -Wall ...` you can get some warnings.

-- 
With Best Regards,
Andy Shevchenko


