Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690D27E0522
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjKCO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKCO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:58:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB46D47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699023515; x=1730559515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n4Ft9Khqw6FLR8Iq73ZS5MUfE2ucW9GHgqqIE2K9DSQ=;
  b=D7FlDwl3DI0sDG2yZfX5xFrX6y3/4rU4dC0pTJDuaIWDks4/UoTzAjIH
   BqGZoB/z3Bn3RCWNe2YtZTy2h3tSAi7vwj/lyns93+HCQZ5BrH7q+JUGO
   E+c3C13GARqTanj5ZA3SKa60nvKTtI/068sA9/XWaSCsUw75MM9WSDImZ
   6F65wvqzczG+c3TIt+puMqw72Hv3qqabi591Dm9sRpOogELYN2Yv0shIC
   nndBXO4L5j9NjqOpU3335Rk8bX67OIL+2UnY4Jgowr248Zm8fkcQuVwAf
   P7MCJW9FJJp7bA5Wb7nIQYGhl3qyCfY6TYzP+jhjPJBxhmq10ILPjBYqZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="373994953"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="373994953"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 07:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="796638792"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="796638792"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 07:58:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qyvcy-0000000B32M-2lAq;
        Fri, 03 Nov 2023 16:58:28 +0200
Date:   Fri, 3 Nov 2023 16:58:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Chen Ni <nichen@iscas.ac.cn>, lee@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Fix IRQ check
Message-ID: <ZUUKlK-_bWHCftS_@smile.fi.intel.com>
References: <20231101062643.507983-1-nichen@iscas.ac.cn>
 <20231101070310.GF17433@black.fi.intel.com>
 <ZUIclOuVocLUUk7_@smile.fi.intel.com>
 <20231101104717.GH17433@black.fi.intel.com>
 <ZUOYR1l9D5s3bI37@smile.fi.intel.com>
 <20231103064140.GP17433@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103064140.GP17433@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 08:41:40AM +0200, Mika Westerberg wrote:
> On Thu, Nov 02, 2023 at 02:38:31PM +0200, Andy Shevchenko wrote:
> > > > > > -	if (!info || !info->mem || info->irq <= 0)
> > > > > > +	if (!info || !info->mem)
> > > > > 
> > > > > This check (info->irq <= 0) covers both "invalid" interrupt numbers
> > > > > (that's the negative errno and 0 as no interrupt) so I don't see how
> > > > > this change makes it any better and the changelog does not clarify it
> > > > > either.
> > > > 
> > > > It makes sense. The IRQ here may not be 0. We should actually fix
> > > > the PCI code to guarantee that (platform_get_irq() guarantees that
> > > > in platform driver).
> > > 
> > > Yeah but I mean the check above handles any "invalid" interrupt number
> > > just fine regardless. I don't see any point changing that.
> > 
> > The point is to have proper error code to be returned. Currently it's shadowed
> > in this check.
> 
> Looking at this more, this patch actually introduces a bug.
> 
> We pass pci_dev->irq from intel-lpss-pci.c and that comes directly from
> PCI core that assigns it in pci_read_irq(). This value is unsigned int
> for starters so it is not designed to contain an error code, secondly it
> can be 0 meaning "no IRQ" either if is SRIOV device or the interrupt
> line is not assigned. I actually think SRIOV is a possibility for future
> LPSS devices so we should be dealing with this properly.

I could argue that this patch _reveals_ the bug in PCI that needs to be
addressed.

-- 
With Best Regards,
Andy Shevchenko


