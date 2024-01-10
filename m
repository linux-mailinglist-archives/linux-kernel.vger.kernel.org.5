Return-Path: <linux-kernel+bounces-22001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D308297B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54AF6B250C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16251405C3;
	Wed, 10 Jan 2024 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0EmWP7u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E384176B;
	Wed, 10 Jan 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704883060; x=1736419060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/a07s3zLy6oSxp+NJcNrTR33vSL3+Fp4s3fo+xpFY40=;
  b=C0EmWP7u6MVg7k6DOpxiMy+28mKaZ31btfYxlVZWsuzAkI/hCUTbAKFW
   K63jSY67IByQfW4ZjfQUQS1EFkQICth+CMvZ8jxGeaHQo1fVzClaPl5yy
   wtDw7foyu3BhgfEPuR7iuaotORd+rgPLUnmq21WPqHDnaJmOJQ1TWMRjf
   dL0qOclwmXhsZDLObpPyFhQngnugrJiOhW0k6AbbpzRg2NuuleKEvH10G
   NTAavgJ1pfOox1H8guKo3ogDve853+fXNVcj6OztN/4Qen4vcXxJIed9L
   e+JzjDuOcXAqNUDDsBcsdPG6+zAGY2QlF1b24tFYrK+xFZ1lua0q6rTRl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5252325"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5252325"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 02:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785563231"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="785563231"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.37.8])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 02:37:38 -0800
Date: Wed, 10 Jan 2024 11:37:36 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <ZZ5zcBBEv7qupIdE@linux.intel.com>
References: <10423008.nUPlyArG6x@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10423008.nUPlyArG6x@kreacher>

On Tue, Jan 09, 2024 at 05:59:22PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
> system-wide PM code"), the resume of devices that were allowed to resume
> asynchronously was scheduled before starting the resume of the other
> devices, so the former did not have to wait for the latter unless
> functional dependencies were present.
> 
> Commit 7839d0078e0d removed that optimization in order to address a
> correctness issue, but it can be restored with the help of a new device
> power management flag, so do that now.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> I said I'd probably do this in 6.9, but then I thought more about it
> and now I think it would be nice to have 6.8-rc1 without a suspend
> performance regression and the change is relatively straightforward,
> so here it goes.
> 
> ---
>  drivers/base/power/main.c |  117 +++++++++++++++++++++++++---------------------
>  include/linux/pm.h        |    1 
>  2 files changed, 65 insertions(+), 53 deletions(-)
> 
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -681,6 +681,7 @@ struct dev_pm_info {
>  	bool			wakeup_path:1;
>  	bool			syscore:1;
>  	bool			no_pm_callbacks:1;	/* Owned by the PM core */
> +	bool			in_progress:1;	/* Owned by the PM core */
>  	unsigned int		must_resume:1;	/* Owned by the PM core */
>  	unsigned int		may_skip_resume:1;	/* Set by subsystems */

Not related to the patch, just question: why some types here are
unsigned int :1 others bool :1 ?

>   * dpm_resume_early - Execute "early resume" callbacks for all devices.
>   * @state: PM transition of the system being carried out.
> @@ -845,18 +845,28 @@ void dpm_resume_early(pm_message_t state
>  	mutex_lock(&dpm_list_mtx);
>  	pm_transition = state;
>  
> +	/*
> +	 * Trigger the resume of "async" devices upfront so they don't have to
> +	 * wait for the "non-async" ones they don't depend on.
> +	 */
> +	list_for_each_entry(dev, &dpm_late_early_list, power.entry)
> +		dpm_async_fn(dev, async_resume_early);
> +
>  	while (!list_empty(&dpm_late_early_list)) {
>  		dev = to_device(dpm_late_early_list.next);
> -		get_device(dev);
>  		list_move_tail(&dev->power.entry, &dpm_suspended_list);
>  
> -		mutex_unlock(&dpm_list_mtx);
> +		if (!dev->power.in_progress) {

I would consider different naming just to make clear this
is regarding async call, in_progress looks too generic for me.
Fine if you think otherwise, in general patch LGTM:

Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>


