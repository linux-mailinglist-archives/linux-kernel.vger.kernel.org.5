Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9C97608B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjGYEll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGYEli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:41:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8795910D1;
        Mon, 24 Jul 2023 21:41:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 768CE11FB;
        Mon, 24 Jul 2023 21:42:20 -0700 (PDT)
Received: from [10.163.51.115] (unknown [10.163.51.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1AB93F67D;
        Mon, 24 Jul 2023 21:41:29 -0700 (PDT)
Message-ID: <354fcd14-e86a-fe51-2613-6194b85efd25@arm.com>
Date:   Tue, 25 Jul 2023 10:11:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] arm_pmu: Remove unused
 PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        will@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230724134500.970496-1-james.clark@arm.com>
 <20230724134500.970496-4-james.clark@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230724134500.970496-4-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 19:14, James Clark wrote:
> Since commit bd2756811766 ("perf: Rewrite core context handling") the
> relationship between perf_event_context and PMUs has changed so that
> the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
> silenced no longer exists.
> 
> Remove the capability and associated comment to avoid confusion that it
> actually influences any perf core behavior. This change should be a
> no-op.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  drivers/perf/arm_pmu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 2e79201daa4a..d712a19e47ac 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -877,15 +877,12 @@ struct arm_pmu *armpmu_alloc(void)
>  		.attr_groups	= pmu->attr_groups,
>  		/*
>  		 * This is a CPU PMU potentially in a heterogeneous
> -		 * configuration (e.g. big.LITTLE). This is not an uncore PMU,
> -		 * and we have taken ctx sharing into account (e.g. with our
> -		 * pmu::filter callback and pmu::event_init group validation).
> -		 *
> +		 * configuration (e.g. big.LITTLE) so
>  		 * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open
>  		 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
>  		 * specific PMU.
>  		 */
> -		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS |
> +		.capabilities	= PERF_PMU_CAP_EXTENDED_REGS |
>  				  PERF_PMU_CAP_EXTENDED_HW_TYPE,
>  	};
>  
