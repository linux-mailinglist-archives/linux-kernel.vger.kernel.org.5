Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA237F5A57
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbjKWIpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345010AbjKWIp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:45:26 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847CD42;
        Thu, 23 Nov 2023 00:45:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 31BB441F5F;
        Thu, 23 Nov 2023 08:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1700729126; bh=HutI9EG0kKFuTj0lAK98ZuffMEYUqaLfWIup+i0AkAw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RQFgZgRr4dxfXUj8osOldDjyiWHNtOZZ2dTanRaueLvNgJTV6f9Ye+vJKWzbcnZ0Y
         mt5G5F3oCCBnwwzr1L/28O5HA8+NMEPqil6jTHEgeOXRPdOjPV/hBkPEfroZOUNI0q
         OG9HHKozlJKlq+g2iC7H2/JJI2MBKiazcyenQLKaQ3v9QFDYbllbejbIh1rdMBxYgW
         izhE8befv8ABOeBJ5ZZ9tNJW56CKPYMdNObY7WrHSv8YPwvjcX5I/vZ6cOhkgB5bHH
         ROtz5kV8S301GCOkryE41GGrpC2fWz/C9DzMSq0UNo8xiIeU+IxAibza5dvUb8qBCx
         g5IRlkMU3ARWA==
Message-ID: <ac4cf01d-4bb5-4b4d-bd87-bf05ddb67f2d@marcan.st>
Date:   Thu, 23 Nov 2023 17:45:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231123042922.834425-1-irogers@google.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20231123042922.834425-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/23 13:29, Ian Rogers wrote:
> The perf tool has previously made legacy events the priority so with
> or without a PMU the legacy event would be opened:
> 
> ```
> $ perf stat -e cpu-cycles,cpu/cpu-cycles/ true
> Using CPUID GenuineIntel-6-8D-1
> intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> Attempting to add event pmu 'cpu' with 'cpu-cycles,' that may result in non-fatal errors
> After aliases, add event pmu 'cpu' with 'cpu-cycles,' that may result in non-fatal errors
> Control descriptor is not initialized
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 833967  cpu -1  group_fd -1  flags 0x8 = 3
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> ...
> ```
> 
> Fixes to make hybrid/BIG.little PMUs behave correctly, ie as core PMUs
> capable of opening legacy events on each, removing hard coded
> "cpu_core" and "cpu_atom" Intel PMU names, etc. caused a behavioral
> difference on Apple/ARM due to latent issues in the PMU driver
> reported in:
> https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st/
> 
> As part of that report Mark Rutland <mark.rutland@arm.com> requested
> that legacy events not be higher in priority when a PMU is specified
> reversing what has until this change been perf's default
> behavior. With this change the above becomes:
> 
> ```
> $ perf stat -e cpu-cycles,cpu/cpu-cycles/ true
> Using CPUID GenuineIntel-6-8D-1
> Attempt to add: cpu/cpu-cycles=0/
> ..after resolving event: cpu/event=0x3c/
> Control descriptor is not initialized
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 827628  cpu -1  group_fd -1  flags 0x8 = 3
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (PERF_TYPE_RAW)
>   size                             136
>   config                           0x3c
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> ...
> ```
> 
> So the second event has become a raw event as
> /sys/devices/cpu/events/cpu-cycles exists.
> 
> A fix was necessary to config_term_pmu in parse-events.c as
> check_alias expansion needs to happen after config_term_pmu, and
> config_term_pmu may need calling a second time because of this.
> 
> config_term_pmu is updated to not use the legacy event when the PMU
> has such a named event (either from json or sysfs).
> 
> The bulk of this change is updating all of the parse-events test
> expectations so that if a sysfs/json event exists for a PMU the test
> doesn't fail - a further sign, if it were needed, that the legacy
> event priority was a known and tested behavior of the perf tool.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> This is a large behavioral change:
> 1) the scope of the change means it should bake on linux-next and I
> don't believe should be a 6.7-rc fix.
> 2) a fixes tag and stable backport I don't think are appropriate. The
> real reported issue is with the PMU driver. A backport would bring the
> risk that later fixes, due to the large behavior change, wouldn't be
> backported and past releases get regressed in scenarios like
> hybrid. Backports for the perf tool are also less necessary than say a
> buggy PMU driver, as distributions should be updating to the latest
> perf tool regardless of what Linux kernel is being run (the perf tool
> is backward compatible).
> ---
>  tools/perf/tests/parse-events.c | 256 +++++++++++++++++++++++---------
>  tools/perf/util/parse-events.c  |  52 +++++--
>  tools/perf/util/pmu.c           |   8 +-
>  tools/perf/util/pmu.h           |   3 +-
>  4 files changed, 231 insertions(+), 88 deletions(-)
> 

Tested-by: Hector Martin <marcan@marcan.st>

$ sudo taskset -c 2 ./perf stat -e apple_icestorm_pmu/cycles/ -e
apple_firestorm_pmu/cycles/ -e cycles echo


 Performance counter stats for 'echo':

     <not counted>      apple_icestorm_pmu/cycles/
                       (0.00%)
            34,622      apple_firestorm_pmu/cycles/

            30,751      cycles


       0.000429625 seconds time elapsed

       0.000000000 seconds user
       0.000443000 seconds sys


$ sudo taskset -c 0 ./perf stat -e apple_icestorm_pmu/cycles/ -e
apple_firestorm_pmu/cycles/ -e cycles echo


 Performance counter stats for 'echo':

            13,413      apple_icestorm_pmu/cycles/

     <not counted>      apple_firestorm_pmu/cycles/
                       (0.00%)
     <not counted>      cycles
                       (0.00%)

       0.000898458 seconds time elapsed

       0.000908000 seconds user
       0.000000000 seconds sys

(It would be nice to have "cycles" match/aggregate both PMUs, but that's
a story for another day. The behavior above is what was there in 6.4 and
earlier.)

- Hector
