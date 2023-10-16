Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2BB7CA7DB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjJPMQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjJPMQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:16:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938708E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:16:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qsMWO-0006gq-PE; Mon, 16 Oct 2023 14:16:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qsMWN-00252d-4x; Mon, 16 Oct 2023 14:16:31 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qsMWN-00EjlH-1v; Mon, 16 Oct 2023 14:16:31 +0200
Date:   Mon, 16 Oct 2023 14:16:31 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v7 16/26] PM / devfreq: rockchip-dfi: Add perf support
Message-ID: <20231016121631.GB3359458@pengutronix.de>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-17-s.hauer@pengutronix.de>
 <73ed646a-f20b-8050-2a45-c6faa5539193@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ed646a-f20b-8050-2a45-c6faa5539193@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:48:43AM +0900, Chanwoo Choi wrote:
> On 23. 7. 4. 18:32, Sascha Hauer wrote:
> > The DFI is a unit which is suitable for measuring DDR utilization, but
> > so far it could only be used as an event driver for the DDR frequency
> > scaling driver. This adds perf support to the DFI driver.
> > 
> > Usage with the 'perf' tool can look like:
> > 
> > perf stat -a -e rockchip_ddr/cycles/,\
> > 		rockchip_ddr/read-bytes/,\
> > 		rockchip_ddr/write-bytes/,\
> > 		rockchip_ddr/bytes/ sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >         1582524826      rockchip_ddr/cycles/
> >            1802.25 MB   rockchip_ddr/read-bytes/
> >            1793.72 MB   rockchip_ddr/write-bytes/
> >            3595.90 MB   rockchip_ddr/bytes/
> > 
> >        1.014369709 seconds time elapsed
> > 
> > perf support has been tested on a RK3568 and a RK3399, the latter with
> > dual channel DDR.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > 
> > Notes:
> >     Changes since v5:
> >     - Add missing initialization of &dfi->last_perf_count
> >     
> >     Changes since v4:
> >     
> >     - use __stringify to ensure event type definitions and event numbers in sysfs are consistent
> >     - only use 64bit values in structs holding counters
> >     - support monitoring individual DDR channels
> >     - fix return value in rockchip_ddr_perf_event_init(): -EOPNOTSUPP -> -EINVAL
> >     - check for invalid event->attr.config values
> >     - start hrtimer to trigger in one second, not immediately
> >     - use devm_add_action_or_reset()
> >     - add suppress_bind_attrs
> >     - enable DDRMON during probe when perf is enabled
> >     - use a seqlock to protect perf reading the counters from the hrtimer callback modifying them
> > 
> >  drivers/devfreq/event/rockchip-dfi.c | 442 ++++++++++++++++++++++++++-
> >  include/soc/rockchip/rk3399_grf.h    |   2 +
> >  include/soc/rockchip/rk3568_grf.h    |   1 +
> >  3 files changed, 440 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> > index 50e497455dc69..969b62f071b83 100644
> > --- a/drivers/devfreq/event/rockchip-dfi.c
> > +++ b/drivers/devfreq/event/rockchip-dfi.c
> > @@ -16,10 +16,12 @@
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> >  #include <linux/list.h>
> > +#include <linux/seqlock.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/bits.h>
> > +#include <linux/perf_event.h>
> >  
> >  #include <soc/rockchip/rockchip_grf.h>
> >  #include <soc/rockchip/rk3399_grf.h>
> > @@ -41,19 +43,39 @@
> >  					 DDRMON_CTRL_LPDDR4 | \
> >  					 DDRMON_CTRL_LPDDR23)
> >  
> > +#define DDRMON_CH0_WR_NUM		0x20
> > +#define DDRMON_CH0_RD_NUM		0x24
> >  #define DDRMON_CH0_COUNT_NUM		0x28
> >  #define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
> >  #define DDRMON_CH1_COUNT_NUM		0x3c
> >  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
> >  
> > +#define PERF_EVENT_CYCLES		0x0
> > +#define PERF_EVENT_READ_BYTES		0x1
> > +#define PERF_EVENT_WRITE_BYTES		0x2
> > +#define PERF_EVENT_READ_BYTES0		0x3
> > +#define PERF_EVENT_WRITE_BYTES0		0x4
> > +#define PERF_EVENT_READ_BYTES1		0x5
> > +#define PERF_EVENT_WRITE_BYTES1		0x6
> > +#define PERF_EVENT_READ_BYTES2		0x7
> > +#define PERF_EVENT_WRITE_BYTES2		0x8
> > +#define PERF_EVENT_READ_BYTES3		0x9
> > +#define PERF_EVENT_WRITE_BYTES3		0xa
> > +#define PERF_EVENT_BYTES		0xb
> > +#define PERF_ACCESS_TYPE_MAX		0xc
> > +
> >  /**
> >   * struct dmc_count_channel - structure to hold counter values from the DDR controller
> >   * @access:       Number of read and write accesses
> >   * @clock_cycles: DDR clock cycles
> > + * @read_access:  number of read accesses
> > + * @write_acccess: number of write accesses
> >   */
> >  struct dmc_count_channel {
> > -	u32 access;
> > -	u32 clock_cycles;
> > +	u64 access;
> > +	u64 clock_cycles;
> > +	u64 read_access;
> > +	u64 write_access;
> >  };
> >  
> >  struct dmc_count {
> > @@ -69,6 +91,11 @@ struct rockchip_dfi {
> >  	struct devfreq_event_dev *edev;
> >  	struct devfreq_event_desc desc;
> >  	struct dmc_count last_event_count;
> > +
> > +	struct dmc_count last_perf_count;
> > +	struct dmc_count total_count;
> > +	seqlock_t count_seqlock; /* protects last_perf_count and total_count */
> > +
> >  	struct device *dev;
> >  	void __iomem *regs;
> >  	struct regmap *regmap_pmu;
> > @@ -77,6 +104,14 @@ struct rockchip_dfi {
> >  	struct mutex mutex;
> >  	u32 ddr_type;
> >  	unsigned int channel_mask;
> > +	enum cpuhp_state cpuhp_state;
> > +	struct hlist_node node;
> > +	struct pmu pmu;
> > +	struct hrtimer timer;
> > +	unsigned int cpu;
> > +	int active_events;
> > +	int burst_len;
> > +	int buswidth[DMC_MAX_CHANNELS];
> >  };
> >  
> >  static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
> > @@ -145,7 +180,7 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
> >  	mutex_unlock(&dfi->mutex);
> >  }
> >  
> > -static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_count *count)
> > +static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_count *c)
> 
> Actually, this change is not related to the patch's role which supports perf.
> Also, it is better to use 'res' argument name because rockchip_ddr_perf_counters_add()
> used the 'struct dmc_count *res' argument name.

