Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C4F77899E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjHKJUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjHKJT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:19:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EB32D78;
        Fri, 11 Aug 2023 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691745598; x=1723281598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5cLnojzw8GwJQeVPk+d6p7jnvKD0oM2DncTUym4BGQU=;
  b=EzunvH/GqXvzrrG5RSv/vLwW4JASmhyEAstXHmgc4HYv0upUvU05b/+l
   wgDfFs6M+kk2XEVE+CHWlKrAp9QqOs4LczOot/aqkasR6NOWVl9INAvC4
   t8bPysJ1Vhg4FP3UvWabSa63Nc0njlMms5JvsOraGSEqXjesxpoZi7zrY
   252Ej2MOuQz+43w/oxM602NCyUhFQ8AmWUAHIKppxoE9tBd253lbD2A3b
   mQ9OOeq5otzKFu9T66Cb07oDyw/n3zgDOxgLj2g6xozLMbsRUKgIaL5dR
   IUqdEr8OIML1sx+CX8zEcXGCU1cptR2WCn09MLc0Y4rhs4tp8o/nFCl04
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="374406319"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="374406319"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:19:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="726197121"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="726197121"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2023 02:19:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUOJG-008FZl-35;
        Fri, 11 Aug 2023 12:19:54 +0300
Date:   Fri, 11 Aug 2023 12:19:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>
Subject: Re: [RESEND PATCH 7/7] gpio: ws16c48: Fix off-by-one error in
 WS16C48 resource region extent
Message-ID: <ZNX9Oo2AOASHKOPZ@smile.fi.intel.com>
References: <cover.1691703927.git.william.gray@linaro.org>
 <f20243853e94264534927f2cdf9288b869e7e03b.1691703928.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f20243853e94264534927f2cdf9288b869e7e03b.1691703928.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 06:00:44PM -0400, William Breathitt Gray wrote:
> The WinSystems WS16C48 I/O address region spans offsets 0x0 through 0xA,
> which is a total of 11 bytes. Fix the WS16C48_EXTENT define to the
> correct value of 11 so that access to necessary device registers is
> properly requested in the ws16c48_probe() callback by the
> devm_request_region() function call.
> 
> Fixes: 2c05a0f29f41 ("gpio: ws16c48: Implement and utilize register structures")

Fixes should go first in the series, but I see no conflict here, I hope Bart
can manage this when applying.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


