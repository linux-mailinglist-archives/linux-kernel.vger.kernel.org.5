Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1286977F322
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349490AbjHQJWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349486AbjHQJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:21:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249721FE2;
        Thu, 17 Aug 2023 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692264114; x=1723800114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Ej4qyZf0t+T5TOHw2Any1k3eMHzzTm3DotCIhPdXpA=;
  b=FwhtHTJvSVAV2vWNcTZaxqEn4LIr8ELHeNrqemBzEmCViA2RMDxuoOLA
   7XdjILx0ktRpRr5RP5+z4G63xrI3KP8/Hjl+oQon//vQT26OVSaml3UE9
   +C4qxo2C8cGbvT08D0K/8O+e1HtFEVhxbWG0m36TuCkXPdSByUjLMfRUr
   QBELFlLPjincZH6VzbnrVuf72PesDND/5cAw0qopt164SKDT5jD0vkZKi
   dc3HZxf5PV0q96J92ofe9ZMcFv4wKETI1N8UquXeO0KzcPd+ho0X0tMpK
   qDDiI7wD+BmZLxAXxFPBN+CUB1n60D6ZZhgyCximK6LHxR4cGiCprfMQ6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436664065"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="436664065"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848820018"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="848820018"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 02:21:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZCP-004xap-26;
        Thu, 17 Aug 2023 12:21:49 +0300
Date:   Thu, 17 Aug 2023 12:21:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
Message-ID: <ZN3mraFtdDhDM6Sy@smile.fi.intel.com>
References: <20230809131442.25524-1-brgl@bgdev.pl>
 <20230809131442.25524-2-brgl@bgdev.pl>
 <CACRpkdavsv3nJnhtdqW8ANAVfxbgHdM-SpcfOv4p_t-7EOaOHQ@mail.gmail.com>
 <20230815155253.GK212435@hirez.programming.kicks-ass.net>
 <ZNugkmhj1Joygorj@smile.fi.intel.com>
 <20230815203117.GA971582@hirez.programming.kicks-ass.net>
 <20230816124757.GB982867@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816124757.GB982867@hirez.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:47:57PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 15, 2023 at 10:31:17PM +0200, Peter Zijlstra wrote:
> 
> > > Moreover, maybe some macro that can predict the API call from the type of
> > > the parameter?
> > 
> > The whole type inferrence in C is not extensible. That is, you get to
> > write a single _Generic() statement, and every case that is included in
> > it will work, but the moment you use a new type, one that is not
> > included in your giant _Generic() statement, you're out of luck.
> 
> Additionally, spinlock_t, does that map to spinlock, spinlock_irq or
> spinlock_irqsave ?

Thank you for a good explanation.

-- 
With Best Regards,
Andy Shevchenko


