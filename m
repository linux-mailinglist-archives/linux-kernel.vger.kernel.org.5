Return-Path: <linux-kernel+bounces-13475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A62A82070D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1851C21391
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3ABB670;
	Sat, 30 Dec 2023 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgV4Cwtb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83719461
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703951859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8YGP5w/TfVq3L6L3AbJfFKhLcWdghWgoyKI0rbGjFU=;
	b=VgV4CwtbzR2XmeRJgzwuSJUHK6OAJ7vz1NDPF/LIyiNaB1xHRmZDk6lUuUOFxpEdjrRNH6
	UIXtJMe3De5cTDMSJjjX5UsVg6zc13XGkYUqT/1s9JBIlYKz5erJx6yKD/6hayGKvCRxiT
	MNLVFlqCw1GUGhyRfdsR6AwJ7HBDrsY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-a1hG0aTjNg25b3aYpFm7Eg-1; Sat,
 30 Dec 2023 10:57:30 -0500
X-MC-Unique: a1hG0aTjNg25b3aYpFm7Eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 372B53804A48;
	Sat, 30 Dec 2023 15:57:30 +0000 (UTC)
Received: from [10.22.32.90] (unknown [10.22.32.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C0601121306;
	Sat, 30 Dec 2023 15:57:29 +0000 (UTC)
Message-ID: <3b5c5cf3-1b8b-4815-8d19-2e28c9751305@redhat.com>
Date: Sat, 30 Dec 2023 10:57:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 5/5] locking/osq_lock: Optimise vcpu_is_preempted()
 check.
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'peterz@infradead.org'" <peterz@infradead.org>
Cc: "'mingo@redhat.com'" <mingo@redhat.com>,
 "'will@kernel.org'" <will@kernel.org>,
 "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 "'xinhui.pan@linux.vnet.ibm.com'" <xinhui.pan@linux.vnet.ibm.com>,
 "'virtualization@lists.linux-foundation.org'"
 <virtualization@lists.linux-foundation.org>,
 'Zeng Heng' <zengheng4@huawei.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <23cef5ac49494b9087953f529ae5df16@AcuMS.aculab.com>
 <e7cf4154-294e-40bd-a485-0b23220d4b7a@redhat.com>
In-Reply-To: <e7cf4154-294e-40bd-a485-0b23220d4b7a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 12/29/23 22:13, Waiman Long wrote:
>
> On 12/29/23 15:58, David Laight wrote:
>> The vcpu_is_preempted() test stops osq_lock() spinning if a virtual
>>    cpu is no longer running.
>> Although patched out for bare-metal the code still needs the cpu number.
>> Reading this from 'prev->cpu' is a pretty much guaranteed have a 
>> cache miss
>> when osq_unlock() is waking up the next cpu.
>>
>> Instead save 'prev->cpu' in 'node->prev_cpu' and use that value instead.
>> Update in the osq_lock() 'unqueue' path when 'node->prev' is changed.
>>
>> This is simpler than checking for 'node->prev' changing and caching
>> 'prev->cpu'.
>>
>> Signed-off-by: David Laight <david.laight@aculab.com>
>> ---
>>   kernel/locking/osq_lock.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>> index b60b0add0161..89be63627434 100644
>> --- a/kernel/locking/osq_lock.c
>> +++ b/kernel/locking/osq_lock.c
>> @@ -14,8 +14,9 @@
>>     struct optimistic_spin_node {
>>       struct optimistic_spin_node *self, *next, *prev;
>> -    int locked; /* 1 if lock acquired */
>> -    int cpu; /* encoded CPU # + 1 value */
>> +    int locked;    /* 1 if lock acquired */
>> +    int cpu;       /* encoded CPU # + 1 value */
>> +    int prev_cpu;  /* actual CPU # for vpcu_is_preempted() */
>>   };
>>     static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, 
>> osq_node);
>> @@ -29,11 +30,6 @@ static inline int encode_cpu(int cpu_nr)
>>       return cpu_nr + 1;
>>   }
>>   -static inline int node_cpu(struct optimistic_spin_node *node)
>> -{
>> -    return node->cpu - 1;
>> -}
>> -
>>   static inline struct optimistic_spin_node *decode_cpu(int 
>> encoded_cpu_val)
>>   {
>>       int cpu_nr = encoded_cpu_val - 1;
>> @@ -114,6 +110,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>>       if (old == OSQ_UNLOCKED_VAL)
>>           return true;
>>   +    node->prev_cpu = old - 1;
>>       prev = decode_cpu(old);
>>       node->prev = prev;
>>       node->locked = 0;
>> @@ -148,7 +145,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>>        * polling, be careful.
>>        */
>>       if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
>> -                  vcpu_is_preempted(node_cpu(node->prev))))
>> +                  vcpu_is_preempted(node->prev_cpu)))

On second thought, I believe it is more correct to use READ_ONCE() to 
access "node->prev_cpu" as this field is subjected to change by a 
WRITE_ONCE().

Cheers,
Longman



