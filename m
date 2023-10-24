Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FABD7D4E53
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjJXKz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjJXKzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:55:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92510C6;
        Tue, 24 Oct 2023 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698144950; x=1729680950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rP21uFRnfVWXZ25USLUeupGk34jQ/H1beVBH1jodnfM=;
  b=kUukX/5FAYHUo7Yffbwg5xd5rzltW2nXM0q34AH8L7xGhrLvq0vY/+PS
   HNqZei+GjOlAwMszQ39DQJ3fiPBLzJ87ZTyNl7JxyYiayUL+DDjHCVRS2
   flQLSdALx5/8TyLDWfZqwa9AIn9lri5V7k0eeuNREEGhJwrrjNB9nKh1g
   faYSwqajL0qWcV3OY2dfU1w6lEb/yzlrwgeIYzA0jDz+866DYLXKL13sK
   2CiTPF1ZZZHARHpwa8Cr3zWMNbkzWfR65gzIkoel2MI7lfJD3muRx83Ja
   aYzL0taA414vToDqfQvDTmJmTdRZExUJFIBNjt9rSr4FsotGF+Mdo4eii
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="389879602"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="389879602"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 03:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1089802807"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1089802807"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 03:55:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvF4a-00000008BgP-3Kkn;
        Tue, 24 Oct 2023 13:55:44 +0300
Date:   Tue, 24 Oct 2023 13:55:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 1/1] clk: divider: Fix divisor masking on 64 bit
 platforms
Message-ID: <ZTeisLk5zvF2Fh/B@smile.fi.intel.com>
References: <20230630183835.464216-1-sebastian.reichel@collabora.com>
 <a9756c11ea3f111d45e85e0f3928bdd8.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9756c11ea3f111d45e85e0f3928bdd8.sboyd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:34:12PM -0700, Stephen Boyd wrote:
> Quoting Sebastian Reichel (2023-06-30 11:38:35)

> > --- a/include/linux/math.h
> > +++ b/include/linux/math.h
> > @@ -36,6 +36,17 @@
> >  
> >  #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
> >  
> > +/**
> > + * DIV_ROUND_UP_NO_OVERFLOW - divide two numbers and always round up
> > + * @n: numerator / dividend
> > + * @d: denominator / divisor
> > + *
> > + * This functions does the same as DIV_ROUND_UP, but internally uses a
> > + * division and a modulo operation instead of math tricks. This way it
> > + * avoids overflowing when handling big numbers.
> > + */
> > +#define DIV_ROUND_UP_NO_OVERFLOW(n, d) (((n) / (d)) + !!((n) % (d)))
> 
> Can you get someone to review/ack this macro? Maybe Andy?
> 
> > +
> >  #define DIV_ROUND_DOWN_ULL(ll, d) \
> >         ({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })

First of all, it should be a separate patch and second, same issue is being
discussed here (as it needs to be fixed in UAPI header directly):

https://lore.kernel.org/all/your-ad-here.call-01697881440-ext-2458@work.hours/

-- 
With Best Regards,
Andy Shevchenko


