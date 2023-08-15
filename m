Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6770377CCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjHOMoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbjHOMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:43:38 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC19A172A;
        Tue, 15 Aug 2023 05:43:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vps.ZOj_1692103407;
Received: from 30.221.150.39(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vps.ZOj_1692103407)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 20:43:29 +0800
Message-ID: <2b1fd6cd-69a0-c38d-c1c2-442dc36456a3@linux.alibaba.com>
Date:   Tue, 15 Aug 2023 20:43:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 6/7] perf jevents: Add support for Arm CMN PMU aliasing
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1691394685-61240-7-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fWyLQrYt=LVS9SoxsuZuR5fmRaNOn+v8qxdYa6WH7WmMA@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fWyLQrYt=LVS9SoxsuZuR5fmRaNOn+v8qxdYa6WH7WmMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/15 上午6:36, Ian Rogers 写道:
> On Mon, Aug 7, 2023 at 12:51 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> Currently just add aliases for part of Arm CMN PMU events which
>> are general and compatible for any SoC and CMN-ANY.
>>
>> "Compat" value "434*;436*;43c*;43a*" means it is compatible with
>> all CMN600/CMN650/CMN700/Ci700, which can be obtained from
>> commit 7819e05a0dce ("perf/arm-cmn: Revamp model detection").
>>
>> The arm-cmn PMU events got from:
> 
> nit: The use of the words "events" and "aliases" can be confusing -
> aliases isn't specific as there may be a notion of other aliases like
> for PMU names. I think in the code base we should avoid to use
> "aliases" and just use "events".
> 

Thank you for your suggestions. But if I use "event" instead of "alias" here,
it may not describe it clearly because essentially I am adding aliases to
existing events rather than adding new events.

Thanks,
Jing

