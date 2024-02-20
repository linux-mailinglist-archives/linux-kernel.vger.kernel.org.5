Return-Path: <linux-kernel+bounces-73323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FE85C0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26DF1F21E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECB6763FF;
	Tue, 20 Feb 2024 16:19:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67C8763E0;
	Tue, 20 Feb 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445950; cv=none; b=GBj07tUuVhZtz4mRBX1TUUgRFNgt0jfJ59youxqk1Gq/RWpW4o9hUrzPrLgbFZzYg4aK2DvD4IP8Cyd45hm0Bavr4+YgTJmh5IYgMZ5R/Pwdj2Ql5LEw1yNnrvwYI+XSB3LzNj4pyt2sItje9WPii1Q/94AXt4tTct4DvurP5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445950; c=relaxed/simple;
	bh=Kbs5ShNMiGtmIUVdQbCngo+ZeLV8wkZ+tvoPL+DmafM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVm8OfAfsIPuz3K5ZSEn/9vd33fpKfYncKbh2HyyLQeFiBmdGeUQ3IycHd9XfVFOMRR7p85bjaM3wIE2tK3mNK+PaLLPrXkHdbWCNMIQuaGp6kq8OMeIzwf/VQwibPVJgpxfaBTt5umC4QfMds1T7Fvm07kzzOYRoa7B1+6rKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB65AFEC;
	Tue, 20 Feb 2024 08:19:45 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E523E3F762;
	Tue, 20 Feb 2024 08:19:04 -0800 (PST)
Date: Tue, 20 Feb 2024 16:19:02 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, andersson@kernel.org, konrad.dybcio@linaro.org,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com,
	conor+dt@kernel.org, Amir Vajid <avajid@quicinc.com>
Subject: Re: [RFC 4/7] soc: qcom: Utilize qcom scmi vendor protocol for bus
 dvfs
Message-ID: <ZdTQ9ur3XpNVlduo@pluto>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-5-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117173458.2312669-5-quic_sibis@quicinc.com>

On Wed, Jan 17, 2024 at 11:04:55PM +0530, Sibi Sankar wrote:
> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>

Hi

> 
> This patch introduces a client driver that interacts with the SCMI QCOM
> vendor protocol and passes on the required tuneables to start various
> features running on the SCMI controller.
> 
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> Co-developed-by: Amir Vajid <avajid@quicinc.com>
> Signed-off-by: Amir Vajid <avajid@quicinc.com>
> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig            |  10 +
>  drivers/soc/qcom/Makefile           |   1 +
>  drivers/soc/qcom/qcom_scmi_client.c | 486 ++++++++++++++++++++++++++++
>  3 files changed, 497 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom_scmi_client.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index c6ca4de42586..1530558aebfb 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -264,6 +264,16 @@ config QCOM_ICC_BWMON
>  	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
>  	  memory throughput even with lower CPU frequencies.
>  
> +config QCOM_SCMI_CLIENT
> +	tristate "Qualcomm Technologies Inc. SCMI client driver"
> +	depends on QCOM_SCMI_VENDOR_PROTOCOL || COMPILE_TEST
> +	default n
> +	help
> +	  SCMI client driver registers for SCMI QCOM vendor protocol.
> +
> +	  This driver interacts with the vendor protocol and passes on the required
> +	  tuneables to start various features running on the SCMI controller.
> +
>  config QCOM_INLINE_CRYPTO_ENGINE
>  	tristate
>  	select QCOM_SCM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 05b3d54e8dc9..c2a51293c886 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -32,5 +32,6 @@ obj-$(CONFIG_QCOM_APR) += apr.o
>  obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
> +obj-$(CONFIG_QCOM_SCMI_CLIENT)	+= qcom_scmi_client.o
>  qcom_ice-objs			+= ice.o
>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
> diff --git a/drivers/soc/qcom/qcom_scmi_client.c b/drivers/soc/qcom/qcom_scmi_client.c
> new file mode 100644
> index 000000000000..418aa7900496
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_scmi_client.c
> @@ -0,0 +1,486 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/qcom_scmi_vendor.h>
> +#include <linux/scmi_protocol.h>
> +
> +#define MAX_MEMORY_TYPES	3
> +#define MEMLAT_ALGO_STR		0x74616C6D656D /* "memlat" */
> +#define INVALID_IDX		0xFF
> +#define MAX_NAME_LEN		20
> +#define MAX_MAP_ENTRIES		6
> +#define MAX_MONITOR_CNT		4
> +#define SCMI_VENDOR_MSG_START	3
> +#define SCMI_VENDOR_MSG_MODULE_START	16
> +
> +enum scmi_memlat_protocol_cmd {
> +	MEMLAT_SET_LOG_LEVEL = SCMI_VENDOR_MSG_START,
> +	MEMLAT_FLUSH_LOGBUF,
> +	MEMLAT_SET_MEM_GROUP = SCMI_VENDOR_MSG_MODULE_START,
> +	MEMLAT_SET_MONITOR,
> +	MEMLAT_SET_COMMON_EV_MAP,
> +	MEMLAT_SET_GRP_EV_MAP,
> +	MEMLAT_ADAPTIVE_LOW_FREQ,
> +	MEMLAT_ADAPTIVE_HIGH_FREQ,
> +	MEMLAT_GET_ADAPTIVE_CUR_FREQ,
> +	MEMLAT_IPM_CEIL,
> +	MEMLAT_FE_STALL_FLOOR,
> +	MEMLAT_BE_STALL_FLOOR,
> +	MEMLAT_WB_PCT,
> +	MEMLAT_IPM_FILTER,
> +	MEMLAT_FREQ_SCALE_PCT,
> +	MEMLAT_FREQ_SCALE_CEIL_MHZ,
> +	MEMLAT_FREQ_SCALE_FLOOR_MHZ,
> +	MEMLAT_SAMPLE_MS,
> +	MEMLAT_MON_FREQ_MAP,
> +	MEMLAT_SET_MIN_FREQ,
> +	MEMLAT_SET_MAX_FREQ,
> +	MEMLAT_GET_CUR_FREQ,
> +	MEMLAT_START_TIMER,
> +	MEMLAT_STOP_TIMER,
> +	MEMLAT_GET_TIMESTAMP,
> +	MEMLAT_MAX_MSG
> +};

