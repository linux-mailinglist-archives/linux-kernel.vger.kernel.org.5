Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7281D782660
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjHUJfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjHUJfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:35:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06434A1;
        Mon, 21 Aug 2023 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692610534; x=1724146534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fB2XI/PxSUETG+AsQIenqdqmaoGWnt7ws1F6VGdHMeE=;
  b=lIWpx3kLU6ZsXTMese4cXFeqhaKO5m2QY5gBRZXG2XjJO0fY0t5lQ5Dd
   ltTAEPjay693gPvwxigVZRFoEfh3zhnZNQ9wO+jr055YTGkr9eVeAIJxc
   +OIGfxQlJrMoQFHEwK21Vk7U0YnhVerPelaifW0o5NtOVTU780k1QCFaH
   NnS0P0SRU3nNi6Lb76IJshAxORXJ0cRnRtdrQPvRK3VIj7NV0p/vx5e8b
   TbD0E7t5X1QHd2xiDfyeXevhW3e73OugTTtnJDY4lKm9dKT+bL7I8a0n+
   3A4/IacTm3GoUn7HzvRPFxk75z9H4urNfEKp8rEjM05sk5MT08VJoWxPQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="437466086"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="437466086"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 02:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="805868248"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="805868248"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2023 02:35:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY1Jq-007vPY-0f;
        Mon, 21 Aug 2023 12:35:30 +0300
Date:   Mon, 21 Aug 2023 12:35:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
Message-ID: <ZOMv4VB0bZpupNlN@smile.fi.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
 <ZMK60UphgVuj4Z+L@smile.fi.intel.com>
 <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm>
 <ZND/8wd67YbGs8d5@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308141128260.14207@cbobk.fhfr.pm>
 <ZOMcHQc8Em/s6C+y@smile.fi.intel.com>
 <ez2oewpi3yeaiejrvbe433ude75pgm3k3s5sh5gnn7pvnzm7b4@ajuopfgwocft>
 <ZOMvpmoWLCgcAyJR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOMvpmoWLCgcAyJR@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:34:30PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 21, 2023 at 10:51:04AM +0200, Benjamin Tissoires wrote:
> > On Aug 21 2023, Andy Shevchenko wrote:

...

> > Long story short, I'm not able to test it right now (and I got quite
> > some backlog as you can imagine). IIRC the code was fine, so I think we
> > can just take the series as is, and work on the quirks (if any) later.
> 
> Thank you!
> 
> The thing that might be broken is interrupts handling. If that works,
> I'm pretty confident with the rest.

I.o.w. first 5 patches to test is already 98% of guarantee that everything
is fine.

-- 
With Best Regards,
Andy Shevchenko


