Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3D7E9B75
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjKMLxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKMLxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:53:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751EED6C;
        Mon, 13 Nov 2023 03:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699876398; x=1731412398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=L5BaIpp1w6C71nPUGd/W2TImQRoCRT8NntlWKS9HTyc=;
  b=nhC+84qmkTu4VAhA+gdI75ragpe8OUthxB6GwPv3sC8MboptN/h5fYYH
   WKK+s8IF1TAH4RJztctDiSPepGxxA0a2LGKx3nZOKi2/pzOSP1RKHkkL8
   4JeumdLmHlCWFHtlyJimm1FvpU90lp1i3GhFKtbHdC5XGXEkRA40DXdhj
   gslmcmG4/acwS8fYgdmHB9ReRB5ka2STWIxMQoSE8BA0CkqSkzUy51Jo2
   B8mHQ6K2LMab0Iy9/Kr2NSTbH1xL3mJaEijbmmBxNYkqPEqb57KOIRXgh
   fRP7VuS5nheJ7ZcV4zqsFHeUtM04NN4vnm743nnfhtt8lT1+ONFLRCzos
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="3506155"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="3506155"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 03:53:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="757781076"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="757781076"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 03:53:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2VVA-0000000DY1n-3aSN;
        Mon, 13 Nov 2023 13:53:12 +0200
Date:   Mon, 13 Nov 2023 13:53:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Move default strength
 assignment to a switch-case
Message-ID: <ZVIOKMf9fDh6qjC6@smile.fi.intel.com>
References: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdb3wLAZfU+_E0r5Rr_HD-bdFpf7K6bMD6dqiK1Ryv7NAQ@mail.gmail.com>
 <ZUOXVSij9497HrBR@smile.fi.intel.com>
 <CACRpkdaYpgg7Umc3=QZ1QxH=jzt-wJh+msu5DuVn1aRUvzkeGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaYpgg7Umc3=QZ1QxH=jzt-wJh+msu5DuVn1aRUvzkeGA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 01:56:08PM +0100, Linus Walleij wrote:
> On Thu, Nov 2, 2023 at 1:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Nov 02, 2023 at 08:36:11AM +0100, Linus Walleij wrote:
> 
> > > So where does this 1 come from in the end? That's the piece I
> > > am missing in this explanation. Somewhere, someone decided
> > > to pass 1 to indicate "pull to default resistance".
> > >
> > > Is it coming from ACPI firmware?
> >
> > No, it's pure Linux kernel decision.
> > gpio_set_bias() is who made that. That's why it needs to be chosen on global
> > level.
> 
> Aha I see, that makes sense.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


