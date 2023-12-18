Return-Path: <linux-kernel+bounces-3894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D29F8174DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7972849E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5781D14B;
	Mon, 18 Dec 2023 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCeuPAZQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD83A1C7;
	Mon, 18 Dec 2023 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702912203; x=1734448203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H2JiMZF2Ij39VAVR9TnJ4A+j9YTlsOjpmC1hsIFWk04=;
  b=FCeuPAZQXo6EDHVAwk6JCXJV49ZKDukliJ15s4RuAwlsX/NwLC2h6uf8
   eNfToHwPPKk0ew9ELhGgAK0eRq4QhNNVf8ZlkpqhdapBGuaLlhJ9YfG64
   o3ZZamaLrFGoN+0yP0i1qo/7ViwxwBSb+CRtD2B4cd6VUGGbVf9Nwv1PG
   PAPkM9J6hOUQ7Bwci6ezN+I1ig4KtntJUYtRuQJf2Ckc72/54/5Hs3gHk
   MTNu6+kJBbZH07+UvTMYUxiaEKNTCyi9ZGZZ9cI/APYtbGLYOyVF6Ygx0
   PWC8QCxjpvd0wLlk10KSovu11+n+47a5fWUgOIyIh9sOE7GKUnWyCbfBS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="14203970"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="14203970"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 07:10:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1106975744"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="1106975744"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 07:09:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFFFh-00000006yC9-47z3;
	Mon, 18 Dec 2023 17:09:53 +0200
Date: Mon, 18 Dec 2023 17:09:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/6] printk: Save console options for
 add_preferred_console_match()
Message-ID: <ZYBgwbYmF5WsFVic@smile.fi.intel.com>
References: <20231218071020.21805-1-tony@atomide.com>
 <20231218071020.21805-2-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218071020.21805-2-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 09:09:48AM +0200, Tony Lindgren wrote:
> Driver subsystems may need to translate the preferred console name to the
> character device name used. We already do some of this in console_setup()
> with a few hardcoded names, but that does not scale well.
> 
> The console options are parsed early in console_setup(), and the consoles
> are added with __add_preferred_console(). At this point we don't know much
> about the character device names and device drivers getting probed.
> 
> To allow driver subsystems to set up a preferred console, let's save the
> kernel command line console options. To add a preferred console from a
> driver subsystem with optional character device name translation, let's
> add a new function add_preferred_console_match().
> 
> This allows the serial core layer to support console=DEVNAME:0.0 style
> hardware based addressing in addition to the current console=ttyS0 style
> naming. And we can start moving console_setup() character device parsing
> to the driver subsystem specific code.
> 
> We use a separate array from the console_cmdline array as the character
> device name and index may be unknown at the console_setup() time. And
> eventually there's no need to call __add_preferred_console() until the
> subsystem is ready to handle the console.
> 
> Adding the console name in addition to the character device name, and a
> flag for an added console, could be added to the struct console_cmdline.
> And the console_cmdline array handling could be modified accordingly. But
> that complicates things compared saving the console options, and then
> adding the consoles when the subsystems handling the consoles are ready.

...

> +#include <linux/console.h>
> +#include <linux/init.h>
> +#include <linux/string.h>

A nit: uXX require types.h.

> +#include <asm/errno.h>

-- 
With Best Regards,
Andy Shevchenko



