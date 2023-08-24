Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF23787399
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbjHXPGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbjHXPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:05:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 132FFFD;
        Thu, 24 Aug 2023 08:05:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5679D75;
        Thu, 24 Aug 2023 08:06:31 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B82353F762;
        Thu, 24 Aug 2023 08:05:48 -0700 (PDT)
Message-ID: <cbd34ed6-3220-3c0c-74bc-46a2baa744e5@arm.com>
Date:   Thu, 24 Aug 2023 16:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 1/8] perf pmu: "Compat" supports matching multiple
 identifiers
Content-Language: en-GB
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1692606977-92009-2-git-send-email-renyu.zj@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1692606977-92009-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 9:36 am, Jing Zhang wrote:
> The jevent "Compat" is used for uncore PMU alias or metric definitions.
> 
> The same PMU driver has different PMU identifiers due to different
> hardware versions and types, but they may have some common PMU event.
> Since a Compat value can only match one identifier, when adding the
> same event alias to PMUs with different identifiers, each identifier
> needs to be defined once, which is not streamlined enough.
> 
> So let "Compat" supports matching multiple identifiers for uncore PMU
> alias. For example, the Compat value {43401;436*} can match the PMU
> identifier "43401", that is, CMN600_r0p0, and the PMU identifier with
> the prefix "436", that is, all CMN650, where "*" is a wildcard.
> Tokens in Unit field are delimited by ';' with no spaces.

I wonder is there any possibility of supporting multiple values as a 
JSON array, rather than a single delimited string? Otherwise, if we're 
putting restrictions on what characters a driver can expose as an 
identifier, then I think that really wants explicitly documenting. 
AFAICT there's currently not even any documentation of the de-facto ABI 
that it's expected to be a free-form string rather than completely 
arbitrary binary data.

Thanks,
Robin.

> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---
>   tools/perf/util/pmu.c | 33 +++++++++++++++++++++++++++++++--
>   tools/perf/util/pmu.h |  1 +
>   2 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index ad209c8..6402423 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -776,6 +776,35 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>   	return res;
>   }
>   
> +bool pmu_uncore_identifier_match(const char *id, const char *compat)
> +{
> +	char *tmp = NULL, *tok, *str;
> +	bool res;
> +	int n;
> +
> +	/*
> +	 * The strdup() call is necessary here because "compat" is a const str*
> +	 * type and cannot be used as an argument to strtok_r().
> +	 */
> +	str = strdup(compat);
> +	if (!str)
> +		return false;
> +
> +	tok = strtok_r(str, ";", &tmp);
> +	for (; tok; tok = strtok_r(NULL, ";", &tmp)) {
> +		n = strlen(tok);
> +		if ((tok[n - 1] == '*' && !strncmp(id, tok, n - 1)) ||
> +		    !strcmp(id, tok)) {
> +			res = true;
> +			goto out;
> +		}
> +	}
> +	res = false;
> +out:
> +	free(str);
> +	return res;
> +}
> +
>   struct pmu_add_cpu_aliases_map_data {
>   	struct list_head *head;
>   	const char *name;
> @@ -847,8 +876,8 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
>   	if (!pe->compat || !pe->pmu)
>   		return 0;
>   
> -	if (!strcmp(pmu->id, pe->compat) &&
> -	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
> +	if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
> +	    pmu_uncore_identifier_match(pmu->id, pe->compat)) {
>   		__perf_pmu__new_alias(idata->head, -1,
>   				      (char *)pe->name,
>   				      (char *)pe->desc,
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index b9a02de..9d4385d 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -241,6 +241,7 @@ void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
>   char *perf_pmu__getcpuid(struct perf_pmu *pmu);
>   const struct pmu_events_table *pmu_events_table__find(void);
>   const struct pmu_metrics_table *pmu_metrics_table__find(void);
> +bool pmu_uncore_identifier_match(const char *id, const char *compat);
>   void perf_pmu_free_alias(struct perf_pmu_alias *alias);
>   
>   int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
