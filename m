Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B087D57FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjJXQVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbjJXQU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:20:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB3710DD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698164452; x=1729700452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=stAV+c+m6ur0U0ftL1kJBRBWT7RqDc7NNlJHBqfAKF0=;
  b=YK0oXkQl8WBRqt0t/slZ68JEj2N9oqXls3Luok4XsWUuR39RgjTlezq4
   Fm7gPQEpAPhP647OEaZ1pmqiNcINEFME7gOaodpuUSnzR4n6ueoxWXPwv
   Ss2zt4SFF1Bz891rfUAoD4MN3slEYlHnBHd/fR7pm2pag+BhmebdLsZbF
   vmel7gy9StMqKCC/gptX5P7R3zMAuVMTpMdR14ZFeT/hVT4cWTTrBdyjm
   YtUyIeAtgZlPH050taSX92UGNZ2oarW5N2Bi6k2g192aEZvxql65qJkNw
   5Y/2DFeMtJl7+ZAEMW5hxzOe/5VL+RW+KOQSyzL1ArKKWMQfgHEOW67qX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="473333359"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="473333359"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="828906405"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="828906405"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:11:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvK0B-00000008KRg-2l0V;
        Tue, 24 Oct 2023 19:11:31 +0300
Date:   Tue, 24 Oct 2023 19:11:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 6/7] drm/i915/dsi: Replace poking of CHV GPIOs behind
 the driver's back
Message-ID: <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:
> It's a dirty hack in the driver that pokes GPIO registers behind
> the driver's back. Moreoever it might be problematic as simultaneous
> I/O may hang the system, see the commit 0bd50d719b00 ("pinctrl:
> cherryview: prevent concurrent access to GPIO controllers") for
> the details. Taking all this into consideration replace the hack
> with proper GPIO APIs being used.

Ah, just realised that this won't work if it happens to request to GPIOs with
the same index but different communities. I will fix that in v3, but will wait
for Hans to test VLV and it might even work in most of the cases on CHV as it
seems quite unlikely that the above mentioned assertion is going to happen in
real life.

-- 
With Best Regards,
Andy Shevchenko


