Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59327DD17A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbjJaQXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344836AbjJaQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:23:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6744DF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698769384; x=1730305384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RwuuNJAK+7sQSJQmSTHK9qohrsSPiOemxUURP/vRQkk=;
  b=kAZIC+QKU2o6UiPPgdM5WsVYf+yy29LqQtAQ1/OgYow/DfjloCM+DKjJ
   ivfpG+oLNiVMQ2c/+AQMXXkSk9+I/XUtyfmneV67e0Gw86IrY6LD7St8H
   cK57KcqXArLgsH9+bdOMDSgajg2zWLNiedXAPP0YCKnIilsraOsb+KKK+
   IGmxIf5+PbzsV9S7WD1rp/YTv8sHY7N7OC1/rpRAkIjMjjLrldNGxDS5j
   YJtE97GRfnCJrDPpsVxf95JeMOaEWC+JCtxjkhK7gj0h5ZoaMHRvGtXpD
   jDDom3X+UtQSn8WpdN/ko/i3VaE9CodGDHDo1WR5X/s+QJYSSUyMS4+kH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="385509627"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="385509627"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 09:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="904391019"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="904391019"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 09:21:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxrUu-0000000ACaZ-1HwF;
        Tue, 31 Oct 2023 18:21:44 +0200
Date:   Tue, 31 Oct 2023 18:21:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 6/7] drm/i915/dsi: Replace poking of CHV GPIOs behind
 the driver's back
Message-ID: <ZUEplxH51geCyHdb@smile.fi.intel.com>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
 <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
 <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:07:39PM +0100, Hans de Goede wrote:
> On 10/24/23 18:11, Andy Shevchenko wrote:
> > On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:
> >> It's a dirty hack in the driver that pokes GPIO registers behind
> >> the driver's back. Moreoever it might be problematic as simultaneous
> >> I/O may hang the system, see the commit 0bd50d719b00 ("pinctrl:
> >> cherryview: prevent concurrent access to GPIO controllers") for
> >> the details. Taking all this into consideration replace the hack
> >> with proper GPIO APIs being used.
> > 
> > Ah, just realised that this won't work if it happens to request to GPIOs with
> > the same index but different communities. I will fix that in v3, but will wait
> > for Hans to test VLV and it might even work in most of the cases on CHV as it
> > seems quite unlikely that the above mentioned assertion is going to happen in
> > real life.
> 
> I have added patches 1-5 to my personal tree + a small debug patch on top
> which logs when soc_exec_opaque_gpio() actually gets called.
> 
> So these patches will now get run every time I run some tests on
> one my tablets.
> 
> I'll get back to you with testing results when I've found a device where
> the new soc_exec_opaque_gpio() actually gets called.

Thank you!

> As for the CHT support, I have not added that to my tree yet, I would
> prefer to directly test the correct/fixed patch.

Noted, I'll prepare a new version then.

-- 
With Best Regards,
Andy Shevchenko


