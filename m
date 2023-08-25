Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E412788039
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbjHYGrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242335AbjHYGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:47:21 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD00CCD5;
        Thu, 24 Aug 2023 23:47:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VqW3x5o_1692946031;
Received: from 30.221.145.196(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VqW3x5o_1692946031)
          by smtp.aliyun-inc.com;
          Fri, 25 Aug 2023 14:47:13 +0800
Message-ID: <364ae15e-6fdc-026e-a211-ec7348f0928f@linux.alibaba.com>
Date:   Fri, 25 Aug 2023 14:47:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v7 8/8] perf vendor events: Add JSON metrics for Arm CMN
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
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1692606977-92009-9-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fU3-iuHd6Yd6SGtffZr92eMN3nb0NRM40KmqKPxKZobHA@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fU3-iuHd6Yd6SGtffZr92eMN3nb0NRM40KmqKPxKZobHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/25 下午12:13, Ian Rogers 写道:
> On Mon, Aug 21, 2023 at 1:36 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> Add JSON metrics for Arm CMN. Currently just add part of CMN PMU
>> metrics which are general and compatible for any SoC with CMN-ANY.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>> ---
>>  .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  | 74 ++++++++++++++++++++++
>>  1 file changed, 74 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
>> new file mode 100644
>> index 0000000..64db534
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
>> @@ -0,0 +1,74 @@
>> +[
>> +       {
>> +               "MetricName": "slc_miss_rate",
>> +               "BriefDescription": "The system level cache miss rate.",
>> +               "MetricGroup": "cmn",
>> +               "MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
>> +               "ScaleUnit": "100%",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
> 
> Here a ';' is used as a separator, but for "Unit" ',' is used as a
> separator. Is there a reason for the inconsistency?
> 

John and I have previously discussed this issue, and in fact, I deliberately used ';'.

I use a semicolon instead of a comma because I want to distinguish it from the function
of the comma in "Unit" and avoid confusion between the use of commas in "Unit" and "Compat".
Because in Unit, commas act as wildcards, and in “Compat”, the semicolon means "or". So
I think semicolons are more appropriate.

Thanks,
Jing

> Thanks,
> Ian
> 
>> +       },
>> +       {
>> +               "MetricName": "hnf_message_retry_rate",
>> +               "BriefDescription": "HN-F message retry rate indicates whether a lack of credits is causing the bottlenecks.",
>> +               "MetricGroup": "cmn",
>> +               "MetricExpr": "hnf_pocq_retry / hnf_pocq_reqs_recvd",
>> +               "ScaleUnit": "100%",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "MetricName": "sf_hit_rate",
>> +               "BriefDescription": "Snoop filter hit rate can be used to measure the snoop filter efficiency.",
>> +               "MetricGroup": "cmn",
>> +               "MetricExpr": "hnf_sf_hit / hnf_slc_sf_cache_access",
>> +               "ScaleUnit": "100%",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "MetricName": "mc_message_retry_rate",
>> +               "BriefDescription": "The memory controller request retries rate indicates whether the memory controller is the bottleneck.",
>> +               "MetricGroup": "cmn",
>> +               "MetricExpr": "hnf_mc_retries / hnf_mc_reqs",
>> +               "ScaleUnit": "100%",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "MetricName": "rni_actual_read_bandwidth.all",
>> +               "BriefDescription": "This event measure the actual bandwidth that RN-I bridge sends to the interconnect.",
>> +               "MetricGroup": "cmn",
>> +               "MetricExpr": "rnid_rxdat_flits * 32 / 1e6 / duration_time",
>> +               "ScaleUnit": "1MB/s",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "MetricName": "rni_actual_write_bandwidth.all",
>> +               "BriefDescription": "This event measures the actual write bandwidth at RN-I bridges.",
>> +               "MetricGroup": "cmn",
>> +               "MetricExpr": "rnid_txdat_flits * 32 / 1e6 / duration_time",
>> +               "ScaleUnit": "1MB/s",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "MetricName": "rni_retry_rate",
>> +               "BriefDescription": "RN-I bridge retry rate indicates whether the memory controller is the bottleneck.",
>> +               "MetricGroup": "cmn",
>> +               "MetricExpr": "rnid_txreq_flits_retried / rnid_txreq_flits_total",
>> +               "ScaleUnit": "100%",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       },
>> +       {
>> +               "MetricName": "sbsx_actual_write_bandwidth.all",
>> +               "BriefDescription": "sbsx actual write bandwidth.",
>> +               "MetricGroup": "cmn",
>> +               "MetricExpr": "sbsx_txdat_flitv * 32 / 1e6 / duration_time",
>> +               "ScaleUnit": "1MB/s",
>> +               "Unit": "arm_cmn",
>> +               "Compat": "434*;436*;43c*;43a*"
>> +       }
>> +]
>> --
>> 1.8.3.1
>>
