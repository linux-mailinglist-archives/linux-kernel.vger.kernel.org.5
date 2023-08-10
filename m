Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F733777992
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjHJN1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjHJN1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:27:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1E726B1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691674052; x=1723210052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CX/8PWwRlzjURvCQeMfP60m3SD6Gi3s5IWlgF68o6U0=;
  b=k1E2b6+a8TRBd/qcGg4ySKyL904CcB0zvhRCEtkVGEu+znRWET/Pf0tM
   fDKszxAdVrcNOJoqFO8gIEB13QVeUDWA3qNW75TmB/+jqlzwvWafbCLQ3
   Jf+0TyW7Cwno1DOg3EN/Jvy82awpkzua47N84RSZouSN2TG/l5NbYHs/V
   47ehH2R+dbJkXH9C9zOK8rCM0syix4gY/VwO3OT6VamBv6/NNxgkJEULD
   MtumXkoF/RNj9BXUYfT8d8OzQ7wohCRWYCQz9Ie/P2U+mwDQqVjPR4WWb
   g5bQ9XLDpngcdhLLSX203HYDsaId+iw9PA1xrT4LVPaoqKfaJv8Z+dw1T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="370298866"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="370298866"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 06:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875714029"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2023 06:17:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU5Xj-002PH0-0V;
        Thu, 10 Aug 2023 16:17:35 +0300
Date:   Thu, 10 Aug 2023 16:17:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNTjbtNhWts5i8Q0@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
 <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
 <ZNHjrW8y_FXfA7N_@alley>
 <ZNI5f+5Akd0nwssv@smile.fi.intel.com>
 <ZNScla_5FXc28k32@alley>
 <67ddbcec-b96f-582c-a38c-259234c3f301@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ddbcec-b96f-582c-a38c-259234c3f301@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:09:20AM +0200, Rasmus Villemoes wrote:
> On 10/08/2023 10.15, Petr Mladek wrote:

...

> >     + prolonging the list of #include lines in .c file. It will
> >       not help with maintainability which was one of the motivation
> >       in this patchset.
> 
> We really have to stop pretending it's ok to rely on header a.h
> automatically pulling in b.h, if a .c file actually uses something
> declared in b.h. [Of course, the reality is more complicated; e.g. we
> have many cases where one must include linux/foo.h, not asm/foo.h, but
> the actual declarations are in the appropriate arch-specific file.
> However, we should not rely on linux/bar.h pulling in linux/foo.h.]

Btw, it's easy to enforce IIUC, i.e. by dropping

  #ifndef _FOO_H
  #define _FOO_H
  #endif

mantra from the headers.

-- 
With Best Regards,
Andy Shevchenko


