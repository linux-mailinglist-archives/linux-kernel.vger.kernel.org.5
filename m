Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775BA7FD4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjK2LDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjK2LDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:03:05 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29F295;
        Wed, 29 Nov 2023 03:03:10 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SgGbd2SXHz6K94L;
        Wed, 29 Nov 2023 19:01:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 3114D140F33;
        Wed, 29 Nov 2023 19:02:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 Nov
 2023 11:02:39 +0000
Date:   Wed, 29 Nov 2023 11:02:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] perf: starfive: Add StarLink PMU support
Message-ID: <20231129110238.000060f7@Huawei.com>
In-Reply-To: <20231116162330.1144983-2-jisheng.teoh@starfivetech.com>
References: <20231116162330.1144983-1-jisheng.teoh@starfivetech.com>
        <20231116162330.1144983-2-jisheng.teoh@starfivetech.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 00:23:29 +0800
Ji Sheng Teoh <jisheng.teoh@starfivetech.com> wrote:

> This patch adds support for StarFive's StarLink PMU (Performance
> Monitor Unit). StarLink PMU integrates one or more CPU cores with
> a shared L3 memory system. The PMU supports overflow interrupt,
> up to 16 programmable 64bit event counters, and an independent
> 64bit cycle counter. StarLink PMU is accessed via MMIO.
> 
> Example Perf stat output:
> [root@user]# perf stat -a -e /starfive_starlink_pmu/cycles/ \
> 	-e /starfive_starlink_pmu/read_miss/ \
> 	-e /starfive_starlink_pmu/read_hit/ \
> 	-e /starfive_starlink_pmu/release_request/  \
> 	-e /starfive_starlink_pmu/write_hit/ \
> 	-e /starfive_starlink_pmu/write_miss/ \
> 	-e /starfive_starlink_pmu/write_request/ \
> 	-e /starfive_starlink_pmu/writeback/ \
> 	-e /starfive_starlink_pmu/read_request/ \
> 	-- openssl speed rsa2048
> Doing 2048 bits private rsa's for 10s: 5 2048 bits private RSA's in
> 2.84s
> Doing 2048 bits public rsa's for 10s: 169 2048 bits public RSA's in
> 2.42s
> version: 3.0.11
> built on: Tue Sep 19 13:02:31 2023 UTC
> options: bn(64,64)
> CPUINFO: N/A
>                   sign    verify    sign/s verify/s
> rsa 2048 bits 0.568000s 0.014320s      1.8     69.8
> /////////
>  Performance counter stats for 'system wide':
> 
>          649991998      starfive_starlink_pmu/cycles/
>            1009690      starfive_starlink_pmu/read_miss/
>            1079750      starfive_starlink_pmu/read_hit/
>            2089405      starfive_starlink_pmu/release_request/
>                129      starfive_starlink_pmu/write_hit/
>                 70      starfive_starlink_pmu/write_miss/
>                194      starfive_starlink_pmu/write_request/
>             150080      starfive_starlink_pmu/writeback/
>            2089423      starfive_starlink_pmu/read_request/
> 
>       27.062755678 seconds time elapsed
> 
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Hi. Some drive by comments inline.

Mostly concern being consistent with error handling.

Documentation needed.
Documentation/admin-guide/perf

Note I've not looked at perf state machine as would need to remind myself
how that stuff works.  So this is all generic driver handling stuff rather
than perf specific.

Thanks,

Jonathan

> ---
> diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
> new file mode 100644
> index 000000000000..272896ab1ade
> --- /dev/null
> +++ b/drivers/perf/starfive_starlink_pmu.c
> @@ -0,0 +1,654 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * StarFive's StarLink PMU driver
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> + *
> + */
> +
> +#define STARLINK_PMU_PDEV_NAME	"starfive_starlink_pmu"
> +#define pr_fmt(fmt)	STARLINK_PMU_PDEV_NAME ": " fmt
> +
> +#include <linux/bitmap.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

Why?  Probably want mod_devicetable.h

> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysfs.h>
> +
> +#define STARLINK_PMU_MAX_COUNTERS			64
> +#define STARLINK_PMU_NUM_COUNTERS			16
> +#define STARLINK_PMU_IDX_CYCLE_COUNTER			63
> +
> +#define STARLINK_PMU_EVENT_SELECT			0x060
> +#define STARLINK_PMU_EVENT_COUNTER			0x160
> +#define STARLINK_PMU_COUNTER_MASK			GENMASK_ULL(63, 0)
> +#define STARLINK_PMU_CYCLE_COUNTER			0x058
> +
> +#define STARLINK_PMU_CONTROL				0x040
> +#define STARLINK_PMU_GLOBAL_ENABLE			BIT(0)
> +
> +#define STARLINK_PMU_INTERRUPT_ENABLE			0x050
> +#define STARLINK_PMU_COUNTER_OVERFLOW_STATUS		0x048
> +#define STARLINK_PMU_CYCLE_OVERFLOW_MASK		BIT(63)
> +
> +#define CYCLES					0x058

Prefix these.  Highly likely to have namespace clashes.
	STARLINK_CYCLES etc

> +#define CACHE_READ_REQUEST			0x04000701
> +#define CACHE_WRITE_REQUEST			0x03000001
> +#define CACHE_RELEASE_REQUEST			0x0003e001
> +#define CACHE_READ_HIT				0x00901202
> +#define CACHE_READ_MISS				0x04008002
> +#define CACHE_WRITE_HIT				0x006c0002
> +#define CACHE_WRITE_MISS			0x03000002
> +#define CACHE_WRITEBACK				0x00000403
> +
> +#define to_starlink_pmu(p) (container_of(p, struct starlink_pmu, pmu))
> +
> +#define STARLINK_FORMAT_ATTR(_name, _config)				      \
> +	(&((struct dev_ext_attribute[]) {				      \
> +		{ .attr = __ATTR(_name, 0444, starlink_pmu_sysfs_format_show, NULL), \
> +		  .var = (void *)_config, }				      \
> +	})[0].attr.attr)
> +
> +#define STARLINK_EVENT_ATTR(_name, _id)					     \
> +	PMU_EVENT_ATTR_ID(_name, starlink_pmu_sysfs_event_show, _id)
> +
> +#define BIT_IS_SET(nr, bit) (((nr) >> (bit)) & 0x1)

Not sure this macro is worth having.  Mostly used as boolean, so
nr & BIT(bit) inline would do the job.

> +
> +struct starlink_hw_events {
> +	struct perf_event	*events[STARLINK_PMU_MAX_COUNTERS];
> +	DECLARE_BITMAP(used_mask, STARLINK_PMU_MAX_COUNTERS);
> +};
> +
> +struct starlink_pmu {
> +	struct pmu					pmu;
> +	struct starlink_hw_events			__percpu *hw_events;
> +	struct hlist_node				node;
> +	struct notifier_block				starlink_pmu_pm_nb;
> +	void __iomem					*pmu_base;
> +	cpumask_t					cpumask;
> +	int						irq;
> +};
> +
> +/* Formats Attr */
> +static ssize_t
> +starlink_pmu_sysfs_format_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct dev_ext_attribute *eattr = container_of(attr,
> +						       struct dev_ext_attribute, attr);
> +
> +	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
> +}
> +
> +static struct attribute *starlink_pmu_format_attrs[] = {
> +	STARLINK_FORMAT_ATTR(event, "config:0-31"),
> +	NULL,
As below.

> +};
> +
> +static const struct attribute_group starlink_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = starlink_pmu_format_attrs,
> +};
> +
> +/* Events Attr */

These comments don't really add much given that's easy to see from code.
It's rare that 'structure' comments describing where things are in code
are actually useful in kernel drivers.  They tend to be there in example
code to indicate what is needed, but don't keep them!


