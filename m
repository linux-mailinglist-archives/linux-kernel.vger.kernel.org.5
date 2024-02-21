Return-Path: <linux-kernel+bounces-73977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F2185CE44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F403A1C22ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48228382;
	Wed, 21 Feb 2024 02:46:21 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484E79FD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483581; cv=none; b=lMn7k4Y5Xfx3qi85WgsA0yPGvszi93a+gNWXRNKpkvZMm/7lYSGxi/1p7bJzkG5uaXVXnPdQ3oNf1iOeXPeJO2TjaiNOewR/e61to9++Ds+Qvom+yRTMf/+T7JY+/Du02/BOJ5YtpkP3jQ8t07/m4qqSWjL61QJ2L/O/0on/nyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483581; c=relaxed/simple;
	bh=jISVa8nDibYniU2mn5Vk9qwOWLjCxCu8I+7+17XxWTo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o09mZDqP7FWeG04byV5yckgV7PX9OOY7UoJsn/0aYO4pYxRpJCXob8PgPQLkEXPio01OvggWoN4cvVWtvgOtYa/rZli7NIv6zMt5UfY0BucGcadc33/b8wgOr33RZeNetuiy40OtMtuMC2pePzc7Rix0NVqrLJHUDftceXccrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp85t1708483327t8z2ke3f
X-QQ-Originating-IP: fdqu/5R07Br02wHR3lffm800aYSI2+LHQlDoDxoz+6o=
Received: from [10.7.13.112] ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 Feb 2024 10:42:05 +0800 (CST)
X-QQ-SSF: 01400000000000D0I000000A0000000
X-QQ-FEAT: +ynUkgUhZJllNiNwmDGrjsnkv2+iV9NBYRHn0nBq4veJ2AT0m/jH+gIocW2Sn
	7SUvHsI+L8kZDnWQ1GlHpyPQSVrn49/D5kVnfkbB+GSRv6wHh56YtdPOqnKaNkqH+GvDYFh
	aypP4RQ8G3dsWLLGEyozJtj+lvAlYppnQEymrpy8jRxgtMFRXvX37cqW6W9PiH18wIUTDCf
	djCk9obywWqBUYPXENYHieAVzEdC0rFp09BtPhwu7JO/QqrDAsYoQC+SnqSEmLfqiTZdLPt
	t6lqFo62hlROiLNB4M5nHbMitk0YJVXRKwB9RNXqk/2AiInDMmLUnL1nXOWPpkaOIbNp7Od
	KRg4ESsN3BXc7zbuzO8EuF4Sc7SfCyK3em1g8GLvrhyY5tEU3LaHLbP02eU7tIUuiaAdcVE
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10674637185529186905
Subject: Re: [PATCH] locking/osq_lock: Optimize osq_lock performance using
 per-NUMA
To: Waiman Long <longman@redhat.com>, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, boqun.feng@gmail.com, David.Laight@ACULAB.COM
Cc: linux-kernel@vger.kernel.org
References: <20240220073058.6435-1-guohui@uniontech.com>
 <03c1eb2e-4eae-49be-94cb-b90894cc00a9@redhat.com>
From: Guo Hui <guohui@uniontech.com>
Message-ID: <1EEDB3CB3E97FFDE+e8c7acce-ec6b-f2b7-9c2d-0d1b471a671f@uniontech.com>
Date: Wed, 21 Feb 2024 10:42:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <03c1eb2e-4eae-49be-94cb-b90894cc00a9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

On 2/21/24 2:16 AM, Waiman Long wrote:

