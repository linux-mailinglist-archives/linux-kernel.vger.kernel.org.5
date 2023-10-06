Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1F7BB51A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjJFK04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjJFK0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:26:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C9AD;
        Fri,  6 Oct 2023 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696588010; x=1728124010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7WnwQUvBuHgxdN53eoOtAT89Q1Kyl5KXJdkCJfU6q8k=;
  b=PhKJsDUGPB3WJ9su1EK31qfI1UqkIs0YV1+Mr6JqD+KUrhZbY3s/2CgJ
   03OWcvmlaAWMWMI6xD817x6wbdOwWmg8bkpsIDBh1nLTOEj1IhHUtSc7h
   X7VyipZ9243R9VrqkdOasjSCbnrqGLxVuXn9OGtRf4EVJvhmRe7iKLkrV
   61BYzMMZ70UrRZWXJhx4iRdp5laoE+yJtxLsApWuQGzShfv1rM6ZAE5ox
   +x7pvT48OKF51gHDx/2KpOQzspBg71PBDyH8Qi7Po3svApXDdLa1L+B++
   hqrlD+AW7OMUZ45xEW2nMCeYQz64vLwAWe494FP05GiAkNHVGd5ZU5lsn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="382591098"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382591098"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083407014"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="1083407014"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:26:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qoi2f-00000003GYH-2q2F;
        Fri, 06 Oct 2023 13:26:45 +0300
Date:   Fri, 6 Oct 2023 13:26:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 1/2] pinctrl: cherryview: Avoid duplicated I/O
Message-ID: <ZR/g5SwjBOSN4agw@smile.fi.intel.com>
References: <20231006094033.3082468-1-andriy.shevchenko@linux.intel.com>
 <20231006102412.GY3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006102412.GY3208943@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 01:24:12PM +0300, Mika Westerberg wrote:
> On Fri, Oct 06, 2023 at 12:40:32PM +0300, Andy Shevchenko wrote:
> > In some cases we already read the value from the register followed
> > by a reading of it again for other purposes, but the both reads
> > are under the lock and bits we are insterested in are not going
> > to change (they are not volatile from HW perspective). Hence, no
> > need to read the same registeer twice.
> 
> Typo "registeer" -> "register"

Will fix when applying.

...

> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Thank you!

-- 
With Best Regards,
Andy Shevchenko


