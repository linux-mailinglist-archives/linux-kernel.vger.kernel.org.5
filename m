Return-Path: <linux-kernel+bounces-45961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C38843865
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6941F23967
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADC155E57;
	Wed, 31 Jan 2024 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcoTvb4t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82655C04
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687958; cv=none; b=W6HPDMaqs7UASapNOr4SFEHc6QpCNBK4Y63irrciyuTyrc5ktg7+wzhGUoRKgEvwiQIYu5GYO+w+27jcC5BkfOKppyAOmXhyljFKFWBU3mih59V6y5ANDLRfNs7zAJWulNh2vFST9L1J7YhzdYP8glpLLjOAb9bg+u3zpwa8shQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687958; c=relaxed/simple;
	bh=mh7Nq3Y7PmlFpOZjIPYfFJ5mOgb15LP4eGuEC0C2waI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSWgY9/4eon+MiSqrVCiP53IKq9bXVIrpJc1fBtaIPmA/daQe+xcNyBpWzxT+oyZeCk27HuMdxNkK8bDDV+SyABe/we6DAuwXYgeVOK4NT5YpqBQPLg54xfUKlT9FOpmNUBmKQr5LvLsrV9W8R+OhE5ScZC/V0rW6SHCnKswwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcoTvb4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66C5C433C7;
	Wed, 31 Jan 2024 07:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706687957;
	bh=mh7Nq3Y7PmlFpOZjIPYfFJ5mOgb15LP4eGuEC0C2waI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GcoTvb4tMAIBqdnYGrJ3YjtlokNXCdqQiG0zNg44FHyFUzcUwIKLyQOBTr/RZvcxE
	 CE3N+G7atr9DbIHC8x0mXQbtWvBUMaCHjwWso0Oe0zWpV8zaW38VxiPitsm0tBurZz
	 xbQUHQl2JAafWVfv6ptIjdZuHU014F3QYYliJaJmRc2wlybvEuUpKoD/LuiZ5a1yRy
	 VYc30fYD7pIhR6ZHRoYGsIkPGJ7TcBrp5kRW00FEXGcd6PK3iArzUTPCI09+xYgGJe
	 Cj5rgrv33BN94I/zP0A8Zd+frrgxM5S9gZZvUzsOD/V8389M11kwfWpNrtwZuy33vC
	 c+wYn2nU1GdWQ==
Message-ID: <deb708e5-bbaf-4510-826b-17e14e69b475@kernel.org>
Date: Wed, 31 Jan 2024 08:59:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
Content-Language: en-US
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240131070821.11477-1-jialong.yang@shingroup.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240131070821.11477-1-jialong.yang@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 08:08, JiaLong.Yang wrote:
> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
> One ni-700 can have many clock domains. Each of them has only one PMU.
> Here one PMU corresponds to one 'struct ni_pmu' instance.
> PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
> different PMU in one NI-700. If only one NI-700 found in NI-700, name will
> be ni_pmu_N.
> Node interface event name will be xxni_N_eventname, such as
> asni_0_rdreq_any. There are many kinds of type of nodes in one clock
> domain. Also means that there are many kinds of that in one PMU. So we
> distinguish them by xxni string. Besides, maybe there are many nodes
> have same type. So we have number N in event name.
> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
> Example1: perf stat -a -e ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
> 
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
> ---
> v1 --> v2:
> 1. Submit MAINTANER Documentation/ files seperately.

SEPARATE PATCHES, not patchsets. You have now checkpatch warnings
because of this...

> 2. Delete some useless info printing.
> 3. Change print from pr_xxx to dev_xxx.
> 4. Fix more than 75 length log info.
> 5. Fix dts attribute pccs-id.
> 6. Fix generic name according to DT specification.
> 7. Some indentation.
> 8. Del of_match_ptr macro.
> 
>  drivers/perf/Kconfig     |   11 +
>  drivers/perf/Makefile    |    1 +
>  drivers/perf/hx_arm_ni.c | 1284 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1296 insertions(+)
>  create mode 100644 drivers/perf/hx_arm_ni.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index ec6e0d9194a1..95ef8b13730f 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -241,4 +241,15 @@ config CXL_PMU
>  
>  	  If unsure say 'm'.
>  
> +config HX_ARM_NI_PMU
> +       tristate "HX ARM NI-700 PMU"
> +       depends on PPC_HX_C2000 && 64BIT

