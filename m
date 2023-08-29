Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981EB78C72F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjH2ORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbjH2OQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:16:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D7C0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693318605; x=1724854605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mIXi4VnZ2Tu1yVzadE65zNJqQwtahCq6DztaxKEtuMc=;
  b=e93/F9xkbMH6pPU2PxmM1GWtqK72kmS9ZUFUyoQZEazDrOhX8RGGxKvy
   oaSdAPhSYnqDSKq0zAy3GkfxizdxXuTSo8RcRruRT9i1rEO0hFo8WsItl
   CyWTIuYqYw/qKGEenFRLnG2YPHYIMTYL6yBmuDXG5jmii2RSPRumZKmZs
   m4//oev4s6jDhNp1vG5Z+5oBJ1/CFmY3a/KZsJR43zxNsRb+yOWTy2phs
   TuuHJGwtW+XJxHrDmk7brYx+s5+I7olSm4OKkK/y6xnVmmkwHBYulzJLh
   ye0V/8LKAKfaUm2nGqlgSPQKCKdJbKE0HCGu/onxdAeBDpYtPIu0uRmUB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="439329358"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="439329358"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="862259273"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="862259273"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2023 07:16:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qazWC-004tqV-1k;
        Tue, 29 Aug 2023 17:16:32 +0300
Date:   Tue, 29 Aug 2023 17:16:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ALSA: control: Use list_for_each_entry_safe()
Message-ID: <ZO39wMfKDmXc1+ms@smile.fi.intel.com>
References: <20230829135252.3915124-1-andriy.shevchenko@linux.intel.com>
 <87ttsit08x.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttsit08x.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 04:02:38PM +0200, Takashi Iwai wrote:
> On Tue, 29 Aug 2023 15:52:52 +0200,
> Andy Shevchenko wrote:
> > 
> > Instead of reiterating the list, use list_for_each_entry_safe()
> > that allows to continue without starting over.

> Through a quick glance, it should be OK, but I need to read and
> understand whether this change is perfectly safe or not -- unless
> Jaroslav gives his review and ack.

Sure.

> > ---
> > 
> > Takashi, if you have anybody or want yourself to spend some time,
> > I believe you can simplify a lot the parser in this file with
> > the help of lib/cmdline.c APIs.
> 
> Thanks for the hint.  Yeah, it looks feasible, but too late for 6.6,
> it's a nice TODO ;)

Of course.

Just a reference what I did to gpio-aggregator module:
ac505b6f5fa8 ("gpio: aggregator: Replace custom get_arg() with a generic next_arg()")
deb631c40114 ("gpio: aggregator: Replace isrange() by using get_options()")


-- 
With Best Regards,
Andy Shevchenko


