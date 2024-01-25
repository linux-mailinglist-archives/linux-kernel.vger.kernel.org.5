Return-Path: <linux-kernel+bounces-38102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC983BAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB6F1F21BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA3513AF3;
	Thu, 25 Jan 2024 07:51:05 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4CA13AC2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169065; cv=none; b=uumjrPotUR9RwK3RIGSAKlGXG4sRhOYvEysVA1IK7jDZGFkYkrUw4zB+lagnsIE1AI1zvnWnGBeY14Ujjn9lfcKBhHvmgwHmPq6nQamt/PYI7DXIpltN8KGBX8NCNxHQwoi9q/nd4bMnE88ODmH9GscIOMJCXCh3wUK9SnGQQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169065; c=relaxed/simple;
	bh=eriZHgiTuEabaO6CgP5pvILQfwCC+L1hdFiPWCx+o1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6lmQXT7ckk9zg1tiwX5qOic83ypDwI8iTQ+zlLPvWVJWNZAiHvXlzWvlw8qaKzAjDGRVcokKTwec5FwHeVKLTCaUBqH1Mgw79FvWukGwyj/Pp1adj073i3TaBGOa8UTSw+f+mnGdt6CFe+XtLkRdoiNe7Y1st9CXW31o+6hPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.JhImL_1706169052;
Received: from 30.178.67.122(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.JhImL_1706169052)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 15:50:53 +0800
Message-ID: <7301930a-12f8-46d3-b427-144c40d8edb4@linux.alibaba.com>
Date: Thu, 25 Jan 2024 15:50:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] watchdog/softlockup: report the most time-consuming
 hardirq
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>
Cc: akpm@linux-foundation.org, pmladek@suse.com, tglx@linutronix.de,
 maz@kernel.org, liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240123121223.22318-1-yaoma@linux.alibaba.com>
 <20240123121223.22318-3-yaoma@linux.alibaba.com>
 <CAD=FV=X_uLqi1W7JuSjo=WXF5JEvtM=wxbSeFQQ2KhVcW9=Fcw@mail.gmail.com>
From: Bitao Hu <yaoma@linux.alibaba.com>
In-Reply-To: <CAD=FV=X_uLqi1W7JuSjo=WXF5JEvtM=wxbSeFQQ2KhVcW9=Fcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/1/25 08:19, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jan 23, 2024 at 4:12 AM Bitao Hu <yaoma@linux.alibaba.com> wrote:
>>
>> When the watchdog determines that the current soft lockup is due
>> to an interrupt storm based on CPU utilization, reporting the
>> top three most time-consuming hardirq can be quite useful for
>> further troubleshooting.
>> Below is an example of interrupt storm. The call tree does not
>> provide useful information, but we can analyze which interrupt
>> caused the soft lockup by using the time-consuming information
>> of hardirq.
>>
>> [   67.714044] watchdog: BUG: soft lockup - CPU#9 stuck for 28s! [swapper/9:0]
>> [   67.714548] CPU#9 Utilization every 4s during lockup:
>> [   67.714549]  #1: 0.0% system,        0.0% softirq,   95.0% hardirq,  0.0% idle
>> [   67.714551]  #2: 0.0% system,        0.0% softirq,   90.0% hardirq,  0.0% idle
>> [   67.714553]  #3: 0.0% system,        0.0% softirq,   90.0% hardirq,  0.0% idle
>> [   67.714555]  #4: 0.0% system,        0.0% softirq,   95.0% hardirq,  0.0% idle
>> [   67.714556]  #5: 0.0% system,        0.0% softirq,   90.0% hardirq,  0.0% idle
>> [   67.714570] CPU#9 Detect HardIRQ Time exceeds 50% since 45s. Most time-consuming HardIRQs:
>> [   67.714571]  #1: 99.9% irq#7(IPI)
>> [   67.714575]  #2: 0.0% irq#10(arch_timer)
>> [   67.714578]  #3: 0.0% irq#2(IPI)
>> ...
>> [   67.714654] Call trace:
>> [   67.714656]  __do_softirq+0xa8/0x364
>>
>> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
>> ---
>>   include/linux/irq.h     |   9 ++
>>   include/linux/irqdesc.h |   2 +
>>   kernel/irq/irqdesc.c    |   9 +-
>>   kernel/watchdog.c       | 186 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 205 insertions(+), 1 deletion(-)
> 
> Just like on patch #1, I'd overall like to say that I'm very excited
> about this patch and think it'll help track down a lot of issues, so
> please continue moving forward with it!
Sure, I will continue moving forward with it.
> 
> That being said, my gut says that this can be a lot simpler / lower
> overhead if we just use the existing IRQ counts that the framework is
> already keeping track of for us. We could look for the IRQs that had
> the most counts on the soft locked CPU over the period of time.
> 
> It might not be quite as good/accurate compared to what you have here
> but it seems like it would be "good enough". Normally when there's an
> IRQ storm that's so bad that it's causing a softlockup then each IRQ
> isn't actually that slow but they're going off nonstop. It would catch
> that case perfectly.
> 
> I guess maybe (?) the case it wouldn't catch so well would be if you
> had a loop that looked like:
> 
> * CPU from "storming" device takes ~10 ms and finishes.
> * After the "storming" device finishes, we somehow manage to service a
> whole pile of normal interrupts from non-storming devices.
> * After the non-storming interrupts finished, then we went back to
> servicing the slow storming interrupt.
I think there are two issues with using IRQ counts in determining 
interrupt storm:

1. we might not know the normal frequency for each interrupt, witch 
making the IRQ counts inconvenient for comparison.

For instance, in your example, suppose the slow interrupt takes 10ms at 
a frequency of 100Hz; the normal interrupt takes 10us at a frequency of 
500Hz. If we use IRQ counts, we might incorrectly conclude that it is 
the normal interrupt causing softlockup.

2. During an interrupt storm, the IRQ counts recorded by the kernel does 
not necessarily increase.
The softlockup caused by an NVMe interrupt storm that I encountered is a 
case in point. Around the time of the softlockup, the NVMe interrupt 
frequency actually decreased from ~300 kHz to ~17 kHz. However, the 
average time taken per NVMe interrupt increased from  ~2us to ~60us. 
This is because the nvme_irq handler is capable of polling and 
processing multiple interrupts reported by the NVMe controller, which 
are not captured in the kernel's interrupt statistics. The NVMe driver 
handles interrupts frequency is ~660 kHz actually.

Using interrupt time as a criterion of interrupt storm can avoid the 
above two points.

> 
> I haven't dug into the bowels of the Linux IRQ handling well enough to
> know if that would be possible. However, even if it was possible it
> doesn't feel likely to happen. If those "normal" interrupts aren't
> storming then it seems unlikely we'd see more than one of each of them
> between the "storming" interrupts. Thus it feels like the "storming"
> interrupt would still have the highest (or tied for the highest) count
> on the locked up CPU. Maybe you could print the top 4 or 5 (instead of
> the top 3) and you'd be pretty certain to catch even this case?
> 
> In any case, I'll wait before doing a more thorough review for now and
> hope the above sounds right to you.
> 
> -Doug

