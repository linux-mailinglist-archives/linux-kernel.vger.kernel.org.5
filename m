Return-Path: <linux-kernel+bounces-147010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6F8A6E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69911C208C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052E132C0E;
	Tue, 16 Apr 2024 14:25:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9348512D1FD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277534; cv=none; b=qJOVSAzT/HjCf2hxJ1B61+AdlxuDmsz/TkqYBtOkqlHW9dS3Obor3kZu3Dw+RQOd4vW4/D/2rjqq0aR/xlQHDlBFhptWiKcO3K4iqekbD54TXWhZibIa5wOkoGRn5sJK68MGzcXV1zsSIfHeErRVOLl4AN5FkAdMkVVfrgOlipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277534; c=relaxed/simple;
	bh=NtzZhWCLoYDyDEaIaBdGSQB1n+vHC8iXmb9QjPQS5BU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uZGZ4+SG75Z4jQK25EX7Ze1Q/h8sf/1jOWrTQXN8TqU8RrmI45LOIZ3vudcpo8FusZPuewsCdqsDoV/l2R+sGlEUXX/iSS0JkrBwOWjoXbefbsg71x6cqwMVrtjgnwY0LRcteeK/ravgHzjIxnwaXAA99QbdSZh7yWdlN5Qmxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37503339;
	Tue, 16 Apr 2024 07:25:58 -0700 (PDT)
Received: from [10.1.26.17] (e133047.arm.com [10.1.26.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE3F73F738;
	Tue, 16 Apr 2024 07:25:28 -0700 (PDT)
Message-ID: <29b6f42f-6917-4584-a53a-4711754c6fcf@arm.com>
Date: Tue, 16 Apr 2024 15:25:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/core: split iowait state into two states
From: Christian Loehle <christian.loehle@arm.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de
References: <20240416121526.67022-1-axboe@kernel.dk>
 <20240416121526.67022-5-axboe@kernel.dk>
 <f1685b30-9d0d-419e-b004-590edf21315a@arm.com>
Content-Language: en-US
In-Reply-To: <f1685b30-9d0d-419e-b004-590edf21315a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2024 15:10, Christian Loehle wrote:
>>[snip]
>> +	atomic_long_add(val, &task_rq(p)->nr_iowait);
>>  #else
>> -	atomic_inc(&task_rq(p)->nr_iowait);
>> +	int val = 1 + ((int) p->in_iowait_acct << 16);
>> +	atomic_add(val, &task_rq(p)->nr_iowait);
>>  #endif
>>  }
>>  
>>  static void task_iowait_dec(struct task_struct *p)
>>  {
>>  #ifdef CONFIG_64BIT
>> -	atomic_long_dec(&task_rq(p)->nr_iowait);
>> +	long val = 1 + ((long) p->in_iowait_acct << 32);
>> +	atomic_long_sub(val, &task_rq(p)->nr_iowait);
>>  #else
>> -	atomic_dec(&task_rq(p)->nr_iowait);
>> +	int val = 1 + ((int) p->in_iowait_acct << 16);
>> +	atomic_sub(val, &task_rq(p)->nr_iowait);
>>  #endif
>>  }
>>  
>>  int rq_iowait(struct rq *rq)
>>  {
>>  #ifdef CONFIG_64BIT
>> -	return atomic_long_read(&rq->nr_iowait);
>> +	return atomic_long_read(&rq->nr_iowait) & ((1UL << 32) - 1);
>> +#else
>> +	return atomic_read(&rq->nr_iowait) & ((1U << 16) - 1);
>> +#endif
>> +}
>> +
>> +int rq_iowait_acct(struct rq *rq)
>> +{
>> +#ifdef CONFIG_64BIT
>> +	return atomic_long_read(&rq->nr_iowait) >> 32;
>>  #else
>> -	return atomic_read(&rq->nr_iowait);
>> +	return atomic_read(&rq->nr_iowait) >> 16;
>>  #endif
>>  }
>>  
>> @@ -5497,7 +5514,12 @@ unsigned long long nr_context_switches(void)
>>   * it does become runnable.
>>   */
>>  
>> -unsigned int nr_iowait_cpu(int cpu)
>> +unsigned int nr_iowait_acct_cpu(int cpu)
> 
> There is a comment above here by Daniel referring to "these two
> interfaces [...]", originally referring to nr_iowait_cpu() and
> get_iowait_load().
> get_iowait_load() was removed in commit a7fe5190c03f ("cpuidle: menu: Remove get_loadavg() from the performance multiplier")
> but nr_iowait_cpu() remains, so the comment should remain above it.
> Rewording is also way overdue, although that's hardly on your
> patch ;)
> 
FWIW, but also feel free to reword yourself.

From ba66fe24c64f5615b9820b0fe24857ecbf18fc5f Mon Sep 17 00:00:00 2001
From: Christian Loehle <christian.loehle@arm.com>
Date: Tue, 16 Apr 2024 15:20:22 +0100
Subject: [PATCH] sched/core: Reword comment about iowait interface

The original comment referenced an interface which was removed in
the meantime by commit a7fe5190c03f ("cpuidle: menu: Remove
get_loadavg() from the performance multiplier").

Furthermore the function has moved so move the comment accordingly.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d52d3118dd73..bb10b9bc37d6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5507,18 +5507,19 @@ unsigned long long nr_context_switches(void)
 	return sum;
 }
 
-/*
- * Consumers of these two interfaces, like for example the cpuidle menu
- * governor, are using nonsensical data. Preferring shallow idle state selection
- * for a CPU that has IO-wait which might not even end up running the task when
- * it does become runnable.
- */
 
 unsigned int nr_iowait_acct_cpu(int cpu)
 {
 	return rq_iowait_acct(cpu_rq(cpu));
 }
 
+/*
+ * Consumers of this interface like the cpuidle menu governor are using
+ * nonsensical data. Preferring shallow idle state selection for a CPU that
+ * has IO-wait which might not even end up being selected for the task again
+ * when it does become runnable.
+ */
+
 unsigned nr_iowait_cpu(int cpu)
 {
 	return rq_iowait(cpu_rq(cpu));
-- 
2.34.1


