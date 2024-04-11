Return-Path: <linux-kernel+bounces-140306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4978A127F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096B01C214CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6201474CD;
	Thu, 11 Apr 2024 11:05:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1901448EF;
	Thu, 11 Apr 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833540; cv=none; b=cDggxUVestaiaGTJuMDE6RDQy45txyXVDefBY5TYgIZqg7O/45GKJi+t40CApsaPtfN0HZAYp42pKoTmNvH8uFpZEWtZ8SvxrzwSnmwDyiH1UuHN4zTlN/Sx7VJO72XSzwZMiHlIfVrStuU97OFjLsLCYGHspemgF+MUQr4wB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833540; c=relaxed/simple;
	bh=YEJL3ghCsfMB8ZAFRjYsc97OCY/S6Wd4Nn8Odn32JnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZV2FH17FkbuYntPmhXzPKKaWmx90k6+WljZbS92ueH7WRaOWO8ejrEifotFMWcqQt+v/3fAW9Cacujvj/wnbBrWTafp3B82S6hE7WS/3NOKTVUYsOYSWdxM8bHTbMFOpO+ks3zvEZQLjaAZe0vfI1AnZajutJhxhIrTeo6JaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA3E2113E;
	Thu, 11 Apr 2024 04:06:05 -0700 (PDT)
