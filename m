Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2638577F9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352300AbjHQOve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352295AbjHQOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:51:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 667A494;
        Thu, 17 Aug 2023 07:51:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C38D75;
        Thu, 17 Aug 2023 07:42:05 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0BBA3F6C4;
        Thu, 17 Aug 2023 07:41:20 -0700 (PDT)
Message-ID: <43e5d3e9-fe5f-655d-a6d3-44d47081e1a4@arm.com>
Date:   Thu, 17 Aug 2023 15:41:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 6/6] perf vendor events arm64: Update N2 and V2 metrics
 and events using Arm telemetry repo
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, acme@kernel.org
References: <20230816114841.1679234-1-james.clark@arm.com>
 <20230816114841.1679234-7-james.clark@arm.com>
 <81e404fb-0eae-e4b8-299a-54ac860fd1dd@oracle.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <81e404fb-0eae-e4b8-299a-54ac860fd1dd@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2023 12:09, John Garry wrote:
> On 16/08/2023 12:47, James Clark wrote:
>> Apart from some slight naming and grouping differences, the new metrics
>> are functionally the same as the existing ones. Any missing metrics were
>> manually appended to the end of the auto generated file.
>>
>> For the events, the new data includes descriptions that may have product
>> specific details and new groupings that will be consistent with other
>> products.
>>
>> After generating the metrics from the telemetry repo [1], the following
>> manual steps were performed:
>>
>>   * Change the topdown expressions to compare on CPUID and use
>>     #slots so that the same data can be shared between N2 and V2. Apart
>>     from these modifications, the expressions now match more closely with
>>     the Arm telemetry data which will hopefully make future updates
>>     easier.
>>
>>   * Append some metrics from the old N2/V2 data that aren't present in
>>     the telemetry data. These will possibly be added to the
>>     telemetry-solution repo at a later time:
>>
>>      l3d_cache_mpki, l3d_cache_miss_rate, branch_pki, ipc_rate, spec_ipc,
>>      retired_rate, wasted_rate, branch_immed_spec_rate,
>>      branch_return_spec_rate, branch_indirect_spec_rate
>>
>> [1]:https://urldefense.com/v3/__https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2.json__;!!ACWV5N9M2RV99hQ!NW7DYe7T69u8RFn9WLyiCcoHm-8BtlxNK3PRw19udocwlwv0vQpjcSDT5XqGbWzvPQyFrG-eRkuu_VZt7cO8-Q$ 
>> Signed-off-by: James Clark<james.clark@arm.com>
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks for the reviews!
