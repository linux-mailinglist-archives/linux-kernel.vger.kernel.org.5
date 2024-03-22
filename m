Return-Path: <linux-kernel+bounces-111833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A7887178
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196131F24C14
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA15FDA4;
	Fri, 22 Mar 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6hF0qZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8175E3AF;
	Fri, 22 Mar 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126849; cv=none; b=LzU8dilu+zfS14Rv1cKKQoZAk3CBKd0OWSQbTk6HeG9XWu5b6LPbc2tKnrLh4e9yfc3oucWwmMCiM6le7RDr4OT4acnHNl9mL1lCnYDyOivYIB4hBm6+uzlyQDIGGKDjamhbZs7mIF0cE343N9wx8HRv3IrhwDe1c8VZ+folqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126849; c=relaxed/simple;
	bh=CuEL8DTKaHcVBhcZt4WzvXtU5ff2h1A3Pqle55mHAOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyodoiSs1RxKbdcEi1VJecOVVVTqRdaVrysSzfSoLlg8XhdjagvTBZDb89BK1y8ci9lWzeum3qq2PvzHdjpKFnDPvna49JNirrsf2QNy9ko1CZ+HdbFQse72YZYgSllVL2SqHidxa8zMfdiqtl9Uxb7w/u3QVJR5sPhboqafuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6hF0qZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A9CC433C7;
	Fri, 22 Mar 2024 17:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711126848;
	bh=CuEL8DTKaHcVBhcZt4WzvXtU5ff2h1A3Pqle55mHAOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6hF0qZmvPOdqDBKWJbPvCD8CZS2SLVCBA4nhYyv7dFG5ueIARi/Pa93/GPzBeUZb
	 Z/Bh/gBAZULimKRn9bnI2oXHazHeeCDHVFmcPRN0830LtiXHsIf4Plw21SOLXR6HOi
	 vWUSWIQA0Jhppb1o5lQfdj9R5XsaZ28m75Wf2qkXWSxL5i1uAL9pINT51poibnOrjZ
	 oQUrrMjbf1gEJPWDBlsTLAoXH+hFbJY+dZLq2RIuPfinGt6Dxnev28O0bc+mBLlpWF
	 mGc4VDApLFnGpcj/WBj36jIGlCqdNx3Vn9X+Sp355BgIvknsPLvROM5GK9nVPZ1+rI
	 24jEB92m+iGfg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rniGI-000000006Kx-1Z57;
	Fri, 22 Mar 2024 18:00:58 +0100
Date: Fri, 22 Mar 2024 18:00:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 2/8] clk: qcom: gdsc: Enable supply reglator in GPU GX
 handler
Message-ID: <Zf25Sv2x9WaCFuIH@hovoldconsulting.com>
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
 <20240125-sa8295p-gpu-v4-2-7011c2a63037@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-sa8295p-gpu-v4-2-7011c2a63037@quicinc.com>

On Thu, Jan 25, 2024 at 01:05:08PM -0800, Bjorn Andersson wrote:
> The GX GDSC is modelled to aid the GMU in powering down the GPU in the
> event that the GPU crashes, so that it can be restarted again. But in
> the event that the power-domain is supplied through a dedicated
> regulator (in contrast to being a subdomin of another power-domain),
> something needs to turn that regulator on, both to make sure things are
> powered and to match the operation in gdsc_disable().
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/clk/qcom/gdsc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 5358e28122ab..e7a4068b9f39 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -557,7 +557,15 @@ void gdsc_unregister(struct gdsc_desc *desc)
>   */
>  int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
>  {
> -	/* Do nothing but give genpd the impression that we were successful */
> -	return 0;
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	int ret = 0;
> +
> +	/* Enable the parent supply, when controlled through the regulator framework. */
> +	if (sc->rsupply)
> +		ret = regulator_enable(sc->rsupply);
> +
> +	/* Do nothing with the GDSC itself */
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);

