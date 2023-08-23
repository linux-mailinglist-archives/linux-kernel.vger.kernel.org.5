Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C28785525
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjHWKPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjHWKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:14:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE8510CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:14:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692785678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=xHAy/sMONweUS/DhPb0E5JyPCBTL0TCK63jYWN/GUBw=;
        b=MaFU7WgNJNXbv+VAo2Ng2Saag+bl1U9CuHPLj50Ck68lWbxm4reFqSyROvCqCDrmTn5cUV
        JoHseGcrvoB2S31sfk2KzqAmgL3KTDHeo2tedg0xOS36DHh5JHjKoLwUjQSvhc5Z5x6I3h
        +rPYXfz/HU+SVZmpHmf6FJ8hmVYdPPilvyahj9bIlFr1O0AD6GU5EgdKCf6UtDazx0TmQs
        Lpw+07jJ6UppqUPQHlvM+B9FwNseFFt3Hc9Ox405GrNV5Es+Ky030KD/b7ooLMawM7LL/S
        Zz+8lMF8BkJOUVsyTET0odZyhEvhbqJ2uV3UgAudIFAUzLcwM+6ESEmrf8Oatw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692785678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=xHAy/sMONweUS/DhPb0E5JyPCBTL0TCK63jYWN/GUBw=;
        b=w0rJPPoPOb77vzsk69ycDWLo+QBz9XjT5hbA++ZEMKdeZRboIEOl81UoCSTPT2Qb6OXs2j
        G+hoLOhgRc5QXhAg==
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, vschneid@redhat.com,
        Phil Auld <pauld@redhat.com>, vdonnefort@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, zhangqiao22@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
In-Reply-To: <CAKfTPtBSx7h1caR9g8wEK5GG2JMfSBRqSzLgjRUjrnp1Zc-ssg@mail.gmail.com>
Date:   Wed, 23 Aug 2023 12:14:37 +0200
Message-ID: <87h6oqdq0i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29 2023 at 10:30, Vincent Guittot wrote:
> On Thu, 29 Jun 2023 at 00:01, Thomas Gleixner <tglx@linutronix.de> wrote:
>>  int cpu_device_down(struct device *dev)
>>  {
>> -       return cpu_down(dev->id, CPUHP_OFFLINE);
>> +       unsigned int cpu = cpumask_any_but(cpu_online_mask, dev->id);
>> +
>> +       if (cpu >= nr_cpu_ids)
>> +               return -EBUSY;
>> +
>> +       return work_on_cpu(cpu, __cpu_device_down, dev);
>
> The comment for work_on_cpu :
>
>  * It is up to the caller to ensure that the cpu doesn't go offline.
>  * The caller must not hold any locks which would prevent @fn from completing.
>
> make me wonder if this should be done only once the hotplug lock is
> taken so the selected cpu will not go offline

That makes sense. Updated and again untested patch below.

Thanks,

        tglx
---
Subject: cpu/hotplug: Prevent self deadlock on CPU hot-unplug
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 23 Aug 2023 10:47:02 +0200

Xiongfeng reported and debugged a self deadlock of the task which initiates
and controls a CPU hot-unplug operation vs. the CFS bandwidth timer.

    CPU1      			                 	 CPU2

T1 sets cfs_quota
   starts hrtimer cfs_bandwidth 'period_timer'
T1 is migrated to CPU2				
						T1 initiates offlining of CPU1
Hotplug operation starts
  ...
'period_timer' expires and is re-enqueued on CPU1
  ...
take_cpu_down()
  CPU1 shuts down and does not handle timers
  anymore. They have to be migrated in the
  post dead hotplug steps by the control task.

						T1 runs the post dead offline operation
					      	T1 is scheduled out
						T1 waits for 'period_timer' to expire

T1 waits there forever if it is scheduled out before it can execute the hrtimer
offline callback hrtimers_dead_cpu().

Cure this by delegating the hotplug control operation to a worker thread on
an online CPU. This takes the initiating user space task, which might be
affected by the bandwidth timer, completely out of the picture.

Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com
---
 kernel/cpu.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1467,8 +1467,22 @@ static int __ref _cpu_down(unsigned int
 	return ret;
 }
 
+struct cpu_down_work {
+	unsigned int		cpu;
+	enum cpuhp_state	target;
+};
+
+static long __cpu_down_maps_locked(void *arg)
+{
+	struct cpu_down_work *work = arg;
+
+	return _cpu_down(work->cpu, 0, work->target);
+}
+
 static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 {
+	struct cpu_down_work work = { .cpu = cpu, .target = target, };
+
 	/*
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
@@ -1477,7 +1491,15 @@ static int cpu_down_maps_locked(unsigned
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
-	return _cpu_down(cpu, 0, target);
+
+	/*
+	 * Ensure that the control task does not run on the to be offlined
+	 * CPU to prevent a deadlock against cfs_b->period_timer.
+	 */
+	cpu = cpumask_any_but(cpu_online_mask, cpu);
+	if (cpu >= nr_cpu_ids)
+		return -EBUSY;
+	return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
 }
 
 static int cpu_down(unsigned int cpu, enum cpuhp_state target)
