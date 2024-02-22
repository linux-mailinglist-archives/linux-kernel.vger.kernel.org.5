Return-Path: <linux-kernel+bounces-76793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D98B85FCAD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8871F26931
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F5114F9D0;
	Thu, 22 Feb 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OM0uGCBz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611D14E2EA;
	Thu, 22 Feb 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616377; cv=none; b=uIwH4rzAyT6+162aY/Q43Z4OtXmP9jmg8cMEYZX8cMBk6axVb68hS19YMziCvHmzy+Hl1Pf9WKsqM6mae14ehxJIOfhNdex9hQge5H554e/0C6mI/y2FKF5KNs3wZ+GMAcLPss/j4a84G0/nxJoJr9rTD9xn1abYSmfXKBI0xqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616377; c=relaxed/simple;
	bh=VwHg7LUdcIrFoPjrcD5ddqTta7KlIaNL26jH4Yy3jIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sE0XxqQv+/cfvJOOy1GB5XU8q8PPEeMttZSnFsZvCCDYJF43dt+MI6/wXSlXsGO9o+Aq+r2WLYDtLz8FUOtv2JzwoqN8xo7QyEsxb54F7VRWf3QiG7M3AkZeQCObLqekbB3kwkvHjNncDWaPUB15BQ9ow4FUPa7JmZMeLN9v28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OM0uGCBz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708616375; x=1740152375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VwHg7LUdcIrFoPjrcD5ddqTta7KlIaNL26jH4Yy3jIM=;
  b=OM0uGCBzKRcWGJByDuqLzYS3Tf5nT1AwoTlclXoLB4dAKtEkUI1QR2Pn
   hGsGva+jZRo6OL/yZrhjkPXclK0gEjIc8OuXoEONlsjWQMEjiMMZtcZ6H
   zLVCLvXR8RLt8wVACPcLomJUm2SVgwWPHb344mU6tZKNGYq5cHaHgdpON
   h2rat+VDy5yQsQkMt+EiNTITVC/MpXPKIFKUmqBV5Grxk1OF5+hJl8a+s
   ZNOQXEN8jmWLykE0h5UIECO5xKqReXwBK/2YcwG9Wk8kLL4G2t7vrZvLt
   HCFhgNVgC5tmxDn4u05L8vHEsZObut6M5G3qLxw2EqIBLZoErr0/f54aq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2985497"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2985497"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:39:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913544289"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913544289"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:39:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdBAV-00000006fLv-3ofM;
	Thu, 22 Feb 2024 17:39:27 +0200
Date: Thu, 22 Feb 2024 17:39:27 +0200
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
Subject: Re: [PATCH v4 3/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <Zddqr3aN4rU-upai@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
 <20240222142219.441767-4-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222142219.441767-4-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 03:22:16PM +0100, Herve Codina wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> These helpers scatters or gathers a bitmap with the help of the mask
> position bits parameter.
> 
> bitmap_scatter() does the following:
>   src:  0000000001011010
>                   ||||||
>            +------+|||||
>            |  +----+||||
>            |  |+----+|||
>            |  ||   +-+||
>            |  ||   |  ||
>   mask: ...v..vv...v..vv
>         ...0..11...0..10
>   dst:  0000001100000010
> 
> and bitmap_gather() performs this one:
>    mask: ...v..vv...v..vv
>    src:  0000001100000010
>             ^  ^^   ^   0
>             |  ||   |  10
>             |  ||   > 010
>             |  |+--> 1010
>             |  +--> 11010
>             +----> 011010
>    dst:  0000000000011010
> 
> bitmap_gather() can the seen as the reverse bitmap_scatter() operation.

> The original work was done by Andy Shevchenko.

Mine SoB is enough for a credit, but thank you :-)

..

> +/**
> + * bitmap_gather - Gather a bitmap according to given mask
> + * @dst: gathered bitmap
> + * @src: scattered bitmap
> + * @mask: mask representing bits to extract from in the scattered bitmap
> + * @nbits: number of bits in each of these bitmaps
> + *
> + * Gathers bitmap with sparse bits according to the given @mask.
> + *
> + * Example:
> + * If @src bitmap = 0x0302, with @mask = 0x1313, @dst will be 0x001a.
> + *
> + * Or in binary form
> + * @src			@mask			@dst
> + * 0000001100000010	0001001100010011	0000000000011010
> + *
> + * (Bits 0, 1, 4, 8, 9, 12 are copied to the bits 0, 1, 2, 3, 4, 5)
> + *
> + * A more 'visual' description of the operation:
> + * mask: ...v..vv...v..vv
> + * src:  0000001100000010
> + *          ^  ^^   ^   0
> + *          |  ||   |  10
> + *          |  ||   > 010
> + *          |  |+--> 1010
> + *          |  +--> 11010
> + *          +----> 011010
> + * dst:  0000000000011010

Cool!

> + * A relationship exists between bitmap_gather() and bitmap_scatter() (See

Either '... (see'
or '(). See'

> + * bitmap_scatter() for the bitmap scatter detailed operations).

> + * Suppose scattered computed using bitmap_scatter(scattered, src, mask, n).
> + * The operation bitmap_gather(result, scattered, mask, n) leads to a result
> + * equal or equivalent to src.

This paragraph...

> + * The result can be 'equivalent' because bitmap_scatter() and bitmap_gather()
> + * are not bijective.


> + * The result and src values are equivalent in that sense that a call to
> + * bitmap_scatter(res, src, mask, n) and a call to bitmap_scatter(res, result,
> + * mask, n) will lead to the same res value.

..seems duplicating this one.

I would drop the latter one.

> + */

-- 
With Best Regards,
Andy Shevchenko



