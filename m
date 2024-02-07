Return-Path: <linux-kernel+bounces-56008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9707084C4E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8BDEB27D82
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43671CD21;
	Wed,  7 Feb 2024 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cCoF84+s"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4831CD1B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286732; cv=none; b=WuIJj+bfYu1Ean4OHdS0ETyaVp6HUy0pogW8/QaMnm0juzjO1K7J/jtzdwwfnmTK282R4RI8fXzMvwsKwDVk25btCxzQYyuJJFgZWbOIl0p95CVbgB5UFzul0U635va61P8v633woPbmbnqic1EPzZQvgtL7X3QytOc+BYgtnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286732; c=relaxed/simple;
	bh=WiwO3Gt1+WS89Pl1lzhydHse7eC79DiiER0deW93QRs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BaF5KCsDM3x83TKfIjaRYFsGqJAOclE+htvnNp2TBKFd+7reRC68t3FOvHWyJNOlFGof3T6F8SxPe+dwwaFD7WIdI3OR4rkHvOgmK0FP8pjoy34eLybvVpIzbaFCK5BnwXnDiWSFW1tr/OFoWIhd3KEiyTuDGyJ3p3ngn9ef5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cCoF84+s; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707286720; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=oJn5/8Zg79JD9ZFEyNa0c/KhIKs7G7x61eOVjn1QnWg=;
	b=cCoF84+sV8mjl/Pm0ow2jhzue7a9LZInw4atLr8oPYmDHpfidmVs0bxlPru+/sGUlSlBgcwanqspbQJwLOvbu7XDlc9oyBhPvtqLwEZ0mxlaXoD1FFUUwQdbHFnOC56+uFOh9p3JfcLmiJfNzx28a3n7dK1VsALcTZamIYtN/+s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0FmdUi_1707286718;
Received: from 192.168.0.104(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0FmdUi_1707286718)
          by smtp.aliyun-inc.com;
          Wed, 07 Feb 2024 14:18:40 +0800
Message-ID: <1cdff175-37d8-4223-a3ca-07699a5f8a6c@linux.alibaba.com>
Date: Wed, 7 Feb 2024 14:18:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv5 1/3] watchdog/softlockup: low-overhead detection of
 interrupt
To: Doug Anderson <dianders@chromium.org>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com,
 liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240206095902.56406-1-yaoma@linux.alibaba.com>
 <20240206095902.56406-2-yaoma@linux.alibaba.com>
 <CAD=FV=V+mcBdeq8mmH0h41byUtL-G1zFmZQtj341ubwqyPxD1A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAD=FV=V+mcBdeq8mmH0h41byUtL-G1zFmZQtj341ubwqyPxD1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2024/2/7 05:41, Doug Anderson wrote:
