Return-Path: <linux-kernel+bounces-76894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B705285FE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703C52860AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B489B153BCE;
	Thu, 22 Feb 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eb9YQ+hx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAAA1509AF;
	Thu, 22 Feb 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620201; cv=none; b=FWNN6/xM9fx7eiFo9w8BLLYBEJQdOK9mxDuQDWjIZlkF2IJu5GqdAR30aXq4Cs5L/itS/kAIfh9g5ue9GHtI719BFTnRLzRujdh7QHq4UiWvSBoafmMXwu8uICL7fVydd0D5Y8Z7QnaG7wr9kUH03TAXcgwQKf9zztA9sKCpJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620201; c=relaxed/simple;
	bh=6cgmf39JYiDBELE0+UskrRn1VRCO10hey7B1q9DlcUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugdgTFs0yf7ePBTkZspsU9UlUtMNT5+tq0CtS89kI2By9RjsLs+ihqo8oS25a79Vjavh5omajhRMFmyC6+h7bKJhDJTtMS/8444cC6eup0ymfd7znTSicw/exOuQaHzoaLutgC54pW99toyb6ptftOGaXptrY8QvGZCtNwOK89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eb9YQ+hx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708620199; x=1740156199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6cgmf39JYiDBELE0+UskrRn1VRCO10hey7B1q9DlcUg=;
  b=eb9YQ+hxdf6ULUtsTYZHluOpaVl/bLYGvyVAE5ZWSFZooN9oCYi+Mviw
   ujP42Gdg8yNJw0nHRiR68PtbNYdC+md2sSy4NLk0F8Vhuz51+RJWhWkId
   2FGA/R7RcSS440US8nKMpqpAKOXSaAp5b8sZaExReXwnf+Y28KVwsgRyo
   7Od41Ih8ri7qAJkl5p4CfN9gQNLGYMxWWpy/Wf6JYZElQ8l7A4Nxy7ppG
   KUwOhsWIw1/3zO3anWG0D3W8O45mv1lLAHmlW/Qd3xWq8Nm6AkyOvMXFK
   PGDw7py7bvVf15MtYRExXZ4d183v4lR6Qu5oWtse2E37F9Nw6CjJbwWel
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2731286"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2731286"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:43:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913553362"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913553362"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:43:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdCA8-00000006g8k-1nva;
	Thu, 22 Feb 2024 18:43:08 +0200
Date: Thu, 22 Feb 2024 18:43:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v1 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
Message-ID: <Zdd5m2xIPlGI0_Qv@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
 <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
 <ZddKzHplwOX7naLv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZddKzHplwOX7naLv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 03:23:24PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 22, 2024 at 11:07:05AM +1030, Andrew Jeffery wrote:
> > On Wed, 2024-02-21 at 20:31 +0200, Andy Shevchenko wrote:
> > > Since we have now a common helper to read port properties
> > > use it instead of sparse home grown solution.
> > 
> > I did some brief testing of the series for the Aspeed machines under
> > qemu, building them on top of v6.8-rc5:
> > 
> > export ARCH=arm
> > export CROSS_COMPILE=arm-linux-gnueabihf-
> > make aspeed_g5_defconfig
> > make -j$(nproc)
> > qemu-system-arm -M rainier-bmc -nographic -no-reboot -kernel arch/arm/boot/zImage -dtb arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb -initrd ...
> > 
> > I got an oops during boot, which bisected to this change:
> 
> Thank you for prompt testing! I will look at it.

I found the issue, will be fixed in next version.

-- 
With Best Regards,
Andy Shevchenko



