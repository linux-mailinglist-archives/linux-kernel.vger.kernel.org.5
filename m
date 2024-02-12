Return-Path: <linux-kernel+bounces-61784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9125685167B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4CE282457
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD63C490;
	Mon, 12 Feb 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFVdNLoV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D63C481;
	Mon, 12 Feb 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746510; cv=none; b=SGkcRtL9pXSrohuJHZoE7XFF4n5D5G06wjrLjLcIh1/G+i6BLYYNe5cxNi8wvsH6twbCV5/VD+njUUICA3gNmYnsw8CCSWlyZkQwOTJLA9f4GiYHSTuJ0eYq4ZG+MEtg21czvH3i2+F+NqYJCVE8IWyOz5Rgt1FVmQaPkt091uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746510; c=relaxed/simple;
	bh=+k/jxrO0zWN40HjTz5V2N5DaQA7u2Sd/R7/hgOheP60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sceAc/SuNzjaCGHwpeSUEDnweztG1e5Cvc+Du9mOGh3qwYCYeiJO6qSE7Rv6dBNIbR4nTE47wEHzkEL6x8JStI1O950sfZLK4CR/+YhhoRz8vTKJD/fNiTAlujoEd1c2qVINkbUhbyfA2tmp7SRhM/PLbVGbCEIBeGgDZKwOPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFVdNLoV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707746508; x=1739282508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+k/jxrO0zWN40HjTz5V2N5DaQA7u2Sd/R7/hgOheP60=;
  b=QFVdNLoVmjNJJrre0np1kOK0p98XuJRTVGAS+UNIZap46XsaLqCY3qNY
   tPXk8ysSXYaBwkRmvv2xKYjevx3r6T0QfnT2oJkDeRiQ/gUBRAGIWzc+M
   I22vyPe7dg2hcg/CYfIoX872wUpN1jeW32exLUqLwQx9snXXdQOhaauQf
   Lsi1bxEB9TjpA4U23VjdrKyVIPCb8zzxI3eTzgEzjfJpAT15as375B3zF
   4WjWNtegYh8J4rCCcWrWYwtpayWze7shiTwTWkCDsrKy9KPHRMSqAkvPa
   IwqbZV46ruwpsog7KL/v1MSkHCZ+AA+gspa9m6dW+aDiLkGLvkTgGOlwv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5535970"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5535970"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911490360"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911490360"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:01:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWsM-00000003unC-1szc;
	Mon, 12 Feb 2024 16:01:38 +0200
Date: Mon, 12 Feb 2024 16:01:38 +0200
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
Message-ID: <ZcokwpMb6SFWhLBB@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
 <20240212075646.19114-4-herve.codina@bootlin.com>
 <ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
 <20240212143753.620ddd6e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212143753.620ddd6e@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 02:37:53PM +0100, Herve Codina wrote:
> On Mon, 12 Feb 2024 14:27:16 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 12, 2024 at 08:56:31AM +0100, Herve Codina wrote:
> > > Currently the bitmap_onto() is available only for CONFIG_NUMA=y case,
> > > while some users may benefit out of it and being independent to NUMA
> > > code.
> > > 
> > > Make it available to users by moving out of ifdeffery and exporting for
> > > modules.  
> > 
> > Wondering if you are trying to have something like
> > https://lore.kernel.org/lkml/20230926052007.3917389-1-andriy.shevchenko@linux.intel.com/
> 
> Yes, it looks like.
> Can you confirm that your bitmap_scatter() do the same operations as the
> existing bitmap_onto() ?

I have test cases to be 100% sure, but on the first glance, yes it does with
the adjustment to the atomicity of the operations (which I do not understand
why be atomic in the original bitmap_onto() implementation).

This actually gives a question if we should use your approach or mine.
At least the help of bitmap_onto() is kinda hard to understand.

> If so, your bitmap_gather() will match my bitmap_off() (patch 4 in this
> series).

Yes.

-- 
With Best Regards,
Andy Shevchenko



