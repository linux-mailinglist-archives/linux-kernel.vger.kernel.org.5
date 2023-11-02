Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6A7DF4CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376759AbjKBOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKBOT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:19:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4618DB7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698934793; x=1730470793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YIoOazyZIxRBLXmipC//1yjCBmIXsr31xOo/Ttayfpw=;
  b=L/qu+/6P0OEbXeaLA//3+PWkfVdyJ+v7MYTKofEvtktBADnEz3DL3QOX
   UzUaE7NSq/MiRlxmZMX694LbCoDJSyml0GVbt2QA1CIHHV8BOe2ylV8GL
   CoqunAIpqT8q7gmyr52GFUX85u3UL+cS1SB7u+JRx0qTKvc5Lk0/lH8TC
   psPiMFRB4QDriI2qGBzT0mX/TzTovspAwjE7gTZTd+QyRQPezFR4UTjwq
   jpdVhYGZDqWJNxJln5QA/wtQszQNjrUo2OFYqsaIA4XayiMtR367wjY1a
   HBrUNke2Hj7v5LoRR7OisBs1aI0Sej7mwM5cqTIsORG8yzbNLpdLsIMH9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1647426"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1647426"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 07:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="831702572"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="831702572"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 07:19:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qyYXy-0000000AhvZ-3fkX;
        Thu, 02 Nov 2023 16:19:46 +0200
Date:   Thu, 2 Nov 2023 16:19:46 +0200
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
Message-ID: <ZUOwAn158pUELTBq@smile.fi.intel.com>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
 <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
 <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
 <16e533e2-81bb-47ba-9e23-460a626bcad7@redhat.com>
 <ZUIbPtEEbl6pjdqg@smile.fi.intel.com>
 <f68dca47-d9ed-a146-b152-c19bcc9d8828@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68dca47-d9ed-a146-b152-c19bcc9d8828@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:20:23AM +0100, Hans de Goede wrote:
> On 11/1/23 10:32, Andy Shevchenko wrote:
> > On Tue, Oct 31, 2023 at 10:15:52PM +0100, Hans de Goede wrote:
> >> On 10/31/23 17:07, Hans de Goede wrote:
> >>> On 10/24/23 18:11, Andy Shevchenko wrote:
> >>>> On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:

...

> Note you still need the first part of my patch which is
> an unrelated bugfix:
> 
> --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> @@ -219,8 +219,7 @@ static void soc_exec_gpio(struct intel_connector *connector, const char *con_id,
>  	} else {
>  		gpio_desc = devm_gpiod_get_index(dev_priv->drm.dev,
>  						 con_id, gpio_index,
> -						 value ? GPIOD_OUT_LOW :
> -						 GPIOD_OUT_HIGH);
> +						 value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
>  		if (IS_ERR(gpio_desc)) {
>  			drm_err(&dev_priv->drm,
>  				"GPIO index %u request failed (%pe)\n",

Can you attach or send a formal submission, so I can incorporate it into one
(v3) series among other changes?

-- 
With Best Regards,
Andy Shevchenko


