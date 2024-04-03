Return-Path: <linux-kernel+bounces-129604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF8B896D14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6F91F31282
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E88139581;
	Wed,  3 Apr 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hC06IWpH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612CF136674
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141219; cv=none; b=BP3xiYhdChiytyOTAvrBZ7dWR0jB1+qXh3vgEpDNVwJ7tsVY79g1Uiv2b9tcEpSgs/fH/ZmyE2L5n4usRgxXMeEQck6NX1xTHciSkkdhZp/y1swWfVPcg+JLzrIewbt6FEE71CzWZGmN/zeUNVIfgxRQmtilbuFQuHmVeDcqQ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141219; c=relaxed/simple;
	bh=CNEpcz5/OubUYF8ylHtJPsNUYIrlKQyGeuSEe5hO77w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7ZA9SsZgrzsfz30k9kyCYOQ1kdyBIGKPrNO2Zj5sC/YC2v2+mcEW0PejjPhVRceVPvlRanpCFnzMtkCsAvkFeDInQWldDmXZqzU358uqTn4tE/vDC5Sto0Fo8JTnvY2ljurVUsPZhehkj0clnajb54TypFzRJBH5SpNFyVPeIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hC06IWpH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712141217; x=1743677217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CNEpcz5/OubUYF8ylHtJPsNUYIrlKQyGeuSEe5hO77w=;
  b=hC06IWpHUEPwRDndBtchBcHGmF9TuxWh0uVcvbRgfnYOlJZwelOfm9cN
   VoZUG/dnAmKDX+D46Tl/V2TdW5ZQa02877iCsRRc2qf7Gs7Oowyqs2hlw
   XW8kQaHbTiybLByoJYiYOET31e+RRsQn6ygoR4fTC44uni6SpkD56a1Ab
   yAm3FCFAAGpDLmsqyjCe/JGpHdzhido4CdTpIt9xkQLnriwKJNnxWkQGL
   vo5W9axiPJwdgCAc/5Un3ncJjR/eSFYHk3x4+pY+TcDR83NMTrCILn4vX
   o+NKgImYovKmL3eFo/q/wSvnvM43qr4h6VZeRQIw3uACDPyt/mOEu+yj9
   w==;
X-CSE-ConnectionGUID: jvekmUSySMClU+QDcM+mbw==
X-CSE-MsgGUID: psMzRsNsQ9mI87LRqm/9hQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24864473"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="24864473"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915178449"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915178449"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:41:21 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rry3T-000000015qz-0hJz;
	Wed, 03 Apr 2024 13:41:19 +0300
Date: Wed, 3 Apr 2024 13:41:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Anatolij Gustschin <agust@denx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] powerpc/52xx: Replace of_gpio.h by proper one
Message-ID: <Zg0yTnTswS2je9VG@smile.fi.intel.com>
References: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 03:56:45PM +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.

Any comments on this?

-- 
With Best Regards,
Andy Shevchenko



