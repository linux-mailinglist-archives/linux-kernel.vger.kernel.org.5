Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE390805B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbjLEQIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjLEQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:08:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69602122;
        Tue,  5 Dec 2023 08:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701792526; x=1733328526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KLWsLZHLpQvaSU4eb5D78m7MmK7AFyLBJOq+D8rCdzY=;
  b=Dk98ILA408CQ9lMFhvJ+o1nhu75KPjR+jRHtBXwqoUGQ4vLc0wj0dInw
   U97MzjpPwsOYDw/HFjHV7+iHgaPb40ExunkkKAhFFZz/IlKnKpxoXe+f5
   NJj3B7EPfSG45lVWAAnyxe22S7wtSp9g3/M5SilXySHKFvILMJ+O7OVsw
   BIFX9yFxO63FGMtt1Qomi27W/y8Ffr6VHfWszmpmOFsFduMHe9e1y/Jl0
   6VJM4fCwIfTDGPFv+Hq285UXwiYpoN43PAYHyPN8UruxDomJuyx2ChPhR
   AT4pc/9gV9ImVR6D9jvHV8NdCz96zXMzl9TfgpOd60OgcASJ2xYdc/x90
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="7261714"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="7261714"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:08:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="894423854"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="894423854"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:08:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1rAXyP-0000000250s-26B5;
        Tue, 05 Dec 2023 18:08:37 +0200
Date:   Tue, 5 Dec 2023 18:08:37 +0200
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
Subject: Re: [PATCH v4 4/4] serial: 8250: Add preferred console in
 serial8250_isa_init_ports()
Message-ID: <ZW9LBXc8ars-rrh6@smile.fi.intel.com>
References: <20231205073255.20562-1-tony@atomide.com>
 <20231205073255.20562-5-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205073255.20562-5-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:32:36AM +0200, Tony Lindgren wrote:
> Prepare 8250 isa ports to drop kernel command line serial console

ISA

> handling from console_setup().
> 
> We need to set the preferred console in serial8250_isa_init_ports().
> Otherwise the console gets initialized only later on when the hardware
> specific driver takes over, and console_setup() is no longer handling
> the ttyS related quirks.
> 
> Note that this mostly affects x86 as this happens based on define
> SERIAL_PORT_DFNS.

...

> +static void __init serial8250_isa_init_preferred_console(int idx)
> +{
> +	const char *name __free(kfree);
> +	int ret;
> +
> +	name = kasprintf(GFP_KERNEL, "%s%i", serial8250_reg.dev_name, idx);

No error check?

> +	ret = add_preferred_console_match(name, serial8250_reg.dev_name, idx);
> +	if (!ret || ret == -ENOENT)
> +		return;

	ret = serial_base_add_one_prefcon(...);

?

> +	pr_err("Could not add preferred console for %s idx %i\n",
> +	       serial8250_reg.dev_name, idx);
> +}

-- 
With Best Regards,
Andy Shevchenko


