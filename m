Return-Path: <linux-kernel+bounces-48533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C16D845D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA211F20F59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A9F4A2A;
	Thu,  1 Feb 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1qQqYnv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77BC3FFE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805132; cv=none; b=Ne06ZbVXAiRfPyz+WBp2z8fz2K0yIvyJrp3rbKDgXYzxc5cVkwwjN3hwsFTWK6brrj3tX7tiYWP6S/UVseizUkR+mRTv7bXXbMssZWWngZ9+vSnPNtsfKqXjxW07kXdaOaVJAAJssJhTxj/Q/wAl3bSbBlN9aK0AL3w/bwasZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805132; c=relaxed/simple;
	bh=/dEbfKdsCxc6i2ZleAJoeyfJW9N+L7lE8dX/mKZ0Tvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGUxj3uCu1Wfp/5vB9sOhDBwQtrN8ximGK8fMa7GBS7NfIodm4kBWSgAoFtOJaP+lctY6GvTn29Osqvuw3LjDNil286Hjvb2HoGQtcKjr6bxJENtiZ/iLIVT7cIBI4HTA85vI7IQNyJIrSYHWbyddZSIua3jirHIfV2C/8JxbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1qQqYnv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706805131; x=1738341131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/dEbfKdsCxc6i2ZleAJoeyfJW9N+L7lE8dX/mKZ0Tvs=;
  b=j1qQqYnvSNst6l8GdXQQiAjXJwDo2KeAugXMTeNkavLnnZaU41lwKS3L
   TQiQkjZX5Ln7dgp5gqFTDsaBeR1gJPepdHLMb+55w/16sowwpxtm4yCe3
   aDhSNH33tUtkgHsZHNDEgXv0SuPuIyChB7NMfp7/kWPEXDYq5mKOpZ1Zs
   UgQJpHBhHK6zqmzirZshLRTGBjg+MSVyar4iq45UjjT2UpmnvXMwvPfs4
   s7kD3uvY9gmCo4XkeBSjok4k/t00hFfn7O7Rh4OsYvZqK/W8+EbX14A4m
   3JDrYfKqDYJSyYVZ4Ka5y/yNdjDDTkvP1rewqmdIEpDN6WIOd+h14Ynf2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11307691"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="11307691"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:32:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="109475"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:32:09 -0800
Date: Thu, 1 Feb 2024 08:33:30 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: kuiliang Shi <seakeel@gmail.com>, alexs@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6 RFT] sched/fair: change sched asym checking
 condition
Message-ID: <20240201163330.GB20261@ranerica-svr.sc.intel.com>
References: <20240130131708.429425-1-alexs@kernel.org>
 <20240130131708.429425-6-alexs@kernel.org>
 <20240201011038.GD18560@ranerica-svr.sc.intel.com>
 <4a6d2404-46ab-41ca-856e-e4cbfebba185@gmail.com>
 <0c9e077c-c59a-40c7-878f-7f429e12ba24@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9e077c-c59a-40c7-878f-7f429e12ba24@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Feb 01, 2024 at 08:49:05PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 2/1/24 5:10 PM, kuiliang Shi wrote:
> > 
> > 
> > On 2/1/24 9:10 AM, Ricardo Neri wrote:
> >> On Tue, Jan 30, 2024 at 09:17:08PM +0800, alexs@kernel.org wrote:
> >>> From: Alex Shi <alexs@kernel.org>
> >>>
> >>> Asym only used on SMT sd, or core sd with ITMT and core idled.
> >>> !sched_smt_active isn't necessary.
> >>
> >> sched_smt_active() is implemented as a static key. Thus, if SMT is not
> >> enabled, we can quickly return without having to check the rest of the
> >> conditions, as we should.
> > 
> > Hi Ricardo,
> > 
> > Thanks a lot for comments! I will drop this patch in this series.
> > 
> > But forgive my stupidity, asym feature is possible when SMT enabled instead of SMT disable. Why no SMT is a condition for asm feature? For this asym feature, I only see the SMT and MC domain use this, correct me if I'm wrong. 
> > 
> 
> on power7 ASYM_PACKING is used to pack at SMT level. 

Indeed, this is why the function returns true if it the sched domain has
the SD_SHARE_CPUCAPACITY flag.

When SMT is disabled there is no point in doing any check because we will
always want to use asym_packing.

> 
> On x86, ITMT topology uses ASYM_PACKING to do load balancing instead of using different cpu capacities.

You can look at x86_cluster_flags() and x86_die_flags().

> 
> Its possible to have it in PKG(earlier referred as DIE) as well. 
> In powerpc recently we did that for shared processor LPAR's. So asym feature is in PKG as well. 
> 
> >>
> >>>

