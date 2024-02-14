Return-Path: <linux-kernel+bounces-65012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D58546AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52DEB21782
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A96168AF;
	Wed, 14 Feb 2024 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeyZ8QX4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FCB17585;
	Wed, 14 Feb 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904526; cv=none; b=Q8vebhGwI5ILYpPplusv1QZ5gl3G43TD6XVdvqR2s5QjD3NZGjAbj5QjsO4gkaCz2ONBOwU9dn+2cX0M2D/oqvl9wTwslA5ScfyXLV3AVaOiRZhEu8d6xAwObZozspj9IYbI23+M0qefdbr36OneKnuCKKACAAlJsG53RqCI/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904526; c=relaxed/simple;
	bh=A/g1r9lBVBXaq+NvYx4KgeDD3Du8cdjmgJE9bAtv2zA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dw8pFhDSgXsWx0i+9tA8q4g2vssAH+zZJ1HrQwtyQ/zlCT6T/9JnA2eIsjoRn0uupA1uCSKwQugStFiUBdF5vp/XabPdYuSVqU+DE7Q00TDzT72WkrnG/4NejbMVMd7AUkmWyoAPr2pH2jqbXrxWqfed0O56VaEgYJ0moCAoGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeyZ8QX4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707904523; x=1739440523;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=A/g1r9lBVBXaq+NvYx4KgeDD3Du8cdjmgJE9bAtv2zA=;
  b=BeyZ8QX48Xa81mp1jqJAVDqHrJrGysyymE/GyWJgZc+HIko+Wh4L14Zc
   lnJGWhmvcui2gTUK53d/wBwg7Uy/SU51ywm2YNDwkYHnAQaEyNS133Cvu
   CKhb4XjzxgvneXVJt978uZtW9DeAZ2pUxMhs4jD1pt7xWCTxSXTpZaYmQ
   q1ZVP40u0XpBWBZ57+lCqDFUO9kXLi/bYHvMRYazMXcq8i+hovTwPxA3p
   qIbchUsTrFE1Omh6wc0gDd7w96CwoX/AT9Tqqvk9HEDeTJa1HRAiZBVrN
   MrjZ/hSQMMQihTucF+XjDB4bPBcjRj56bvS6b7vUmzU4FrGxV3z2zDmjr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2085167"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2085167"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 01:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3499569"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa006.jf.intel.com with ESMTP; 14 Feb 2024 01:55:24 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id B5A60300B65; Wed, 14 Feb 2024 01:55:23 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Ben Gainey <ben.gainey@arm.com>
Cc: linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  peterz@infradead.org,
  mingo@redhat.com,  acme@kernel.org,  mark.rutland@arm.com,
  alexander.shishkin@linux.intel.com,  jolsa@kernel.org,
  namhyung@kernel.org,  irogers@google.com,  adrian.hunter@intel.com,
  will@kernel.org
Subject: Re: [RFC PATCH 0/2] A mechanism for efficient support for
 per-function metrics
In-Reply-To: <20240123113420.1928154-1-ben.gainey@arm.com> (Ben Gainey's
	message of "Tue, 23 Jan 2024 11:34:18 +0000")
References: <20240123113420.1928154-1-ben.gainey@arm.com>
Date: Wed, 14 Feb 2024 01:55:23 -0800
Message-ID: <87r0hfwet0.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Gainey <ben.gainey@arm.com> writes:

> I've been working on an approach to supporting per-function metrics for
> aarch64 cores, which requires some changes to the arm_pmuv3 driver, and
> I'm wondering if this approach would make sense as a generic feature
> that could be used to enable the same on other architectures?
>
> The basic idea is as follows:
>
>  * Periodically sample one or more counters as needed for the chosen
>    set of metrics.
>  * Record a sample count for each symbol so as to identify hot
>    functions.
>  * Accumulate counter totals for each of the counters in each of the
>    metrics *but* only do this where the previous sample's symbol
>    matches the current sample's symbol.

It sounds very similar to what perf script -F +metric already does
(or did if it wasn't broken currently). It would be a straight forward
extension here to add this "same as previous" check.

Of course the feature is somewhat dubious in that it will have a very
strong systematic bias against short functions and even long functions
in some alternating execution patterns. I assume you did some
experiments to characterize this. It would be important
to emphasize this in any documentation.

> For this to work efficiently, it is useful to provide a means to
> decouple the sample window (time over which events are counted) from
> the sample period (time between interesting samples). This patcheset
> modifies the Arm PMU driver to support alternating between two
> sample_period values, providing a simple and inexpensive way for tools
> to separate out the sample period and the sample window. It is expected
> to be used with the cycle counter event, alternating between a long and
> short period and subsequently discarding the counter data for samples
> with the long period. The combined long and short period gives the
> overall sampling period, and the short sample period gives the sample
> window. The symbol taken from the sample at the end of the long period
> can be used by tools to ensure correct attribution as described
> previously. The cycle counter is recommended as it provides fair
> temporal distribution of samples as would be required for the
> per-symbol sample count mentioned previously, and because the PMU can
> be programmed to overflow after a sufficiently short window; this may
> not be possible with software timer (for example). This patch does not
> restrict to only the cycle counter, it is possible there could be other
> novel uses based on different events.

I don't see anything ARM specific with the technique, so if it's done
it should be done generically IMHO


> Cursory testing on a Xeon(R) W-2145 sampling every 300 cycles (without
> the patch) suggests this approach would work for some counters.
> Calculating branch miss rates for example appears to be correct,
> likewise UOPS_EXECUTED.THREAD seems to give something like a sensible
> cycles-per-uop value. On the other hand the fixed function instructions
> counter does not appear to sample correctly (it seems to report either
> very small or very large numbers). No idea whats going on there, so any
> insight welcome...

If you use precise samples with 3p there is a restriction on the periods
that is enforced by the kernel. Non precise or single/double p should
support arbitrary, except that any p is always period + 1.

One drawback of the technique on x86 is that it won't allow multi record
pebs (collecting samples without interrupts), so the overhead might
be intrinsically higher.

-Andi

