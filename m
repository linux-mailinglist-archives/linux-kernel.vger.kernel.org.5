Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620427AF0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjIZQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjIZQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:39:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCB2E5;
        Tue, 26 Sep 2023 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695746341; x=1727282341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MDDhGr3aQovmHXfUFdXU2hLWgnvXegVFBPTQjWjZprQ=;
  b=a3ZmMJBJ57Swr3AnhBAlSNxRLlA5TqTufeGBWlYHEU3Y4fK4wUe0M24G
   K9yo15BuMvk4Nr+xRzFJvlAsw+nwxtSSydkj2lsW/9Y0aeeZlJcBoGTgP
   cF6VaDzfodllDMfFJbgHnbmjcVbRPYrSkNULQb6s9WuGq7dVDW1UbJUwB
   dFlJllCBeospOUYdQX0TFGmT/2ihu4x2bx1Y3FxMCP4hMBbKanEbQjAcb
   lqbRqU2/Q01tva7/MdflS7Js8RxkbiYmtUVKnItgg5T0Ud1vplnUmKnZJ
   magaIHVJ+48+0ESwViNIAlliSOZsnEa7K6Piu8ovX3ohbiW3NHs4iQZGH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378890432"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378890432"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864459689"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="864459689"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:39:00 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6C048580BBE;
        Tue, 26 Sep 2023 09:38:58 -0700 (PDT)
Message-ID: <c8250aa5-452a-9e5a-b46f-98e1c35c9e27@linux.intel.com>
Date:   Tue, 26 Sep 2023 12:38:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 24/25] perf stat: Add check to ensure correctness in
 platform that does not support hardware-grouping
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
 <20230925061824.3818631-25-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-25-weilin.wang@intel.com>
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
> Add check and return with -EINVAL when event json files do not support
> hardware aware grouping so that the program could successfully fall back to
> normal grouping without segfault.

Seems another bug fix. Please merge it with the patch which introduce
the feature/bug.

Thanks,
Kan
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 6a4404226..1c89c9371 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1684,6 +1684,8 @@ static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
>  	struct metricgroup__add_metric_event_data *d = data;
>  
>  	if (!strcasecmp(pe->name, d->event_name)) {
> +		if (!pe->counter)
> +			return -EINVAL;
>  		event = event_info__new(d->event_id, pe->pmu, pe->counter,
>  					pe->taken_alone, /*free_counter=*/false);
>  		if (!event)
