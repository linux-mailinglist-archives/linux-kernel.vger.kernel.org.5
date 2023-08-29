Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8778C650
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbjH2NnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbjH2Nmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:42:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40AE5B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693316543; x=1724852543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5JjrPIoCQIvaXLE5zJ2itJpmzGQj92dNt3ToYHiGyLk=;
  b=lb3ua4zAdnZf7V5kNGBwuAYIiZmT5YCFT7x/KRhcOsSQSRCYE4AnLjnF
   r6+9FuJ/5RxXDkm+jMiQ2n2+AFqpOu9HceeIlRzfhouPwHEDJ8YX/fa/Z
   jlSckG/CDPR4PCEt86DzxfkzlDXEMJWsHRsWEBqIEI6UXgyZi88hOMzbw
   S/++vZ0fa3VGBe2Z7tubAGpf87Vi18bAn4QAktKQN/kdE/q+oVx/6vnOt
   qP0TJlW9WdWtBXcbE+n0xAbjOmlr8oIsUvAHneFcyGDt+69fM30X600SW
   P7jocxw3LkWHuA6b2Om5GKWrIuqSU/vSFdDt9VSUe9lkMZimn4yibfOFS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="379138362"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="379138362"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="985354870"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="985354870"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2023 06:38:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qayvZ-004tN8-2C;
        Tue, 29 Aug 2023 16:38:41 +0300
Date:   Tue, 29 Aug 2023 16:38:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] bitmap: rework bitmap_{bit,}remap()
Message-ID: <ZO304SCFoP2wmnNA@smile.fi.intel.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
 <5247e354-cb7f-4df7-37a5-95cebed43d4c@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5247e354-cb7f-4df7-37a5-95cebed43d4c@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 09:33:29AM +0200, Rasmus Villemoes wrote:
> On 28/08/2023 20.43, Yury Norov wrote:
> > This series adds a test, const-time optimizaton and fixes O(N^2)
> > complexity problem for the functions. It's based on discussion in
> > bitmap: optimize bitmap_remap() series [1], but there's much more work
> > here, so I decided to give it a separete run, and don't name it as v2.
> > 
> > bitmap_remap() API has just one user in generic code, and few more in
> > drivers, so this may look like an overkill. But the work gives ~10x
> > better performance for a 1000-bit bitmaps, which is typical for nodemasks
> > in major distros like Ubuntu.
> 
> Can you find just _one_ project on Debian Code Search or elsewhere that
> actually uses mbind(2), that could possibly ever trigger the use of that
> bitmap_remap stuff? Also, the bitmap may be order 10, but that's just
> because the kitchen sink distros are silly, real machines have nowhere
> near that number of nodes, so even if mbind is used, the bitmaps
> involved will never actually have anything beyond index ~64.
> 
> I think this is all total overkill for non-existing problems, and when
> it takes me 20 seconds to find the first bug, I really don't think it's
> worth the churn. I'm not giving a thorough review on the rest of the
> series, nor commenting on followups.

I posted one patch to replace these APIs with something else, more particular
for GPIO case(s). Have you chance to look at that? With that taking in, I'm
fully agree on the above statement (as we lose the user of this complicated
thingy which is a niche of the NUMA as you mentioned already).

-- 
With Best Regards,
Andy Shevchenko


