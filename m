Return-Path: <linux-kernel+bounces-67562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D472856D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF181C222F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA56139587;
	Thu, 15 Feb 2024 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/pkdJIP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1182595;
	Thu, 15 Feb 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024653; cv=none; b=QrTxQ7iU5+HM3h1j74eODtp5J47Q1t2Z1I7+Gmq3jwQXtGecZdvOy77H35weRKF7VQ/mR0mp2Zf3F2RNblMU8QUYODs6edlJZva3m2+rjmoWUxVhjdEOrIGZ7wIsV8QOmKkep0hCuwwuIWYEyyy03mC+XEaQzDz5eaapxQknIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024653; c=relaxed/simple;
	bh=nq1gXXMtQTFmzjqZbMFawObh/b5GZMKjRfQ9FOAf2eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtJt5e/LYoygutpvtSE0eGE0tHZh5Y3sjbs1uVerkUrQBczibxKtLAHb4TozoWjLaUVYxnO7RSbi9oJ0YttB05C06kJBKQvZcWK0Uau2fFHj+ScckbSnrxrr2oLlodMbWdOh4NnEA+fGgaz4k9m99KFyZRZmsYka1ZcJWLkL8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/pkdJIP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708024652; x=1739560652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nq1gXXMtQTFmzjqZbMFawObh/b5GZMKjRfQ9FOAf2eI=;
  b=j/pkdJIPUPJPVEkjSKERG3Xw0iIIOMvZLm1F2S81v0A/aUWou/H1QleT
   aVidnTtEYz3PTmCd7/Bb1vOlUnR6Gf3GoaYwla3qoCWcx+XnTXBIz4Bdc
   tllbIJBVL9BzGNPcJr7Luxcr/dgP6dmiUgsy4FqMCNN2JJainDLWJdhbG
   a92Laxl/HVi7qCvMvHofE8jXNR6wBWVkLUCthcKN5Z80us7o6FUv3xrhs
   LS8oMTP8FrFzhJbJIEVo7oUbFMKruc3MycQQ1zSUkblbb7I0dZR1H5+u/
   i5zV99ttMnCzxGJtMCfYOzrvVz9m52lv1E80ArALUP6OA2qp6JT5AmlCD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2255249"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2255249"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912215250"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912215250"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:17:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rahEa-00000004s7i-0DgF;
	Thu, 15 Feb 2024 21:17:24 +0200
Date: Thu, 15 Feb 2024 21:17:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 RESEND 3/6] bitmap: Make bitmap_onto() available to
 users
Message-ID: <Zc5jQ3zR51MDIovB@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
 <20240212075646.19114-4-herve.codina@bootlin.com>
 <ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
 <20240212143753.620ddd6e@bootlin.com>
 <ZcokwpMb6SFWhLBB@smile.fi.intel.com>
 <20240212152022.75b10268@bootlin.com>
 <Zcos9F3ZCX5c936p@smile.fi.intel.com>
 <Zcptyd/AWrDD3EAL@yury-ThinkPad>
 <20240215184612.438bd4f2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215184612.438bd4f2@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 06:46:12PM +0100, Herve Codina wrote:
> On Mon, 12 Feb 2024 11:13:13 -0800
> Yury Norov <yury.norov@gmail.com> wrote:

..

> > That's I agree. Scatter/gather from your last approach sound better.
> > Do you plan to send a v2?

See below.

..

> > I think your scatter/gather is better then this onto/off by naming and
> > implementation. If you'll send a v2, and it would work for Herve, I'd
> > prefer scatter/gather. But we can live with onto/off as well.
> 
> Andy, I tested your bitmap_{scatter,gather}() in my code.
> I simply replaced my bitmap_{onto,off}() calls by calls to your helpers and
> it works perfectly for my use case.
> 
> I didn't use your whole patch
>   "[PATCH v1 2/5] lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers"
> because it didn't apply on a v6.8-rc1 based branch.
> I just manually extracted the needed functions for my tests and I didn't look
> at the lib/test_bitmap.c part.
> 
> Now what's the plan ?
> Andy, do you want to send a v2 of this patch or may I get the patch, modify it
> according to reviews already present in v1 and integrate it in my current
> series ?

I would like to do that, but under pile of different things.
I would try my best but if you have enough time and motivation feel free
to take over, address the comments and integrate in your series.

I dunno what to do with bitmap_onto(), perhaps in a separate patch we can
replace it with bitmap_scatter() (IIUC) with explanation that the former
1) uses atomic ops while being non-atomic as a whole, and b) having quite
hard to get documentation. At least that's how I see it, I mean that I would
like to leave bitmap_onto() alone and address it separately.

> Yury, any preferences ?

-- 
With Best Regards,
Andy Shevchenko



