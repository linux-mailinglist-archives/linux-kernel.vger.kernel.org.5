Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DEA78C120
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjH2JUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjH2JUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:20:20 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C41AB;
        Tue, 29 Aug 2023 02:20:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VqqzHEu_1693300810;
Received: from 30.221.149.238(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VqqzHEu_1693300810)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 17:20:11 +0800
Message-ID: <c32809b4-353b-fecb-a7bf-b7bda1604574@linux.alibaba.com>
Date:   Tue, 29 Aug 2023 17:20:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 06/18] perf s390 s390_cpumcfdg_dump: Don't scan all
 PMUs
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824041330.266337-1-irogers@google.com>
 <20230824041330.266337-7-irogers@google.com> <ZOdiX4eJHFfFbQhi@kernel.org>
 <428afeb4-d5ca-8115-73fc-881119a1cd51@linux.ibm.com>
 <CAP-5=fVt1vxK0CJ=aYjZzs4mushbxAx8056uxVQZUfsLAKpVoQ@mail.gmail.com>
 <4f2438fc-2360-8833-3751-fe3bc8b11afb@linux.ibm.com>
 <ZOkVYoN17A8wwP3k@kernel.org>
 <CAP-5=fUqLXdu2=TPSASFBbZ+B1oTFbuFra38z5YwYHWpX-V=hw@mail.gmail.com>
 <ZOzdFPOLhNdd59PG@kernel.org> <ZOzfHEuJkXfajmWO@kernel.org>
 <CAP-5=fV81WPRAXrGoMJDuT3aKHJBThEscq=NX=Jn_4UUPOutAg@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fV81WPRAXrGoMJDuT3aKHJBThEscq=NX=Jn_4UUPOutAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/29 上午8:59, Ian Rogers 写道:
