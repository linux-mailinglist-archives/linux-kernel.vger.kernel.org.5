Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C151D75F8DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGXNuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGXNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:49:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52979421A;
        Mon, 24 Jul 2023 06:47:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF3FA1655;
        Mon, 24 Jul 2023 06:47:22 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E8893F67D;
        Mon, 24 Jul 2023 06:46:37 -0700 (PDT)
Message-ID: <5876adba-0507-6bfd-6ede-74f8e7aa55f2@arm.com>
Date:   Mon, 24 Jul 2023 14:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
To:     Will Deacon <will@kernel.org>, Ian Rogers <irogers@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230710122138.1450930-1-james.clark@arm.com>
 <20230710122138.1450930-2-james.clark@arm.com>
 <e111d9ac-c4f6-c541-313b-7a3a6acfb5d2@arm.com>
 <597f53e0-5a5b-75a1-4054-253630a941f2@arm.com>
 <CAP-5=fVpjJLBNCd4LJ7krX1tpqUT-S_DCRebXR1ioTCGFsF6Pw@mail.gmail.com>
 <20230721102131.GA12457@willie-the-truck>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230721102131.GA12457@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/2023 11:21, Will Deacon wrote:
> On Thu, Jul 20, 2023 at 10:12:21AM -0700, Ian Rogers wrote:
>> On Tue, Jul 11, 2023 at 7:12 AM James Clark <james.clark@arm.com> wrote:
>>>
>>>
>>>
>>> On 11/07/2023 13:01, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 7/10/23 17:51, James Clark wrote:
>>>>> This capability gives us the ability to open PERF_TYPE_HARDWARE and
>>>>> PERF_TYPE_HW_CACHE events on a specific PMU for free. All the
>>>>> implementation is contained in the Perf core and tool code so no change
>>>>> to the Arm PMU driver is needed.
>>>>>
>>>>> The following basic use case now results in Perf opening the event on
>>>>> all PMUs rather than picking only one in an unpredictable way:
>>>>>
>>>>>   $ perf stat -e cycles -- taskset --cpu-list 0,1 stress -c 2
>>>>>
>>>>>    Performance counter stats for 'taskset --cpu-list 0,1 stress -c 2':
>>>>>
>>>>>          963279620      armv8_cortex_a57/cycles/                (99.19%)
>>>>>          752745657      armv8_cortex_a53/cycles/                (94.80%)
>>>>>
>>>>> Fixes: 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE")
>>>>> Suggested-by: Ian Rogers <irogers@google.com>
>>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>
>> Hi ARM Linux and ARM Linux PMU people,
>>
>> Could this patch be picked up for Linux 6.5? I don't see it in the
>> tree and it seems a shame to have to wait for it. The other patches do
>> cleanup and so waiting for 6.6 seems okay.
> 
> I'm only taking fixes for 6.5 and I don't think this qualifies.
> 
> If it was an oversight introduced during the recent merge window, then
> I'd be happier fixing it up, but 55bcf6ef314a was merged ages ago (v5.12?),
> so I think we can wait.
> 
> I'll be queuing perf changes for 6.6 next week, so I'll look at this
> then.
> 
> Cheers,
> 
> Will

Hi Will,

Thanks for looking at this. I've sent a v2 with Anshuman's fixes.

James
