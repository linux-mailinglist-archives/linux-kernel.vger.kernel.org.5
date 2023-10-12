Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B27C6D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378887AbjJLLza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442949AbjJLLzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:55:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E0658C;
        Thu, 12 Oct 2023 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697111603; x=1728647603;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=QAxAyetg73HHGlwaNyN3/g6f3UuJ6ZNcnJXJPuO59jE=;
  b=JqeEw8e1lPrLIr4OT1lSPdhtaMAV/WFgiqH5IS/sT/kmDGnQNieOnp0C
   iXdtsWFBPHuYtmVDLUTx6jIRhshfrUx+bE7FaJ8G6RtK+L9R0+EdSjl9H
   z9ZYQWtAqZBfN5mzfzdL097lb4MrYr+KNL64l7/5ntX7I5Vp1xXbWt1dt
   U2FFKzC7gEFv9ciKgCAp7xJmCbqWAnUWLQd0Upvlj1rKDH9kOdxB6S/Qe
   aeBA5lcIgxlbsD4u0ENcSC50dvw110BeS/ICqZRMfNYFkxCv5HHVDKQRJ
   f0DAIxpc9HTXv+2LV6ohzlFMBeApMoSP0R4auDpZEr3vLaDGdPsu01ZUq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415949459"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="415949459"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870545554"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="870545554"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.84])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:52:22 -0700
Message-ID: <18273cd4-a720-4eab-a14d-f24c5f3299bb@intel.com>
Date:   Thu, 12 Oct 2023 14:52:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] perf intel-pt: Move PMU initialization from
 default config code
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
 <20231007021326.4156714-3-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231007021326.4156714-3-irogers@google.com>
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
> Avoid setting PMU values in intel_pt_pmu_default_config, move to
> perf_pmu__arch_init.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/x86/util/intel-pt.c | 2 --
>  tools/perf/arch/x86/util/pmu.c      | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index b923bca939d9..6d6cd8f9133c 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -267,8 +267,6 @@ intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
>  
>  	attr->config = intel_pt_default_config(intel_pt_pmu);
>  
> -	intel_pt_pmu->selectable = true;
> -
>  	return attr;
>  }
>  
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 811e2377d2d5..949b3e2c67bd 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -22,6 +22,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  #ifdef HAVE_AUXTRACE_SUPPORT
>  	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
>  		pmu->auxtrace = true;
> +		pmu->selectable = true;
>  		pmu->default_config = intel_pt_pmu_default_config(pmu);
>  	}
>  	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {

