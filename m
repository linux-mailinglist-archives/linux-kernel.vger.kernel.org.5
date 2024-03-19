Return-Path: <linux-kernel+bounces-107067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC41E87F723
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36D0282D20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7494D4EB5D;
	Tue, 19 Mar 2024 06:12:03 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C34595A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828722; cv=none; b=LWJVnXS2C/a1mx3DYgdpUjkTSS+PeOscCS816a04KpmnBJDydBi17mjpL9rr+AhRjKRsiRJwqQfoJxqSLORoZSbke1Vb5x42oAdwBUNEftzTHrQ+xzb4zSFgm+uhP1z/TnxYRoARERvm4DcRwq+zWAhCh2Sh1pQuIbgVu/V4N7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828722; c=relaxed/simple;
	bh=ej4GoyMUOm8kuliqD2hJhK0UieQieA3qYqUApllZfPE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l1OB2koawhMWu6aKCKFg7TGRNbnUqtEnt65X8vglJ+QuZPj/pLRabedg2El2wSyN6YTWdV59XJqDwzxky3Pr8PUENm2WedA1SRXHRLFA0Dmlbl5y93rxjEy6/34gio7NLGsZ6weS7hDCDgBQZ7NPCdNjZLA/2kJ5F1U0bIrFeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp66t1710828636tkw3c9lw
X-QQ-Originating-IP: TW1j/1Jtj1awmEFT7V7GvYjKa+iGctcU3o6vIry6lcs=
Received: from [10.7.13.112] ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Mar 2024 14:10:34 +0800 (CST)
X-QQ-SSF: 01400000000000D0I000000A0000000
X-QQ-FEAT: k0mQ4ihyJQM9DPXBAbmHiEGdalJh5L6ipOFIy5ckVZWImVnP9XitosrTlOjXX
	TIyZSNFkS0MOk20KzGhkIZ/xk9nUX7M50CKf59zpOAkOnBpeViF+bbPhbXmdmXf4UFOGpAK
	5j1prOfQzApyu+s+/chXmldwMmjy2/XoTcFQDozrp77Ci025ZVaHgs8xHl9Ol0HCXREgSqW
	wp4rI2mjGmLUEP4dwkTm8CxN87xRd8kbz6/yu0D3C2bAP5t58vTdRE8HVxZn7BVcFp47YIY
	CqtaNDbn1kaqOvbM23Uh/bX7gIVPxpfzXhLWI8gUIHDgElgn4OmRYIxhdg3eiFfN3QBZ4Wu
	R3LUFmkSn9LswZpdiWemkb+2eZ1nNeydAU3PL7kd2358f0xmEvyo4O1+/JO/sbvCB1l0kRm
	vzAOqwKv/WI=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13073446502722347930
Subject: Re: [PATCH v2] locking/osq_lock: Optimize osq_lock performance using
 per-NUMA
To: Waiman Long <longman@redhat.com>, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, boqun.feng@gmail.com, David.Laight@ACULAB.COM
Cc: linux-kernel@vger.kernel.org
References: <20240318055023.25546-1-guohui@uniontech.com>
 <d63dfa33-f194-4368-ab9a-3be27c4cd893@redhat.com>
From: Guo Hui <guohui@uniontech.com>
Message-ID: <E5B453826796EEB9+d70dde03-2549-2e37-2db6-39eac90457f9@uniontech.com>
Date: Tue, 19 Mar 2024 14:10:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d63dfa33-f194-4368-ab9a-3be27c4cd893@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

On 3/19/24 9:59 AM, Waiman Long wrote:

> On 3/18/24 01:50, Guo Hui wrote:
>> Changes in version v1:
>> The queue is divided according to NUMA nodes,
>> but the tail of each NUMA node is still stored
>> in the structure optimistic_spin_queue.
>>
>> Changes in version v2:
>> 1,On the basis of v1,
>> the tail of each NUMA node is separated from
>> the structure optimistic_spin_queue,
>> and a separate memory space is allocated.
>> This memory space is a pre-statically allocated
>> fixed-size array osnq_queue[1024], array length is 1024.
>> Each array element of osnq_queue is an array of atomic_t type.
>> The length of this atomic_t type array is MAX_NUMNODES.
>> The total memory size of statically allocated arrays is as follows:
>>
>>       4 * MAX_NUMNODES * 1024
>>
>> When MAX_NUMNODES is 64, the memory is 256K,
>> and when it is 1024, the memory is 4M.
>>
>> The relationship between the statically allocated array osnq_queue
>> and the structure optimistic_spin_queue is to use the hash value of
>> the optimistic_spin_queue structure type pointer as the index of
>> the array osnq_queue, and obtain the array element
>> corresponding to osq_lock from osnq_queue.
>> This array element stores the tail value of
>> each NUMA node corresponding to the osq_lock lock.
>>
>> The form of the osnq_queue array is as follows:
>>
>>   ----------------------------------------------------------
>>   |                  |                                     |
>>   |                  |             MAX_NUMNODES            |
>>   |                  |                                     |
>>   |                  |-------------------------------------|
>>   |                  |               |               |     |
>>   |                  | atomic_t tail | atomic_t tail | ... |
>>   |                  |               |               |     |
>>   |                  |-------------------------------------|
>>   |                  |               |               |     |
>>   |                  | atomic_t tail | atomic_t tail | ... |
>>   |                  |               |               |     |
>>   |                  |-------------------------------------|
>>   |                  |               |               |     |
>>   | osnq_queue[1024] | atomic_t tail | atomic_t tail | ... |
>>   |                  |               |               |     |
>>   |                  |-------------------------------------|
>>   | The hash value ->|               |               |     |
>>   | of osq_lock is   | atomic_t tail | atomic_t tail | ... |
>>   | the index        |               |               |     |
>>   |                  |-------------------------------------|
>>   |                  |               |               |     |
>>   |                  |    ... ...    |    ... ...    | ... |
>>   |                  |               |               |     |
>>   |------------------|-------------------------------------|
>>
>> There is a very small probability that different osq_locks
>> with the same hash value will run concurrently on different CPUs.
>> After extensive testing, this probability is no greater than 0.01%.
>> This situation is also a normal situation.
>> In this case, two different osq_locks will share the same
>> osnq_queue array element,these two different osq_locks
>> share the same NUMA linked list.Put different CPU nodes waiting
>> for different osq_locks into the same NUMA linked list,
>> which means that CPU nodes with different osq_locks
>> share the same lock of the same NUMA queue.
>> This is essentially the same method as using zippers
>> to resolve hash collisions.
>>
>> Make an extreme case and set the above osnq_queue array
>> to an array element.Then all osq_locks in the kernel
>> will share the same queue on different NUMA nodes.
>> After verification, the kernel can also run normally.
>> However, the performance of some test cases will deteriorate.
>> This patch solution greatly reduces the probability of
>> shared queues to less than 0.01%,greatly improving
>> the kernel osq_lock lock performance.
>
> I don't like the idea of using a hash table and having hash collision. 
> Is it possible to adopt the numa-aware qspinlock's idea of having a 
> primary queue of the same numa node and a secondary queue for all the 
> other nodes? I know it will be more complex because of the need to 
> back out when rescheduling is needed.

Ok, I'll try the numa-aware qspinlock idea as much as possible, have the 
primary queue for the same numa node and the secondary queue for all 
other nodes.

As you said, the idea of numa-aware qspinlock is very complex for osq_lock.

>
> Also I will prefer to make this numa-awareness optional so that it is 
> determined at boot time if the numa-aware version or the original 
> version is being used. At the beginning, the numa-aware osq_lock will 
> be default to off unless it is forced on by a command line or kconfig 
> option. We want to minimize risk due to the introduction of bug in the 
> new code.

OK, I'll add this option.

>
>>
>> 2. Achieve fairness in transferring locks between nodes
>> and prevent the same NUMA node from holding locks for a long time.
>> This method borrows from the qspinlock numa-aware scheme.
>>
>> The effect on the 96-core 4-NUMA ARM64 platform is as follows:
>> System Benchmarks Partial Index       with patch  without patch promote
>> Execl Throughput                         7255.8 5632.8      +28.81%
>> File Copy 1024 bufsize 2000 maxblocks    1817.2 910.9       +99.50%
>> File Copy 256 bufsize 500 maxblocks      1168.1 570.4       +104.79%
>> File Copy 4096 bufsize 8000 maxblocks    3321.1 2088.7      +59.00%
>>
>> The effect on the 128-core 8-NUMA X86_64 platform is as follows:
>> System Benchmarks Partial Index       with patch  without patch promote
>> Execl Throughput                         3947 3533.6      +11.70%
>> File Copy 1024 bufsize 2000 maxblocks    819.1 553         +48.12%
>> File Copy 256 bufsize 500 maxblocks      508.5 330.2       +54.00%
>> File Copy 4096 bufsize 8000 maxblocks    1982.2 1377.1      +43.94%
>>
>> Signed-off-by: Guo Hui <guohui@uniontech.com>
>> ---
>>   include/linux/osq_lock.h  |  29 ++++++++--
>>   kernel/locking/osq_lock.c | 111 ++++++++++++++++++++++++++++++++++----
>>   2 files changed, 126 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
>> index ea8fb31379e3..3433f13276b8 100644
>> --- a/include/linux/osq_lock.h
>> +++ b/include/linux/osq_lock.h
>> @@ -2,6 +2,13 @@
>>   #ifndef __LINUX_OSQ_LOCK_H
>>   #define __LINUX_OSQ_LOCK_H
>>   +#include <linux/nodemask.h>
>> +#include <linux/hash.h>
>> +
>> +struct optimistic_spin_numa_queue {
>> +    atomic_t tail[MAX_NUMNODES]; /* Store the tail of each NUMA 
>> queue */
>> +};
>> +
>>   /*
>>    * An MCS like lock especially tailored for optimistic spinning for 
>> sleeping
>>    * lock implementations (mutex, rwsem, etc).
>> @@ -9,12 +16,16 @@
>>     struct optimistic_spin_queue {
>>       /*
>> -     * Stores an encoded value of the CPU # of the tail node in the 
>> queue.
>> -     * If the queue is empty, then it's set to OSQ_UNLOCKED_VAL.
>> +     * Stores the hash value of the structure type pointer.
>>        */
>>       atomic_t tail;
>>   };
>>   +#define HASH_BITS_LEN    10
>> +
>> +/* this value is 2^@HASH_BITS_LEN */
>> +#define NUMA_QUEUE_SIZE  1024
>> +
>>   #define OSQ_UNLOCKED_VAL (0)
>>     /* Init macro and function. */
>> @@ -22,15 +33,25 @@ struct optimistic_spin_queue {
>>     static inline void osq_lock_init(struct optimistic_spin_queue *lock)
>>   {
>> -    atomic_set(&lock->tail, OSQ_UNLOCKED_VAL);
>> +    atomic_set(&lock->tail, hash_ptr(lock, HASH_BITS_LEN));
>>   }
>>     extern bool osq_lock(struct optimistic_spin_queue *lock);
>>   extern void osq_unlock(struct optimistic_spin_queue *lock);
>>   +extern struct optimistic_spin_numa_queue osnq_queue[NUMA_QUEUE_SIZE];
>> +
>>   static inline bool osq_is_locked(struct optimistic_spin_queue *lock)
>>   {
>> -    return atomic_read(&lock->tail) != OSQ_UNLOCKED_VAL;
>> +    int node;
>> +    atomic_t *numa_tail = osnq_queue[atomic_read(&lock->tail)].tail;
>> +
>> +    for_each_online_node(node) {
>> +        if (atomic_read(&numa_tail[node]) != OSQ_UNLOCKED_VAL)
>> +            return true;
>> +    }
>> +
>> +    return false;
>>   }
> That greatly increase of cost of calling osq_is_locked().
>>     #endif
>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>> index 75a6f6133866..bea6a2784b5e 100644
>> --- a/kernel/locking/osq_lock.c
>> +++ b/kernel/locking/osq_lock.c
>> @@ -2,6 +2,8 @@
>>   #include <linux/percpu.h>
>>   #include <linux/sched.h>
>>   #include <linux/osq_lock.h>
>> +#include <linux/topology.h>
>> +#include <linux/random.h>
>>     /*
>>    * An MCS like lock especially tailored for optimistic spinning for 
>> sleeping
>> @@ -14,12 +16,48 @@
>>     struct optimistic_spin_node {
>>       struct optimistic_spin_node *next, *prev;optimistic_spin_queue
>> +    atomic_t *tail;
> Don't use the name "tail" here as it is also used in 
> optimistic_spin_queue. It is hard to tell which tail is which when 
> reading the code. Make them unique.

I'll change the name.

>>       int locked; /* 1 if lock acquired */
>>       int cpu; /* encoded CPU # + 1 value */
>> +    int numa_node;
>>   };
>>     static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, 
>> osq_node);
>>   +/* Use the hash value of the structure optimistic_spin_node type 
>> pointer as the index. */
>> +struct optimistic_spin_numa_queue osnq_queue[NUMA_QUEUE_SIZE];
>> +
>> +#define INVALID_NUMA_NODE (-1)
>> +
>> +/* Per-CPU pseudo-random number seed */
>> +static DEFINE_PER_CPU(u32, seed);
>> +
>> +/*
>> + * Controls the probability for intra-node lock hand-off. It can be
>> + * tuned and depend, e.g., on the number of CPUs per node. For now,
>> + * choose a value that provides reasonable long-term fairness without
>> + * sacrificing performance compared to a version that does not have any
>> + * fairness guarantees.
>> + */
>> +#define INTRA_NODE_HANDOFF_PROB_ARG (16)
>> +
>> +
>> +/*
>> + * Return false with probability 1 / 2^@num_bits.
>> + * Intuitively, the larger @num_bits the less likely false is to be 
>> returned.
>> + * @num_bits must be a number between 0 and 31.
>> + */
>> +static bool probably(unsigned int num_bits)
>> +{
>> +    u32 s;
>> +
>> +    s = this_cpu_read(seed);
>> +    s = next_pseudo_random32(s);
>> +    this_cpu_write(seed, s);
>> +
>> +    return s & ((1 << num_bits) - 1);
>> +}
>> +
>>   /*
>>    * We use the value 0 to represent "no CPU", thus the encoded value
>>    * will be the CPU number incremented by 1.
>> @@ -58,8 +96,8 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>>       int curr = encode_cpu(smp_processor_id());
>>         for (;;) {
>> -        if (atomic_read(&lock->tail) == curr &&
>> -            atomic_cmpxchg_acquire(&lock->tail, curr, old_cpu) == 
>> curr) {
>> +        if (atomic_read(&node->tail[node->numa_node]) == curr &&
>> + atomic_cmpxchg_acquire(&node->tail[node->numa_node], curr, old_cpu) 
>> == curr) {
>>               /*
>>                * We were the last queued, we moved @lock back. @prev
>>                * will now observe @lock and will complete its
>> @@ -90,6 +128,19 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>>       }
>>   }
>>   +static atomic_t osq_lock_node = ATOMIC_INIT(-1);
>> +
>> +static void osq_wait_numa_node(struct optimistic_spin_node *node)
>> +{
>> +    int  old_node;
>> +
>> +    while (!need_resched() &&
>> +        ((old_node = atomic_cmpxchg_acquire(&osq_lock_node, 
>> INVALID_NUMA_NODE,
>> +            node->numa_node)) != INVALID_NUMA_NODE) &&
>> +        (node->numa_node != old_node))
>> +        cpu_relax();
>> +}
>> +
>>   bool osq_lock(struct optimistic_spin_queue *lock)
>>   {
>>       struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
>> @@ -100,6 +151,8 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>>       node->locked = 0;
>>       node->next = NULL;
>>       node->cpu = curr;
>> +    node->numa_node = cpu_to_node(smp_processor_id());
>> +    node->tail = osnq_queue[atomic_read(&lock->tail)].tail;
>>         /*optimistic_spin_queue
>>        * We need both ACQUIRE (pairs with corresponding RELEASE in
>> @@ -107,9 +160,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>>        * the node fields we just initialised) semantics when updating
>>        * the lock tail.
>>        */
>> -    old = atomic_xchg(&lock->tail, curr);
>> -    if (old == OSQ_UNLOCKED_VAL)
>> +    old = atomic_xchg(&node->tail[node->numa_node], curr);
>> +    if (old == OSQ_UNLOCKED_VAL) {
>> +        osq_wait_numa_node(node);
>>           return true;
>> +    }
>>         prev = decode_cpu(old);
>>       node->prev = prev;
>> @@ -144,8 +199,10 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>>        * polling, be careful.
>>        */
>>       if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
>> -                  vcpu_is_preempted(node_cpu(node->prev))))
>> +                  vcpu_is_preempted(node_cpu(node->prev)))) {
>> +        osq_wait_numa_node(node);
>>           return true;
>> +    }
>>         /* unqueue */
>>       /*
>> @@ -170,8 +227,10 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>>            * in which case we should observe @node->locked becoming
>>            * true.
>>            */
>> -        if (smp_load_acquire(&node->locked))
>> +        if (smp_load_acquire(&node->locked)) {
>> +            osq_wait_numa_node(node);
>>               return true;
>> +        }
>>             cpu_relax();
>>   @@ -207,29 +266,61 @@ bool osq_lock(struct optimistic_spin_queue 
>> *lock)
>>       return false;
>>   }
>>   +/*
>> + * Pass the lock to the next NUMA node.
>> + */
>> +static void pass_lock_numa_node(struct optimistic_spin_node *node)
>> +{
>> +    int curr_node = cpu_to_node(smp_processor_id());
>> +    int numa_node = curr_node;
>> +    int num_nodes = num_online_nodes();
>> +
>> +    do {
>> +        numa_node = (numa_node + 1) % num_nodes;
>> +        if (numa_node == curr_node) {
>> +            atomic_set(&osq_lock_node, INVALID_NUMA_NODE);
>> +            return;
>> +        }
>> +    } while (atomic_read(&node->tail[numa_node]) == OSQ_UNLOCKED_VAL);
>> +    atomic_set(&osq_lock_node, numa_node);
>> +}
>> +
>> +static inline void pass_lock_fair(struct optimistic_spin_node *node)
>> +{
>> +    if (!probably(INTRA_NODE_HANDOFF_PROB_ARG))
>> +        pass_lock_numa_node(node);
>> +}
>> +
>>   void osq_unlock(struct optimistic_spin_queue *lock)
>>   {
>>       struct optimistic_spin_node *node, *next;
>>       int curr = encode_cpu(smp_processor_id());
>>   +    node = this_cpu_ptr(&osq_node);
>> +
>>       /*
>>        * Fast path for the uncontended case.
>>        */
>> -    if (likely(atomic_cmpxchg_release(&lock->tail, curr,
>> -                      OSQ_UNLOCKED_VAL) == curr))
>> +    if (likely(atomic_cmpxchg_release(&node->tail[node->numa_node], 
>> curr,
>> +                      OSQ_UNLOCKED_VAL) == curr)) {
>> +        pass_lock_numa_node(node);
>>           return;
>> +    }
>>         /*
>>        * Second most likely case.
>>        */
>> -    node = this_cpu_ptr(&osq_node);
>>       next = xchg(&node->next, NULL);
>>       if (next) {
>>           WRITE_ONCE(next->locked, 1);
>> +        pass_lock_fair(node);
>>           return;
>>       }
>>         next = osq_wait_next(lock, node, OSQ_UNLOCKED_VAL);
>> -    if (next)
>> +    if (next) {
>>           WRITE_ONCE(next->locked, 1);
>> +        pass_lock_fair(node);
>> +    } else
>> +        pass_lock_numa_node(node);
>>   }
>
> With numa-aware qspinlock, most of the action is in the unlock code to 
> scan the queue.
Yes, it is.
>
> Cheers,
> Longman
>
>

