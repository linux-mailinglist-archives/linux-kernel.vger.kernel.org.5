Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EF6762B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjGZGQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjGZGQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:16:10 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8861719BD;
        Tue, 25 Jul 2023 23:15:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VoFhAhR_1690352140;
Received: from 30.221.150.4(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VoFhAhR_1690352140)
          by smtp.aliyun-inc.com;
          Wed, 26 Jul 2023 14:15:41 +0800
Message-ID: <a16f4eb7-24c2-fc42-964d-0b84effae9a5@linux.alibaba.com>
Date:   Wed, 26 Jul 2023 14:15:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v4 1/4] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690100513-61165-2-git-send-email-renyu.zj@linux.alibaba.com>
 <4c20d8fd-b478-5b0a-0558-3b59dead0751@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <4c20d8fd-b478-5b0a-0558-3b59dead0751@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/25 下午4:20, John Garry 写道:
> On 23/07/2023 09:21, Jing Zhang wrote:
>> The jevent "Compat" is used for uncore PMU alias or metric definitions.
>>
>> The same PMU driver has different PMU identifiers due to different hardware
>> versions and types, but they may have some common PMU event/metric. Since a
>> Compat value can only match one identifier, when adding the same event
>> alias and metric to PMUs with different identifiers, each identifier needs
>> to be defined once, which is not streamlined enough.
>>
>> So let "Compat" value supports matching multiple identifiers. For example,
>> the Compat value {abcde;123*} can match the PMU identifier "abcde" and the
>> the PMU identifier with the prefix "123", where "*" is a wildcard.
>> Tokens in Unit field are delimited by ';' with no spaces.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>   tools/perf/util/metricgroup.c | 27 ++++++++++++++++++++++++++-
> 
> Why only support for metrics? Why not support for regular events aliases? I would have expected pmu_add_sys_aliases_iter_fn() to have been updated for this.
> 

Oh, you are right. I forgot to modify pmu_add_sys_aliases_iter_fn().

> On the basis that we will support regular events aliases, we need perf tool self-test cases for this in tools/perf/test/pmu-events.c (I think that pmu-events.c would be the most appropriate file)
> 

Ok, I will support it for regular events aliases and add self-test cases in the next version.

Thanks,
Jing
