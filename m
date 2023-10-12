Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343B17C6D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347218AbjJLLzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442961AbjJLLzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:55:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520265A0;
        Thu, 12 Oct 2023 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697111607; x=1728647607;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gctK71zo6mU9YBXPKhgvnbP3DBiV6PqC8v9oU1p5Z8I=;
  b=G73GJrIZ1aDvjxYK6R+hJV9Ta3S9B+zAuiL+e59zRGpPMyyJ5xO1s4bl
   uYFSfDiwShBPyunIafpNCnz2RR17idratMED1kvUuIKeTs8568+cb/aee
   r2MWYFJbRIBUzRp0spIRYHclItBDb4Qssx0cIlUSHjwcmecuPIfgj/Dug
   UxV6uDSArzSBF0FqVKSVAVuc28zAdd2hdUjiTPekuJI1I0VUhxTIXejAA
   3EbVOKL9iS3pJVP9P+/WNvXJ+QgrUTqBKOCH0w91xzDM9Ny3zlTfdZf9U
   /19psmJs7e+FXKuHYNJjUMtTiLnypqhxVXXBHT7jrFDT78/EtXa0lVbol
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415949494"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="415949494"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870545611"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="870545611"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.84])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:52:38 -0700
Message-ID: <c0aa0f90-21bc-43b3-9498-6b34997c348d@intel.com>
Date:   Thu, 12 Oct 2023 14:52:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] perf arm-spe: Move PMU initialization from default
 config code
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
 <20231007021326.4156714-4-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231007021326.4156714-4-irogers@google.com>
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
> Avoid setting PMU values in arm_spe_pmu_default_config, move to
> perf_pmu__arch_init.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/arm/util/pmu.c       | 2 ++
>  tools/perf/arch/arm64/util/arm-spe.c | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index d55d2b15f2e6..f25f68f84a94 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -23,6 +23,8 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  		pmu->default_config = cs_etm_get_default_config(pmu);
>  #if defined(__aarch64__)
>  	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
> +		pmu->selectable = true;
> +		pmu->is_uncore = false;
>  		pmu->default_config = arm_spe_pmu_default_config(pmu);
>  	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
>  		pmu->selectable = true;
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 9cc3d6dcb849..08a76734ccd2 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -516,8 +516,5 @@ struct perf_event_attr
>  		attr->sample_period = 4096;
>  	}
>  
> -	arm_spe_pmu->selectable = true;
> -	arm_spe_pmu->is_uncore = false;
> -
>  	return attr;
>  }

