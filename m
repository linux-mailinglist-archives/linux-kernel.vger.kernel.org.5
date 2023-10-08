Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B800C7BD060
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjJHVsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjJHVsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:48:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B829D;
        Sun,  8 Oct 2023 14:48:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7511CC433C7;
        Sun,  8 Oct 2023 21:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696801730;
        bh=EkBXXfOQSJIR3CrR+vD+5FTY0QAYSF/SOI8rEiaZF7k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HI2PiSM8vK/bOAQoW3idcWgwK1VKAIrBDqshSZ8jmPzvb8AyowjPqgTmnTFXz5cpS
         iiDKIfQam9lxNbl0hHQ/bF6C5tFImrofI8Rwqp+aTHZc7qpkBwdxDREV2sTfpzhYLu
         ci7jqlTVgtHT8Cp/SC3Im3+dgZ5YNsy6y5INPZNUurKG3vsK8Nw8DIBO5WIsrES/40
         MRiIf77PblbzGZS7XLEMCZMe4LR5fEerPAAOxqahfX1ZZkN90OYPYrw29dQ65qkypo
         XLcR3cqXo/jozljLREuKS6xLa6xaa1e7A5Jw6dJNo0i8j1rpp/AQEvp1YjmzfD1i2a
         X5CkvRSY0QoeQ==
Message-ID: <73ed646a-f20b-8050-2a45-c6faa5539193@kernel.org>
Date:   Mon, 9 Oct 2023 06:48:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 16/26] PM / devfreq: rockchip-dfi: Add perf support
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-17-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230704093242.583575-17-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 7. 4. 18:32, Sascha Hauer wrote:
> The DFI is a unit which is suitable for measuring DDR utilization, but
> so far it could only be used as an event driver for the DDR frequency
> scaling driver. This adds perf support to the DFI driver.
> 
> Usage with the 'perf' tool can look like:
> 
> perf stat -a -e rockchip_ddr/cycles/,\
> 		rockchip_ddr/read-bytes/,\
> 		rockchip_ddr/write-bytes/,\
> 		rockchip_ddr/bytes/ sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>         1582524826      rockchip_ddr/cycles/
>            1802.25 MB   rockchip_ddr/read-bytes/
>            1793.72 MB   rockchip_ddr/write-bytes/
>            3595.90 MB   rockchip_ddr/bytes/
> 
>        1.014369709 seconds time elapsed
> 
> perf support has been tested on a RK3568 and a RK3399, the latter with
> dual channel DDR.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> 
> Notes:
>     Changes since v5:
>     - Add missing initialization of &dfi->last_perf_count
>     
>     Changes since v4:
>     
>     - use __stringify to ensure event type definitions and event numbers in sysfs are consistent
>     - only use 64bit values in structs holding counters
>     - support monitoring individual DDR channels
>     - fix return value in rockchip_ddr_perf_event_init(): -EOPNOTSUPP -> -EINVAL
>     - check for invalid event->attr.config values
>     - start hrtimer to trigger in one second, not immediately
>     - use devm_add_action_or_reset()
>     - add suppress_bind_attrs
>     - enable DDRMON during probe when perf is enabled
>     - use a seqlock to protect perf reading the counters from the hrtimer callback modifying them
> 
>  drivers/devfreq/event/rockchip-dfi.c | 442 ++++++++++++++++++++++++++-
>  include/soc/rockchip/rk3399_grf.h    |   2 +
>  include/soc/rockchip/rk3568_grf.h    |   1 +
>  3 files changed, 440 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 50e497455dc69..969b62f071b83 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -16,10 +16,12 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/list.h>
> +#include <linux/seqlock.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/perf_event.h>
>  
>  #include <soc/rockchip/rockchip_grf.h>
>  #include <soc/rockchip/rk3399_grf.h>
> @@ -41,19 +43,39 @@
>  					 DDRMON_CTRL_LPDDR4 | \
>  					 DDRMON_CTRL_LPDDR23)
>  
> +#define DDRMON_CH0_WR_NUM		0x20
> +#define DDRMON_CH0_RD_NUM		0x24
>  #define DDRMON_CH0_COUNT_NUM		0x28
>  #define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
>  
> +#define PERF_EVENT_CYCLES		0x0
> +#define PERF_EVENT_READ_BYTES		0x1
> +#define PERF_EVENT_WRITE_BYTES		0x2
> +#define PERF_EVENT_READ_BYTES0		0x3
> +#define PERF_EVENT_WRITE_BYTES0		0x4
> +#define PERF_EVENT_READ_BYTES1		0x5
> +#define PERF_EVENT_WRITE_BYTES1		0x6
> +#define PERF_EVENT_READ_BYTES2		0x7
> +#define PERF_EVENT_WRITE_BYTES2		0x8
> +#define PERF_EVENT_READ_BYTES3		0x9
> +#define PERF_EVENT_WRITE_BYTES3		0xa
> +#define PERF_EVENT_BYTES		0xb
> +#define PERF_ACCESS_TYPE_MAX		0xc
> +
>  /**
>   * struct dmc_count_channel - structure to hold counter values from the DDR controller
>   * @access:       Number of read and write accesses
>   * @clock_cycles: DDR clock cycles
> + * @read_access:  number of read accesses
> + * @write_acccess: number of write accesses
>   */
>  struct dmc_count_channel {
> -	u32 access;
> -	u32 clock_cycles;
> +	u64 access;
> +	u64 clock_cycles;
> +	u64 read_access;
> +	u64 write_access;
>  };
>  
>  struct dmc_count {
> @@ -69,6 +91,11 @@ struct rockchip_dfi {
>  	struct devfreq_event_dev *edev;
>  	struct devfreq_event_desc desc;
>  	struct dmc_count last_event_count;
> +
> +	struct dmc_count last_perf_count;
> +	struct dmc_count total_count;
> +	seqlock_t count_seqlock; /* protects last_perf_count and total_count */
> +
>  	struct device *dev;
>  	void __iomem *regs;
>  	struct regmap *regmap_pmu;
> @@ -77,6 +104,14 @@ struct rockchip_dfi {
>  	struct mutex mutex;
>  	u32 ddr_type;
>  	unsigned int channel_mask;
> +	enum cpuhp_state cpuhp_state;
> +	struct hlist_node node;
> +	struct pmu pmu;
> +	struct hrtimer timer;
> +	unsigned int cpu;
> +	int active_events;
> +	int burst_len;
> +	int buswidth[DMC_MAX_CHANNELS];
>  };
>  
>  static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
> @@ -145,7 +180,7 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
>  	mutex_unlock(&dfi->mutex);
>  }
>  
> -static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_count *count)
> +static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_count *c)

