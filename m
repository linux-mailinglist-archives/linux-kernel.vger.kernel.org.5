Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E952D7DE009
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjKALDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjKALDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:03:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDD0111
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698836583; x=1730372583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZm2FRo0QlZe3vUOYch1zlq/LSJxNku5I2xXeQeO+Z8=;
  b=D3770ckfFt0mGY5baVx4CrNpJAtNBUDTGTSnYRYQmr13GSsOMkbUB13Q
   IKPMx5MkOFZlTXPnSATTldSfC46KZvCCja24tmr160MrclE0+WsMaRiaX
   Rp4S65vkKvNcOTmhmNdT65HLD2PJIW+rcDSQVNcff+E29Mr/s4mfHUEh1
   hBZroPybmTIDXwm8wiUB/kuD4dolSUp1cH1pmoSX0RnXosqBCJw4mg6PP
   zOyK+DpJUMEExWYeInlE1HSBul3oZ9UgTE0lrWUTHR6l+Nx7aQVQsf7Ci
   Jj1LucmBB0KeabbCajwJyrxkw5f143ws4+n1Y+TuqAhjg/0KxWufGg+3g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="385652013"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="385652013"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 04:03:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="884530390"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="884530390"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 01 Nov 2023 04:03:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A61D054A; Wed,  1 Nov 2023 12:47:17 +0200 (EET)
Date:   Wed, 1 Nov 2023 12:47:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Chen Ni <nichen@iscas.ac.cn>, lee@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Fix IRQ check
Message-ID: <20231101104717.GH17433@black.fi.intel.com>
References: <20231101062643.507983-1-nichen@iscas.ac.cn>
 <20231101070310.GF17433@black.fi.intel.com>
 <ZUIclOuVocLUUk7_@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUIclOuVocLUUk7_@smile.fi.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:38:28AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 01, 2023 at 09:03:10AM +0200, Mika Westerberg wrote:
> > On Wed, Nov 01, 2023 at 06:26:43AM +0000, Chen Ni wrote:
> > > platform_get_irq() returns a negative error code to indicating an
> > > error. So in intel_lpss_probe() the unset / erroneous IRQ should be
> > > returned as is.
> > > 
> > > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> 
> > There is no need for Fixes tag here.
> 
> I said that already in v1 :-)
> 
> ...
> 
> > > -	if (!info || !info->mem || info->irq <= 0)
> > > +	if (!info || !info->mem)
> > 
> > This check (info->irq <= 0) covers both "invalid" interrupt numbers
> > (that's the negative errno and 0 as no interrupt) so I don't see how
> > this change makes it any better and the changelog does not clarify it
> > either.
> 
> It makes sense. The IRQ here may not be 0. We should actually fix
> the PCI code to guarantee that (platform_get_irq() guarantees that
> in platform driver).

Yeah but I mean the check above handles any "invalid" interrupt number
just fine regardless. I don't see any point changing that.