Received: from [10.57.53.156] (unknown [10.57.53.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBFEC3F64C;
	Thu, 11 Apr 2024 04:05:33 -0700 (PDT)
Message-ID: <dc9ab047-79cb-42a8-ad75-bc0f306517d5@arm.com>
Date: Thu, 11 Apr 2024 12:05:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] drivers/perf: Add SiFive Composable Cache PMU
 driver
Content-Language: en-GB
To: Samuel Holland <samuel.holland@sifive.com>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Eric Lin <eric.lin@sifive.com>, Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
 <20240216000837.1868917-3-samuel.holland@sifive.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240216000837.1868917-3-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-16 12:08 am, Samuel Holland wrote:
> From: Eric Lin <eric.lin@sifive.com>
> 
> Add a driver for the PMU found in the SiFive Composable Cache
> controller. This PMU provides a configurable number of counters and a
> variety of events. Events are grouped into sets. Each counter can count
> events from only one set at a time; however, it can count any number of
> events within that set simultaneously. The PMU hardware does not provide
> an overflow interrupt or a way to atomically control groups of counters.
> 
> Some events can be filtered further by client ID (e.g. CPU or external
> DMA master). That functionality is not supported by this driver.
> 
> This driver further assumes that a single Composable Cache instance is
> shared by all CPUs in the system.
> 
> Example usage:
> 
> $ perf stat -a -e sifive_ccache_pmu/inner_acquire_block_btot/,
> 		  sifive_ccache_pmu/inner_acquire_block_hit/,
> 		  sifive_ccache_pmu/inner_acquire_block_ntob/ ls
> 
>   Performance counter stats for 'system wide':
> 
>                 542      sifive_ccache_pmu/inner_acquire_block_btot/
>               22081      sifive_ccache_pmu/inner_acquire_block_hit/
>               22006      sifive_ccache_pmu/inner_acquire_block_ntob/
> 
>         0.064672432 seconds time elapsed
> 
> Example using numeric event selectors:
> 
> $ perf stat -a -e sifive_ccache_pmu/event=0x10001/,
> 		  sifive_ccache_pmu/event=0x2002/,
> 		  sifive_ccache_pmu/event=0x4001/ ls
> 
>   Performance counter stats for 'system wide':
> 
>                 478      sifive_ccache_pmu/event=0x10001/
>                4717      sifive_ccache_pmu/event=0x2002/
>               44966      sifive_ccache_pmu/event=0x4001/
> 
>         0.111027326 seconds time elapsed
> 
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>   drivers/perf/Kconfig             |   9 +
>   drivers/perf/Makefile            |   1 +
>   drivers/perf/sifive_ccache_pmu.c | 577 +++++++++++++++++++++++++++++++
>   include/linux/cpuhotplug.h       |   1 +
>   4 files changed, 588 insertions(+)
>   create mode 100644 drivers/perf/sifive_ccache_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index ec6e0d9194a1..b4e4db7424b4 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -155,6 +155,15 @@ config QCOM_L3_PMU
>   	   Adds the L3 cache PMU into the perf events subsystem for
>   	   monitoring L3 cache events.
>   
> +config SIFIVE_CCACHE_PMU
> +	tristate "SiFive Composable Cache PMU"
> +	depends on RISCV || COMPILE_TEST
> +	help
> +	  Support for the Composable Cache performance monitoring unit (PMU) on
> +	  SiFive platforms. The Composable Cache PMU provides up to 64 counters
> +	  for measuring whole-system L2/L3 cache performance using the perf
> +	  events subsystem.
> +
>   config THUNDERX2_PMU
>   	tristate "Cavium ThunderX2 SoC PMU UNCORE"
>   	depends on ARCH_THUNDER2 || COMPILE_TEST
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index a06338e3401c..51ef5f50ace4 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
>   obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
>   obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
>   obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
> +obj-$(CONFIG_SIFIVE_CCACHE_PMU) += sifive_ccache_pmu.o
>   obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>   obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>   obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
> diff --git a/drivers/perf/sifive_ccache_pmu.c b/drivers/perf/sifive_ccache_pmu.c
> new file mode 100644
> index 000000000000..8c9ef0d09f48
> --- /dev/null
> +++ b/drivers/perf/sifive_ccache_pmu.c
> @@ -0,0 +1,577 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SiFive Composable Cache PMU driver
> + *
> + * Copyright (C) 2022-2024 SiFive, Inc.
> + * Copyright (C) Eric Lin <eric.lin@sifive.com>
> + *
> + */
> +
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +#define CCACHE_SELECT_OFFSET		0x2000
> +#define CCACHE_CLIENT_FILTER_OFFSET	0x2800
> +#define CCACHE_COUNTER_OFFSET		0x3000
> +
> +#define CCACHE_PMU_MAX_COUNTERS		64
> +
> +struct sifive_ccache_pmu {
> +	struct pmu			pmu;
> +	struct hlist_node		node;
> +	struct notifier_block		cpu_pm_nb;

This seems unused.

> +	void __iomem			*base;
> +	DECLARE_BITMAP(used_mask, CCACHE_PMU_MAX_COUNTERS);
> +	unsigned int			cpu;
> +	int				n_counters;
> +	struct perf_event		*events[] __counted_by(n_counters);
> +};
> +
> +#define to_ccache_pmu(p) (container_of(p, struct sifive_ccache_pmu, pmu))
> +
> +#ifndef readq
> +static inline u64 readq(void __iomem *addr)
> +{
> +	return readl(addr) | (((u64)readl(addr + 4)) << 32);
> +}
> +#endif
> +
> +#ifndef writeq
> +static inline void writeq(u64 v, void __iomem *addr)
> +{
> +	writel(lower_32_bits(v), addr);
> +	writel(upper_32_bits(v), addr + 4);
> +}
> +#endif

As Jonathan says, please include the io-64-nonatomic header of 
preference and don't reinvent these as-is. However, see later...

> +
> +/*
> + * sysfs attributes
> + *
> + * We export:
> + * - cpumask, used by perf user space and other tools to know on which CPUs to create events
> + * - events, used by perf user space and other tools to create events symbolically, e.g.:
> + *     perf stat -a -e sifive_ccache_pmu/event=inner_put_partial_data_hit/ ls
> + *     perf stat -a -e sifive_ccache_pmu/event=0x101/ ls
> + * - formats, used by perf user space and other tools to configure events
> + */
> +
> +/* cpumask */
> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sifive_ccache_pmu *ccache_pmu = dev_get_drvdata(dev);
> +
> +	if (ccache_pmu->cpu >= nr_cpu_ids)
> +		return 0;

I'm not sure it's really correct to return no data, but then this is 
impossible in the first place (if there are no online CPUs, who's 
reading the file?)

> +
> +	return sysfs_emit(buf, "%d\n", ccache_pmu->cpu);
> +};
> +
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *sifive_ccache_pmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group sifive_ccache_pmu_cpumask_group = {
> +	.attrs = sifive_ccache_pmu_cpumask_attrs,
> +};
> +
> +/* events */
> +static ssize_t sifive_ccache_pmu_event_show(struct device *dev, struct device_attribute *attr,
> +					    char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
> +}
> +
> +#define SET_EVENT_SELECT(_event, _set)	(BIT_ULL((_event) + 8) | (_set))

