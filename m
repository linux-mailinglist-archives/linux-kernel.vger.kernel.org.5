Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF38811948
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377302AbjLMQ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379383AbjLMQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:26:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62E591
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702484779; x=1734020779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q82MA+J7j3N6bQ85PNxR0xck1Z52kqDFLIJ5jhv5BJU=;
  b=lDbYrak0FhABCY6XWFrgVw163ckh1TvzTwQKLprDQXDvNSYutiEnayzi
   4bF5qb9dwBDdWqhOoe/VYQ/iimrJn2NcuxGpWmnk5vF2935vsVjPqTPdx
   rAez67vc7W3V8iHjZFTLuZ89X6IsiMcH6rJySb5jdA2gXP/lV0rapB29u
   +HSFdmT2LLfscmAbPI0bQzPMz5JMT8z1LvwuSi9t2BnBJjnvYPHhRh4Tu
   YSUCU7n6mvGi2Q5fVpkH+mMJ/REFIk1rryMkqVp8t4oTt1LD3SxmM2h/T
   mPRSw7IxTQF4BHNz5N1NCiX39sW8zU1ltuAQ3EFlEzSU6CCO6sUrkjwR/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394742084"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="394742084"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:26:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="808213061"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="808213061"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:26:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rDS3d-00000005ZWp-2wpH;
        Wed, 13 Dec 2023 18:26:01 +0200
Date:   Wed, 13 Dec 2023 18:26:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alex Vinarskis <alex.vinarskis@gmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Fix the fractional clock divider
 flags
Message-ID: <ZXnbGbjm-i7n4qU3@smile.fi.intel.com>
References: <20231211111441.3910083-1-andriy.shevchenko@linux.intel.com>
 <20231213161352.GQ111411@google.com>
 <ZXnZDjnor8oQNo2g@smile.fi.intel.com>
 <20231213161854.GR111411@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213161854.GR111411@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 04:18:54PM +0000, Lee Jones wrote:
> On Wed, 13 Dec 2023, Andy Shevchenko wrote:
> > On Wed, Dec 13, 2023 at 04:13:52PM +0000, Lee Jones wrote:
> > > On Mon, 11 Dec 2023, Andy Shevchenko wrote:

...

> > > >  	tmp = clk_register_fractional_divider(NULL, name, __clk_get_name(tmp),
> > > > +					      0, lpss->priv, 1, 15, 16, 15,
> > > >  					      CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
> > > > -					      lpss->priv, 1, 15, 16, 15, 0,
> > > >  					      NULL);
> > > 
> > > What an ugly interface.  Intel-only too, right?
> > 
> > Nope, de facto way how custom clocks are being introduced.
> > See clk-provider.h for several similar APIs (that require an
> > additional, custom, flags to be supplied).
> 
> This call only has 2 call-sites, both Intel.

Yes, but the clock fractional divider is used wider.

And again, it's not related to Intel, as this how clock framework
does the custom clocks. I don't know how to say this clearer.

Whatever, thank you for review and applying this fix!

-- 
With Best Regards,
Andy Shevchenko


