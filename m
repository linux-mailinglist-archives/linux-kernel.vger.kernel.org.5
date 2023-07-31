Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9276A1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGaUC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGaUCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:02:55 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ED68F;
        Mon, 31 Jul 2023 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690833774; x=1722369774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QLuqdMFVbfipgkJpmQ7yQ70kosGRgV7Qx5yzcgkRwo8=;
  b=EACdtjWbZUBt92jSHsV37Dtm/x/V/YPJw/MLOu6PGlUArA8eOHREIq7h
   UTd/cqYlcKWhH2rIA8mkgtROng65mFUqaO7zbbQrc52fxy621MW0JO711
   a4W0f02NB0pBqtCH5ZLOBIF7nSi6LJ8h1RLCwozYGP0LLzbslFtTX+iwt
   rMWnEt0etXR5fs21UUiL19ib5+hRvIGzLoobIKvay69JlcT9w95famASD
   Vp4d0F11Zgrq4whse1ujFwOHalb2Aq9jYLebzxzFVuu1edSFPRHD6MHf0
   DTlw7JlhGCTgJBIuVp9DKR9y8Lc6N6nZs9SD01JIGkqFJR1V9XI/6E4U7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="368020245"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="368020245"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 13:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="793852520"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="793852520"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jul 2023 13:02:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qQZ6B-003xYM-0O;
        Mon, 31 Jul 2023 23:02:35 +0300
Date:   Mon, 31 Jul 2023 23:02:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <ZMgTWktV1pDQ+Esz@smile.fi.intel.com>
References: <20230725054216.45696-1-tony@atomide.com>
 <20230725054216.45696-4-tony@atomide.com>
 <ZL+QuHE4CztPvBxo@smile.fi.intel.com>
 <2023073158-ungraded-carefully-6af3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023073158-ungraded-carefully-6af3@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:14:15PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 25, 2023 at 12:07:04PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 25, 2023 at 08:42:12AM +0300, Tony Lindgren wrote:
> > > We are missing the serial core controller id for the serial core port
> > > name. Let's fix the issue for sane sysfs output, and to avoid issues
> > > addressing serial ports later on.
> > > 
> > > And as we're now showing the controller id, the "ctrl" and "port" prefix
> > > for the DEVNAME become useless, we can just drop them. Let's standardize on
> > > DEVNAME:0 for controller name, where 0 is the controller id. And
> > > DEVNAME:0.0 for port name, where 0.0 are the controller id and port id.
> > > 
> > > This makes the sysfs output nicer, on qemu for example:
> > > 
> > > $ ls /sys/bus/serial-base/devices
> > > 00:04:0         serial8250:0    serial8250:0.2
> > > 00:04:0.0       serial8250:0.1  serial8250:0.3
> > 
> > Hmm... Why 0.0 is absent for serial8250?
> > Btw, what was before this patch there?
> > And maybe ls -l will look more informative?
> > 
> > > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > > 
> > > Andy, I kept your Reviewed-by although I updated the device naming and
> > > description, does the patch still look OK to you?
> > 
> > Looks okay, but I have a question above.
> 
> Can I get an ack for this if you are ok with these fixes?

Sure,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


