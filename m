Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61907C6D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378499AbjJLLzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442889AbjJLLzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:55:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B16198;
        Thu, 12 Oct 2023 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697111597; x=1728647597;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Oj8HbFCN1TmF38fodLALxC7xF2mTTbCenSwPteNPHRQ=;
  b=lLmWR7H1AJw+Fh0UvWPgV64CgMdN1L0+31bt9Cz/eo1/ANyEKLPKAL6X
   dmDb5YtJ7HYmGMulk2ZW4jz3PTx7FonHJ3TR2olukJR8TuTyfsxagXbvn
   IOPV1oorKMVc0dkPYUYtxF2BBJkrlAoxcjCM6RTVGYJzdvqU57T9b6WcJ
   Kr8e//0N6yh7U/5Br6xprB/jzY18DwA5YWg39RX3ueKQ1851nwRELjlfr
   wKhZhmOaA0vtAYu2kPX1jLOqtGopRISLejn3OvZD33SQbssjXpXX8E1XW
   PSxzO9LLHQQxvsDzQ/q9PtLMQLMbEzIvIe4l8bgjnREsZxpIgXhFeQjs2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415949365"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="415949365"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870545422"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="870545422"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.84])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:51:52 -0700
Message-ID: <002da48a-c40f-4d6a-881c-59490ea2de95@intel.com>
Date:   Thu, 12 Oct 2023 14:51:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] perf pmu: Rename perf_pmu__get_default_config to
 perf_pmu__arch_init
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231007021326.4156714-1-irogers@google.com>
 <20231007021326.4156714-2-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231007021326.4156714-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 05:13, Ian Rogers wrote:
> Assign default_config as part of the
> init. perf_pmu__get_default_config was doing more than just getting
> the default config and so this is intended to better align with the
> code.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

One cosmetic comment otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/arm/util/pmu.c  |  8 +++-----
>  tools/perf/arch/s390/util/pmu.c |  3 +--
>  tools/perf/arch/x86/util/pmu.c  |  5 ++---
>  tools/perf/util/pmu.c           | 14 +++++++-------
>  tools/perf/util/pmu.h           |  2 +-
>  5 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index a9623b128ece..d55d2b15f2e6 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -14,22 +14,20 @@
>  #include "../../../util/pmu.h"
>  #include "../../../util/cs-etm.h"
>  
> -struct perf_event_attr
> -*perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
> +void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  {
>  #ifdef HAVE_AUXTRACE_SUPPORT
>  	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
>  		/* add ETM default config here */
>  		pmu->selectable = true;
> -		return cs_etm_get_default_config(pmu);
> +		pmu->default_config = cs_etm_get_default_config(pmu);
>  #if defined(__aarch64__)
>  	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
> -		return arm_spe_pmu_default_config(pmu);
> +		pmu->default_config = arm_spe_pmu_default_config(pmu);
>  	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
>  		pmu->selectable = true;
>  #endif
>  	}
>  
>  #endif
> -	return NULL;
>  }
> diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/util/pmu.c
> index 11f03f32e3fd..886c30e001fa 100644
> --- a/tools/perf/arch/s390/util/pmu.c
> +++ b/tools/perf/arch/s390/util/pmu.c
> @@ -13,11 +13,10 @@
>  #define	S390_PMUPAI_EXT		"pai_ext"
>  #define	S390_PMUCPUM_CF		"cpum_cf"
>  
> -struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu)
> +void perf_pmu__arch_init(struct perf_pmu *pmu)
>  {
>  	if (!strcmp(pmu->name, S390_PMUPAI_CRYPTO) ||
>  	    !strcmp(pmu->name, S390_PMUPAI_EXT) ||
>  	    !strcmp(pmu->name, S390_PMUCPUM_CF))
>  		pmu->selectable = true;
> -	return NULL;
>  }
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 8b53ca468a50..811e2377d2d5 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -17,19 +17,18 @@
>  #include "../../../util/pmus.h"
>  #include "env.h"
>  
> -struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
> +void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  {
>  #ifdef HAVE_AUXTRACE_SUPPORT
>  	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
>  		pmu->auxtrace = true;
> -		return intel_pt_pmu_default_config(pmu);
> +		pmu->default_config = intel_pt_pmu_default_config(pmu);
>  	}
>  	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
>  		pmu->auxtrace = true;
>  		pmu->selectable = true;
>  	}
>  #endif
> -	return NULL;
>  }
>  
>  int perf_pmus__num_mem_pmus(void)
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6b1b7f8f00fa..6e95b3d2c2e3 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -954,12 +954,6 @@ void pmu_add_sys_aliases(struct perf_pmu *pmu)
>  	pmu_for_each_sys_event(pmu_add_sys_aliases_iter_fn, pmu);
>  }
>  
> -struct perf_event_attr * __weak
> -perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
> -{
> -	return NULL;
> -}
> -
>  static char *pmu_find_alias_name(struct perf_pmu *pmu, int dirfd)
>  {
>  	FILE *file = perf_pmu__open_file_at(pmu, dirfd, "alias");
> @@ -991,6 +985,12 @@ static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
>  	return max_precise;
>  }
>  
> +

Double blank line

> +void __weak
> +perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> +{
> +}
> +
>  struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name)
>  {
>  	struct perf_pmu *pmu;
> @@ -1037,7 +1037,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
>  	pmu_add_sys_aliases(pmu);
>  	list_add_tail(&pmu->list, pmus);
>  
> -	pmu->default_config = perf_pmu__get_default_config(pmu);
> +	perf_pmu__arch_init(pmu);
>  
>  	return pmu;
>  err:
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 85190d058852..588c64e38d6b 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -233,7 +233,7 @@ bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name);
>  
>  int perf_pmu__test(void);
>  
> -struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
> +void perf_pmu__arch_init(struct perf_pmu *pmu);
>  void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
>  			       const struct pmu_events_table *table);
>  

