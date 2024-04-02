Return-Path: <linux-kernel+bounces-127830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1A6895189
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E79E2859CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE43E6166E;
	Tue,  2 Apr 2024 11:12:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6D4604BB;
	Tue,  2 Apr 2024 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056378; cv=none; b=KIHq/XVTuI0cWgxh1/NTEAZ1C4ZIkqjOWiSFHrPEQtV+Otrx1lTuwJvo2aCGHyltsz7QQ6VzycFS0O2cV3ZvU1WgcMwIx2C1RU4kJ3T7Hp5GBoPo5J0ewtM2qBlOZDUSq2HmX6rmgiKcQgnLfj4I/+VT5VnSKBEEiXvqHNRHgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056378; c=relaxed/simple;
	bh=/MoYJpA2GdRSYaL6CI74cBtohbnZU9BGiFdHG+52kIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAlnegKPIUgDLeQtPDiwoQbGN9jvQXo7gBfmnyJ607uPFFH48+xQCNOh2b5BIiF3Y+ulQKk7W3hLecXUdiShPbHsJW8oTNgx3yIZvALSxbUCZpcFD4ZrKBk3jKCxMSZnugDY9zZySL8u5fkFQfSaMVdL9Z+2ciYntVWLi82CdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 890FB1007;
	Tue,  2 Apr 2024 04:13:27 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.18.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0FDA3F766;
	Tue,  2 Apr 2024 04:12:53 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:12:50 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/9] perf: Avoid explicit cpumask var allocation from
 stack
Message-ID: <ZgvoMunpbaE-x3jV@FVFF77S0Q05N>
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402105610.1695644-1-dawei.li@shingroup.cn>

On Tue, Apr 02, 2024 at 06:56:01PM +0800, Dawei Li wrote:
> Hi,
> 
> This series try to eliminate direct cpumask var allocation from stack
> for perf subsystem.
> 
> Direct/explicit allocation of cpumask on stack could be dangerous since
> it can lead to stack overflow for systems with big NR_CPUS or
> CONFIG_CPUMASK_OFFSTACK=y.
> 
> For arm64, it's more urgent since commit 3fbd56f0e7c1 ("ARM64: Dynamically
> allocate cpumasks and increase supported CPUs to 512").
> 
> It's sort of a pattern that almost every cpumask var in perf subystem
> occurs in teardown callback of cpuhp. In which case, if dynamic
> allocation failed(which is unlikely), we choose return 0 rather than
> -ENOMEM to caller cuz:
> @teardown is not supposed to fail and if it does, system crashes:

.. but we've left the system in an incorrect state, so that makes no sense.

As I commented on the first patch, NAK to dynamically allocating cpumasks in
the CPUHP callbacks. Please allocate the necessry cpumasks up-front when we
probe the PMU. At that time we can handle an allocation failure by cleaning up
and failing to probe the PMU, and then the CPUHP callbacks don't need to
allocate memory to offline a CPU...

Also, for the titles it'd be better to say something like "avoid placing
cpumasks on the stack", because "explicit cpumask var allocation" sounds like
the use of alloc_cpumask_var().

Mark.

> 
> static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
>                             struct hlist_node *node)
> {
>         struct cpuhp_step *sp = cpuhp_get_step(state);
>         int ret;
> 
>         /*
>          * If there's nothing to do, we done.
>          * Relies on the union for multi_instance.
>          */
>         if (cpuhp_step_empty(bringup, sp))
>                 return 0;
>         /*
>          * The non AP bound callbacks can fail on bringup. On teardown
>          * e.g. module removal we crash for now.
>          */
> 	#ifdef CONFIG_SMP
>         if (cpuhp_is_ap_state(state))
>                 ret = cpuhp_invoke_ap_callback(cpu, state, bringup, node);
>         else
>                 ret = cpuhp_invoke_callback(cpu, state, bringup, node,
> 		NULL);
> 	#else
>         ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
> 	#endif
>         BUG_ON(ret && !bringup);
>         return ret;
> }
> 
> Dawei Li (9):
>   perf/alibaba_uncore_drw: Avoid explicit cpumask var allocation from
>     stack
>   perf/arm-cmn: Avoid explicit cpumask var allocation from stack
>   perf/arm_cspmu: Avoid explicit cpumask var allocation from stack
>   perf/arm_dsu: Avoid explicit cpumask var allocation from stack
>   perf/dwc_pcie: Avoid explicit cpumask var allocation from stack
>   perf/hisi_pcie: Avoid explicit cpumask var allocation from stack
>   perf/hisi_uncore: Avoid explicit cpumask var allocation from stack
>   perf/qcom_l2: Avoid explicit cpumask var allocation from stack
>   perf/thunder_x2: Avoid explicit cpumask var allocation from stack
> 
>  drivers/perf/alibaba_uncore_drw_pmu.c    | 13 +++++++++----
>  drivers/perf/arm-cmn.c                   | 13 +++++++++----
>  drivers/perf/arm_cspmu/arm_cspmu.c       | 13 +++++++++----
>  drivers/perf/arm_dsu_pmu.c               | 18 +++++++++++++-----
>  drivers/perf/dwc_pcie_pmu.c              | 17 +++++++++++------
>  drivers/perf/hisilicon/hisi_pcie_pmu.c   | 15 ++++++++++-----
>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 13 +++++++++----
>  drivers/perf/qcom_l2_pmu.c               | 15 ++++++++++-----
>  drivers/perf/thunderx2_pmu.c             | 20 ++++++++++++--------
>  9 files changed, 92 insertions(+), 45 deletions(-)
> 
> 
> Thanks,
> 
>     Dawei
> 
> -- 
> 2.27.0
> 

