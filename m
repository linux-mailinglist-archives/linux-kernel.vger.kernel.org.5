Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA3778A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjHKJfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHKJfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:35:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0210126BC;
        Fri, 11 Aug 2023 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691746507; x=1723282507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=30FA1fvKG5fhZ6OZRVeFBPQmbmKp7z1629d+RxTdjE8=;
  b=CXI8dxjSm3KZggL8O3drWaQ+nZ0twgrcMsN16yC+cEfsQom56giMluiH
   maKp3Pw0vHre76/hniiEG2d6E3iWQktXOzyAZMbB55AFLsfbiM/LaaaNX
   bT/kX0X1dXjEFrxLHfBaXuzKApcOzC8TWTmVYamH5EjH5T6dfWQhuPq32
   VUiMWnldUZGdbV9rQUB+xbFnkeJhtfT/g24b4SZHqy0mIPVXlJYPsU34F
   Vioq2mFL183mJ59PDIxZlJwrtxSm10UYP7B7w8qR275OqE9CTJYCjh/+Y
   AEM+Je8j1diLZt58edJsKLOlVLVJNujgmHHDeLhrZ0QfiLyKZ5qT7Aln5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="458012637"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="458012637"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="979183085"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="979183085"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2023 02:35:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qUOXt-008lwF-1P;
        Fri, 11 Aug 2023 12:35:01 +0300
Date:   Fri, 11 Aug 2023 12:35:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: core: Fix serial core port id, including
 multiport devices
Message-ID: <ZNYAxb3eSJ63w7U9@smile.fi.intel.com>
References: <20230810065737.47294-1-tony@atomide.com>
 <ZNUBHaDTsAXVNNLZ@smile.fi.intel.com>
 <ZNUBvZQcbBbCziXU@smile.fi.intel.com>
 <20230811051121.GL11676@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811051121.GL11676@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 08:11:21AM +0300, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [230810 15:26]:
> > On Thu, Aug 10, 2023 at 06:24:13PM +0300, Andy Shevchenko wrote:
> > > On Thu, Aug 10, 2023 at 09:57:34AM +0300, Tony Lindgren wrote:

...

> > > > +	unsigned int min = 0, max = ~0U;
> > > 
> > > Shouldn't this be int? The max IIRC will be INT_MAX with this anyway.
> > 
> > Ah, and then you can supply is as 0 (IIRC).
> 
> The returned id will be INT_MAX, but idr.h uses unsigned int:
> 
> int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
> 
> If there's some reason to limit max id we can do it, otherwise it's just
> a don't care flag.
> 
> Please clarify if I'm not following what you are suggesting :)

	... max = 0;

Will have the same effect with more explicit intention "use whatever maximum is
default". With ~0U I would expect to see something bigger than INT_MAX, but it
won't ever appear.

-- 
With Best Regards,
Andy Shevchenko


