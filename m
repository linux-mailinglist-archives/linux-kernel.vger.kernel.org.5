Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A0D7DF29D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376403AbjKBMiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376379AbjKBMio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:38:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEFE197
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698928716; x=1730464716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P0/Xt85LX/gplXPKMJhGwaLX5bFksjydXcwt6V+SytI=;
  b=KCFq0GthXMyTjGKZRaqw3Neodttd7iiadBgP68CRy/upo1ILoQAxu/02
   RGwK/RAjaZXExnVdrVvDJkYHPcUmOuw2xfHO2c8AA1vddDgoyda5DhEis
   b4jhhHfCL4sLrCx/LuBZ8MaDG7Xj0Jf24NcYel+Q1+B+OPZ3UaDVO2gsp
   P+0kmT8uppjULzRA2D7FU9XoR+jOlTn39V78gNDwninvukTwD/EUJLyZZ
   AJzYn+FIGm3RMw8+SFZKcbwLkR1qjpf3Q02xHJ1TElae/nxzhMqRiS6FU
   +nqElSNmEn6R675qlAqzW3xoSoZM/zSqeqbpqZBCi83xziuawkLkd2QFt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="392585824"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="392585824"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="761286316"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="761286316"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:38:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qyWxz-0000000Agck-1kAj;
        Thu, 02 Nov 2023 14:38:31 +0200
Date:   Thu, 2 Nov 2023 14:38:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Chen Ni <nichen@iscas.ac.cn>, lee@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Fix IRQ check
Message-ID: <ZUOYR1l9D5s3bI37@smile.fi.intel.com>
References: <20231101062643.507983-1-nichen@iscas.ac.cn>
 <20231101070310.GF17433@black.fi.intel.com>
 <ZUIclOuVocLUUk7_@smile.fi.intel.com>
 <20231101104717.GH17433@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101104717.GH17433@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 12:47:17PM +0200, Mika Westerberg wrote:
> On Wed, Nov 01, 2023 at 11:38:28AM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 01, 2023 at 09:03:10AM +0200, Mika Westerberg wrote:
> > > On Wed, Nov 01, 2023 at 06:26:43AM +0000, Chen Ni wrote:

...

> > > > -	if (!info || !info->mem || info->irq <= 0)
> > > > +	if (!info || !info->mem)
> > > 
> > > This check (info->irq <= 0) covers both "invalid" interrupt numbers
> > > (that's the negative errno and 0 as no interrupt) so I don't see how
> > > this change makes it any better and the changelog does not clarify it
> > > either.
> > 
> > It makes sense. The IRQ here may not be 0. We should actually fix
> > the PCI code to guarantee that (platform_get_irq() guarantees that
> > in platform driver).
> 
> Yeah but I mean the check above handles any "invalid" interrupt number
> just fine regardless. I don't see any point changing that.

The point is to have proper error code to be returned. Currently it's shadowed
in this check.

-- 
With Best Regards,
Andy Shevchenko