This seems like you really want to have distinct "set" and "event" 
fields in the config.

> +#define CCACHE_PMU_EVENT_ATTR(_name, _event, _set) \
> +	PMU_EVENT_ATTR_ID(_name, sifive_ccache_pmu_event_show, SET_EVENT_SELECT(_event, _set))
> +
> +enum ccache_pmu_event_set1 {
> +	INNER_PUT_FULL_DATA = 0,
> +	INNER_PUT_PARTIAL_DATA,
> +	INNER_ATOMIC_DATA,
> +	INNER_GET,
> +	INNER_PREFETCH_READ,
> +	INNER_PREFETCH_WRITE,
> +	INNER_ACQUIRE_BLOCK_NTOB,
> +	INNER_ACQUIRE_BLOCK_NTOT,
> +	INNER_ACQUIRE_BLOCK_BTOT,
> +	INNER_ACQUIRE_PERM_NTOT,
> +	INNER_ACQUIRE_PERM_BTOT,
> +	INNER_RELEASE_TTOB,
> +	INNER_RELEASE_TTON,
> +	INNER_RELEASE_BTON,
> +	INNER_RELEASE_DATA_TTOB,
> +	INNER_RELEASE_DATA_TTON,
> +	INNER_RELEASE_DATA_BTON,
> +	OUTER_PROBE_BLOCK_TOT,
> +	OUTER_PROBE_BLOCK_TOB,
> +	OUTER_PROBE_BLOCK_TON,
> +	CCACHE_PMU_MAX_EVENT1_IDX
> +};
> +
> +enum ccache_pmu_event_set2 {
> +	INNER_PUT_FULL_DATA_HIT = 0,
> +	INNER_PUT_PARTIAL_DATA_HIT,
> +	INNER_ATOMIC_DATA_HIT,
> +	INNER_GET_HIT,
> +	INNER_PREFETCH_HIT,
> +	INNER_ACQUIRE_BLOCK_HIT,
> +	INNER_ACQUIRE_PERM_HIT,
> +	INNER_RELEASE_HIT,
> +	INNER_RELEASE_DATA_HIT,
> +	OUTER_PROBE_HIT,
> +	INNER_PUT_FULL_DATA_HIT_SHARED,
> +	INNER_PUT_PARTIAL_DATA_HIT_SHARED,
> +	INNER_ATOMIC_DATA_HIT_SHARED,
> +	INNER_GET_HIT_SHARED,
> +	INNER_PREFETCH_HIT_SHARED,
> +	INNER_ACQUIRE_BLOCK_HIT_SHARED,
> +	INNER_ACQUIRE_PERM_HIT_SHARED,
> +	OUTER_PROBE_HIT_SHARED,
> +	OUTER_PROBE_HIT_DIRTY,
> +	CCACHE_PMU_MAX_EVENT2_IDX
> +};
> +
> +enum ccache_pmu_event_set3 {
> +	OUTER_ACQUIRE_BLOCK_NTOB_MISS = 0,
> +	OUTER_ACQUIRE_BLOCK_NTOT_MISS,
> +	OUTER_ACQUIRE_BLOCK_BTOT_MISS,
> +	OUTER_ACQUIRE_PERM_NTOT_MISS,
> +	OUTER_ACQUIRE_PERM_BTOT_MISS,
> +	OUTER_RELEASE_TTOB_EVICTION,
> +	OUTER_RELEASE_TTON_EVICTION,
> +	OUTER_RELEASE_BTON_EVICTION,
> +	OUTER_RELEASE_DATA_TTOB_NOT_APPLICABLE,
> +	OUTER_RELEASE_DATA_TTON_DIRTY_EVICTION,
> +	OUTER_RELEASE_DATA_BTON_NOT_APPLICABLE,
> +	INNER_PROBE_BLOCK_TOT_CODE_MISS_HITS_OTHER_HARTS,
> +	INNER_PROBE_BLOCK_TOB_LOAD_MISS_HITS_OTHER_HARTS,
> +	INNER_PROBE_BLOCK_TON_STORE_MISS_HITS_OTHER_HARTS,
> +	CCACHE_PMU_MAX_EVENT3_IDX
> +};
> +
> +enum ccache_pmu_event_set4 {
> +	INNER_HINT_HITS_INFLIGHT_MISS = 0,
> +	CCACHE_PMU_MAX_EVENT4_IDX
> +};
> +
> +static struct attribute *sifive_ccache_pmu_events[] = {
> +	/*  pmEventSelect1 */
> +	CCACHE_PMU_EVENT_ATTR(inner_put_full_data, INNER_PUT_FULL_DATA, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_put_partial_data, INNER_PUT_PARTIAL_DATA, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_atomic_data, INNER_ATOMIC_DATA, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_get, INNER_GET, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_prefetch_read, INNER_PREFETCH_READ, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_prefetch_write, INNER_PREFETCH_WRITE, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_acquire_block_ntob, INNER_ACQUIRE_BLOCK_NTOB, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_acquire_block_ntot, INNER_ACQUIRE_BLOCK_NTOT, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_acquire_block_btot, INNER_ACQUIRE_BLOCK_BTOT, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_acquire_perm_ntot, INNER_ACQUIRE_PERM_NTOT, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_acquire_perm_btot, INNER_ACQUIRE_PERM_BTOT, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_release_ttob, INNER_RELEASE_TTOB, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_release_tton, INNER_RELEASE_TTON, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_release_bton, INNER_RELEASE_BTON, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_release_data_ttob, INNER_RELEASE_DATA_TTOB, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_release_data_tton, INNER_RELEASE_DATA_TTON, 1),
> +	CCACHE_PMU_EVENT_ATTR(inner_release_data_bton, INNER_RELEASE_DATA_BTON, 1),
> +	CCACHE_PMU_EVENT_ATTR(outer_probe_block_tot, OUTER_PROBE_BLOCK_TOT, 1),
> +	CCACHE_PMU_EVENT_ATTR(outer_probe_block_tob, OUTER_PROBE_BLOCK_TOB, 1),
> +	CCACHE_PMU_EVENT_ATTR(outer_probe_block_ton, OUTER_PROBE_BLOCK_TON, 1),

Yuck, those enums not only make the code overly verbose and repetitive, 
but they completely obfuscate the significant information here. I don't 
personally care enough to go digging for documentation to review whether 
the event numbers are correct for the event names they claim to be, but 
anyone who did wish to do that is clearly in for an unnecessarily hard 
time :(

> +
> +	/*  pmEventSelect2 */
> +	CCACHE_PMU_EVENT_ATTR(inner_put_full_data_hit, INNER_PUT_FULL_DATA_HIT, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_put_partial_data_hit, INNER_PUT_PARTIAL_DATA_HIT, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_atomic_data_hit, INNER_ATOMIC_DATA_HIT, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_get_hit, INNER_GET_HIT, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_prefetch_hit, INNER_PREFETCH_HIT, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_acquire_block_hit, INNER_ACQUIRE_BLOCK_HIT, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_acquire_perm_hit, INNER_ACQUIRE_PERM_HIT, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_release_hit, INNER_RELEASE_HIT, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_release_data_hit, INNER_RELEASE_DATA_HIT, 2),
> +	CCACHE_PMU_EVENT_ATTR(outer_probe_hit, OUTER_PROBE_HIT, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_put_full_data_hit_shared, INNER_PUT_FULL_DATA_HIT_SHARED, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_put_partial_data_hit_shared,
> +			      INNER_PUT_PARTIAL_DATA_HIT_SHARED, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_atomic_data_hit_shared, INNER_ATOMIC_DATA_HIT_SHARED, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_get_hit_shared, INNER_GET_HIT_SHARED, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_prefetch_hit_shared, INNER_PREFETCH_HIT_SHARED, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_acquire_block_hit_shared, INNER_ACQUIRE_BLOCK_HIT_SHARED, 2),
> +	CCACHE_PMU_EVENT_ATTR(inner_acquire_perm_hit_shared, INNER_ACQUIRE_PERM_HIT_SHARED, 2),
> +	CCACHE_PMU_EVENT_ATTR(outer_probe_hit_shared, OUTER_PROBE_HIT_SHARED, 2),
> +	CCACHE_PMU_EVENT_ATTR(outer_probe_hit_dirty, OUTER_PROBE_HIT_DIRTY, 2),
> +
> +	/*  pmEventSelect3 */
> +	CCACHE_PMU_EVENT_ATTR(outer_acquire_block_ntob_miss, OUTER_ACQUIRE_BLOCK_NTOB_MISS, 3),
> +	CCACHE_PMU_EVENT_ATTR(outer_acquire_block_ntot_miss, OUTER_ACQUIRE_BLOCK_NTOT_MISS, 3),
> +	CCACHE_PMU_EVENT_ATTR(outer_acquire_block_btot_miss, OUTER_ACQUIRE_BLOCK_BTOT_MISS, 3),
> +	CCACHE_PMU_EVENT_ATTR(outer_acquire_perm_ntot_miss, OUTER_ACQUIRE_PERM_NTOT_MISS, 3),
> +	CCACHE_PMU_EVENT_ATTR(outer_acquire_perm_btot_miss, OUTER_ACQUIRE_PERM_BTOT_MISS, 3),
> +	CCACHE_PMU_EVENT_ATTR(outer_release_ttob_eviction, OUTER_RELEASE_TTOB_EVICTION, 3),
> +	CCACHE_PMU_EVENT_ATTR(outer_release_tton_eviction, OUTER_RELEASE_TTON_EVICTION, 3),
> +	CCACHE_PMU_EVENT_ATTR(outer_release_bton_eviction, OUTER_RELEASE_BTON_EVICTION, 3),
> +	CCACHE_PMU_EVENT_ATTR(outer_release_data_ttob_not_applicable,
> +			      OUTER_RELEASE_DATA_TTOB_NOT_APPLICABLE, 3),
> +	CCACHE_PMU_EVENT_ATTR(outer_release_data_tton_dirty_eviction,
> +			      OUTER_RELEASE_DATA_TTON_DIRTY_EVICTION, 3),
> +	CCACHE_PMU_EVENT_ATTR(outer_release_data_bton_not_applicable,
> +			      OUTER_RELEASE_DATA_BTON_NOT_APPLICABLE, 3),
> +	CCACHE_PMU_EVENT_ATTR(inner_probe_block_tot_code_miss_hits_other_harts,
> +			      INNER_PROBE_BLOCK_TOT_CODE_MISS_HITS_OTHER_HARTS, 3),
> +	CCACHE_PMU_EVENT_ATTR(inner_probe_block_tob_load_miss_hits_other_harts,
> +			      INNER_PROBE_BLOCK_TOB_LOAD_MISS_HITS_OTHER_HARTS, 3),
> +	CCACHE_PMU_EVENT_ATTR(inner_probe_block_ton_store_miss_hits_other_harts,
> +			      INNER_PROBE_BLOCK_TON_STORE_MISS_HITS_OTHER_HARTS, 3),
> +
> +	/*  pm_event_select4 */
> +	CCACHE_PMU_EVENT_ATTR(inner_hint_hits_inflight_miss, INNER_HINT_HITS_INFLIGHT_MISS, 4),
> +	NULL
> +};
> +
> +static struct attribute_group sifive_ccache_pmu_events_group = {
> +	.name = "events",
> +	.attrs = sifive_ccache_pmu_events,
> +};
> +
> +/* formats */
> +PMU_FORMAT_ATTR(event, "config:0-63");
> +
> +static struct attribute *sifive_ccache_pmu_formats[] = {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group sifive_ccache_pmu_format_group = {
> +	.name = "format",
> +	.attrs = sifive_ccache_pmu_formats,
> +};
> +
> +/*
> + * Per PMU device attribute groups
> + */
> +
> +static const struct attribute_group *sifive_ccache_pmu_attr_grps[] = {
> +	&sifive_ccache_pmu_cpumask_group,
> +	&sifive_ccache_pmu_events_group,
> +	&sifive_ccache_pmu_format_group,
> +	NULL,
> +};
> +
> +/*
> + * Event Initialization
> + */
> +
> +static int sifive_ccache_pmu_event_init(struct perf_event *event)
> +{
> +	struct sifive_ccache_pmu *ccache_pmu = to_ccache_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 config = event->attr.config;
> +	u64 ev_type = config >> 8;
> +	u64 set = config & 0xff;
> +

I have some patches in progress trying to improve the situation, but for 
now you still must check that the event is actually for your PMU before 
doing anything else, and return -ENOENT if not, otherwise you may be 
offered raw or hardware events, misinterpret them, and confuse the user 
with nonsense counts from the wrong PMU.

> +	/* Check if this is a valid set and event */
> +	switch (set) {
> +	case 1:
> +		if (ev_type >= BIT_ULL(CCACHE_PMU_MAX_EVENT1_IDX))
> +			return -ENOENT;

Conversely if the event *is* yours, then you must not return -ENOENT for 
any other error - these look like they would all probably be -EINVAL 
conditions (see the comments in the definition of struct pmu).

> +		break;
> +	case 2:
> +		if (ev_type >= BIT_ULL(CCACHE_PMU_MAX_EVENT2_IDX))
> +			return -ENOENT;
> +		break;
> +	case 3:
> +		if (ev_type >= BIT_ULL(CCACHE_PMU_MAX_EVENT3_IDX))
> +			return -ENOENT;
> +		break;
> +	case 4:
> +		if (ev_type >= BIT_ULL(CCACHE_PMU_MAX_EVENT4_IDX))
> +			return -ENOENT;
> +		break;
> +	default:
> +		return -ENOENT;
> +	}

There's also the matter of validating event groups - if you can't 
support them at all that should mean simply rejecting any event grouped 
with any other non-software event.

> +	/* Do not allocate the hardware counter yet */
> +	hwc->idx = -1;
> +	hwc->config = config;
> +
> +	event->cpu = ccache_pmu->cpu;
> +
> +	return 0;
> +}
> +
> +/*
> + * pmu->read: read and update the counter
> + */
> +static void sifive_ccache_pmu_read(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 prev_raw_count, new_raw_count;
> +	u64 oldval;
> +
> +	do {
> +		prev_raw_count = local64_read(&hwc->prev_count);
> +		new_raw_count = readq((void *)hwc->event_base);

The 32-bit non-atomic version could read a torn value here, thus give an 
apparent large jump backwards in the count. If the 32-bit support is 
entirely nominal for build-testing then that's probably OK (possibly 
worth a comment here), but if it's expected to actually be used then I 
think you want an explicit hi-lo-hi sequence in teh 32-bit case to 
ensure the value is read correctly.

> +
> +		oldval = local64_cmpxchg(&hwc->prev_count, prev_raw_count, new_raw_count);
> +	} while (oldval != prev_raw_count);

If you don't have an overflow interrupt and don't expect to ever have 
one (not entirely unreasonable if counters are always a full 64 bits), 
then strictly you shouldn't need the cmpxchg loop, however there is 
certainly still a consistency argument for sticking to the familiar 
pattern anyway if it's not getting in the way.

> +
> +	local64_add(new_raw_count - prev_raw_count, &event->count);
> +}
> +
> +/*
> + * State transition functions:
> + *
> + * start()/stop() & add()/del()
> + */
> +
> +/*
> + * pmu->start: start the event
> + */
> +static void sifive_ccache_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED))) > +		return;
> +
> +	hwc->state = 0;
> +
> +	/* Set initial value to 0 */
> +	local64_set(&hwc->prev_count, 0);
> +	writeq(0, (void *)hwc->event_base);
> +
> +	/* Enable this counter to count events */
> +	writeq(hwc->config, (void *)hwc->config_base);
> +}
> +
> +/*
> + * pmu->stop: stop the counter
> + */
> +static void sifive_ccache_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return;
> +
> +	/* Disable this counter to count events */
> +	writeq(0, (void *)hwc->config_base);
> +	sifive_ccache_pmu_read(event);
> +
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +/*
> + * pmu->add: add the event to the PMU
> + */
> +static int sifive_ccache_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct sifive_ccache_pmu *ccache_pmu = to_ccache_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +
> +	/* Find an available counter idx to use for this event */
> +	do {
> +		idx = find_first_zero_bit(ccache_pmu->used_mask, ccache_pmu->n_counters);
> +		if (idx >= ccache_pmu->n_counters)
> +			return -EAGAIN;
> +	} while (test_and_set_bit(idx, ccache_pmu->used_mask));

