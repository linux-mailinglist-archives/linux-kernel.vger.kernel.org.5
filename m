Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A4478E9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjHaJnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjHaJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:43:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45029CFA;
        Thu, 31 Aug 2023 02:43:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 743E9C15;
        Thu, 31 Aug 2023 02:43:58 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2943F738;
        Thu, 31 Aug 2023 02:43:17 -0700 (PDT)
Message-ID: <1486ef1d-6c17-af0a-7df6-bc30640d4825@arm.com>
Date:   Thu, 31 Aug 2023 10:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] perf jevents: Use "default_core" for events with no
 Unit
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230826062203.1058041-1-irogers@google.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230826062203.1058041-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/2023 07:22, Ian Rogers wrote:
> The json Unit field encodes the name of the PMU to match the events
> to. When no name is given it has meant the "cpu" core PMU except for
> tests. On ARM, Intel hybrid and s390 the core PMU is named differently
> which means that using "cpu" for this case causes the events not to
> get matched to the PMU. Introduce a new "default_core" string for this
> case and in the pmu__name_match force all core PMUs to match this
> name.
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Fixes: 2e255b4f9f41 ("perf jevents: Group events by PMU")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/perf/pmu-events/jevents.py |  2 +-
>  tools/perf/tests/pmu-events.c    | 19 ++++++++++---------
>  tools/perf/util/pmu.c            |  7 ++++++-
>  3 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 712f80d7d071..a7e88332276d 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -266,7 +266,7 @@ class JsonEvent:
>      def unit_to_pmu(unit: str) -> Optional[str]:
>        """Convert a JSON Unit to Linux PMU name."""
>        if not unit:
> -        return 'cpu'
> +        return 'default_core'
>        # Comment brought over from jevents.c:
>        # it's not realistic to keep adding these, we need something more scalable ...
>        table = {
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index ce4da9b1d115..f5321fbdee79 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -44,7 +44,7 @@ struct perf_pmu_test_pmu {
>  
>  static const struct perf_pmu_test_event bp_l1_btb_correct = {
>  	.event = {
> -		.pmu = "cpu",
> +		.pmu = "default_core",
>  		.name = "bp_l1_btb_correct",
>  		.event = "event=0x8a",
>  		.desc = "L1 BTB Correction",
> @@ -56,7 +56,7 @@ static const struct perf_pmu_test_event bp_l1_btb_correct = {
>  
>  static const struct perf_pmu_test_event bp_l2_btb_correct = {
>  	.event = {
> -		.pmu = "cpu",
> +		.pmu = "default_core",
>  		.name = "bp_l2_btb_correct",
>  		.event = "event=0x8b",
>  		.desc = "L2 BTB Correction",
> @@ -68,7 +68,7 @@ static const struct perf_pmu_test_event bp_l2_btb_correct = {
>  
>  static const struct perf_pmu_test_event segment_reg_loads_any = {
>  	.event = {
> -		.pmu = "cpu",
> +		.pmu = "default_core",
>  		.name = "segment_reg_loads.any",
>  		.event = "event=0x6,period=200000,umask=0x80",
>  		.desc = "Number of segment register loads",
> @@ -80,7 +80,7 @@ static const struct perf_pmu_test_event segment_reg_loads_any = {
>  
>  static const struct perf_pmu_test_event dispatch_blocked_any = {
>  	.event = {
> -		.pmu = "cpu",
> +		.pmu = "default_core",
>  		.name = "dispatch_blocked.any",
>  		.event = "event=0x9,period=200000,umask=0x20",
>  		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
> @@ -92,7 +92,7 @@ static const struct perf_pmu_test_event dispatch_blocked_any = {
>  
>  static const struct perf_pmu_test_event eist_trans = {
>  	.event = {
> -		.pmu = "cpu",
> +		.pmu = "default_core",
>  		.name = "eist_trans",
>  		.event = "event=0x3a,period=200000,umask=0x0",
>  		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
> @@ -104,7 +104,7 @@ static const struct perf_pmu_test_event eist_trans = {
>  
>  static const struct perf_pmu_test_event l3_cache_rd = {
>  	.event = {
> -		.pmu = "cpu",
> +		.pmu = "default_core",
>  		.name = "l3_cache_rd",
>  		.event = "event=0x40",
>  		.desc = "L3 cache access, read",
> @@ -391,8 +391,8 @@ static int compare_alias_to_test_event(struct pmu_event_info *alias,
>  		return -1;
>  	}
>  
> -
> -	if (!is_same(alias->pmu_name, test_event->event.pmu)) {
> +	if (!is_same(alias->pmu_name, test_event->event.pmu) &&
> +	    !is_same(alias->pmu_name, "default_core")) {
>  		pr_debug("testing aliases PMU %s: mismatched pmu_name, %s vs %s\n",
>  			  pmu_name, alias->pmu_name, test_event->event.pmu);
>  		return -1;
> @@ -409,7 +409,7 @@ static int test__pmu_event_table_core_callback(const struct pmu_event *pe,
>  	struct perf_pmu_test_event const **test_event_table;
>  	bool found = false;
>  
> -	if (strcmp(pe->pmu, "cpu"))
> +	if (strcmp(pe->pmu, "default_core"))
>  		test_event_table = &uncore_events[0];
>  	else
>  		test_event_table = &core_events[0];
> @@ -543,6 +543,7 @@ static int __test_core_pmu_event_aliases(const char *pmu_name, int *count)
>  	INIT_LIST_HEAD(&pmu->caps);
>  	INIT_LIST_HEAD(&pmu->list);
>  	pmu->name = strdup(pmu_name);
> +	pmu->is_core = true;
>  
>  	pmu->events_table = table;
>  	pmu_add_cpu_aliases_table(pmu, table);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 502fd58c3ea7..cde33e01959a 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1747,7 +1747,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
>  {
>  	return !strcmp(pmu->name, pmu_name) ||
> -		(pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->name));
> +		(pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->name)) ||
> +		/*
> +		 * jevents and tests use default_core as a marker for any core
> +		 * PMU as the PMU name varies across architectures.
> +		 */
> +	        (pmu->is_core && !strcmp(pmu_name, "default_core"));
>  }
>  
>  bool perf_pmu__is_software(const struct perf_pmu *pmu)