> +static ssize_t
> +starlink_pmu_sysfs_event_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct perf_pmu_events_attr *eattr = container_of(attr,
> +							  struct perf_pmu_events_attr, attr);
> +
> +	return sysfs_emit(buf, "event=0x%02llx\n", eattr->id);
> +}
> +
> +static struct attribute *starlink_pmu_event_attrs[] = {
> +	STARLINK_EVENT_ATTR(cycles, CYCLES),
> +	STARLINK_EVENT_ATTR(read_request, CACHE_READ_REQUEST),
> +	STARLINK_EVENT_ATTR(write_request, CACHE_WRITE_REQUEST),
> +	STARLINK_EVENT_ATTR(release_request, CACHE_RELEASE_REQUEST),
> +	STARLINK_EVENT_ATTR(read_hit, CACHE_READ_HIT),
> +	STARLINK_EVENT_ATTR(read_miss, CACHE_READ_MISS),
> +	STARLINK_EVENT_ATTR(write_hit, CACHE_WRITE_HIT),
> +	STARLINK_EVENT_ATTR(write_miss, CACHE_WRITE_MISS),
> +	STARLINK_EVENT_ATTR(writeback, CACHE_WRITEBACK),
> +	NULL,

As below.

> +};
> +
> +static const struct attribute_group starlink_pmu_events_attr_group = {
> +	.name = "events",
> +	.attrs = starlink_pmu_event_attrs,
> +};
> +
> +/* Cpumask Attr */
> +static ssize_t
> +cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct starlink_pmu *starlink_pmu = to_starlink_pmu(dev_get_drvdata(dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, &starlink_pmu->cpumask);
> +}
> +
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *starlink_pmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL,

As below.

> +};
> +
> +static const struct attribute_group starlink_pmu_cpumask_attr_group = {
> +	.attrs = starlink_pmu_cpumask_attrs,
> +};
> +
> +static const struct attribute_group *starlink_pmu_attr_groups[] = {
> +	&starlink_pmu_format_attr_group,
> +	&starlink_pmu_events_attr_group,
> +	&starlink_pmu_cpumask_attr_group,
> +	NULL,

No comma after NULL terminator as we can't add anything there anyway.

> +};


> +
> +static void starlink_pmu_counter_stop(struct perf_event *event,
> +				      struct starlink_pmu *starlink_pmu)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = event->hw.idx;
> +	u64 val;
> +
> +	/* Stop counter */

Pretty obvious that clearing global enable stops the counter.
Perhaps review comments and remove any that are obvious from the code.
Such comments add little value and can be a maintenance problem.

> +	val = readq(starlink_pmu->pmu_base + STARLINK_PMU_CONTROL);
> +	val &= ~STARLINK_PMU_GLOBAL_ENABLE;
> +	writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_CONTROL);
> +
> +	/* Disable counter overflow interrupt */
> +	val = readq(starlink_pmu->pmu_base + STARLINK_PMU_INTERRUPT_ENABLE);
> +	if (hwc->config == CYCLES)
> +		val &= ~STARLINK_PMU_CYCLE_OVERFLOW_MASK;
> +	else
> +		val &= ~(1 << idx);
> +
> +	writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_INTERRUPT_ENABLE);
> +}



> +static bool starlink_pmu_validate_event_group(struct perf_event *event)
> +{
> +	struct perf_event *leader = event->group_leader;
> +	struct perf_event *sibling;
> +	int counter = 1;
> +
> +	/*
> +	 * Ensure hardware events in the group are on the same PMU,
> +	 * software events are acceptable.
> +	 */
> +	if (event->group_leader->pmu != event->pmu &&
> +	    !is_software_event(event->group_leader))
> +		return false;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (sibling->pmu != event->pmu && !is_software_event(sibling))
> +			return false;
> +
> +		counter += 1;

counter++;

> +	}
> +	/*
> +	 * Limit the number of requested counter to
> +	 * counter available on the HW.
> +	 */
> +	return counter <= STARLINK_PMU_NUM_COUNTERS;
> +}
> +

