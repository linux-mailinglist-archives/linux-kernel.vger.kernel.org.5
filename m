Return-Path: <linux-kernel+bounces-134726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3DD89B60C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCF51F21313
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EC01860;
	Mon,  8 Apr 2024 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mduNRGtD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FD217C2;
	Mon,  8 Apr 2024 02:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543812; cv=none; b=RRKmuaASisvrZ6Amt5CEZECalsIbCVmTDsLlJwyNX9TYCPdQ1S5KzqIxQwbWCZO96V9/wMfuQTjaakcMn9VM3+gxUCTNROwx+o7LHKBNLf5/QH4BdOEHc9GMl44ZChhtrNUf4VPkLTRD11KVdqSlNzCrvhdanpI45zMjc7z/mZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543812; c=relaxed/simple;
	bh=0Ztem555u7cSgmzNrKwZ1a7JMYlZ+WMJzySSY/XJLWY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Swzl6NA5lFKYNnzwoGsf6MYIyPC6vywSVjArM9oTcI2BcdRSErpKaamowFLmkpZD48/mgXIJfXiDU1CxtCec39INDEgZEw+/a/lB1k8GfL3SBVX/Uaw7Xw1Ir7/2BxS9pIZ/S5AoUlIb3me2LYg286i0jYmXOg1HgRpUjBaucuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mduNRGtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FE4C433F1;
	Mon,  8 Apr 2024 02:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712543811;
	bh=0Ztem555u7cSgmzNrKwZ1a7JMYlZ+WMJzySSY/XJLWY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mduNRGtDMp7rDLpNMLTFzqbOSTKRjfHOILOJ6QbQa8j3j6Fu0pIfqJTvqcv1MzH0Y
	 AALg0ZeYRyvMP3rwrbwuzFms7Y4L9TI0XOfLA1YXc9aMBaFne9pIGRhfJFBSEZSUCN
	 96AdjtiSoelsRpTQDSHqcfFaBnRVkntVvZqFwm4/VUM5RA5hM0ulR43JuOk1dlJKjc
	 7b1xoGKCB5ciD9RNIJVxnXCVNjS9lb6rTe+BqCO5nRay2oycSWk2kwz1ZR7Nt594BV
	 l1FwZEpDmqnZnUFUKaJryHdE8HCZjCVeeT+pmI0aXEMhNlTR4zflIxU/ExUFAZTckX
	 cxsOelQx4V5EQ==
