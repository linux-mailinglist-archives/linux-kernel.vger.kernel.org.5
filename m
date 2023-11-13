Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2C7E9BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjKMMNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKMMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:13:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B73D7D;
        Mon, 13 Nov 2023 04:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699877589; x=1731413589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KjFlVb/hpwo9JJSDz+au+1FquPh+IO2BdrfebCwPYaY=;
  b=DrfotMyFTDilamIjK8WRbjHsorfcOAiFq4L7atvKLO8rUB1fx7dOl40X
   OP61VTxy+T24nMSEWGCE6232riXpYPA8TVJhhMarLTptnI5pX1RRYz2TA
   ReMstcSwI5OaUppGcHpfbgfOjx97b2ReIqU4LpWtCjxD3FDO9hhHIBqrA
   VDT3cHjLUCntEr06pAB6xoUHvxfOu7VPTjaAs/DlNaupqQ6lapXI+/Pyg
   UekVnG3Lp385cDJBjOTSJe654n1Vy3zWfqSFiyonAtiAQdMn6FnXczbMg
   aI2Wy2jXaRpqJfYK2HtMg4ESRsJRYWX1AAZupWKkfdmQZCTjML4HT3c7m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369761029"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="369761029"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 04:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="908031091"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="908031091"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 04:12:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2Vo8-0000000DYPW-2BjG;
        Mon, 13 Nov 2023 14:12:48 +0200
Date:   Mon, 13 Nov 2023 14:12:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/3] pinctrl: intel: Add a generic Intel pin control
 platform driver
Message-ID: <ZVISwHwoLpy3nGDT@smile.fi.intel.com>
References: <20231030141034.3241674-1-andriy.shevchenko@linux.intel.com>
 <20231030141034.3241674-3-andriy.shevchenko@linux.intel.com>
 <20231103055738.GO17433@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103055738.GO17433@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 07:57:38AM +0200, Mika Westerberg wrote:
> On Mon, Oct 30, 2023 at 04:10:33PM +0200, Andy Shevchenko wrote:

...

> > +config PINCTRL_INTEL_PLATFORM
> > +	tristate "Intel pinctrl and GPIO platform driver"
> > +	depends on ACPI
> > +	select PINCTRL_INTEL
> > +	help
> > +	  This pinctrl driver provides an interface that allows configuring
> > +	  of Intel PCH pins and using them as GPIOs.
> 
> Add here some description that explains why this needs to be enabled,
> for example for Lunar Lake. Now it is all too generic for distro folks
> to understand if this is needed or not.

OK!

...

> > + * Copyright (C) 2021-2023, Intel Corporation
> 
> That's 2023

As-is it is still valid and reflects the history.

...

> > +	ngpps = device_get_child_node_count(dev);
> > +	if (ngpps == 0)
> 
> if (!nggps)

0 is a plain number here (as count) and explicit comparison makes sense.
But I'm okay with another form.


> > +		return -ENODEV;

...

> > +	ncommunities = 1,
> 
> Why this is 1? Can't we have more communities?

As for now (version 1.0 of the specification) it's assumed that it's one
community per device node in the ACPI, so I would leave this as is (we have
also drivers with single community per device node, hence this is kinda
pattern. Should I add a comment?

...

> > +	struct device *dev = &pdev->dev;
> > +	struct intel_pinctrl_soc_data *data;
> 
> 
> Change the ordering of the above:
> 
> 	struct intel_pinctrl_soc_data *data;
> 	struct device *dev = &pdev->dev;

Sure.

...

> > +static const struct acpi_device_id intel_platform_pinctrl_acpi_match[] = {
> > +	{ }
> 
> And add the _CID here in this patch as I commented in the last patch.

OK! I'll squash the next patch into this one.

> > +};

-- 
With Best Regards,
Andy Shevchenko