FWIW I continue to maintain the opinion that faffing around with bitmaps 
is more costly than simply scanning for an empty slot in the events 
array that you still have to touch anyway.

> +
> +	hwc->config_base = (unsigned long)ccache_pmu->base + CCACHE_SELECT_OFFSET + 8 * idx;
> +	hwc->event_base = (unsigned long)ccache_pmu->base + CCACHE_COUNTER_OFFSET + 8 * idx;
> +	hwc->idx = idx;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	ccache_pmu->events[idx] = event;
> +
> +	if (flags & PERF_EF_START)
> +		sifive_ccache_pmu_start(event, PERF_EF_RELOAD);
> +
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
> +/*
> + * pmu->del: delete the event from the PMU
> + */
> +static void sifive_ccache_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct sifive_ccache_pmu *ccache_pmu = to_ccache_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	/* Stop and release this counter */
> +	sifive_ccache_pmu_stop(event, PERF_EF_UPDATE);
> +
> +	ccache_pmu->events[idx] = NULL;
> +	clear_bit(idx, ccache_pmu->used_mask);
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +/*
> + * Driver initialization
> + */
> +
> +static void sifive_ccache_pmu_hw_init(const struct sifive_ccache_pmu *ccache_pmu)
> +{
> +	/* Disable the client filter (not supported by this driver) */

Note that if filtering is something you may want to add support for in 
future, it's well worth planning ahead in terms of config fields to 
avoid churning the user API too much later.

> +	writeq(0, ccache_pmu->base + CCACHE_CLIENT_FILTER_OFFSET);
> +}
> +
> +static int sifive_ccache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct sifive_ccache_pmu *ccache_pmu =
> +		hlist_entry_safe(node, struct sifive_ccache_pmu, node);
> +
> +	if (ccache_pmu->cpu >= nr_cpu_ids)
> +		ccache_pmu->cpu = cpu;