> On Mon, Aug 28, 2023 at 10:53 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> Em Mon, Aug 28, 2023 at 02:44:53PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Fri, Aug 25, 2023 at 03:56:54PM -0700, Ian Rogers escreveu:
>>>> On Fri, Aug 25, 2023 at 1:56 PM Arnaldo Carvalho de Melo
>>>> <acme@kernel.org> wrote:
>>>>>
>>>>> Em Fri, Aug 25, 2023 at 04:39:22PM +0200, Thomas Richter escreveu:
>>>>>> On 8/25/23 15:14, Ian Rogers wrote:
>>>>>>> On Fri, Aug 25, 2023 at 1:20 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>>>
>>>>>>>> On 8/24/23 15:59, Arnaldo Carvalho de Melo wrote:
>>>>>>>>> Em Wed, Aug 23, 2023 at 09:13:18PM -0700, Ian Rogers escreveu:
>>>>>>>>>> Rather than scanning all PMUs for a counter name, scan the PMU
>>>>>>>>>> associated with the evsel of the sample. This is done to remove a
>>>>>>>>>> dependence on pmu-events.h.
>>>>>
>>>>>>>>> I'm applying this one, and CCing the S/390 developers so that they can
>>>>>>>>> try this and maybe provide an Acked-by/Tested-by,
>>>>>
>>>>>>>> I have downloaded this patch set of 18 patches (using b4), but they do not
>>>>>>>> apply on my git tree.
>>>>>
>>>>>>>> Which git branch do I have to use to test this. Thanks a lot.
>>>>>
>>>>>>> the changes are in the perf-tools-next tree:
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/
>>>>>
>>>>>> Unfurtunately this patch set fails again on s390.
>>>>>> Here is the test output from the current 6.5.0rc7 kernel:
>>>>>>
>>>>>> # ./perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
>>>>>>   6: Parse event definition strings                                  :
>>>>>>   6.1: Test event parsing                                            : Ok
>>>>>>   6.2: Parsing of all PMU events from sysfs                          : Ok
>>>>>>   6.3: Parsing of given PMU events from sysfs                        : Ok
>>>>>>   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
>>>>>>   6.5: Parsing of aliased events                                     : Ok
>>>>>>   6.6: Parsing of terms (event modifiers)                            : Ok
>>>>>>  10: PMU events                                                      :
>>>>>>  10.1: PMU event table sanity                                        : Ok
>>>>>>  10.2: PMU event map aliases                                         : Ok
>>>>>>  10.3: Parsing of PMU event table metrics                            : Ok
>>>>>>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>>>>>>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
>>>>>>  95: perf all metricgroups test                                      : Ok
>>>>>>  96: perf all metrics test                                           : Ok
>>>>>> #
>>>>>>
>>>>>> This looks good.
>>>>>
>>>>> Reproduced:
>>>>>
>>>>> # grep -E vendor_id\|^processor -m2 /proc/cpuinfo
>>>>> vendor_id       : IBM/S390
>>>>> processor 0: version = 00,  identification = 1A33E8,  machine = 2964
>>>>> #
>>>>> # perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
>>>>>   6: Parse event definition strings                                  :
>>>>>   6.1: Test event parsing                                            : Ok
>>>>>   6.2: Parsing of all PMU events from sysfs                          : Ok
>>>>>   6.3: Parsing of given PMU events from sysfs                        : Ok
>>>>>   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
>>>>>   6.5: Parsing of aliased events                                     : Ok
>>>>>   6.6: Parsing of terms (event modifiers)                            : Ok
>>>>>  10: PMU events                                                      :
>>>>>  10.1: PMU event table sanity                                        : Ok
>>>>>  10.2: PMU event map aliases                                         : Ok
>>>>>  10.3: Parsing of PMU event table metrics                            : Ok
>>>>>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>>>>>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
>>>>>  95: perf all metricgroups test                                      : Ok
>>>>>  96: perf all metrics test                                           : Ok
>>>>> # perf -v
>>>>> perf version 6.5.rc7.g6f0edbb833ec
>>>>> #
>>>>>
>>>>>> However when I use the check-out from perf-tools-next, I get this output:
>>>>>> # ./perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
>>>>>>   6: Parse event definition strings                                  :
>>>>>>   6.1: Test event parsing                                            : Ok
>>>>>>   6.2: Parsing of all PMU events from sysfs                          : FAILED!
>>>>>>   6.3: Parsing of given PMU events from sysfs                        : Ok
>>>>>>   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
>>>>>>   6.5: Parsing of aliased events                                     : FAILED!
>>>>>>   6.6: Parsing of terms (event modifiers)                            : Ok
>>>>>>  10: PMU events                                                      :
>>>>>>  10.1: PMU event table sanity                                        : Ok
>>>>>>  10.2: PMU event map aliases                                         : FAILED!
>>>>>>  10.3: Parsing of PMU event table metrics                            : Ok
>>>>>>  10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
>>>>>>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
>>>>>>  93: perf all metricgroups test                                      : FAILED!
>>>>>>  94: perf all metrics test                                           : FAILED!
>>>>>> #
>>>>>>
>>>>>> So some tests are failing again.
>>>>>>
>>>>>> I am out for the next two weeks, Sumanth Korikkar (on to list) might be able to help.
>>>>>> Thanks a lot.
>>>>>
>>>>> [root@kernelqe3 linux]# git checkout perf-tools-next
>>>>> git Switched to branch 'perf-tools-next'
>>>>> Your branch is up to date with 'perf-tools-next/perf-tools-next'.
>>>>> [root@kernelqe3 linux]# git log --oneline -5
>>>>> eeb6b12992c4 (HEAD -> perf-tools-next, perf-tools-next/perf-tools-next) perf jevents: Don't append Unit to desc
>>>>> f208b2c6f984 (perf-tools-next/tmp.perf-tools-next) perf scripts python gecko: Launch the profiler UI on the default browser with the appropriate URL
>>>>> 43803cb16f99 perf scripts python: Add support for input args in gecko script
>>>>> f85d120c46e7 perf jevents: Sort strings in the big C string to reduce faults
>>>>> 8d4b6d37ea78 perf pmu: Lazily load sysfs aliases
>>>>> [root@kernelqe3 linux]# make BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf install-bin
>>>>>
>>>>> [root@kernelqe3 linux]# perf -v
>>>>> perf version 6.5.rc5.geeb6b12992c4
>>>>> [root@kernelqe3 linux]# git log --oneline -1
>>>>> eeb6b12992c4 (HEAD -> perf-tools-next, perf-tools-next/perf-tools-next) perf jevents: Don't append Unit to desc
>>>>> [root@kernelqe3 linux]# perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
>>>>>   6: Parse event definition strings                                  :
>>>>>   6.1: Test event parsing                                            : Ok
>>>>>   6.2: Parsing of all PMU events from sysfs                          : FAILED!
>>>>>   6.3: Parsing of given PMU events from sysfs                        : Ok
>>>>>   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
>>>>>   6.5: Parsing of aliased events                                     : FAILED!
>>>>>   6.6: Parsing of terms (event modifiers)                            : Ok
>>>>>  10: PMU events                                                      :
>>>>>  10.1: PMU event table sanity                                        : Ok
>>>>>  10.2: PMU event map aliases                                         : FAILED!
>>>>>  10.3: Parsing of PMU event table metrics                            : Ok
>>>>>  10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
>>>>>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
>>>>>  93: perf all metricgroups test                                      : FAILED!
>>>>>  94: perf all metrics test                                           : FAILED!
>>>>> [root@kernelqe3 linux]#
>>>>>
>>>>> Bisecting the first problem:
>>>>>
>>>>>  10.2: PMU event map aliases                                         : FAILED!
>>>>>
>>>>> make: Leaving directory '/root/git/linux/tools/perf'
>>>>>   6: Parse event definition strings                                  :
>>>>>   6.1: Test event parsing                                            : Ok
>>>>>   6.2: Parsing of all PMU events from sysfs                          : Ok
>>>>>   6.3: Parsing of given PMU events from sysfs                        : Ok
>>>>>   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
>>>>>   6.5: Parsing of aliased events                                     : Ok
>>>>>   6.6: Parsing of terms (event modifiers)                            : Ok
>>>>>  10: PMU events                                                      :
>>>>>  10.1: PMU event table sanity                                        : Ok
>>>>>  10.2: PMU event map aliases                                         : FAILED!
>>>>>  10.3: Parsing of PMU event table metrics                            : Ok
>>>>>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>>>>>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
>>>>>  93: perf all metricgroups test                                      : Ok
>>>>>  94: perf all metrics test                                           : Ok
>>>>> [root@kernelqe3 linux]# git bisect bad
>>>>> 2e255b4f9f41f137d9e3dc4fae3603a9c2c3dd28 is the first bad commit
>>>>> commit 2e255b4f9f41f137d9e3dc4fae3603a9c2c3dd28
>>>>> Author: Ian Rogers <irogers@google.com>
>>>>> Date:   Wed Aug 23 21:13:16 2023 -0700
>>>>>
>>>>>     perf jevents: Group events by PMU
>>>>>
>>>>>     Prior to this change a cpuid would map to a list of events where the PMU
>>>>>     would be encoded alongside the event information. This change breaks
>>>>>     apart each group of events so that there is a group per PMU. A new table
>>>>>     is added with the PMU's name and the list of events, the original table
>>>>>     now holding an array of these per PMU tables.
>>>>>
>>>>>     These changes are to make it easier to get per PMU information about
>>>>>     events, rather than the current approach of scanning all events. The
>>>>>     perf binary size with BPF skeletons on x86 is reduced by about 1%. The
>>>>>     unidentified PMU is now always expanded to "cpu".
>>>>>
>>>>>     Signed-off-by: Ian Rogers <irogers@google.com>
>>>>>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>>>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>>>     Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
>>>>>     Cc: Ingo Molnar <mingo@redhat.com>
>>>>>     Cc: James Clark <james.clark@arm.com>
>>>>>     Cc: Jing Zhang <renyu.zj@linux.alibaba.com>
>>>>>     Cc: Jiri Olsa <jolsa@kernel.org>
>>>>>     Cc: John Garry <john.g.garry@oracle.com>
>>>>>     Cc: Kajol Jain <kjain@linux.ibm.com>
>>>>>     Cc: Kan Liang <kan.liang@linux.intel.com>
>>>>>     Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>     Cc: Namhyung Kim <namhyung@kernel.org>
>>>>>     Cc: Peter Zijlstra <peterz@infradead.org>
>>>>>     Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>>>>>     Cc: Rob Herring <robh@kernel.org>
>>>>>     Link: https://lore.kernel.org/r/20230824041330.266337-5-irogers@google.com
>>>>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>>>
>>>>>  tools/perf/pmu-events/jevents.py | 181 +++++++++++++++++++++++++++++----------
>>>>>  tools/perf/tests/pmu-events.c    |  30 ++++---
>>>>>  2 files changed, 154 insertions(+), 57 deletions(-)
>>>>> [root@kernelqe3 linux]#
>>>>>
>>>>
>>>> This change defaulted events without a specified PMU to being for the
>>>> PMU 'cpu', so that events in pmu-events.c were associated with a PMU
>>>> and we could find per-PMU information easily. The test events have no
>>>> PMU and so this has broken s390 where the the PMU should be "cpum_cf".
>>>> It has probably also broken x86 hybrid and arm where their default PMU
>>>> isn't cpu. I'll work on a fix, but the problem will be limited to the
>>>> test.
>>>
>>> So, with your "default_core" branche we go to:
>>>
>>> [root@kernelqe3 linux]# perf test 10
>>>  10: PMU events                                                      :
>>>  10.1: PMU event table sanity                                        : Ok
>>>  10.2: PMU event map aliases                                         : Ok
>>>  10.3: Parsing of PMU event table metrics                            : Ok
>>>  10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
>>>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
>>> [root@kernelqe3 linux]# perf --version
>>> perf version 6.5.rc5.g3d63ae82aa12
>>> [root@kernelqe3 linux]#
>>>
>>> The other tests:
>>>
>>> [root@kernelqe3 linux]# perf --version
>>> perf version 6.5.rc5.g3d63ae82aa12
>>> [root@kernelqe3 linux]# perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
>>>   6: Parse event definition strings                                  :
>>>   6.1: Test event parsing                                            : Ok
>>>   6.2: Parsing of all PMU events from sysfs                          : FAILED!
>>>   6.3: Parsing of given PMU events from sysfs                        : Ok
>>>   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
>>>   6.5: Parsing of aliased events                                     : FAILED!
>>>   6.6: Parsing of terms (event modifiers)                            : Ok
>>>  10: PMU events                                                      :
>>>  10.1: PMU event table sanity                                        : Ok
>>>  10.2: PMU event map aliases                                         : Ok
>>>  10.3: Parsing of PMU event table metrics                            : Ok
>>>  10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
>>>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
>>>  93: perf all metricgroups test                                      : FAILED!
>>>  94: perf all metrics test                                           : FAILED!
>>> [root@kernelqe3 linux]#
>>>
>>> Trying to bisect it now.
>>
>> make: Leaving directory '/root/git/linux/tools/perf'
>> [root@kernelqe3 linux]# perf test 6
>>   6: Parse event definition strings                                  :
>>   6.1: Test event parsing                                            : Ok
>>   6.2: Parsing of all PMU events from sysfs                          : FAILED!
>>   6.3: Parsing of given PMU events from sysfs                        : Ok
>>   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
>>   6.5: Parsing of aliased events                                     : FAILED!
>>   6.6: Parsing of terms (event modifiers)                            : Ok
>> [root@kernelqe3 linux]# git bisect bad
>> 8d4b6d37ea7862d230ad2e1bd4c7d2ff5e9acd53 is the first bad commit
>> commit 8d4b6d37ea7862d230ad2e1bd4c7d2ff5e9acd53
>> Author: Ian Rogers <irogers@google.com>
>> Date:   Wed Aug 23 21:13:28 2023 -0700
>>
>>     perf pmu: Lazily load sysfs aliases
>>
>>     Don't load sysfs aliases for a PMU when the PMU is first created, defer
>>     until an alias needs to be found. For the pmu-scan benchmark, average
>>     core PMU scanning is reduced by 30.8%, and average PMU scanning by
>>     12.6%.
>>
>>     Signed-off-by: Ian Rogers <irogers@google.com>
>>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>     Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
>>     Cc: Ingo Molnar <mingo@redhat.com>
>>     Cc: James Clark <james.clark@arm.com>
>>     Cc: Jing Zhang <renyu.zj@linux.alibaba.com>
>>     Cc: Jiri Olsa <jolsa@kernel.org>
>>     Cc: John Garry <john.g.garry@oracle.com>
>>     Cc: Kajol Jain <kjain@linux.ibm.com>
>>     Cc: Kan Liang <kan.liang@linux.intel.com>
>>     Cc: Mark Rutland <mark.rutland@arm.com>
>>     Cc: Namhyung Kim <namhyung@kernel.org>
>>     Cc: Peter Zijlstra <peterz@infradead.org>
>>     Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>>     Cc: Rob Herring <robh@kernel.org>
>>     Link: https://lore.kernel.org/r/20230824041330.266337-17-irogers@google.com
>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>>  tools/perf/tests/pmu-events.c |  2 ++
>>  tools/perf/util/pmu.c         | 81 ++++++++++++++++++++++---------------------
>>  tools/perf/util/pmu.h         |  2 ++
>>  3 files changed, 46 insertions(+), 39 deletions(-)
>> [root@kernelqe3 linux]#
>>
>> It is segfaulting:
>>
>>   6.2: Parsing of all PMU events from sysfs                          :
>> --- start ---
>> test child forked, pid 1202947
>> Using CPUID IBM,2964,400,N96,1.4,002f
>> perf: Segmentation fault
>> Obtained 16 stack frames.
>> perf(dump_stack+0x36) [0x1156dbe]
>> perf(sighandler_dump_stack+0x3a) [0x1156e8a]
>> [0x3fffd4790b6]
>> /lib64/libc.so.6(__strcasecmp+0x42) [0x3ffa889c51a]
>> perf() [0x11792ac]
>> perf(pmu_events_table__find_event+0x27c) [0x12432fc]
>> perf() [0x11777cc]
>> perf() [0x1179842]
>> perf(perf_pmu__check_alias+0x4f0) [0x1179e98]
>> perf(parse_events_add_pmu+0x72c) [0x1128e84]
>> perf(parse_events_parse+0x4d4) [0x11754d4]
>> perf(__parse_events+0xda) [0x112644a]
>> perf() [0x10cecb2]
>> perf() [0x10d3264]
>> perf() [0x10cb250]
>> perf(cmd_test+0x109e) [0x10cc756]
>> test child interrupted
>> ---- end ----
>> Parse event definition strings subtest 2: FAILED!
>>
>>
>> Starting program: /root/bin/perf test -F 6
>> [Thread debugging using libthread_db enabled]
>> Using host libthread_db library "/lib64/libthread_db.so.1".
>>   6: Parse event definition strings                                  :
>>   6.1: Test event parsing                                            : Ok
>>   6.2: Parsing of all PMU events from sysfs                          :
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x000003fffcf1c51a in strcasecmp () from /lib64/libc.so.6
>> #0  0x000003fffcf1c51a in strcasecmp () from /lib64/libc.so.6
>> #1  0x000000000123e518 in assign_str (name=0x1487cc3 "l1i_ondrawer_mem_sourced_writes", field=0x141eeba "value", old_str=0x18c12e0, new_str=0x1487d1f "event=0xb1") at util/pmu.c:449
>> #2  0x000000000123e82c in update_alias (pe=0x3ffffff8ac0, table=0x1555cb0 <pmu_events_map+160>, vdata=0x3ffffff8c40) at util/pmu.c:490
>> #3  0x000000000137b9dc in pmu_events_table.find_event ()
>> #4  0x000000000123ed4e in perf_pmu__new_alias (pmu=0x15ce490, name=0x23c2593 "L1I_ONDRAWER_MEM_SOURCED_WRITES", desc=0x0, val=0x0, val_fd=0x16058a0, pe=0x0) at util/pmu.c:569
>> #5  0x000000000123f370 in pmu_aliases_parse (pmu=0x15ce490) at util/pmu.c:673
>> #6  0x000000000123e3a2 in perf_pmu__find_alias (pmu=0x15ce490, name=0x238eb10 "L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV", load=true) at util/pmu.c:432
>> #7  0x0000000001241bb2 in pmu_find_alias (pmu=0x15ce490, term=0x18409d0) at util/pmu.c:1439
>> #8  0x0000000001241f82 in perf_pmu__check_alias (pmu=0x15ce490, head_terms=0x21b14d0, info=0x3ffffffa238, err=0x3ffffffc4c8) at util/pmu.c:1519
>> #9  0x00000000011bbbd4 in parse_events_add_pmu (parse_state=0x3ffffffc2f0, list=0x21afec0, name=0x21c6430 "cpum_cf", head_config=0x21b14d0, auto_merge_stats=false, loc_=0x3ffffffb4d8) at util/parse-events.c:1351
>> #10 0x000000000123aa4c in parse_events_parse (_parse_state=0x3ffffffc2f0, scanner=0x15b9310) at util/parse-events.y:299
>> #11 0x00000000011bd190 in parse_events__scanner (str=0x3ffffffc68a "cpum_cf/event=L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV/u", input=0x0, parse_state=0x3ffffffc2f0) at util/parse-events.c:1738
>> #12 0x00000000011bde00 in __parse_events (evlist=0x15b7030, str=0x3ffffffc68a "cpum_cf/event=L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV/u", pmu_filter=0x0, err=0x3ffffffc4c8, fake_pmu=0x0, warn_if_reordered=true) at util/parse-events.c:2010
>> #13 0x0000000001121884 in parse_events (evlist=0x15b7030, str=0x3ffffffc68a "cpum_cf/event=L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV/u", err=0x3ffffffc4c8) at /root/git/linux/tools/perf/util/parse-events.h:40
>> #14 0x0000000001134084 in test_event (e=0x3ffffffc5e0) at tests/parse-events.c:2393
>> #15 0x00000000011349ec in test__pmu_events (test=0x156b860 <suite.parse_events>, subtest=1) at tests/parse-events.c:2551
>> #16 0x000000000111f884 in run_test (test=0x156b860 <suite.parse_events>, subtest=1) at tests/builtin-test.c:242
>> #17 0x000000000111fa1a in test_and_print (t=0x156b860 <suite.parse_events>, subtest=1) at tests/builtin-test.c:271
>> #18 0x00000000011203fa in __cmd_test (argc=1, argv=0x3ffffffe5d0, skiplist=0x0) at tests/builtin-test.c:442
>> #19 0x0000000001120cca in cmd_test (argc=1, argv=0x3ffffffe5d0) at tests/builtin-test.c:564
>> #20 0x00000000011713a4 in run_builtin (p=0x1561190 <commands+600>, argc=3, argv=0x3ffffffe5d0) at perf.c:322
>> #21 0x0000000001171712 in handle_internal_command (argc=3, argv=0x3ffffffe5d0) at perf.c:375
>> #22 0x0000000001171920 in run_argv (argcp=0x3ffffffe304, argv=0x3ffffffe2f8) at perf.c:419
>> #23 0x0000000001171ce8 in main (argc=3, argv=0x3ffffffe5d0) at perf.c:535
>> (gdb)
>>
>> (gdb) fr 1
>> #1  0x000000000123e518 in assign_str (name=0x1487cc3 "l1i_ondrawer_mem_sourced_writes", field=0x141eeba "value", old_str=0x18c12e0, new_str=0x1487d1f "event=0xb1") at util/pmu.c:449
>> 449             if (!new_str || !strcasecmp(*old_str, new_str))
>> (gdb) p new_str
>> $1 = 0x1487d1f "event=0xb1"
>> (gdb) p *old_str
>> $2 = 0x1 <error: Cannot access memory at address 0x1>
>> (gdb) p old_str
>> $3 = (char **) 0x18c12e0
>> (gdb)
> 
> I can't explain this, how come the line numbers don't agree with?
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=tmp.perf-tools-next#n449
> 
> The values are coming from the json event data. I'd need to see the
> generated pmu-events.c.
> 
> Thanks,
> Ian


