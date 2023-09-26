Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7157AF0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjIZQgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjIZQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:36:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2554124;
        Tue, 26 Sep 2023 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695746199; x=1727282199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W9JR7UKiiB5qX/Bnbhhy9qpsfgN7ArWX+EkyPOjLqrU=;
  b=PVug25ZFyqoRbxS2OTEc6WKP+MQj1KgVq9JkX0l1QhazQcIEq2eeZyPO
   WCCELkgbPkU8MLqFZMM+mzxWwSYs5XKsrMVxd9ffwStO1Q0rDddIVAf90
   VQdGkDlzSjVyCLz5tM0hKJtG3j93pyKIeay13uJGirEQVJO2jFR0X7Bao
   d5rfXxbTb5wdmale1bSqtFlFwwKIwqevv+STXrhB83N2K9hobRGdqu+50
   Fihu2AsTvq8wi5MgPTbU9uhm87dyT/FER5E++WlKN4ds2/bB2JQXnx71m
   jIZUM0VWNcDjBSzhhmc99+hqq0Ksxrp+Ov4Il41ZpC6fLOrejvSU/LtX5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380480448"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="380480448"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1079766210"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="1079766210"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:36:38 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 120E3580BBE;
        Tue, 26 Sep 2023 09:36:35 -0700 (PDT)
Message-ID: <bb2db7bf-a1cb-c109-80f5-7e7be23c8b95@linux.intel.com>
Date:   Tue, 26 Sep 2023 12:36:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 23/25] perf stat: Fix a return error issue in
 hardware-grouping
Content-Language: en-US
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
 <20230925061824.3818631-24-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-24-weilin.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-25 2:18 a.m., weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Update the hw_aware_parse_ids() goto to improve error handling.
> 

Seems like a bug fix. Please merge it with the patch which introduces
the issue.

Thanks,
Kan
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 07a82fa21..6a4404226 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -2196,11 +2196,11 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
>  	*out_evlist = NULL;
>  	ret = hw_aware_build_grouping(ids, &grouping);
>  	if (ret)
> -		goto err_out;
> +		goto out;
>  	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier,
>  						      tool_events, &grouping);
>  	if (ret)
> -		goto err_out;
> +		goto out;
>  
>  	parsed_evlist = evlist__new();
>  	if (!parsed_evlist) {
> @@ -2225,10 +2225,11 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
>  	*out_evlist = parsed_evlist;
>  	parsed_evlist = NULL;
>  err_out:
> -	metricgroup__free_group_list(&grouping);
> -	metricgroup__free_grouping_strs(&grouping_str);
>  	parse_events_error__exit(&parse_error);
>  	evlist__delete(parsed_evlist);
> +out:
> +	metricgroup__free_group_list(&grouping);
> +	metricgroup__free_grouping_strs(&grouping_str);
>  	return ret;
>  }
>  
