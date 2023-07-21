Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A25075C816
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGUNpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGUNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:44:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA20E1731;
        Fri, 21 Jul 2023 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689947097; x=1721483097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W2c5i87m641xZTDORa7IxxqDokmk7rzBhkbolV0mLj8=;
  b=DFv+Gq4bk+x2+DPZc2qCZtujbn53vUMXE7+MAAwm3XXeyTiuNb9z8Q0z
   2pA+RcMPKqPI1yS/3WWx/ryhdZSNLp0ZKdUVTjLgtDp2LF/kKas6IPx1I
   sxjVj4l9DXydW/ubxAb70kg4mNG8CF7wFOIKKV+l1oHw6GeR3FgzhMpiy
   MaMoYh0UgrIuanBMbagIcDzIBzpmwoadDn2/RyqPAVXHUTjk+MGUDkB46
   /FxqyD5abEqkpDOdFH+2UYcnvLjHjtENOqJXbaOuJfz7dFH6lW8YvDKPd
   4dpCN3GqzrsWkAeVHeM0HMrLvm+mLzLY1EX4JBBdpycwVmHflBVnMFtwM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="346622538"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346622538"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 06:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="759961069"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="759961069"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2023 06:44:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qMqRA-006oT6-1K;
        Fri, 21 Jul 2023 16:44:52 +0300
Date:   Fri, 21 Jul 2023 16:44:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] media: i2c: ds90ub953: Restructure clkout
 management
Message-ID: <ZLqL1LinK21Pkx+K@smile.fi.intel.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
 <20230720-fpdlink-additions-v2-6-b91b1eca2ad3@ideasonboard.com>
 <ZLpeHG9/99YjdKtW@smile.fi.intel.com>
 <2e2417fb-97a1-7153-6ba9-88a6d50f962a@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e2417fb-97a1-7153-6ba9-88a6d50f962a@ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:23:54PM +0300, Tomi Valkeinen wrote:
> On 21/07/2023 13:29, Andy Shevchenko wrote:
> > On Thu, Jul 20, 2023 at 01:30:37PM +0300, Tomi Valkeinen wrote:

...

> > > +struct ub953_clkout_data {
> > > +	u32 hs_div;
> > > +	u32 m;
> > > +	u32 n;
> > 
> > I don't think it makes driver worse. The V4L2 UAPI has similar struct which is
> > used widely, hence I see no issues in using u32_fract here.
> 
> I think it makes sense to use u32_fract in common code. My argument for not
> using it here is:
> 
> - There is no actual functionality that u32_fract brings, so it's really
> only about field naming
> - m and n matches the terms in the HW documentation, making it easier to
> compare the code and the docs
> - This is private to the driver
> - I'm (currently) the most likely person to edit the driver, and I would
> have to check which one that numerator/denominator was again when looking at
> this part of the code (but maybe I would learn eventually)
> 
> So, in my view, the change doesn't really have any pros but does have cons.
> 
> That said, it's not a biggie. If others chime in and say it's a good idea to
> use u32_fract, I'm fine doing that change.

Thank you for a good summary of your point of view.
I agree that others, esp. maintainers, can decide
on how to proceed with this suggestion.

-- 
With Best Regards,
Andy Shevchenko