>
> On 2/20/24 02:30, Guo Hui wrote:
>> After extensive testing of osq_lock,
>> we found that the performance of osq_lock is closely related to
>> the distance between NUMA nodes.The greater the distance
>> between NUMA nodes,the more serious the performance degradation of
>> osq_lock.When a group of processes that need to compete for
>> the same lock are on the same NUMA node,the performance of osq_lock
>> is the best.when the group of processes is distributed on
>> different NUMA nodes,as the distance between NUMA nodes increases,
>> the performance of osq_lock becomes worse.
>>
>> This patch uses the following solutions to improve performance:
>> Divide the osq_lock linked list according to NUMA nodes.
>> Each NUMA node corresponds to an osq linked list.
>> Each CPU is added to the linked list corresponding to
>> its respective NUMA node.When the last CPU of
>> the NUMA node releases osq_lock,osq_lock is passed to
>> the next NUMA node.
>>
>> As shown in the figure below, the last osq_node1 on NUMA0 passes the 
>> lock
>> to the first node (osq_node3) of the next NUMA1 node.
>>
>> -----------------------------------------------------------
>> |            NUMA0           |            NUMA1           |
>> |----------------------------|----------------------------|
>> |  osq_node0 ---> osq_node1 -|-> osq_node3 ---> osq_node4 |
>> -----------------------------|-----------------------------
>>
>> Set an atomic type global variable osq_lock_node to
>> record the NUMA node number that can currently obtain
>> the osq_lock lock.When the osq_lock_node value is
>> a certain node number,the CPU on the node obtains
>> the osq_lock lock in turn,and the CPUs on
>> other NUMA nodes poll wait.
>>
>> This solution greatly reduces the performance degradation caused
>> by communication between CPUs on different NUMA nodes.
>>
>> The effect on the 96-core 4-NUMA ARM64 platform is as follows:
>> System Benchmarks Partial Index       with patch  without patch promote
>> File Copy 1024 bufsize 2000 maxblocks   2060.8      980.3 +110.22%
>> File Copy 256 bufsize 500 maxblocks     1346.5      601.9 +123.71%
>> File Copy 4096 bufsize 8000 maxblocks   4229.9      2216.1 +90.87%
>>
>> The effect on the 128-core 8-NUMA X86_64 platform is as follows:
>> System Benchmarks Partial Index       with patch  without patch promote
>> File Copy 1024 bufsize 2000 maxblocks   841.1       553.7 +51.91%
>> File Copy 256 bufsize 500 maxblocks     517.4       339.8 +52.27%
>> File Copy 4096 bufsize 8000 maxblocks   2058.4      1392.8 +47.79%
> That is similar in idea to the numa-aware qspinlock patch series.
>> Signed-off-by: Guo Hui <guohui@uniontech.com>
>> ---
>>   include/linux/osq_lock.h  | 20 +++++++++++--
>>   kernel/locking/osq_lock.c | 60 +++++++++++++++++++++++++++++++++------
>>   2 files changed, 69 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
>> index ea8fb31379e3..c016c1cf5e8b 100644
>> --- a/include/linux/osq_lock.h
>> +++ b/include/linux/osq_lock.h
>> @@ -2,6 +2,8 @@
>>   #ifndef __LINUX_OSQ_LOCK_H
>>   #define __LINUX_OSQ_LOCK_H
>>   +#include <linux/nodemask.h>
>> +
>>   /*
>>    * An MCS like lock especially tailored for optimistic spinning for 
>> sleeping
>>    * lock implementations (mutex, rwsem, etc).
>> @@ -11,8 +13,9 @@ struct optimistic_spin_queue {
>>       /*
>>        * Stores an encoded value of the CPU # of the tail node in the 
>> queue.
>>        * If the queue is empty, then it's set to OSQ_UNLOCKED_VAL.
>> +     * The actual number of NUMA nodes is generally not greater than 
>> 32.
>>        */
>> -    atomic_t tail;
>> +    atomic_t tail[32];
>
> That is a no-go. You are increasing the size of a mutex/rwsem by 128 
> bytes. If you want to enable this numa-awareness, you have to do it in 
> a way without increasing the size of optimistic_spin_queue. My 
> suggestion is to queue optimistic_spin_node in a numa-aware way in 
> osq_lock.c without touching optimistic_spin_queue.
>
> Cheers,
> Longman
>
>
>
Thank you for your suggestion, I will make a better solution according 
to your suggestion.



