Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2890C79078E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352035AbjIBLLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjIBLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:11:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB26E5B;
        Sat,  2 Sep 2023 04:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D00260ABD;
        Sat,  2 Sep 2023 11:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E38BC433C8;
        Sat,  2 Sep 2023 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693653078;
        bh=UUmZbegS54x8YszypsKqjuWfpppoUM06IXqVKKqUn+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5PsOi7OIT2dwbDaHo6q53FeCjFePvyOsO51psdH3OW4VJZfXjcCu/wr9FC6jLV1D
         Jm79ndlmEvkeW72Dbt8eZtk3/tfaIdUPXI3sbMDTO7+SpFNKxGh9yqcSzTYt8l0ySA
         HUUpomsLAnDHBc3L7kZ0j/MArMIr+kuhyCwEIbiIxzxt9P7lLZ1CcD+lb/VLjKtJZQ
         NGk5LY9Yje4GBPjQdGydOtte9SoF3fOjUSypCBMmXfI5CnmJ9cjwwX8d4X09GIRnKU
         izfkhpbtucKw2xCRK7/wT8YuaXKmjTqGvOY9MUGvmJDmB7+6uoEKX47rnASSE0gE4p
         xebTgBlL8yUlQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DBCB640722; Sat,  2 Sep 2023 08:11:15 -0300 (-03)
Date:   Sat, 2 Sep 2023 08:11:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] perf parse-events: Fixes relating to no_value
 terms
Message-ID: <ZPMYU2lvkhfmPYyG@kernel.org>
References: <20230901233949.2930562-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901233949.2930562-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 01, 2023 at 04:39:44PM -0700, Ian Rogers escreveu:
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

I'm trying to minimize the number of patches that aren't strict fixes
this late in the process for v6.6, so I think I'll get just this first
one and defer the other cleanups/improvements for v6.7, ok?

Thanks,

- Arnaldo

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
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 

-- 

- Arnaldo
