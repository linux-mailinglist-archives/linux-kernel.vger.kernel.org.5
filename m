Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E8771007
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHEOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEOBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 10:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAD7113
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 07:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 423D360E0A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 14:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD57BC433C8;
        Sat,  5 Aug 2023 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691244112;
        bh=Z7i5QwWx2AHjf62kHkBY4DZ84VJ8f4fULqWvP9CNS3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aYGafcyMpqWW1JrU2tEUIbghx9oeVRHe7yD/V4AonUVl9pJjX0qPNmFahIeoYGmqS
         lNxfBmxJyFNJ10LzTVvlN3atGc3gqXnrcIvdjeFWa/RKNk1B/gge20DGMKPN/Mlybb
         U296FuomHsXqJ8T3sGxR05iuz7UZ5xWTaQiZIZmGJmgw36ljpE5Az3nrJ9OfGYtUkK
         cWSOAgFnN9klCvWYx0ETFfHI1NcA2L0SkgjawfD6hcidieBpgxzj+i054aC7LxTEZy
         KCBS/2SgOsDUItr7bXGoU0TPnWYtHa1gkNUV7Qch4SI2eyHwq7yICHzRSEbVCHC7A3
         yBhDOLAuLqqDg==
Date:   Sat, 5 Aug 2023 23:01:48 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf probe: Free string returned by
 synthesize_perf_probe_point() on failure to add a probe
Message-Id: <20230805230148.84a94f9f67e56513d58f4e1b@kernel.org>
In-Reply-To: <ZM0l1Oxamr4SVjfY@kernel.org>
References: <ZM0l1Oxamr4SVjfY@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 13:22:44 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Building perf with EXTRA_CFLAGS="-fsanitize=address" a leak is detect
> when trying to add a probe to a non-existent function:
> 
>   # perf probe -x ~/bin/perf dso__neW
>   Probe point 'dso__neW' not found.
>     Error: Failed to add events.
> 
>   =================================================================
>   ==296634==ERROR: LeakSanitizer: detected memory leaks
> 
>   Direct leak of 128 byte(s) in 1 object(s) allocated from:
>       #0 0x7f67642ba097 in calloc (/lib64/libasan.so.8+0xba097)
>       #1 0x7f67641a76f1 in allocate_cfi (/lib64/libdw.so.1+0x3f6f1)
> 
>   Direct leak of 65 byte(s) in 1 object(s) allocated from:
>       #0 0x7f67642b95b5 in __interceptor_realloc.part.0 (/lib64/libasan.so.8+0xb95b5)
>       #1 0x6cac75 in strbuf_grow util/strbuf.c:64
>       #2 0x6ca934 in strbuf_init util/strbuf.c:25
>       #3 0x9337d2 in synthesize_perf_probe_point util/probe-event.c:2018
>       #4 0x92be51 in try_to_find_probe_trace_events util/probe-event.c:964
>       #5 0x93d5c6 in convert_to_probe_trace_events util/probe-event.c:3512
>       #6 0x93d6d5 in convert_perf_probe_events util/probe-event.c:3529
>       #7 0x56f37f in perf_add_probe_events /var/home/acme/git/perf-tools-next/tools/perf/builtin-probe.c:354
>       #8 0x572fbc in __cmd_probe /var/home/acme/git/perf-tools-next/tools/perf/builtin-probe.c:738
>       #9 0x5730f2 in cmd_probe /var/home/acme/git/perf-tools-next/tools/perf/builtin-probe.c:766
>       #10 0x635d81 in run_builtin /var/home/acme/git/perf-tools-next/tools/perf/perf.c:323
>       #11 0x6362c1 in handle_internal_command /var/home/acme/git/perf-tools-next/tools/perf/perf.c:377
>       #12 0x63667a in run_argv /var/home/acme/git/perf-tools-next/tools/perf/perf.c:421
>       #13 0x636b8d in main /var/home/acme/git/perf-tools-next/tools/perf/perf.c:537
>       #14 0x7f676302950f in __libc_start_call_main (/lib64/libc.so.6+0x2950f)
> 
>   SUMMARY: AddressSanitizer: 193 byte(s) leaked in 2 allocation(s).
>   #
> 
> synthesize_perf_probe_point() returns a "detached" strbuf, i.e. a
> malloc'ed string that needs to be free'd.
> 
> An audit will be performed to find other such cases.

Thanks for finding it!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/probe-event.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 2d056f02ae408a64..c7bfeab610a3679a 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -961,8 +961,9 @@ static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
>  	debuginfo__delete(dinfo);
>  
>  	if (ntevs == 0)	{	/* No error but failed to find probe point. */
> -		pr_warning("Probe point '%s' not found.\n",
> -			   synthesize_perf_probe_point(&pev->point));
> +		char *probe_point = synthesize_perf_probe_point(&pev->point);
> +		pr_warning("Probe point '%s' not found.\n", probe_point);
> +		free(probe_point);
>  		return -ENODEV;
>  	} else if (ntevs < 0) {
>  		/* Error path : ntevs < 0 */
> -- 
> 2.37.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
