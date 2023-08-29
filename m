Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8878C51F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbjH2NX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbjH2NXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:23:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83C11BF;
        Tue, 29 Aug 2023 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693315382; x=1724851382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XsOalVaIilKSnqJ168eGblRrPPVV7yvX6wZpdU+7mg8=;
  b=mR3JDtxeSXIh+bLRTIPqUoMYOjfNcDveZxlQxMLd1GQJJdHSLUGisKfn
   6hGY+2RZAMSXSSWkJlYE+L4E+A2vReXXo8Wt+rgTHx8rms9zouXPOq9p5
   Ya+XaWB057LIw1UCiCr1RRMgedax+C9ZEWh7GG20bY0qFk9KMZbVXTEk6
   xjbVjT4nwM68AyFG7Df8lF75ubyE9fju+pjUpDIVRhT2EuNtPtCthCA0d
   O8Mdp9DR93CgI71u7nF6o84A3R2kVXwADP7fiHijSGltrl8899R/yBMs6
   vvXebRU0H4rSYK71EV7YE+i/lKmVNIBlErA4iomsduQMTdsYpJ+fzyb4H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="354878077"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="354878077"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="985352731"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="985352731"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2023 06:22:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qaygL-004t9W-1h;
        Tue, 29 Aug 2023 16:22:57 +0300
Date:   Tue, 29 Aug 2023 16:22:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/3] types: Complement the aligned types with signed
 64-bit one
Message-ID: <ZO3xMQv/4HEhPktX@smile.fi.intel.com>
References: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
 <20230828171018.2ee59df7@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828171018.2ee59df7@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:10:18PM +0100, Jonathan Cameron wrote:
> On Tue, 15 Aug 2023 18:40:25 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Some user may want to use aligned signed 64-bit type.
> > Provide it for them.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Excellent.  I'll pick this up once the minor things in the first two
> users are resolved (as long as no one argues we shouldn't have this
> for some reason!)

I'll cook a new series sooner than later. Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko


