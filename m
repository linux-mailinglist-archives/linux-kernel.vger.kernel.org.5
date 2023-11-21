Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500E97F3573
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjKUSAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKUSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:00:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785B7193;
        Tue, 21 Nov 2023 10:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700589617; x=1732125617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kR4j5LmmglSwWkcRVhfnSdc4lXlxN4xSDvWLYtbkvvg=;
  b=WyTGu0aNG+ifIMIorYAC7jOYtFWYvV8SaVejrLRflfI/Qqq7vIZ0+rUH
   M3P8n8Yc1yxgkdDVlvwplunMPdI7tqYBDLeaSvfSG/dq/8nvpRCtJCrQT
   Ojfs7l9YMcwRI1CgE2CSjXLh/fQF0M/kBc8hsej8v26cOb4Rup3LKozcT
   omABdtYODlqohs788Ftp19CZ8lXjjfGz8uNlXuq2XQVa0bQSEJsIpzVrA
   ne/l/FT9NVPrGQGXcom6Pc83flO1qgcwMgIEtoy4uWweyI6ax5UKpxAce
   mRAOyEKVf/D4vkQ6gdfCKVMwMd/h1lUV0zLBVUMHdwtjDni9FG4wEKMtT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391667759"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="391667759"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:00:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="884282984"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="884282984"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:00:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r5V2g-0000000Fske-0Ql3;
        Tue, 21 Nov 2023 20:00:10 +0200
Date:   Tue, 21 Nov 2023 20:00:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Move console character device
 handling from printk
Message-ID: <ZVzwKeALJ4swIdj0@smile.fi.intel.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <20231121113203.61341-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121113203.61341-4-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:31:57PM +0200, Tony Lindgren wrote:
> There's no need for console_setup() to try to figure out the console
> character device name for serial ports early on before uart_add_one_port()
> has been called. And for early debug console we have earlycon.
> 
> Let's handle the serial port specific commandline options in the serial
> core subsystem and drop the handling from printk. The serial core
> subsystem can just call add_preferred_console() when the serial port is
> getting initialized.
> 
> Note that eventually we may want to set up driver specific console quirk
> handling for the serial port device drivers to use. But we need to figure
> out which driver(s) need to call the quirk. So for now, we just move the
> sparc quirk and handle it directly.

...

> +	ret = add_preferred_console_match(name, drv->dev_name, port->line);
> +	if (ret && ret != -ENOENT)
> +		return ret;
> +
> +	return 0;

2nd time and so on, perhaps deserves a helper?

static inline int add_preferred_console...(...)
{
	int ret;

	ret = add_preferred_console_match(name, drv->dev_name, port->line);
	if (ret == -ENOENT)
		return 0;
	return ret;

}

?

-- 
With Best Regards,
Andy Shevchenko


