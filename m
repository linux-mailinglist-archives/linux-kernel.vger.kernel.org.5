Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E557AF07A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjIZQS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjIZQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:18:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22174AF;
        Tue, 26 Sep 2023 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695745101; x=1727281101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A9jrx3tFlJDnW5UDsrNm7zRxi6LjPePTrAxC7omemIg=;
  b=gGObSqN7r/mLLDF3ID/Onac+rAOwPLjIUQuwJjyhdE2s8T3AJcc6ZJ9z
   JJneD/L7dxddSxBkqrCZDnmdbsEE1CclVXvgugubuKCn9TPwcFcC6zb/x
   xig+fsN80rFBe6CjZW769DSRR0X6IAZue9A2hqCkWiLg/dqm47w3pTISP
   K02IKsO2LyuCOYplY8IAoeEoZrJiSvO3WlKcxkiyyaltTDWc6SIXQT1o+
   N1W3BJU5QZj/rJvCYCbCnxE4+U5RetCTK7XZGFUmqbgRNE/wozduuibb9
   KQm81OhnHNvjy62t3WvDoevBmxLwzUlIixQZ70xSkpU0EdqRc3jUS2W5i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381505902"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="381505902"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:18:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="203932"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:17:50 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C7571580BBE;
        Tue, 26 Sep 2023 09:18:17 -0700 (PDT)
Message-ID: <81539684-f673-8af5-ff94-fe90a81a06e9@linux.intel.com>
Date:   Tue, 26 Sep 2023 12:18:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 13/25] perf stat: Add functions to hardware-grouping
 method
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
 <20230925061824.3818631-14-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-14-weilin.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-25 2:18 a.m., weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Add functions to free all the group lists before exit metric grouping
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 39 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8d54e71bf..4b1b0470d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1528,6 +1528,38 @@ static int parse_counter(const char *counter,
>  	return 0;
>  }
>  
> +static void group_event_list_free(struct metricgroup__group *groups)
> +{
> +	struct metricgroup__group_events *e, *tmp;
> +
> +	list_for_each_entry_safe (e, tmp, &groups->event_head, nd) {
> +		list_del_init(&e->nd);
> +		free(e);
> +	}
> +}
> +
> +static void group_list_free(struct metricgroup__pmu_group_list *groups)
> +{
> +	struct metricgroup__group *g, *tmp;
> +
> +	list_for_each_entry_safe (g, tmp, &groups->group_head, nd) {
> +		list_del_init(&g->nd);
> +		group_event_list_free(g);
> +		free(g);
> +	}
> +}
> +
> +static void metricgroup__free_group_list(struct list_head *groups)
> +{
> +	struct metricgroup__pmu_group_list *g, *tmp;
> +
> +	list_for_each_entry_safe (g, tmp, groups, nd) {
> +		list_del_init(&g->nd);
> +		group_list_free(g);
> +		free(g);
> +	}
> +}
> +
>  static void metricgroup__free_event_info(struct list_head
>  					*event_info_list)
>  {
> @@ -1845,6 +1877,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
>  		struct metricgroup__pmu_counters *p;
>  
>  		pmu_group_head = malloc(sizeof(struct metricgroup__pmu_group_list));
> +		if (!pmu_group_head)
> +			return -ENOMEM;

I think it's better to combine the free and init/alloc into a single patch.

Thanks,
Kan

>  		INIT_LIST_HEAD(&pmu_group_head->group_head);
>  		pr_debug("create new group for event %s in pmu %s\n", e->name, e->pmu_name);
>  		pmu_group_head->pmu_name = e->pmu_name;
> @@ -1886,8 +1920,11 @@ static int create_grouping(struct list_head *pmu_info_list,
>  		pr_debug("Event name %s, [pmu]=%s, [counters]=%s\n", e->name,
>  			e->pmu_name, bit_buf);
>  		ret = assign_event_grouping(e, pmu_info_list, &groups);
> +		if (ret)
> +			goto out;
>  	}
> -
> +out:
> +	metricgroup__free_group_list(&groups);
>  	return ret;
>  };
>  
