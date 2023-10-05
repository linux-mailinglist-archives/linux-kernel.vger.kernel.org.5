Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69407B9F85
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjJEOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjJEOWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:22:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFD927B3F;
        Thu,  5 Oct 2023 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513470; x=1728049470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FKCtbN7+J1DFK4Wis91OM2jfqlmQHuZrK9CqwaCbtBg=;
  b=K4RNaZ1Fl3Yxi4bjM6GMuqaoaNJMQGhR0h0ruSSuib0ySaKpUTArK/PE
   wZCLu/bKPAuplja7F5qDgvuoGG1v2rd0YKNGHC57MUSsDZA+gjt0CKcrl
   18zdhbcMO6sh2o17QT/99EKnTY7Q4ZblWYzMvL1LDjLJdkkZQDMyjAJyV
   6e8ZOmE2PBIotJiXB28O0fd6kOPskPVsNn+UTvWtlcR1fevHWsN7aovHe
   tfVaDZDswNqk2IMIa4yOtYqG85BAXI+ecNXq7A5e5xZjymIXFzet59e6E
   Ig/xW2/ZliIvjjqgjFTgbQQUNzaTN7pvc4CXuzoJIhGAZTAKh0fOjB324
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="387321291"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="387321291"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 02:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="701591191"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="701591191"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 02:03:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qoKGY-00000002yxu-1DYA;
        Thu, 05 Oct 2023 12:03:30 +0300
Date:   Thu, 5 Oct 2023 12:03:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: 8250_omap: Drop pm_runtime_irq_safe()
Message-ID: <ZR574o7etTozvhzt@smile.fi.intel.com>
References: <20231004062650.64487-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004062650.64487-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 09:26:48AM +0300, Tony Lindgren wrote:
> Let's drop the use of pm_runtime_irq_safe() for 8250_omap. The use of
> pm_runtime_irq_safe() is not nice as it takes a permanent usage count on
> the parent device.
> 
> We can finally drop pm_runtime_irq_safe() safely as the kernel now knows
> when the uart port tx is active. This changed with commit 84a9582fd203
> ("serial: core: Start managing serial controllers to enable runtime PM").
> 
> For serial port rx, we already use Linux generic wakeirqs for 8250_omap.
> 
> To drop pm_runtime_irq_safe(), we need to add handling for shallow idle
> state where the port hardware may already be awake and an IO interrupt
> happens. We also need to replace the serial8250_rpm sync calls in the
> interrupt handlers with async runtime PM calls.
> 
> Note that omap8250_irq() calls omap_8250_dma_handle_irq(), so we don't
> need separate runtime PM calls in omap_8250_dma_handle_irq().
> 
> While at it, let's also add the missing line break to the end of
> omap8250_runtime_resume() to group the calls.

Yoo-hoo! A few years only to get to the point :-)
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