...

> +
> +static irqreturn_t starlink_pmu_handle_irq(int irq_num, void *data)
> +{
> +	struct starlink_pmu *starlink_pmu = data;
> +	struct starlink_hw_events *hw_events =
> +					this_cpu_ptr(starlink_pmu->hw_events);

Odd alignment.  I'd put it one tab more than struct.

> +	bool handled = false;
> +	int idx;
> +	u64 overflow_status;
> +
> +	for (idx = 0; idx < STARLINK_PMU_MAX_COUNTERS; idx++) {
> +		struct perf_event *event = hw_events->events[idx];
> +
> +		overflow_status = readq(starlink_pmu->pmu_base +
> +					STARLINK_PMU_COUNTER_OVERFLOW_STATUS);
> +		if (!BIT_IS_SET(overflow_status, idx))
> +			continue;
> +
> +		/* Clear event counter overflow interrupt */
> +		writeq(1 << idx, starlink_pmu->pmu_base +
> +		       STARLINK_PMU_COUNTER_OVERFLOW_STATUS);
> +
> +		if (!event)
> +			continue;
If you get here and !event. Is it a bug, or something valid?
Maybe a comment if it's valid.  Otherwise an error print might make sense.

> +
> +		starlink_pmu_update(event);
> +		starlink_pmu_set_event_period(event);
> +		handled = true;
> +	}
> +	return IRQ_RETVAL(handled);
> +}
> +
> +static int starlink_setup_irqs(struct starlink_pmu *starlink_pmu,
> +			       struct platform_device *pdev)
> +{
> +	int ret, irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -EINVAL;
> +
> +	ret = devm_request_irq(&pdev->dev, irq, starlink_pmu_handle_irq,
> +			       0, STARLINK_PMU_PDEV_NAME, starlink_pmu);
> +	if (ret) {
> +		dev_warn(&pdev->dev, "Failed to request IRQ %d\n", irq);
> +		return ret;

		return dev_err_probe(...)

> +	}
> +
> +	starlink_pmu->irq = irq;
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_CPU_PM
> +static int starlink_pmu_pm_notify(struct notifier_block *b,
> +				  unsigned long cmd, void *v)
> +{
> +	struct starlink_pmu *starlink_pmu = container_of(b, struct starlink_pmu,
> +							 starlink_pmu_pm_nb);

Compiler can probably figure out this isn't used. But if not
if (!IS_ENABLED(CONFIG_CPU_PM))
	return 0;

will allow the compiler to definitely remove the code.

> +	struct starlink_hw_events *hw_events =
> +					this_cpu_ptr(starlink_pmu->hw_events);
> +	int enabled = bitmap_weight(hw_events->used_mask,
> +				    STARLINK_PMU_MAX_COUNTERS);
> +	struct perf_event *event;
> +	int idx;
> +
> +	if (!enabled)
> +		return NOTIFY_OK;
> +
> +	for (idx = 0; idx < STARLINK_PMU_MAX_COUNTERS; idx++) {
> +		event = hw_events->events[idx];
> +		if (!event)
> +			continue;
> +
> +		switch (cmd) {
> +		case CPU_PM_ENTER:
> +			/* Stop and update the counter */
> +			starlink_pmu_stop(event, PERF_EF_UPDATE);
> +			break;
> +		case CPU_PM_EXIT:
> +		case CPU_PM_ENTER_FAILED:
> +			/* Restore and enable the counter */
> +			starlink_pmu_start(event, PERF_EF_RELOAD);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int starlink_pmu_pm_register(struct starlink_pmu *starlink_pmu)
> +{
> +	starlink_pmu->starlink_pmu_pm_nb.notifier_call = starlink_pmu_pm_notify;
> +	return cpu_pm_register_notifier(&starlink_pmu->starlink_pmu_pm_nb);
Stubbed out as below.

> +}
> +
> +static void starlink_pmu_pm_unregister(struct starlink_pmu *starlink_pmu)
> +{
> +	cpu_pm_unregister_notifier(&starlink_pmu->starlink_pmu_pm_nb);

stubbed out in header so no need to protect with ifdef.
Compiler will probably remove it anyway.

> +}
> +#else
> +static inline int
> +starlink_pmu_pm_register(struct starlink_pmu *starlink_pmu) { return 0; }
> +static inline void
> +starlink_pmu_pm_unregister(struct starlink_pmu *starlink_pmu) { }
> +#endif
> +
> +static void starlink_pmu_destroy(struct starlink_pmu *starlink_pmu)
> +{
> +	starlink_pmu_pm_unregister(starlink_pmu);
> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARFIVE_STARLINK_ONLINE,
> +				    &starlink_pmu->node);
> +}
> +
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
> +	ret = starlink_setup_irqs(starlink_pmu, pdev);

Handle ret  You are printing a warning so I'd assume it's a failure to probe
case, not something ignored.


> +
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARFIVE_STARLINK_ONLINE,
> +				       &starlink_pmu->node);
> +	if (ret)

Not dropped in error paths.

> +		return ret;
> +
> +	ret = starlink_pmu_pm_register(starlink_pmu);
> +	if (ret)
> +		starlink_pmu_destroy(starlink_pmu);

This calls starlink_pmu_pm_unregister()
That should not be necessary as every function should be designed to have no side effects
on error return.

> +
> +	starlink_pmu->hw_events = alloc_percpu_gfp(struct starlink_hw_events,
> +						   GFP_KERNEL);
> +	if (!starlink_pmu->hw_events) {
> +		pr_info("Failed to allocate per-cpu PMU data.\n");
> +		kfree(starlink_pmu);

Inconsistent error handling.  Before and aftre this you call starlink_pmu_destroy()
but not here.

> +		return -ENOMEM;
> +	}
> +
> +	for_each_possible_cpu(cpuid) {
> +		hw_events = per_cpu_ptr(starlink_pmu->hw_events, cpuid);
> +		for (i = 0; i < STARLINK_PMU_MAX_COUNTERS; i++)
> +			hw_events->events[i] = NULL;
> +	}
> +
> +	starlink_pmu->pmu = (struct pmu) {
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= starlink_pmu_event_init,
> +		.add		= starlink_pmu_add,
> +		.del		= starlink_pmu_del,
> +		.start		= starlink_pmu_start,
> +		.stop		= starlink_pmu_stop,
> +		.read		= starlink_pmu_update,
> +		.attr_groups	= starlink_pmu_attr_groups,
> +	};
> +
> +	ret = perf_pmu_register(&starlink_pmu->pmu, STARLINK_PMU_PDEV_NAME, -1);
> +	if (ret)
> +		starlink_pmu_destroy(starlink_pmu);
> +
> +	dev_info(&pdev->dev, "Registered StarFive's StarLink PMU\n");

Noise.  Don't print to the log when there are many other ways to find this out.

> +
> +	return ret;
> +}
> +
> +static const struct of_device_id starlink_pmu_of_match[] = {
> +	{ .compatible = "starfive,jh8100-starlink-pmu", },
> +	{},

No need for comma after a 'terminator' as nothing can come after it.

> +};
> +MODULE_DEVICE_TABLE(of, starlink_pmu_of_match);

> +device_initcall(starlink_pmu_init);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index d305db70674b..6d9eb70c13d4 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -219,6 +219,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_X86_CQM_ONLINE,
>  	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
>  	CPUHP_AP_PERF_X86_IDXD_ONLINE,
> +	CPUHP_AP_PERF_RISCV_STARFIVE_STARLINK_ONLINE,
Can you use CPUHP_AP_ONLINE_DYN?

Moves it a bit later in the sequence but it often works for perf drivers.

>  	CPUHP_AP_PERF_S390_CF_ONLINE,
>  	CPUHP_AP_PERF_S390_SF_ONLINE,
>  	CPUHP_AP_PERF_ARM_CCI_ONLINE,

