Return-Path: <linux-kernel+bounces-138674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE7F89F8E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515A01C2275F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8515F3ED;
	Wed, 10 Apr 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqHAAXon"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF01854
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756834; cv=none; b=ia2ApgrEb8fUNS4D3d/6frqwFbykuHb8Rto4yCdGBBDeywZr/frSloT7ksvIcONL6jEV3/l0vIYDuhT59gUHR0XvRI+zuSkcy2of7jbvTKRMtKQ13OBxOlpZv50vaBn6Vo4YhyNK6D1rip+bGJT0LX1mTy6rA4XTFAkU6u/NCZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756834; c=relaxed/simple;
	bh=MYZA0qDXcZni1G28gmsIVy0hqO6YvW9POyiKmiOgpXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm2sH/XCQ1mzpugcLbw2q5dJBLx4Uj78zgVIezNJeY49oNvrXUB+6wQ35wLfdt5JUuFMeIy54oxfI9n3gtQOdxygN5eA6PcQa1K8gainRtPpGnJM3x86bkEtBpXzn372gBzXVJjwm6HvwP0m2QFRdW3u9OmZ54K32Rcc6UdPdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqHAAXon; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712756833; x=1744292833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MYZA0qDXcZni1G28gmsIVy0hqO6YvW9POyiKmiOgpXI=;
  b=ZqHAAXon2CXkDl6/1QjhJ016tYqn2Ck/wx2i02Ak4Rnzw5pGyhOA0NLe
   bg/VcNlHcXmz4goyWCeJs0vIjNKpnnysA7Aik4NiewG8vYYYn7TCnpYqM
   8XfOT2SrpXL6w8Ua5Zu6jGDKQlA/nm6AayTeuOwr1MJlZnDJmyE7yrFGZ
   NP4J4taFnAH/MtID1duxqQcCLj2EQzMWQS2SwO9LK5aHclEA70KH5UO1+
   BDe+CLStqYKYCEKsYm6tGzc334fUh+X8DvPP5R7zJ3WB87qdKd4n0lqyP
   LVpOn+tOUaQIEeHV+4ZPjmqfvvuXuktmj6GLvbrhhO2gekeQGhnozRvSk
   w==;
X-CSE-ConnectionGUID: aFFAyVmkRnugmwNSOAYDCg==
X-CSE-MsgGUID: mWsdMTscS2menzMuBG244g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7992166"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7992166"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:47:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915433492"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="915433492"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:47:08 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruYI4-0000000355d-47BL;
	Wed, 10 Apr 2024 16:47:04 +0300
Date: Wed, 10 Apr 2024 16:47:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH 2/2 RESEND] sched/topology: Optimize topology_span_sane()
Message-ID: <ZhaYWOIec55l7Tsg@smile.fi.intel.com>
References: <20240409155250.3660517-1-kyle.meyer@hpe.com>
 <20240409155250.3660517-3-kyle.meyer@hpe.com>
 <ZhVr4i5F1uWyrJ15@smile.fi.intel.com>
 <ZhWXBSMDPKThcLsY@DESKTOP-IR8JFSN.>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhWXBSMDPKThcLsY@DESKTOP-IR8JFSN.>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 02:29:09PM -0500, Kyle Meyer wrote:
> On Tue, Apr 09, 2024 at 07:25:06PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 09, 2024 at 10:52:50AM -0500, Kyle Meyer wrote:
> > > Optimize topology_span_sane() by removing duplicate comparisons.
> > > 
> > > The total number of comparisons is reduced from N * (N - 1) to
> > > N * (N - 1) / 2 (per non-NUMA scheduling domain level).

..

> > > -	for_each_cpu(i, cpu_map) {
> > > -		if (i == cpu)
> > > -			continue;
> > > +	for_each_cpu_from(i, cpu_map) {
> > 
> > Hmm... I'm not familiar with the for_each_cpu*(), but from the above
> > it seems only a single comparison? Or i.o.w. can i ever repeat the value?
> 
> for_each_cpu() is a macro around for_each_set_bit() which iterates over each set
> bit in a bitmap starting at zero.
> 
> for_each_cpu_from() is a macro around for_each_set_bit_from() which iterates
> over each set bit in a bitmap starting at the specified bit.
> 
> The above (topology_span_sane()) currently does a "single comparison" for each
> CPU in cpu_map, but it's called for each CPU in cpu_map and for each scheduling
> domain level (please see build_sched_domains() in kernel/sched/topology.c).
> 
> > And what about i < cpu cases?
> 
> Those values have already been passed to topology_span_sane(). This patch uses
> for_each_cpu_from() starting at cpu + 1 to prevent those duplicate comparisons.

So, it appears to me that commit message has a room to improve / elaborate based
on what you explained to me above.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



