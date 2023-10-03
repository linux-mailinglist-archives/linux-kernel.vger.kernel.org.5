Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D797B64E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbjJCJBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjJCJBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:01:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51DA9E;
        Tue,  3 Oct 2023 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696323708; x=1727859708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j4r45DuPOKqBoDxxAsuV+SL7fxIH76HZazvWueuSR+Y=;
  b=Xm5P8ni18BmyN4fNdtBrPf1yCBcZ3jn4N0fdpj0a8m8XeT16lUB8Ldfv
   mR4tpVb5EimnXr2LyUL1Dg+CrzxQbSJi1SxRqP4dK7AF6HCMN/+npkviw
   cuzvnLBxO6KRr3y7ESooPlck7GH7gC94Q4/Ka2klfk+lhJjSNz9Znf24S
   08cpZHXg0fjG9rOoOdNo0e7886DZ2++NKGYUB7FNRjJW/N9lKY6TH/+Yo
   YuYGHHnhRGBTjcLRocEYuOQ6E/jMT2dukXZog3TcTyV5ZlqjCnRHXmIvn
   18LFZ2+s+pmgQeU9Y2nmUD17ctzo8AQofBALdM8aHgqefnD7WPaGOfFiq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385650347"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="385650347"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="750854588"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="750854588"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:01:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnbHY-00000002RKw-1KHY;
        Tue, 03 Oct 2023 12:01:32 +0300
Date:   Tue, 3 Oct 2023 12:01:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 1/2] pinctrl: baytrail: drop runtime PM support
Message-ID: <ZRvYbFF0h7OOo7Nu@smile.fi.intel.com>
References: <20231003081519.27524-1-raag.jadav@intel.com>
 <ZRvX9GUXbJksmSIP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRvX9GUXbJksmSIP@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:59:33AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 03, 2023 at 01:45:18PM +0530, Raag Jadav wrote:
> > Since Baytrail pinctrl device is not attached to acpi_lpss_pm_domain,
> > runtime PM serves no purpose here. Drop it and switch to pm_sleep_ptr()
> > as now we only have suspend and resume handles in place.
> > 
> > No functional impact.
> 
> > TODO:
> > Consider moving to DEFINE_LATE_DEV_PM_OPS() in the future once we have
> > enough users to account for its introduction.
> 
> This is not related to the commit message.
> I'll drop it.

Ah, and next time, please do a cover letter for the series, it can be
better managed from maintainer perspective.

-- 
With Best Regards,
Andy Shevchenko


