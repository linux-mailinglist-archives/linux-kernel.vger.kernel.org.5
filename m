Return-Path: <linux-kernel+bounces-47479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229E3844E75
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E3A1C2A47B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4385CB5;
	Thu,  1 Feb 2024 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/8GZyUj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7D2C1A7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749758; cv=none; b=l739gWv3A8lUWolRqgIfUhhYCwu7NRglCijs6yGq18W6Z/BTmJrxFETh4kW+XI4DDQRxbi1309tnA6C4NpZUq17kpx0aBgEapN/U8XDHzKlfmhO+lQXjrouGDNfM6wsrrNXvcXh6QMxPzJS11avETr4Qn/nVblZCK4g0JJOl108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749758; c=relaxed/simple;
	bh=7fgLJaTz+fjvVRnJCmgZZzswtZ/OzmScjrU1Huk7Eh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=st4TbSP7AHHLVQFT32hf9e9GHqRWmcwiyjMttN6zulgqTaJFtOt4sUJ03u4ghIO/CZtdPBwSV1bOM6jhUdBJqNg1+YvkkRnmb1nbv1G8WqXk8pYLDV7kDfZztf/FdznUpVRf5OlElIlGowfSRpV9W5ivINbn3G4aHlTKCA+lLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/8GZyUj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749758; x=1738285758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7fgLJaTz+fjvVRnJCmgZZzswtZ/OzmScjrU1Huk7Eh0=;
  b=K/8GZyUj/UHTM+NjL+Ktt4VMOhQ76MwbOyVArCJ6PEAFs/Vq3rS5v9uU
   1gzgd+4EyKeV5rGDAg9ug+fHq39y8PyK0ATgePbsPrn58kUbhEhrSMt+g
   MtJgHcL6HgNeoCwo2lxQ6VsMWccMPFswSv4M37ll5OKKKCP6gFzEMirZ4
   yqhG5Zy2NR26qPxZgWqPCRj8FvnJfv7PY0FI+ivAKDo1uiVSg4oyS6ZQ8
   2JbL+rf2r/taNPP6Ndw/nrN/anVigfG3j3K7GXxObRomLS+pwa95mMn+J
   jW/bwAJ448eWnR0y1gNpfZuCYmSkseRfN80T7KeeByQS/KGVeZgr/F7Vs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10427927"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10427927"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:09:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878964939"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="878964939"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:09:16 -0800
Date: Wed, 31 Jan 2024 17:10:38 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, sshegde@linux.ibm.com
Subject: Re: [PATCH v2 6/6 RFT] sched/fair: change sched asym checking
 condition
Message-ID: <20240201011038.GD18560@ranerica-svr.sc.intel.com>
References: <20240130131708.429425-1-alexs@kernel.org>
 <20240130131708.429425-6-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130131708.429425-6-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Jan 30, 2024 at 09:17:08PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> Asym only used on SMT sd, or core sd with ITMT and core idled.
> !sched_smt_active isn't necessary.

sched_smt_active() is implemented as a static key. Thus, if SMT is not
enabled, we can quickly return without having to check the rest of the
conditions, as we should.

> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: linux-kernel@vger.kernel.org
> To: Valentin Schneider <vschneid@redhat.com>
> To: Daniel Bristot de Oliveira <bristot@redhat.com>
> To: Ben Segall <bsegall@google.com>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Dietmar Eggemann <dietmar.eggemann@arm.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Juri Lelli <juri.lelli@redhat.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6680cb39c787..0b7530b93429 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9744,8 +9744,8 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  	if (!(sd->flags & SD_ASYM_PACKING))
>  		return false;
>  
> -	return (!sched_smt_active()) ||
> -		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
> +	return (sd->flags & SD_SHARE_CPUCAPACITY) ||
> +		(is_core_idle(cpu) && test_bit(cpu_core_flags(), (void *)&sd->flags));

cpu_core_flags() can contain more than one flag, AFAICS. Which bit should
it check? Moreover, it is implemented differently for each architecture.
Also, as stated, in x86 asym_packing is also used in domains other than MC.