If you don't have any NUMA of other affinity-related shenangians to 
worry about, then it's really not worth bothering with an online 
callback, just assign a CPU directly at the same point as all the other 
initialisation. Plus it's then also that much clearer to reason about it 
always being valid and not needing spurious nr_cpu_ids checks.

> +
> +	return 0;
> +}
> +
> +static int sifive_ccache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct sifive_ccache_pmu *ccache_pmu =
> +		hlist_entry_safe(node, struct sifive_ccache_pmu, node);
> +
> +	/* Do nothing if this CPU does not own the events */
> +	if (cpu != ccache_pmu->cpu)
> +		return 0;
> +
> +	/* Pick a random online CPU */
> +	ccache_pmu->cpu = cpumask_any_but(cpu_online_mask, cpu);
> +	if (ccache_pmu->cpu >= nr_cpu_ids)
> +		return 0;
> +
> +	/* Migrate PMU events from this CPU to the target CPU */
> +	perf_pmu_migrate_context(&ccache_pmu->pmu, cpu, ccache_pmu->cpu);
> +
> +	return 0;
> +}
> +
> +static int sifive_ccache_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sifive_ccache_pmu *ccache_pmu;
> +	u32 n_counters;
> +	int ret;
> +
> +	/* Instances without a sifive,perfmon-counters property do not contain a PMU */
> +	ret = device_property_read_u32(dev, "sifive,perfmon-counters", &n_counters);
> +	if (ret || !n_counters)

