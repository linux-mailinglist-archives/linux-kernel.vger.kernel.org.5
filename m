Return-Path: <linux-kernel+bounces-158370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5AF8B1EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA8C28365C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4BA86264;
	Thu, 25 Apr 2024 10:15:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD82B6EB52;
	Thu, 25 Apr 2024 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040117; cv=none; b=pRCEKk4ALXI9bL+z2ieJI7del5WD5WtSnjfUt0i3RbBQNcxYVFEwe0kB1x86v/Tmp0v444sBlbkq4wyQSmUxdDlbIzoTl28IgW6Gvg6zKGneDfsmqSXUq1A0MwghYgm4uryllZfVUGd2s7DiOV4vVL1u3AIXE6uQHi4m4NYJhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040117; c=relaxed/simple;
	bh=+s/Le6r8EFv4cqCtd1Bx2t0YRlTjI4h3wOhaGBCcfnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoPe6fdwObDZC/yDHDcmo1nvVxal6CDWtOFbxcadhKgM8VNDg0QbkmpJg13CFKALBwilUnP3WJchAZbsblW6DcrEKppdtXyGL/3qiM091rf/OXWFITboqSe6ouPuBKSLTs/UGGYuFG9EUL29cI1MfZfuHrAIbqepIL+vXaCpRDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A7D71007;
	Thu, 25 Apr 2024 03:15:43 -0700 (PDT)
Received: from [10.1.30.55] (e133047.arm.com [10.1.30.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F0983F64C;
	Thu, 25 Apr 2024 03:15:12 -0700 (PDT)
Message-ID: <9272d284-ec2c-4e35-be90-c8852278b648@arm.com>
Date: Thu, 25 Apr 2024 11:15:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [timers] 7ee9887703: stress-ng.uprobe.ops_per_sec
 -17.1% regression
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
 feng.tang@intel.com, fengwei.yin@intel.com,
 Frederic Weisbecker <frederic@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
References: <87zfth3l6y.fsf@somnus>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <87zfth3l6y.fsf@somnus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/04/2024 09:23, Anna-Maria Behnsen wrote:
> Hi,
> 
> (adding cpuidle/power people to cc-list)
> 
> Oliver Sang <oliver.sang@intel.com> writes:
> 
>> hi, Frederic Weisbecker,
>>
>> On Tue, Apr 02, 2024 at 12:46:15AM +0200, Frederic Weisbecker wrote:
>>> Le Wed, Mar 27, 2024 at 04:39:17PM +0800, kernel test robot a écrit :
>>>>
>>>>
>>>> Hello,
>>>>
>>>>
>>>> we reported
>>>> "[tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps -1.2% regression"
>>>> in
>>>> https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.com/
>>>>
>>>> now we noticed this commit is in mainline and we captured further results.
>>>>
>>>> still include netperf results for complete. below details FYI.
>>>>
>>>>
>>>> kernel test robot noticed a -17.1% regression of stress-ng.uprobe.ops_per_sec
>>>> on:
>>>
>>> The good news is that I can reproduce.
>>> It has made me spot something already:
>>>
>>>    https://lore.kernel.org/lkml/ZgsynV536q1L17IS@pavilion.home/T/#m28c37a943fdbcbadf0332cf9c32c350c74c403b0
>>>
>>> But that's not enough to fix the regression. Investigation continues...
>>
>> Thanks a lot for information! if you want us test any patch, please let us know.
> 
> Oliver, I would be happy to see, whether the patch at the end of the
> message restores the original behaviour also in your test setup. I
> applied it on 6.9-rc4. This patch is not a fix - it is just a pointer to
> the kernel path, that might cause the regression. I know, it is
> probable, that a warning in tick_sched is triggered. This happens when
> the first timer is alredy in the past. I didn't add an extra check when
> creating the 'defacto' timer thingy. But existing code handles this
> problem already properly. So the warning could be ignored here.
> 
> For the cpuidle people, let me explain what I oberserved, my resulting
> assumption and my request for help:
> 
> cpuidle governors use expected sleep length values (beside other data)
> to decide which idle state would be good to enter. The expected sleep
> length takes the first queued timer of the CPU into account and is
> provided by tick_nohz_get_sleep_length(). With the timer pull model in
> place the non pinned timers are not taken into account when there are
> other CPUs up and running which could handle those timers. This could
> lead to increased sleep length values. On my system during the stress-ng
> uprobes test it was in the range of maximum 100us without the patch set
> and with the patch set the maximum was in a range of 200sec. This is
> intended behaviour, because timers which could expire on any CPU should
> expire on the CPU which is busy anyway and the non busy CPU should be
> able to go idle.
> 
> Those increased sleep length values were the only anomalies I could find
> in the traces with the regression.
> 
> I created the patch below which simply fakes the sleep length values
> that they take all timers of the CPU into account (also the non
> pinned). This patch kind of restores the behavoir of
> tick_nohz_get_sleep_length() before the change but still with the timer
> pull model in place.
> 
> With the patch the regression was gone, at least on my system (using
> cpuidle governor menu but also teo).

I assume the regression is reproducible for both?
(The original report is using menu for anyone else looking at this)

> 
> So my assumption here is, that cpuidle governors assume that a deeper
> idle state could be choosen and selecting the deeper idle state makes an
> overhead when returning from idle. But I have to notice here, that I'm
> still not familiar with cpuidle internals... So I would be happy about
> some hints how I can debug/trace cpuidle internals to falsify or verify
> this assumption.

I'd say that sounds correct.
Comparing cpu_idle_miss would be interesting for both.

Regards,
Christian

> [snip]

