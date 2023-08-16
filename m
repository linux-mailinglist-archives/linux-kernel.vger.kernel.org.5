Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7B77DCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbjHPJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbjHPJCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:02:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C4F51990;
        Wed, 16 Aug 2023 02:02:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3409D1063;
        Wed, 16 Aug 2023 02:02:53 -0700 (PDT)
Received: from [10.57.2.104] (unknown [10.57.2.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89E5A3F64C;
        Wed, 16 Aug 2023 02:02:03 -0700 (PDT)
Message-ID: <7676ff3a-4afc-a26a-8e20-521054298c72@arm.com>
Date:   Wed, 16 Aug 2023 10:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/6] perf arm64: Allow version comparisons of CPU IDs
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-3-james.clark@arm.com>
 <47a32410-d9ca-627b-e8a3-f64d4a1ea95f@oracle.com>
 <4c6a4729-8331-5c47-a81e-f92915e2e848@arm.com>
 <eb23ad55-a46c-4ed7-d2b0-0dcf7d536f89@oracle.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <eb23ad55-a46c-4ed7-d2b0-0dcf7d536f89@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/08/2023 15:43, John Garry wrote:
> On 14/08/2023 15:15, James Clark wrote:
>>
>> On 14/08/2023 14:07, John Garry wrote:
>>> On 11/08/2023 15:39, James Clark wrote:
>>>> Currently variant and revision fields are masked out of the MIDR so
>>>> it's not possible to compare different versions of the same CPU.
>>>> In a later commit a workaround will be removed just for N2 r0p3, so
>>>> enable comparisons on version.
>>>>
>>>> This has the side effect of changing the MIDR stored in the header of
>>>> the perf.data file to no longer have masked version fields.
>>> Did you consider adding a raw version of _get_cpuid(), which returns the
>>> full MIDR just for the purpose of caller strcmp_cpuid_str()?
>> I did, but I thought that seeing as it would only be used in one place,
>> and that changing the existing one didn't break anything, that it was
>> better to not fragment the CPU ID interface. I thought it might also
>> have repercussions for the other architectures as well. It would also
>> mean that the MIDR that's stored in the header wouldn't have the version
>> information, which if we're starting to do things with that could be bad.
>>
>> There are already callers of strcmp_cpuid_str() so it's probably best to
>> keep it using the same get_cpuid() string. Unless there is a reason
>> _not_  to do it? There isn't really anything that can't be done with it
>> accepting/returning the full unmasked MIDR. If you want the old
>> behavior, you just set the version fields to 0, which I've also used in
>> a later patch and is already done in mapfile.csv
>>
> 
> ok, fine, so we seems that we would be following x86 on this in terms of
> using strcmp_cpuid_str(). It would be good to mention that there is
> already a weak version of strcmp_cpuid_str() for !x86 in your commit
> message.
> 

Yep I can add this.

> Let me check your code again...
> 
> Thanks,
> John
