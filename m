Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C087EC407
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjKONsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbjKONsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:48:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E2AC;
        Wed, 15 Nov 2023 05:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700056108; x=1731592108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1u10bwHQDzE5uIfqyJfipjClovLVgHJkX794aOUElLk=;
  b=kSBZrxjY+BjaysKGLAusng1H1iWFkiGMGd4birl4DXOUlFtz9rT79izs
   hpednhOAU67uzqk1ftoKKb126aM1wm1pAo45Fbld7lrKDcqLZY9zC3arZ
   l/1W5HpztcIsVLEwnpS4X2p4q3GCXEIkh2pFsnpXJ9L3zYKnAgVDD4ria
   OrGTFkfFf3quZC4v6g9q2/7UtUR0U6jmZUYbPzs/l/uJ6tNs0mrhpcb1X
   6OQ0qX7bB/FZXoiVq/GS1lFSjXrcB2XRETIe4VUysaf+9xfIbx1Nm6LfV
   yOVA8huXbI8oO9zuztL+5x8ggoGs7N00IW5xxi2gdowcrUZ7z/MJNs287
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12426388"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12426388"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:48:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="888597743"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="888597743"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:48:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r3GFg-0000000EKO7-3NGU;
        Wed, 15 Nov 2023 15:48:20 +0200
Date:   Wed, 15 Nov 2023 15:48:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 02/25] i2c: designware: Fix PM calls order in
 dw_i2c_plat_probe()
Message-ID: <ZVTMJA5JsQI13dhz@smile.fi.intel.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
 <20231110182304.3894319-3-andriy.shevchenko@linux.intel.com>
 <e299ee44-7de1-4542-828d-a0c86b217fb4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e299ee44-7de1-4542-828d-a0c86b217fb4@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 01:14:36PM +0200, Jarkko Nikula wrote:
> On 11/10/23 20:11, Andy Shevchenko wrote:
> > We should not mix managed calls with non-managed. This will break
> > the calls order at the error path and ->remove() stages. Fix this
> > by wrapping PM ops to become managed one.
> > 
> > Fixes: 36d48fb5766a ("i2c: designware-platdrv: enable RuntimePM before registering to the core")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I fail to see what was broken in above commit and how this patch fixes it?

The order of the unwiding probed flow is broken now as devm_*() mixed with
non-devm_*() calls. This makes all non-devm_*() calls that interleave devm_*()
ones to be also devm_*()-wrapped.

...

> Is it intended change the reset isn't asserted after this patch in case
> i2c_dw_probe() fails?

Did you miss that this is become managed with this patch and hence the above
is false scenario?

-- 
With Best Regards,
Andy Shevchenko


