Return-Path: <linux-kernel+bounces-26070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1068682DAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB5C1C21B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E3317589;
	Mon, 15 Jan 2024 14:03:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908917583
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC3A62F4;
	Mon, 15 Jan 2024 06:04:14 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B13383F6C4;
	Mon, 15 Jan 2024 06:03:25 -0800 (PST)
Message-ID: <dfde5b4f-0d5e-49b6-a787-0766eff23f91@arm.com>
Date: Mon, 15 Jan 2024 15:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Qais Yousef <qyousef@layalina.io>
Cc: Wyes Karny <wkarny@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
References: <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc> <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc>
 <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114151250.5wfexq44o3mdm3nh@airbuntu>
 <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>
 <20240114195815.nes4bn53tc25djbh@airbuntu>
 <CAKfTPtCGgJiFDrZYpynCiHBnQx48A9RsAY9-6Hshduo4ymGJLQ@mail.gmail.com>
 <20240115120915.fukpcdumntdsllwi@airbuntu>
 <CAKfTPtAMacH4hKLyttLuQJjzc=D4m864MFaEEwZLG4K8RKTDYA@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtAMacH4hKLyttLuQJjzc=D4m864MFaEEwZLG4K8RKTDYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 14:26, Vincent Guittot wrote:
> On Mon, 15 Jan 2024 at 13:09, Qais Yousef <qyousef@layalina.io> wrote:
>>
>> On 01/15/24 09:21, Vincent Guittot wrote:
>>
>>>> Or I've done the math wrong :-) But the two don't behave the same for the same
>>>> kernel with and without CPPC.
>>>
>>> They will never behave the same because they can't
>>> - with invariance, the utilization is the utilization at max capacity
>>> so we can easily jump several OPP to go directly to the right one
>>> - without invariance, the utilization is the utilization at current
>>> OPP so we can only jump to a limited number of OPP
>>
>> I am probably missing some subtlty, but the  behavior looks more sensible to
>> me when we divide by current capacity instead of max one.
>>
>> It seems what you're saying is that the capacity range for each OPP is 0-1024.
> 
> Yes that's the case when you don't have frequency invariance
> 
>> And that's when we know that we saturated the current capacity level we decide
>> to move on.
> 
> yes
> 
>>
>> As I am trying to remove the hardcoded headroom values I am wary of another
>> one. But it seems this is bandaid scenario anyway; so maybe I shouldn't worry
>> too much about it.

I still don't fully understand this fix.

We had:

sugov_update_single_freq()

  sugov_update_single_common()

  next_f = get_next_freq()

   freq = arch_scale_freq_invariant() ?
          policy->cpuinfo.max_freq : policy->cur (**) <- (2) !freq_inv


  util = map_util_perf(util);                     <- (1) util *= 1.25

  freq = map_util_freq(util, freq, max);          <- (3)
}



And now there is:

sugov_update_single_freq()

  sugov_update_single_common()

    sugov_get_util()

      sg_cpu->util = sugov_effective_cpu_perf()

        /* Add dvfs headroom to actual utilization */
        actual = map_util_perf(actual)            <- (1) util *= 1.25

  next_f = get_next_freq()

    freq = get_capacity_ref_freq()

      return policy->cur (*)                      <- (2) !freq_inv

    freq = map_util_freq(util, freq, max)         <- (3)

Still not clear to me why we need this extra 'policy->cur *= 1.25' here
(*) and not here (**)



