Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7322380F68A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376652AbjLLTWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLLTWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:22:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4226AD;
        Tue, 12 Dec 2023 11:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702408972; x=1733944972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O45Xbl/7tJ9DpXNiIOh4vllAPXxwHYQM/gneJnoJZKE=;
  b=f+1H0zkP89DkfDVCiULor5TGTsefTPdewTAd86pjIB/r3n8AlsjYku7l
   Qm7EdYvA9piG0bSru8qTnT8ay3uR5Qp9ePCrDA6D2yAwvcVjXQk78e3eB
   x9h+jrgYwrE8yTZcSVcQXicABlM1i3EcHQg7s4scUhOwd7Yr7w2TqlY4j
   mGuIsUHKcYakbe0mBBGYnfDqIQi/A8ReACyNGww3y0a5GlQvkpV+yH8Bc
   kThFNsOst5LU1ZXvTZDc2+JtGRPGdelwZ8KF/5iozG+hRdNi5B9X5Bn69
   mWu45gYICiPTEWWx1cgQ8p0L61TpyIDNxwQ4JOZRJIMUpX7om3RMvSa0f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481056376"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="481056376"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 11:22:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="946890572"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="946890572"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 11:22:51 -0800
Received: from [10.209.138.122] (kliang2-mobl1.ccr.corp.intel.com [10.209.138.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A1EC5580DC5;
        Tue, 12 Dec 2023 11:22:50 -0800 (PST)
Message-ID: <56f4ba32-a0c6-4ae4-8bf9-c00aaed65fc5@linux.intel.com>
Date:   Tue, 12 Dec 2023 14:22:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, maz@kernel.org,
        marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
 <CAM9d7cgxCg0bgWRUg2rkR1dFfpTEUX6AZdw-Od5yALiL33ymQg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7cgxCg0bgWRUg2rkR1dFfpTEUX6AZdw-Od5yALiL33ymQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-12 1:49 p.m., Namhyung Kim wrote:
> On Tue, Dec 12, 2023 at 10:31 AM Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> On Tue, Dec 12, 2023 at 10:00:16AM -0800, Ian Rogers wrote:
>>> On Tue, Dec 12, 2023 at 9:23 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>
>>>> On Tue, Dec 12, 2023 at 7:56 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
>>>>>> Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com escreveu:
>>>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>>>
>>>>>>> perf top errors out on a hybrid machine
>>>>>>>  $perf top
>>>>>>>
>>>>>>>  Error:
>>>>>>>  The cycles:P event is not supported.
>>>>>>>
>>>>>>> The user_requested_cpus may contain CPUs that are invalid for a hybrid
>>>>>>> PMU. It causes perf_event_open to fail.
>>>>>>
>>>>>> ?
>>>>>>
>>>>>> All perf top expects is that the "cycles", the most basic one, be
>>>>>> collected, on all CPUs in the system.
>>>>>>
>>>>>
>>>>> Yes, but for hybrid there is no single "cycles" event which can cover
>>>>> all CPUs.
>>>>
>>>> Does that mean the kernel would reject the legacy "cycles" event
>>>> on hybrid CPUs?
>>>
>>> I believe not. When the extended type isn't set on legacy cycles we
>>> often have the CPU and from that can determine the PMU. The issue is
>>> with the -1 any CPU perf_event_open option. As I was told, the PMU the
>>> event is opened on in this case is the first one registered in the
>>> kernel, on Intel hybrid this could be cpu_core or cpu_atom.. but IIRC
>>> it'll probably be cpu_core. On ARM ¯\_(ツ)_/¯.
>>
>> On ARM it'll be essentially the same as on x86: if you open an event with
>> type==PERF_EVENT_TYPE_HARDWARE (without the extended HW type pointing to a
>> specific PMU), and with cpu==-1, it'll go to an arbitrary CPU PMU, whichever
>> happens to be found by perf_init_event() when iterating over the 'pmus' list.
>>
>> If you open an event with type==PERF_EVENT_TYPE_HARDWARE and cpu!=-1, the event
>> will opened on the appropriate CPU PMU, by virtue of being rejected by others
>> when perf_init_event() iterates over the 'pmus' list.
> 
> Ok, that means "cycles" with cpu == -1 would not work well.
>

Unless a PMU is specified.

> I'm curious if it's possible to do some basic work at the event_init()
> like to preserve (common) resource and to do some other work at
> sched to config PMU on the current CPU.  So that users can simply
> use "cycles" or "instructions" for their processes.
> 

The current code treats the hybrid as two standalone PMUs. To preserve
the common resource in the other PMU, I think the only way is to create
an event on the other PMU. It's what perf tool does now. I don't think
we want to move the logic to the kernel.

I think a possible way is to abstract a common PMU (cpu) which only
includes common PMU features. It should be doable, because without the
enabling code of hybrid, the default PMU is the common PMU. But I don't
know how does it coexist with the other hybrid PMUs if we have both
common PMU and hybrid PMUs available? It may just bring more complexity.

Thanks,
Kan
