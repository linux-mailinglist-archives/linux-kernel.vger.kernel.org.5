Return-Path: <linux-kernel+bounces-65727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B608550E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6631C276C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3817D418;
	Wed, 14 Feb 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H40AzB/7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F6126F3E;
	Wed, 14 Feb 2024 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933306; cv=none; b=gYnDIr9Ajqg6kegHPVURH/eqInwPa7GZu75yDKvNspqR76KTEFXRQbq5rIzQ6bG49723fb4jpaEbflCa25DkoeE83xMA9qFwfx/QUOJBMhqzKHbl1wvOORA7CGI601iq1Hytyu4QHuA9z5su2oDSK40Y9Pr/qd0ucXNtHbFkYTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933306; c=relaxed/simple;
	bh=aj7CoZ0NAdOuL6mZfwN+KVUUcS2JZ6cq6z7lzJwvVU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSRxQJhf05Le2x3hsX0I9895YQkjO21YGRZGCFEES3L9Im/bxcrWtF/58GiQghruDvEncnz7JyX3CMcGg7fkfj0x/uL/xne6vadHn8MLk7cGEyhNtTD5ZZAUIPnBK2ZSPfSwn7QZRY8HfhQswMvLaOIv6jufgmsogkAw0qvJdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H40AzB/7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707933305; x=1739469305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aj7CoZ0NAdOuL6mZfwN+KVUUcS2JZ6cq6z7lzJwvVU0=;
  b=H40AzB/7EEFdEsObd8B10FD6Wbnbyq96FR5lpwnPMaw7Fjp0uqKivCQB
   PtCi+NEC/YDWgxfX9yEHUGII2hoTtBqUC9CTIzhY56R9NpVt7uxdqJnAQ
   5l6VZCaYrg+JyoL0ogfJ2D4K5XVrvqrnYo+oRkru8P9A7aZ4DmqGDjA/G
   w/jYAxJ/AUZ1KKGJRIg1JJrTJmzyXDmHUTAPnYWqJNju5Pz+1a6UE7dlH
   Lhvz7j6YVO1hcOdApdJc8kp8spMXnNq6AIAhoNFe5c06aGc7OdniXp59a
   dBXoDHAZvetAhrqpFzGSeeOAoqvX5ss6FbniEXuPW/Ue3nc8kDhjdEKg4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13381417"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="13381417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912092863"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912092863"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:55:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJTG-00000004Yld-3fku;
	Wed, 14 Feb 2024 19:54:58 +0200
Date: Wed, 14 Feb 2024 19:54:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pwm: dwc: drop redundant error check
Message-ID: <Zcz-csPY5x29DP7v@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-2-raag.jadav@intel.com>
 <qrwcje4t2pbbxilnlfz2q7njodcp6vl54uaypdbvjgvwhgvc5g@4eq5wvumpjjx>
 <ZcUJoSMhgC7lhY-H@smile.fi.intel.com>
 <cv6w4n2ptcdehn5n3mipuyfrtemm4rldhiyppazk4uqdn2xx7e@hxg4kldaacxk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cv6w4n2ptcdehn5n3mipuyfrtemm4rldhiyppazk4uqdn2xx7e@hxg4kldaacxk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 06:45:48PM +0100, Uwe Kleine-König wrote:
> On Thu, Feb 08, 2024 at 07:04:33PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 08, 2024 at 08:46:44AM +0100, Uwe Kleine-König wrote:
> > > On Thu, Feb 08, 2024 at 12:35:25PM +0530, Raag Jadav wrote:
> > > > pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
> > > > check for failure if the latter is already successful.
> > > 
> > > Is this really true? pcim_iomap_table() calls devres_alloc_node() which
> > > might fail if the allocation fails. (Yes, I know
> > > https://lwn.net/Articles/627419/, but the rule is still to check for
> > > errors, right?)
> > 
> > We do not add a dead code to the kernel, right?
> > 
> > > What am I missing?
> > 
> > Mysterious ways of the twisted PCI devres code.
> > Read the above commit message again :-)
> > 
> > For your convenience I can elaborate. pcim_iomap_table() calls _first_
> > devres_find() which _will_ succeed if the pcim_iomap_regions() previously
> > succeeded. Does it help to understand how it designed?
> 
> I assume you're saying that after pcim_iomap_regions() succeeded it's
> already known that pcim_iomap_table() succeeds (because the former
> already called the latter).
> 
> I'm still concerned here. I agree that error checking might be skipped
> if it's clear that no error can happen (the device cannot disappear
> between these two calls, can it?), 

It depends. If you call it in some asynchronous callbacks which may be run
after PCI device disappears, then indeed, it's problematic. But you probably
will have much bigger issue at that point already.

In ->probe() it's guaranteed to work as I suggested (assuming properly working
hardware).

> but for me as an uninitiated pci code
> reader, I wonder about
> 
> 	dwc->base = pcim_iomap_table(pci)[0];
> 
> without error checking. (OTOH, if pcim_iomap_table() returned NULL, the
> "[0]" part is already problematic.)

Seems it's your problem, many drivers use the way I suggested.

> I'd like to have a code comment here saying that pcim_iomap_table()
> won't return NULL.

Why? It's redundant. If you use it, you should know this API.
So, the bottom line, does this API needs better documentation?

-- 
With Best Regards,
Andy Shevchenko



