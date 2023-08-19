Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFEF781750
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 06:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjHSEQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 00:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjHSEQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 00:16:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CCD1706;
        Fri, 18 Aug 2023 21:16:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RSQMV2ZnSzFqgl;
        Sat, 19 Aug 2023 12:13:10 +0800 (CST)
Received: from [10.174.179.211] (10.174.179.211) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 19 Aug 2023 12:16:09 +0800
Message-ID: <b244a320-5f00-d382-a4ab-0168a80c55fe@huawei.com>
Date:   Sat, 19 Aug 2023 12:16:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] perf header: Fix missing PMU caps
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230818171952.3719251-1-irogers@google.com>
From:   "liwei (GF)" <liwei391@huawei.com>
In-Reply-To: <20230818171952.3719251-1-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.211]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian:

On 2023/8/19 1:19, Ian Rogers wrote:
> PMU caps are written as HEADER_PMU_CAPS or for the special case of the
> PMU "cpu" as HEADER_CPU_PMU_CAPS. As the PMU "cpu" is special, and not
> any "core" PMU, the logic had become broken and core PMUs not called
> "cpu" were not having their caps written. This affects ARM and s390
> non-hybrid PMUs.
> 
> Simplify the PMU caps writing logic to scan one fewer time and to be
> more explicit in its behavior.
> 
> Reported-by: Wei Li <liwei391@huawei.com>
> Fixes: 178ddf3bad98 ("perf header: Avoid hybrid PMU list in write_pmu_caps")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/header.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 52fbf526fe74..13c71d28e0eb 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1605,8 +1605,15 @@ static int write_pmu_caps(struct feat_fd *ff,
>  	int ret;
>  
>  	while ((pmu = perf_pmus__scan(pmu))) {
> -		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
> -		    perf_pmu__caps_parse(pmu) <= 0)
> +		if (!strcmp(pmu->name, "cpu")) {

So you removed the check of 'pmu->name', does this check really redundant? since
we can find such checks in many places in the perf code. If not, i think it is
necessary for strcmp().

> +			/*
> +			 * The "cpu" PMU is special and covered by
> +			 * HEADER_CPU_PMU_CAPS. Note, core PMUs are
> +			 * counted/written here for ARM, s390 and Intel hybrid.
> +			 */
> +			continue;
> +		}
> +		if (perf_pmu__caps_parse(pmu) <= 0)
>  			continue;
>  		nr_pmu++;
>  	}
> @@ -1619,23 +1626,17 @@ static int write_pmu_caps(struct feat_fd *ff,
>  		return 0;
>  
>  	/*
> -	 * Write hybrid pmu caps first to maintain compatibility with
> -	 * older perf tool.
> +	 * Note older perf tools assume core PMUs come first, this is a property
> +	 * of perf_pmus__scan.
>  	 */
> -	if (perf_pmus__num_core_pmus() > 1) {
> -		pmu = NULL;
> -		while ((pmu = perf_pmus__scan_core(pmu))) {
> -			ret = __write_pmu_caps(ff, pmu, true);
> -			if (ret < 0)
> -				return ret;
> -		}
> -	}
> -
>  	pmu = NULL;
>  	while ((pmu = perf_pmus__scan(pmu))) {
> -		if (pmu->is_core || !pmu->nr_caps)
> +		if (!strcmp(pmu->name, "cpu")) {

same here

Thanks,
Wei

> +			/* Skip as above. */
> +			continue;
> +		}
> +		if (perf_pmu__caps_parse(pmu) <= 0)
>  			continue;
> -
>  		ret = __write_pmu_caps(ff, pmu, true);
>  		if (ret < 0)
>  			return ret;
