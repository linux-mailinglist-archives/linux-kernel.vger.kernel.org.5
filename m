Return-Path: <linux-kernel+bounces-86911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578DF86CCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AF81C20F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF313EFF6;
	Thu, 29 Feb 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIgh2tni"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81813777D;
	Thu, 29 Feb 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219859; cv=none; b=GXV0hJsjV9E3WksOmSORctJPJrburmMeBPRXL7jgrNt/Da/mzjjWitA098dWhocM65ESAhFNM0q2EynbADBWKYJXGUI3XL6OJIGu4Nluhn+7G5I2o8b4UMkCSd/oM4cMgoirg2CPgYp9LTb8TODKPtxI/L4QAfP8jTqDVcR5tCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219859; c=relaxed/simple;
	bh=oLRc3WhRkuCv1lTZmfKgUONC6J83KWsGVD8/2oxXDPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKcdpHg69pLoZENCjyLQIzGk4E9aV3CyUmS5wCn5oCQ9lI9cm+UolHAtc8CIBz7akJnNZiaYhQH62lEmwIE96N7A/fylsaJxEpJuPgabEcq9HmPNiBqwnVyAtHIPM13UEBxNgN5dLp4uWzyQEZYETTqBI4SmI3qlvGDA8ZCyI+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIgh2tni; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709219858; x=1740755858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oLRc3WhRkuCv1lTZmfKgUONC6J83KWsGVD8/2oxXDPE=;
  b=KIgh2tnikL8vv6bV06S5h4wM1r7zSkRgnLA3r2RTkmyokC3Op37pXCqn
   yyJktZgdHpHAp2eeWs7Vjp5v18K2PrCEtxGeUkCYTU2Q2aGGXqaDkZr9J
   EQ/pl8GsZMRNCoGd1BFvFhfJIA2raAl5jEzsYoD487152JuV0OnswE0j4
   XErqCidp0NpWVDw1QeDfyhKWoXOz3Quu67BfS9OBuawVYF1kjMnAAiBVJ
   i4hpfST33lYeuJ+1/1ybcWad+uhAv8uY85EjU3V7+xd3K7fQ/wkizCPqH
   tdxUKXqaFAfhtlmimKWWWSU3HmqiNFTTl12ZXGPePOr8oJAFEHvk0DbLI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3574306"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3574306"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:17:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913984318"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913984318"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:17:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfiA5-00000008he7-36Q0;
	Thu, 29 Feb 2024 17:17:29 +0200
Date: Thu, 29 Feb 2024 17:17:29 +0200
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
Subject: Re: [PATCH v5 3/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <ZeCgCWND06rD2KvD@smile.fi.intel.com>
References: <20240229141554.836867-1-herve.codina@bootlin.com>
 <20240229141554.836867-4-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229141554.836867-4-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 03:15:51PM +0100, Herve Codina wrote:
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

As I said, it's too much credit :-)

..

> + * A relationship exists between bitmap_gather() and bitmap_scatter(). See
> + * bitmap_scatter() for the bitmap scatter detailed operations.
> + * Suppose scattered computed using bitmap_scatter(scattered, src, mask, n).
> + * The operation bitmap_gather(result, scattered, mask, n) leads to a result
> + * equal or equivalent to src.
> + *
> + * The result can be 'equivalent' because bitmap_scatter() and bitmap_gather()
> + * are not bijective.
> + * The result and src values are equivalent in that sense that a call to

> + * bitmap_scatter(res, src, mask, n) and a call to bitmap_scatter(res, result,
> + * mask, n) will lead to the same res value.

For better readability I wouldn't break API calls, hence

 The result and src values are equivalent in that sense that a call to
 bitmap_scatter(res, src, mask, n) and a call to
 bitmap_scatter(res, result, mask, n) will lead to the same res value.

-- 
With Best Regards,
Andy Shevchenko



