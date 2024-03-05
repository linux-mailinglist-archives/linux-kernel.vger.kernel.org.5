Return-Path: <linux-kernel+bounces-92555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A215B872219
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D040C1C2383E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A12126F1E;
	Tue,  5 Mar 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vc2zJHsv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12A126F07
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650556; cv=none; b=fkMHF8tEXANOkowGks8O2esnvG85LTphZECN4jdP1XLwvdgRvt9qKKCEaL2UTzw8299ovjY12rSvvNVJrSm9F3m8d9t83TY3XTVRLwW0nEG01pO11KLSIRuebldJsN5Bi7axHrxxqJhd6N1C6KeVmcH+aY4iSAX8TLZt6jnpQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650556; c=relaxed/simple;
	bh=39gVmTrnaPcBAXFQ9fABlJJvi07E0ITx1ZYkR7ZIUZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erXvUzwnWNkz1/SIuiyVsjJ6nIVTRToh3EIlCe525pX/aodIrOoTOsowBcjZiwFlBIZCQoszNi51zmXrGy9HF+biXNJHFLLvo2Zqrd+MwQO15BBH84yaosbwdIo+oadiPYM6StZhsefDxjYmM4BVuD/ufISmtT5zI8kEpYrMBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vc2zJHsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709650554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFwR4TmyChVD0V7huvtNjWd7hm01xS8gRASdmKfqn1Y=;
	b=Vc2zJHsvX/tXkVUZNaAfmnFeYTwkV6WrsIaXVPCjs5IYarYOFFcO6DCbl7HWX84RrqyiVF
	EcoVUF+yNCJ3e2ytSYeu+vkJzpJE0jgS7UkZmyUxf9L2t5w79UvFBXATjDXVyWHltWs+lH
	GH/SWOklvSB2X0u8viJDV2A9cDa6OHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-ViIZL26vMBOPj2b2n-QZ6Q-1; Tue, 05 Mar 2024 09:55:49 -0500
X-MC-Unique: ViIZL26vMBOPj2b2n-QZ6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0623990EA91;
	Tue,  5 Mar 2024 14:55:49 +0000 (UTC)
Received: from [10.22.8.217] (unknown [10.22.8.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7A5DC17475;
	Tue,  5 Mar 2024 14:55:48 +0000 (UTC)
Message-ID: <b92644e5-529b-4403-aba7-d316262cc8ac@redhat.com>
Date: Tue, 5 Mar 2024 09:55:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/rwsem: Disable preemption while trying for
 rwsem lock
Content-Language: en-US
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Mukesh Ojha
 <quic_mojha@quicinc.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
 linux-kernel@vger.kernel.org,
 Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <1662661467-24203-1-git-send-email-quic_mojha@quicinc.com>
 <20240305110402.GA72649@darkstar.musicnaut.iki.fi>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240305110402.GA72649@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 3/5/24 06:04, Aaro Koskinen wrote:
> Hi,
>
> It seems this patch (commit 48dfb5d2560d) is missing from
> at least 5.15 stable tree.
>
> Based on quick test, it seems to fix an issue where system locks up
> easily when RT throttling is disabled, and also it applies cleanly, so
> I think it should be good to have it 5.15?

You need to cc stable as the locking maintainers are not responsible for 
merging patches to stable trees.

Cheers,
Longman

>
> A.
>
> On Thu, Sep 08, 2022 at 11:54:27PM +0530, Mukesh Ojha wrote:
>> From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
>>
>> Make the region inside the rwsem_write_trylock non preemptible.
>>
>> We observe RT task is hogging CPU when trying to acquire rwsem lock
>> which was acquired by a kworker task but before the rwsem owner was set.
>>
>> Here is the scenario:
>> 1. CFS task (affined to a particular CPU) takes rwsem lock.
>>
>> 2. CFS task gets preempted by a RT task before setting owner.
>>
>> 3. RT task (FIFO) is trying to acquire the lock, but spinning until
>> RT throttling happens for the lock as the lock was taken by CFS task.
>>
>> This patch attempts to fix the above issue by disabling preemption
>> until owner is set for the lock. While at it also fix the issues
>> at the places where rwsem_{set,clear}_owner() are called.
>>
>> This also adds lockdep annotation of preemption disable in
>> rwsem_{set,clear}_owner() on Peter Z. suggestion.
>>
>> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Changes in v2:
>>   - Remove preempt disable code in rwsem_try_write_lock_unqueued()
>>   - Addressed suggestion from Peter Z.
>>   - Modified commit text
>>   kernel/locking/rwsem.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 65f0262..4487359 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -133,14 +133,19 @@
>>    * the owner value concurrently without lock. Read from owner, however,
>>    * may not need READ_ONCE() as long as the pointer value is only used
>>    * for comparison and isn't being dereferenced.
>> + *
>> + * Both rwsem_{set,clear}_owner() functions should be in the same
>> + * preempt disable section as the atomic op that changes sem->count.
>>    */
>>   static inline void rwsem_set_owner(struct rw_semaphore *sem)
>>   {
>> +	lockdep_assert_preemption_disabled();
>>   	atomic_long_set(&sem->owner, (long)current);
>>   }
>>   
>>   static inline void rwsem_clear_owner(struct rw_semaphore *sem)
>>   {
>> +	lockdep_assert_preemption_disabled();
>>   	atomic_long_set(&sem->owner, 0);
>>   }
>>   
>> @@ -251,13 +256,16 @@ static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
>>   static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
>>   {
>>   	long tmp = RWSEM_UNLOCKED_VALUE;
>> +	bool ret = false;
>>   
>> +	preempt_disable();
>>   	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
>>   		rwsem_set_owner(sem);
>> -		return true;
>> +		ret = true;
>>   	}
>>   
>> -	return false;
>> +	preempt_enable();
>> +	return ret;
>>   }
>>   
>>   /*
>> @@ -1352,8 +1360,10 @@ static inline void __up_write(struct rw_semaphore *sem)
>>   	DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
>>   			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
>>   
>> +	preempt_disable();
>>   	rwsem_clear_owner(sem);
>>   	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
>> +	preempt_enable();
>>   	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
>>   		rwsem_wake(sem);
>>   }
>> -- 
>> 2.7.4
>>
>>


