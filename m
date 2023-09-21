Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9916E7A9E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjIUUAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjIUUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:00:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E545AA99
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695317353; x=1726853353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uzDkfWXeowTfu3zdB2+xHFSe333dlATcO9CRMMxZdao=;
  b=XiQgDmBV4sSA3VCGkDrTzNwDhL7ywVHpxHY4aSRZMKpDhPHyQs3/ZgRT
   ZGm3V/LMyTtgx3OGP/FnhZ6OfsTm0+BioUJ40GJXYOKIgNlZ218KRt2ZF
   rMOhRItLcDA9Oyc6tLTkOj/p8XuagabTfZyGIMGPatVV/9ibjC5X+lcXz
   kZ/+Pf4NyGCip8qyQgyFJnyQ3f2T0hx6zp7p1nH/Suz0OcfwZeeWQplGo
   dofoqki37R2qVm2FkO/hBT9OQzflC3ld2SJ6kj7Vm7eK2aW+IrytCPPq3
   SRCvus6233MVUt0wqJkHwZQFc5cPjpNxw0P/Elf6izmpEGfxo6YG8cVFk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="411497381"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="411497381"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 08:36:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="862522382"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="862522382"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 08:36:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjLjK-0000000Gwxq-22aH;
        Thu, 21 Sep 2023 18:36:38 +0300
Date:   Thu, 21 Sep 2023 18:36:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()
Message-ID: <ZQxjBkFZV5T6BELA@smile.fi.intel.com>
References: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
 <202309211632.67e4c1e0-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309211632.67e4c1e0-oliver.sang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 09:34:13PM +0800, kernel test robot wrote:
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_fs/sysfs/file.c:#sysfs_emit" on:
> 
> commit: d4004295e5502a1eb3e361e97ea4dd1686046af6 ("[PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()")
> url: https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/params-Introduce-the-param_unknown_fn-type/20230912-231033
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> patch link: https://lore.kernel.org/all/20230912150551.401537-1-andriy.shevchenko@linux.intel.com/
> patch subject: [PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()
> 
> in testcase: trinity
> version: trinity-i386-abe9de86-1_20230429
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-04
> 	nr_groups: 5


> what we observed is this issue doesn't always happen. we run the test upon
> this commit almost 500 times, it happened 42 times.
> however, the parent keeps clean.
> 
>         v6.6-rc1 d4004295e5502a1eb3e361e97ea
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :497          8%          42:496   dmesg.EIP:sysfs_emit
>            :497          8%          42:496   dmesg.WARNING:at_fs/sysfs/file.c:#sysfs_emit

Cool! I will check this, thank you for the report.

-- 
With Best Regards,
Andy Shevchenko


