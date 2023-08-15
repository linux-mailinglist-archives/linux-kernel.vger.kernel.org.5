Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A4F77CD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbjHONDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237372AbjHONDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:03:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19AE10C1;
        Tue, 15 Aug 2023 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692104598; x=1723640598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0NaBjGHbMZjcD7dyeE2IOkqncW3pch7CbgmgQYzt9SI=;
  b=UeKV7H9GcjCiDnHPQX+QKDYQdEQ1tXULO4kI9d2DD5lpgeW0t0irsKg0
   nSMqOo1kAHXEjLhHSuRuyXyedyl60m4DTMXXX1517qtJO9+rY4L99F8dT
   cKcwnHMgMrfS1Ia3Y4N7lOeqemPzqCxwSF2KWD4okwis+rqwggF0JsLXE
   btEPdrnvu+2MvMNhQfjq2VFU9wmVZuKZIDPXN/v2jXHj+bHSEaHid4ET/
   Ry1QFET4VTHlJQY0mal9NKZtDm0nXDUW8TEdWISUAkNSGitP8iTusiyxY
   jGtgVfuNnwmOXr9VnkOgnsjgk91SaWmoDPFqD8d9F2Nak1rij4wgDN440
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403251019"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="403251019"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 06:03:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="803813841"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="803813841"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2023 06:03:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVthX-002HbB-0G;
        Tue, 15 Aug 2023 16:03:11 +0300
Date:   Tue, 15 Aug 2023 16:03:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1 0/4] Reuse common functions from pinctrl-intel
Message-ID: <ZNt3joaolej9B8wy@smile.fi.intel.com>
References: <20230814060311.15945-1-raag.jadav@intel.com>
 <20230814073405.GX14638@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814073405.GX14638@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:34:05AM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Aug 14, 2023 at 11:33:07AM +0530, Raag Jadav wrote:
> >  drivers/pinctrl/intel/Kconfig              |  6 +-
> >  drivers/pinctrl/intel/pinctrl-baytrail.c   | 90 +++-------------------
> >  drivers/pinctrl/intel/pinctrl-cherryview.c | 69 +++--------------
> >  drivers/pinctrl/intel/pinctrl-intel.c      | 30 ++++----
> >  drivers/pinctrl/intel/pinctrl-intel.h      | 12 +++
> >  drivers/pinctrl/intel/pinctrl-lynxpoint.c  | 86 ++-------------------
> >  6 files changed, 57 insertions(+), 236 deletions(-)
> 
> This is really nice reductions of lines :-)
> 
> For the whole series,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


