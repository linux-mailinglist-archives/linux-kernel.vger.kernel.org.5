Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BF979D49F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjILPRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjILPRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:17:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727D12E;
        Tue, 12 Sep 2023 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694531848; x=1726067848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ek7zeRveSjW1HyewGP99m9eXHqbmJXZueDnRe0MSmc=;
  b=N/2DfbdYstgODafxxGrnpDTc8uEac9MoZ0/DMKA4aIy1+5cYbn8dkFLQ
   sKBAQhtZ5E3jgZ0V+k0Rmk/xaQpA4Lm69TNm1gW/daFo8xDfegm7qiScq
   LdltDlcfE5kghl/XJxYsOUHjO3g39+2ozlklJjCdN0e+Fy93ydBIMl+oA
   aplriftZ+8sBVRzB/Catznky1504OvoW4HQxZc/KxKb9Y/CSsObaO/x9m
   JDol4ZSWYotIZHNG4unaa7vEZeixOXjN24Cq8IHYLXEXaY8nDRYvpQsk9
   S2PTHQpRMnyQ4AnyLW2nF9fyUGECoBPMWygiHLueVlFmmozox19U2B+TV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377322543"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="377322543"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:17:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858839099"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858839099"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:17:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qg58j-008cFf-2z;
        Tue, 12 Sep 2023 18:17:21 +0300
Date:   Tue, 12 Sep 2023 18:17:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/3] serial: core: Add sysfs links for serial core
 port instances for ttys
Message-ID: <ZQCBAXcFwDqZyBZP@smile.fi.intel.com>
References: <20230912110350.14482-1-tony@atomide.com>
 <20230912110350.14482-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912110350.14482-4-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 02:03:45PM +0300, Tony Lindgren wrote:
> Let's allow the userspace to find out the ttyS style name for a serial
> core port device if a tty exists. This can be done with:
> 
> $ grep DEVNAME /sys/bus/serial-base/devices/*/tty/uevent
> /sys/bus/serial-base/devices/00:04:0.0/tty/uevent:DEVNAME=ttyS0
> /sys/bus/serial-base/devices/serial8250:0.1/tty/uevent:DEVNAME=ttyS1
> /sys/bus/serial-base/devices/serial8250:0.2/tty/uevent:DEVNAME=ttyS2
> /sys/bus/serial-base/devices/serial8250:0.3/tty/uevent:DEVNAME=ttyS3
> 
> With this change, we can add /dev/serial/by-id symlinks for the serial
> core port device instances. This allows using hardware based port
> addressing in addition to the legacy ttyS style naming.
> 
> The serial core port naming is DEVNAME:0.0, such as the 00:04:0.0 above.
> The 0.0 above are serial core controller id and port id. The port id and
> controller id are typically both zero unless the serial port hardware
> controller has multiple controllers or ports.

...

> +	struct uart_match match = {port, drv};

A nit:

	struct uart_match match = { .port = port, .driver = drv };

...

> +	tty_dev = device_find_child(port->dev, &match, serial_match_port);
> +	if (tty_dev) {

> +		ret = sysfs_create_link(&port->port_dev->dev.kobj, &tty_dev->kobj,
> +					"tty");

I would do it on a single line (you already over 80 anyway).

> +		put_device(tty_dev);
> +		if (ret)
> +			goto err_remove_port;
> +	}

...

> +	struct uart_match match = {port, drv};

As per above.

...

> +	tty_dev = device_find_child(port->dev, &match, serial_match_port);

Can be written as

	tty_dev = device_find_child(phys_dev, &match, serial_match_port);

?

> +	if (tty_dev) {
> +		sysfs_remove_link(&port->port_dev->dev.kobj, "tty");

Can be written as

		sysfs_remove_link(&port_dev->dev.kobj, "tty");

can't be?

> +		put_device(tty_dev);
> +	}

-- 
With Best Regards,
Andy Shevchenko