Hi Ian,

I pulled the lastest tmp.perf-tools-next, and build with JEVENT_ARCH=all on ARM(KunPeng) system. The test 10 also fails.

The bad commit maybe is "edb217f perf pmu: Parse sysfs events directly from a file". Hope it helps.

#git log --oneline -1
3d63ae8 perf jevents: Use "default_core" for events with no Unit

#./perf test 10
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : FAILED!
 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
 10.5: Parsing of metric thresholds with fake PMUs                   : FAILED!

Found metric 'tsx_aborted_cycles'
metric expr (max(cycles\-t - cycles\-ct, 0) / cycles if has_event(cycles\-t) else 0) for tsx_aborted_cycles
parsing metric: (max(cycles\-t - cycles\-ct, 0) / cycles if has_event(cycles\-t) else 0)
perf: Segmentation fault
Obtained 16 stack frames.
./perf() [0x514a23]
linux-vdso.so.1(+0x7c3) [0xffff8ac847c3]
./perf() [0x52bb08]
./perf() [0x52ffc3]
./perf() [0x4e8cab]
./perf() [0x4ea27b]
./perf() [0x532137]
./perf() [0x53273b]
./perf() [0x533ed7]
./perf() [0x4ed58b]
./perf() [0x530763]
./perf() [0x4e8c47]
./perf() [0x4ea5e3]
./perf() [0x4eaa8f]
./perf() [0x595393]
./perf() [0x593753]
test child interrupted
---- end ----
PMU events subtest 3: FAILED!
 10.4: Parsing of PMU event table metrics with fake PMUs             :