1. There is no PPC_HX_C2000.
2. Nothing justified dependency on 64bit. Drop or explain. Your previous
message did not provide real rationale.
3. Your indentation here is entirely mismatched. Read the coding style.

> +       default y
> +       help
> +	 Support for NI-700(Network-on-chip Interconnect) PMUs, which
> +	 provide monitoring of transactions passing through between
> +	 CMN and other buses or periapherals.
> +
> +source "drivers/perf/hisilicon/Kconfig"
> +
>  endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index a06338e3401c..ec8b9c08577d 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -27,3 +27,4 @@ obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
>  obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
>  obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
>  obj-$(CONFIG_CXL_PMU) += cxl_pmu.o
> +obj-$(CONFIG_HX_ARM_NI_PMU) += hx_arm_ni.o
> diff --git a/drivers/perf/hx_arm_ni.c b/drivers/perf/hx_arm_ni.c
> new file mode 100644
> index 000000000000..619e3b789dda
> --- /dev/null
> +++ b/drivers/perf/hx_arm_ni.c
> @@ -0,0 +1,1284 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HX ARM-NI-700 uncore PMU support
> + *
> + * This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
> + *
> + * One ni-700 can have many clock domains. Each of them has only one PMU.
> + * Here one PMU corresponds to one 'struct ni_pmu' instance.
> + *
> + * PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
> + * different PMU in one NI-700. If only one NI-700 found in NI-700, name
> + * will be ni_pmu_N.
> + *
> + * Node interface event name will be xxni_N_eventname, such as
> + * asni_0_rdreq_any. There are many kinds of type of nodes in one clock
> + * domain. Also means that there are many kinds of that in one PMU. So we
> + * distinguish them by xxni string. Besides, maybe there are many nodes
> + * have same type. So we have number N in event name.
> + * By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
> + *
> + * Example1: perf stat -a -e ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
> + * Example2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
> + *
> + * TODO: Secure or non-secure attribute in all event omitted now.
> + *
> + */
> +
> +#define dev_fmt(fmt) "ni-700 pmu: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/msi.h>
> +#include <linux/of.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/build_bug.h>
> +
> +/* number of counters in one ni pmu */
> +#define NI_PMU_COUNTER_NUM 8
> +
> +/* node type values */
> +enum ni_node_type {
> +	NI_BASE = 0x0,
> +	NI_VD,
> +	NI_PD,
> +	NI_CD,
> +	NI_ASNI = 0x4,
> +	NI_AMNI,
> +	NI_PMU,
> +	NI_HSNI,
> +	NI_HMNI,
> +	NI_PMNI = 0x9,
> +};
> +
> +/* event format */
> +/**

That's not kerneldoc.

You must test your code with W=1 build, sparse and smatch.

> + * config:
> + * 0-5    31      32-47      48-63
> + * event  cycles  node_type  node_id
> + *
> + */
> +#define NI_EVENT_FORMAT_EVENT    GENMASK_ULL(5, 0)
> +#define NI_EVENT_FORMAT_CYCLES   (1ULL << 31)
> +#define NI_EVENT_FORMAT_NODETYPE GENMASK_ULL(32 + NI_PMNI, 32)
> +#define NI_EVENT_FORMAT_ASNI     BIT(32 + NI_ASNI)
> +#define NI_EVENT_FORMAT_AMNI     BIT(32 + NI_AMNI)
> +#define NI_EVENT_FORMAT_HSNI     BIT(32 + NI_HSNI)
> +#define NI_EVENT_FORMAT_HMNI     BIT(32 + NI_HMNI)
> +#define NI_EVENT_FORMAT_PMNI     BIT(32 + NI_PMNI)
> +#define NI_EVENT_FORMAT_NODEID   GENMASK_ULL(63, 48)
> +

..

> +
> +static ssize_t ni_event_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct ni_event_attr *eattr;
> +
> +	eattr = to_ni_event_attr(attr);
> +
> +	if (eattr->ev_desc)
> +		return sysfs_emit(buf,
> +				  "%s,id=0x%x,event=0x%llx\n",
> +				  ni_node_name[eattr->node->type],
> +				  eattr->node->id,
> +				  eattr->ev_desc->eventid);
> +
> +	return sysfs_emit(buf, "cycles\n");
> +}
> +
> +struct ni_format_attr {
> +	struct device_attribute attr;
> +	u64 field;
> +};

Declarations go to the top of the file.

> +

..

