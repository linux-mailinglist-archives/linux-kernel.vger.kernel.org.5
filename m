Return-Path: <linux-kernel+bounces-32063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA208355EA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0FEB2296C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1606837179;
	Sun, 21 Jan 2024 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Updjnxkc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CF273FB;
	Sun, 21 Jan 2024 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705843429; cv=none; b=V8yFGPKfaZ/Uz4WnXM+cQH6wSPouJ9FeUwPWCmt+8KkREcUvAWQJR+8fBnO7IsaXAFqmq+WmoZhI3XScaPex3gsCT3rCrfS0qhl1Ow2YvYfT3tBJcBfEfLNAwJGJublfAmzjgplZH3RRghb3VheLCy9CvmToZlFUPHup2xWZ9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705843429; c=relaxed/simple;
	bh=nX0wC3BXoOzexoh889i8A9lXHbcB97hLlRRcCvc5jK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2Oaa8hAdc4Jl1vsb8Evm3Fg4SsKrPH9urDC3IbI/1Nk/Zq9JpF4vZ8LlsC5Gz90NoFQoXbWTA5QTJLWfXkPBEeCVp/WpO0rgvObAfn0GRny6YCXefAR4x8OpqMaW1GkW5ur2VYazbdWck5u3l859t+x4M0NRbMcgjYChUp/N/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Updjnxkc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705843428; x=1737379428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nX0wC3BXoOzexoh889i8A9lXHbcB97hLlRRcCvc5jK0=;
  b=Updjnxkc/brJwTOynlFOjknErD5VHkfRXyxdXfQ4K+hu/NomLvVjYcm8
   oQN1n75VvLwcTxHAaZ/3kQS+pjK5bgqIo5uZE3Exol//XWROi9CDfOqXI
   r8/a7GE/jbsqNk8f7B0gu8BM0mrTw4QZi2g2DwedfkzZexD7SrOUd+/LP
   G7blzQYknXv6+T8OeVc2e6cA0scI9ZfWV9gH8J+SuFais15C8Yy9cqfpi
   IzDMDoh7Cgsh7AktOsNhirBE0hc0WcU4F01yNUkV7Alg+2H1smssyQWym
   9KlsL70cMjm+OoFD2bT2tNLlS4U2m4E71mNtULWACT1Vdex+dJMLV882f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="920816"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="920816"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 05:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="855725066"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="855725066"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 05:23:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rRXna-0000000FdSJ-1rNo;
	Sun, 21 Jan 2024 15:23:42 +0200
Date: Sun, 21 Jan 2024 15:23:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_ether: Re-attach netif device to mirror
 detachment
Message-ID: <Za0a3tVpml9c0VFv@smile.fi.intel.com>
References: <20231218164532.411125-2-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218164532.411125-2-mailingradian@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 11:45:33AM -0500, Richard Acayan wrote:
> In 6.7-rc1, there was a netif_device_detach call added to the
> gether_disconnect function. This clears the __LINK_STATE_PRESENT bit of
> the netif device and suppresses pings (ICMP messages) and TCP connection
> requests from the connected host. If userspace temporarily disconnects
> the gadget, such as by temporarily removing configuration in the gadget
> configfs interface, network activity should continue to be processed
> when the gadget is re-connected. Mirror the netif_device_detach call
> with a netif_device_attach call in gether_connect to fix re-connecting
> gadgets.

Tested-by: From: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # Intel Merrifield

-- 
With Best Regards,
Andy Shevchenko



