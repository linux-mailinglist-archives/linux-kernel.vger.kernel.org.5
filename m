Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CF77BDCC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjHNQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjHNQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:18:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407BBF1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692029888; x=1723565888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ep/RLZyH8YvmQby9LCngd+7o67ISxlSmm6w9+qiLu6U=;
  b=S/7VE0d7RKS2P0XMblJuvH49J6pbWGGyI0CMZhOAJ+TbRBTocUxaKCLZ
   Y0+HIOq0etv1VKtVb2PzTz9ImbAPlCjQl0/LZH8r3idPlilrrQZsVz1Gm
   z52kCEPycdxx0iDw4YLGil7Uab4tsl7zY6ccdhghTDNBiuWZ3Rr4o4SRi
   XkhV+ri/7aupG71fdgXPcT2VyQLQ96PuuBoHFwspL6tAjmiiNHedsIxFp
   5x71wKpbjbCi5eY1+s+pMwnWpKA/j0FkFa7aeTCglHLDbu+REfaYKP/gK
   40b9gjfOpAeEiDDz587EDqWB9bbuh4EAzRenXmnebqm1q2z9Y70QRnad6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369547679"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="369547679"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 09:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="823500297"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="823500297"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2023 09:11:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVa9v-00CAed-3B;
        Mon, 14 Aug 2023 19:11:11 +0300
Date:   Mon, 14 Aug 2023 19:11:11 +0300
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
Subject: Re: [PATCH v2 0/3] lib/vsprintf: Rework header inclusions
Message-ID: <ZNpSH13mUAWyI0HW@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <ZNpKaausydIB_xRH@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNpKaausydIB_xRH@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:38:17PM +0200, Petr Mladek wrote:
> On Sat 2023-08-05 20:50:24, Andy Shevchenko wrote:
> > Some patches that reduce the mess with the header inclusions related to
> > vsprintf.c module. Each patch has its own description, and has no
> > dependencies to each other, except the collisions over modifications
> > of the same places. Hence the series.
> > 
> > Changelog v2:
> > - covered test_printf.c in patches 1 & 2
> > - do not remove likely implict inclusions (Rasmus)
> > - declare no_hash_pointers in sprintf.h (Marco, Steven, Rasmus)
> > 
> > Andy Shevchenko (3):
> >   lib/vsprintf: Sort headers alphabetically
> 
> I am sorry but I am still against this patch?
> 
> >   lib/vsprintf: Split out sprintf() and friends
> >   lib/vsprintf: Declare no_hash_pointers in sprintf.h
> 
> I am fine with these two.
> 
> Would you mind preparing v3 without the sorting patch, please?

Yes. Thank you for the review.

-- 
With Best Regards,
Andy Shevchenko


