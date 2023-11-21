Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE77F32D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjKUPzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjKUPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:55:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41146132
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:54:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602F7C433C8;
        Tue, 21 Nov 2023 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700582096;
        bh=nUNQwOHk4EELbIput1hMEvEcgZjaGuxBlZjCetzZAIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmG1JEOTrepgRO1Uwkv5Pi/eAe3djSEGUAhsS6kO3BfC5of3+YrT30v/wXDJDU1+z
         5e7k9H1CC4PoUAx6DKYDACr7PKB+vPxX/RvBLeH0mrpY0zQaqdotr5R6oIqazwpvKG
         opTK/QY8os/L2fQXAXILGR82HUTxxHKRnm+vMskJ2wFmo7dBeWDE3JCVFviEjKIbVK
         YypKP2cszURHsv/cUz2of3HonbpVaYyxSZ0v8fmli48Z0rCTkUAANVuCOZ9Kmc0asX
         3m24gMqKnoHHsco722BraL7TS5+Y5JHXaOTlx4a+wrhsIKlQ5ka7eWiFbkzsNWqTJG
         MNhH8x91xYVoQ==
Date:   Tue, 21 Nov 2023 15:54:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 08/34] drivers/perf: optimize ali_drw_get_counter_idx()
 by using find_bit()
Message-ID: <20231121155450.GC1938@willie-the-truck>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-9-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118155105.25678-9-yury.norov@gmail.com>
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

On Sat, Nov 18, 2023 at 07:50:39AM -0800, Yury Norov wrote:
> The function searches used_mask for a set bit in a for-loop bit by bit.
> We can do it faster by using atomic find_and_set_bit().
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/perf/alibaba_uncore_drw_pmu.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index 19d459a36be5..2a3b7701d568 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -274,15 +274,9 @@ static const struct attribute_group *ali_drw_pmu_attr_groups[] = {
>  static int ali_drw_get_counter_idx(struct perf_event *event)
>  {
>  	struct ali_drw_pmu *drw_pmu = to_ali_drw_pmu(event->pmu);
> -	int idx;
> +	int idx = find_and_set_bit(drw_pmu->used_mask, ALI_DRW_PMU_COMMON_MAX_COUNTERS);
>  
> -	for (idx = 0; idx < ALI_DRW_PMU_COMMON_MAX_COUNTERS; ++idx) {
> -		if (!test_and_set_bit(idx, drw_pmu->used_mask))
> -			return idx;
> -	}
> -
> -	/* The counters are all in use. */
> -	return -EBUSY;
> +	return idx < ALI_DRW_PMU_COMMON_MAX_COUNTERS ? idx : -EBUSY;
>  }
>  
>  static u64 ali_drw_pmu_read_counter(struct perf_event *event)
> -- 
> 2.39.2

Acked-by: Will Deacon <will@kernel.org>

Will

