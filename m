Return-Path: <linux-kernel+bounces-39444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF7E83D13F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427791F23162
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D21385;
	Fri, 26 Jan 2024 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTPvybDG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1879CC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227373; cv=none; b=UMiBVRU5vxbWkRfzxFQPoGV5A02YbcQRMn1dhq/lsGpXNE2MJbyhh0hAHLMABwBjwGe1t/Line9MWtFnISJanKIrad0bcAZD9HeVGNDouGLAgtkfM3V6YRndnpaZYW4O+u8APES61EOVbqX0Hv+psVdsoqomxhRj4h2dQpM4bCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227373; c=relaxed/simple;
	bh=9zQY3QXZGybNHL3/YduUhXY2paMLb0maHxRAfxDQqQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVg/6t8DFC7ISoIimV170Ztxr9c3BDsDXTyCQeYV/koqqgC2mIwXqynt8ZTQdbpSYKz+7EWu43H+9ppmBk4KE82yMQbmki5/zocoA2vaGtYXFVr5ZzEbk2Sx6PrTssrR+v7Kng+gNG9WOwhgXMK+MmCmDYJJhtDbt+cd//ZAIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTPvybDG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706227372; x=1737763372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9zQY3QXZGybNHL3/YduUhXY2paMLb0maHxRAfxDQqQQ=;
  b=MTPvybDGxLYV2uATbSUqRgpRFpv5QTSiPjYxCHnrDrWYJtja8Bf0VRsx
   IlFyhWVjF/mP35dR99Dq5xpg6hBWwnY+LGy10O/Dohkmglqh54F+OU6Oc
   hFy0vDlCEmW2CkLBWudsjpECG5YYMoV3ygaEoLYBX3OubYA+ipfRqLfAE
   69gacaClC0a/Ky/IsCYMd0zR8yAE6aTb0Tr1GV3U/y5AW4liJs0hX/qeZ
   JXLnfFyrP5T1zEZUakBeRl28bdKKqOA7YPqhL7bW/S6qx3Pn57x+4kEHg
   +GZ3pJwnY391uU9QX9y0kBag62I8z1tvpnihCQiM5WiWZI9b/ZNPlAFyA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2211474"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2211474"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="820966448"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820966448"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:02:51 -0800
Date: Thu, 25 Jan 2024 16:04:17 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] sched/fair: narrow the sched_use_asym_prio checking
 scenario
Message-ID: <20240126000417.GB17237@ranerica-svr.sc.intel.com>
References: <20240117085715.2614671-1-alexs@kernel.org>
 <20240117085715.2614671-5-alexs@kernel.org>
 <dd4e5498-3e21-4ac1-b65a-fd132c2a7206@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4e5498-3e21-4ac1-b65a-fd132c2a7206@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Jan 23, 2024 at 02:17:00PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 1/17/24 2:27 PM, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> > 
> > Current function doesn't match it's comments, in fact, core_idle
> > checking is only meaningful with non-SMT.

For SMT cores, we _do_ need to check for a whole core to be idle when
deciding to use asym_packing priorities when balancing between cores, but
not in SMT domains. This is what the function's documentation states.

> > So make the function right.
> > 
> > Signed-off-by: Alex Shi <alexs@kernel.org>
> > To: Valentin Schneider <vschneid@redhat.com>
> > To: Vincent Guittot <vincent.guittot@linaro.org>
> > To: Peter Zijlstra <peterz@infradead.org>
> > To: Ingo Molnar <mingo@redhat.com>
> > ---
> >  kernel/sched/fair.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 96163ab69ae0..0a321f639c79 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9741,8 +9741,8 @@ group_type group_classify(unsigned int imbalance_pct,
> >   */
> >  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
> >  {
> > -	return (!sched_smt_active()) ||
> > -		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
> > +	return	(sd->flags & SD_SHARE_CPUCAPACITY) ||
> > +		(!sched_smt_active() && is_core_idle(cpu));
> >  }
> 
> This seems wrong. This would always return false for higher than SMT domains 
> if smt is active. 

Agreed.

> 
> Was this meant to be sched_smt_active() && is_core_idle(cpu)? 

But this would not work if SMT is inactive, in such case checking
for a whole idle core is pointless.


