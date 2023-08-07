Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D867728CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjHGPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjHGPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:11:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657C9172A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691421046; x=1722957046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XE7lAmwu44QiLaUDvsnQL76XBEMqgW2TS+j1d7xf+c0=;
  b=mhwojDK9+75ZKbBIGFGX99ArPh5AND7uYoKwZmmUxbJp1WXWnMw+jA6c
   TGUOK75VOQZoYVY0etiyoPEfLGHqvDVG9hAj2pC14RdQI6f+N6Ex0181J
   X1sLRGh3pA/vYoJ5ppFY1z1MblSIMxj50d6pVdbdtEvRGfVMPK3+RgfOh
   8ElBwtKLR4+yp6taITmGCkNUTOdwC/gtqmgJ7FMBbR6l/2i8QT+2VZLIq
   bOzgzbZC+1Y9phXaqkIEiUiE6gSKegnmnU4OiB+szNvLgeTYO5807fz83
   CXO3Sc9thx69EWsxIrU849Eu19kDr45zC62ns+sNfxJkDvO9Zn+F/fQfB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374246594"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="374246594"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="904797907"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="904797907"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 07 Aug 2023 08:09:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT1rm-00Gkcv-2K;
        Mon, 07 Aug 2023 18:09:54 +0300
Date:   Mon, 7 Aug 2023 18:09:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEHt564a8RCLWon@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 05:03:19PM +0200, Petr Mladek wrote:
> On Sat 2023-08-05 20:50:26, Andy Shevchenko wrote:
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > sprintf() and friends are used in many drivers without need of the full
> > kernel.h dependency train with it.
> > 
> > Here is the attempt on cleaning it up by splitting out sprintf() and
> > friends.

...

> I agree that kernel.h is not the right place. But are there any
> numbers how much separate sprintf.h might safe?
> Maybe, we should not reinvent the wheel and get inspired by
> userspace.
> 
> sprintf() and friends are basic functions which most people know
> from userspace. And it is pretty handy that the kernel variants
> are are mostly compatible as well.
> 
> IMHO, it might be handful when they are also included similar way
> as in userspace. From my POV printk.h is like stdio.h. And we already
> have include/linux/stdarg.h where the v*print*() function might
> fit nicely.
> 
> How does this sound, please?

Not every user (especially _header_) wants to have printk.h included just for
sprintf.h that may have nothing to do with real output. So, same reasoning
from me as keeping that in kernel.h, i.e. printk.h no better.

-- 
With Best Regards,
Andy Shevchenko


