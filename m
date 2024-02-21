Return-Path: <linux-kernel+bounces-74892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A645985DFAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1EB1F2490C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0B7C0A4;
	Wed, 21 Feb 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9L9uYjZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483AB76905;
	Wed, 21 Feb 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525821; cv=none; b=G3+jSfWmH1Mw40ngTWs11rN0kOosC/WClsPywxgqxSQcRyu+Qi8UZoWDq+cCHLAaY9V8azmJsNdGrJLYjSj9xSNVgpsA5SDIh1DZSvtuUKYsia3xmzVQcTSTPR1DE9FTQYb05iU9p18Bfwe/22+hr8I497hkR6DAetbGNpFnytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525821; c=relaxed/simple;
	bh=AnVfYPg9QLlMiSY5zHzUg1A2vSHWhrEptn7kKIChBoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIu4QEk4LdHQmawwWuF1pvJjnMv5hjBVwjiXTUE2tnqJDiZvPfHfqG9f6uXCErkAX0uVmCznfYcWs60lZZg8IXJJ//xAqh/ebXKrOBgp/csPOLZPVmzMixUWeOaT7wQY+SbEgc70SANjjMyfPmrg2PGjDz4X/b75vfRlX+9OV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9L9uYjZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708525820; x=1740061820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AnVfYPg9QLlMiSY5zHzUg1A2vSHWhrEptn7kKIChBoo=;
  b=U9L9uYjZPZvNCgxys9fQ+5kAb01R42X7dD0t2OKiFMXnGX7WoNzqN5jN
   wMwWEqGkPHiG2B+zT98X/8XY7B3i0natMZxIsfyoalx0CAcax5EY/LPfz
   Yte5ExO61GyXZaNmVPtntcbtuqrNWSQ/E63efPCxVmkHuk1zRgibv+ubw
   A4e+4gC4RXAnMZTiSMdanWq2P3dvMXzGpt1S29MPBd8UrFEWFYBiJv6sm
   qyg7AmYa6yMzl4JiWGc6uVN/bXnEv3OEYznzfdrfBCYd+lTBIQ0P151VL
   UA+3Xns4Ko0JOUd1VraFRKOBefbHkLuHbtmoqGMJVh8ahe3EhrIVTGbRT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2549601"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2549601"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:30:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913314388"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="913314388"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:30:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcnbv-00000006N3D-3zA2;
	Wed, 21 Feb 2024 16:30:11 +0200
Date: Wed, 21 Feb 2024 16:30:11 +0200
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
Message-ID: <ZdYI81yKNisoLR7Y@smile.fi.intel.com>
References: <20240212075646.19114-4-herve.codina@bootlin.com>
 <ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
 <20240212143753.620ddd6e@bootlin.com>
 <ZcokwpMb6SFWhLBB@smile.fi.intel.com>
 <20240212152022.75b10268@bootlin.com>
 <Zcos9F3ZCX5c936p@smile.fi.intel.com>
 <Zcptyd/AWrDD3EAL@yury-ThinkPad>
 <20240215184612.438bd4f2@bootlin.com>
 <Zc5jQ3zR51MDIovB@smile.fi.intel.com>
 <20240221144431.149c3a16@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221144431.149c3a16@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 02:44:31PM +0100, Herve Codina wrote:
> On Thu, 15 Feb 2024 21:17:23 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

[...]

> > > Now what's the plan ?
> > > Andy, do you want to send a v2 of this patch or may I get the patch, modify it
> > > according to reviews already present in v1 and integrate it in my current
> > > series ?  
> > 
> > I would like to do that, but under pile of different things.
> > I would try my best but if you have enough time and motivation feel free
> > to take over, address the comments and integrate in your series.
> > 
> > I dunno what to do with bitmap_onto(), perhaps in a separate patch we can
> > replace it with bitmap_scatter() (IIUC) with explanation that the former
> > 1) uses atomic ops while being non-atomic as a whole, and b) having quite
> > hard to get documentation. At least that's how I see it, I mean that I would
> > like to leave bitmap_onto() alone and address it separately.
> 
> I will take the Andy's bitmap_{scatter,gather}() patch in my next iteration.
> And use bitmap_{scatter,gather}() in my code.

Thank you and sorry that I have no time to finish that. I will be happy to help
reviewing if you Cc me.

> For bitmap_onto() replacement, nothing will be done in my next iteration as
> it is out of this series scope.

I agree on this. This will be a separate logical change related to NUMA with
explanation and replacement of all callers at once.

-- 
With Best Regards,
Andy Shevchenko