Indeed the variable rename is not required here and for consistency
with rockchip_ddr_perf_counters_add() 'res' would be a better name.

Are you fine with renaming 'c' to 'res' in this patch or do you want me
to make a separate patch from the renaming?

> 
> 
> >  {
> >  	u32 i;
> >  	void __iomem *dfi_regs = dfi->regs;
> > @@ -153,13 +188,36 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
> >  	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
> >  		if (!(dfi->channel_mask & BIT(i)))
> >  			continue;
> > -		count->c[i].access = readl_relaxed(dfi_regs +
> > +		c->c[i].read_access = readl_relaxed(dfi_regs +
> > +				DDRMON_CH0_RD_NUM + i * 20);
> > +		c->c[i].write_access = readl_relaxed(dfi_regs +
> > +				DDRMON_CH0_WR_NUM + i * 20);
> > +		c->c[i].access = readl_relaxed(dfi_regs +
> >  				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> > -		count->c[i].clock_cycles = readl_relaxed(dfi_regs +
> > +		c->c[i].clock_cycles = readl_relaxed(dfi_regs +
> >  				DDRMON_CH0_COUNT_NUM + i * 20);
> >  	}
> >  }
> >  
> > +static void rockchip_ddr_perf_counters_add(struct rockchip_dfi *dfi,
> > +					   const struct dmc_count *now,
> > +					   struct dmc_count *res)
> > +{
> > +	const struct dmc_count *last = &dfi->last_perf_count;
> > +	int i;
> > +
> > +	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
> > +		res->c[i].read_access = dfi->total_count.c[i].read_access +
> > +			(u32)(now->c[i].read_access - last->c[i].read_access);
> > +		res->c[i].write_access = dfi->total_count.c[i].write_access +
> > +			(u32)(now->c[i].write_access - last->c[i].write_access);
> > +		res->c[i].access = dfi->total_count.c[i].access +
> > +			(u32)(now->c[i].access - last->c[i].access);
> > +		res->c[i].clock_cycles = dfi->total_count.c[i].clock_cycles +
> > +			(u32)(now->c[i].clock_cycles - last->c[i].clock_cycles);
> > +	}
> > +}
> > +
> >  static int rockchip_dfi_event_disable(struct devfreq_event_dev *edev)
> >  {
> >  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
> > @@ -223,6 +281,370 @@ static const struct devfreq_event_ops rockchip_dfi_ops = {
> >  	.set_event = rockchip_dfi_set_event,
> >  };
> >  

[...]

> > +static u64 rockchip_ddr_perf_event_get_count(struct perf_event *event)
> > +{
> > +	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
> > +	int blen = dfi->burst_len;
> > +	struct dmc_count total, now;
> > +	unsigned int seq;
> > +	u64 c = 0;
> 
> Actually, it is difficult to understand the meaning of 'c' local variable name.
> Need to use the more clear vairable name instead of 'c'.

'c' is short for 'count' as in the function name xxx_get_count(). It is
initialized to 0, filled with values throughout the function and
returned at the end. Which other name do you suggest?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