Actually, this change is not related to the patch's role which supports perf.
Also, it is better to use 'res' argument name because rockchip_ddr_perf_counters_add()
used the 'struct dmc_count *res' argument name.


>  {
>  	u32 i;
>  	void __iomem *dfi_regs = dfi->regs;
> @@ -153,13 +188,36 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
>  	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
>  		if (!(dfi->channel_mask & BIT(i)))
>  			continue;
> -		count->c[i].access = readl_relaxed(dfi_regs +
> +		c->c[i].read_access = readl_relaxed(dfi_regs +
> +				DDRMON_CH0_RD_NUM + i * 20);
> +		c->c[i].write_access = readl_relaxed(dfi_regs +
> +				DDRMON_CH0_WR_NUM + i * 20);
> +		c->c[i].access = readl_relaxed(dfi_regs +
>  				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> -		count->c[i].clock_cycles = readl_relaxed(dfi_regs +
> +		c->c[i].clock_cycles = readl_relaxed(dfi_regs +
>  				DDRMON_CH0_COUNT_NUM + i * 20);
>  	}
>  }
>  
> +static void rockchip_ddr_perf_counters_add(struct rockchip_dfi *dfi,
> +					   const struct dmc_count *now,
> +					   struct dmc_count *res)
> +{
> +	const struct dmc_count *last = &dfi->last_perf_count;
> +	int i;
> +
> +	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
> +		res->c[i].read_access = dfi->total_count.c[i].read_access +
> +			(u32)(now->c[i].read_access - last->c[i].read_access);
> +		res->c[i].write_access = dfi->total_count.c[i].write_access +
> +			(u32)(now->c[i].write_access - last->c[i].write_access);
> +		res->c[i].access = dfi->total_count.c[i].access +
> +			(u32)(now->c[i].access - last->c[i].access);
> +		res->c[i].clock_cycles = dfi->total_count.c[i].clock_cycles +
> +			(u32)(now->c[i].clock_cycles - last->c[i].clock_cycles);
> +	}
> +}
> +
>  static int rockchip_dfi_event_disable(struct devfreq_event_dev *edev)
>  {
>  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
> @@ -223,6 +281,370 @@ static const struct devfreq_event_ops rockchip_dfi_ops = {
>  	.set_event = rockchip_dfi_set_event,
>  };
>  
> +#ifdef CONFIG_PERF_EVENTS
> +
> +static ssize_t ddr_perf_cpumask_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct rockchip_dfi *dfi = container_of(pmu, struct rockchip_dfi, pmu);
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(dfi->cpu));
> +}
> +
> +static struct device_attribute ddr_perf_cpumask_attr =
> +	__ATTR(cpumask, 0444, ddr_perf_cpumask_show, NULL);
> +
> +static struct attribute *ddr_perf_cpumask_attrs[] = {
> +	&ddr_perf_cpumask_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ddr_perf_cpumask_attr_group = {
> +	.attrs = ddr_perf_cpumask_attrs,
> +};
> +
> +PMU_EVENT_ATTR_STRING(cycles, ddr_pmu_cycles, "event="__stringify(PERF_EVENT_CYCLES))
> +
> +#define DFI_PMU_EVENT_ATTR(_name, _var, _str) \
> +	PMU_EVENT_ATTR_STRING(_name, _var, _str); \
> +	PMU_EVENT_ATTR_STRING(_name.unit, _var##_unit, "MB"); \
> +	PMU_EVENT_ATTR_STRING(_name.scale, _var##_scale, "9.536743164e-07")
> +
> +DFI_PMU_EVENT_ATTR(read-bytes0, ddr_pmu_read_bytes0, "event="__stringify(PERF_EVENT_READ_BYTES0));
> +DFI_PMU_EVENT_ATTR(write-bytes0, ddr_pmu_write_bytes0, "event="__stringify(PERF_EVENT_WRITE_BYTES0));
> +
> +DFI_PMU_EVENT_ATTR(read-bytes1, ddr_pmu_read_bytes1, "event="__stringify(PERF_EVENT_READ_BYTES1));
> +DFI_PMU_EVENT_ATTR(write-bytes1, ddr_pmu_write_bytes1, "event="__stringify(PERF_EVENT_WRITE_BYTES1));
> +
> +DFI_PMU_EVENT_ATTR(read-bytes2, ddr_pmu_read_bytes2, "event="__stringify(PERF_EVENT_READ_BYTES2));
> +DFI_PMU_EVENT_ATTR(write-bytes2, ddr_pmu_write_bytes2, "event="__stringify(PERF_EVENT_WRITE_BYTES2));
> +
> +DFI_PMU_EVENT_ATTR(read-bytes3, ddr_pmu_read_bytes3, "event="__stringify(PERF_EVENT_READ_BYTES3));
> +DFI_PMU_EVENT_ATTR(write-bytes3, ddr_pmu_write_bytes3, "event="__stringify(PERF_EVENT_WRITE_BYTES3));
> +
> +DFI_PMU_EVENT_ATTR(read-bytes, ddr_pmu_read_bytes, "event="__stringify(PERF_EVENT_READ_BYTES));
> +DFI_PMU_EVENT_ATTR(write-bytes, ddr_pmu_write_bytes, "event="__stringify(PERF_EVENT_WRITE_BYTES));
> +
> +DFI_PMU_EVENT_ATTR(bytes, ddr_pmu_bytes, "event="__stringify(PERF_EVENT_BYTES));
> +
> +#define DFI_ATTR_MB(_name) 		\
> +	&_name.attr.attr,		\
> +	&_name##_unit.attr.attr,	\
> +	&_name##_scale.attr.attr
> +
> +static struct attribute *ddr_perf_events_attrs[] = {
> +	&ddr_pmu_cycles.attr.attr,
> +	DFI_ATTR_MB(ddr_pmu_read_bytes),
> +	DFI_ATTR_MB(ddr_pmu_write_bytes),
> +	DFI_ATTR_MB(ddr_pmu_read_bytes0),
> +	DFI_ATTR_MB(ddr_pmu_write_bytes0),
> +	DFI_ATTR_MB(ddr_pmu_read_bytes1),
> +	DFI_ATTR_MB(ddr_pmu_write_bytes1),
> +	DFI_ATTR_MB(ddr_pmu_read_bytes2),
> +	DFI_ATTR_MB(ddr_pmu_write_bytes2),
> +	DFI_ATTR_MB(ddr_pmu_read_bytes3),
> +	DFI_ATTR_MB(ddr_pmu_write_bytes3),
> +	DFI_ATTR_MB(ddr_pmu_bytes),
> +	NULL,
> +};
> +
> +static const struct attribute_group ddr_perf_events_attr_group = {
> +	.name = "events",
> +	.attrs = ddr_perf_events_attrs,
> +};
> +
> +PMU_FORMAT_ATTR(event, "config:0-7");
> +
> +static struct attribute *ddr_perf_format_attrs[] = {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ddr_perf_format_attr_group = {
> +	.name = "format",
> +	.attrs = ddr_perf_format_attrs,
> +};
> +
> +static const struct attribute_group *attr_groups[] = {
> +	&ddr_perf_events_attr_group,
> +	&ddr_perf_cpumask_attr_group,
> +	&ddr_perf_format_attr_group,
> +	NULL,
> +};
> +
> +static int rockchip_ddr_perf_event_init(struct perf_event *event)
> +{
> +	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (event->attach_state & PERF_ATTACH_TASK)
> +		return -EINVAL;
> +
> +	if (event->cpu < 0) {
> +		dev_warn(dfi->dev, "Can't provide per-task data!\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static u64 rockchip_ddr_perf_event_get_count(struct perf_event *event)
> +{
> +	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
> +	int blen = dfi->burst_len;
> +	struct dmc_count total, now;
> +	unsigned int seq;
> +	u64 c = 0;

Actually, it is difficult to understand the meaning of 'c' local variable name.
Need to use the more clear vairable name instead of 'c'.

> +	int i;
> +
> +	rockchip_dfi_read_counters(dfi, &now);
> +
> +	do {
> +		seq = read_seqbegin(&dfi->count_seqlock);
> +
> +		rockchip_ddr_perf_counters_add(dfi, &now, &total);
> +

Remove unneeded blank line.

> +	} while (read_seqretry(&dfi->count_seqlock, seq));
(snip)

I added the some comment. If you are fixing the comment, feel free to add my ack.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

