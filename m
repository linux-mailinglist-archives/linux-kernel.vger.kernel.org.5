Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751DD7EF928
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbjKQVGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:06:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B7CB6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700255191; x=1731791191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P/2jZ6JHxUbZa9SDIcVD15ATpthu+hET9d9WFIL3VoU=;
  b=HDt4vLdVAL3werq5LYHDuhjkxNLH6tMOvkB48zaiM9piZPVOo6Wwq78+
   jkbZAFtpDMVzogOEgycYgjY5DfP0Nh4vp23+k3sgOPTzL0LbrpLnu3wiB
   ljaBBr98azNgew4b7nhWJhwrEV2dQhKg7n3OHjwx7yLBJWpNhILa3ZGGw
   SuTE2wIncf+jfUo5olFOuSdRSYDE0qHpvL1rdVIlHGojcLgmGvLWwNRf3
   rMx7Xmpzjxq2UQL8fbj9yASVW87ETGwjP9XxaxocFgM0h8GQ1CyKKKVQg
   eX0xAf+fOs/AGnM5D4Kfna7rTQZvi5hnN+DZqvUfjfuuXrsiBVX9/3od5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="371547064"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="371547064"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="769319948"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769319948"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:06:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r462j-0000000Eu2V-3x4X;
        Fri, 17 Nov 2023 23:06:25 +0200
Date:   Fri, 17 Nov 2023 23:06:25 +0200
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
Subject: Re: [rft, PATCH v4 00/16] drm/i915/dsi: 4th attempt to get rid of
 IOSF GPIO
Message-ID: <ZVfV0XIsUXSekXb5@smile.fi.intel.com>
References: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
 <e66638b0-bbad-4ac7-ad93-6fb0c6147005@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66638b0-bbad-4ac7-ad93-6fb0c6147005@redhat.com>
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

On Thu, Nov 16, 2023 at 09:58:06AM +0100, Hans de Goede wrote:
> On 11/3/23 21:18, Andy Shevchenko wrote:
> > DSI code for VBT has a set of ugly GPIO hacks, one of which is direct
> > talking to GPIO IP behind the actual driver's back. A second attempt
> > to fix that is here.
> > 
> > If I understood correctly, my approach should work in the similar way as
> > the current IOSF GPIO.
> > 
> > Hans, I believe you have some devices that use this piece of code,
> > is it possible to give a test run on (one of) them?
> 
> Ok, this now has been testen on both a BYT and a CHT device which
> actually use GPIO controls in their MIPI sequences so this
> series is:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> And the code of the entire series also looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> for the series.

Good news so far, thank you!

-- 
With Best Regards,
Andy Shevchenko


