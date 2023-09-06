Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A25794023
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbjIFPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIFPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:18:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE85BE6B;
        Wed,  6 Sep 2023 08:18:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16506C433C8;
        Wed,  6 Sep 2023 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694013528;
        bh=yQ0Z23Zi8vpt2reo1u33VyPF/URjsB49sQKSs1lkV0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fw1sxYmiMiSJqGZP6RvSzA0KGNwnoVb4NMyBgnswTrUM08IvSlIqgfBvAsZsvYNfV
         g3Caoq9QVdI1mE82mJtUwL0FX6rr36brxpDxiRzeimsSZIj/0Bad4rv/YsO/wcg9J8
         4hja5rGYQuIaM75ZrNfprKifyGqISvdRbX9jI7xQJf5tD8KNlfdmvVpjMx06ch+xjt
         0XHgnJ3iC12n1G95dygwvXydP1I9Yc/M0Ewwn0PrJPJarqAgTpPdbmsYozdFfnUYKt
         yGyHVdThSrq66GOc1JUTnPDEEdkSfdBxSSMjUpaEFrY+h7ZV54djAds5chFvoiJFPg
         yzBb1qT4xkTOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE3A4403F4; Wed,  6 Sep 2023 12:18:44 -0300 (-03)
Date:   Wed, 6 Sep 2023 12:18:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 1/3] perf completion: Restrict completion of events to
 events
Message-ID: <ZPiYVCO2XMLwMxo7@kernel.org>
References: <20230905181554.3202873-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905181554.3202873-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 05, 2023 at 11:15:52AM -0700, Ian Rogers escreveu:
> perf list will list libpfm4 events and metrics which aren't valid
> options to the '-e' option. Restrict the events gathered so that
> invalid ones aren't shown.
> 
> Before:
> $ perf stat -e <tab><tab>
> Display all 633 possibilities? (y or n)
> 
> After:
> $ perf stat -e <tab><tab>
> Display all 375 possibilities? (y or n)


Thanks, tested and applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/perf-completion.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
> index 978249d7868c..40cfc30ad7ad 100644
> --- a/tools/perf/perf-completion.sh
> +++ b/tools/perf/perf-completion.sh
> @@ -164,7 +164,7 @@ __perf_main ()
>  		$prev_skip_opts == @(record|stat|top) ]]; then
>  
>  		local cur1=${COMP_WORDS[COMP_CWORD]}
> -		local raw_evts=$($cmd list --raw-dump)
> +		local raw_evts=$($cmd list --raw-dump hw sw cache tracepoint pmu sdt)
>  		local arr s tmp result cpu_evts
>  
>  		# aarch64 doesn't have /sys/bus/event_source/devices/cpu/events
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 

-- 

- Arnaldo
