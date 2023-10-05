Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2D7BA03E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjJEOdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjJEObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153C110CE;
        Thu,  5 Oct 2023 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513714; x=1728049714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/qcg9z9QjvBBFf2lrrpqt3uTlEPx56wjWhM7cNUhZdk=;
  b=DaVpxLG1ZwQB4MHj+/gzTu8CSLiAGjp1z7nfUXvDWVUsfBxC9+pPwnxq
   f2fuCpmdjz1WD0FRy27NWgiox21j32NZDBeAVXEWSamm+jtJT1uBu2u+K
   TXJR6Vej63HpBHDONxpncO2INswa4IznDOSwWeqZU2krjD0X1ff4u4lV+
   CQ8pbtDRLhnbxFcp+JHh9tdd8UcmfZ66BW/2R0yGB4FUP/4HJFwhl12mX
   +a0GDs2kblAc8s06lMcu2OEXqrWXg8dL8WL21FwaFuKkSsZN99MyoO9Jf
   Vk/EV5dyAxKoA98FpEAS3cRtJUydqJqemDopwGrKx8yW+nXVHJpM1XB3c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469745820"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="469745820"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 05:00:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="867860677"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="867860677"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 05:00:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qoN2B-000000030w6-1WjO;
        Thu, 05 Oct 2023 15:00:51 +0300
Date:   Thu, 5 Oct 2023 15:00:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] serial: core: Fix checks for tx runtime PM state
Message-ID: <ZR6lc/F1Esxt5ChI@smile.fi.intel.com>
References: <20231005075644.25936-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005075644.25936-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 10:56:42AM +0300, Tony Lindgren wrote:
> Maximilian reported that surface_serial_hub serdev tx does not work during
> system suspend. During system suspend, runtime PM gets disabled in
> __device_suspend_late(), and tx is unable to wake-up the serial core port
> device that we use to check if tx is safe to start. Johan summarized the
> regression noting that serdev tx no longer always works as earlier when the
> serdev device is runtime PM active.
> 
> The serdev device and the serial core controller devices are siblings of
> the serial port hardware device. The runtime PM usage count from serdev

I'm a bit lost in terminology here.
AFAIU there are:
1) children of the serial physical device;
2) siblings (to each other).

But may be I mistakenly deciphered the diagram from the previous discussion.

> device does not propagate to the serial core device siblings, it only
> propagates to the parent.
> 
> In addition to the tx issue for suspend, testing for the serial core port
> device can cause an unnecessary delay in enabling tx while waiting for the
> serial core port device to wake-up. The serial core port device wake-up is
> only needed to flush pending tx when the serial port hardware device was
> in runtime PM suspended state.
> 
> To fix the regression, we need to check the runtime PM state of the parent
> serial port hardware device for tx instead of the serial core port device.
> 
> As the serial port device drivers may or may not implement runtime PM, we
> need to also add a check for pm_runtime_enabled().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


