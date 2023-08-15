Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE1F77CFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjHOP6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbjHOP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:58:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC3D1BF8;
        Tue, 15 Aug 2023 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692115095; x=1723651095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=o2Eb+5rz5n+LyEqDEQcpJWsHJ40eqEd9SL2bfrfu7A4=;
  b=QDiN448Itx7NQgi2HD+d77fv7NeynydSEwbIlujnipEWZ3DKHMFPmSoz
   F4u7DIMGJ7RzprCS+LW7GshocF/6gxbqXcjDSwj8aESGs7+Z1CElwYARM
   tXFR15cvCSff2Il8+0WDCrYqcVKOypAH3fIyjl8515IMyWSFuAa4Tzlsh
   5e6W+SkAfBKQIttyLLWqLJts3iJPG0NBBDf6wq3TrD2eRzcaSPlNIE88S
   UuehgiO9pk+kXgtjtu1nKfqZgeLlmmxnCstXBkI+YtOVaht/vZJw8620s
   0tAzarLv/fw3DGlbxSdSn/va4/t8lSAgrtTzoVNeUbqy8XTqm6G3NSdPv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438650368"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="438650368"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="857488813"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="857488813"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2023 08:58:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVwQs-008KLb-2S;
        Tue, 15 Aug 2023 18:58:10 +0300
Date:   Tue, 15 Aug 2023 18:58:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
Message-ID: <ZNugkmhj1Joygorj@smile.fi.intel.com>
References: <20230809131442.25524-1-brgl@bgdev.pl>
 <20230809131442.25524-2-brgl@bgdev.pl>
 <CACRpkdavsv3nJnhtdqW8ANAVfxbgHdM-SpcfOv4p_t-7EOaOHQ@mail.gmail.com>
 <20230815155253.GK212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815155253.GK212435@hirez.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 05:52:53PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 15, 2023 at 10:04:32AM +0200, Linus Walleij wrote:
> > On Wed, Aug 9, 2023 at 3:14 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:


> > > -       mutex_lock(&chip->lock);
> > > +       guard(mutex)(&chip->lock);

> Looks about right.

Btw, why don't we have something like

	guard_mutex()

to be used as

	guard_mutex(&chip->lock);

Moreover, maybe some macro that can predict the API call from the type of
the parameter?

-- 
With Best Regards,
Andy Shevchenko


