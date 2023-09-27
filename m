Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3124F7B038B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjI0MLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjI0MLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:11:22 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 05:11:21 PDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B563D139;
        Wed, 27 Sep 2023 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695816682; x=1727352682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4vQe1q4hMJ3hNkO7sxKc4Crn7sjhVzAnB6hHM6cKjoI=;
  b=C0i4X3rOPrfUc3jcwuFpFMfYYRmBemCZfhMfKrs5nxgqZdPN/ZxNciix
   MzgDLl9/cho0tPp3ZtDw9dzS022sQr803ZluYi1PLiPI567+NLWyIl2w+
   Hn89GBo2O/sjZowO0UEtr4kF6E06MK0173DKCqjmeJ7QlwNBzGmwfv11p
   348vgeHEWTmMng6bofEIpqf+t8Hi/5BKhZIHj4jEl7Iy0HAIuAS1rWUal
   DuH+cYAfEaT69wWUI+CptfA1/fawmi5CPW/60rAnauLwaa6i0l/w5GyOU
   iLpHWHot1H1Tx93aAAY+0CuzJ84LhmN6yJYnEhP4FMDTS4EGiggS2GncF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="404480"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="404480"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725781465"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="725781465"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:10:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qlTMs-00000000sW0-0brW;
        Wed, 27 Sep 2023 15:10:14 +0300
Date:   Wed, 27 Sep 2023 15:10:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 2/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <ZRQbpSiwsS886cvH@smile.fi.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-3-andriy.shevchenko@linux.intel.com>
 <ZRN2adZZaGeqWNlY@yury-ThinkPad>
 <ZROO9skQbYw1N9YP@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZROO9skQbYw1N9YP@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 07:10:33PM -0700, Yury Norov wrote:

...

> So, if mask is 0b01, and src is 0b10, the output will be 0b00.

Correct. This how it must work.

> To me it sounds like you've gathered nothing, while the intention
> was to gather all source bits to bit #0.

No, the idea is to gather bits positions of which are provided by a mask
from source to a destination, where the positions are sequential.

> This is my understanding
> of the word 'gather',

You should get the mask meaning. It's not the bit provider, it's a bit
positions provider.

>	and this is how bitmap_remap() works.

It's NOT a replacement of bitmap_remap(). It's specifically written in the
commit message that domain of these APIs is when @old or @new (in case of
bitmap_remap() API) equals 2^n - 1, where n is amount of bits we consider.

...

> If you claim you're replacing bitmap_remap(),
> you should correctly handle
> the above case; when src == dst; when mask is empty, and probably more...

I don't care about corner cases of bitmap_remap(), and we can solve the issue
when it comes. Currently there is no issue with the all users that need these
API as they use different addresses.

-- 
With Best Regards,
Andy Shevchenko


