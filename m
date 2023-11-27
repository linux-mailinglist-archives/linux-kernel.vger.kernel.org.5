Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF8B7F9DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjK0KpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjK0KpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:45:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A60310F;
        Mon, 27 Nov 2023 02:45:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB4A32F4;
        Mon, 27 Nov 2023 02:45:57 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C02BB3F73F;
        Mon, 27 Nov 2023 02:45:08 -0800 (PST)
Message-ID: <be1d187c-a282-9b07-8485-72cf55833abf@arm.com>
Date:   Mon, 27 Nov 2023 10:45:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf test: Remove atomics from test_loop to avoid test
 failures
Content-Language: en-US
To:     Michael Petlan <mpetlan@redhat.com>,
        Nick Forrington <nick.forrington@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        vmolnaro@redhat.com
References: <20231102162225.50028-1-nick.forrington@arm.com>
 <alpine.LRH.2.20.2311242037260.11297@Diego>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <alpine.LRH.2.20.2311242037260.11297@Diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/11/2023 19:57, Michael Petlan wrote:
> On Thu, 2 Nov 2023, Nick Forrington wrote:
>> The current use of atomics can lead to test failures, as tests (such as
>> tests/shell/record.sh) search for samples with "test_loop" as the
>> top-most stack frame, but find frames related to the atomic operation
>> (e.g. __aarch64_ldadd4_relax).
>>
>> This change simply removes the "count" variable, as it is not necessary.
> 
> Hello.
> 
> I believe that it was there to prevent the compiler to optimize the loop
> out or some reason like that. Hopefully, it will work even without that
> on all architectures with all compilers that are used for building perf...
> 

If that optimisation ever happens and there is a concrete case, I think
it should be treated like any other test regression and fixed at that
time when it's known what the specifics of that issue are. As Nick says
in a later comment, the loop can't be optimised out because it depends
on the done variable and the function is noinline.

> I also think that the tests should be designed in a more robust way, so
> that they aren't directly dependent on exact stack frames, e.g. let's look
> at the "inet_pton" testcase...

This one doesn't look like it's dependent on exact stack frames, but
just one frame at the end, which unless something is actually broken in
Perf causing a failure, I don't see how could be made any more robust.

> 
> The inet_pton test result check algorithm is designed to rely on exact
> stacktrace, without a possibility to specify something like "we want this
> and that in the stack trace, but otherwise, it does not matter which
> wrappers are aroung". Then there must be the following code to adjust
> the expected output exactly per architecture:
> 
>     echo "ping[][0-9 \.:]+$event_name: \([[:xdigit:]]+\)" > $expected
>     echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
>     case "$(uname -m)" in
>       s390x)
>         eventattr='call-graph=dwarf,max-stack=4'
>         echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
>         echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>       ;;
>       ppc64|ppc64le)
>         eventattr='max-stack=4'
>         echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
>         echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
>         echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>       ;;
>       *)
>         eventattr='max-stack=3'
>         echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>       ;;
>     esac
> 
> Of course, since it relies on libc version, then we need patches, such as
>     1f85d016768f ("perf test record+probe_libc_inet_pton: Fix call chain match on x86_64")
>     311693ce81c9 ("perf test record+probe_libc_inet_pton: Fix call chain match on s390")
>     fb710ddee75f ("perf test record_probe_libc_inet_pton: Fix test on s/390 where 'text_to_binary_address' now appears on the backtrace")
>     ...
> which break the test when used with older libc...
> 

I definitely think that relying on external libraries for stacks in
tests can be annoying to keep up to date, but that's exactly what we
just removed from test_loop.

For the inet_pton test it seems to be specifically testing probing libc,
so maybe making the test program ourselves would make the test much less
valuable. And then as long as all the tests are not like that and there
is only this one to keep up to date, maybe it's not that bad.

> I think that a better design of such test is either probing some program
> of ourselves that has predictable and stable function call sequence or
> be more robust in checking the stack trace.
> 
> Thoughts?
> 
> Michael
> 
>>
>> Fixes: 1962ab6f6e0b ("perf test workload thloop: Make count increments atomic")
>> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
>> ---
>>  tools/perf/tests/workloads/thloop.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
>> index af05269c2eb8..457b29f91c3e 100644
>> --- a/tools/perf/tests/workloads/thloop.c
>> +++ b/tools/perf/tests/workloads/thloop.c
>> @@ -7,7 +7,6 @@
>>  #include "../tests.h"
>>  
>>  static volatile sig_atomic_t done;
>> -static volatile unsigned count;
>>  
>>  /* We want to check this symbol in perf report */
>>  noinline void test_loop(void);
>> @@ -19,8 +18,7 @@ static void sighandler(int sig __maybe_unused)
>>  
>>  noinline void test_loop(void)
>>  {
>> -	while (!done)
>> -		__atomic_fetch_add(&count, 1, __ATOMIC_RELAXED);
>> +	while (!done);
>>  }
>>  
>>  static void *thfunc(void *arg)
>> -- 
>> 2.42.0
>>
>>
>>
> 
> 
