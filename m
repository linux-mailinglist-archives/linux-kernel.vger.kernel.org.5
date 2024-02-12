Return-Path: <linux-kernel+bounces-61829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E51851722
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFCC1F21D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423703B2BD;
	Mon, 12 Feb 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZ5gJbiN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8863B189;
	Mon, 12 Feb 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748608; cv=none; b=l/FVk7tddrudmqnTpLxM7wjl1fr85rfZA2tu4ttrlsTSDBI6CXMz4D8hBuD2mfJkuP8baY/RGM+K1PMGufnt9UzSeIAtxkOMnuKEmWtaoFcJRyS35aHdmzyzEPeJp8q8NpU23FftFtqVPnDazO5MxMhx03MNWoZzJwg1sGNbLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748608; c=relaxed/simple;
	bh=NgxONl1Mo80zC/wVZflOnNJ1Dx1W2G8WQMUGFtld7AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz8yI/uUBSp8cgj40CIJgTMpUD1oD5KdvHG0rANKjRaGkwnXo2CH1TmgfPzU3SR5TfWB/Qf7QYyQxk9YfEjweggC/tO9UzIgxcAVL8qQMjlK81E/NyhJMLJXHqPfO1TR2ylmd2S3H4Kc5dD+LDAxk69Y8qWTFjhHIuCGpTdoYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZ5gJbiN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707748608; x=1739284608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NgxONl1Mo80zC/wVZflOnNJ1Dx1W2G8WQMUGFtld7AY=;
  b=KZ5gJbiNIJw9MVZtjRiPdhkCUMZuPef31cWMTVwfE7qEKaJZ6giNBIxi
   NyfEkyHuzp2wg9JEiF2lUWYvbsw6148Ttfj5JsXdSyaL5yXc+HhpVXk6y
   iOcvOAsAD17IG+dINIxwxC1wWB3pqgO2InxS1NoHqrap66Wi8DnVAw4RG
   KvlltSbK3GcnElf/pQ9FWYhO3560iHFru3DkZFxp/TuLq5GMDx477TMcW
   IUIaxr2RED+ROfirWOrVHwHJrCqBkuJ6USQvH02BvTOtvbe6CQo0fm9Y7
   YdxSrs5BmxnqwKO+hpJzDPGZN5CzVc7KIJGJXueHZscUAnPuUKb70fwCX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12815641"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="12815641"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911498069"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911498069"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:36:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZXQD-00000003vJa-11bE;
	Mon, 12 Feb 2024 16:36:37 +0200
Date: Mon, 12 Feb 2024 16:36:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 RESEND 3/6] bitmap: Make bitmap_onto() available to
 users
Message-ID: <Zcos9F3ZCX5c936p@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
 <20240212075646.19114-4-herve.codina@bootlin.com>
 <ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
 <20240212143753.620ddd6e@bootlin.com>
 <ZcokwpMb6SFWhLBB@smile.fi.intel.com>
 <20240212152022.75b10268@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212152022.75b10268@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 03:20:22PM +0100, Herve Codina wrote:
> On Mon, 12 Feb 2024 16:01:38 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

..

> Agree, the bitmap_onto() code is simpler to understand than its help.
> 
> I introduced bitmap_off() to be the "reverse" bitmap_onto() operations
> and I preferred to avoid duplicating function that do the same things.
> 
> On my side, I initially didn't use the bitmap_*() functions and did the the
> bits manipulation by hand.
> During the review, it was suggested to use the bitmap_*() family and I followed
> this suggestion.

I also would go this way, the problems I see with the current implementation are:
- being related to NUMA (and as Rasmus once pointed out better to be there);
- unclear naming, esp. proposed bitmap_off();
- the quite hard to understand help text
- atomicity when it's not needed (AFAICT).

> I did tests to be sure that bitmap_onto() and bitmap_off() did
> exactly the same things as my previous code did.

Yuri, what do you think about all this?

-- 
With Best Regards,
Andy Shevchenko



