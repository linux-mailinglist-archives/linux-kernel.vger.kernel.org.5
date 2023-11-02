Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6D87DF298
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376522AbjKBMiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376388AbjKBMhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:37:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7815B12F;
        Thu,  2 Nov 2023 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698928659; x=1730464659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3cx3Gh97q1TI7X7Gi33Q4qSv/X460QUi4X0UkGtWr2A=;
  b=I9d+gwcw6KyFppLs7PawQpT5gUgLzFwEXwRKzPwKkmj61mRDTT9YwigH
   JI5b7U2KmVJBi6/54ybnf2EpH6+Ol4kIKISa3w2u0Z9K4nQYtUvMhzxJI
   xwhBacpy9gmMkHUKavJaoGgV0zW6TOYiQ3W+/Yz1GRmXfhI73US0b9u91
   lHVN60tIwKfz2OY7N/Q2hHApZ1QZ5ke1q+y7WEnl2mwbstR6MpdT2Ypwj
   xmnQ47ZAxtxofdnPSTW0EiOq7SlJdPDyyQb/90fRaHLaALkNTzM3VaHPw
   OoaTEk1E3apzAGPlmHHY1+Mi1bynSmNbC6lwMDN5a4N+emjH/IOOnBIS4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1627113"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1627113"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="851904992"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="851904992"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:37:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qyWx4-0000000Agc8-2yzC;
        Thu, 02 Nov 2023 14:37:34 +0200
Date:   Thu, 2 Nov 2023 14:37:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Move default strength
 assignment to a switch-case
Message-ID: <ZUOYDg9etwMR2rmy@smile.fi.intel.com>
References: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdb3wLAZfU+_E0r5Rr_HD-bdFpf7K6bMD6dqiK1Ryv7NAQ@mail.gmail.com>
 <ZUOXVSij9497HrBR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUOXVSij9497HrBR@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 02:34:30PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 02, 2023 at 08:36:11AM +0100, Linus Walleij wrote:
> > On Mon, Oct 30, 2023 at 4:54 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

(...)

> > > +               case 1: /* Set default strength value in case none is given */
> > 
> > So where does this 1 come from in the end? That's the piece I
> > am missing in this explanation. Somewhere, someone decided
> > to pass 1 to indicate "pull to default resistance".
> > 
> > Is it coming from ACPI firmware?
> 
> No, it's pure Linux kernel decision.
> gpio_set_bias() is who made that. That's why it needs to be chosen on global
> level.
> 
> We may even document somewhere that arguments let's say up to 10 do not make
> any sense in real life, as even for 1.2 v it will give 120 mA current on a single
> pin. Yet, theoretically that's possible for discrete industrial GPIOs, so we
> can choose "very big number" if such case appears in the future. I don't want

Just realized that "very big number" is limited to 16-bit value right now and
65 kOhm is quite reasonable value for the pull bias (yet we can use exact
0xffff for the "special" case).

> to change 1 to something else right now as it may break things.
> 
> > for default pull" should be added to the constant definition in the
> > code.

-- 
With Best Regards,
Andy Shevchenko


