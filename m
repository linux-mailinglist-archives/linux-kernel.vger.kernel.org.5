Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244378E978
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244669AbjHaJdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245463AbjHaJda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:33:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53C02CFE;
        Thu, 31 Aug 2023 02:33:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80B84FEC;
        Thu, 31 Aug 2023 02:34:05 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28F593F738;
        Thu, 31 Aug 2023 02:33:24 -0700 (PDT)
Message-ID: <4e2783e2-6b7f-8c8d-67cc-16cd6626caa9@arm.com>
Date:   Thu, 31 Aug 2023 10:33:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] perf jevents: Use "default_core" for events with no
 Unit
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230826062203.1058041-1-irogers@google.com>
 <4f493093-fe3e-0d17-1bdb-3c3545734f0c@arm.com>
 <CAP-5=fVcc-0xUe1SnHCBUiDEWBc1VA3O52SsOAV3LDV3nZo=jg@mail.gmail.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fVcc-0xUe1SnHCBUiDEWBc1VA3O52SsOAV3LDV3nZo=jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/2023 14:06, Ian Rogers wrote:
> On Wed, Aug 30, 2023 at 2:00 AM James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 26/08/2023 07:22, Ian Rogers wrote:
>>> The json Unit field encodes the name of the PMU to match the events
>>> to. When no name is given it has meant the "cpu" core PMU except for
>>> tests. On ARM, Intel hybrid and s390 the core PMU is named differently
>>> which means that using "cpu" for this case causes the events not to
>>> get matched to the PMU. Introduce a new "default_core" string for this
>>> case and in the pmu__name_match force all core PMUs to match this
>>> name.
>>>
>>> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
>>> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Fixes: 2e255b4f9f41 ("perf jevents: Group events by PMU")
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>
>> Hi Ian,
>>
>> Running 'perf list' with this change I get "munmap_chunk(): invalid
>> pointer". It's probably related to an earlier change though.
>>
>> Here's the stack:
>>
>> Program received signal SIGABRT, Aborted.
>> __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
>> 50      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
>> (gdb) bt
>> #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
>> #1  0x0000fffff70adaac in __GI_abort () at abort.c:79
>> #2  0x0000fffff70faf40 in __libc_message (action=action@entry=do_abort, fmt=fmt@entry=0xfffff71bc518 "%s\n")
>>      at ../sysdeps/posix/libc_fatal.c:155
>> #3  0x0000fffff7102344 in malloc_printerr (str=str@entry=0xfffff71b7ae0 "munmap_chunk(): invalid pointer") at malloc.c:5347
>> #4  0x0000fffff7102644 in munmap_chunk (p=<optimized out>) at malloc.c:2830
>> #5  0x0000aaaaaadc727c in __zfree (ptr=0xaaaaaaf89db0) at ../../lib/zalloc.c:13
>> #6  0x0000aaaaaacbbbcc in assign_str (name=0xaaaaaae878c2 "l1d_cache_refill", field=0xaaaaaae4fb78 "value", old_str=0xaaaaaaf89db0,
>>      new_str=0xaaaaaae878f7 "event=0x3") at util/pmu.c:454
>> #7  0x0000aaaaaacbbdf4 in update_alias (pe=0xffffffffd450, table=0xaaaaaaf43870 <pmu_events_map+592>, vdata=0xffffffffd598)
>>      at util/pmu.c:490
>> #8  0x0000aaaaaadbc37c in pmu_events_table__find_event_pmu (table=0xaaaaaaf43870 <pmu_events_map+592>,
>>      pmu=0xaaaaaaf43400 <pmu_events.arm_neoverse_n1>, name=0xaaaaaaf900b3 "l1d_cache_refill", fn=0xaaaaaacbbcc0 <update_alias>,
>>      data=0xffffffffd598) at pmu-events/pmu-events.c:5359
>> #9  0x0000aaaaaadbc598 in pmu_events_table__find_event (table=0xaaaaaaf43870 <pmu_events_map+592>, pmu=0xaaaaaaf8fcd0,
>>      name=0xaaaaaaf900b3 "l1d_cache_refill", fn=0xaaaaaacbbcc0 <update_alias>, data=0xffffffffd598)
>>      at pmu-events/pmu-events.c:5398
>> #10 0x0000aaaaaacbc1f0 in perf_pmu__new_alias (pmu=0xaaaaaaf8fcd0, name=0xaaaaaaf900b3 "l1d_cache_refill", desc=0x0, val=0x0,
>>      val_fd=0xaaaaaaf8a2e0, pe=0x0) at util/pmu.c:569
>> #11 0x0000aaaaaacbc710 in pmu_aliases_parse (pmu=0xaaaaaaf8fcd0) at util/pmu.c:673
>> #12 0x0000aaaaaacbf168 in perf_pmu__num_events (pmu=0xaaaaaaf8fcd0) at util/pmu.c:1633
>> #13 0x0000aaaaaacc1e00 in perf_pmus__print_pmu_events (print_cb=0xffffffffe878, print_state=0xffffffffe898) at util/pmus.c:359
>> #14 0x0000aaaaaac53810 in print_events (print_cb=0xffffffffe878, print_state=0xffffffffe898) at util/print-events.c:407
>> #15 0x0000aaaaaab1cc30 in cmd_list (argc=0, argv=0xfffffffff0c0) at builtin-list.c:524
>> #16 0x0000aaaaaac106f0 in run_builtin (p=0xaaaaaaf59580 <commands+240>, argc=2, argv=0xfffffffff0c0) at perf.c:322
>> #17 0x0000aaaaaac109a4 in handle_internal_command (argc=2, argv=0xfffffffff0c0) at perf.c:375
>> #18 0x0000aaaaaac10b5c in run_argv (argcp=0xffffffffeebc, argv=0xffffffffeeb0) at perf.c:419
>> #19 0x0000aaaaaac10e84 in main (argc=2, argv=0xfffffffff0c0) at perf.c:535
> 
> Hi James,
> 
> Could you try adding:
> https://lore.kernel.org/lkml/20230830000545.1638964-1-irogers@google.com/
> which I believe fixes the problem.
> 
> Thanks,
> Ian
> 

