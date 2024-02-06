Return-Path: <linux-kernel+bounces-55659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD9084BF9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411821C22172
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBA91BC26;
	Tue,  6 Feb 2024 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5y2FL9P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D061B948
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256546; cv=none; b=WiUxQYbWKVPgDZnkWUBipGGQ1rhov+64OFp7t/RggP7dZoi7ErTQrcibc/qAqNmAwFSp8538CPMebHGVDlwiTTYB9GOD/Yz5EDju3CfJJJt2PbTaHbf7l+VgDF/31IUNeglJbgArZkPcMFA7ODnbDkMGsLb3V9FoZRgbF7nsxh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256546; c=relaxed/simple;
	bh=ScFWhTYt+HvHgJN5dBTn7rmIWKDNAZP3JLX6ELdw0t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrwQK71Lpif9Q8rrh2MZ+Nx73e1fbAoRSSYJjwMn76bAM8tUX3njhi4j+dJ6F+Hj//v7FFSSFyxBxfFgslVn6Acy5cy9V0vYUhOpFOYxqyoctvwjj8okBvuB9Cz0ZZJArr4M1AeWDxsbepQgoXSuvWtx7DfsTFVL1Veo5UU5O1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5y2FL9P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707256545; x=1738792545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ScFWhTYt+HvHgJN5dBTn7rmIWKDNAZP3JLX6ELdw0t8=;
  b=L5y2FL9PGEHw1w8HSlK0GtK+7x9mR6hbzKsBfptlyYUQyHwu58U5cVkt
   h16H2JvOEwxUPEKUs4kv1yMuF/t95umiZzi9Y1m+iTRwY7JBgUmjCF9i2
   Sl4t6Rzoiv1B8eV5bdIuZ0fHJkYeIcc9XDHxji8L58r/q08IoD69fk8P0
   sy8jzq0d3XajzOJS8FiNo0oOxlTwbSsRQwuK0fvKw4QUpVHLkckNk31LV
   flJ0ChO0A0xHBBBstzMDh0MAlUKgjZNUSZ8mPx4XdCX1cEoe/u9zhzMJH
   9NDHE//HjPuLMsJ7SU4Hdmqv32yLZNfCsQuJZd6izi+8WYHw2YseiNs9r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="26297014"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="26297014"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1368577"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:55:44 -0800
Date: Tue, 6 Feb 2024 13:57:02 -0800
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
Message-ID: <20240206215702.GB19695@ranerica-svr.sc.intel.com>
References: <20240201115447.522627-1-alexs@kernel.org>
 <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240206024633.GD17602@ranerica-svr.sc.intel.com>
 <xhsmheddphgx5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmheddphgx5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Feb 06, 2024 at 02:16:06PM +0100, Valentin Schneider wrote:
> On 05/02/24 18:46, Ricardo Neri wrote:
> > On Fri, Feb 02, 2024 at 03:27:32PM +0100, Valentin Schneider wrote:
> >>
> >> Subject nit: the prefix should be sched/topology
> >>
> >> On 01/02/24 19:54, alexs@kernel.org wrote:
> >> > From: Alex Shi <alexs@kernel.org>
> >> >
> >> > The description of SD_CLUSTER is missing. Add it.
> >> >
> >> > Signed-off-by: Alex Shi <alexs@kernel.org>
> >> > To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> >> > To: Valentin Schneider <vschneid@redhat.com>
> >> > To: Vincent Guittot <vincent.guittot@linaro.org>
> >> > To: Juri Lelli <juri.lelli@redhat.com>
> >> > To: Peter Zijlstra <peterz@infradead.org>
> >> > To: Ingo Molnar <mingo@redhat.com>
> >> > ---
> >> >  kernel/sched/topology.c | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >> > index 10d1391e7416..8b45f16a1890 100644
> >> > --- a/kernel/sched/topology.c
> >> > +++ b/kernel/sched/topology.c
> >> > @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
> >> >   * function:
> >> >   *
> >> >   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
> >> > + *   SD_CLUSTER             - describes CPU Cluster topologies
> >>
> >> So I know this is the naming we've gone for the "Cluster" naming, but this
> >> comment isn't really explaining anything.
> >>
> >> include/linux/sched/sd_flags.h has a bit more info already:
> >>  * Domain members share CPU cluster (LLC tags or L2 cache)
> >
> > I also thought of this, but I didn't want to suggest to repeat in topolog.c
> > what is described in sd_flags.h.
> >
> > Maybe it is better to remove the descriptions of all flags here and instead
> > direct the reader to sd_flags.h?
> >
> 
> Yeah I agree on less duplication.
> 
> >>
> >> I had to go through a bit of git history to remember what the CLUSTER thing
> >> was about, how about this:
> >>
> >> * SD_CLUSTER             - describes shared shared caches, cache tags or busses
> >
> > AFAIK, this describes a subset of CPUs in the package that share a
> > resource, likely L2 cache.
> >
> >> * SD_SHARE_PKG_RESOURCES - describes shared LLC cache
> >>
> >> And looking at this it would make sense to:
> >>   rename SD_CLUSTER into SD_SHARE_PKG_RESOURCES
> >
> > but not all CPUs in the package share the resource
> 
> But SD_CLUSTER never expands beyond the package, right?

Correct.

> 
> Regardless, my main point is that having both SD_CLUSTER and
> SD_SHARE_PKG_RESOURCES is a source of confusion (at the very least for
> myself),

Agreed!

> and given SD_SHARE_PKG_RESOURCES is really used to mean "shares
> LLC" (see update_top_cache_domain()), we could make that flag more explicit
> and lift some ambiguity with SD_CLUSTER.

As Yicong stated, cluster topology should mean CPUs beyond SMT that share
some resource but not LLC.

It makes sense to me to keep SD_CLUSTER name as it is today and rename
SD_SHARE_PKG_RESOURCES as SD_SHARE_LLC.

