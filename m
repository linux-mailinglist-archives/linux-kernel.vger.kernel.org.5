Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF578C289
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjH2Kqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjH2Kq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:46:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 879481AA;
        Tue, 29 Aug 2023 03:46:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A246D2F4;
        Tue, 29 Aug 2023 03:47:02 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 154D03F738;
        Tue, 29 Aug 2023 03:46:20 -0700 (PDT)
Message-ID: <1299e1ff-2543-6ee5-dc32-bc098bd6bfe1@arm.com>
Date:   Tue, 29 Aug 2023 11:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] perf vendor events arm64: Add AmpereOne metrics
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
References: <20230826192352.3043220-1-ilkka@os.amperecomputing.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230826192352.3043220-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/2023 20:23, Ilkka Koskinen wrote:
> This patch adds AmpereOne metrics. The metrics also work around
> the issue related to some of the events.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  .../arch/arm64/ampere/ampereone/metrics.json  | 396 ++++++++++++++++++
>  1 file changed, 396 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> new file mode 100644
> index 000000000000..b623d8a9e3dc
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> @@ -0,0 +1,396 @@

[...]

> +    {
> +        "MetricExpr": "STALL_SLOT_BACKEND / (CPU_CYCLES * 4)",
> +        "BriefDescription": "Fraction of slots backend bound",
> +        "MetricGroup": "Default;TopDownL1",
> +        "MetricName": "backend_bound",
> +        "ScaleUnit": "100%"
> +    },

Hi Ilkaa,

For these topdown metrics, as long as they are the same as the standard
one you can remove anything that is duplicated. This might make it
easier to make changes across all the topdown metrics in the future and
have consistent descriptions across CPUs. For example this backend_bound
one could look like this:

    {
        "ArchStdEvent": "backend_bound",
    }

This assumes that you have the slots sysfs file available, otherwise you
could leave only the formula in.

We also decided to make the units for the topdown metrics "percent of
slots" as we thought more specificity in the units was clearer.

Thanks
James

> +    {
> +        "MetricExpr": "1 - (retired_fraction + slots_lost_misspeculation_fraction + backend_bound)",
> +        "BriefDescription": "Fraction of slots frontend bound",
> +        "MetricGroup": "Default;TopDownL1",
> +        "MetricName": "frontend_bound",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "(OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4)",
> +        "BriefDescription": "Fraction of slots lost due to misspeculation",
> +        "MetricGroup": "Default;TopDownL1",
> +        "MetricName": "slots_lost_misspeculation_fraction",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "OP_RETIRED / (CPU_CYCLES * 4)",
> +        "BriefDescription": "Fraction of slots retiring, useful work",
> +        "MetricGroup": "Default;TopDownL1",
> +        "MetricName": "retired_fraction",
> +        "ScaleUnit": "100%"
> +    },
> +    {
