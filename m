Return-Path: <linux-kernel+bounces-54212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36484AC4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128891C22E80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A206DCED;
	Tue,  6 Feb 2024 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtVbZ43P"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B105647B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187517; cv=none; b=nbKBKZsWs4kvLFfYGbF2cYHFfQPqTElKSkRDZIemi0/NK7fnCZ3DewKpFzu+99V8O2IGqve0PYOPjk7QYUqPRE+b+T5lGBwRURmrvcwKR5tlWd/AscsAAluRyUeo2eCFn9AH4lcP4UXkN4faMpLBntv0XpjoAXTDu6GBVRouiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187517; c=relaxed/simple;
	bh=8vqFn8D6gm1jxmqcWZnPon0cRMSRqMW/kMiyBAJWUBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPW7rhl/JmNyAnMV1doGk6pVVqppZF+OUOuBkDJQSr1tKnpGLwn39j9+I9/yc9exDqdQVt1nSqr/ZE92u4ocrNuEEMPBgginVtGaIq98ZwVAGkjABHDWNkur1zEWZj+vZUjLgPPPtflD0J++DzcBVe8zlFLAWnnpk2ES0DrsWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtVbZ43P; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707187516; x=1738723516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8vqFn8D6gm1jxmqcWZnPon0cRMSRqMW/kMiyBAJWUBI=;
  b=MtVbZ43P429MOd2CwasFf886dgY9NUqrX9lkBAy4cnDvsERORRUs0/VR
   TazS5jCHkwMsxrj8VACXC7RKcOihRlaSHV1kEEigddm0WwdS3W1NOtYVU
   sh2lkgDnSe20qk3K46i41KWC7hNR3OZRFTAfSLlmtTHf1LEEMD5zdlr0i
   5Kyiz8cAdVdrGbG42LWZtesrmN4gdnI7pKNOvmLYJBl+5LClyjmMXB7lr
   uGyYAxUggIHBxuD3TX7jbpM0fAtTm3zJXscbgziHLRXP6lcdNA+bqBc0G
   gmRHKJdXJuKekCicPtaDS43jVgaBdAlVLksgWLXHdOETf8EFlbPFxSVMq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="435787158"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="435787158"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:45:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38314634"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:45:15 -0800
Date: Mon, 5 Feb 2024 18:46:33 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	linux-kernel@vger.kernel.org, sshegde@linux.ibm.com
Subject: Re: [PATCH v3 1/4] sched/fair: add SD_CLUSTER in comments
Message-ID: <20240206024633.GD17602@ranerica-svr.sc.intel.com>
References: <20240201115447.522627-1-alexs@kernel.org>
 <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Feb 02, 2024 at 03:27:32PM +0100, Valentin Schneider wrote:
> 
> Subject nit: the prefix should be sched/topology
> 
> On 01/02/24 19:54, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> >
> > The description of SD_CLUSTER is missing. Add it.
> >
> > Signed-off-by: Alex Shi <alexs@kernel.org>
> > To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > To: Valentin Schneider <vschneid@redhat.com>
> > To: Vincent Guittot <vincent.guittot@linaro.org>
> > To: Juri Lelli <juri.lelli@redhat.com>
> > To: Peter Zijlstra <peterz@infradead.org>
> > To: Ingo Molnar <mingo@redhat.com>
> > ---
> >  kernel/sched/topology.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 10d1391e7416..8b45f16a1890 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
> >   * function:
> >   *
> >   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
> > + *   SD_CLUSTER             - describes CPU Cluster topologies
> 
> So I know this is the naming we've gone for the "Cluster" naming, but this
> comment isn't really explaining anything.
> 
> include/linux/sched/sd_flags.h has a bit more info already:
>  * Domain members share CPU cluster (LLC tags or L2 cache)

I also thought of this, but I didn't want to suggest to repeat in topolog.c
what is described in sd_flags.h.

Maybe it is better to remove the descriptions of all flags here and instead
direct the reader to sd_flags.h?

> 
> I had to go through a bit of git history to remember what the CLUSTER thing
> was about, how about this:
> 
> * SD_CLUSTER             - describes shared shared caches, cache tags or busses

AFAIK, this describes a subset of CPUs in the package that share a
resource, likely L2 cache.

> * SD_SHARE_PKG_RESOURCES - describes shared LLC cache
> 
> And looking at this it would make sense to:
>   rename SD_CLUSTER into SD_SHARE_PKG_RESOURCES

but not all CPUs in the package share the resource

>   rename SD_SHARE_PKG_RESOURCES into SD_SHARE_LLC
> but that's another topic...
> 

