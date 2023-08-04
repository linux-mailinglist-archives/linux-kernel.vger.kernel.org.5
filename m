Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990EB76FA8D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjHDG5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjHDG5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:57:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154331990;
        Thu,  3 Aug 2023 23:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691132266; x=1722668266;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=YF5eThoF16g5LDkzOFEcQves24YrD0KLDG6gRhtI1j0=;
  b=QxmPsINRFjciY4yM8cNx6M2KNRsne1KEUHrfb3PL6RW5bsxWDjhtrVBr
   tcCDcVfnvi+PFy25Ksd+kYizNP+WQmrC5xKjC4vy86wUgw63LXL2Zubid
   MLq8FhY7V356bbOvW4/uomv2q8x0CMNKGi56T8MOdDlFcB42DIN3Gxcg9
   vYY0dILvLhnE6NFDNODqpnnYIKGitCo6HfW9EFxIf0x/nJ8kPTJ3cYYHP
   owgqPJrCG5SHnLX+WsItlbcRihc9zqSqgqHd2mu8zId76kAHAD8s9nUaN
   9XWpdV7PnURWirrRhSISbdZlJnYbE2AT1e4E+Y/KAl7sr0umZm4Qpv0X1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349679826"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="349679826"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060611905"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="1060611905"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.129])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:57:41 -0700
Message-ID: <5b92986f-0e23-fa03-c322-25970cf4e2ac@intel.com>
Date:   Fri, 4 Aug 2023 09:57:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v5 1/7] perf evlist: Add perf_evlist__go_system_wide()
 helper
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230804020741.99806-1-yangjihong1@huawei.com>
 <20230804020741.99806-2-yangjihong1@huawei.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230804020741.99806-2-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/08/23 05:07, Yang Jihong wrote:
> For dummy events that keep tracking, we may need to modify its cpu_maps.
> For example, change the cpu_maps to record sideband events for all CPUS.
> Add perf_evlist__go_system_wide() helper to support this scenario.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/lib/perf/evlist.c                  | 9 +++++++++
>  tools/lib/perf/include/internal/evlist.h | 2 ++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index b8b066d0dc5e..3acbbccc1901 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -738,3 +738,12 @@ int perf_evlist__nr_groups(struct perf_evlist *evlist)
>  	}
>  	return nr_groups;
>  }
> +
> +void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *evsel)
> +{
> +	if (!evsel->system_wide) {
> +		evsel->system_wide = true;
> +		if (evlist->needs_map_propagation)
> +			__perf_evlist__propagate_maps(evlist, evsel);
> +	}
> +}
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 3339bc2f1765..d86ffe8ed483 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -135,4 +135,6 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>  void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
>  
>  void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader);
> +
> +void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *evsel);
>  #endif /* __LIBPERF_INTERNAL_EVLIST_H */

