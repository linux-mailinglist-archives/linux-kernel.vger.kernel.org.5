Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46747C6D74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378440AbjJLL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347237AbjJLLzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:55:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41276A7C;
        Thu, 12 Oct 2023 04:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697111626; x=1728647626;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=LnqL56wi3grFaEumVNjs3QvHBuvjmv7Ccggb/DBIQy4=;
  b=YlWQgk0jl91Jn6hczrXmhpfSkReGzile50pyyU+SXwfsbO0/JW5zsMml
   kRNNs69le8XLTmynHUeMbIP9PIGKWbkX9NxX9F09boBjZEitcPrSLsths
   JQsEzqWxvVCWahTTo38KQuxpiT97uil62OFlQA+RAIzQ/f3moauh3Qv5Z
   DMhengMMn7k+bbozkBblhEw2M9994f22TJggbAbPa11uRT7W+F7SpRpjx
   P+Ca1Nm+KS4IBz4DGBs+qE+8TZG/JTUfLWpeAnwKj6N35xWKGoHtHy5Xp
   IrWMjaly1OBXsEtPfJuElXzjyXkDsiqJqtZuLfz7uWJ1q/t18eT9ASIRy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415949525"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="415949525"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870545678"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="870545678"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.84])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:52:53 -0700
Message-ID: <5779887c-d712-40d2-963b-8c912b8cf5fc@intel.com>
Date:   Thu, 12 Oct 2023 14:52:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/7] perf pmu: Const-ify file APIs
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
 <20231007021326.4156714-5-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231007021326.4156714-5-irogers@google.com>
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
> File APIs don't alter the struct pmu so allow const ones to be passed.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/pmu.c    | 12 ++++++------
>  tools/perf/util/pmu.h    | 11 ++++++-----
>  tools/perf/util/python.c |  2 +-
>  3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6e95b3d2c2e3..e11901c923d7 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -575,7 +575,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
>  	return 0;
>  }
>  
> -static inline bool pmu_alias_info_file(char *name)
> +static inline bool pmu_alias_info_file(const char *name)
>  {
>  	size_t len;
>  
> @@ -1771,7 +1771,7 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
>  	return !strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe");
>  }
>  
> -FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
> +FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name)
>  {
>  	char path[PATH_MAX];
>  
> @@ -1782,7 +1782,7 @@ FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
>  	return fopen(path, "r");
>  }
>  
> -FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name)
> +FILE *perf_pmu__open_file_at(const struct perf_pmu *pmu, int dirfd, const char *name)
>  {
>  	int fd;
>  
> @@ -1793,7 +1793,7 @@ FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name)
>  	return fdopen(fd, "r");
>  }
>  
> -int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
> +int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt,
>  			...)
>  {
>  	va_list args;
> @@ -1810,7 +1810,7 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
>  	return ret;
>  }
>  
> -int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
> +int perf_pmu__scan_file_at(const struct perf_pmu *pmu, int dirfd, const char *name,
>  			   const char *fmt, ...)
>  {
>  	va_list args;
> @@ -1827,7 +1827,7 @@ int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
>  	return ret;
>  }
>  
> -bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name)
> +bool perf_pmu__file_exists(const struct perf_pmu *pmu, const char *name)
>  {
>  	char path[PATH_MAX];
>  
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 588c64e38d6b..24af7297b522 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -222,14 +222,15 @@ bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name);
>   */
>  bool perf_pmu__is_software(const struct perf_pmu *pmu);
>  
> -FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
> -FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name);
> +FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name);
> +FILE *perf_pmu__open_file_at(const struct perf_pmu *pmu, int dirfd, const char *name);
>  
> -int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
> -int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
> +int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt, ...)
> +	__scanf(3, 4);
> +int perf_pmu__scan_file_at(const struct perf_pmu *pmu, int dirfd, const char *name,
>  			   const char *fmt, ...) __scanf(4, 5);
>  
> -bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name);
> +bool perf_pmu__file_exists(const struct perf_pmu *pmu, const char *name);
>  
>  int perf_pmu__test(void);
>  
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index c29f5f0bb552..8761f51b5c7c 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -98,7 +98,7 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel __maybe_unused)
>  	return NULL;
>  }
>  
> -int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...)
> +int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt, ...)
>  {
>  	return EOF;
>  }

