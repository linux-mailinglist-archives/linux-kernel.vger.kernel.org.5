Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A647EF923
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjKQVGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQVGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:06:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8DCD52
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700255161; x=1731791161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aT2WVaBK/OG0nienKZxPLkMpvLciTyV3MOhYksMFC+c=;
  b=gGT1TycHdV6I8z/qa3Qh3XyguBWRSpnZ2hV/uMNm7PIa+4eXCMuXnwwx
   EUAjBbrgX/I96IkmctuTiLR3dOyS75c2/DF4gcoIp0/lE1J9+HypjlbUO
   uZ5kkUDmXfJyAwjSSqs3l2K+BeSyj9Ss5QnK1I0w+e0uZge9tS/g5huHQ
   gajD6HOeuxd/2LtEzsMh8FOINZfFO1LYlmdJeh5nlzDy3Fz+fFRL0LyDS
   th1HfWjEANezw/UcTo5kvAsr87owXcx536ZhcA2/mkTeYGQqLNIX5J+iP
   873wxi+1cD5JCDEvaNrJGt/xpvct6K5mAnRiifFovGurg2FZJGN6ihvCY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="371546988"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="371546988"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="742187505"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="742187505"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:05:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r462E-0000000Eu2D-0uzm;
        Fri, 17 Nov 2023 23:05:54 +0200
Date:   Fri, 17 Nov 2023 23:05:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [rft, PATCH v4 00/16] drm/i915/dsi: 4th attempt to get rid of
 IOSF GPIO
Message-ID: <ZVfVsVDQ9j7nMsnW@smile.fi.intel.com>
References: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
 <e66638b0-bbad-4ac7-ad93-6fb0c6147005@redhat.com>
 <871qcqqa1k.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qcqqa1k.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 12:15:03PM +0200, Jani Nikula wrote:
> On Thu, 16 Nov 2023, Hans de Goede <hdegoede@redhat.com> wrote:
> > Ok, this now has been testen on both a BYT and a CHT device which
> > actually use GPIO controls in their MIPI sequences so this
> > series is:
> >
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> >
> > And the code of the entire series also looks good to me:
> >
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> > for the series.
> 
> Thanks Andy & Hans!
> 
> I'll merge this once the test results are in. The BAT results have been
> a bit flaky recently, so needed to do a rerun.
> 
> That said, I'm not sure if we have any hardware in CI that would
> actually exercise the modifications, so in that sense I trust Hans'
> testing much more.

Thank you!
Should I fix checkpatch warnings CI reported about?

-- 
With Best Regards,
Andy Shevchenko


