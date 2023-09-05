Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFF7792B50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjIEQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354107AbjIEJjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:39:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 566C21A7;
        Tue,  5 Sep 2023 02:39:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C5D011FB;
        Tue,  5 Sep 2023 02:40:18 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F9D93F793;
        Tue,  5 Sep 2023 02:39:38 -0700 (PDT)
Message-ID: <c4833297-da67-3337-b3d1-b628b1282a8a@arm.com>
Date:   Tue, 5 Sep 2023 10:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/6] perf parse-events: Fixes relating to no_value
 terms
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
References: <20230901233949.2930562-1-irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230901233949.2930562-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2023 00:39, Ian Rogers wrote:
> A term may have no value in which case it is assumed to have a value
> of 1. It doesn't just apply to alias/event terms so change the
> parse_events_term__to_strbuf assert.
> 
> Commit 99e7138eb789 ("perf tools: Fail on using multiple bits long
> terms without value") made it so that no_value terms could only be for
> a single bit. Prior to commit 64199ae4b8a3 ("perf parse-events: Fix
> propagation of term's no_value when cloning") this missed a test case
> where config1 had no_value.
> 
> Fixes: 64199ae4b8a3 ("perf parse-events: Fix propagation of term's no_value when cloning")
> Signed-off-by: Ian Rogers <irogers@google.com>

For the whole set:

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/perf/tests/parse-events.c | 2 +-
>  tools/perf/util/parse-events.c  | 2 +-
>  tools/perf/util/parse-events.h  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index d86076d575ed..d47f1f871164 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2170,7 +2170,7 @@ static const struct evlist_test test__events[] = {
>  
>  static const struct evlist_test test__events_pmu[] = {
>  	{
> -		.name  = "cpu/config=10,config1,config2=3,period=1000/u",
> +		.name  = "cpu/config=10,config1=1,config2=3,period=1000/u",
>  		.valid = test__pmu_cpu_valid,
>  		.check = test__checkevent_pmu,
>  		/* 0 */
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 68fe2c4ff49f..65608a3cba81 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2607,7 +2607,7 @@ int parse_events_term__to_strbuf(struct list_head *term_list, struct strbuf *sb)
>  
>  		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
>  			if (term->no_value) {
> -				assert(term->type_term == PARSE_EVENTS__TERM_TYPE_USER);
> +				assert(term->val.num == 1);
>  				ret = strbuf_addf(sb, "%s", term->config);
>  			} else
>  				ret = strbuf_addf(sb, "%s=%#"PRIx64, term->config, term->val.num);
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 855b0725c5d4..594e5d2dc67f 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -124,8 +124,8 @@ struct parse_events_term {
>  	 */
>  	bool weak;
>  	/**
> -	 * @no_value: Is there no value. TODO: this should really be part of
> -	 * type_val.
> +	 * @no_value: Is there no value. If a numeric term has no value then the
> +	 * value is assumed to be 1. An event name also has no value.
>  	 */
>  	bool no_value;
>  };
