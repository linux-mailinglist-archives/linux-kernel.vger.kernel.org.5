Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8055975EC19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjGXG5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjGXG5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:57:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95EDAE55;
        Sun, 23 Jul 2023 23:57:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB63BDE0;
        Sun, 23 Jul 2023 23:58:24 -0700 (PDT)
Received: from [10.162.41.7] (a077893.blr.arm.com [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25C8D3F67D;
        Sun, 23 Jul 2023 23:57:33 -0700 (PDT)
Message-ID: <c784911e-72f4-8150-530b-234978546a45@arm.com>
Date:   Mon, 24 Jul 2023 12:27:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 3/3] perf arm-spe: Support data source for Cortex-X4
 CPU
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Marc Zyngier <maz@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, fissure2010@gmail.com
References: <20230717054327.79815-1-leo.yan@linaro.org>
 <20230717054327.79815-4-leo.yan@linaro.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230717054327.79815-4-leo.yan@linaro.org>
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



On 7/17/23 11:13, Leo Yan wrote:
> We have a CPU list to maintain Neoverse CPUs (N1/N2/V2), this list is
> used for parsing data source packet.  Since Cortex-x4 CPU shares the
> same data source format with Neoverse CPUs, this commit adds Cortex-x4
> CPU into the CPU list so we can reuse the parsing logic.
> 
> The CPU list was assumed for only Neoverse CPUs, but now Cortex-X4 has
> been added into the list.  To avoid Neoverse specific naming, this patch
> renames the variables and function as the default data source format.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/arm-spe.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index afbd5869f6bf..c2cdb9f2e188 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -409,15 +409,16 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
>  
> -static const struct midr_range neoverse_spe[] = {
> +static const struct midr_range cpus_use_default_data_src[] = {

Is not 'cpus_use_default_data_src' too long ? 'use' could be dropped ?

>  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
>  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
>  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
>  	{},
>  };
>  
> -static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
> -						union perf_mem_data_src *data_src)
> +static void arm_spe__synth_data_source_default(const struct arm_spe_record *record,
> +					       union perf_mem_data_src *data_src)
>  {
>  	/*
>  	 * Even though four levels of cache hierarchy are possible, no known
> @@ -518,7 +519,8 @@ static void arm_spe__synth_data_source_generic(const struct arm_spe_record *reco
>  static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
>  {
>  	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
> -	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
> +	bool is_default_dc =

_dc stands for ?

> +		is_midr_in_range_list(midr, cpus_use_default_data_src);
>  
>  	if (record->op & ARM_SPE_OP_LD)
>  		data_src.mem_op = PERF_MEM_OP_LOAD;
> @@ -527,8 +529,8 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
>  	else
>  		return 0;
>  
> -	if (is_neoverse)
> -		arm_spe__synth_data_source_neoverse(record, &data_src);
> +	if (is_default_dc)
> +		arm_spe__synth_data_source_default(record, &data_src);
>  	else
>  		arm_spe__synth_data_source_generic(record, &data_src);
>  
