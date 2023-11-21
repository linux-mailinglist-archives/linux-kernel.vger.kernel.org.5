Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B47F32CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjKUPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjKUPyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:54:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5422199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:53:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527F8C433C7;
        Tue, 21 Nov 2023 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700582030;
        bh=SoS9Ag1+RqC2NSBHSqQi1wvuc0Z8QYMVBqZbJL+ARpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4xoftpBz4krbCJ+RVWs2QWqiTqBBrpytVL5qOIIlmgZhqbid6GcrhnDd/MFhk7qO
         NFQMMBXQrCAW3TegL2vXnU60F8qnK05nICHTWatU4oKdUSLalu0puc6pR6WonuWIpx
         pIqztTOPO3k+MpE358j9gn5vYTsrLwf6Cr4x1GD4G5loQDlzDo2fg8vL1PRE+HegRK
         5+fJvFoaOt6DOh0YjpVBNFbhlfv7mL4Cu+r+NeoyOyRFpWDd4HtL7quXDvJnRjdWlV
         lWWgxdfgUMptOVtJP30JjtiguMxflbDtsxcHXnlOqpyMHiD0B2AOQ+6zh8tWazMmii
         sCNG4BC4n0yJQ==
Date:   Tue, 21 Nov 2023 15:53:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 07/34] perf/arm: optimize opencoded atomic find_bit() API
Message-ID: <20231121155344.GB1938@willie-the-truck>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-8-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118155105.25678-8-yury.norov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 07:50:38AM -0800, Yury Norov wrote:
> Switch subsystem to use atomic find_bit() or atomic iterators as
> appropriate.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/perf/arm-cci.c        | 23 +++++------------------
>  drivers/perf/arm-ccn.c        | 10 ++--------
>  drivers/perf/arm_dmc620_pmu.c |  9 ++-------
>  drivers/perf/arm_pmuv3.c      |  8 ++------
>  4 files changed, 11 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> index 61de861eaf91..70fbf9d09d37 100644
> --- a/drivers/perf/arm-cci.c
> +++ b/drivers/perf/arm-cci.c
> @@ -320,12 +320,8 @@ static int cci400_get_event_idx(struct cci_pmu *cci_pmu,
>  		return CCI400_PMU_CYCLE_CNTR_IDX;
>  	}
>  
> -	for (idx = CCI400_PMU_CNTR0_IDX; idx <= CCI_PMU_CNTR_LAST(cci_pmu); ++idx)
> -		if (!test_and_set_bit(idx, hw->used_mask))
> -			return idx;
> -
> -	/* No counters available */
> -	return -EAGAIN;
> +	idx = find_and_set_bit(hw->used_mask, CCI_PMU_CNTR_LAST(cci_pmu) + 1);

CCI400_PMU_CNTR0_IDX is defined as 1, so isn't this wrong?

[...]

> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> index 30cea6859574..e41c84dabc3e 100644
> --- a/drivers/perf/arm_dmc620_pmu.c
> +++ b/drivers/perf/arm_dmc620_pmu.c
> @@ -303,13 +303,8 @@ static int dmc620_get_event_idx(struct perf_event *event)
>  		end_idx = DMC620_PMU_MAX_COUNTERS;
>  	}
>  
> -	for (idx = start_idx; idx < end_idx; ++idx) {
> -		if (!test_and_set_bit(idx, dmc620_pmu->used_mask))
> -			return idx;
> -	}
> -
> -	/* The counters are all in use. */
> -	return -EAGAIN;
> +	idx = find_and_set_next_bit(dmc620_pmu->used_mask, end_idx, start_idx);

It might just be me, but I'd find this a tonne easier to read if you swapped
the last two arguments around so that the offset came before the limit in
the new function.

Will
