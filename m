Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECECC77F317
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349480AbjHQJSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349527AbjHQJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:17:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501AA3596
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692263858; x=1723799858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PLuy+Xy6YP4LzcN7ciTfB9SWRSrTcIOvq3XwcRzSaD0=;
  b=mfKceFb7l5EH96H07B+yz+nLUmUD8v0wZz1vwCycPhqK4KiQpID25rgC
   VpAXV0RfoJU8YmOlmhjMqdQGfpyrpBfnODH4crOc7bbaMtFqa7lIhVYa7
   yiHiG/gE019qyHYPkVVrXlIdfm5dwyTLt8/TbEsTEDf+57acv4ZWrKihh
   kL7qXEWdxdSFg9iXYihRi+zJQUEA09oayzHvh8kU0Hc0tAW6KdsA1lsO3
   8kxcoKDqkjgdsjUn/k9Y90G+vI28PRqH+Pto4EaFc9SiewoRUyny9YB1u
   7Q0Qrlv+SQJF+txi3Ezc63CvN1IfU9Nof1a2PU5YYzbArQzFaVqkvIzpK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375523534"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="375523534"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799962228"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="799962228"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2023 02:17:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZ83-004o1i-1i;
        Thu, 17 Aug 2023 12:17:19 +0300
Date:   Thu, 17 Aug 2023 12:17:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/4] genirq/irq_sim: dispose of remaining mappings before
 removing the domain
Message-ID: <ZN3lnwsP52KAzfYm@smile.fi.intel.com>
References: <20230812194457.6432-1-brgl@bgdev.pl>
 <20230812194457.6432-2-brgl@bgdev.pl>
 <ZNtVuUWTZa0gLwXz@smile.fi.intel.com>
 <CAMRc=MeJS9-EF3EEAV8EW1UN2_pcafyc9ckHHjwTQVJnfxOVMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeJS9-EF3EEAV8EW1UN2_pcafyc9ckHHjwTQVJnfxOVMA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:38:41PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 15, 2023 at 12:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Aug 12, 2023 at 09:44:54PM +0200, Bartosz Golaszewski wrote:

...

> > > +#include <linux/list.h>
> >
> > Maybe ordered?
> >
> 
> This patch comes first in the series as it's meant to be a
> backportable fix. Header ordering comes later.

It does not prevent you from putting it in the better place.
So the followup will be a less churn.

-- 
With Best Regards,
Andy Shevchenko


