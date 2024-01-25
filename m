Return-Path: <linux-kernel+bounces-38106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4170883BB02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050CF28AA67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393D13FE5;
	Thu, 25 Jan 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5ibB8Zt"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F417736;
	Thu, 25 Jan 2024 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169172; cv=none; b=oBgjGjBeoRxV7BhE8yCdDHEhbdyrYSo4LzzDGLtbIbRFKCwM+xx5xAUSnlH8sYKL9fXQdMkVtakA58tR9bbtdRO0M9QRKxC2sAaHJH8G7bEKLt3DP5foPjb4laX4kyd9EO/rYPQfFT/PAMIhqx+91vp1usXuoQBaFGKwGyAnOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169172; c=relaxed/simple;
	bh=E2jDdYMcW3/zdELWqG5r09VuoojlGddVc/lLHVVXNos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwv/HLN2mjwin2f0t/Ppp/fbBFt2LYGQxo5DkHkW1LbdcHZFc9ZTtlIpp5FC+0RbfWznFalHL4pyMK9pdV+XRyjndW4OTujSKOoDRuEM9RqdifAmq7klWWi5HCXVRZauSF/hM0g1ssqPLUitmf4Axj/l4CtyNS5eE3ITeHT/0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5ibB8Zt; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706169171; x=1737705171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E2jDdYMcW3/zdELWqG5r09VuoojlGddVc/lLHVVXNos=;
  b=P5ibB8ZtxbSkqIhOpLXQuUC0LvlJ71h9vr4ObGeYy/Qg6EmAJgWRT5Ug
   5bnLfBbwjT243LysB3oU5Xs6oQI7NylcNQNN8PF/xXAwN6DzQb7kHgTb9
   r0ZHQ1ymJbH46QV8kwjQXROaY2/GpawQRFdbot6VjxPTMQG4+lUiqz7EX
   rGd2VATpIq5yYU7nxVmI00j2nXVOKlv0gzrvP5PR9Nyc/g5oK+DEl+65d
   5CU5APwysPRzyh35mtoeXgG2mnlRgkQtcTyjESxbrcqV7GX1cpwhaznyA
   CNFSd8OYmT+SIOrFDXg3qlWz7ZEi6qdBQyycjrWWtH52psjyJ8wQpp/C8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400947098"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400947098"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2140893"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.119])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:52:49 -0800
Date: Thu, 25 Jan 2024 08:52:46 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 05/12] PM: sleep: stats: Use step_failures[0] as a
 counter of successful cycles
Message-ID: <ZbITTlBwu390dwT5@linux.intel.com>
References: <5760158.DvuYhMxLoT@kreacher>
 <3290637.44csPzL39Z@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3290637.44csPzL39Z@kreacher>

On Mon, Jan 22, 2024 at 12:29:11PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The first (index 0) cell of the step_failures[] array in struct
> suspend_stats introduced previously can be used as a counter of
> successful suspend-resume cycles instead of the separate "success"
> field in it, so do that.
> 
> While at it, change the type of the "fail" field in struct
> suspend_stats to unsigned int, because it cannot be negative.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/suspend.h |    3 +--
>  kernel/power/main.c     |    9 +++++----
>  kernel/power/suspend.c  |    2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -55,8 +55,7 @@ enum suspend_stat_step {
>  
>  struct suspend_stats {
>  	unsigned int step_failures[SUSPEND_NR_STEPS];
> -	int	success;
<snip>
> -		   suspend_stats.success, suspend_stats.fail);
> +	seq_printf(s, "success: %u\nfail: %u\n",
> +		   suspend_stats.step_failures[SUSPEND_NONE],
> +		   suspend_stats.fail);
>  
>  	for (step = SUSPEND_FREEZE; step < SUSPEND_NR_STEPS; step++)
>  		seq_printf(s, "failed_%s: %u\n", suspend_step_names[step],
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -620,7 +620,7 @@ int pm_suspend(suspend_state_t state)
>  		suspend_stats.fail++;
>  		dpm_save_failed_errno(error);
>  	} else {
> -		suspend_stats.success++;
> +		suspend_stats.step_failures[SUSPEND_NONE]++;

This looks confusing for me. I think would be better keep
success field and just remove SUSPEND_NONE from the 
suspend_stat_step and suspend_stat_names. Actually do
not introduce it, SUSPEND_NONE does not seems to be necessary
(SUSPEND_FREEZE can be 0).

Regards
Stanislaw
 






