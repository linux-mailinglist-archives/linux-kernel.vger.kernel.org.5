Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7877E00F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbjKCJO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346858AbjKCJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:14:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 592031AD;
        Fri,  3 Nov 2023 02:14:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE07B2F4;
        Fri,  3 Nov 2023 02:15:29 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1CB63F64C;
        Fri,  3 Nov 2023 02:14:45 -0700 (PDT)
Message-ID: <9e3355e0-f0d6-5f82-d2f6-b7e84bda996c@arm.com>
Date:   Fri, 3 Nov 2023 09:14:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf test: Remove atomics from test_loop to avoid test
 failures
Content-Language: en-US
To:     Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20231102162225.50028-1-nick.forrington@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231102162225.50028-1-nick.forrington@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2023 16:22, Nick Forrington wrote:
> The current use of atomics can lead to test failures, as tests (such as
> tests/shell/record.sh) search for samples with "test_loop" as the
> top-most stack frame, but find frames related to the atomic operation
> (e.g. __aarch64_ldadd4_relax).
> 
> This change simply removes the "count" variable, as it is not necessary.
> 
> Fixes: 1962ab6f6e0b ("perf test workload thloop: Make count increments atomic")
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> ---
>   tools/perf/tests/workloads/thloop.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
> index af05269c2eb8..457b29f91c3e 100644
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
> @@ -7,7 +7,6 @@
>   #include "../tests.h"
>   
>   static volatile sig_atomic_t done;
> -static volatile unsigned count;
>   
>   /* We want to check this symbol in perf report */
>   noinline void test_loop(void);
> @@ -19,8 +18,7 @@ static void sighandler(int sig __maybe_unused)
>   
>   noinline void test_loop(void)
>   {
> -	while (!done)
> -		__atomic_fetch_add(&count, 1, __ATOMIC_RELAXED);
> +	while (!done);
>   }
>   
>   static void *thfunc(void *arg)

Reviewed-by: James Clark <james.clark@arm.com>
