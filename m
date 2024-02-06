Return-Path: <linux-kernel+bounces-55624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6633084BF28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCBD1F24E28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C801C1B953;
	Tue,  6 Feb 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nREWfIz0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176D1B949
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254583; cv=none; b=kuJ5XV0V4UhFESSEzKFTzwMN8KF7GwYtcTkfrlxL0/geh5uG+suJMoww820FJsoLykAIJBeI2Prib2IAzucjoiB8b0dQQNj2/bbvTNMZRhLNA6NQ27CeBWWZjPzoAakG7xobRxdFJjJUIJVGcT2Lrp1k1HZ/jTR7p3VhHVzPobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254583; c=relaxed/simple;
	bh=mFw5pANaM+E7fTa/QIBb7DTO8TWgq8m2d82tmMq2mYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLCiMceVFt4uMVwWS1QzSqe0I5dDCYpP0Yn/D82Z0Cz0zamMChprAaUOowUINyWf8JtoT9LRK0obEtPycfyJUGTQ/8bZOdYzRxSea1JotSo66Vx9mdKl+95JYUK5vmL19rVjexpaFe29ap7kKN6CDybA7yIGZ+oA5G7vv9BYdAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nREWfIz0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707254581; x=1738790581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mFw5pANaM+E7fTa/QIBb7DTO8TWgq8m2d82tmMq2mYE=;
  b=nREWfIz0FgacRx3NRRxpVSAWU/IfuBzmX/d+dzUZAhYYbveb3xyW+Oti
   PljFxNtXdbouRfN7IXBeNHrQ+KdKOIZySPbhuaoOSjn6MYnPUzyDsODQX
   9HGzdJ5uejR7/1W3aVOGpGEZlnSh3pY8qg3/B5gnhhl/CyYKdYJcO4AmH
   XYzvX+8M1K7xcsrmFcrIVNSfcLbs+kbSha427N4h7t7Lgs41LDQwtViBz
   rXjUVz0iCyDyJ3yR4UtIa0mQdveUdNcVLyNxX/WCRzdn29us/ML55QaUh
   xJj3PXsWyEMEXZEco/GqUPgTiw+F6MT9ZT33sYALuYOeLhPdoMKo9rod+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11432279"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="11432279"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:23:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="909765130"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="909765130"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:22:59 -0800
Date: Tue, 6 Feb 2024 13:24:18 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: kuiliang Shi <seakeel@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>, alexs@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	linux-kernel@vger.kernel.org, sshegde@linux.ibm.com
Subject: Re: [PATCH v3 1/4] sched/fair: add SD_CLUSTER in comments
Message-ID: <20240206212418.GA19695@ranerica-svr.sc.intel.com>
References: <20240201115447.522627-1-alexs@kernel.org>
 <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240206024633.GD17602@ranerica-svr.sc.intel.com>
 <b19487fe-cc9b-412d-8b70-c0be6ad224ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19487fe-cc9b-412d-8b70-c0be6ad224ae@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Feb 06, 2024 at 04:56:02PM +0800, kuiliang Shi wrote:
> 
> 
> On 2/6/24 10:46 AM, Ricardo Neri wrote:
> > On Fri, Feb 02, 2024 at 03:27:32PM +0100, Valentin Schneider wrote:
> >>
> >> Subject nit: the prefix should be sched/topology
> >>
> >> On 01/02/24 19:54, alexs@kernel.org wrote:
> >>> From: Alex Shi <alexs@kernel.org>
> >>>
> >>> The description of SD_CLUSTER is missing. Add it.
> >>>
> >>> Signed-off-by: Alex Shi <alexs@kernel.org>
> >>> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> >>> To: Valentin Schneider <vschneid@redhat.com>
> >>> To: Vincent Guittot <vincent.guittot@linaro.org>
> >>> To: Juri Lelli <juri.lelli@redhat.com>
> >>> To: Peter Zijlstra <peterz@infradead.org>
> >>> To: Ingo Molnar <mingo@redhat.com>
> >>> ---
> >>>  kernel/sched/topology.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >>> index 10d1391e7416..8b45f16a1890 100644
> >>> --- a/kernel/sched/topology.c
> >>> +++ b/kernel/sched/topology.c
> >>> @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
> >>>   * function:
> >>>   *
> >>>   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
> >>> + *   SD_CLUSTER             - describes CPU Cluster topologies
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
> 
> yes, good idea for getting their meaning directly from the header file. 
> So is it fine for next sending?

Some tweaks below.

> 
>     sched/fair: remove duplicate comments for SD_ flags

      sched/topology: Remove duplicate descriptions from TOPOLOGY_SD_FLAGS
>     
>     Originally, it missed SD_CLUSTER flag description, but comparing to copy
>     the flags meaning from sd_flags.h, reader is better to get info from
>     there.

      These flags are already documented in include/linux/sched/sd_flags.h.

      Keep the comment on SD_ASYM_PACKING as it is a special case.
>     
>     Keep SD_ASYM_PACKING unchange for a point from another way.
>     
>     Signed-off-by: Alex Shi <alexs@kernel.org>
>     To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>     To: Valentin Schneider <vschneid@redhat.com>
>     To: Vincent Guittot <vincent.guittot@linaro.org>
>     To: Juri Lelli <juri.lelli@redhat.com>
>     To: Peter Zijlstra <peterz@infradead.org>
>     To: Ingo Molnar <mingo@redhat.com>
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..96a24bf954ad 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1551,11 +1551,7 @@ static struct cpumask            ***sched_domains_numa_masks;
>   *
>   * These flags are purely descriptive of the topology and do not prescribe
>   * behaviour. Behaviour is artificial and mapped in the below sd_init()
> - * function:
> - *
> - *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
> - *   SD_SHARE_PKG_RESOURCES - describes shared caches
> - *   SD_NUMA                - describes NUMA topologies

Maybe only remove the descriptions but keep the enumeration?

> + * function, for details in include/linux/sched/sd_flags.h:

      function. For details, see include/linux/sched/sd_flags.h.



