Return-Path: <linux-kernel+bounces-71562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B2B85A719
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30524282137
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40594383A6;
	Mon, 19 Feb 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Io3ipe+f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E13A264;
	Mon, 19 Feb 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355493; cv=none; b=kf6dF+2Gsg/MQXIt3tHxgoBsO0Za5wkMUg6L8yr2H85zCDWtnQCTR1YEMEqTtulBBTahkycYpqWctfc+W+OHNWtZbbaS60DHmlpPQ2yIWe/c1U8PL53Ly2IKCjj6+7OBBtzqUYh1f1BXHtA7FzEMiaztphuXEqZ3rTr6v4nod1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355493; c=relaxed/simple;
	bh=ayLLTpEgKqvBUDQj5moMFIOBncxte1r8rIs7zb2L0nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZOi2PPqBIeVydNBg5MAhpA/GQdn68olzudgsZJJiYPClazSaWNhRibllHf8ZM5cD/SZxs9xYQEUnzvrZIXlB2KoVBnYlDOlQdZygQZVecfVsA4jT+NhhHTStrtKoC5bYf/xBLfMRp78cCMqpQYgiIrhFlufCrMUsrix49hESdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Io3ipe+f; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708355492; x=1739891492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ayLLTpEgKqvBUDQj5moMFIOBncxte1r8rIs7zb2L0nI=;
  b=Io3ipe+fSuBs3WX/JSX180EOJd+mCC1pJdAUW7hTI0SHzuwXM585dJWv
   +Kep0tqLlqM+9zHh+l4U0sNl5bc1JaO4v6JyjR1rcRQZJzVaPj5cjfzAY
   OGZ6fmhVo8OjhNBaDAVYg0HigMe4nLkoS7bJMKjG6ogS9mI4HhYC2Jkf7
   yqK3BnToKe5vSa4fiNVImSvFmMJ/MblO36i7T2GcEraY2t4iLJ5SN1GdI
   AFucmw9p+nqK+Mwnnq9CS+y9nYAqJPFtJqUfKtPCo9/XCz8sAIhlljzbn
   xr0s9AWyqu7JaA3cC+yJmoBTPsk5v6r0WOp+JYWnO2PG1vb0Ox3YLsh3z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2545654"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2545654"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:09:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="912890661"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912890661"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:08:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc5GI-00000005qqV-1fic;
	Mon, 19 Feb 2024 17:08:54 +0200
Date: Mon, 19 Feb 2024 17:08:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andy Shevchenko <andy@black.fi.intel.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Maxime Ripard <mripard@kernel.org>, Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] serial: 8250: Add 8250 port clock update method
Message-ID: <ZdNvBtOlxo4FlLUH@smile.fi.intel.com>
References: <20200723003357.26897-1-Sergey.Semin@baikalelectronics.ru>
 <20200723003357.26897-2-Sergey.Semin@baikalelectronics.ru>
 <ZczD7KPbeRnY4CFc@black.fi.intel.com>
 <raryiklwhctwxcfj3ulbnjcl32owagiccmxpwzmszlh3vm343y@h2ehupm7uiga>
 <Zc5oYJY6W_MCpwhN@smile.fi.intel.com>
 <ow5mvkxa4g7mub3faiytsij4cyaaralcbzyn675jny5355han7@azw65mhkpwjz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ow5mvkxa4g7mub3faiytsij4cyaaralcbzyn675jny5355han7@azw65mhkpwjz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 16, 2024 at 08:19:37PM +0300, Serge Semin wrote:
> On Thu, Feb 15, 2024 at 09:39:12PM +0200, Andy Shevchenko wrote:

..

(thanks for the detailed explanation why you have done it that way)

> If what you suggest is to replace the serial8250_update_uartclk() body
> with a direct uart_port::set_termios() invocation then I don't find it
> being much clearer really. The serial8250_update_uartclk() is
> currently specialized on doing one thing: adjusting the divider in
> case of the UART-clock change. If instead the entire
> serial8250_set_termios() method is called then for a reader it won't
> be easy to understand what is really required for a 8250 serial port
> to perceive the ref-clock change. But from the maintainability point
> of view I guess that it might be safer to just call
> serial8250_set_termios() indeed, since among the other things the
> later method implies the divider update too. Thus the maintainer won't
> need to support the two clock divider update implementations.

> From that perspective I agree, directly calling serial8250_set_termios()
> might be more suitable despite of it' doing more than required.

Would it be possible for you to cook the patch (and test on your HW,
since it seems the only user of that)?

-- 
With Best Regards,
Andy Shevchenko



