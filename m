Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707B677B768
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjHNLQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjHNLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:16:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0BFE58
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692011792; x=1723547792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KxFiqcFpllOBBtd1j20+T+HjiwbOVSrGhU2e86jRQK8=;
  b=QpVU1tY/4K7I5UAsNKtJQ4/s3Co2VCsF9/Q6c2BJZZ3GYg2ROizqi6OL
   WX5gxls90UB78sQujdtuOuhb+Mmlm3hqwhWqqx1J9ZZuNtmheHohQi3kC
   yQjhqXeEwgR6Kg1OgPJRmgY5eaEqUV4myWNUYiA4i8hXo1AuQvnmLv7ek
   6pjkhSGfxVWilWb424qxSYwLZnJS+xO8OBLurHDhxkL1m5ugWvYlH+xj9
   q9v3hlyqFG+zD13FmKsOpUzkgmp7klCpXwQQ6+PtDFLSXiFcP7H3jgMmj
   pqWENmdjoG8Qs3AxPxf8Mh1TN6sHhlCBPO9XTJ5IL7DpQ+0vHnJiDeO7D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="375721912"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="375721912"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 04:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="733416210"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="733416210"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2023 04:16:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVVYS-0021iT-2B;
        Mon, 14 Aug 2023 14:16:12 +0300
Date:   Mon, 14 Aug 2023 14:16:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNoM/LUhjG2/NHl1@smile.fi.intel.com>
References: <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
 <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
 <ZNHjrW8y_FXfA7N_@alley>
 <ZNI5f+5Akd0nwssv@smile.fi.intel.com>
 <ZNScla_5FXc28k32@alley>
 <67ddbcec-b96f-582c-a38c-259234c3f301@rasmusvillemoes.dk>
 <ZNTjbtNhWts5i8Q0@smile.fi.intel.com>
 <37faa9c7-94a3-3ea1-f116-6ff5cdf021cd@rasmusvillemoes.dk>
 <20230811152817.010e1da3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811152817.010e1da3@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:28:17PM -0400, Steven Rostedt wrote:
> On Thu, 10 Aug 2023 16:17:57 +0200
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
> > > Btw, it's easy to enforce IIUC, i.e. by dropping
> > > 
> > >   #ifndef _FOO_H
> > >   #define _FOO_H
> > >   #endif
> > > 
> > > mantra from the headers.
> > 
> > No, you can't do that, because some headers legitimately include other
> > headers, often for type definitions. Say some struct definition where
> > one of the members is another struct (struct list_head being an obvious
> > example). Or a static inline function.
> > 
> > We _also_ don't want to force everybody who includes a.h to ensure that
> > they first include b.h because something in a.h needs stuff from b.h.
> > 
> > So include guards must be used. They are a so well-known idiom that gcc
> > even has special code for handling them: If everything in a foo.h file
> > except comments is inside an ifndef/define/endif, gcc remembers that
> > that foo.h file has such an include guard, so when gcc then encounters
> > some #include directive that would again resolve to that same foo.h, and
> > the include guard hasn't been #undef'ed, it doesn't even do the syscalls
> > to open/read/close the file again.
> 
> I hope Andy was just joking with that recommendation.

Too radical to be true to implement. But it's always good to have a rationale
(thanks Rasmus) behind existing approach.

-- 
With Best Regards,
Andy Shevchenko


