Return-Path: <linux-kernel+bounces-90486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324C086FFFC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B321C2330C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D538F8F;
	Mon,  4 Mar 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9CripOA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680F46AD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550685; cv=none; b=AeECL+voHbTeq7SNG1QfI8qn5PlJ5de6BKOKdNXqIfwDLZX4bcJD4DB9TVGsbC5EmjkRTM9droxoIj44YD95NDYFQuc6QF9/C0G9OAZwfA5OhUaxMs7kyMwH23/7fKl53updO98m9Txc6MJgsQce7/lyCnVbt3Xae5So66yTTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550685; c=relaxed/simple;
	bh=0T0lhm8LzcAdzbLDuBp+ZTGZjesoCjhi5zU7O8aSCKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crIfbw9jak9Ki4YieEwmKU86MtDlD0DmrttFpY+wjFNbvRIYsxnik9/FM5+dIviwX0SnSbFe6eLRhTGyeAVWopopY2vHybu86W9tAEJIvF2kgUxAWsGzbep60oxCbvrK3rsGl3ky0TTC+zjHATxZWZGcAxxtH6lXksJSgJtudqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9CripOA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709550684; x=1741086684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0T0lhm8LzcAdzbLDuBp+ZTGZjesoCjhi5zU7O8aSCKI=;
  b=f9CripOA53/9SXNGSz+zq2JlTMz1QpfLG06Rp8dFiiv6jRJJC3zGadXv
   URNX0JDSLzzLF4LrHSbcuVRwVHrSPJ7/SP/6wkmRw4odyWRzODjmthBZB
   er9wzOk5XBC8mIZFTyCFM83crmdnA9Ndfw5hijyTEFQlaeX5iPRvu0O2G
   UMhW6hh5f3kHo6RFGmZRTpLi2eQe3iWu3yGMkUj0fngd/K7sQXQimppR/
   A1v6DCvMTrOw8Yzhvu6kGXRnE7Y12n5bwgIO+xZ6Q11njjRPnLjVrfbuW
   Q896JnC3KpaUZDtusRcL3O6D5nJughBec5rh9OuJVqO+PFv8gQViBGWkI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4160900"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4160900"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:11:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="827773138"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="827773138"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 04 Mar 2024 03:11:18 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 04 Mar 2024 13:11:17 +0200
Date: Mon, 4 Mar 2024 13:11:17 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Manasi Navare <manasi.d.navare@intel.com>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/i915: Remove unneeded double drm_rect_visible call
 in check_overlay_dst
Message-ID: <ZeWsVXhj1AUD4q3G@intel.com>
References: <>
 <79c92cfa-cf5a-4a23-8a93-11c1af7432fc@ancud.ru>
 <ZeB45WKv4lP8QQpv@intel.com>
 <ecfb0f31-a454-4a51-9fb8-9cd0aca3195c@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecfb0f31-a454-4a51-9fb8-9cd0aca3195c@ancud.ru>
X-Patchwork-Hint: comment

On Fri, Mar 01, 2024 at 09:56:41PM +0300, Nikita Kiryushin wrote:
> On 2/29/24 15:30, Ville Syrjälä wrote:
> > I prefer the current way where we have no side effects in
> > the if statement.
> >
> 
> This seem like a valid concern from readability and maintainability 
> standpoint. My patch was aimed mostly at performance and maintainability 
> using tools: some more pedantic analyzers are sensitive to non-checked 
> return values (as of now, drm_rect_intersect is ignored).
> 
> Would it be a better idea to make an update to the patch with second 
> drm_rect_visible call changed to an appropriately named state flag set 
> with drm_rect_intersect result?

I was thinking of maybe removing that drm_rect_visible() from
drm_rect_intersect() entirely, but looks like it's used fairly
extensively, so would require a bunch of work.

But now that I though about this I recalled that there was an earlier
patch trying to do exactly what you suggested in this patch. And looks
like there was a second version posted which I completely missed:
https://patchwork.freedesktop.org/series/115605/

While that does still have drm_rect_intersect() with its side effects
inside the if() I don't find it quite as objectionable since it's the
only thing in there. So it's a bit more obvious what is happening.
I've gone and merged that one.

Thanks for the patch regardless. At least I reminded me to look at the
earlier attempt ;)

> 
> BTW, the original patch somehow got mangled while it made its way to the 
> patchwork: source list line in patch got broken, which permits the patch 
> from being applied (the original version did not have that line break). 
> Any ideas how to prevent this happening with the second version of patch 
> (in case the idea is viable)?

-- 
Ville Syrjälä
Intel

