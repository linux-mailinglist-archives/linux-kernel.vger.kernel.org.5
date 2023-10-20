Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7057D0CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376736AbjJTKPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376596AbjJTKPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:15:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14CACC;
        Fri, 20 Oct 2023 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697796931; x=1729332931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2TIqSN9T6bPg5PoltWfdwivatK05gbf6nUPnbeBe0nQ=;
  b=HonY1UIhnE8m9D1S3ZHL+5wfRI+KSRPEl3t8+e7Yp220ITzk9n89pva6
   ZdICDi0Fa7a1N522nZGAtPuFqWmaZHVeawmBsJX4C5H7A9jNBMv6YeRCN
   h2wVezMhoIFe18aAJ1Cf+qx6F9XX425Dgk5N8L/9pBGh4ITJSSSFJ4koP
   DX/4SEGwrYBSPUxkmufj7nwS8vyvgprkYO5KTvCIluEcFE46/RchwWJj+
   SA3pX8HJqQ7q5sBFQZMDAaAlwrYzHd6+jVOV4F83hsOtUDS76dgKngIYh
   Bx/bnWWYNdLTvTDXpEUQ+KCpVsE5ZRbEYvOwl/G3D4CGTC47ixiw1ytuy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="8035914"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="8035914"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:15:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="881041854"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="881041854"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:15:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtmXK-000000077Rb-38KP;
        Fri, 20 Oct 2023 13:15:22 +0300
Date:   Fri, 20 Oct 2023 13:15:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v3 1/2] amba: bus: balance firmware node reference
 counting
Message-ID: <ZTJTOpoBnX3c+VP1@smile.fi.intel.com>
References: <20231006145732.3419115-1-andriy.shevchenko@linux.intel.com>
 <169756785858.2487391.2620832432762980006.robh@kernel.org>
 <ZS7VrxX6If8Afl5R@smile.fi.intel.com>
 <CAL_JsqLsdjiAYupw-U-voLWGaJoiUTW49PJJYXAhG1podivP5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLsdjiAYupw-U-voLWGaJoiUTW49PJJYXAhG1podivP5w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:15:43PM -0500, Rob Herring wrote:
> On Tue, Oct 17, 2023 at 1:43 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 17, 2023 at 01:37:43PM -0500, Rob Herring wrote:
> > > On Fri, 06 Oct 2023 17:57:31 +0300, Andy Shevchenko wrote:

...

> > > Applied, thanks!
> >
> > Thanks, I hope w.o. patch 2 as it seems it can't be enabled on non-ARM
> > platforms due to some strange MM APIs.
> 
> Yes, just patch 1. Isn't it just the driver with the error that can't
> be enabled, not all ARM_AMBA. I suspect there's a more portable
> variant of what was causing the error, but didn't investigate more.

Yeah, I think so but it's not the first time I saw such non-portable APIs in
the drivers as they were (mistakenly?) designed as ARM-only.

-- 
With Best Regards,
Andy Shevchenko