> +
> +static bool is_event_supported(u64 eventid, enum ni_node_type type)
> +{
> +	int num;
> +	int idx;
> +	struct ni_event_desc **descs;
> +
> +	num = ni_ev_desc_array_size(type, &descs);
> +
> +	for (idx = 0; idx < num; idx++)
> +		if (eventid == descs[idx]->eventid)
> +			break;
> +
> +	return idx == num ? false : true;
> +}
> +
> +static enum ni_node_type ni_event_config_nodetype(u64 config)
> +{
> +	u64 nodetype = _ni_event_config_nodetype(config);
> +	unsigned long lo = __ffs(nodetype), hi = __fls(nodetype);
> +
> +	if (!nodetype || lo != hi)
> +		return 0;
> +
> +	return lo;
> +

Redundant blank line. Clean it up from the code.

> +}
> +

..

> +
> +static irqreturn_t ni_pmu_handle_irq(int irq_num, void *data)
> +{
> +	struct ni_pmu *ni_pmu = data;
> +	int idx, ret = IRQ_NONE;
> +
> +	if (ni_pmu->ni->irq_num != 1)
> +		return _ni_pmu_handle_irq(ni_pmu);
> +
> +	for (idx = 0; idx < ni_pmu->ni->pmu_num; idx++)
> +		ret |= _ni_pmu_handle_irq(ni_pmu->ni->ni_pmus[idx]);
> +
> +	return ret;
> +}
> +
> +static int ni_hp_state;

Drop. No file-scope variables. And for 100% no file scope variables
hidden in the middle of something else.

> +static int ni_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct global_ni *ni;
> +	unsigned int target;
> +	int idx;
> +
> +
> +	ni = hlist_entry_safe(node, struct global_ni, node);
> +	if (cpu != ni->on_cpu)
> +		return 0;
> +
> +
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +
> +	for (idx = 0; idx < ni->pmu_num; idx++) {
> +		perf_pmu_migrate_context(&ni->ni_pmus[idx]->pmu, cpu, target);
> +#ifndef CONFIG_PPC_HX_C2000

Drop, it does not exist.

> +		WARN_ON(irq_set_affinity(ni->ni_pmus[idx]->irq, cpumask_of(target)));
> +#endif
> +	}
> +
> +	ni->on_cpu = target;
> +
> +	return 0;
> +}
> +
> +static u32 ni_child_number_total(void __iomem *periphbase,
> +				 void __iomem *from, enum ni_node_type type)
> +{
> +	enum ni_node_type node_type;
> +	int total, idx;
> +	void __iomem *child_base;
> +
> +	node_type = ni_node_type(from);
> +
> +	if (node_type == type)
> +		return 1;
> +
> +	if (node_type >= NI_ASNI)
> +		return 0;
> +
> +	total = 0;
> +	for (idx = 0; idx < ni_child_number(from); idx++) {
> +		child_base = ni_child_pointer(periphbase, from, idx);
> +		total += ni_child_number_total(periphbase, child_base, type);
> +	}
> +
> +	return total;
> +}
> +
> +static void ni_pmu_reset(struct ni_pmu *ni_pmu)
> +{
> +	ni_pmu_disable(&ni_pmu->pmu);
> +
> +#define clear_reg(name) \
> +	writel(readl(ni_pmu_offset(ni_pmu, name)), ni_pmu_offset(ni_pmu, name))
> +
> +	clear_reg(pmcntenclr);
> +	clear_reg(pmintenclr);
> +	clear_reg(pmovsclr);
> +
> +	writel_relaxed(NI_PMU_PMCR_RST_CYC_CNTR & NI_PMU_PMCR_RST_EV_CNTR,
> +		       ni_pmu_offset(ni_pmu, pmcr));
> +}
> +
> +static int ni_pmu_irq_setup(struct ni_pmu *ni_pmu, int irq_idx)
> +{
> +	int err;
> +	unsigned long flags = IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD;
> +
> +	ni_pmu->irq = platform_get_irq(to_platform_device(ni_pmu->dev), irq_idx);
> +	if (ni_pmu->irq < 0)
> +		return ni_pmu->irq;
> +
> +	err = devm_request_irq(ni_pmu->dev, ni_pmu->irq, ni_pmu_handle_irq,
> +			       flags, dev_name(ni_pmu->dev), ni_pmu);
> +	if (err)
> +		return err;
> +
> +#ifndef CONFIG_PPC_HX_C2000

Drop, it does not exist.

> +	err = irq_set_affinity(ni_pmu->irq, cpumask_of(ni_pmu->ni->on_cpu));
> +	if (err)
> +		return err;
> +#endif
> +
> +	return 0;
> +}

