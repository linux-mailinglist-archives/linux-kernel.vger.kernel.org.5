Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C334F792B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245490AbjIEQuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353929AbjIEIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:40:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92BB8E6;
        Tue,  5 Sep 2023 01:40:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0129E11FB;
        Tue,  5 Sep 2023 01:41:14 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0D283F766;
        Tue,  5 Sep 2023 01:40:34 -0700 (PDT)
Message-ID: <d7bae298-9d83-1bff-15a2-4ebe433ec8af@arm.com>
Date:   Tue, 5 Sep 2023 09:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] perf parse-events: Fix driver config term
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230905033805.3094293-1-irogers@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230905033805.3094293-1-irogers@google.com>
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



On 05/09/2023 04:38, Ian Rogers wrote:
> Inadvertently deleted in commit 30f4ade33d64 ("perf tools: Revert
> enable indices setting syntax for BPF map").
> 
> Reported-by: James Clark <james.clark@arm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.y | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 4a305df61f74..21bfe7e0d944 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -839,6 +839,23 @@ PE_TERM
>  
>  	$$ = term;
>  }
> +|
> +PE_DRV_CFG_TERM
> +{
> +	struct parse_events_term *term;
> +	char *config = strdup($1);
> +	int err;
> +
> +	if (!config)
> +		YYNOMEM;
> +	err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG, config, $1, &@1, NULL);
> +	if (err) {
> +		free($1);
> +		free(config);
> +		PE_ABORT(err);
> +	}
> +	$$ = term;
> +}
>  
>  sep_dc: ':' |
>  

Reviewed-by: James Clark <james.clark@arm.com>