--- start ---
test child forked, pid 24107
parsing '': '(unc_p_power_state_occupancy.cores_c0 / unc_p_clockticks) * 100.'
parsing metric: (unc_p_power_state_occupancy.cores_c0 / unc_p_clockticks) * 100.
Using CPUID 0x00000000481fd010
perf: Segmentation fault
Obtained 16 stack frames.
./perf() [0x514a23]
linux-vdso.so.1(+0x7c3) [0xffff8ac847c3]
./perf() [0x52bb08]
./perf() [0x52ffc3]
./perf() [0x4e8cab]
./perf() [0x4ea27b]
./perf() [0x532137]
./perf() [0x53273b]
./perf() [0x533ed7]
./perf() [0x4ed58b]
./perf() [0x530763]
./perf() [0x4e8c47]
./perf() [0x4ea5e3]
./perf() [0x4a50b3]
./perf() [0x4a5343]
./perf() [0x48fef7]
test child interrupted
---- end ----
PMU events subtest 4: FAILED!
 10.5: Parsing of metric thresholds with fake PMUs                   :
--- start ---
test child forked, pid 24108
parsing 'tma_alloc_restriction': 'tma_alloc_restriction > 0.1'
parsing metric: tma_alloc_restriction > 0.1
Using CPUID 0x00000000481fd010
perf: Segmentation fault
Obtained 16 stack frames.
./perf() [0x514a23]
linux-vdso.so.1(+0x7c3) [0xffff8ac847c3]
./perf() [0x52bb08]
./perf() [0x52ffc3]
./perf() [0x4e8cab]
./perf() [0x4ea27b]
./perf() [0x532137]
./perf() [0x53273b]
./perf() [0x533ed7]
./perf() [0x4ed58b]
./perf() [0x530763]
./perf() [0x4e8c47]
./perf() [0x4ea5e3]
./perf() [0x4a50b3]
./perf() [0x5dec0b]
./perf() [0x5df117]
test child interrupted
---- end ----
PMU events subtest 5: FAILED!