Even simpler is to just initialise n_counters to 0 in the first place, 
if the return value doesn't matter beyond "did it work or not?"

> +		return -ENODEV;
> +
> +	ccache_pmu = devm_kzalloc(dev, struct_size(ccache_pmu, events, n_counters), GFP_KERNEL);

Maybe worth a sanity check that n_counters isn't unrealistically large 
either?

> +	if (!ccache_pmu)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ccache_pmu);
> +
> +	ccache_pmu->pmu = (struct pmu) {
> +		.parent		= dev,
> +		.attr_groups	= sifive_ccache_pmu_attr_grps,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= sifive_ccache_pmu_event_init,
> +		.add		= sifive_ccache_pmu_add,
> +		.del		= sifive_ccache_pmu_del,
> +		.start		= sifive_ccache_pmu_start,
> +		.stop		= sifive_ccache_pmu_stop,
> +		.read		= sifive_ccache_pmu_read,
> +	};
> +	ccache_pmu->cpu = nr_cpu_ids;
> +	ccache_pmu->n_counters = n_counters;
> +
> +	ccache_pmu->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ccache_pmu->base))
> +		return PTR_ERR(ccache_pmu->base);
> +
> +	sifive_ccache_pmu_hw_init(ccache_pmu);
> +
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE, &ccache_pmu->node);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add CPU hotplug instance\n");
> +
> +	ret = perf_pmu_register(&ccache_pmu->pmu, "sifive_ccache_pmu", -1);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register PMU\n");
> +		goto err_remove_instance;
> +	}
> +
> +	return 0;
> +
> +err_remove_instance:
> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE, &ccache_pmu->node);

