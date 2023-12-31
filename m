Return-Path: <linux-kernel+bounces-13626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E7A820998
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 04:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4A51F2234A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 03:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0710E2;
	Sun, 31 Dec 2023 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCvxaKgf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1BA53
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703991854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IT/n07HZ/2mOvnFD6dGSeRcaJ3NLAIa0Bqdh0XqcV1E=;
	b=MCvxaKgfqX08/BI6tRw7NOsGJkTVBOyP5Gptdb6IFmeorEegjXDXTRTinHudIBYmGSQw2m
	Yrawo1TSEMi+X1WkdREC7i4B6Cc10WbQ6RQ4xMQqZZU1HB+K3mPX3uCdVsUX4hjRKdlG/5
	6YGA/SR0wO36Q7G0FT8GuO+q/KjvBnM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-84_5THisOfOJ0RMlQRNxgQ-1; Sat,
 30 Dec 2023 22:04:12 -0500
X-MC-Unique: 84_5THisOfOJ0RMlQRNxgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEA7E2837811;
	Sun, 31 Dec 2023 03:04:11 +0000 (UTC)
Received: from [10.22.32.46] (unknown [10.22.32.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E5051121306;
	Sun, 31 Dec 2023 03:04:11 +0000 (UTC)
Message-ID: <910ac70a-5503-4594-b5b2-b2ba86bf8435@redhat.com>
Date: Sat, 30 Dec 2023 22:04:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, 'Ingo Molnar' <mingo@kernel.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'peterz@infradead.org'" <peterz@infradead.org>,
 "'mingo@redhat.com'" <mingo@redhat.com>, "'will@kernel.org'"
 <will@kernel.org>, "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 "'xinhui.pan@linux.vnet.ibm.com'" <xinhui.pan@linux.vnet.ibm.com>,
 "'virtualization@lists.linux-foundation.org'"
 <virtualization@lists.linux-foundation.org>,
 'Zeng Heng' <zengheng4@huawei.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
 <346c40b5-686f-461e-a1e3-9f255418efb2@redhat.com>
 <ZY/6YCNJ7tSCmiGo@gmail.com>
 <4b9da867c24f4ff990851050c8f61515@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <4b9da867c24f4ff990851050c8f61515@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


On 12/30/23 06:35, David Laight wrote:
> From: Ingo Molnar
>> Sent: 30 December 2023 11:09
>>
>>
>> * Waiman Long <longman@redhat.com> wrote:
>>
>>> On 12/29/23 15:57, David Laight wrote:
>>>> this_cpu_ptr() is rather more expensive than raw_cpu_read() since
>>>> the latter can use an 'offset from register' (%gs for x86-84).
>>>>
>>>> Add a 'self' field to 'struct optimistic_spin_node' that can be
>>>> read with raw_cpu_read(), initialise on first call.
>>>>
>>>> Signed-off-by: David Laight <david.laight@aculab.com>
>>>> ---
>>>>    kernel/locking/osq_lock.c | 14 +++++++++-----
>>>>    1 file changed, 9 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>>>> index 9bb3a077ba92..b60b0add0161 100644
>>>> --- a/kernel/locking/osq_lock.c
>>>> +++ b/kernel/locking/osq_lock.c
>>>> @@ -13,7 +13,7 @@
>>>>     */
>>>>    struct optimistic_spin_node {
>>>> -	struct optimistic_spin_node *next, *prev;
>>>> +	struct optimistic_spin_node *self, *next, *prev;
>>>>    	int locked; /* 1 if lock acquired */
>>>>    	int cpu; /* encoded CPU # + 1 value */
>>>>    };
>>>> @@ -93,12 +93,16 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>>>>    bool osq_lock(struct optimistic_spin_queue *lock)
>>>>    {
>>>> -	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
>>>> +	struct optimistic_spin_node *node = raw_cpu_read(osq_node.self);
>>> My gcc 11 compiler produces the following x86-64 code:
>>>
>>> 92        struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
>>>     0x0000000000000029 <+25>:    mov    %rcx,%rdx
>>>     0x000000000000002c <+28>:    add %gs:0x0(%rip),%rdx        # 0x34
>>> <osq_lock+36>
>>>
>>> Which looks pretty optimized for me. Maybe older compiler may generate more
>>> complex code. However, I do have some doubt as to the benefit of this patch
>>> at the expense of making the code a bit more complex.
> My changed code is one instruction shorter!
>    18:   65 48 8b 15 00 00 00    mov    %gs:0x0(%rip),%rdx        # 20 <osq_lock+0x20>
>    1f:   00
>                          1c: R_X86_64_PC32       .data..percpu..shared_aligned-0x4
> However is might have one less cache line miss.
>
>> GCC-11 is plenty of a look-back window in terms of compiler efficiency:
>> latest enterprise distros use GCC-11 or newer, while recent desktop
>> distros use GCC-13. Anything older won't matter, because no major
>> distribution is going to use new kernels with old compilers.
> There must be a difference in the header files as well.
> Possibly forced by the older compiler I'm using (7.5 from Ubuntu 18.04).
> But maybe based on some config option.
>
> I'm seeing this_cpu_ptr(&xxx) converted to per_cpu_ptr(&xxx, smp_processor_id())
> which necessitates an array lookup (indexed by cpu number).
> Whereas I think you are seeing it implemented as
>    raw_cpu_read(per_cpu_data_base) + offset_to(xxx)
>
> So the old code generates (after the prologue):
>    10:   49 89 fd                mov    %rdi,%r13
>    13:   49 c7 c4 00 00 00 00    mov    $0x0,%r12
>                          16: R_X86_64_32S        .data..percpu..shared_aligned
>    1a:   e8 00 00 00 00          callq  1f <osq_lock+0x1f>
>                          1b: R_X86_64_PC32       debug_smp_processor_id-0x4
>    1f:   89 c0                   mov    %eax,%eax
>    21:   48 8b 1c c5 00 00 00    mov    0x0(,%rax,8),%rbx
>    28:   00
>                          25: R_X86_64_32S        __per_cpu_offset
>    29:   e8 00 00 00 00          callq  2e <osq_lock+0x2e>
>                          2a: R_X86_64_PC32       debug_smp_processor_id-0x4
>    2e:   4c 01 e3                add    %r12,%rbx
>    31:   83 c0 01                add    $0x1,%eax
>    34:   c7 43 10 00 00 00 00    movl   $0x0,0x10(%rbx)
>    3b:   48 c7 03 00 00 00 00    movq   $0x0,(%rbx)
>    42:   89 43 14                mov    %eax,0x14(%rbx)
>    45:   41 87 45 00             xchg   %eax,0x0(%r13)
>
> I was also surprised that smp_processor_id() is a real function rather
> than an offset from %gs.

I have looked up definition of this_cpu_ptr() and gotten the following 
results:

this_cpu_ptr() => raw_cpu_ptr() => arch_raw_cpu_ptr()

/*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
  */
#define arch_raw_cpu_ptr(ptr)                           \
({                                                      \
         unsigned long tcp_ptr__;                        \
         asm ("add " __percpu_arg(1) ", %0"              \
              : "=r" (tcp_ptr__)                         \
              : "m" (this_cpu_off), "0" (ptr));          \
         (typeof(*(ptr)) __kernel __force *)tcp_ptr__;   \
})

The presence of debug_smp_processor_id in your compiled code is likely 
due to the setting of CONFIG_DEBUG_PREEMPT in your kernel config.

#ifdef CONFIG_DEBUG_PREEMPT
   extern unsigned int debug_smp_processor_id(void);
# define smp_processor_id() debug_smp_processor_id()
#else
# define smp_processor_id() __smp_processor_id()
#endif

I don't have that config entry in my kernel config and so I only get 2 
instructions for this_cpu_ptr(). We are not going to optimize the code 
specifically for CONFIG_DEBUG_PREEMPT and so this patch should be dropped.

Cheers,
Longman


