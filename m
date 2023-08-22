Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC0784533
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjHVPOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjHVPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:14:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9321AD;
        Tue, 22 Aug 2023 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692717257; x=1724253257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z9rsyHIcEKOtmBcW7scJ8+r5B/sc+XBtNEg19MqEOC0=;
  b=i54Hc9pfvpJu5saqoJ/AtfT5zXoaV+ifV7pAw2W1znDlGdqYgRiicV91
   ZqAFXr78Z3fJrFMCk8c5XIwoTg7zk+10dLyyftyE2DlHabclj92OWnubO
   CqRnOEN0iGb77HibkLMfFbrbroXCmhgqdSveg+OciaqHAQimnFgyXDixD
   wrr6oNMupgG29s0galbkb2H/jAb2DZe7Gy19OVFTlbBO53dL4LFp6rSG7
   rBZOfO8gplN3yqVXx5o0v/ZD1oeHwdr+Oeq1RUeTWVuSVfoUSn6Vpwkot
   WYtpi8fAMJUqJyoSRMiHz87cWuCAOhWSQzpN56towgjHeMPBLhubs2aw4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="354242332"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="354242332"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 08:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739346677"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="739346677"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2023 08:13:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYT4n-00FnbU-1X;
        Tue, 22 Aug 2023 18:13:49 +0300
Date:   Tue, 22 Aug 2023 18:13:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] watchdog: simatic: Use idiomatic selection of P2SB
Message-ID: <ZOTQrf8VnJ8ljGK4@smile.fi.intel.com>
References: <20230822141859.2139630-1-andriy.shevchenko@linux.intel.com>
 <a02b41a2-c390-8d05-ba2a-7a0a958013a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02b41a2-c390-8d05-ba2a-7a0a958013a8@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 04:50:14PM +0200, Hans de Goede wrote:
> On 8/22/23 16:18, Andy Shevchenko wrote:
> > While it's pretty much theoretical to be otherwise, make sure
> > that P2SB is selected only for X86. This is idiomatic dependency
> > which is used by all others who select it. Use it for Simatic
> > as well.
> 
> Hmm, this already depends on SIEMENS_SIMATIC_IPC which itself
> depends on X86, so as you already say this is not really necessary...

Yes, but I want to keep that idiom, that's it.
It's purely style change.

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Note this depends on / applies on top of 2 other
> "config SIEMENS_SIMATIC_IPC_WDT" patches which
> are currently pending in pdx86/for-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
> 
> so this should probably be merged after 6.6-rc1 once
> these other changes have been merged.

Or with an Ack from watchdog maintainers... Whatever is the best for you,
folks. I'm fine with either choice.

-- 
With Best Regards,
Andy Shevchenko


