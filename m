Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13FF773BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjHHP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHHP5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:57:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B11BD3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691509440; x=1723045440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E0EynbxGdFq+RhyKZ+D0QVNimExMQYMgYLiLwG2Hanw=;
  b=AOoeRWmOG/G6HjyR8pL1d0DjvLgrV/rZ7uhXZe4uAwv/eCoX3sbfNAMf
   ck4rHmMVGwHcxDa5Nn5n6ioGjORwt7ow9N5JPLD7d2/925qR4JS4ICONE
   ElXD9HNqwSrFvrH4EgVO9ZyMDtrumpVS1haRp4bo4XLSROUYbmHfo6c+s
   X7YPMpigl/rcxQQBxOPDdLFieSN9HnW++hr663LQNzgsiwvCTsN1CFT2N
   4lIg35EOMzHYMfrYqAvcA0D0LRK+oRtoVE4dpecFGIeWtY5M4sb2YMCwK
   Scbdn7ClDOQjK98FvFD52pEHVmlzQy9ks55BP+glf4wo8zAvJoNwgjEWk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457201114"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="457201114"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 05:56:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="708241283"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="708241283"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2023 05:55:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTMFg-008epA-1w;
        Tue, 08 Aug 2023 15:55:56 +0300
Date:   Tue, 8 Aug 2023 15:55:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNI7XO42WwEtGrCs@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <20230805114304.001f8afe1d325dbb6f05d67e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805114304.001f8afe1d325dbb6f05d67e@linux-foundation.org>
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

On Sat, Aug 05, 2023 at 11:43:04AM -0700, Andrew Morton wrote:
> On Sat,  5 Aug 2023 20:50:26 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > sprintf() and friends are used in many drivers without need of the full
> > kernel.h dependency train with it.
> 
> There seems little point in this unless someone signs up to convert
> lots of code to include sprintf.h instead of kernel.h?

You can say it to any cleanup work that starts from the baby steps.

> And such conversions will presumably cause all sorts of nasties
> which require additional work?
> 
> So... what's the plan here?

My main goal is to get rid from kernel.h in the _headers_ first.
The secondary goal as discussed with Jonathan to have IIO subsystem
be cleaned up from kernel.h (meaning C files as well) at some point.

FWIW, I have started kernel.h cleanup due to impossibility to
make bitmap_*alloc() being static inline.

-- 
With Best Regards,
Andy Shevchenko


