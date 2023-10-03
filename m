Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1247B6909
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjJCMcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJCMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:32:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B28B0;
        Tue,  3 Oct 2023 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696336321; x=1727872321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jR3ZKAYCJVTRHgBSKndRIk5g9K8kLHYUqYX4OOReHaU=;
  b=W8c55kZnuShOr5/KQzrJ4j8trOFSHCYDV1RiiMsNqkez7es0uVzoWbxa
   2tg5nf4PMCbkmrSy5voW4JJBB6Ny+SIwDrXtJz8DqEk6SH3QrDSw6utKG
   NUPXb67/2btbfo4bHIupVMbDUOTvuSyFd2mszduEGV825BUdct0TmGtSi
   XznM0dfNa1dubEweV2dbu6f+i468+kF/zQoiVt7biHtKLzkeakZrcw1ix
   yxLFu9YINHLJJCdBAI6cjDJhD0JzxauVSeBZs7pNpT2P3qi4D/z0VpIAj
   RoD+LuyLcohXDiZl4nndze08iZcvBWUqQxBX2NBNE63D+/99bF4/cOSTq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362232612"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="362232612"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="780289792"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="780289792"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:31:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qneZ9-00000002U2c-1S6b;
        Tue, 03 Oct 2023 15:31:55 +0300
Date:   Tue, 3 Oct 2023 15:31:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 0/2] Drop runtime PM support for Baytrail and
 Lynxpoint pinctrl
Message-ID: <ZRwJu23K1aEH5xsl@smile.fi.intel.com>
References: <20231003114036.27674-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003114036.27674-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 05:10:34PM +0530, Raag Jadav wrote:
> This series removes runtime PM support for the devices that are not
> explicitly attached to acpi_lpss_pm_domain as it is dead code anyway.
> 
> This has no functional impact and helps reduce their code and memory
> footprint.
> 
> bloat-o-meter:
> ==============
> 
> Baytrail:
> add/remove: 2/4 grow/shrink: 0/3 up/down: 49/-103 (-54)
> Total: Before=16104, After=16050, chg -0.34%
> 
> Lynxpoint:
> add/remove: 7/10 grow/shrink: 1/3 up/down: 152/-223 (-71)
> Total: Before=7506, After=7435, chg -0.95%

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


