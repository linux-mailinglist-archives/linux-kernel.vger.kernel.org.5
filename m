Return-Path: <linux-kernel+bounces-47486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB12844E83
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2B8295C74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4CB3B191;
	Thu,  1 Feb 2024 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liaUvRRH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B663442D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749946; cv=none; b=d/IjW02JEmdfYQkcfACXgKLW8zkfOp/eyRrlMMWcI7jPht6BF2j80nUiewEBXAPeBlfMvAWeRJWxCDXeA/lkOP9qKLq6I4LOav16x83A2MaM8/bsyXfoc7sLquh+m/m7Zv6vR0t8KY4SD2UFT7S8hn9N48nQ7YjDim6vRcRK31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749946; c=relaxed/simple;
	bh=5oY9fVl0MQz5NtK26kDl38I3dzyHW6A1bxVpnjnyZ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEHETerzbDRaoeZDIXEwMDFVEHf7xmbzYlYdH6J21kxMeH0n/PwWSRpCLKQjbgFUA6ZqRLr43mvdG9/auEuvMxtxbGatgZ+4hZwrH01AjmN6G/7r2xY6NqPNw5oXtLs9G2ujLmGqUPmiFMktkFPspaLm0BplUhVJ3TN+t5dN6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liaUvRRH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749946; x=1738285946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5oY9fVl0MQz5NtK26kDl38I3dzyHW6A1bxVpnjnyZ0g=;
  b=liaUvRRHurcjaBI2eippVI8fUM3eU+F4dWVWpV87wu/u5a/y76jwbc3J
   nGKPkXUBDcWZv3/Vcw4gESrxd5+YC82PLwsaooSoMe1CmLUx0DzROwiqo
   A3CU0MNQeTL97YvSYDQBLeWp+Wk3+pI9GnhyZDHCgs+sVNQErhFgMDGWX
   2bLVzNC4u8ZZEGLh+SdMGFkk82U0SMxfsJ4FDGtMW0xpyUGtSIVFUXBgg
   hE4jeedFFW0vGYmGj2xuhfwBnQtziwI+/FD0F8ovXEg6B6OaUU3iwFoqh
   2QO8ZLa5R45f3Wig39W94bbize+LltTmUeKFCPpEQWhRmymRH0JmPZZB3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10411375"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10411375"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:12:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788782396"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="788782396"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:12:24 -0800
Date: Wed, 31 Jan 2024 17:13:46 -0800
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
Subject: Re: [PATCH v2 3/6] sched/fair: cleanup sched_use_asym_prio
Message-ID: <20240201011346.GE18560@ranerica-svr.sc.intel.com>
References: <20240130131708.429425-1-alexs@kernel.org>
 <20240130131708.429425-3-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130131708.429425-3-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Jan 30, 2024 at 09:17:05PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> And simplify the one line code. No function change.
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8d70417f5125..ebd659af2d78 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9741,10 +9741,8 @@ group_type group_classify(unsigned int imbalance_pct,
>   */
>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  {
> -	if (!sched_smt_active())
> -		return true;
> -
> -	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
> +	return (!sched_smt_active()) ||
> +		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);

I think that compressing the two conditions into one hurts readability.
As implemented, it is clear that no further checks are required if there
is no SMT.

Also, please see my comment in patch 6/6.
 

