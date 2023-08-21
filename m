Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B8782519
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjHUILR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjHUILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:11:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7568B8;
        Mon, 21 Aug 2023 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692605474; x=1724141474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=boY6vv7n5cck+F2StWQLgI3FQHvNqW5BGka1J6tyivg=;
  b=QSkiHV66zXVB+poMV02CbKUNRUhejIBm20B9WR7ShZCgGh1qK10fWM15
   ZJK7xa2eLPNocQw0soVuIuSds2xjqrDos3LqRvzu+gmpVQSsfDxc32RsD
   +aD3M4AufXOtJnrPuXFtYBMOIrU7SB18r85VmNE4Rd/KoDH5qBKgP27Mt
   VF3Y0jsXmhlizYwG8AToR/0JjLneqtlrjrzvvvxvOvJgJztq5WG5dzjJb
   H2U6a4eGUWm8d0aD57bUaP2C3dMwd2TXwlrOpECSoFb9Qt2MpoTQnH8q5
   xwhpkx0CT2R1igRkDlWDowKQvlGsghE7m8ifAY5LHCsGCkY3QCW38fdcH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="370962631"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="370962631"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="770858027"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="770858027"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2023 01:11:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY00E-00540R-0e;
        Mon, 21 Aug 2023 11:11:10 +0300
Date:   Mon, 21 Aug 2023 11:11:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
Message-ID: <ZOMcHQc8Em/s6C+y@smile.fi.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
 <ZMK60UphgVuj4Z+L@smile.fi.intel.com>
 <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm>
 <ZND/8wd67YbGs8d5@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308141128260.14207@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2308141128260.14207@cbobk.fhfr.pm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:28:58AM +0200, Jiri Kosina wrote:
> On Mon, 7 Aug 2023, Andy Shevchenko wrote:

...

> > > > > > After I updated GPIO library for the case Benjamin has with CP2112,
> > > > > > I have a brief look into the CP2112 driver itself.
> > > > > > 
> > > > > > From GPIO perspective it has two main (maitenance) issues:
> > > > > > - usage of ->to_irq() with IRQ chip present;
> > > > > > - having IRQ chip not immutable.
> > > > > > 
> > > > > > Besides that there are plenty small cleanups here and there.
> > > > > > Hence this series.
> > > > > 
> > > > > Any comments on this?
> > > > 
> > > > Gentle ping^2 for this...
> > > > 
> > > > Anything should I do to improve it or is it okay to go as is?
> > > 
> > > I have been off pretty much the whole July. I am now back and slowly 
> > > making my way through everything that accumulated, I will eventually get 
> > > to this.
> > > 
> > > Thanks for the patience,
> > 
> > Ah, okay, no worries and take your time!
> > 
> > I was thinking more on Benjamin's answer as last time he had a hw setup
> > to test... Not sure what the status of that now and if he has a chance
> > to test this or busy enough with something else.
> 
> Ah, that would be of course nice. Benjamin?

Benjamin? It almost full release cycle passed...
I understand if you are busy with something, just tell us.

-- 
With Best Regards,
Andy Shevchenko


