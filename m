Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCC2811D40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjLMSr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjLMSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:47:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7D9F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702493251; x=1734029251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=POsCaczFV0r3vzLRIv6yKonaGaiJNwVSFqqKvK20p5E=;
  b=Ecg29BRyH/bcogRMg4QRmbUUPZlF1TVu/D/V/TiCKmk7pE8JRRET6gmS
   Lukjv2f+6siBzLtcODccSoU8UgQZaJ1AamvLDHLBe5JWPEVWFgy844OAC
   GnkBuJMu1KR3K20Ahm0hgsUeuy3+/mHifu3k2VCxn3zxGldUBIaiUB8fg
   7015A5ffBOMP+NMcG7YD6hcQ3ak9BXivLBomGNsz1BgAjevZWoRcjiw/V
   CGX45PaL3ZFHKvMF4DOvRdYFqw6Je8j+jpUmDAESml86BMuHZV+VorbmC
   ovFsYYYOjueCzwQNQJkpx4MeZH1tRA/DS7rzhgRjZzxxn0pWZaxy6odOW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1848483"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1848483"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:47:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774048780"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="774048780"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:47:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rDUGU-00000005c2W-3B7P;
        Wed, 13 Dec 2023 20:47:26 +0200
Date:   Wed, 13 Dec 2023 20:47:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alex Vinarskis <alex.vinarskis@gmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Fix the fractional clock divider
 flags
Message-ID: <ZXn8PixKBaxRUIZm@smile.fi.intel.com>
References: <20231211111441.3910083-1-andriy.shevchenko@linux.intel.com>
 <20231213161352.GQ111411@google.com>
 <ZXnZDjnor8oQNo2g@smile.fi.intel.com>
 <20231213161854.GR111411@google.com>
 <ZXnbGbjm-i7n4qU3@smile.fi.intel.com>
 <20231213174605.GS111411@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213174605.GS111411@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 05:46:05PM +0000, Lee Jones wrote:
> On Wed, 13 Dec 2023, Andy Shevchenko wrote:
> > On Wed, Dec 13, 2023 at 04:18:54PM +0000, Lee Jones wrote:
> > > On Wed, 13 Dec 2023, Andy Shevchenko wrote:
> > > > On Wed, Dec 13, 2023 at 04:13:52PM +0000, Lee Jones wrote:
> > > > > On Mon, 11 Dec 2023, Andy Shevchenko wrote:

...

> > > > > >  	tmp = clk_register_fractional_divider(NULL, name, __clk_get_name(tmp),
> > > > > > +					      0, lpss->priv, 1, 15, 16, 15,
> > > > > >  					      CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
> > > > > > -					      lpss->priv, 1, 15, 16, 15, 0,
> > > > > >  					      NULL);
> > > > > 
> > > > > What an ugly interface.  Intel-only too, right?
> > > > 
> > > > Nope, de facto way how custom clocks are being introduced.
> > > > See clk-provider.h for several similar APIs (that require an
> > > > additional, custom, flags to be supplied).
> > > 
> > > This call only has 2 call-sites, both Intel.
> > 
> > Yes, but the clock fractional divider is used wider.
> > 
> > And again, it's not related to Intel, as this how clock framework
> > does the custom clocks. I don't know how to say this clearer.
> 
> I'm not sure how you can say that.  Intel were the authors, hold the
> _only_ copyright and are the _only_ users.  If it were to be removed,
> there is only a single entity that would even notice.

_This_ API is indeed used by only Intel code right now, but the _design_
of the API is dictated by CCF, and not anyhow related to Intel.

> Anyway, it was just a passing comment.  Not positive, not negative.

Okay!

-- 
With Best Regards,
Andy Shevchenko


