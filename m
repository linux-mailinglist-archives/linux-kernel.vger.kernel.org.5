Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1076F8E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjHDEU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjHDEUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:20:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1833F3AB1;
        Thu,  3 Aug 2023 21:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691122851; x=1722658851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfgFdFaPZzAwY62NpMVOgR5DKzyUu6HyS+eVaO3NlDc=;
  b=LUZobZ3W44DujQ/MtwDg1FRcTHpliiC/LZ1HB9csHNNsSHpLbt/oOdBQ
   PNqp3TOH8WfHve9HX/mPCPUMVt0nAQPz5pK6hlECo0T0R/rYOU7sgqDZD
   IpRutsKafUaqNuiosjZZhTORnrzzsAWudRci4Z4zlzj9nYlZbU7/EI7KT
   XGMC25tdnvMG8KFvjvl7BOepGjrFH3VPgvy1ge5VOSB3sVvGH9pPrxCeq
   L2GfIr704MlMNxICL4RZxtWcuY3lNc8JDiW54me4nCHQYwmNwKTgBLwJ+
   snB60pB0OEsPilDSD1Wb4jYnt31lMHILVbyQmpWobOEV1UWYEDAIWNRia
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456435643"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="456435643"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 21:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="706824176"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="706824176"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2023 21:20:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRmIv-009Hs3-1k;
        Fri, 04 Aug 2023 07:20:45 +0300
Date:   Fri, 4 Aug 2023 07:20:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <ZMx8nQzYB3dBouFE@smile.fi.intel.com>
References: <20230725054216.45696-1-tony@atomide.com>
 <20230725054216.45696-4-tony@atomide.com>
 <6423de18-637e-4ee6-858e-b74e701ff3e5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6423de18-637e-4ee6-858e-b74e701ff3e5@roeck-us.net>
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

On Thu, Aug 03, 2023 at 03:18:42PM -0700, Guenter Roeck wrote:
> On Tue, Jul 25, 2023 at 08:42:12AM +0300, Tony Lindgren wrote:
> > We are missing the serial core controller id for the serial core port
> > name. Let's fix the issue for sane sysfs output, and to avoid issues
> > addressing serial ports later on.
> > 
> > And as we're now showing the controller id, the "ctrl" and "port" prefix
> > for the DEVNAME become useless, we can just drop them. Let's standardize on
> > DEVNAME:0 for controller name, where 0 is the controller id. And
> > DEVNAME:0.0 for port name, where 0.0 are the controller id and port id.
> > 
> > This makes the sysfs output nicer, on qemu for example:
> > 
> > $ ls /sys/bus/serial-base/devices
> > 00:04:0         serial8250:0    serial8250:0.2
> > 00:04:0.0       serial8250:0.1  serial8250:0.3
> > 
> > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> This patch causes about 50% of my boot tests to fail because the console
> is no longer recognized. Reverting this patch fixes the problem.
> Bisect log attached.

Isn't fix already available?
7d695d83767c ("serial: core: Fix serial_base_match() after fixing controller port name")

(in tty/tty-linus)

-- 
With Best Regards,
Andy Shevchenko


