Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB7771262
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjHEVcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHEVcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:32:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59DC2D54
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691271123; x=1722807123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=foxztf3bggQrYhlFlsEZq/4CQgtVKP5w/vnsGUlzlbk=;
  b=RpZQVaFRI3NzHBYZWay4x49DKPyBhG+F5BNSjw6LI2vpygRD8EfwNCyL
   KOsvWUZYX4d+q8uVdAXKSFyplF9tIZ2SGUzdoXBmin4+6OFNmJuAK70OI
   RJxy/y6ylQpC/WF3cVCr+0/oc/7FdTJW+/mCMCj9kuPlGPYGSS94BJHHQ
   mM8xaSjjZyPS/fBg+uOxWw4TC+ilnvKxtHLCb+H9TsfKPGBatmvMoOXWB
   PSy6xo0puXpB3BtYqH/DAgcRjvvYq+seoMMi+FNsSYUxp3pgX270xcLhx
   SgPrk6cEF9qSGPPKESQZdUiqexhHODSVwIqxRCBNH6JjTh7CKxT99jMQ7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="360408039"
X-IronPort-AV: E=Sophos;i="6.01,258,1684825200"; 
   d="scan'208";a="360408039"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 14:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="730458453"
X-IronPort-AV: E=Sophos;i="6.01,258,1684825200"; 
   d="scan'208";a="730458453"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 05 Aug 2023 14:32:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qSOsP-004wdI-36;
        Sun, 06 Aug 2023 00:31:57 +0300
Date:   Sun, 6 Aug 2023 00:31:57 +0300
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
Message-ID: <ZM6/za76TZyX5tdg@smile.fi.intel.com>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
> 
> And such conversions will presumably cause all sorts of nasties
> which require additional work?
> 
> So... what's the plan here?

My main plan is to clean _headers_ from kernel.h.
The rest of the code may do that gradually.

-- 
With Best Regards,
Andy Shevchenko