> Hi,
> 
> On Tue, Feb 6, 2024 at 1:59 AM Bitao Hu <yaoma@linux.alibaba.com> wrote:
>>
>> The following softlockup is caused by interrupt storm, but it cannot be
>> identified from the call tree. Because the call tree is just a snapshot
>> and doesn't fully capture the behavior of the CPU during the soft lockup.
>>    watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>>    ...
>>    Call trace:
>>      __do_softirq+0xa0/0x37c
>>      __irq_exit_rcu+0x108/0x140
>>      irq_exit+0x14/0x20
>>      __handle_domain_irq+0x84/0xe0
>>      gic_handle_irq+0x80/0x108
>>      el0_irq_naked+0x50/0x58
>>
>> Therefore，I think it is necessary to report CPU utilization during the
>> softlockup_thresh period (report once every sample_period, for a total
>> of 5 reportings), like this:
>>    watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>>    CPU#28 Utilization every 4s during lockup:
>>      #1: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #2: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #3: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #4: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #5: 0% system, 0% softirq, 100% hardirq, 0% idle
>>    ...
>>
>> This would be helpful in determining whether an interrupt storm has
>> occurred or in identifying the cause of the softlockup. The criteria for
>> determination are as follows:
>>    a. If the hardirq utilization is high, then interrupt storm should be
>>    considered and the root cause cannot be determined from the call tree.
>>    b. If the softirq utilization is high, then we could analyze the call
>>    tree but it may cannot reflect the root cause.
>>    c. If the system utilization is high, then we could analyze the root
>>    cause from the call tree.
>>
>> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
>> ---
>>   kernel/watchdog.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 89 insertions(+)
> 
> On v4 you got Liu Song's Reviewed-by and I don't think this is
> massively different than v4. I would have expected you to carry the
> tag forward. In any case ,I guess Liu Song can give it again.. >
> 
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 81a8862295d6..71d5b6dfa358 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -16,6 +16,8 @@
>>   #include <linux/cpu.h>
>>   #include <linux/nmi.h>
>>   #include <linux/init.h>
>> +#include <linux/kernel_stat.h>
>> +#include <linux/math64.h>
>>   #include <linux/module.h>
>>   #include <linux/sysctl.h>
>>   #include <linux/tick.h>
>> @@ -333,6 +335,90 @@ __setup("watchdog_thresh=", watchdog_thresh_setup);
>>
>>   static void __lockup_detector_cleanup(void);
>>
>> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
>> +#define NUM_STATS_GROUPS       5
>> +#define NUM_STATS_PER_GROUP    4
>> +enum stats_per_group {
>> +       STATS_SYSTEM,
>> +       STATS_SOFTIRQ,
>> +       STATS_HARDIRQ,
>> +       STATS_IDLE,
> 
> nit: I still would have left "NUM_STATS_PER_GROUP" here instead of as
> a separate #define.
OK.
> 
> 
>> +static void print_cpustat(void)
>> +{
>> +       int i, group;
>> +       u8 tail = __this_cpu_read(cpustat_tail);
> 
> Sorry for not noticing before, but why are you using
> "__this_cpu_read()" instead of "this_cpu_read()"? In other words, why
> do you need the double-underscore version everywhere? I don't think
> you do, do you?
I also struggled with which version of the operation to use. The one
without double-underscores provides preemption/interrupt protection,
but in watchdog.c, the version with double-underscores is used. I
analyzed that it is also safe to use the version without
preemption/interrupt protection in my code, so to maintain consistency
with watchdog.c, I ues the version with double-underscores.

Is my approach reasonable? If not, I will switch to using the
non-underscored version.
> 
> 
>> +       u64 sample_period_second = sample_period;
>> +
>> +       do_div(sample_period_second, NSEC_PER_SEC);
>> +       /*
>> +        * We do not want the "watchdog: " prefix on every line,
>> +        * hence we use "printk" instead of "pr_crit".
>> +        */
>> +       printk(KERN_CRIT "CPU#%d Utilization every %llus during lockup:\n",
>> +               smp_processor_id(), sample_period_second);
>> +       for (i = 0; i < NUM_STATS_GROUPS; i++) {
>> +               group = (tail + i) % NUM_STATS_GROUPS;
>> +               printk(KERN_CRIT "\t#%d: %3u%% system,\t%3u%% softirq,\t"
>> +                       "%3u%% hardirq,\t%3u%% idle\n", i+1,
> 
> nit: though I don't care too much in this case, I think kernel folks
> slightly prefer "i + 1" instead of "i+1". Running
> "./scripts/checkpatch.pl --strict" will give a warning about this, for
> instance. Actually, "./scripts/checkpatch.pl --strict" has a few extra
> style nits that you could consider fixing.
Thanks for your reminder. I will use "./scripts/checkpatch.pl --strict"
to check and correct these patches.
> 
> 
>> +static void report_cpu_status(void)
>> +{
>> +       print_cpustat();
>> +}
> 
> I don't understand why you need the extra wrapper. You didn't have it
> on v3 and I don't see any reason why you introduced it. Ah, I see, in
> the next patch you add something to it. OK, I guess it's fine to
> introduce it here.
Yes, I add this wrapper to prepare for the next patch, to avoid
predeclaring of "print_irq_counts".


> 
> -Doug