This patch (and series) is now in mainline as commit 9187ebb954ab ("clk:
qcom: gdsc: Enable supply reglator in GPU GX handler") and appears to be
involved in triggering the below lockdep splat on boot of the Lenovo
ThinkPad X13s.

Adding Ulf and the MSM DRM devs as well in case I blamed the wrong
change here.

Johan


[    5.849106] ======================================================
[    5.849111] WARNING: possible circular locking dependency detected
[    5.849115] 6.8.0 #111 Not tainted
[    5.849119] ------------------------------------------------------
[    5.849123] kworker/u32:2/66 is trying to acquire lock:
[    5.849128] ffffaffb0ca9b4f0 (regulator_list_mutex){+.+.}-{3:3}, at: regulator_lock_dependent+0x54/0x27c
[    5.849148] 
               but task is already holding lock:
[    5.849152] ffffaffad8f33a00 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x24
[    5.849165] 
               which lock already depends on the new lock.

[    5.849170] 
               the existing dependency chain (in reverse order) is:
[    5.849175] 
               -> #3 (&genpd->mlock){+.+.}-{3:3}:
[    5.849182]        lock_acquire+0x68/0x84
[    5.849190]        __mutex_lock+0xa0/0x840
[    5.849197]        mutex_lock_nested+0x24/0x30
[    5.849201]        genpd_lock_mtx+0x18/0x24
[    5.849206]        genpd_runtime_resume+0x104/0x2f4
[    5.849211]        __rpm_callback+0x48/0x1a8
[    5.849218]        rpm_callback+0x68/0x74
[    5.849223]        rpm_resume+0x444/0x638
[    5.849228]        __pm_runtime_resume+0x5c/0xbc
[    5.849233]        device_link_add+0x680/0x6e8
[    5.849239]        arm_smmu_probe_device+0x2a4/0x3e4
[    5.849245]        __iommu_probe_device+0x108/0x430
[    5.849250]        iommu_probe_device+0x3c/0x80
[    5.849255]        of_iommu_configure+0x170/0x25c
[    5.849260]        of_dma_configure_id+0x10c/0x340
[    5.849265]        platform_dma_configure+0x78/0xbc
[    5.849270]        really_probe+0x74/0x388
[    5.849276]        __driver_probe_device+0x7c/0x160
[    5.849281]        driver_probe_device+0x40/0x114
[    5.849287]        __driver_attach+0xfc/0x208
[    5.849292]        bus_for_each_dev+0x74/0xd0
[    5.849296]        driver_attach+0x24/0x30
[    5.849301]        bus_add_driver+0x110/0x214
[    5.849306]        driver_register+0x60/0x128
[    5.849312]        __platform_driver_register+0x28/0x34
[    5.849316]        panel_edp_init+0x20/0x1000 [panel_edp]
[    5.849329]        panel_edp_init+0xc8/0x1000 [panel_edp]
[    5.849337]        do_one_initcall+0x74/0x344
[    5.849342]        do_init_module+0x5c/0x1f8
[    5.849347]        load_module+0x1c9c/0x1e18
[    5.849351]        init_module_from_file+0x84/0xc0
[    5.849356]        idempotent_init_module+0x180/0x250
[    5.849360]        __arm64_sys_finit_module+0x68/0xcc
[    5.849365]        invoke_syscall+0x48/0x114
[    5.849370]        el0_svc_common.constprop.0+0xc0/0xe0
[    5.849376]        do_el0_svc+0x1c/0x28
[    5.849381]        el0_svc+0x48/0x114
[    5.849386]        el0t_64_sync_handler+0xc0/0xc4
[    5.849391]        el0t_64_sync+0x190/0x194
[    5.849395] 
               -> #2 (dpm_list_mtx){+.+.}-{3:3}:
[    5.849403]        lock_acquire+0x68/0x84
[    5.849408]        __mutex_lock+0xa0/0x840
[    5.849412]        mutex_lock_nested+0x24/0x30
[    5.849416]        device_pm_lock+0x1c/0x28
[    5.849422]        device_link_add+0x274/0x6e8
[    5.849426]        fw_devlink_create_devlink+0x118/0x2fc
[    5.849431]        __fw_devlink_link_to_consumers.isra.0+0x50/0x104
[    5.849437]        device_add+0x744/0x7b0
[    5.849441]        of_device_add+0x44/0x60
[    5.849446]        of_platform_device_create_pdata+0x98/0x140
[    5.849451]        of_platform_bus_create+0x1b4/0x4b4
[    5.849455]        of_platform_populate+0x58/0x150
[    5.849459]        of_platform_default_populate_init+0xd8/0xf0
[    5.849466]        do_one_initcall+0x74/0x344
[    5.849470]        kernel_init_freeable+0x244/0x350
[    5.849476]        kernel_init+0x20/0x1d8
[    5.849480]        ret_from_fork+0x10/0x20
[    5.849484] 
               -> #1 (device_links_lock){+.+.}-{3:3}:
[    5.849492]        lock_acquire+0x68/0x84
[    5.849497]        __mutex_lock+0xa0/0x840
[    5.849501]        mutex_lock_nested+0x24/0x30
[    5.849505]        device_link_remove+0x38/0x94
[    5.849509]        _regulator_put.part.0+0x168/0x190
[    5.849515]        regulator_bulk_free+0x64/0x90
[    5.849521]        devm_regulator_bulk_release+0x1c/0x28
[    5.849526]        release_nodes+0x5c/0x90
[    5.849532]        devres_release_group+0xc8/0x134
[    5.849537]        i2c_device_probe+0x138/0x2e8 [i2c_core]
[    5.849549]        really_probe+0xc0/0x388
[    5.849554]        __driver_probe_device+0x7c/0x160
[    5.849559]        driver_probe_device+0x40/0x114
[    5.849565]        __device_attach_driver+0xbc/0x158
[    5.849571]        bus_for_each_drv+0x84/0xe0
[    5.849576]        __device_attach_async_helper+0xb0/0x10c
[    5.849582]        async_run_entry_fn+0x34/0x14c
[    5.849588]        process_one_work+0x220/0x634
[    5.849595]        worker_thread+0x268/0x3a8
[    5.849599]        kthread+0x124/0x128
[    5.849603]        ret_from_fork+0x10/0x20
[    5.849608] 
               -> #0 (regulator_list_mutex){+.+.}-{3:3}:
[    5.849615]        __lock_acquire+0x130c/0x2064
[    5.849621]        lock_acquire.part.0+0xc8/0x20c
[    5.849626]        lock_acquire+0x68/0x84
[    5.849631]        __mutex_lock+0xa0/0x840
[    5.849636]        mutex_lock_nested+0x24/0x30
[    5.849640]        regulator_lock_dependent+0x54/0x27c
[    5.849646]        regulator_enable+0x34/0xd0
[    5.849651]        gdsc_gx_do_nothing_enable+0x18/0x2c
[    5.849659]        _genpd_power_on+0x94/0x17c
[    5.849664]        genpd_power_on.part.0+0xa4/0x1a8
[    5.849669]        genpd_runtime_resume+0x120/0x2f4
[    5.849673]        __rpm_callback+0x48/0x1a8
[    5.849678]        rpm_callback+0x68/0x74
[    5.849683]        rpm_resume+0x584/0x638
[    5.849688]        __pm_runtime_resume+0x5c/0xbc
[    5.849693]        a6xx_gmu_resume+0x70/0xcf8 [msm]
[    5.849722]        a6xx_gmu_pm_resume+0x3c/0x284 [msm]
[    5.849745]        adreno_runtime_resume+0x28/0x34 [msm]
[    5.849769]        pm_generic_runtime_resume+0x2c/0x44
[    5.849774]        __rpm_callback+0x48/0x1a8
[    5.849779]        rpm_callback+0x68/0x74
[    5.849783]        rpm_resume+0x444/0x638
[    5.849788]        __pm_runtime_resume+0x5c/0xbc
[    5.849793]        adreno_load_gpu+0x78/0x238 [msm]
[    5.849816]        msm_open+0x114/0x128 [msm]
[    5.849843]        drm_file_alloc+0x184/0x2a8 [drm]
[    5.849876]        drm_client_init+0x7c/0x10c [drm]
[    5.849900]        msm_fbdev_setup+0x84/0x150 [msm]
[    5.849929]        msm_drm_bind+0x264/0x420 [msm]
[    5.849950]        try_to_bring_up_aggregate_device+0x1ec/0x2f4
[    5.849962]        __component_add+0xa8/0x194
[    5.849965]        component_add+0x14/0x20
[    5.849967]        dp_display_probe_tail+0x4c/0xac [msm]
[    5.850000]        dp_auxbus_done_probe+0x14/0x20 [msm]
[    5.850023]        dp_aux_ep_probe+0x4c/0xf0 [drm_dp_aux_bus]
[    5.850030]        really_probe+0xc0/0x388
[    5.850034]        __driver_probe_device+0x7c/0x160
[    5.850038]        driver_probe_device+0x40/0x114
[    5.850042]        __device_attach_driver+0xbc/0x158
[    5.850046]        bus_for_each_drv+0x84/0xe0
[    5.850050]        __device_attach+0xa8/0x1d4
[    5.850053]        device_initial_probe+0x14/0x20
[    5.850058]        bus_probe_device+0xb0/0xb4
[    5.850061]        device_add+0x5b8/0x7b0
[    5.850065]        device_register+0x20/0x30
[    5.850068]        of_dp_aux_populate_bus+0xcc/0x1a0 [drm_dp_aux_bus]
[    5.850074]        devm_of_dp_aux_populate_bus+0x18/0x80 [drm_dp_aux_bus]
[    5.850080]        dp_display_probe+0x2a4/0x454 [msm]
[    5.850098]        platform_probe+0x68/0xd8
[    5.850102]        really_probe+0xc0/0x388
[    5.850106]        __driver_probe_device+0x7c/0x160
[    5.850109]        driver_probe_device+0x40/0x114
[    5.850113]        __device_attach_driver+0xbc/0x158
[    5.850117]        bus_for_each_drv+0x84/0xe0
[    5.850121]        __device_attach+0xa8/0x1d4
[    5.850125]        device_initial_probe+0x14/0x20
[    5.850129]        bus_probe_device+0xb0/0xb4
[    5.850133]        deferred_probe_work_func+0xa0/0xf4
[    5.850137]        process_one_work+0x220/0x634
[    5.850141]        worker_thread+0x268/0x3a8
[    5.850144]        kthread+0x124/0x128
[    5.850147]        ret_from_fork+0x10/0x20
[    5.850151] 
               other info that might help us debug this:

[    5.850154] Chain exists of:
                 regulator_list_mutex --> dpm_list_mtx --> &genpd->mlock

[    5.850163]  Possible unsafe locking scenario:

[    5.850166]        CPU0                    CPU1
[    5.850168]        ----                    ----
[    5.850171]   lock(&genpd->mlock);
[    5.850174]                                lock(dpm_list_mtx);
[    5.850178]                                lock(&genpd->mlock);
[    5.850182]   lock(regulator_list_mutex);
[    5.850185] 
                *** DEADLOCK ***
[    5.850188] 8 locks held by kworker/u32:2/66:
[    5.850191]  #0: ffff2be180020948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1a0/0x634
[    5.850199]  #1: ffff800081033de0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1c8/0x634
[    5.850207]  #2: ffff2be1849e38f8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x38/0x1d4
[    5.850215]  #3: ffff2be183c550e8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x38/0x1d4
[    5.850223]  #4: ffffaffb0caa59e8 (component_mutex){+.+.}-{3:3}, at: __component_add+0x60/0x194
[    5.850231]  #5: ffffaffad96ee178 (init_lock){+.+.}-{3:3}, at: msm_open+0x38/0x128 [msm]
[    5.850252]  #6: ffff2be18d6536d8 (&a6xx_gpu->gmu.lock){+.+.}-{3:3}, at: a6xx_gmu_pm_resume+0x34/0x284 [msm]
[    5.850274]  #7: ffffaffad8f33a00 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x24
[    5.850282] 
               stack backtrace:
[    5.850286] CPU: 6 PID: 66 Comm: kworker/u32:2 Not tainted 6.8.0 #111
[    5.850291] Hardware name: LENOVO 21BYZ9SRUS/21BYZ9SRUS, BIOS N3HET87W (1.59 ) 12/05/2023
[    5.850296] Workqueue: events_unbound deferred_probe_work_func
[    5.850301] Call trace:
[    5.850303]  dump_backtrace+0x9c/0x11c
[    5.850307]  show_stack+0x18/0x24
[    5.850312]  dump_stack_lvl+0x90/0xd0
[    5.850316]  dump_stack+0x18/0x24
[    5.850320]  print_circular_bug+0x290/0x370
[    5.850324]  check_noncircular+0x15c/0x170
[    5.850327]  __lock_acquire+0x130c/0x2064
[    5.850331]  lock_acquire.part.0+0xc8/0x20c
[    5.850335]  lock_acquire+0x68/0x84
[    5.850339]  __mutex_lock+0xa0/0x840
[    5.850342]  mutex_lock_nested+0x24/0x30
[    5.850345]  regulator_lock_dependent+0x54/0x27c
[    5.850349]  regulator_enable+0x34/0xd0
[    5.850352]  gdsc_gx_do_nothing_enable+0x18/0x2c
[    5.850356]  _genpd_power_on+0x94/0x17c
[    5.850360]  genpd_power_on.part.0+0xa4/0x1a8
[    5.850363]  genpd_runtime_resume+0x120/0x2f4
[    5.850366]  __rpm_callback+0x48/0x1a8
[    5.850370]  rpm_callback+0x68/0x74
[    5.850374]  rpm_resume+0x584/0x638
[    5.850377]  __pm_runtime_resume+0x5c/0xbc
[    5.850381]  a6xx_gmu_resume+0x70/0xcf8 [msm]
[    5.850398]  a6xx_gmu_pm_resume+0x3c/0x284 [msm]
[    5.850416]  adreno_runtime_resume+0x28/0x34 [msm]
[    5.850433]  pm_generic_runtime_resume+0x2c/0x44
[    5.850437]  __rpm_callback+0x48/0x1a8
[    5.850440]  rpm_callback+0x68/0x74
[    5.850443]  rpm_resume+0x444/0x638
[    5.850447]  __pm_runtime_resume+0x5c/0xbc
[    5.850450]  adreno_load_gpu+0x78/0x238 [msm]
[    5.850467]  msm_open+0x114/0x128 [msm]
[    5.850485]  drm_file_alloc+0x184/0x2a8 [drm]
[    5.850504]  drm_client_init+0x7c/0x10c [drm]
[    5.850522]  msm_fbdev_setup+0x84/0x150 [msm]
[    5.850540]  msm_drm_bind+0x264/0x420 [msm]
[    5.850557]  try_to_bring_up_aggregate_device+0x1ec/0x2f4
[    5.850562]  __component_add+0xa8/0x194
[    5.850566]  component_add+0x14/0x20
[    5.850570]  dp_display_probe_tail+0x4c/0xac [msm]
[    5.850587]  dp_auxbus_done_probe+0x14/0x20 [msm]
[    5.850605]  dp_aux_ep_probe+0x4c/0xf0 [drm_dp_aux_bus]
[    5.850611]  really_probe+0xc0/0x388
[    5.850615]  __driver_probe_device+0x7c/0x160
[    5.850619]  driver_probe_device+0x40/0x114
[    5.850624]  __device_attach_driver+0xbc/0x158
[    5.850628]  bus_for_each_drv+0x84/0xe0
[    5.850631]  __device_attach+0xa8/0x1d4
[    5.850635]  device_initial_probe+0x14/0x20
[    5.850639]  bus_probe_device+0xb0/0xb4
[    5.850642]  device_add+0x5b8/0x7b0
[    5.850645]  device_register+0x20/0x30
[    5.850648]  of_dp_aux_populate_bus+0xcc/0x1a0 [drm_dp_aux_bus]
[    5.850654]  devm_of_dp_aux_populate_bus+0x18/0x80 [drm_dp_aux_bus]
[    5.850660]  dp_display_probe+0x2a4/0x454 [msm]
[    5.850678]  platform_probe+0x68/0xd8
[    5.850681]  really_probe+0xc0/0x388
[    5.850684]  __driver_probe_device+0x7c/0x160
[    5.850688]  driver_probe_device+0x40/0x114
[    5.850692]  __device_attach_driver+0xbc/0x158
[    5.850696]  bus_for_each_drv+0x84/0xe0
[    5.850699]  __device_attach+0xa8/0x1d4
[    5.850703]  device_initial_probe+0x14/0x20
[    5.850707]  bus_probe_device+0xb0/0xb4
[    5.850710]  deferred_probe_work_func+0xa0/0xf4
[    5.850714]  process_one_work+0x220/0x634
[    5.850717]  worker_thread+0x268/0x3a8
[    5.850720]  kthread+0x124/0x128
[    5.850723]  ret_from_fork+0x10/0x20


