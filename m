Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C51773FA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjHHQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjHHQta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:49:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750744AABF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510250; x=1723046250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WqUbKspfNJbqE0nLiF+n9zQ92CXed0lkUH9NGnIH5hw=;
  b=SC3kfic9a28LAx/HilnmHWZaGITda5Dt7SwxvEt8GTLUhlOVbQiqF7rD
   RT8WUsPWWRjWi3ElaHMH1S+TdP31JjEAk0ZVi794cbOMNXYd/w4jeUvS5
   E8G0azeoB2nY2X20meQwDlR3lNuTOB/XoTkntd1orKKeKfUU4NV/dERQn
   Ne6HyiFH9G1C3nkiQZlDNNpw6w0Bhv1CDxcSpuIcJttK9KYcC3iDApRnu
   JDvFOuGyPTmghKpoecPvdA+IciOgM4RjR2oC5dL2V9MqJFH/aHgkkvv7/
   EeAF7A35uwXKvmzy1ZTcIxP6gI0sica2LWSRUv5rvZDILo1Um8t0yhHsp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369711744"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="369711744"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 05:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681226171"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="681226171"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 05:49:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTM9q-008S3O-2i;
        Tue, 08 Aug 2023 15:49:54 +0300
Date:   Tue, 8 Aug 2023 15:49:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNI58vThL83P4nRY@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <20230807222455.27874f80@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807222455.27874f80@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 10:24:55PM -0400, Steven Rostedt wrote:
> On Mon, 7 Aug 2023 18:09:54 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Aug 07, 2023 at 05:03:19PM +0200, Petr Mladek wrote:
> > > On Sat 2023-08-05 20:50:26, Andy Shevchenko wrote:  
> > > > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > > > sprintf() and friends are used in many drivers without need of the full
> > > > kernel.h dependency train with it.
> > > > 
> > > > Here is the attempt on cleaning it up by splitting out sprintf() and
> > > > friends.  

...

> > > I agree that kernel.h is not the right place. But are there any
> > > numbers how much separate sprintf.h might safe?
> > > Maybe, we should not reinvent the wheel and get inspired by
> > > userspace.
> > > 
> > > sprintf() and friends are basic functions which most people know
> > > from userspace. And it is pretty handy that the kernel variants
> > > are are mostly compatible as well.
> > > 
> > > IMHO, it might be handful when they are also included similar way
> > > as in userspace. From my POV printk.h is like stdio.h. And we already
> > > have include/linux/stdarg.h where the v*print*() function might
> > > fit nicely.
> > > 
> > > How does this sound, please?  
> > 
> > Not every user (especially _header_) wants to have printk.h included just for
> > sprintf.h that may have nothing to do with real output. So, same reasoning
> > from me as keeping that in kernel.h, i.e. printk.h no better.
> 
> If you separate out the sprintf() into its own header and still include
> that in kernel.h, then for what you said in the other email:
> 
> > What to do with _headers_ that include kernel.h for no reason other than
> > sprintf.h (as an example)? Your suggestion, please?
> 
> It can include sprintf.h (or printk.h or stdio.h, whatever) instead of kernel.h.
> 
> What's the issue?

The issue is the same, printk.h brings a lot more than just s*printf().
Why should I include it for a, let's say, single sprintf() call?

-- 
With Best Regards,
Andy Shevchenko