> Thanks,
> Ian
> 
>> [0] https://developer.arm.com/documentation/100180/0302/?lang=en
>> [1] https://developer.arm.com/documentation/101408/0100/?lang=en
>> [2] https://developer.arm.com/documentation/102308/0302/?lang=en
>> [3] https://developer.arm.com/documentation/101569/0300/?lang=en
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>> ---
>>  .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
>>  tools/perf/pmu-events/jevents.py                   |   1 +
>>  2 files changed, 267 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
>> new file mode 100644
>> index 0000000..e54036c
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
>> @@ -0,0 +1,266 @@
>> +[
>> +       {
>> +               "EventName": "hnf_cache_miss",
>> +               "EventIdCode": "0x1",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts total cache misses in first lookup result (high priority).",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_slc_sf_cache_access",
>> +               "EventIdCode": "0x2",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of cache accesses in first access (high priority).",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_cache_fill",
>> +               "EventIdCode": "0x3",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts total allocations in HN SLC (all cache line allocations to SLC).",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_pocq_retry",
>> +               "EventIdCode": "0x4",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of retried requests.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_pocq_reqs_recvd",
>> +               "EventIdCode": "0x5",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of requests that HN receives.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_sf_hit",
>> +               "EventIdCode": "0x6",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of SF hits.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_sf_evictions",
>> +               "EventIdCode": "0x7",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of SF eviction cache invalidations initiated.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_dir_snoops_sent",
>> +               "EventIdCode": "0x8",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of directed snoops sent (not including SF back invalidation).",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_brd_snoops_sent",
>> +               "EventIdCode": "0x9",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of multicast snoops sent (not including SF back invalidation).",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_slc_eviction",
>> +               "EventIdCode": "0xa",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of SLC evictions (dirty only).",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_slc_fill_invalid_way",
>> +               "EventIdCode": "0xb",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of SLC fills to an invalid way.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_mc_retries",
>> +               "EventIdCode": "0xc",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of retried transactions by the MC.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_mc_reqs",
>> +               "EventIdCode": "0xd",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of requests that are sent to MC.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hnf_qos_hh_retry",
>> +               "EventIdCode": "0xe",
>> +               "Type": "0x5",
>> +               "BriefDescription": "Counts number of times a HighHigh priority request is protocolretried at the HN‑F.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "rnid_s0_rdata_beats",
>> +               "EventIdCode": "0x1",
>> +               "Type": "0xa",
>> +               "BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 0. This event measures the read bandwidth, including CMO responses.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "rnid_s1_rdata_beats",
>> +               "EventIdCode": "0x2",
>> +               "Type": "0xa",
>> +               "BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 1. This event measures the read bandwidth, including CMO responses.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "rnid_s2_rdata_beats",
>> +               "EventIdCode": "0x3",
>> +               "Type": "0xa",
>> +               "BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 2. This event measures the read bandwidth, including CMO responses.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "rnid_rxdat_flits",
>> +               "EventIdCode": "0x4",
>> +               "Type": "0xa",
>> +               "BriefDescription": "Number of RXDAT flits received. This event measures the true read data bandwidth, excluding CMOs.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "rnid_txdat_flits",
>> +               "EventIdCode": "0x5",
>> +               "Type": "0xa",
>> +               "BriefDescription": "Number of TXDAT flits dispatched. This event measures the write bandwidth.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "rnid_txreq_flits_total",
>> +               "EventIdCode": "0x6",
>> +               "Type": "0xa",
>> +               "BriefDescription": "Number of TXREQ flits dispatched. This event measures the total request bandwidth.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "rnid_txreq_flits_retried",
>> +               "EventIdCode": "0x7",
>> +               "Type": "0xa",
>> +               "BriefDescription": "Number of retried TXREQ flits dispatched. This event measures the retry rate.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "sbsx_txrsp_retryack",
>> +               "EventIdCode": "0x4",
>> +               "Type": "0x7",
>> +               "BriefDescription": "Number of RXREQ flits dispatched. This event is a measure of the retry rate.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "sbsx_txdat_flitv",
>> +               "EventIdCode": "0x5",
>> +               "Type": "0x7",
>> +               "BriefDescription": "Number of TXDAT flits dispatched from XP to SBSX. This event is a measure of the write bandwidth.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "sbsx_arvalid_no_arready",
>> +               "EventIdCode": "0x21",
>> +               "Type": "0x7",
>> +               "BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on AR channel.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "sbsx_awvalid_no_awready",
>> +               "EventIdCode": "0x22",
>> +               "Type": "0x7",
>> +               "BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on AW channel.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "sbsx_wvalid_no_wready",
>> +               "EventIdCode": "0x23",
>> +               "Type": "0x7",
>> +               "BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on W channel.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hni_txrsp_retryack",
>> +               "EventIdCode": "0x2a",
>> +               "Type": "0x4",
>> +               "BriefDescription": "Number of RXREQ flits dispatched. This event is a measure of the retry rate.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hni_arvalid_no_arready",
>> +               "EventIdCode": "0x2b",
>> +               "Type": "0x4",
>> +               "BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on AR channel.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hni_arready_no_arvalid",
>> +               "EventIdCode": "0x2c",
>> +               "Type": "0x4",
>> +               "BriefDescription": "Number of cycles the AR channel is waiting for new requests from HN-I bridge.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hni_awvalid_no_awready",
>> +               "EventIdCode": "0x2d",
>> +               "Type": "0x4",
>> +               "BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on AW channel.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hni_awready_no_awvalid",
>> +               "EventIdCode": "0x2e",
>> +               "Type": "0x4",
>> +               "BriefDescription": "Number of cycles the AW channel is waiting for new requests from HN-I bridge.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hni_wvalid_no_wready",
>> +               "EventIdCode": "0x2f",
>> +               "Type": "0x4",
>> +               "BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on W channel.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "EventName": "hni_txdat_stall",
>> +               "EventIdCode": "0x30",
>> +               "Type": "0x4",
>> +               "BriefDescription": "TXDAT valid but no link credit available.",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       }
>> +]
>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>> index 9c0f63a..bfdfb67 100755
>> --- a/tools/perf/pmu-events/jevents.py
>> +++ b/tools/perf/pmu-events/jevents.py
>> @@ -272,6 +272,7 @@ class JsonEvent:
>>            'DFPMC': 'amd_df',
>>            'cpu_core': 'cpu_core',
>>            'cpu_atom': 'cpu_atom',
>> +          'arm_cmn': 'arm_cmn',
>>        }
>>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>>
>> --
>> 1.8.3.1
>>
