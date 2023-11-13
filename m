Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F018E7E9C71
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjKMMxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKMMxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:53:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A662D7E;
        Mon, 13 Nov 2023 04:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699880018; x=1731416018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gBQ3rqlQpRh7qgsxRECw0OU/rnWQCddI4JFcR8EXNRU=;
  b=LzcBtBfrPF6W6GsalUYBYl1Adzbr/EkMlY+xqO6Pi4eaTanVrDVwSTh6
   oGNcogRCekk5l1H0gvU51iZshV9dSncT28JYcY0e1xjNRXJXxE6qN1IFM
   k45hJT9iSo5Ke2tqp3XHLVirKGzhdQj3JzKCmjS5nPj0ICKt0fwLy6Fcb
   B/oSog18GfnD1gbiacVJBrSqAm+mp8AJbF/QPRDX46CSK3tFGGBoS1NJC
   +jscobfOiS4zcYFnQoqUwg1gZeOabTVLuAb2e3SeEhK+UbgCxCM5YgWlF
   8y1TTG23O2/vuL5Zcyoc1t+f/Z12j3Gf//FBT3sW/tedJLnChWgtwuQDy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="3513668"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="3513668"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 04:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="757793492"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="757793492"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2023 04:53:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3FA3664A; Mon, 13 Nov 2023 14:53:34 +0200 (EET)
Date:   Mon, 13 Nov 2023 14:53:34 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/3] pinctrl: intel: Add a generic Intel pin control
 platform driver
Message-ID: <20231113125334.GQ17433@black.fi.intel.com>
References: <20231030141034.3241674-1-andriy.shevchenko@linux.intel.com>
 <20231030141034.3241674-3-andriy.shevchenko@linux.intel.com>
 <20231103055738.GO17433@black.fi.intel.com>
 <ZVISwHwoLpy3nGDT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVISwHwoLpy3nGDT@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 02:12:48PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 03, 2023 at 07:57:38AM +0200, Mika Westerberg wrote:
> > On Mon, Oct 30, 2023 at 04:10:33PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > +config PINCTRL_INTEL_PLATFORM
> > > +	tristate "Intel pinctrl and GPIO platform driver"
> > > +	depends on ACPI
> > > +	select PINCTRL_INTEL
> > > +	help
> > > +	  This pinctrl driver provides an interface that allows configuring
> > > +	  of Intel PCH pins and using them as GPIOs.
> > 
> > Add here some description that explains why this needs to be enabled,
> > for example for Lunar Lake. Now it is all too generic for distro folks
> > to understand if this is needed or not.
> 
> OK!
> 
> ...
> 
> > > + * Copyright (C) 2021-2023, Intel Corporation
> > 
> > That's 2023
> 
> As-is it is still valid and reflects the history.
> 
> ...
> 
> > > +	ngpps = device_get_child_node_count(dev);
> > > +	if (ngpps == 0)
> > 
> > if (!nggps)
> 
> 0 is a plain number here (as count) and explicit comparison makes sense.
> But I'm okay with another form.
> 
> 
> > > +		return -ENODEV;
> 
> ...
> 
> > > +	ncommunities = 1,
> > 
> > Why this is 1? Can't we have more communities?
> 
> As for now (version 1.0 of the specification) it's assumed that it's one
> community per device node in the ACPI, so I would leave this as is (we have
> also drivers with single community per device node, hence this is kinda
> pattern. Should I add a comment?
> 

Yes, I think it warrants a comment.

> ...
> 
> > > +	struct device *dev = &pdev->dev;
> > > +	struct intel_pinctrl_soc_data *data;
> > 
> > 
> > Change the ordering of the above:
> > 
> > 	struct intel_pinctrl_soc_data *data;
> > 	struct device *dev = &pdev->dev;
> 
> Sure.
> 
> ...
> 
> > > +static const struct acpi_device_id intel_platform_pinctrl_acpi_match[] = {
> > > +	{ }
> > 
> > And add the _CID here in this patch as I commented in the last patch.
> 
> OK! I'll squash the next patch into this one.
> 
> > > +};
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
