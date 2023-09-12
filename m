Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7701879D464
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjILPHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbjILPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:07:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5721717;
        Tue, 12 Sep 2023 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694531258; x=1726067258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=txUBt16FAPKgP2na7/yuErGVgUSLTzrXNIzLNXszvrs=;
  b=eA9L46RGueFHVYqcJgQPdXfYPimj2HXo6GphBANywut5u6jSs7ibwWZc
   l5Q+409FS1KMAGl7UDbOvxREtPS9zNCyGXXj09Hi59FHSpZ/Vh9ccBi1M
   7I2Zhxy4usdqdlWdLooDprOuQzKmKBzh5myHxoqSVhImToGxMurCkjJny
   NgaA/K8M5pLu3z/js5hYqYClFo6iPE2tUbmTTsDjZJ2n3qsZeeIDKG2K0
   8OpQW00bImM6YuymyHVPIdxyGK4LT5iiwY6M0CBBEkOIBv+5mWjR6r72c
   NhpbaE3XN2EO0s2gtfz0Koy4QFOsl29Kn9SYxMPs7Ya+mL+zEL6G+HcWb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409356631"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="409356631"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:06:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="990530040"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="990530040"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:06:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qg4xz-008c3r-28;
        Tue, 12 Sep 2023 18:06:15 +0300
Date:   Tue, 12 Sep 2023 18:06:15 +0300
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
Subject: Re: [PATCH v2 2/3] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <ZQB+Z2Zwkyz7u9IL@smile.fi.intel.com>
References: <20230912110350.14482-1-tony@atomide.com>
 <20230912110350.14482-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912110350.14482-3-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 02:03:44PM +0300, Tony Lindgren wrote:
> We can now add hardware based addressing to serial ports. Starting with
> commit 84a9582fd203 ("serial: core: Start managing serial controllers to
> enable runtime PM"), and all the related fixes to this commit, the serial
> core now knows to which serial port controller the ports are connected.
> 
> The serial ports can be addressed with DEVNAME:0.0 style naming. The names
> are something like 00:04:0.0 for a serial port on qemu, and something like
> 2800000.serial:0.0 on platform device using systems like ARM64 for example.
> 
> The DEVNAME is the unique serial port hardware controller device name, AKA
> the name for port->dev. The 0.0 are the serial core controller id and port
> id.
> 
> Typically 0.0 are used for each controller and port instance unless the
> serial port hardware controller has multiple controllers or ports.
> 
> Using DEVNAME:0.0 style naming actually solves two long term issues for
> addressing the serial ports:
> 
> 1. According to Andy Shevchenko, using DEVNAME:0.0 style naming fixes an
>    issue where depending on the BIOS settings, the kernel serial port ttyS
>    instance number may change if HSUART is enabled
> 
> 2. Device tree using architectures no longer necessarily need to specify
>    aliases to find a specific serial port, and we can just allocate the
>    ttyS instance numbers dynamically in whatever probe order
> 
> To do this, we need a custom init time parser for the console= command
> line option as printk already handles parsing it with console_setup().
> Also early_param() gets handled by console_setup() if "console" and
> "earlycon" are used.

...

> +#ifdef CONFIG_SERIAL_CORE_CONSOLE
> +int serial_base_add_preferred_console(struct uart_driver *drv,
> +				      struct uart_port *port);
> +#else

> +static inline int serial_base_add_preferred_console(struct uart_driver *drv,
> +						    struct uart_port *port)

Maybe

static inline
int serial_base_add_preferred_console(struct uart_driver *drv,
				      struct uart_port *port)

for being aligned with the above?


> +{
> +	return 0;
> +}
> +#endif

...

> +#include <linux/init.h>
> +#include <linux/list.h>

> +#include <linux/kernel.h>

Hmm... Can we use better header(s) instead?
types.h, etc?


> +#include <linux/serial_core.h>
> +#include <linux/slab.h>

...

> +static LIST_HEAD(serial_base_consoles);

Don't you need a locking to access this list?
If not, perhaps a comment why it's okay?

...

> +int serial_base_add_preferred_console(struct uart_driver *drv,
> +				      struct uart_port *port)
> +{
> +	struct serial_base_console *entry;
> +	char *port_match;

...

> +	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
> +			       port->ctrl_id, port->port_id);

What about starting using cleanup.h?

> +	if (!port_match)
> +		return -ENOMEM;
> +
> +	list_for_each_entry(entry, &serial_base_consoles, node) {
> +		if (!strcmp(port_match, entry->name)) {
> +			add_preferred_console(drv->dev_name, port->line,
> +					      entry->opt);
> +			break;
> +		}
> +	}
> +
> +	kfree(port_match);

Also (with the above) this can be written as

	list_for_each_entry(entry, &serial_base_consoles, node) {
		if (!strcmp(port_match, entry->name))
			break;
	}
	if (list_entry_is_head(entry, &serial_base_consoles, node)
		return 0; // Hmm... it maybe -ENOENT, but okay.

	add_preferred_console(drv->dev_name, port->line, entry->opt);

> +	return 0;

> +}

...

> +EXPORT_SYMBOL_GPL(serial_base_add_preferred_console);

Can we use (start using) namespaced exports?

...

> +static int __init serial_base_add_con(char *name, char *opt)

const name
const opt
?

> +{
> +	struct serial_base_console *con;
> +
> +	con = kzalloc(sizeof(*con), GFP_KERNEL);
> +	if (!con)
> +		return -ENOMEM;
> +
> +	con->name = kstrdup(name, GFP_KERNEL);
> +	if (!con->name)
> +		goto free_con;
> +
> +	if (opt) {
> +		con->opt = kstrdup(opt, GFP_KERNEL);

> +		if (!con->name)

Are you sure? I think it's c&p typo here.

> +			goto free_name;
> +	}
> +
> +	list_add_tail(&con->node, &serial_base_consoles);
> +
> +	return 0;
> +
> +free_name:
> +	kfree(con->name);
> +
> +free_con:
> +	kfree(con);

With cleanup.h this will look much better.

> +	return -ENOMEM;
> +}

...

> +static int __init serial_base_parse_one(char *param, char *val,
> +					const char *unused, void *arg)
> +{
> +	char *opt;
> +
> +	if (strcmp(param, "console"))
> +		return 0;
> +
> +	if (!val)
> +		return 0;

> +	opt = strchr(val, ',');
> +	if (opt) {
> +		opt[0] = '\0';
> +		opt++;
> +	}

strsep() ?

Actually param_array() uses strcspn() in similar situation.

> +	if (!strlen(val))
> +		return 0;

Btw, have you seen lib/cmdline.c? Can it be helpful here?

> +	return serial_base_add_con(val, opt);
> +}

-- 
With Best Regards,
Andy Shevchenko


