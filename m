Return-Path: <linux-kernel+bounces-66350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A05E855B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8F21F2E5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E5D529;
	Thu, 15 Feb 2024 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsNmcnOM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C8D518;
	Thu, 15 Feb 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980929; cv=none; b=b7ba7sVirKKrew8vlXc2O8Q8rw4zddk+3B3Id7fNsAdAE2ku6Yyd/PxfXFmUY0B2PLbfnljCTo/ZT/jkmsQYh3S9clgClZ96vAt72uiysSzoBywwxRmPgvNIkckOxepQGY/XxamnHv6+acVpYeybp96RBg2m9eBsm/h3hjVjsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980929; c=relaxed/simple;
	bh=IrFzdD8XFZTzKPegTy0YzhPFfPW8Y+EoXkVTZvyKbFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgwVt6uMvd3foACXrVn3cQTeIiGZvYT/Y4N6TUIIidR+NtBHgUEow0WzyA5HbjpzGl5gPK9nWP/7IGUR5hzLRV9bKeHubbFnUAtz0tBWBDBa7Evqv7q5mhguo1ayFCoZ86kodF8W1kTQe+bCphN/158JP5fpYrmsojLTVbQ8p1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsNmcnOM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707980927; x=1739516927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IrFzdD8XFZTzKPegTy0YzhPFfPW8Y+EoXkVTZvyKbFc=;
  b=CsNmcnOMpza4rHMJPFHhtEAnraBVF8s0x69Cxm7EQKzaGalWL9fZlZ3g
   v+ys77FbOLF3asr/9PO+BxN1E/oWx80KAk+k8wjXCZw97pCFJgZYqMsnC
   VBx/Cm2hSxjP+s69Uoe6wbpDx+TOw6i6QJd+WUu6P+p0fgUxgxWQmtvHa
   wiExDh4PAJNrxY+x0ckTL97NOeM7JMr/QMDqksl/Zi2isC1TDj31X4qD9
   IwwCxB9BxSkU+7sdg12WifwKVOcwpzCD9XW/BWR8YSXmgOEby5PF7wMGy
   ijVQNoepxp5qqA0Ks68mSbMkOjoR8Btk4u30pWpGKCVVHEAUsFrBWFdrI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1910963"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1910963"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 23:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3426313"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 23:08:46 -0800
Date: Wed, 14 Feb 2024 23:08:40 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ben Gainey <Ben.Gainey@arm.com>
Cc: "irogers@google.com" <irogers@google.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [RFC PATCH 0/2] A mechanism for efficient support for
 per-function metrics
Message-ID: <Zc24eLqZycmIg3d2@tassilo>
References: <20240123113420.1928154-1-ben.gainey@arm.com>
 <87r0hfwet0.fsf@linux.intel.com>
 <7de25cbdc9df21e1723d209ca8bd377a55bb54e4.camel@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de25cbdc9df21e1723d209ca8bd377a55bb54e4.camel@arm.com>

On Wed, Feb 14, 2024 at 07:13:50PM +0000, Ben Gainey wrote:
> 
> Nice, I wasn't aware of this feature. I'll have a play...

You have to use an old perf version for now, still need to fix it.
> 
> 
> > 
> > Of course the feature is somewhat dubious in that it will have a very
> > strong systematic bias against short functions and even long
> > functions
> > in some alternating execution patterns. I assume you did some
> > experiments to characterize this. It would be important
> > to emphasize this in any documentation.
> 
> The way I have been thinking about this is that for each sample you
> always maintain a periodic sample count so that the relative ranking of
> functions is maintained, and that the "same as previous" check is a way
> to enhance the attributability of the PMU data for any given sample. 
> 
> But it absolutely correct to say that this will bias the availability
> of PMU data in the way you have describe. The bias depends on sample
> window size, workload characteristics and so on.

I would be more comfortable with it if you added some randomization
on the window sizes. That would limit bias and worst case sampling
error.

> It should be possible to provide a per metric "valid sample" count that
> can be used to judge the  "quality" of the metrics for each symbol,
> which may allow the user to make some adjustments to the recording
> paramters (modify sample period, or sample window size for example).

Even that would be misleading because it assumes that the IP stayed
in the same function between the two samples. But you could have
something like

F1  sample
F2
F1  sample

and if you're unlucky this could happen systematically. The
randomization would fight it somewhat, but even there you might
be very very unlucky.

The only sure way to judge it really is to run branch trace in parallel and see
if it is correct.

Also there is of course the problem that on a modern core the
reordering window might well be larger than your sample window, so any notion
of things happening inside a short window is quite fuzzy.

> > 
> > I don't see anything ARM specific with the technique, so if it's done
> > it should be done generically IMHO
> 
> 
> Great. When i was originally thinking about the implementation of the
> event strobing feature I was thinking:
> 
>  * Add `strobe_sample` flag bit to opt into the fature
>    - This will be mutually exclusive with `freq`.
>  * Add `strobe_period` field to hold the alternate sample period (for
> the sample window.
>  * Have all PMU drivers check and reject the `strobe_sample` flag by
> default; the swizzling of the period will be done in the PMU driver its
> self if it make sense to support this feature for a given PMU.
>    - Do you think this is sensible, or would be better handled in core?

I would have a common function in core that is called from the PMU
drivers, similar to how the adaptive period is done today.

> > > the patch) suggests this approach would work for some counters.
> > > Calculating branch miss rates for example appears to be correct,
> > > likewise UOPS_EXECUTED.THREAD seems to give something like a
> > > sensible
> > > cycles-per-uop value. On the other hand the fixed function
> > > instructions
> > > counter does not appear to sample correctly (it seems to report
> > > either
> > > very small or very large numbers). No idea whats going on there, so
> > > any
> > > insight welcome...
> > 
> > If you use precise samples with 3p there is a restriction on the
> > periods
> > that is enforced by the kernel. Non precise or single/double p should
> > support arbitrary, except that any p is always period + 1.
> 
> Is there some default value for precise? when testing I didn't set any
> specific value for p modifier.

In some cases the perf tool tries to use the highest, e.g. if you don't
specify anything.

If you used :p (and not :P) it should have taken the number you
specified. Single :p is normally not useful because it samples
the -1 IP, normal use is either two or three p. Three p is more
precise but also has some restrictions on the sampling period
and the counters that can be used.

-Andi

