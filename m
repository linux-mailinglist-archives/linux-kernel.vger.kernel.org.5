Return-Path: <linux-kernel+bounces-61544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2063851388
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C6DB232DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E30B39FDC;
	Mon, 12 Feb 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxIAX19Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C513984D;
	Mon, 12 Feb 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740846; cv=none; b=cqfOB9mbzmK1D9U6/9K48JOj5ZIikhBolfzr+6NS5YKbqpL/++EnT+xKr0EMtGlQiRC5d0VWF02DragAJYnYNWvEEnEjImoCYcWGWE9nEJgYFFzoegHtGrtg7azrkrujZIeFYfmSmp1TMUn2w71fiYMKrweq9yk/qSRfRRZVrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740846; c=relaxed/simple;
	bh=hbdJFCCuPFgmNxY6Pc6OeFv4Zasw/ff5zsB4psb92tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW9s6NlCdE8eByEwMxFXSOHxbvjY8tkvdvkOnN39KXIz0tVwKLFArdU2ojE/hepaZbnARyKblEoB7V2K5QEMAhc1t95hl+Uj82lYQ5MQQ6gbcc2vVWAmbmQNfw/TN094qklpczo3dPMLki+8M1M5I5sBfZf63wZq6I52H/6tC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxIAX19Q; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707740845; x=1739276845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hbdJFCCuPFgmNxY6Pc6OeFv4Zasw/ff5zsB4psb92tU=;
  b=IxIAX19Qq89sk8rqxYTiZbpKoIs5WACFrOfY0pfmBAyvTV6mNFOOdxCW
   ZKMCtBw0V90K8Mzgt9ejsRK7YTbLOLrM/4gGdmZ1khvCfrdvbzZuNNeKS
   x02VY6Fwp/AFNvNA7JmyYr/a5iw/aLo2Uw8fIpDusB0BWno33Xp8xeVNc
   OGW8W9cuYUBGFNeZ7ZC3JlKrxLAanmlspbCiHS/kW4VG9WQerYRd1+eXl
   sFeFZ99iluaNOkFAO6cyV8rES5jS8HPfgJeYH7LmFxCAIQuC1zYgOuSVs
   ILFoCC/SaXMoW0OD5W9SWxsDlHRkin/LHzNZ7l2AN3d4IUnzm7F84EHLj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1592171"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1592171"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:27:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911468813"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911468813"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:27:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZVP2-00000003tMs-1ItT;
	Mon, 12 Feb 2024 14:27:16 +0200
Date: Mon, 12 Feb 2024 14:27:16 +0200
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
Message-ID: <ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
 <20240212075646.19114-4-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212075646.19114-4-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 08:56:31AM +0100, Herve Codina wrote:
> Currently the bitmap_onto() is available only for CONFIG_NUMA=y case,
> while some users may benefit out of it and being independent to NUMA
> code.
> 
> Make it available to users by moving out of ifdeffery and exporting for
> modules.

Wondering if you are trying to have something like
https://lore.kernel.org/lkml/20230926052007.3917389-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko



