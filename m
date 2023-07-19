Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A04758D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGSFeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGSFeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:34:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071CE1BFD;
        Tue, 18 Jul 2023 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689744848; x=1721280848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OEj3ek+YeyUL9Cdx9pzU+b+sOp7C9Yw+8ZFjf9YMjG0=;
  b=TrUsA2NQqPFl2FLffqI2U7GLF6wo31VfO0knkhXNR7SA5dVR/dYl4RP7
   PaJVy/+yGPea7KX5jUgRuDyrxY/aCyPozu+/3z9SZxmY7ZXDIkEX3S7sj
   fqoiZZl2NBvs3s9eVMl9ZBZ+aA2HSpUiVhb/OORDrUuot/2rvnxO14l5/
   S0JWpomrB3U6URzujOTKjOuuWj5XqdEQLQEH6G4QYpB/edSiHTRQjWs1k
   vGrTPGgRUnfE1u5ux4quMeml1Z5djKPVhdSjhD9JyXZQalkdwT2tw/Z+O
   JbgNjssCa7wd/M48bjYAzKiiXEnC6vi3uWF/KuLiO4lqYMA1HftzkpEYb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346679117"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="346679117"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 22:33:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="723874614"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="723874614"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2023 22:33:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qLzom-00DIud-2W;
        Wed, 19 Jul 2023 08:33:44 +0300
Date:   Wed, 19 Jul 2023 08:33:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Add sysfs links for serial core port
 instances for ttys
Message-ID: <ZLd1uCKoGMBruwiN@smile.fi.intel.com>
References: <20230719051613.46569-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719051613.46569-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 08:16:11AM +0300, Tony Lindgren wrote:
> Let's allow the userspace to find out the tty name for a serial core
> controller id if a tty exists. This can be done with:
> 
> $ grep DEVNAME /sys/bus/serial-base/devices/port*/tty/uevent
> /sys/bus/serial-base/devices/port.00:04.0/tty/uevent:DEVNAME=ttyS0
> /sys/bus/serial-base/devices/port.serial8250.1/tty/uevent:DEVNAME=ttyS1
> /sys/bus/serial-base/devices/port.serial8250.2/tty/uevent:DEVNAME=ttyS2
> /sys/bus/serial-base/devices/port.serial8250.3/tty/uevent:DEVNAME=ttyS3

What part is the controller ID here?

We also have something in procfs (I don't remember what info exactly is there).

> And with this, we can add /dev/serial/by-id symlinks to the serial port
> device instances so we can start using serial core port addressing in
> addition to the legacy ttyS naming.
> 
> The naming we can use is dev_name:0.0 where 0.0 are the serial core
> controller id and port id, so for the ttyS0 example above the naming
> would be 00:04.0:0.0.

This is interesting idea. But any hint why it can be useful?

-- 
With Best Regards,
Andy Shevchenko