Yep that fixes it.

>>> ---
>>>  tools/perf/pmu-events/jevents.py |  2 +-
>>>  tools/perf/tests/pmu-events.c    | 19 ++++++++++---------
>>>  tools/perf/util/pmu.c            |  7 ++++++-
>>>  3 files changed, 17 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>>> index 712f80d7d071..a7e88332276d 100755
>>> --- a/tools/perf/pmu-events/jevents.py
>>> +++ b/tools/perf/pmu-events/jevents.py
>>> @@ -266,7 +266,7 @@ class JsonEvent:
>>>      def unit_to_pmu(unit: str) -> Optional[str]:
>>>        """Convert a JSON Unit to Linux PMU name."""
>>>        if not unit:
>>> -        return 'cpu'
>>> +        return 'default_core'
>>>        # Comment brought over from jevents.c:
>>>        # it's not realistic to keep adding these, we need something more scalable ...
>>>        table = {
>>> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
>>> index ce4da9b1d115..f5321fbdee79 100644
>>> --- a/tools/perf/tests/pmu-events.c
>>> +++ b/tools/perf/tests/pmu-events.c
>>> @@ -44,7 +44,7 @@ struct perf_pmu_test_pmu {
>>>
>>>  static const struct perf_pmu_test_event bp_l1_btb_correct = {
>>>       .event = {
>>> -             .pmu = "cpu",
>>> +             .pmu = "default_core",
>>>               .name = "bp_l1_btb_correct",
>>>               .event = "event=0x8a",
>>>               .desc = "L1 BTB Correction",
>>> @@ -56,7 +56,7 @@ static const struct perf_pmu_test_event bp_l1_btb_correct = {
>>>
>>>  static const struct perf_pmu_test_event bp_l2_btb_correct = {
>>>       .event = {
>>> -             .pmu = "cpu",
>>> +             .pmu = "default_core",
>>>               .name = "bp_l2_btb_correct",
>>>               .event = "event=0x8b",
>>>               .desc = "L2 BTB Correction",
>>> @@ -68,7 +68,7 @@ static const struct perf_pmu_test_event bp_l2_btb_correct = {
>>>
>>>  static const struct perf_pmu_test_event segment_reg_loads_any = {
>>>       .event = {
>>> -             .pmu = "cpu",
>>> +             .pmu = "default_core",
>>>               .name = "segment_reg_loads.any",
>>>               .event = "event=0x6,period=200000,umask=0x80",
>>>               .desc = "Number of segment register loads",
>>> @@ -80,7 +80,7 @@ static const struct perf_pmu_test_event segment_reg_loads_any = {
>>>
>>>  static const struct perf_pmu_test_event dispatch_blocked_any = {
>>>       .event = {
>>> -             .pmu = "cpu",
>>> +             .pmu = "default_core",
>>>               .name = "dispatch_blocked.any",
>>>               .event = "event=0x9,period=200000,umask=0x20",
>>>               .desc = "Memory cluster signals to block micro-op dispatch for any reason",
>>> @@ -92,7 +92,7 @@ static const struct perf_pmu_test_event dispatch_blocked_any = {
>>>
>>>  static const struct perf_pmu_test_event eist_trans = {
>>>       .event = {
>>> -             .pmu = "cpu",
>>> +             .pmu = "default_core",
>>>               .name = "eist_trans",
>>>               .event = "event=0x3a,period=200000,umask=0x0",
>>>               .desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
>>> @@ -104,7 +104,7 @@ static const struct perf_pmu_test_event eist_trans = {
>>>
>>>  static const struct perf_pmu_test_event l3_cache_rd = {
>>>       .event = {
>>> -             .pmu = "cpu",
>>> +             .pmu = "default_core",
>>>               .name = "l3_cache_rd",
>>>               .event = "event=0x40",
>>>               .desc = "L3 cache access, read",
>>> @@ -391,8 +391,8 @@ static int compare_alias_to_test_event(struct pmu_event_info *alias,
>>>               return -1;
>>>       }
>>>
>>> -
>>> -     if (!is_same(alias->pmu_name, test_event->event.pmu)) {
>>> +     if (!is_same(alias->pmu_name, test_event->event.pmu) &&
>>> +         !is_same(alias->pmu_name, "default_core")) {
>>>               pr_debug("testing aliases PMU %s: mismatched pmu_name, %s vs %s\n",
>>>                         pmu_name, alias->pmu_name, test_event->event.pmu);
>>>               return -1;
>>> @@ -409,7 +409,7 @@ static int test__pmu_event_table_core_callback(const struct pmu_event *pe,
>>>       struct perf_pmu_test_event const **test_event_table;
>>>       bool found = false;
>>>
>>> -     if (strcmp(pe->pmu, "cpu"))
>>> +     if (strcmp(pe->pmu, "default_core"))
>>>               test_event_table = &uncore_events[0];
>>>       else
>>>               test_event_table = &core_events[0];
>>> @@ -543,6 +543,7 @@ static int __test_core_pmu_event_aliases(const char *pmu_name, int *count)
>>>       INIT_LIST_HEAD(&pmu->caps);
>>>       INIT_LIST_HEAD(&pmu->list);
>>>       pmu->name = strdup(pmu_name);
>>> +     pmu->is_core = true;
>>>
>>>       pmu->events_table = table;
>>>       pmu_add_cpu_aliases_table(pmu, table);
>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>> index 502fd58c3ea7..cde33e01959a 100644
>>> --- a/tools/perf/util/pmu.c
>>> +++ b/tools/perf/util/pmu.c
>>> @@ -1747,7 +1747,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>>>  bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
>>>  {
>>>       return !strcmp(pmu->name, pmu_name) ||
>>> -             (pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->name));
>>> +             (pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->name)) ||
>>> +             /*
>>> +              * jevents and tests use default_core as a marker for any core
>>> +              * PMU as the PMU name varies across architectures.
>>> +              */
>>> +             (pmu->is_core && !strcmp(pmu_name, "default_core"));
>>>  }
>>>
>>>  bool perf_pmu__is_software(const struct perf_pmu *pmu)
