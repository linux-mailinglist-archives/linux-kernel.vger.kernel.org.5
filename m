Return-Path: <linux-kernel+bounces-25464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C22382D0B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66EB1F219F1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A443C2C;
	Sun, 14 Jan 2024 13:03:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A6028FA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6D5A1FB;
	Sun, 14 Jan 2024 05:03:36 -0800 (PST)
Received: from [192.168.2.88] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF8283F73F;
	Sun, 14 Jan 2024 05:02:47 -0800 (PST)
Message-ID: <711c20cf-4aa7-4380-b076-195736bc4978@arm.com>
Date: Sun, 14 Jan 2024 14:02:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Content-Language: en-US
To: Wyes Karny <wkarny@gmail.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc> <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240114123759.pjs7ctexcpc6pshl@wyes-pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/01/2024 13:37, Wyes Karny wrote:
> On Sun, Jan 14, 2024 at 12:18:06PM +0100, Vincent Guittot wrote:
>> Hi Wyes,
>>
>> Le dimanche 14 janv. 2024 ï¿½ 14:42:40 (+0530), Wyes Karny a ï¿½crit :
>>> On Wed, Jan 10, 2024 at 02:57:14PM -0800, Linus Torvalds wrote:
>>>> On Wed, 10 Jan 2024 at 14:41, Linus Torvalds
>>>> <torvalds@linux-foundation.org> wrote:

[...]

> Yeah, correct something was wrong in the bpftrace readings, max_cap is
> not zero in traces.
> 
>              git-5511    [001] d.h1.   427.159763: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
>              git-5511    [001] d.h1.   427.163733: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
>              git-5511    [001] d.h1.   427.163735: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
>              git-5511    [001] d.h1.   427.167706: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
>              git-5511    [001] d.h1.   427.167708: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
>              git-5511    [001] d.h1.   427.171678: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
>              git-5511    [001] d.h1.   427.171679: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
>              git-5511    [001] d.h1.   427.175653: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
>              git-5511    [001] d.h1.   427.175655: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
>              git-5511    [001] d.s1.   427.175665: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
>              git-5511    [001] d.s1.   427.175665: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> 
> Debug patch applied:
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..5c9b3e1de7a0 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -166,6 +166,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> 
>         freq = get_capacity_ref_freq(policy);
>         freq = map_util_freq(util, freq, max);
> +       trace_printk("[DEBUG] : freq %llu, util %llu, max %llu\n", freq, util, max);
> 
>         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>                 return sg_policy->next_freq;
> @@ -199,6 +200,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>         util = max(util, boost);
>         sg_cpu->bw_min = min;
>         sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
> +       trace_printk("[DEBUG] : util %llu, sg_cpu->util %llu\n", util, sg_cpu->util);
>  }
> 
>  /**
> 
> 
> So, I guess map_util_freq going wrong somewhere.

sugov_update_single_freq() -> get_next_freq() -> get_capacity_ref_freq()

Is arch_scale_freq_invariant() true in both cases, so that
get_capacity_ref_freq() returns 'policy->cpuinfo.max_freq' and not just
'policy->cur'?


