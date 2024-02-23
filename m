Return-Path: <linux-kernel+bounces-78214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA58C861056
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0AC1C21D22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F228C76C83;
	Fri, 23 Feb 2024 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1VBBDuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D5633E9;
	Fri, 23 Feb 2024 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687600; cv=none; b=mS7SrSXVdabbXm0jQ8eQX30I8JH1j2jJ8lM2meoat/k4/mjpabtnWkEXzvzoLhn2iMcF6lnbG6aFhOdFKodty06IHfETL807EE7CjG0fRp6TOa1iOxOAZ0wOD0odEfpzOT6wo4MkYBM+vFdkQFTfzUMiWue76Z9XYcelagt3CRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687600; c=relaxed/simple;
	bh=pPKLLS6SVTpg1tKiUiKHfl/jdui9YbrMYB1Xo5+H3qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m00oa1Gt6Gnr4PrUppxOHYiTvlCZ6I3rcexxE+unf5nZCVuSlZ6j8SlYG3u2gOaWAYNb5BkzB4hzln+Q9UiZX8Y5B/vuAr2P+pHinTl1h38QWMn/hIHNpP638Sy2yRTx6lAz09aiDBoiGA8gI521r94/XCffWORGVZTIjpQR68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1VBBDuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC829C43390;
	Fri, 23 Feb 2024 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708687599;
	bh=pPKLLS6SVTpg1tKiUiKHfl/jdui9YbrMYB1Xo5+H3qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1VBBDuws5kOxlmM1rNRc6tfcBgeJ2kZK52q+QUTB5RLSJfE2lKpDbEhCMyDz540s
	 y7GndBI06OoCvSFiXEBS9MvP8dvCgbvSSdd1cm2VIWRnmGIcB8CE4tC0mRBuOtBWot
	 0Uvo0VyLpfGF2I5xkN0J5vpjPmx/5zkNqXkX6HMDVZHMkhD9S+rs3dZib/JrtyS1K2
	 svl5QMxTb+rCBVM2+QrSXXLE2xF6Jad4uIU5mzlKZoBgzsNuWjcbnDalrEf2BdxYf9
	 3fmPGEoT9ZmVbm1iGWRJwCpHDN7tJ7zK76OGAzGjR1xQFMKaqD7nRNLh6+yQZkyEM5
	 CnPZ0fRkDk6/w==
Date: Fri, 23 Feb 2024 11:26:33 +0000
From: Will Deacon <will@kernel.org>
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/4] perf: starfive: Add StarLink PMU support
Message-ID: <20240223112633.GA10403@willie-the-truck>
References: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
 <20240129095141.3262366-2-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129095141.3262366-2-jisheng.teoh@starfivetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi,

On Mon, Jan 29, 2024 at 05:51:38PM +0800, Ji Sheng Teoh wrote:
> This patch adds support for StarFive's StarLink PMU (Performance
> Monitor Unit). StarLink PMU integrates one or more CPU cores with
> a shared L3 memory system. The PMU supports overflow interrupt,
> up to 16 programmable 64bit event counters, and an independent
> 64bit cycle counter. StarLink PMU is accessed via MMIO.

Since Palmer acked this (thanks!), I queued it locally but then ran into
a few small issues with my build testing. Comments below.

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 273d67ecf6d2..41278742ef88 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -86,6 +86,15 @@ config RISCV_PMU_SBI
>  	  full perf feature support i.e. counter overflow, privilege mode
>  	  filtering, counter configuration.
>  
> +config STARFIVE_STARLINK_PMU
> +	depends on ARCH_STARFIVE

Please can you add "|| COMPILE_TEST" to this dependency so that you get
build coverage from other architectures?

> +	bool "StarFive StarLink PMU"
> +	help
> +	   Provide support for StarLink Performance Monitor Unit.
> +	   StarLink Performance Monitor Unit integrates one or more cores with
> +	   an L3 memory system. The L3 cache events are added into perf event
> +	   subsystem, allowing monitoring of various L3 cache perf events.
> +
>  config ARM_PMU_ACPI
>  	depends on ARM_PMU && ACPI
>  	def_bool y

