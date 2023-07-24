Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AEE75ECA5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGXHk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGXHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:40:23 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778F8195;
        Mon, 24 Jul 2023 00:40:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vo3N3oz_1690184414;
Received: from 30.221.149.214(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vo3N3oz_1690184414)
          by smtp.aliyun-inc.com;
          Mon, 24 Jul 2023 15:40:16 +0800
Message-ID: <2e392aa9-859a-75ef-eb3e-1870b1e78061@linux.alibaba.com>
Date:   Mon, 24 Jul 2023 15:40:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] perf arm64: Fix read PMU cpu slots
To:     Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZL4G7rWXkfv-Ectq@B-Q60VQ05P-2326.local>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <ZL4G7rWXkfv-Ectq@B-Q60VQ05P-2326.local>
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



在 2023/7/24 下午1:06, Haixin Yu 写道:
> Commit f8ad6018ce3c ("perf pmu: Remove duplication around
>  EVENT_SOURCE_DEVICE_PATH") uses sysfs__read_ull to read a full
> sysfs path, which will never success. Fix it by read file directly.
> 
> Signed-off-by: Haixin Yu <yuhaixin.yhx@linux.alibaba.com>
> ---
>  tools/perf/arch/arm64/util/pmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 561de0cb6b95..512a8f13c4de 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -54,10 +54,11 @@ double perf_pmu__cpu_slots_per_cycle(void)
>  		perf_pmu__pathname_scnprintf(path, sizeof(path),
>  					     pmu->name, "caps/slots");
>  		/*
> -		 * The value of slots is not greater than 32 bits, but sysfs__read_int
> -		 * can't read value with 0x prefix, so use sysfs__read_ull instead.
> +		 * The value of slots is not greater than 32 bits, but
> +		 * filename__read_int can't read value with 0x prefix,
> +		 * so use filename__read_ull instead.
>  		 */
> -		sysfs__read_ull(path, &slots);
> +		filename__read_ull(path, &slots);
>  	}
>  
>  	return slots ? (double)slots : NAN;

Yes, the function perf_pmu__pathname_scnprintf returns the complete slots file path "/sys/bus/xxxxx/caps/slots",
and sysfs__read_ull will add the prefix "/sys" to the path, so the final file path becomes "/sys/sys/bus/xxxx/caps/slots"
which does not exist, and the slots file cannot be successfully read, so sysfs__read_ull needs to be changed to the
filename__read_ull.

I tested it and it works well.

Tested-by: Jing Zhang <renyu.zj@linux.alibaba.com>
