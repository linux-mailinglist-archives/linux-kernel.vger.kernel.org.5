Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1950B7AE444
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjIZDpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZDpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:45:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9006D7;
        Mon, 25 Sep 2023 20:44:59 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rvlsp4Z09zTm2F;
        Tue, 26 Sep 2023 11:41:50 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:44:56 +0800
Subject: Re: [RFC PATCH 10/25] perf stat: Add helper functions to
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
 <20230925061824.3818631-11-weilin.wang@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <7751b63e-d8cf-85b0-b64e-5f656244a2c9@huawei.com>
Date:   Tue, 26 Sep 2023 11:44:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230925061824.3818631-11-weilin.wang@intel.com>
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
> Add struct metricgroup__pmu_group_list to hold the lists of groups from
> different PMUs. Each PMU has one separate list.
> 
> Add struct metricgroup__group as one node (one group in the grouping
> result) of the metricgroup__pmu_group_list. It uses two bitmaps to log
> counter availabilities(gp counters and fixed counters).
> 
> Add functions to create group and assign event into the groups based on the
> event restrictions (struct metricgroup__event_info) and counter
> availability (pmu_info_list and bitmaps). New group is inserted into the
> list groups.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>   tools/perf/util/metricgroup.c | 72 +++++++++++++++++++++++++++++++++++
>   tools/perf/util/metricgroup.h | 37 ++++++++++++++++++
>   2 files changed, 109 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 0ca885a42..de6a6a1d7 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1681,6 +1681,76 @@ static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
>   	return ret;
>   }
>   
> +/**
> + * assign_event_grouping - Assign an event into a group. If existing group
> + * cannot include it, create a new group and insert the event to it.
> + */
> +static int assign_event_grouping(struct metricgroup__event_info *e,
> +				struct list_head *pmu_info_list __maybe_unused,
> +				struct list_head *groups)
> +{
> +	int ret = 0;
> +
> +	struct metricgroup__pmu_group_list *g = NULL;
> +	struct metricgroup__pmu_group_list *pmu_group_head = NULL;
> +
> +	list_for_each_entry(g, groups, nd) {
> +		if (!strcasecmp(g->pmu_name, e->pmu_name)) {
> +			pr_debug("found group for event %s in pmu %s\n", e->name, g->pmu_name);
> +			pmu_group_head = g;
> +			break;
> +		}
> +	}
> +	if (!pmu_group_head) {
> +		struct metricgroup__pmu_counters *p;
> +
> +		pmu_group_head = malloc(sizeof(struct metricgroup__pmu_group_list));
Here may need to check the return value of malloc.

> +		INIT_LIST_HEAD(&pmu_group_head->group_head);
> +		pr_debug("create new group for event %s in pmu %s ", e->name, e->pmu_name);
> +		pmu_group_head->pmu_name = e->pmu_name;
> +		list_for_each_entry(p, pmu_info_list, nd) {
> +			if (!strcasecmp(p->name, e->pmu_name)) {
> +				pmu_group_head->size = p->size;
> +				pmu_group_head->fixed_size = p->fixed_size;
> +			}
> +		}
> +		list_add_tail(&pmu_group_head->nd, groups);
> +	}
> +
> +	//ret = insert_event_to_group(e, pmu_group_head, pmu_info_list);
This is also the commented out code. Can it delete?

> +	return ret;
> +}
> +
> +/**
> + * create_grouping - Create a list of groups and place all the events of
> + * event_info_list into these groups.
> + * @pmu_info_list: the list of PMU units info based on pmu-events data, used for
> + * creating new groups.
> + * @event_info_list: the list of events to be grouped.
> + * @groupings: the list of groups with events placed in.
> + * @modifier: any modifiers added to the events.
> + */
> +static int create_grouping(struct list_head *pmu_info_list,
> +			  struct list_head *event_info_list,
> +			  struct list_head *groupings __maybe_unused,
> +			  const char *modifier __maybe_unused)
> +{
> +	int ret = 0;
> +	struct metricgroup__event_info *e;
> +	LIST_HEAD(groups);
> +	char *bit_buf = malloc(NR_COUNTERS);
Similar to the above, may need to check the malloc return value.

Thanks,
Yang
