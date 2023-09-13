Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92779ED42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjIMPhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjIMPhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:37:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADD5493;
        Wed, 13 Sep 2023 08:37:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F4FC1FB;
        Wed, 13 Sep 2023 08:38:17 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33C1B3F5A1;
        Wed, 13 Sep 2023 08:37:32 -0700 (PDT)
Message-ID: <36a4405d-0133-5ee7-4bdf-b85a26defb4f@arm.com>
Date:   Wed, 13 Sep 2023 16:37:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/7] perf pmu: Move pmu__find_core_pmu() to pmus.c
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230831151632.124985-1-james.clark@arm.com>
 <20230831151632.124985-6-james.clark@arm.com> <ZQC7da2AM9ih8RMz@kernel.org>
 <c122cf68-6ceb-5441-960e-fc754b0dfdb0@arm.com>
 <abf7e4fb-a86a-a582-fd14-e500a23b82dd@arm.com>
In-Reply-To: <abf7e4fb-a86a-a582-fd14-e500a23b82dd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/09/2023 11:32, James Clark wrote:
> 
> 
> On 13/09/2023 11:20, James Clark wrote:
>>
>>
>> On 12/09/2023 20:26, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Aug 31, 2023 at 04:16:16PM +0100, James Clark escreveu:
>>>> pmu__find_core_pmu() more logically belongs in pmus.c because it
>>>> iterates over all PMUs, so move it to pmus.c
>>>>
>>>> At the same time rename it to perf_pmus__find_core_pmu() to match the
>>>> naming convention in this file.
>>>>
>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>
>>> So, this one is hitting this:
>>>
>>>   CC      /tmp/build/perf-tools-next/util/expr.o
>>> In file included from /var/home/acme/git/perf-tools-next/tools/include/linux/list.h:7,
>>>                  from util/pmus.c:2:
>>> In function ‘perf_pmus__scan_core’,
>>>     inlined from ‘perf_pmus__find_core_pmu’ at util/pmus.c:601:16:
>>> /var/home/acme/git/perf-tools-next/tools/include/linux/kernel.h:36:45: error: array subscript 0 is outside array bounds of ‘struct list_head[1]’ [-Werror=array-bounds]
>>>    36 |         const typeof(((type *)0)->member) * __mptr = (ptr);     \
>>>       |                                             ^~~~~~
>>> /var/home/acme/git/perf-tools-next/tools/include/linux/list.h:352:9: note: in expansion of macro ‘container_of’
>>>   352 |         container_of(ptr, type, member)
>>>       |         ^~~~~~~~~~~~
>>> /var/home/acme/git/perf-tools-next/tools/include/linux/list.h:404:9: note: in expansion of macro ‘list_entry’
>>>   404 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>>>       |         ^~~~~~~~~~
>>> /var/home/acme/git/perf-tools-next/tools/include/linux/list.h:494:20: note: in expansion of macro ‘list_next_entry’
>>>   494 |         for (pos = list_next_entry(pos, member);                        \
>>>       |                    ^~~~~~~~~~~~~~~
>>> util/pmus.c:274:9: note: in expansion of macro ‘list_for_each_entry_continue’
>>>   274 |         list_for_each_entry_continue(pmu, &core_pmus, list)
>>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> util/pmus.c: In function ‘perf_pmus__find_core_pmu’:
>>> util/pmus.c:35:18: note: at offset -128 into object ‘core_pmus’ of size 16
>>>    35 | static LIST_HEAD(core_pmus);
>>>       |                  ^~~~~~~~~
>>> /var/home/acme/git/perf-tools-next/tools/include/linux/list.h:23:26: note: in definition of macro ‘LIST_HEAD’
>>>    23 |         struct list_head name = LIST_HEAD_INIT(name)
>>>       |                          ^~~~
>>> cc1: all warnings being treated as errors
>>> make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/pmus.o] Error 1
>>> make[4]: *** Waiting for unfinished jobs....
>>>   LD      /tmp/build/perf-tools-next/ui/browsers/perf-in.o
>>>
>>>
>>> So I applied up to 4/7
>>>
>>> Please continue from what will be in tmp.perf-tools-next in some
>>> jiffies.
>>>
>>> - Arnaldo
>>
>> I wasn't able to reproduce this on x86 or Arm, with either Clang or GCC.
>>
>> That was with this patch applied onto 999b81b907e on tmp.perf-tools-next
>> and a pretty normal "make WERROR=1" command.
>>
>> It seems like the 0 here is just to get the type rather than access
>> anything, if that's the 0 that the "array subscript 0" error is about,
>> so something seems a bit strange:
>>
>>> /var/home/acme/git/perf-tools-next/tools/include/linux/kernel.h:36:45:
>> error: array subscript 0 is outside array bounds of ‘struct
>> list_head[1]’ [-Werror=array-bounds]
>>>    36 |         const typeof(((type *)0)->member) * __mptr = (ptr);     \
> 
> Nevermind, I managed to reproduce it. With a DEBUG=1 build on x86 there
> is no error, it only happens with a non debug one.
> 
> I will look into it.

Sent a v3 with the fix. It's some kind of awkward semi-undefined
behavior in the linked list implementation that was always there but the
compiler could only see when I moved that function so it was all in one
compilation unit. It also required -O2 and I always build with DEBUG=1
so I missed it.
