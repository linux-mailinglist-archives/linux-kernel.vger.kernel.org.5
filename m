Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610AF802F12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjLDJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjLDJpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:45:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89827B3;
        Mon,  4 Dec 2023 01:45:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92E45FEC;
        Mon,  4 Dec 2023 01:46:45 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.44.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 443083F6C4;
        Mon,  4 Dec 2023 01:45:57 -0800 (PST)
Date:   Mon, 4 Dec 2023 09:45:54 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: perf: arm_pmu: Drop 'pmu_lock' element from
 'struct pmu_hw_events'
Message-ID: <ZW2f0kACNEp7-X-M@FVFF77S0Q05N>
References: <20231115092805.737822-1-anshuman.khandual@arm.com>
 <20231115092805.737822-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115092805.737822-3-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 02:58:05PM +0530, Anshuman Khandual wrote:
> As 'pmu_lock' element is not being used in any ARM PMU implementation, just
> drop this from 'struct pmu_hw_events'.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/arm_pmu.c       | 1 -
>  include/linux/perf/arm_pmu.h | 6 ------
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index d712a19e47ac..379479b50bdd 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -893,7 +893,6 @@ struct arm_pmu *armpmu_alloc(void)
>  		struct pmu_hw_events *events;
>  
>  		events = per_cpu_ptr(pmu->hw_events, cpu);
> -		raw_spin_lock_init(&events->pmu_lock);
>  		events->percpu_pmu = pmu;
>  	}
>  
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 143fbc10ecfe..e2503d48ddee 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -59,12 +59,6 @@ struct pmu_hw_events {
>  	 */
>  	DECLARE_BITMAP(used_mask, ARMPMU_MAX_HWEVENTS);
>  
> -	/*
> -	 * Hardware lock to serialize accesses to PMU registers. Needed for the
> -	 * read/modify/write sequences.
> -	 */
> -	raw_spinlock_t		pmu_lock;
> -
>  	/*
>  	 * When using percpu IRQs, we need a percpu dev_id. Place it here as we
>  	 * already have to allocate this struct per cpu.
> -- 
> 2.25.1
> 