So the reason why you can have just a single qualcomm vendor SCMI protocol is
that it really implements and expose just a couple of set/get generic commands
and exposes a few related ops so that you can piggyback any kind of real messages
into this new sort of transport layer and at the end the full final message payloads
are built here in the client driver...and any future further QC SCMI client driver
will implement its own set of payloads for different protocols.

Seems a bit odd to me (but certainly a creative way to abuse the SCMI stack), anyway
I have personally nothing against it, if you are happy with this design, but the spec
says that the protocol messages have to be little endian-encoded so I suppose that you
should, down below, define your smuggled (:P) payloads with __le32 & friends and use
the proper helpers to be sure that the values tranferred are properly interpreted, from
the endianess point-of-view, on both sides of the channel.

..but Sudeep could think differently...I would wait for his feedback...

> +
> +struct map_table {
> +	u16 v1;
> +	u16 v2;
> +};
> +
> +struct map_param_msg {
> +	u32 hw_type;
> +	u32 mon_idx;
> +	u32 nr_rows;
> +	struct map_table tbl[MAX_MAP_ENTRIES];
> +} __packed;
> +
> +struct node_msg {
> +	u32 cpumask;
> +	u32 hw_type;
> +	u32 mon_type;
> +	u32 mon_idx;
> +	char mon_name[MAX_NAME_LEN];
> +};
> +
> +struct scalar_param_msg {
> +	u32 hw_type;
> +	u32 mon_idx;
> +	u32 val;
> +};
> +
> +enum common_ev_idx {
> +	INST_IDX,
> +	CYC_IDX,
> +	FE_STALL_IDX,
> +	BE_STALL_IDX,
> +	NUM_COMMON_EVS
> +};
> +
> +enum grp_ev_idx {
> +	MISS_IDX,
> +	WB_IDX,
> +	ACC_IDX,
> +	NUM_GRP_EVS
> +};
> +
> +#define EV_CPU_CYCLES		0
> +#define EV_INST_RETIRED		2
> +#define EV_L2_D_RFILL		5
> +
> +struct ev_map_msg {
> +	u32 num_evs;
> +	u32 hw_type;
> +	u32 cid[NUM_COMMON_EVS];
> +};
> +
> +struct cpufreq_memfreq_map {
> +	unsigned int			cpufreq_mhz;
> +	unsigned int			memfreq_khz;
> +};
> +
> +struct scmi_monitor_info {
> +	struct cpufreq_memfreq_map *freq_map;
> +	char mon_name[MAX_NAME_LEN];
> +	u32 mon_idx;
> +	u32 mon_type;
> +	u32 ipm_ceil;
> +	u32 mask;
> +	u32 freq_map_len;
> +};
> +
> +struct scmi_memory_info {
> +	struct scmi_monitor_info *monitor[MAX_MONITOR_CNT];
> +	u32 hw_type;
> +	int monitor_cnt;
> +	u32 min_freq;
> +	u32 max_freq;
> +};
> +
> +struct scmi_memlat_info {
> +	struct scmi_protocol_handle *ph;
> +	const struct qcom_scmi_vendor_ops *ops;
> +	struct scmi_memory_info *memory[MAX_MEMORY_TYPES];
> +	int memory_cnt;
> +};
> +
> +static int get_mask(struct device_node *np, u32 *mask)
> +{
> +	struct device_node *dev_phandle;
> +	struct device *cpu_dev;
> +	int cpu, i = 0;
> +	int ret = -ENODEV;
> +
> +	dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
> +	while (dev_phandle) {
> +		for_each_possible_cpu(cpu) {
> +			cpu_dev = get_cpu_device(cpu);
> +			if (cpu_dev && cpu_dev->of_node == dev_phandle) {
> +				*mask |= BIT(cpu);
> +				ret = 0;
> +				break;
> +			}
> +		}
> +		dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
> +	}
> +
> +	return ret;
> +}
> +
> +static struct cpufreq_memfreq_map *init_cpufreq_memfreq_map(struct device *dev,
> +							    struct device_node *of_node,
> +							    u32 *cnt)
> +{
> +	int len, nf, i, j;
> +	u32 data;
> +	struct cpufreq_memfreq_map *tbl;
> +	int ret;
> +
> +	if (!of_find_property(of_node, "qcom,cpufreq-memfreq-tbl", &len))
> +		return NULL;
> +	len /= sizeof(data);
> +
> +	if (len % 2 || len == 0)
> +		return NULL;
> +	nf = len / 2;
> +
> +	tbl = devm_kzalloc(dev, (nf + 1) * sizeof(struct cpufreq_memfreq_map),
> +			   GFP_KERNEL);
> +	if (!tbl)
> +		return NULL;
> +
> +	for (i = 0, j = 0; i < nf; i++, j += 2) {
> +		ret = of_property_read_u32_index(of_node, "qcom,cpufreq-memfreq-tbl",
> +						 j, &data);
> +		if (ret < 0)
> +			return NULL;

Bailing out here and down below you are not releasing the devm_
allocated memory AND what is worst is that the caller of this function
does not check either for a NULL return value (see below)

> +		tbl[i].cpufreq_mhz = data / 1000;
> +
> +		ret = of_property_read_u32_index(of_node, "qcom,cpufreq-memfreq-tbl",
> +						 j + 1, &data);
> +		if (ret < 0)
> +			return NULL;
> +

Ditto.

> +		tbl[i].memfreq_khz = data;
> +		pr_debug("Entry%d CPU:%u, Mem:%u\n", i, tbl[i].cpufreq_mhz,
> +			 tbl[i].memfreq_khz);
> +	}
> +	*cnt = nf;
> +	tbl[i].cpufreq_mhz = 0;
> +
> +	return tbl;
> +}
> +
> +static int process_scmi_memlat_of_node(struct scmi_device *sdev, struct scmi_memlat_info *info)
> +{
> +	struct device_node *memlat_np, *memory_np, *monitor_np;
> +	struct scmi_memory_info *memory;
> +	struct scmi_monitor_info *monitor;
> +	int ret = 0, i = 0, j;
> +	u32 memfreq[2];
> +
> +	of_node_get(sdev->handle->dev->of_node);
> +	memlat_np = of_find_node_by_name(sdev->handle->dev->of_node, "memlat");
> +
> +	info->memory_cnt = of_get_child_count(memlat_np);
> +	if (info->memory_cnt <= 0)
> +		pr_err("No memory nodes present\n");
> +
> +	for_each_child_of_node(memlat_np, memory_np) {
> +		memory = devm_kzalloc(&sdev->dev, sizeof(*memory), GFP_KERNEL);
> +		if (!memory) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		ret = of_property_read_u32(memory_np, "reg", &memory->hw_type);
> +		if (ret) {
No devm_free see below.
> +			pr_err("Failed to read memory type\n");
> +			goto err;
> +		}
> +
> +		memory->monitor_cnt = of_get_child_count(memory_np);
> +		if (memory->monitor_cnt <= 0) {
> +			pr_err("No monitor nodes present\n");
> +			ret = -EINVAL;
No devm_free see below.
> +			goto err;
> +		}
> +
> +		ret = of_property_read_u32_array(memory_np, "freq-table-khz", memfreq, 2);
> +		if (ret && (ret != -EINVAL)) {
> +			pr_err("Failed to read min/max freq %d\n", ret);
No devm_free see below.
> +			goto err;
> +		}
> +
> +		memory->min_freq = memfreq[0];
> +		memory->max_freq = memfreq[1];
> +		info->memory[i] = memory;
> +		j = 0;
> +		i++;
> +
> +		for_each_child_of_node(memory_np, monitor_np) {
> +			monitor = devm_kzalloc(&sdev->dev, sizeof(*monitor), GFP_KERNEL);
> +			if (!monitor) {
> +				ret = -ENOMEM;
No devm_free see below.
> +				goto err;
> +			}
> +
> +			monitor->mon_type = (of_property_read_bool(monitor_np, "qcom,compute-mon")) ? 1 : 0;
> +			monitor->ipm_ceil = (of_property_read_bool(monitor_np, "qcom,compute-mon")) ? 0 : 20000000;
> +
> +			if (get_mask(monitor_np, &monitor->mask)) {
> +				pr_err("Failed to populate cpu mask %d\n", ret);
No devm_free see below.
> +				goto err;
> +			}
> +
> +			monitor->freq_map = init_cpufreq_memfreq_map(&sdev->dev, monitor_np,
> +								     &monitor->freq_map_len);

Return can be NULL here and it is not checked, but seems to me that is
then accessed without any NULL-check....

> +			snprintf(monitor->mon_name, MAX_NAME_LEN, "monitor-%d", j);
> +			monitor->mon_idx = j;
> +
> +			memory->monitor[j] = monitor;
> +			j++;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	of_node_put(memlat_np);
> +

Here you bailout with an -ENOMEM or other errors but without releasing devm_
allocated stuff AND in the caller of this you carry on despite any error and
you neither did release this memory in the caller, so this unused mem-areas
will be eventually freed only on driver removal.

> +	return ret;
> +}
> +
> +static int configure_cpucp_common_events(struct scmi_memlat_info *info)
> +{
> +	const struct qcom_scmi_vendor_ops *ops = info->ops;
> +	u8 ev_map[NUM_COMMON_EVS];
> +	struct ev_map_msg msg;
> +	int ret;
> +
> +	memset(ev_map, 0xFF, NUM_COMMON_EVS);
> +
> +	msg.num_evs = NUM_COMMON_EVS;
> +	msg.hw_type = INVALID_IDX;
> +	msg.cid[INST_IDX] = EV_INST_RETIRED;
> +	msg.cid[CYC_IDX] = EV_CPU_CYCLES;
> +	msg.cid[FE_STALL_IDX] = INVALID_IDX;
> +	msg.cid[BE_STALL_IDX] = INVALID_IDX;
> +
> +	ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_COMMON_EV_MAP,
> +			     sizeof(msg));
> +	return ret;
> +}
> +
> +static int configure_cpucp_grp(struct scmi_memlat_info *info, int memory_index)
> +{
> +	const struct qcom_scmi_vendor_ops *ops = info->ops;
> +	struct scmi_memory_info *memory = info->memory[memory_index];
> +	struct ev_map_msg ev_msg;
> +	u8 ev_map[NUM_GRP_EVS];
> +	struct node_msg msg;
> +	int ret;
> +
> +	msg.cpumask = 0;
> +	msg.hw_type = memory->hw_type;
> +	msg.mon_type = 0;
> +	msg.mon_idx = 0;
> +	ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_MEM_GROUP, sizeof(msg));
> +	if (ret < 0) {
> +		pr_err("Failed to configure mem type %d\n", memory->hw_type);
> +		return ret;
> +	}
> +
> +	memset(ev_map, 0xFF, NUM_GRP_EVS);
> +	ev_msg.num_evs = NUM_GRP_EVS;
> +	ev_msg.hw_type = memory->hw_type;
> +	ev_msg.cid[MISS_IDX] = EV_L2_D_RFILL;
> +	ev_msg.cid[WB_IDX] = INVALID_IDX;
> +	ev_msg.cid[ACC_IDX] = INVALID_IDX;
> +	ret = ops->set_param(info->ph, &ev_msg, MEMLAT_ALGO_STR, MEMLAT_SET_GRP_EV_MAP,
> +			     sizeof(ev_msg));
> +	if (ret < 0) {
> +		pr_err("Failed to configure event map for mem type %d\n", memory->hw_type);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int configure_cpucp_mon(struct scmi_memlat_info *info, int memory_index, int monitor_index)
> +{
> +	const struct qcom_scmi_vendor_ops *ops = info->ops;
> +	struct scmi_memory_info *memory = info->memory[memory_index];
> +	struct scmi_monitor_info *monitor = memory->monitor[monitor_index];
> +	struct scalar_param_msg scalar_msg;
> +	struct map_param_msg map_msg;
> +	struct node_msg msg;
> +	int ret;
> +	int i;
> +
> +	msg.cpumask = monitor->mask;
> +	msg.hw_type = memory->hw_type;
> +	msg.mon_type = monitor->mon_type;
> +	msg.mon_idx = monitor->mon_idx;
> +	strscpy(msg.mon_name, monitor->mon_name, sizeof(msg.mon_name));
> +	ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_MONITOR, sizeof(msg));
> +	if (ret < 0) {
> +		pr_err("Failed to configure monitor %s\n", monitor->mon_name);
> +		return ret;
> +	}
> +
> +	scalar_msg.hw_type = memory->hw_type;
> +	scalar_msg.mon_idx = monitor->mon_idx;
> +	scalar_msg.val = monitor->ipm_ceil;
> +	ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_IPM_CEIL,
> +			     sizeof(scalar_msg));
> +	if (ret < 0) {
> +		pr_err("Failed to set ipm ceil for %s\n", monitor->mon_name);
> +		return ret;
> +	}
> +
> +	map_msg.hw_type = memory->hw_type;
> +	map_msg.mon_idx = monitor->mon_idx;
> +	map_msg.nr_rows = monitor->freq_map_len;
> +	for (i = 0; i < monitor->freq_map_len; i++) {
> +		map_msg.tbl[i].v1 = monitor->freq_map[i].cpufreq_mhz;
> +		map_msg.tbl[i].v2 = monitor->freq_map[i].memfreq_khz / 1000;
> +	}
> +	ret = ops->set_param(info->ph, &map_msg, MEMLAT_ALGO_STR, MEMLAT_MON_FREQ_MAP,
> +			     sizeof(map_msg));
> +	if (ret < 0) {
> +		pr_err("Failed to configure freq_map for %s\n", monitor->mon_name);
> +		return ret;
> +	}
> +
> +	scalar_msg.hw_type = memory->hw_type;
> +	scalar_msg.mon_idx = monitor->mon_idx;
> +	scalar_msg.val = memory->min_freq;
> +	ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_SET_MIN_FREQ,
> +			     sizeof(scalar_msg));
> +	if (ret < 0) {
> +		pr_err("Failed to set min_freq for %s\n", monitor->mon_name);
> +		return ret;
> +	}
> +
> +	scalar_msg.hw_type = memory->hw_type;
> +	scalar_msg.mon_idx = monitor->mon_idx;
> +	scalar_msg.val = memory->max_freq;
> +	ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_SET_MAX_FREQ,
> +			     sizeof(scalar_msg));
> +	if (ret < 0)
> +		pr_err("Failed to set max_freq for %s\n", monitor->mon_name);
> +
> +	return ret;
> +}
> +
> +static int cpucp_memlat_init(struct scmi_device *sdev)
> +{
> +	const struct scmi_handle *handle = sdev->handle;
> +	const struct qcom_scmi_vendor_ops *ops;
> +	struct scmi_protocol_handle *ph;
> +	struct scmi_memlat_info *info;
> +	u32 cpucp_sample_ms = 8;
> +	int ret, i, j;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	ops = handle->devm_protocol_get(sdev, QCOM_SCMI_VENDOR_PROTOCOL, &ph);
> +	if (IS_ERR(ops))
> +		return PTR_ERR(ops);
> +
> +	info = devm_kzalloc(&sdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	ret = process_scmi_memlat_of_node(sdev, info);
> +	if (ret)
> +		pr_err("Failed to configure common events: %d\n", ret);

Carry on without cleaning up stuff allocated by process_scmi_memlat_of_node()

Thanks,
Cristian