[...]

> diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
> new file mode 100644
> index 000000000000..2447ca09a471
> --- /dev/null
> +++ b/drivers/perf/starfive_starlink_pmu.c
> @@ -0,0 +1,643 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * StarFive's StarLink PMU driver
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> + *
> + */

[...]

> +static void starlink_pmu_counter_start(struct perf_event *event,
> +				       struct starlink_pmu *starlink_pmu)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = event->hw.idx;
> +	u64 val;
> +
> +	/*
> +	 * Enable counter overflow interrupt[63:0],
> +	 * which is mapped as follow:
> +	 *
> +	 * event counter 0	- Bit [0]
> +	 * event counter 1	- Bit [1]
> +	 * ...
> +	 * cycle counter	- Bit [63]
> +	 */
> +	val = readq(starlink_pmu->pmu_base + STARLINK_PMU_INTERRUPT_ENABLE);
> +
> +	if (hwc->config == STARLINK_CYCLES) {
> +		/*
> +		 * Cycle count has its dedicated register, and it starts
> +		 * counting as soon as STARLINK_PMU_GLOBAL_ENABLE is set.
> +		 */
> +		val |= STARLINK_PMU_CYCLE_OVERFLOW_MASK;
> +	} else {
> +		writeq(event->hw.config, starlink_pmu->pmu_base +
> +		       STARLINK_PMU_EVENT_SELECT + idx * sizeof(u64));
> +
> +		val |= (1 << idx);
> +	}

I think this needs to be a u64 on the right hand side, or just use the
BIT_ULL() macro.

> +
> +	writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_INTERRUPT_ENABLE);
> +
> +	writeq(STARLINK_PMU_GLOBAL_ENABLE, starlink_pmu->pmu_base +
> +	       STARLINK_PMU_CONTROL);
> +}

[...]

> +static irqreturn_t starlink_pmu_handle_irq(int irq_num, void *data)
> +{
> +	struct starlink_pmu *starlink_pmu = data;
> +	struct starlink_hw_events *hw_events =
> +			this_cpu_ptr(starlink_pmu->hw_events);
> +	bool handled = false;
> +	int idx;
> +	u64 overflow_status;
> +
> +	for (idx = 0; idx < STARLINK_PMU_MAX_COUNTERS; idx++) {
> +		struct perf_event *event = hw_events->events[idx];
> +
> +		if (!event)
> +			continue;
> +
> +		overflow_status = readq(starlink_pmu->pmu_base +
> +					STARLINK_PMU_COUNTER_OVERFLOW_STATUS);
> +		if (!(overflow_status & BIT(idx)))
> +			continue;
> +
> +		writeq(1 << idx, starlink_pmu->pmu_base +
> +		       STARLINK_PMU_COUNTER_OVERFLOW_STATUS);

Same shifting problem here.

> +static int starlink_pmu_probe(struct platform_device *pdev)
> +{
> +	struct starlink_pmu *starlink_pmu;
> +	struct starlink_hw_events *hw_events;
> +	struct resource *res;
> +	int cpuid, i, ret;
> +
> +	starlink_pmu = devm_kzalloc(&pdev->dev, sizeof(*starlink_pmu), GFP_KERNEL);
> +	if (!starlink_pmu)
> +		return -ENOMEM;
> +
> +	starlink_pmu->pmu_base =
> +			devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(starlink_pmu->pmu_base))
> +		return PTR_ERR(starlink_pmu->pmu_base);
> +
> +	starlink_pmu->hw_events = alloc_percpu_gfp(struct starlink_hw_events,
> +						   GFP_KERNEL);
> +	if (!starlink_pmu->hw_events) {
> +		dev_err(&pdev->dev, "Failed to allocate per-cpu PMU data\n");
> +		kfree(starlink_pmu);

You shouldn't call kfree() on a device-managed object (i.e. allocated with
devm_kzalloc()).

Will

