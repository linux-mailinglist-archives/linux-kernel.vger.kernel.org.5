Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0461F7C911B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjJMXAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:00:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C96B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:00:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCD3C433C7;
        Fri, 13 Oct 2023 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697238046;
        bh=8qM9BSYxF4si0oZK0+zWRYG3pweYYK3vSzWPG9FsH9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khOgFP816HxAaaJBFb9SGkC1jihPOk1bYRxg562/KgHri4N7/lK+1LGiW2kHsAThk
         gMBZIDfcFSDqO7i12sQH5uibP0qc4F721SRUSQqpoqbzo8lhOTdY8N3EC4TqTR8H1p
         PSBYfs/hwM54RDVmnyDt7vcN8971GsikBv/x1WUdB/tPfi6JBIwV7LyzOIKvFrkCre
         GAQFDP7ZWclQxwciGSXhmaL8uUhKe4uGzRkWM8vqEJDweudGRCh3IWB/Futq4tMW9n
         nJ8wYUrH5yUdjN67zTzuEYY9W11dvWp9+DOUeJ5/xUnz7cxQTiE8moewpu2IWKwLgo
         W7sZkk+MRDhSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2AEA40016; Fri, 13 Oct 2023 20:00:43 -0300 (-03)
Date:   Fri, 13 Oct 2023 20:00:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] perf lock contention: Clear lock addr after use
Message-ID: <ZSnMGwlppacZGaXf@kernel.org>
References: <20230928235018.2136-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928235018.2136-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 28, 2023 at 04:50:18PM -0700, Namhyung Kim escreveu:
> It checks the current lock to calculated the delta of contention time.

> The address is saved in the tstamp map which is allocated at begining of
> contention and released at end of contention.
> 
> But it's possible for bpf_map_delete_elem() to fail.  In that case, the

How can it fail? 

You do:

        pelem = bpf_map_lookup_elem(&tstamp, &pid);
        if (!pelem || pelem->lock != ctx[0])
                return 0;

So it is there, why would the removal using the same key fail?

The patch should work as-is, I'm just curious about what would make
there removal of a map entry that was successfully looked up on the same
contention_end prog to fail when being removed...

- Arnaldo

> element in the tstamp map kept for the current lock and it makes the
> next contention for the same lock tracked incorrectly.  Specificially
> the next contention begin will see the existing element for the task and
> it'd just return.  Then the next contention end will see the element and
> calculate the time using the timestamp for the previous begin.
> 
> This can result in a large value for two small contentions happened from
> time to time.  Let's clear the lock address so that it can be updated
> next time even if the bpf_map_delete_elem() failed.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 4900a5dfb4a4..b11179452e19 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -389,6 +389,7 @@ int contention_end(u64 *ctx)
>  
>  	duration = bpf_ktime_get_ns() - pelem->timestamp;
>  	if ((__s64)duration < 0) {
> +		pelem->lock = 0;
>  		bpf_map_delete_elem(&tstamp, &pid);
>  		__sync_fetch_and_add(&time_fail, 1);
>  		return 0;
> @@ -422,6 +423,7 @@ int contention_end(u64 *ctx)
>  	data = bpf_map_lookup_elem(&lock_stat, &key);
>  	if (!data) {
>  		if (data_map_full) {
> +			pelem->lock = 0;
>  			bpf_map_delete_elem(&tstamp, &pid);
>  			__sync_fetch_and_add(&data_fail, 1);
>  			return 0;
> @@ -445,6 +447,7 @@ int contention_end(u64 *ctx)
>  				data_map_full = 1;
>  			__sync_fetch_and_add(&data_fail, 1);
>  		}
> +		pelem->lock = 0;
>  		bpf_map_delete_elem(&tstamp, &pid);
>  		return 0;
>  	}
> @@ -458,6 +461,7 @@ int contention_end(u64 *ctx)
>  	if (data->min_time > duration)
>  		data->min_time = duration;
>  
> +	pelem->lock = 0;
>  	bpf_map_delete_elem(&tstamp, &pid);
>  	return 0;
>  }
> -- 
> 2.42.0.582.g8ccd20d70d-goog
> 

-- 

- Arnaldo
