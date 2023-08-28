Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5832278AEC0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjH1L0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjH1L0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:26:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C220C4;
        Mon, 28 Aug 2023 04:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693221958; x=1724757958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uDOPRWJwnuj9yetysIpW8KOjZrjExoaKm2NnunU/4Bk=;
  b=fUHAfaSVaXsifPNf2Q/AZ2jPh82vetOpwkaqtl8TGuOaUzDwNJwFPwfM
   WJarA/ZqSMHy3+HfDnH6M+6eO01/VgE8Fr9K2IjnSD7mriz4CZmsQMGOT
   jVU8InXmlb6FzwJXQkKw9YN7izfs8fwTY/EYTDOcHIWK66jJ+r9qjViD4
   90/HGm6Gwq6OQ/poIBfY5GGbWdfdD/x4JIWVqT5VBdGBk4eWHmHzzSHiD
   w1Nw1D+4gaQnp+T/uNsALJ3BeMgBtCzbW/4Tv11fQ3vYm7p08l6sVJQ8D
   y76zWgsPizCXvXrJIz0kYT/RrGxQvg7sYnW7Lg/t5IiTie8TTPJgBUKA3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="378854398"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="378854398"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 04:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="688072113"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="688072113"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.213.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 04:25:52 -0700
Message-ID: <0bf5f881-f264-bf2e-431e-444f51c97ee0@intel.com>
Date:   Mon, 28 Aug 2023 14:25:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 4/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230826032608.107261-1-yangjihong1@huawei.com>
 <20230826032608.107261-5-yangjihong1@huawei.com>
 <CAM9d7cibRU6ViyhxtEYG2UMSYUWbu__Oct-+J1PzvGwu_D=SPA@mail.gmail.com>
 <bbef4fc2-cb4b-72a9-44ed-a68c71886dc6@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <bbef4fc2-cb4b-72a9-44ed-a68c71886dc6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/23 06:03, Yang Jihong wrote:
> Hello,
> 
> On 2023/8/26 22:59, Namhyung Kim wrote:
>> Hello,
>>
>> On Fri, Aug 25, 2023 at 8:29 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>>
>>> User space tasks can migrate between CPUs, we need to track side-band
>>> events for all CPUs.
>>>
>>> The specific scenarios are as follows:
>>>
>>>           CPU0                                 CPU1
>>>    perf record -C 0 start
>>>                                taskA starts to be created and executed
>>>                                  -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>>>                                     events only deliver to CPU1
>>>                                ......
>>>                                  |
>>>                            migrate to CPU0
>>>                                  |
>>>    Running on CPU0    <----------/
>>>    ...
>>>
>>>    perf record -C 0 stop
>>>
>>> Now perf samples the PC of taskA. However, perf does not record the
>>> PERF_RECORD_COMM and PERF_RECORD_MMAP events of taskA.
>>> Therefore, the comm and symbols of taskA cannot be parsed.
>>>
>>> The solution is to record sideband events for all CPUs when tracing
>>> selected CPUs. Because this modifies the default behavior, add related
>>> comments to the perf record man page.
>>>
>>> The sys_perf_event_open invoked is as follows:
>>>
>>>    # perf --debug verbose=3 record -e cpu-clock -C 1 true
>>>    <SNIP>
>>>    Opening: cpu-clock
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             1 (PERF_TYPE_SOFTWARE)
>>>      size                             136
>>>      config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID|LOST
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>>>    Opening: dummy:u
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             1 (PERF_TYPE_SOFTWARE)
>>>      size                             136
>>>      config                           0x9 (PERF_COUNT_SW_DUMMY)
>>>      { sample_period, sample_freq }   1
>>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>>      read_format                      ID|LOST
>>>      inherit                          1
>>>      exclude_kernel                   1
>>>      exclude_hv                       1
>>>      mmap                             1
>>>      comm                             1
>>>      task                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>      mmap2                            1
>>>      comm_exec                        1
>>>      ksymbol                          1
>>>      bpf_event                        1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>>>    sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>>>    sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>>>    sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>>>    sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>>>    sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>>>    sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>>>    <SNIP>
>>>
>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>   tools/perf/Documentation/perf-record.txt |  3 ++
>>>   tools/perf/builtin-record.c              | 44 +++++++++++++++++++++++-
>>>   2 files changed, 46 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>>> index d5217be012d7..1889f66addf2 100644
>>> --- a/tools/perf/Documentation/perf-record.txt
>>> +++ b/tools/perf/Documentation/perf-record.txt
>>> @@ -374,6 +374,9 @@ comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-
>>>   In per-thread mode with inheritance mode on (default), samples are captured only when
>>>   the thread executes on the designated CPUs. Default is to monitor all CPUs.
>>>
>>> +User space tasks can migrate between CPUs, so when tracing selected CPUs,
>>> +a dummy event is created to track sideband for all CPUs.
>>> +
>>>   -B::
>>>   --no-buildid::
>>>   Do not save the build ids of binaries in the perf.data files. This skips
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index 83bd1f117191..21c571018148 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -906,10 +906,44 @@ static int record__config_off_cpu(struct record *rec)
>>>          return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>>>   }
>>>
>>> +static bool record__tracking_system_wide(struct record *rec)
>>> +{
>>> +       struct record_opts *opts = &rec->opts;
>>> +       struct evlist *evlist = rec->evlist;
>>> +       struct evsel *evsel;
>>> +
>>> +       /*
>>> +        * If all (non-dummy) evsel have exclude_user,
>>> +        * system_wide is not needed.
>>
>> Maybe I missed some earlier discussion but why is it not
>> needed when exclude_user is set?  I think it still needs
>> FORK or COMM at least..
>>
> 
> This is Adrian's suggestion earlier, I think it's probably because if exclude_user is set, MMAP information is not needed, that's my guess.
> 
> However, as you said, even if exclude_user is set, at least FORK and COMM are required.
> 
> Therefore, the conditions here need to be changed to:
> "system_wide is need as long as there is a non-dummy event."
> 
> @Adrian, is this change okay?

If you wish.  I think we use FORK to get mappings, so not sure it
would be needed.  There is PID, TID so COMM is not essential.
There are FORK, COMM etc from the CPUs being traced of course.

