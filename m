Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE37670C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbjG1Pio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjG1Pik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:38:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 744E5421B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:38:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 345E62F4;
        Fri, 28 Jul 2023 08:39:13 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.89.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A79A3F67D;
        Fri, 28 Jul 2023 08:38:28 -0700 (PDT)
Date:   Fri, 28 Jul 2023 16:38:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        bbhushan2@marvell.com, gcherian@marvell.com, lcherian@marvell.com
Subject: Re: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD performance monitor
 support
Message-ID: <ZMPg8RNxEeHQNdqb@FVFF77S0Q05N>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-4-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630120351.1143773-4-gthiagarajan@marvell.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 05:33:48PM +0530, Gowthami Thiagarajan wrote:
> Each TAD provides eight 64-bit counters for monitoring
> cache behavior.The driver always configures the same counter for
> all the TADs. The user would end up effectively reserving one of
> eight counters in every TAD to look across all TADs.
> The occurrences of events are aggregated and presented to the user
> at the end of running the workload. The driver does not provide a
> way for the user to partition TADs so that different TADs are used for
> different applications.
> 
> The performance events reflect various internal or interface activities.
> By combining the values from multiple performance counters, cache
> performance can be measured in terms such as: cache miss rate, cache
> allocations, interface retry rate, internal resource occupancy, etc.
> 
> Each supported counter's event and formatting information is exposed
> to sysfs at /sys/devices/tad/. Use perf tool stat command to measure
> the pmu events. For instance:
> 
> perf stat -e tad_hit_ltg,tad_hit_dtg <workload>
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>

This generally looks ok; I have a few comments below.

[...]

> +static void tad_pmu_event_counter_stop(struct perf_event *event, int flags)
> +{
> +	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u32 counter_idx = hwc->idx;
> +	int tad_region;
> +
> +	/* TAD()_PFC() stop counting on the write
> +	 * which sets TAD()_PRF()[CNTSEL] == 0
> +	 */

Please fix the comment style.

Likewise for all other instances within this file.

[...]

> +static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
> +{
> +	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +
> +	/* Get a free counter for this event */
> +	idx = find_first_zero_bit(tad_pmu->counters_map, TAD_MAX_COUNTERS);
> +	if (idx == TAD_MAX_COUNTERS)
> +		return -EAGAIN;
> +
> +	set_bit(idx, tad_pmu->counters_map);
> +
> +	hwc->idx = idx;
> +	hwc->state = PERF_HES_STOPPED;
> +	tad_pmu->events[idx] = event;
> +
> +	if (flags & PERF_EF_START)
> +		tad_pmu_event_counter_start(event, flags);
> +
> +	return 0;
> +}
> +
> +static int tad_pmu_event_init(struct perf_event *event)
> +{
> +	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;

Why is this not rejecting smapling events, as patch 1 does?

> +
> +	if (!event->attr.disabled)
> +		return -EINVAL;

Why?

> +
> +	if (event->state != PERF_EVENT_STATE_OFF)
> +		return -EINVAL;

Event groups need to be verified here too.

[...]

> +static int tad_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tad_region *regions;
> +	struct tad_pmu *tad_pmu;
> +	struct resource *res;
> +	u32 tad_pmu_page_size;
> +	u32 tad_page_size;
> +	u32 tad_cnt;
> +	int i, ret;
> +	char *name;
> +
> +	tad_pmu = devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
> +	if (!tad_pmu)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, tad_pmu);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Mem resource not found\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = device_property_read_u32(dev, "marvell,tad-page-size", &tad_page_size);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't find tad-page-size property\n");
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(dev, "marvell,tad-pmu-page-size",
> +				       &tad_pmu_page_size);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't find tad-pmu-page-size property\n");
> +		return ret;
> +	}

Why do you think these properties are necessary?

These should almost certainly be provided by IO resources, and shouldn't need a
custom property.

Thanks,
Mark.
