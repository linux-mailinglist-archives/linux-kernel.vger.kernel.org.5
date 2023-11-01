Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07507DDE72
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjKAJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:32:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA6298
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698831172; x=1730367172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BJlnHyxLxxldKBwcbK7SHbsYAPZoprDqJaMrkG5WMX0=;
  b=jmdk+oO3wVTP5QbHrXqlXoxdFSirsDG1HuwTkdmag3kQQYGY9fb0XPrA
   tpbZGeZttT3x/+bhgs0VK7b5l9JLTqMpA9EHAbdhiWqrh6mi5Xb2Rr3YS
   WiIagEUjPIG7u8JNShqxiU3EHgfSHHUzgNktbYUCx4xv4i5/zaaaHc3DI
   SnQXjEvX+zvsr0WaMg2Z/hahV6lHi5fDvQjtwMefHAH59V7/jaLSHZgDg
   Bl+f2I97bw3r7M/rLIe09IylEQOtR2FkMgNJI4G5EbIoccPg0kozJEIYr
   Q2TP2Qd0wTaYLr2q9IUQrXVsEavW9EOwVtd5CSPsRc98x/fvm9H393OZC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="419582763"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="419582763"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="710732316"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="710732316"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:32:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qy7ag-0000000APOD-1R7V;
        Wed, 01 Nov 2023 11:32:46 +0200
Date:   Wed, 1 Nov 2023 11:32:46 +0200
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
Message-ID: <ZUIbPtEEbl6pjdqg@smile.fi.intel.com>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
 <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
 <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
 <16e533e2-81bb-47ba-9e23-460a626bcad7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e533e2-81bb-47ba-9e23-460a626bcad7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:15:52PM +0100, Hans de Goede wrote:
> On 10/31/23 17:07, Hans de Goede wrote:
> > On 10/24/23 18:11, Andy Shevchenko wrote:
> >> On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:

...

> > As for the CHT support, I have not added that to my tree yet, I would
> > prefer to directly test the correct/fixed patch.
> 
> And I hit the "jackpot" on the first device I tried and the code needed
> some fixing to actually work, so here is something to fold into v3 to
> fix things:

Thanks!

But let me first send current v3 as it quite differs to v2 in the sense
of how I do instantiate GPIO lookup tables.

Meanwhile I will look into the change you sent (and hopefully we can
incorporate something in v3 for v4).

-- 
With Best Regards,
Andy Shevchenko


