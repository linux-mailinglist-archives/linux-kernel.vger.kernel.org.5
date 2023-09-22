Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C0B7AB3B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjIVObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjIVObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:31:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC41A3;
        Fri, 22 Sep 2023 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695393075; x=1726929075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RfDOh01dsGLCl9FfwUATjf4cBSql92IKvvisAzVKqmA=;
  b=XIKS8lxieQRheoxBOUX5sX9uLW4mHmam1GwGe8eeuSyOCC46axJztpcg
   IEevzENmnscA3hZfNtaE2xpf7CYEf68y0sBMz9bh18UeBZaXpk9KBKztB
   6Z5FqqIKiwutg7SEFGxM7JoIadRDGzlC3w0YugOB7Yw6AciMcqVCTWSJd
   2h4T2FBLwPRRMnbKAloqi+5M2x3dVUxZnSnn3agZNUrKitDNDsA22NaTc
   S2U+CXmLcvnPrpt2wpoXYyyxwPAr/zTt9F2f+Pzdcm0l0ZBrXJ98/CMqZ
   sqSy06EOkGYSI7docSjeqDuDb5CTwcFmtDU/wNUlDGRHBI5nQ/pbYwFEk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="360220475"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="360220475"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="741113412"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="741113412"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:31:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjhBT-0000000HCxc-2Wlf;
        Fri, 22 Sep 2023 17:31:07 +0300
Date:   Fri, 22 Sep 2023 17:31:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v1 1/1] amba: bus: balance firmware node reference
 counting
Message-ID: <ZQ2lKz41zFEX2rbK@smile.fi.intel.com>
References: <20230824162654.2890992-1-andriy.shevchenko@linux.intel.com>
 <ZQn+IMMuPpwwZGPp@smile.fi.intel.com>
 <ZQn+UVgBTgFco6hT@smile.fi.intel.com>
 <CAL_JsqJAjxoCctHd4Eo+Hq0SBvc0G3RaEbC4P_jPsPq0LZYHzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJAjxoCctHd4Eo+Hq0SBvc0G3RaEbC4P_jPsPq0LZYHzQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 09:18:47AM -0500, Rob Herring wrote:
> On Tue, Sep 19, 2023 at 3:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Sep 19, 2023 at 11:01:37PM +0300, Andy Shevchenko wrote:
> > > On Thu, Aug 24, 2023 at 07:26:54PM +0300, Andy Shevchenko wrote:
> > > > Currently the ACPI code doesn't bump the reference count of
> > > > the firmware node, while OF counter part does. Not that it's
> > > > a problem right now, since ACPI doesn't really use the reference
> > > > counting for firmware nodes, it still makes sense to make code
> > > > robust against any changes done there. For this,
> > > >  - switch ACPI case to use device_set_node() to be unified with OF
> > > >  - move reference counting to amba_device_add()
> > > >  - switch to use firmware nodes instead of OF ones
> > > >
> > > > In the result we will have reference counting done in the same module
> > > > for all callers independently on the nature of firmware node behind.
> > >
> > > Any comment on this? I would like to have this applied so I can do something
> > > similar to the platform driver code.
> >
> > Ah, I see, I missed LKP run on this, I'll send a v2 perhaps later on this week.
> 
> What's the relationship/dependency with this and the other patches
> dealing with refcounting? Did the AMBA one land?

The OF refcounting is spread over platform code in unexpected places. So, we
have something like of_foo() bumps it, platform ->release() drops it. It sounds
to me as weird design to think of and AMBA is part of this mixture as it uses
platform_bus, BUT has it's own ->release(), besides the fact that it's used in
OF _and_ ACPI environments.

What I would expect to have is both are really agnostic to the fwnode type
and take and release reference in one place, but with OF <--> platform is
kinda more complicated that with AMBA.

-- 
With Best Regards,
Andy Shevchenko


