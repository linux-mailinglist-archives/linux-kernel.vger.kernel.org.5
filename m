Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373D779D0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjILMYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjILMYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:24:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC110D3;
        Tue, 12 Sep 2023 05:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694521453; x=1726057453;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PZ3ZOuKlWKIA/NPSNRLsnK9MoIK3kPL++X5vnjv5+to=;
  b=BLiT/KedA0TikHrxWSml/z9/H4qcRU6OG0hWgd1VkdJ/DNaRBj0WcdRL
   igI1SC1J7y9me1HyuSPzUWnMcjCECI7sCyfygwwc0VfuNZxp7iOsmi68x
   e+ZsLEXyAnNkILR9ZnJlnQkP3ES668N+q3bVn7PgU3Bd1e5UuaEGlJMpu
   TzDBCXgA510oA9B0vqDwof7Pkzi5Tkud9RjRFZlLwtGxjK9eTpskYU2rB
   6OAOeVptgc+h6KrrUhMoT6mOKGuoy9hy1KDkzrAsdCVXPbig1bsZ+WzAp
   fJOKugUQBvxro3XaP6+pM3NLoD2SSL5yKiHrt9jh1oeWpcIfaV+IqFT4M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375688311"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="375688311"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="778772987"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="778772987"
Received: from npejicx-mobl.ger.corp.intel.com ([10.251.217.90])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:24:06 -0700
Date:   Tue, 12 Sep 2023 15:24:04 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
In-Reply-To: <20230912110350.14482-3-tony@atomide.com>
Message-ID: <c7688d45-4b63-20-b1c6-2dc1e83e875@linux.intel.com>
References: <20230912110350.14482-1-tony@atomide.com> <20230912110350.14482-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023, Tony Lindgren wrote:

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
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/Makefile          |   3 +
>  drivers/tty/serial/serial_base.h     |  11 +++
>  drivers/tty/serial/serial_base_con.c | 133 +++++++++++++++++++++++++++
>  drivers/tty/serial/serial_core.c     |   4 +
>  4 files changed, 151 insertions(+)
>  create mode 100644 drivers/tty/serial/serial_base_con.c
> 
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -3,6 +3,9 @@
>  # Makefile for the kernel serial device drivers.
>  #
>  
> +# Parse kernel command line consoles before the serial drivers probe
> +obj-$(CONFIG_SERIAL_CORE_CONSOLE) += serial_base_con.o
> +
>  obj-$(CONFIG_SERIAL_CORE) += serial_base.o
>  serial_base-y := serial_core.o serial_base_bus.o serial_ctrl.o serial_port.o
>  
> diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
> --- a/drivers/tty/serial/serial_base.h
> +++ b/drivers/tty/serial/serial_base.h
> @@ -45,3 +45,14 @@ void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port
>  
>  int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
>  void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
> +
> +#ifdef CONFIG_SERIAL_CORE_CONSOLE
> +int serial_base_add_preferred_console(struct uart_driver *drv,
> +				      struct uart_port *port);
> +#else
> +static inline int serial_base_add_preferred_console(struct uart_driver *drv,
> +						    struct uart_port *port)
> +{
> +	return 0;
> +}
> +#endif
> diff --git a/drivers/tty/serial/serial_base_con.c b/drivers/tty/serial/serial_base_con.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/tty/serial/serial_base_con.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Serial base console options handling
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Author: Tony Lindgren <tony@atomide.com>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/kernel.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +
> +#include "serial_base.h"
> +
> +static LIST_HEAD(serial_base_consoles);
> +
> +struct serial_base_console {
> +	struct list_head node;
> +	char *name;

Can't this be const char as too?

-- 
 i.


> +	char *opt;
> +};
> +
> +/*
> + * Adds a preferred console for a serial port if console=DEVNAME:0.0
> + * style addressing is used for the kernel command line. Translates
> + * from DEVNAME:0.0 to port->dev_name such as ttyS. Duplicates are
> + * ignored by add_preferred_console().
> + */
> +int serial_base_add_preferred_console(struct uart_driver *drv,
> +				      struct uart_port *port)
> +{
> +	struct serial_base_console *entry;
> +	char *port_match;
> +
> +	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
> +			       port->ctrl_id, port->port_id);
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
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(serial_base_add_preferred_console);
> +
> +/* Adds a command line console to the list of consoles for driver probe time */
> +static int __init serial_base_add_con(char *name, char *opt)
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
> +
> +	return -ENOMEM;
> +}
> +
> +/* Parse console name and options */
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
> +
> +	opt = strchr(val, ',');
> +	if (opt) {
> +		opt[0] = '\0';
> +		opt++;
> +	}
> +
> +	if (!strlen(val))
> +		return 0;
> +
> +	return serial_base_add_con(val, opt);
> +}
> +
> +/*
> + * The "console=" option is handled by console_setup() in printk. We can't use
> + * early_param() as do_early_param() checks for "console" and "earlycon" options
> + * so console_setup() potentially handles console also early. Use parse_args().
> + */
> +static int __init serial_base_opts_init(void)
> +{
> +	char *command_line;
> +
> +	command_line = kstrdup(boot_command_line, GFP_KERNEL);
> +	if (!command_line)
> +		return -ENOMEM;
> +
> +	parse_args("Setting serial core console", command_line,
> +		   NULL, 0, -1, -1, NULL, serial_base_parse_one);
> +
> +	kfree(command_line);
> +
> +	return 0;
> +}
> +
> +arch_initcall(serial_base_opts_init);
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3358,6 +3358,10 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>  	if (ret)
>  		goto err_unregister_ctrl_dev;
>  
> +	ret = serial_base_add_preferred_console(drv, port);
> +	if (ret)
> +		goto err_unregister_port_dev;
> +
>  	ret = serial_core_add_one_port(drv, port);
>  	if (ret)
>  		goto err_unregister_port_dev;
> 
