Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0868B79152F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbjIDJyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjIDJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:54:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C6E10EF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693821262; x=1725357262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lku24LhtQTBzblJkGEguDMUBTScmcHBrbWYLmqavMRQ=;
  b=kH7xmdR+CoetbYy0zvxmEI6YI1RbUzAKozJeHnrCK9j/qaIc6NMDfla2
   RupolZWjdLfX1luYUdWJOxmDtYNi4FjAulriNBAL0lwsmLw2EDw9+9RPL
   iIq2S+quV5+OJt+W/q+K1FQFhHelNB62daapxcKlu4WdxNMyXWFqqI/F6
   5QP1ZPTp/M8gonRvSKEx911PqUhdbQDR0GJE5SoevEot7j1Isz/q2cs0n
   RPN+NVTD5vC2G3da3qjx5JE7e0VZCNJWDvyXIlm4Rc52v2YiR7f4bPKgH
   cwF4NHfy0nlRxho3JMZ2PoYbRkxscUOhNUHyKJUn7G+ALhWJ6t8evWL1L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="356060030"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356060030"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="743878457"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="743878457"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6Hi-006ONY-0O;
        Mon, 04 Sep 2023 12:54:18 +0300
Date:   Mon, 4 Sep 2023 12:54:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] zorro: Use helpers from ioport.h
Message-ID: <ZPWpSSvOlcroyRWi@smile.fi.intel.com>
References: <20230831121623.36293-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVoDDV-VgPJL75u_t3KeAPhb1xEFX2VigVC3oS51pG6wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVoDDV-VgPJL75u_t3KeAPhb1xEFX2VigVC3oS51pG6wA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 11:31:03AM +0200, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Thu, Aug 31, 2023 at 2:16 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > We can use the DEFINE_RES_MEM_NAMED() macro and resource_contains() helper
> > instead of reimplementing them in the code. No functional change intended.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/zorro/zorro.c
> > +++ b/drivers/zorro/zorro.c
> > @@ -117,17 +117,13 @@ static struct resource __init *zorro_find_parent_resource(
> >         int i;
> >
> >         for (i = 0; i < bridge->num_resources; i++) {
> > -               struct resource *r = &bridge->resource[i];
> > -
> > -               if (zorro_resource_start(z) >= r->start &&
> > -                   zorro_resource_end(z) <= r->end)
> > -                       return r;
> > +               if (resource_contains(&bridge->resource[i], &z->resource)
> 
> Missing closing parenthesis. What happened to your cross-compiler?
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue in the m68k for-v6.7 branch, with the above fixed.

I have usually three problems with it:
1) wrong branch to test;
2) no proper config is enabled;
3) other things due to my stupidity.

Choose one for this on your taste :-)

AFAIU you fixed that locally and applied (or going to). Thank you!
Otherwise tell me if I need to resend.

-- 
With Best Regards,
Andy Shevchenko


