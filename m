Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC57E0247
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjKCLhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjKCLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:37:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A330C134
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:37:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EADDC15;
        Fri,  3 Nov 2023 04:38:11 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.37.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14DC53F703;
        Fri,  3 Nov 2023 04:37:26 -0700 (PDT)
Date:   Fri, 3 Nov 2023 11:37:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>
Cc:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Raag Jadav <raag.jadav@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
Message-ID: <ZUTbcQcseeoHhl8d@FVFF77S0Q05N>
References: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 05:16:54PM -0700, Ilkka Koskinen wrote:
> Coresight PMU driver didn't reject events meant for other PMUs.
> This caused some of the Core PMU events disappearing from
> the output of "perf list". In addition, trying to run e.g.
> 
>      $ perf stat -e r2 sleep 1
> 
> made Coresight PMU driver to handle the event instead of letting
> Core PMU driver to deal with it.
> 
> Cc: stable@vger.kernel.org
> Fixes: e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU driver")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Will, are you happy to pick this up?

Mark.

> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 42b72042f6b3..2cc35dded007 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -676,6 +676,9 @@ static int arm_cspmu_event_init(struct perf_event *event)
>  
>  	cspmu = to_arm_cspmu(event->pmu);
>  
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
>  	/*
>  	 * Following other "uncore" PMUs, we do not support sampling mode or
>  	 * attach to a task (per-process mode).
> -- 
> 2.40.1
> 
