Return-Path: <linux-kernel+bounces-63917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F22D85365B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D932286934
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A75E5FDD7;
	Tue, 13 Feb 2024 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTicvyFC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E35FB97;
	Tue, 13 Feb 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842527; cv=none; b=dUCK/FundqWKNFXQg0XyXn9YfcgmH2uZez4dErX6VjWAIbjuXYUvFJIPDNr3Taz0g1W44fVW/fqOV+7gRQqzEtADS5HAjJ0aQzn0AEcT6ihnQS1E3J7QhqvFdBoFazm62pyLtdhSAVnuJ7SD/aOcZuZAQ8iGD6uaBWHQEs4AYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842527; c=relaxed/simple;
	bh=D2XFUCuWKzpY/qEP92tpf5yKY/tipQ0EtrgZJh+m48w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqSGjqCVDKUQtBxqBuqLWrnKxEJeBJAI55Ed5VlfePw60oUGfDE9PR4nyawcT+VKafd7o/hHGKqFM/3sbiIqYijEkrL8tKZuKiJShljxMPC6JCQWgudnErj/ZAHlRBvZox2zEZEiPhIeSTWRdr38SjwPVmGOpPZgJ9cAAnz6INM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTicvyFC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707842526; x=1739378526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D2XFUCuWKzpY/qEP92tpf5yKY/tipQ0EtrgZJh+m48w=;
  b=kTicvyFCevCqQVznUZtxsTIKxsxTmnja57St2CeZf0wFlozu/2uVKUDh
   pFBPG9IgPQoaQVvO/e8PB/veD3kVKMddTVvMN8gSHSjqzC8OBRSoTi2+O
   mI0AQqsZsFP2mXfNfKLkWMwExznFr3kM/CA0sbsP5t5TzRjLKhBc4pyG7
   +L3/WmEqyE8gayxpziF92ICI8ajgTMK9lZqLrzCNUa5E/gZgfPgPb/W5M
   t5/g9vnUVUoxUReCN90+Th+yx9y3hwmXrGVGdmbF8QLEeJSpjL4HtQKGl
   T6hURmp6d7/w1IpK19vcx8bRDKyrKN9Dsz8J4K5Z2aT9lsv8Yi3WiMe39
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="4825659"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="4825659"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911830323"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911830323"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:42:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZvr4-00000004Gd2-1y6Z;
	Tue, 13 Feb 2024 18:41:58 +0200
Date: Tue, 13 Feb 2024 18:41:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v6 1/6] printk: Save console options for
 add_preferred_console_match()
Message-ID: <Zcub1bQrDqHE0Mkt@smile.fi.intel.com>
References: <20240213084545.40617-1-tony@atomide.com>
 <20240213084545.40617-2-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213084545.40617-2-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 13, 2024 at 10:45:08AM +0200, Tony Lindgren wrote:
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

..

> +int __init console_opt_save(const char *str, const char *brl_opt)
> +{
> +	struct console_option *con;
> +	const char *opt = NULL;
> +	size_t namelen, optlen;
> +	int i;

> +	namelen = strcspn(str, ",");
> +	if (!namelen)
> +		return -EINVAL;
> +
> +	optlen = strlen(str) - namelen;
> +	if (optlen > 1)
> +		opt = str + namelen + 1;
> +
> +	if (namelen >= CONSOLE_NAME_MAX || optlen >= CONSOLE_OPT_MAX)
> +		return -EINVAL;
> +
> +	for (i = 0; i < MAX_CMDLINECONSOLES; i++) {
> +		con = &conopt[i];
> +
> +		if (con->name[0]) {
> +			if (!strncmp(str, con->name, namelen))
> +				return 0;
> +			continue;
> +		}

> +		strscpy(con->name, str, namelen + 1);
> +		if (opt)
> +			strscpy(con->opt, opt, optlen + 1);

> +		/* See _braille_console_setup(), both empty and NULL are valid */
> +		if (brl_opt) {
> +			strscpy(con->brl_opt, brl_opt, CONSOLE_BRL_OPT_MAX);
> +			con->has_brl_opt = 1;
> +		}
> +
> +		return 0;
> +	}
> +
> +	return -ENOMEM;
> +}

With fresh look at the above, can we amend it like below?
(dropped NULL assignment, optimized strlen(), split checks, dropped unneeded +1 in strscpy() calls)

int __init console_opt_save(const char *str, const char *brl_opt)
{
	struct console_option *con;
	size_t namelen, optlen;
	const char *opt;
	int i;

	namelen = strcspn(str, ",");
	if (namelen == 0 || namelen >= CONSOLE_NAME_MAX)
		return -EINVAL;

	opt = str + namelen;
	if (*opt == ',')
		opt++;

	optlen = strlen(opt);
	if (optlen >= CONSOLE_OPT_MAX)
		return -EINVAL;

	for (i = 0; i < MAX_CMDLINECONSOLES; i++) {
		con = &conopt[i];

		if (con->name[0]) {
			if (!strncmp(str, con->name, namelen))
				return 0;
			continue;
		}

		strscpy(con->name, str, namelen);
		strscpy(con->opt, opt, optlen); // not sure if emptying opt is okay

		/* See _braille_console_setup(), both empty and NULL are valid */
		if (brl_opt) {
			strscpy(con->brl_opt, brl_opt, CONSOLE_BRL_OPT_MAX);
			con->has_brl_opt = 1;
		}

		return 0;
	}

	return -ENOMEM;
}

-- 
With Best Regards,
Andy Shevchenko