Message-ID: <c1dc0e4c1d4c9ba2b5e9c0fc207db267.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240325184204.745706-5-sboyd@kernel.org>
References: <20240325184204.745706-1-sboyd@kernel.org> <20240325184204.745706-5-sboyd@kernel.org>
Subject: Re: [PATCH v2 4/5] clk: Get runtime PM before walking tree during disable_unused
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Sun, 07 Apr 2024 19:36:49 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-03-25 11:41:58)
> Doug reported [1] the following hung task:
>=20
>  INFO: task swapper/0:1 blocked for more than 122 seconds.
>        Not tainted 5.15.149-21875-gf795ebc40eb8 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:swapper/0       state:D stack:    0 pid:    1 ppid:     0 flags:0x0=
0000008
>  Call trace:
>   __switch_to+0xf4/0x1f4
>   __schedule+0x418/0xb80
>   schedule+0x5c/0x10c
>   rpm_resume+0xe0/0x52c
>   rpm_resume+0x178/0x52c
>   __pm_runtime_resume+0x58/0x98
>   clk_pm_runtime_get+0x30/0xb0
>   clk_disable_unused_subtree+0x58/0x208
>   clk_disable_unused_subtree+0x38/0x208
>   clk_disable_unused_subtree+0x38/0x208
>   clk_disable_unused_subtree+0x38/0x208
>   clk_disable_unused_subtree+0x38/0x208
>   clk_disable_unused+0x4c/0xe4
>   do_one_initcall+0xcc/0x2d8
>   do_initcall_level+0xa4/0x148
>   do_initcalls+0x5c/0x9c
>   do_basic_setup+0x24/0x30
>   kernel_init_freeable+0xec/0x164
>   kernel_init+0x28/0x120
>   ret_from_fork+0x10/0x20
>  INFO: task kworker/u16:0:9 blocked for more than 122 seconds.
>        Not tainted 5.15.149-21875-gf795ebc40eb8 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:kworker/u16:0   state:D stack:    0 pid:    9 ppid:     2 flags:0x0=
0000008
>  Workqueue: events_unbound deferred_probe_work_func
>  Call trace:
>   __switch_to+0xf4/0x1f4
>   __schedule+0x418/0xb80
>   schedule+0x5c/0x10c
>   schedule_preempt_disabled+0x2c/0x48
>   __mutex_lock+0x238/0x488
>   __mutex_lock_slowpath+0x1c/0x28
>   mutex_lock+0x50/0x74
>   clk_prepare_lock+0x7c/0x9c
>   clk_core_prepare_lock+0x20/0x44
>   clk_prepare+0x24/0x30
>   clk_bulk_prepare+0x40/0xb0
>   mdss_runtime_resume+0x54/0x1c8
>   pm_generic_runtime_resume+0x30/0x44
>   __genpd_runtime_resume+0x68/0x7c
>   genpd_runtime_resume+0x108/0x1f4
>   __rpm_callback+0x84/0x144
>   rpm_callback+0x30/0x88
>   rpm_resume+0x1f4/0x52c
>   rpm_resume+0x178/0x52c
>   __pm_runtime_resume+0x58/0x98
>   __device_attach+0xe0/0x170
>   device_initial_probe+0x1c/0x28
>   bus_probe_device+0x3c/0x9c
>   device_add+0x644/0x814
>   mipi_dsi_device_register_full+0xe4/0x170
>   devm_mipi_dsi_device_register_full+0x28/0x70
>   ti_sn_bridge_probe+0x1dc/0x2c0
>   auxiliary_bus_probe+0x4c/0x94
>   really_probe+0xcc/0x2c8
>   __driver_probe_device+0xa8/0x130
>   driver_probe_device+0x48/0x110
>   __device_attach_driver+0xa4/0xcc
>   bus_for_each_drv+0x8c/0xd8
>   __device_attach+0xf8/0x170
>   device_initial_probe+0x1c/0x28
>   bus_probe_device+0x3c/0x9c
>   deferred_probe_work_func+0x9c/0xd8
>   process_one_work+0x148/0x518
>   worker_thread+0x138/0x350
>   kthread+0x138/0x1e0
>   ret_from_fork+0x10/0x20
>=20
> The first thread is walking the clk tree and calling
> clk_pm_runtime_get() to power on devices required to read the clk
> hardware via struct clk_ops::is_enabled(). This thread holds the clk
> prepare_lock, and is trying to runtime PM resume a device, when it finds
> that the device is in the process of resuming so the thread schedule()s
> away waiting for the device to finish resuming before continuing. The
> second thread is runtime PM resuming the same device, but the runtime
> resume callback is calling clk_prepare(), trying to grab the
> prepare_lock waiting on the first thread.
>=20
> This is a classic ABBA deadlock. To properly fix the deadlock, we must
> never runtime PM resume or suspend a device with the clk prepare_lock
> held. Actually doing that is near impossible today because the global
> prepare_lock would have to be dropped in the middle of the tree, the
> device runtime PM resumed/suspended, and then the prepare_lock grabbed
> again to ensure consistency of the clk tree topology. If anything
> changes with the clk tree in the meantime, we've lost and will need to
> start the operation all over again.
>=20
> Luckily, most of the time we're simply incrementing or decrementing the
> runtime PM count on an active device, so we don't have the chance to
> schedule away with the prepare_lock held. Let's fix this immediate
> problem that can be triggered more easily by simply booting on Qualcomm
> sc7180.
>=20
> Introduce a list of clk_core structures that have been registered, or
> are in the process of being registered, that require runtime PM to
> operate. Iterate this list and call clk_pm_runtime_get() on each of them
> without holding the prepare_lock during clk_disable_unused(). This way
> we can be certain that the runtime PM state of the devices will be
> active and resumed so we can't schedule away while walking the clk tree
> with the prepare_lock held. Similarly, call clk_pm_runtime_put() without
> the prepare_lock held to properly drop the runtime PM reference. We
> remove the calls to clk_pm_runtime_{get,put}() in this path because
> they're superfluous now that we know the devices are runtime resumed.
>=20
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Closes: https://lore.kernel.org/all/20220922084322.RFC.2.I375b6b9e0a0a534=
8962f004beb3dafee6a12dfbb@changeid/ [1]
> Closes: https://issuetracker.google.com/328070191
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Fixes: 9a34b45397e5 ("clk: Add support for runtime PM")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-fixes