You need the _nocalls variant here, since attempting to migrate the 
context of an unregistered and uninitialised PMU tends to end badly.

> +
> +	return ret;
> +}
> +
> +static void sifive_ccache_pmu_remove(struct platform_device *pdev)
> +{
> +	struct sifive_ccache_pmu *ccache_pmu = platform_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&ccache_pmu->pmu);
> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE, &ccache_pmu->node);

Similarly here.


 From a quick skim I think a lot of these comments will also apply to 
the other drivers in this series, so I'll stop here for now, and please 
consider them in general.

Thanks,
Robin.

> +}
> +
> +static const struct of_device_id sifive_ccache_pmu_of_match[] = {
> +	{ .compatible = "sifive,ccache0" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sifive_ccache_pmu_of_match);
> +
> +static struct platform_driver sifive_ccache_pmu_driver = {
> +	.probe	= sifive_ccache_pmu_probe,
> +	.remove_new	= sifive_ccache_pmu_remove,
> +	.driver	= {
> +		.name		= "sifive_ccache_pmu",
> +		.of_match_table	= sifive_ccache_pmu_of_match,
> +	},
> +};
> +
> +static void __exit sifive_ccache_pmu_exit(void)
> +{
> +	platform_driver_unregister(&sifive_ccache_pmu_driver);
> +	cpuhp_remove_multi_state(CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE);
> +}
> +module_exit(sifive_ccache_pmu_exit);
> +
> +static int __init sifive_ccache_pmu_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE,
> +				      "perf/sifive/ccache:online",
> +				      sifive_ccache_pmu_online_cpu,
> +				      sifive_ccache_pmu_offline_cpu);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&sifive_ccache_pmu_driver);
> +	if (ret)
> +		goto err_remove_state;
> +
> +	return 0;
> +
> +err_remove_state:
> +	cpuhp_remove_multi_state(CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE);
> +
> +	return ret;
> +}
> +module_init(sifive_ccache_pmu_init);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 172d0a743e5d..be6361fdc8ba 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -230,6 +230,7 @@ enum cpuhp_state {
>   	CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE,
>   	CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
>   	CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
> +	CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE,
>   	CPUHP_AP_PERF_CSKY_ONLINE,
>   	CPUHP_AP_WATCHDOG_ONLINE,
>   	CPUHP_AP_WORKQUEUE_ONLINE,

