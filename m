Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE27709BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjHDUeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjHDUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:34:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E9F4C2D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691181249; x=1722717249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ie3+Tp8HSJL5p5a626rZ9+1bzRCSCac0mPMAN935+jg=;
  b=hhl1yViY5b3601jlhethoQpo+FF2KpQ7R3cjDxBJwKuxLl4F8MZwAT08
   pHmhDSWl3C0ayGj7EwAHkfTdPCV0mA6IxDGqittIAw2GLASbYOprveb9h
   iMUiDiw+7dFNmgPC6VAQZ4qkFDBvQvnxOZ0ZNLRKQQ56zH7GFiTbyMvUI
   3iGYHu+eNrvIYYUK9mRz4jlbkBtqPQLLmmCBIIvrIzQxHAMw71mGjtInM
   /shoFLw8G0qCRmujjB2P+BPYuQMRqq5ugF6DvYaEk1T7WRyKMUp7fNoQH
   jfVbV5jLZJGNng1y4zr0aCKgE9vXBF2c/cHc8QIpjcy+lxJ4LxQfxrzxM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="456619034"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="456619034"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 13:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="680087031"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="680087031"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2023 13:34:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qS1Up-0070AP-2g;
        Fri, 04 Aug 2023 23:34:03 +0300
Date:   Fri, 4 Aug 2023 23:34:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 4/4] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZM1gu3+x9uLnDwVB@smile.fi.intel.com>
References: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
 <20230804082619.61833-5-andriy.shevchenko@linux.intel.com>
 <71ce8516-21cb-32c6-84d3-b3f9bb3d625b@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ce8516-21cb-32c6-84d3-b3f9bb3d625b@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 11:31:58AM +0200, Rasmus Villemoes wrote:
> On 04/08/2023 10.26, Andy Shevchenko wrote:

...

> > +#include <linux/types.h>
> 
> Shouldn't this at least also include compiler_attributes.h, to make it
> self-contained?

As I replied in the other email, this is guaranteed by types.h.
But if you insist, I can add it.

> As Marco said, please just declare no_hash_pointers in this file as
> well. Perhaps with a comment about not accessing it unless one has good
> reason, but I suppose that's true in general for all kernel global
> variables, so maybe not worth it for this one.

Sure, thank you for the review!

-- 
With Best Regards,
Andy Shevchenko


