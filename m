Return-Path: <linux-kernel+bounces-26284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8776E82DE11
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC297282DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C69117C72;
	Mon, 15 Jan 2024 16:58:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BC17BDD;
	Mon, 15 Jan 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 855CD2F4;
	Mon, 15 Jan 2024 08:59:27 -0800 (PST)
Received: from [10.57.7.100] (unknown [10.57.7.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25DA93F5A1;
	Mon, 15 Jan 2024 08:58:38 -0800 (PST)
Message-ID: <d8a85931-9790-414e-9a88-4387e65786d0@arm.com>
Date: Mon, 15 Jan 2024 16:58:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: add virtual-cpufreq driver
Content-Language: en-US
To: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>,
 Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Pavan Kondeti <quic_pkondeti@quicinc.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
 kernel-team@android.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231111014933.1934562-1-davidai@google.com>
 <20231111014933.1934562-3-davidai@google.com>
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231111014933.1934562-3-davidai@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2023 01:49, David Dai wrote:
> [...]
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8d141c71b016..eb72ecdc24db 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
>   
>   obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
>   obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
> +obj-$(CONFIG_CPUFREQ_VIRT)		+= virtual-cpufreq.o
>   
>   # Traces
>   CFLAGS_amd-pstate-trace.o               := -I$(src)
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
> new file mode 100644
> index 000000000000..f828d3345a68
> --- /dev/null
> +++ b/drivers/cpufreq/virtual-cpufreq.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Google LLC
> + */
> +
> +#include <linux/arch_topology.h>
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +#define REG_CUR_FREQ_KHZ_OFFSET 0x0
> +#define REG_SET_FREQ_KHZ_OFFSET 0x4
> +#define PER_CPU_OFFSET 0x8
> +
> +static void __iomem *base;
> +
> +static void virt_scale_freq_tick(void)
> +{
> +	int cpu = smp_processor_id();
> +	u32 max_freq = (u32)cpufreq_get_hw_max_freq(cpu);
> +	u64 cur_freq;
> +	unsigned long scale;
> +
> +	cur_freq = (u64)readl_relaxed(base + cpu * PER_CPU_OFFSET
> +			+ REG_CUR_FREQ_KHZ_OFFSET);
> +
> +	cur_freq <<= SCHED_CAPACITY_SHIFT;
> +	scale = (unsigned long)div_u64(cur_freq, max_freq);
> +	scale = min(scale, SCHED_CAPACITY_SCALE);
> +
> +	this_cpu_write(arch_freq_scale, scale);
> +}

Here we update the scaling factor in the guest, but is there any way to 
let the guest know when the host dequeues the vCPU so that the guest 
PELT signal doesn't appear larger than it actually is? Is this a known 
limitation and is there a way to mitigate it?

> [...]

