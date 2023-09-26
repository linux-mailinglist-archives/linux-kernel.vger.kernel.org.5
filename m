Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D057AE43E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjIZDhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZDhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:37:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E805C9;
        Mon, 25 Sep 2023 20:37:35 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RvlhN3yXnzNnqX;
        Tue, 26 Sep 2023 11:33:40 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:37:29 +0800
Subject: Re: [RFC PATCH 09/25] perf stat: Add helper functions for
 hardware-grouping method
To:     <weilin.wang@intel.com>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
 <20230925061824.3818631-10-weilin.wang@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <c57ca700-887b-c445-55c3-a3e34745f210@huawei.com>
Date:   Tue, 26 Sep 2023 11:37:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230925061824.3818631-10-weilin.wang@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/9/25 14:18, weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Add functions to free pmu_info_list and event_info_list before exit
> grouping
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>   tools/perf/util/metricgroup.c | 32 ++++++++++++++++++++++++++++----
>   1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index feb5dab26..0ca885a42 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1507,6 +1507,27 @@ static int parse_counter(const char *counter,
>   	return 0;
>   }
>   
> +static void metricgroup__free_event_info(struct list_head
> +					*event_info_list)
> +{
> +	struct metricgroup__event_info *e, *tmp;
> +
> +	list_for_each_entry_safe(e, tmp, event_info_list, nd) {
> +		list_del_init(&e->nd);
> +		free(e);
> +	}
> +}
> +
> +static void metricgroup__free_pmu_info(struct list_head *pmu_info_list)
> +{
> +	struct metricgroup__pmu_counters *p, *tmp;
> +
> +	list_for_each_entry_safe(p, tmp, pmu_info_list, nd) {
> +		list_del_init(&p->nd);
> +		free(p);
> +	}
> +}
> +
>   static struct metricgroup__event_info *event_info__new(const char *name,
>   						      const char *pmu_name,
>   						      const char *counter,
> @@ -1524,7 +1545,8 @@ static struct metricgroup__event_info *event_info__new(const char *name,
>   	}
>   	e->name = name;
>   	e->free_counter = free_counter;
> -	e->pmu_name = strdup(pmu_name);
> +	//e->pmu_name = strdup(pmu_name);
Can the commented-out code be deleted?

> +	e->pmu_name = pmu_name;
>   	if (free_counter) {
>   		ret = set_counter_bitmap(0, e->counters);
>   		if (ret)
> @@ -1687,13 +1709,15 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
>   
>   		ret = get_metricgroup_events(id, etable, &event_info_list);
>   		if (ret)
> -			return ret;
> +			goto err_out;
>   	}
>   	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
>   	if (ret)
> -		return ret;
> -
> +		goto err_out;
There seems to be no need for "goto err_out" here.

>   
> +err_out:
> +	metricgroup__free_event_info(&event_info_list);
> +	metricgroup__free_pmu_info(&pmu_info_list);
>   	return ret;
>   #undef RETURN_IF_NON_ZERO
>   }
> 


Thanks,
Yang
