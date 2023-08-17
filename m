Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7077F861
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351726AbjHQOIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351712AbjHQOHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:07:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E6519E;
        Thu, 17 Aug 2023 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692281270; x=1723817270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vNdDKtouzhu9+Inu5Ih3J1Ppb7aFydQrlRApI+2a65M=;
  b=BduJ/LweeK1T7yw/naT+GujuI/C62WGTROoKi8YmD+mu9kfES/HS9e1F
   3znAiScRZIWjxaRWCgSTXe0lneMb6DZFX26AfqRa0V2jbMsoizY+fib5V
   KFUBFbgu1gh0p7ja5pEmr/zRIMr4XJCpSKrQKFpsxjF8+kulEGBnPhdI1
   a89SmxAcs6xf4lcBQy5YZd65bW8ro7qXEs8t8882MgFE+7E+JG43NZFfg
   c7SQFJy4eFZnD+b/enkDRHYyIwuYtLlWGY2n2qfab+e5m1GfTgee791GO
   V3CkMxanS1gB48BApbTnGX6GtAf7A5bQyocKdXKFznwSR797PW41ooLwX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352404137"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="352404137"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="734671083"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="734671083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 07:06:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWddu-00Ehx4-1H;
        Thu, 17 Aug 2023 17:06:30 +0300
Date:   Thu, 17 Aug 2023 17:06:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of/platform: increase refcount of fwnode
Message-ID: <ZN4pZqowqDLmst5Y@smile.fi.intel.com>
References: <20230812122411.3410399-1-peng.fan@oss.nxp.com>
 <ZN39I7w4ARc0WLnI@smile.fi.intel.com>
 <ZN3+XzfK00vXPiHO@smile.fi.intel.com>
 <DU0PR04MB9417B3FE767FA06FFFEE018A881AA@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417B3FE767FA06FFFEE018A881AA@DU0PR04MB9417.eurprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 01:13:01PM +0000, Peng Fan wrote:
> > On Thu, Aug 17, 2023 at 01:57:39PM +0300, Andy Shevchenko wrote:
> > > On Sat, Aug 12, 2023 at 08:24:11PM +0800, Peng Fan (OSS) wrote:

...

> > > > -	device_set_node(&dev->dev, of_fwnode_handle(node));
> > > > +	device_set_node(&dev->dev, fwnode_handle_get(fwnode));
> > >
> > > Ditto.
> > 
> > Actually no, amba_device_alloc() does not use platform_device_alloc() and
> > defines it's own .release method. There is no reference count drop there
> > AFAICS.
> 
> My test only covers platform device, so ..
> 
> But I have a general question here. Since of_amba_device_create will use
> the of_node or fwnode, shouldn't the refcount_t be increased and released
> in amba device release?

I believe so.
Basically we need two changes:
1) this one with the suggested modifications, and
2) fix the reference count leak in amba release.

-- 
With Best Regards,
Andy Shevchenko


