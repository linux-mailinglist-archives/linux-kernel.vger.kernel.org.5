Return-Path: <linux-kernel+bounces-79052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E590D861CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BB9284E34
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929C14532F;
	Fri, 23 Feb 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaRZqTVz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BA1448F7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717632; cv=none; b=j04uGeM5LedO6e24/T6Z2D47cRLI8ag/AOIOvkbpd+uOeLNaoQMCpZCAV4vgvG/q1NGthBciXkah0T4SdkfN6BZwfJbABM2Kz1PTRWz8Yy7YuZ6JXzZYeZcJADiFaE35Rx9dZqfDQMkNL17ROFf7bsyyFNqhyyx/7ZSa4iHthfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717632; c=relaxed/simple;
	bh=kf80ZIhdWuP7JmmJe7/UQzljMBCt1MvPt/L3S2dEwmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riUHaF/w9FPN6ykbRUr27cbpfBcsDhoJe9brfSIJCIajh+b8uniLWh3nrjwCVJyPJzPAredOJYq2feHYWqGqe5/COYaP32pNSFUp0xAFZL8Fd10VzRfwSwoccYGB4tpLALazpMFykz8LSHPDPVm+wX/6S87xYmTc9CA4nmCIrRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaRZqTVz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708717630; x=1740253630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kf80ZIhdWuP7JmmJe7/UQzljMBCt1MvPt/L3S2dEwmc=;
  b=LaRZqTVzyswIMMYboaPxSouOg3zSDVGRKbwvbTCxgiD/7RajJUvS6Fs4
   GmvZMjJ6pPgFyNhqj9HgK7Sn3bReCUunfK2UoI8lxQdQ8yW1bwtpftGrV
   6985/BL44tTtyZ1clGs1Php8rM7gJD2tb7Vmj7V5ok6/qGy1pgiI0+zAQ
   xryiOTjZGaDJEEQin9lLlC8dxcydhsp6YW6yKrfjPYBIZXDytTNuSK38T
   vFj6Zu4Tbp9pquzUjd0yFW5VY3/GIx3E5epiKy+vBD9VLh9t2vsHEiwtv
   9NJMJwUW0UJ/E8JJj21hbRkfVq5Exg0x8C6gOwvq03EqTGzh1+bZ5ZTmr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="13695661"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="13695661"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:47:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="827767843"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="827767843"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 23 Feb 2024 11:47:04 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 23 Feb 2024 21:47:04 +0200
Date: Fri, 23 Feb 2024 21:47:04 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/i915: Indicate which pipe failed the fastset
 check overall
Message-ID: <Zdj2ONs8BZ6959Xb@intel.com>
References: <20240215164055.30585-1-ville.syrjala@linux.intel.com>
 <20240215164055.30585-2-ville.syrjala@linux.intel.com>
 <ZdfApN1h97GTfL1t@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdfApN1h97GTfL1t@intel.com>
X-Patchwork-Hint: comment

On Thu, Feb 22, 2024 at 04:46:12PM -0500, Rodrigo Vivi wrote:
> On Thu, Feb 15, 2024 at 06:40:44PM +0200, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > intel_crtc_check_fastset() is done per-pipe, so it would be nice
> > to know which pipe it was that failed its checkup.
> > 
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_display.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> > index 00ac65a14029..a7f487f5c2b2 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -5562,14 +5562,16 @@ static int intel_modeset_checks(struct intel_atomic_state *state)
> >  static void intel_crtc_check_fastset(const struct intel_crtc_state *old_crtc_state,
> >  				     struct intel_crtc_state *new_crtc_state)
> >  {
> > -	struct drm_i915_private *i915 = to_i915(old_crtc_state->uapi.crtc->dev);
> > +	struct intel_crtc *crtc = to_intel_crtc(new_crtc_state->uapi.crtc);
> > +	struct drm_i915_private *i915 = to_i915(crtc->base.dev);
> >  
> >  	/* only allow LRR when the timings stay within the VRR range */
> >  	if (old_crtc_state->vrr.in_range != new_crtc_state->vrr.in_range)
> >  		new_crtc_state->update_lrr = false;
> >  
> >  	if (!intel_pipe_config_compare(old_crtc_state, new_crtc_state, true))
> > -		drm_dbg_kms(&i915->drm, "fastset requirement not met, forcing full modeset\n");
> > +		drm_dbg_kms(&i915->drm, "[CRTC:%d:%s] fastset requirement not met, forcing full modeset\n",
> > +			    crtc->base.base.id, crtc->base.name);
> 
> looking to other patches in this same series, I wonder
> if we shouldn't benefit of a crct_dbg(crtc, "message") that would print
> [CRTC:%d:%s] underneath.

There has been some discussion on this topic recently, but
I don't think that particular approach is good because:
a) it only works when you need to talk about one partiuclar
   object and often we need to talk about more than one
b) different debug function for every little thing is just ugly,
   and we'd probably end up with dozens of differently named
   variants which takes up too many slots in my brain's pattern
   matcher

I think Jani proposed that drm_dbg_kms() could take different kinds
of objects as its first parameter to do this, but I don't like that
either because of point a).

One idea that was floating about was that each object would embed
a .debug_string or somesuch thing which would include the preferred
formatting. With that you could prints with just a simple %s. The
downside is that when you then read the format string you have no
idea what kind of thing each %s refers to unless you also parse
the full argument list to figure out which is which.

And one basic idea I was mulling over at some point was simply
to define DRM_CRTC_FMT/ARGS/etc. macros and use those. But that
makes the format string super ugly and hard to read.


I think the proper solution would be to have actually
sensible conversion specifiers in the format string.
So instead of %<set of random characters> we'd have something
more like %{drm_crtc} (or whatever color you want to throw
on that particular bikeshed).

Adding vsprintf.c folks to cc in case they have some ideas...

-- 
Ville Syrjälä
Intel

