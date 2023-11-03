Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772B57E0047
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjKCGz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKCGzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:55:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87C1A131
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:55:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC66B2F4;
        Thu,  2 Nov 2023 23:55:59 -0700 (PDT)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2EE03F67D;
        Thu,  2 Nov 2023 23:55:14 -0700 (PDT)
Message-ID: <33686356-8c61-439d-8c73-b47ef2133cd6@arm.com>
Date:   Fri, 3 Nov 2023 12:25:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raag Jadav <raag.jadav@intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/23 05:46, Ilkka Koskinen wrote:
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

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