..

> +static int ni_discovery(struct global_ni *ni)
> +{
> +	u32 vd_idx, pd_idx, cd_idx, nd_idx, num_idx = 0;
> +	void __iomem *vd, *pd, *cd, *nd, **cd_arrays;
> +	int num;
> +	struct ni_pmu *ni_pmu;
> +	struct ni_node node;
> +	void __iomem *pbase;
> +	struct device *dev = ni->dev;
> +
> +	pbase = ni->base;
> +
> +	cd_arrays = devm_kmalloc(dev, ni->cd_num * sizeof(typeof(cd)), GFP_KERNEL);
> +
> +	/* Step1: Get all clock domains. */
> +	for (vd_idx = 0; vd_idx < ni_child_number(ni->base); vd_idx++) {
> +		vd = ni_child_pointer(pbase, ni->base, vd_idx);
> +
> +		for (pd_idx = 0; pd_idx < ni_child_number(vd); pd_idx++) {
> +			pd = ni_child_pointer(pbase, vd, pd_idx);
> +
> +			dev_dbg(dev, "The %dth power domain has %d clock domain",
> +				pd_idx,
> +				ni_child_number(pd));
> +
> +			for (cd_idx = 0; cd_idx < ni_child_number(pd); cd_idx++) {
> +				cd_arrays[num_idx++] =
> +					ni_child_pointer(pbase, pd, cd_idx);
> +			}
> +		}
> +	}
> +
> +	/* Step2: Traverse all clock domains. */
> +	for (cd_idx = 0; cd_idx < ni->cd_num; cd_idx++) {
> +		cd = cd_arrays[cd_idx];
> +
> +		num = ni_child_number(cd);
> +		dev_dbg(dev, "The %dth clock domain has %d child nodes:", cd_idx, num);
> +
> +		/* Omit pmu node */
> +		ni_pmu = devm_kzalloc(dev, struct_size(ni_pmu, ev_src_nodes, num - 1),
> +				      GFP_KERNEL);
> +		ni_pmu->ev_src_num = num - 1;
> +
> +		if (!ni_pmu)
> +			return -ENOMEM;
> +
> +		num_idx = 0;
> +		for (nd_idx = 0; nd_idx < num; nd_idx++) {
> +			nd = ni_child_pointer(pbase, cd, nd_idx);
> +
> +			node.base = nd;
> +			node.node_type = ni_node_node_type(nd);
> +
> +			if (unlikely(ni_node_type(nd) == NI_PMU))
> +				ni_pmu->pmu_node = node;
> +			else
> +				ni_pmu->ev_src_nodes[num_idx++] = node;
> +			dev_dbg(dev, "  name: %s   id: %d", ni_node_name[node.type], node.id);
> +		}
> +
> +		ni_pmu->dev = dev;
> +		ni_pmu->ni = ni;
> +		ni->ni_pmus[cd_idx] = ni_pmu;
> +	}
> +
> +	devm_kfree(dev, cd_arrays);

Why? If it is not device-lifetime then allocate with usual way.

> +
> +	return 0;
> +}
> +
> +static int ni_pmu_probe(struct platform_device *pdev)
> +{
> +	int ret, cd_num, idx, irq_num, irq_idx;
> +	void __iomem *periphbase;
> +	struct global_ni *ni;
> +	struct device *dev = &pdev->dev;
> +	char *name;
> +	static int id;
> +	struct ni_pmu *ni_pmu;
> +
> +	BUILD_BUG_ON(sizeof(struct ni_hw_perf_event) >
> +		     offsetof(struct hw_perf_event, target));
> +#define NI_PMU_REG_MAP_SIZE 0xE08
> +	BUILD_BUG_ON(sizeof(struct ni_pmu_reg_map) != NI_PMU_REG_MAP_SIZE);
> +
> +	periphbase = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(periphbase)) {
> +		dev_err_probe(dev, PTR_ERR(periphbase), "Couldn't get ioremap\n");
> +		return PTR_ERR(periphbase);

I wrote you the syntax last time:
return dev_err_probe

> +	}
> +


..

> +
> +static const struct of_device_id ni_pmu_of_match[] = {
> +	{ .compatible = "hx,c2000-arm-ni" },

Don't send undocumented compatibles.

Best regards,
Krzysztof


