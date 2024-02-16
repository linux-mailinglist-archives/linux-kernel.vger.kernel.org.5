Return-Path: <linux-kernel+bounces-68891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E4858182
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136011F224E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B11332AF;
	Fri, 16 Feb 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Euo5EcFm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE412F58E;
	Fri, 16 Feb 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097807; cv=none; b=byQWZGzrDjac3uEN+fiPjj/TtzQEG8YkWCl6NA6ZPa5BY5oMt+Z3C10e3pt+Z7xQuoES6KgkeyRrKfGCzKDaR4r482GWuyn8SWWANnhK+mhS8OCinqsBkKGd90EL2RDunl1810iFdi/KE4bbfMvCCcmeT1O6Dp2W6VAYUs8YwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097807; c=relaxed/simple;
	bh=nx6D/LSdFMWECnG/RJwTottdK0TUpvHXvzRCViA52jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln2NeveJTLXAdCwwqCQMpJ0C/i5GS9npi5Q0+3tLfNIDJp+MCBIwvCjTuWQlfE+eIXEJZhYPPpSc2KRuJCr5Ttr5lwwPXfzyGVPUZMZiwE7n3Yp4c9WYJTo9DhA8YMJ6wpAMq70/TlGfoTaw7jQdyn5bbvc9VY9cH7tuHqrbIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Euo5EcFm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708097807; x=1739633807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nx6D/LSdFMWECnG/RJwTottdK0TUpvHXvzRCViA52jc=;
  b=Euo5EcFmm8Imc9BaOYfsYY2yuklEQ08fwJBlefdRnVOyBZwNE1KnvMun
   RpV2gXc0Vfkm921ghGP7AKdqfwIIvXeNbI8Z/HtK5LfdI1cftmGd6Bg7c
   pm7TGpZ1eJzmquxdxhiM/uWsUamYsl6nmzONff1yNcy6kGzUCWyPzMpbB
   lmNIL1zx2NY+QX5m6hFIaFFI85CrSxw6dpqwVjjaHwrcd7McnWPhWgQHN
   c/QMGUKkCC6LbsULsQLlK/9z8kFmxdW1VD6s0TSlC4UVJOKRSsWbIa+ri
   5nuW5Ip6Q3hZcUgLqhQ8AEwCuVnOF4XdA65lcbvO8nrcR5kE7MM4fw/H2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2361655"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2361655"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 07:36:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="826590448"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="826590448"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 07:36:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rb0GT-000000055Fl-3XR5;
	Fri, 16 Feb 2024 17:36:37 +0200
Date: Fri, 16 Feb 2024 17:36:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] irq/spurious: Account for multiple handles in
 note_interrupt
Message-ID: <Zc-BBQGauwIEJJXy@smile.fi.intel.com>
References: <20240216075948.131372-2-leobras@redhat.com>
 <20240216075948.131372-4-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216075948.131372-4-leobras@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 16, 2024 at 04:59:44AM -0300, Leonardo Bras wrote:
> Currently note_interrupt() will check threads_handled for changes and use
> it to mark an IRQ as handled, in order to avoid having a threaded
> interrupt to falsely trigger unhandled IRQ detection.
> 
> This detection can still be falsely triggered if we have many IRQ handled
> accounted between each check of threads_handled, as those will be counted
> as a single one in the unhandled IRQ detection.
> 
> In order to fix this, subtract from irqs_unhandled the number of IRQs
> handled since the last check (threads_handled_last - threads_handled).

..

> +static inline int get_handled_diff(struct irq_desc *desc)
> +{
> +	unsigned int handled;
> +	int diff;
> +
> +	handled = (unsigned int)atomic_read(&desc->threads_handled);
> +	handled |= SPURIOUS_DEFERRED;
> +
> +	diff = handled - desc->threads_handled_last;
> +	diff >>= SPURIOUS_DEFERRED_SHIFT;
> +
> +	/*
> +	 * Note: We keep the SPURIOUS_DEFERRED bit set. We are handling the
> +	 * previous invocation right now. Keep it for the current one, so the
> +	 * next hardware interrupt will account for it.
> +	 */

> +	if (diff != 0)

	if (diff)

> +		desc->threads_handled_last = handled;
> +
> +	return diff;
> +}

..

> +			diff = get_handled_diff(desc);
> +			if (diff > 0) {

diff may not be negative as you always right shift by 1 (or more) bit. Hence

			if (diff)

will suffice (also be aligned with the similar check inside the helper) and
making the helper to return unsigned value will be clearer. Am I correct?

-- 
With Best Regards,
Andy Shevchenko



