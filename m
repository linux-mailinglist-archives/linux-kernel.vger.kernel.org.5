Return-Path: <linux-kernel+bounces-59099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625FA84F12E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F113281B15
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E1265BBC;
	Fri,  9 Feb 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mg52NG6W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447FA657C7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465731; cv=none; b=HhBQHKFFKe+tCZgHSfRj1Xn3dww3X5SVXus2DxfuFRNyOBW0qIfHLOBxLIfXYQxwseWS+6fCL8Z8FcAmgFlJwde7H6a3htQoDoU2H4sYldNLVpaIhjZp2Ou7tcH8wApyUkqCwwIpKFnVd9fcsZ3ulomcoxgzW9ut4OVlgU6NSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465731; c=relaxed/simple;
	bh=8hv1yW6IbM58UJxt3tLusyVgrFws3JiyjYCrzaAsMUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J2wDCB7zXXF9SI8ufo/puAMYXGBSvmv5ZacJWzXpTP3YhKM+y7hCF4RHwJEzA1wk+5Et2+KmjJUukcmW02SbAk3beHeXCBD7xZfKGvEkByazeE7Yy9o7uJ6BSF0/YM1IIPNRYJfgJx/HmbAufN7l7+LcpstQsJ7j3tDI/mBmGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mg52NG6W; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707465730; x=1739001730;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8hv1yW6IbM58UJxt3tLusyVgrFws3JiyjYCrzaAsMUI=;
  b=Mg52NG6W2BgAwDHnsZBtwLO+szBuod2tbdrE2AdwM+lAH1djC52dHCZp
   ndMAYWBfz9+6YwsjrdCWywoy0ChQ7OA1VVEWX+Wo1tGIS+Ub/mr2pkcM1
   QLIYzC1vhP9Bm2l1nAuMjq5Ryw2zno7Z2bSOIT0D+9XI/DyjsoKFT3Y+F
   udyK3VqSOq9uGlKS5TYDAD7AnBM9SCZ9clPNBloPnGCVxx5ihe/bjuTGR
   fOV4wQn4ef2AZxdg8zGH7BOugDbnX/S8AA2Nvi3YbTGPT4xO8UCdegBCu
   r8vBEEuVPZBswT/YX5UpzZwhgrOqWjzvN+xPsQYkeTUIV9VCAHwNvZ7vV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="18802460"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="18802460"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 00:02:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="6500951"
Received: from mziotti-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.43.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 00:02:05 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: Re: [PATCH v3 2/3] bits: Introduce fixed-type BIT
In-Reply-To: <ilppncjskpt52bijaoxlwcklawjpw5cqrndtx2g5xnwpj6bhbm@kn5yjscaha5e>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-3-lucas.demarchi@intel.com>
 <ZcUz3V56qNeTVq66@ashyti-mobl2.lan>
 <ilppncjskpt52bijaoxlwcklawjpw5cqrndtx2g5xnwpj6bhbm@kn5yjscaha5e>
Date: Fri, 09 Feb 2024 10:01:58 +0200
Message-ID: <87il2yaww9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 08 Feb 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> On Thu, Feb 08, 2024 at 09:04:45PM +0100, Andi Shyti wrote:
>>Hi Lucas,
>>
>>looks good, just one idea...
>>
>>...
>>
>>> +#define BIT_U8(b)		((u8)(BIT_INPUT_CHECK(u8, b) + BIT(b)))
>>> +#define BIT_U16(b)		((u16)(BIT_INPUT_CHECK(u16, b) + BIT(b)))
>>> +#define BIT_U32(b)		((u32)(BIT_INPUT_CHECK(u32, b) + BIT(b)))
>>> +#define BIT_U64(b)		((u64)(BIT_INPUT_CHECK(u64, b) + BIT(b)))
>>
>>considering that BIT defines are always referred to unsigned
>>types, I would just call them
>>
>>#define BIT8
>>#define BIT16
>>#define BIT32
>>#define BIT64
>>
>>what do you think?
>
> it will clash with defines from other headers and not match the ones for
> GENMASK  so I prefer it the other way.

Agreed.


-- 
Jani Nikula, Intel

