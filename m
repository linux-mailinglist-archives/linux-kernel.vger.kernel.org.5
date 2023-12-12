Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A19680EFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376481AbjLLPL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjLLPL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:11:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F77BAA;
        Tue, 12 Dec 2023 07:12:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F51E143D;
        Tue, 12 Dec 2023 07:12:49 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEE2D3F738;
        Tue, 12 Dec 2023 07:11:57 -0800 (PST)
Message-ID: <e067c360-56ac-1756-3b3b-4bf5f663be87@arm.com>
Date:   Tue, 12 Dec 2023 15:11:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 10/14] perf top: Avoid repeated function calls
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-11-irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Changbin Du <changbin.du@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Paran Lee <p4ranlee@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231129060211.1890454-11-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/11/2023 06:02, Ian Rogers wrote:
> Add a local variable to avoid repeated calls to perf_cpu_map__nr.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/perf/util/top.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
> index be7157de0451..4db3d1bd686c 100644
> --- a/tools/perf/util/top.c
> +++ b/tools/perf/util/top.c
> @@ -28,6 +28,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
>  	struct record_opts *opts = &top->record_opts;
>  	struct target *target = &opts->target;
>  	size_t ret = 0;
> +	int nr_cpus;
>  
>  	if (top->samples) {
>  		samples_per_sec = top->samples / top->delay_secs;
> @@ -93,19 +94,17 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
>  	else
>  		ret += SNPRINTF(bf + ret, size - ret, " (all");
>  
> +	nr_cpus = perf_cpu_map__nr(top->evlist->core.user_requested_cpus);
>  	if (target->cpu_list)
>  		ret += SNPRINTF(bf + ret, size - ret, ", CPU%s: %s)",
> -				perf_cpu_map__nr(top->evlist->core.user_requested_cpus) > 1
> -				? "s" : "",
> +				nr_cpus > 1 ? "s" : "",
>  				target->cpu_list);
>  	else {
>  		if (target->tid)
>  			ret += SNPRINTF(bf + ret, size - ret, ")");
>  		else
>  			ret += SNPRINTF(bf + ret, size - ret, ", %d CPU%s)",
> -					perf_cpu_map__nr(top->evlist->core.user_requested_cpus),
> -					perf_cpu_map__nr(top->evlist->core.user_requested_cpus) > 1
> -					? "s" : "");
> +					nr_cpus, nr_cpus > 1 ? "s" : "");
>  	}
>  
>  	perf_top__reset_sample_counters(top);
