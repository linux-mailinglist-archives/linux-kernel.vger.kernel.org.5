Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE37A97F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjIUR3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjIUR2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:28:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A58B2AC52
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316309; x=1726852309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+uJnQMLMCkrFmbMkL5ksZO00cYOUb/n0p/lufRKAs5o=;
  b=H0xQpKVjYsfxjCJaVrxOCQGEFnIrXvZ4KddRs2X3o2RHsFjfCobqkA36
   5wT0EwZYog6fZ5APvO1y4E33/jeVDW3BLt/VkrhDvRps0DoxlD0zoFrsF
   UEkl6DFE8Yjh9Cpcdgm387l1WAoSOjHnSl3YFNlaIIjl3YOSE4HL+xCOC
   ra84TGLphRysiMTjWtHF+cX7lvZ7G9ftcR5QVA77I9NOhfNEa0lc6zeYe
   bEEOip3REG9Q1LJQBXDmUg0nrjxeGo/+DsxxrOCa5vVbnuUn3GQGZ/VXh
   qvIHtRjc5srDZECwQHB9mSK84KnfmWYCoMe80UWGQNN9sf7treFkRp/Bl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="370896833"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="370896833"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 09:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="817463280"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="817463280"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 09:18:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjMO3-0000000GxY6-47Cw;
        Thu, 21 Sep 2023 19:18:43 +0300
Date:   Thu, 21 Sep 2023 19:18:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()
Message-ID: <ZQxs445+AIBnSd8w@smile.fi.intel.com>
References: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
 <202309211632.67e4c1e0-oliver.sang@intel.com>
 <ZQxjBkFZV5T6BELA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQxjBkFZV5T6BELA@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BANG_GUAR,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 06:36:38PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 21, 2023 at 09:34:13PM +0800, kernel test robot wrote:
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_fs/sysfs/file.c:#sysfs_emit" on:
> > 
> > commit: d4004295e5502a1eb3e361e97ea4dd1686046af6 ("[PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()")
> > url: https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/params-Introduce-the-param_unknown_fn-type/20230912-231033
> > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> > patch link: https://lore.kernel.org/all/20230912150551.401537-1-andriy.shevchenko@linux.intel.com/
> > patch subject: [PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()
> > 
> > in testcase: trinity
> > version: trinity-i386-abe9de86-1_20230429
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	group: group-04
> > 	nr_groups: 5
> 
> 
> > what we observed is this issue doesn't always happen. we run the test upon
> > this commit almost 500 times, it happened 42 times.
> > however, the parent keeps clean.
> > 
> >         v6.6-rc1 d4004295e5502a1eb3e361e97ea
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :497          8%          42:496   dmesg.EIP:sysfs_emit
> >            :497          8%          42:496   dmesg.WARNING:at_fs/sysfs/file.c:#sysfs_emit
> 
> Cool! I will check this, thank you for the report.

Oh, my gosh... This reveals a nice overflow bug for some getters that expect
buffer to be PAGE_SIZE, but an array can be bigger than that.

So, basically this is a flaw in param_array_get() which is a wrapper on top of
getter and calls ->get() without any proper alignment or buffer size guarantee!

While ->get() is by nature suppose to get an aligned buffer of PAGE_SIZE.

Ideally we need to have an additional ->get_array_element() callback which will
take an offset. Less intrusive one is to have an allocated buffer of PAGE_SIZE
in the param_array_get() and ->get() to it, then copy to the real one with the
offset. Any other proposals?

Luis, which solution would you prefer?

-- 
With Best Regards,
Andy Shevchenko


