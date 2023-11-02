Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF907DF7F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376923AbjKBQtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:49:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3B128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698943753; x=1730479753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HKl+m4Zjr7h+atr2oTK1n7KhWyPIB1bTDQkuRUWLgbk=;
  b=XZ7VlFjIeDCx7M5tkbevGdM+f0CP30Zp7l2z/0hGjcciLphXUvXtFsW8
   nIHeEFJ23Ew9q9PsPwC/J9TVFIyMqYRnCDT8feahrRkvEws1f2JunL2V5
   7L5bnoETFecV6hbDu63X56XjeQyP7papWt7Eprvo6mvU1+g0lxm6GpRIh
   29xSiCNKDok4KXx25KatNmm0q2TwsTVujDBXUOJz8cz0+MJg0PzLix+Ol
   VtTd5NTWb+JsvGvmrACRwxoVi9oR87cSX1v2kVTA6RV7Gq5AUlj/FG3ho
   GOSKLnFwRiqw4ZpQdfVDnI483qzePfH0I3GEXbXwMdCx26Td+OjUVDt8P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="453060186"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="453060186"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:49:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="764985106"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="764985106"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:49:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qyasT-0000000AkGd-0B1U;
        Thu, 02 Nov 2023 18:49:05 +0200
Date:   Thu, 2 Nov 2023 18:49:04 +0200
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
Subject: Re: [PATCH v3 14/15] drm/i915/dsi: Replace poking of CHV GPIOs
 behind the driver's back
Message-ID: <ZUPTAG5ZuxKoOugs@smile.fi.intel.com>
References: <20231102151228.668842-1-andriy.shevchenko@linux.intel.com>
 <20231102151228.668842-15-andriy.shevchenko@linux.intel.com>
 <34b4f396-ecf3-576d-69e5-f8eac2a5d488@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34b4f396-ecf3-576d-69e5-f8eac2a5d488@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 04:47:41PM +0100, Hans de Goede wrote:
> On 11/2/23 16:12, Andy Shevchenko wrote:

...

> > +			soc_exec_opaque_gpio(connector, gpio_index, "INT33FF:03", "Panel SE",
> > +					     gpio_index - CHV_GPIO_IDX_START_SW, value);
> 
> The "gpio_index - CHV_GPIO_IDX_START_SW" here needs to be "gpio_index - CHV_GPIO_IDX_START_SE".
> 
> Also this patch needs s/soc_exec_opaque_gpio/soc_opaque_gpio_set_value/ to compile ...

Ah, indeed. I looks like I run the test build, but forgot to look into the result. :-(

-- 
With Best Regards,
Andy Shevchenko


