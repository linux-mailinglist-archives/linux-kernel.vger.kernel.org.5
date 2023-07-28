Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04876700B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbjG1PCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjG1PCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:02:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 032B13AAC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:02:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A79252F4;
        Fri, 28 Jul 2023 08:02:48 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.89.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12F8E3F67D;
        Fri, 28 Jul 2023 08:02:03 -0700 (PDT)
Date:   Fri, 28 Jul 2023 16:01:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        bbhushan2@marvell.com, gcherian@marvell.com, lcherian@marvell.com
Subject: Re: [PATCH 1/6] perf/marvell: Marvell PEM performance monitor support
Message-ID: <ZMPYYuwg7wHGXft4@FVFF77S0Q05N>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-2-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630120351.1143773-2-gthiagarajan@marvell.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 30, 2023 at 05:33:46PM +0530, Gowthami Thiagarajan wrote:
> PCI Express Interface PMU includes various performance counters to monitor
> the data that is transmitted over the PCIe link. The counters track various
> inbound and outbound transactions which includes separate counters for
> posted/non-posted/completion TLPs. Also, inbound and outbound memory read
> requests along with their latencies can also be monitored. Address
> Translation Services(ATS)events such as ATS Translation, ATS Page Request,
> ATS Invalidation along with their corresponding latencies are also
> supported.
> 
> The performance counters are 64 bits wide.
> 
> For instance,
> perf stat -e ib_tlp_pr <workload>
> tracks the inbound posted TLPs for the workload.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>

This generally looks fine; I have a few comments below.

[...]

> diff --git a/drivers/perf/marvell_pem_pmu.c b/drivers/perf/marvell_pem_pmu.c
> new file mode 100644
> index 000000000000..fb27112aa7d4
> --- /dev/null
> +++ b/drivers/perf/marvell_pem_pmu.c
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell PEM(PCIe RC) Performance Monitor Driver
> + *
> + * Copyright (C) 2023 Marvell.
> + */

Nit: please follow the preferred coding style for comments. This should have a
newline immediately after the '/*', e.g.

	/*
	 * Marvell PEM(PCIe RC) Performance Monitor Driver
	 *
	 * Copyright (C) 2023 Marvell.
	 */

Likewise for all other multi-line comments.
	
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/perf_event.h>
> +
> +/* Each of these events maps to a free running 64 bit counter
> + * with no event control, but can be reset.
> + *
> + */
> +enum pem_events {
> +	IB_TLP_NPR,
> +	IB_TLP_PR,
> +	IB_TLP_CPL,

> +static u64 eventid_to_offset_table[] = {
> +	0x0,
> +	0x8,
> +	0x10,

I assume the event IDs are the values in the pem_events enum, so please use
array initalizers here to make that clear, e.g.

	static u64 eventid_to_offset_table[] = {
		[IB_TLP_NPR]	= 0x0,
		[IB_TLP_PR]	= 0x8,
		[IB_TLP_CPL]	 0x10,
		...
	};

[...]

> +static int pem_perf_event_init(struct perf_event *event)
> +{
> +	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (is_sampling_event(event)) {

Don't we also need to check for:

	event->attach_state & PERF_ATTACH_TASK

> +		dev_info(pmu->dev, "Sampling not supported!\n");
> +		return -EOPNOTSUPP;
> +	}

Please delete this dev_info().

> +
> +	if (event->cpu < 0) {
> +		dev_warn(pmu->dev, "Can't provide per-task data!\n");
> +		return -EOPNOTSUPP;
> +	}

Likewise, please delete this dev_warn().

> +
> +	/*  We must NOT create groups containing mixed PMUs */
> +	if (event->group_leader->pmu != event->pmu &&
> +	    !is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	/* Set ownership of event to one CPU, same event can not be observed
> +	 * on multiple cpus at same time.
> +	 */

Please fix this comment style (or delete the comment).

> +	event->cpu = pmu->cpu;
> +	hwc->idx = -1;
> +	return 0;
> +}

Thanks,
Mark.
