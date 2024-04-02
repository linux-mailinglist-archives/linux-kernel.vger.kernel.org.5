Return-Path: <linux-kernel+bounces-127624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91318894E88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43C51C22791
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2BD58229;
	Tue,  2 Apr 2024 09:21:22 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B515820C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049682; cv=none; b=pS0bIXzR1boyD1tBDL3FMQr9AYEF6hLjMM2RUqO4M7lJimimRq6oWqNpsXp/kRexJNj+GcSq8BEpvf2kK3HEYm3VKK2B56OOn1rrYtHy8HNRhJ4F9HNXACAFTKW7hLfXqZ8LC/2kAuWRa26VRRFH5yrg24Tx0c2Q0jPxbFlllHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049682; c=relaxed/simple;
	bh=y2QAjuzhl0wYCv7YC1D+Cg98zpUgHm0vHk75GViP87E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLJZrwwZ5Fgiy/5sry4jtRiYhI35Dz6FqPofy1/x7THm1on1YbbvoWuwzJm37i54HdGfTguW/KKoPo4HzmOdTPX3k1Y/byNKlG88K8T+tZsS6aQedtsYA5hY9OvRNNwMfyudGE54czjbObA5YcvOCX94P8LpAlCj86ss7TADd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDC2F20002;
	Tue,  2 Apr 2024 09:21:15 +0000 (UTC)
Message-ID: <7312eb06-c9dd-4a0e-98bc-ea4e8ace7b10@ghiti.fr>
Date: Tue, 2 Apr 2024 11:21:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH] riscv: process: Fix kernel gp leakage
Content-Language: en-US
To: Stefan O'Rear <sorear@fastmail.com>, yunhui cui <cuiyunhui@bytedance.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org
References: <20240327061258.2370291-1-sorear@fastmail.com>
 <CAEEQ3w=yNEktgUucmKuUvqfwDYYztVX+jofi5Q7hG-yQWcLbTA@mail.gmail.com>
 <234c458c-15f1-423f-a2fd-0abfc6232c66@app.fastmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <234c458c-15f1-423f-a2fd-0abfc6232c66@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Stefan,

On 27/03/2024 17:53, Stefan O'Rear wrote:
> On Wed, Mar 27, 2024, at 4:43 AM, yunhui cui wrote:
>> Hi Stefan,
>>
>> On Wed, Mar 27, 2024 at 2:14 PM Stefan O'Rear <sorear@fastmail.com> wrote:
>>> childregs represents the registers which are active for the new thread
>>> in user context. For a kernel thread, childregs->gp is never used since
>>> the kernel gp is not touched by switch_to. For a user mode helper, the
>>> gp value can be observed in user space after execve or possibly by other
>>> means.
>>>
>>> Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
>>> Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
>>> ---
>>>   arch/riscv/kernel/process.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>>> index 92922dbd5b5c..51042f48da17 100644
>>> --- a/arch/riscv/kernel/process.c
>>> +++ b/arch/riscv/kernel/process.c
>>> @@ -27,8 +27,6 @@
>>>   #include <asm/vector.h>
>>>   #include <asm/cpufeature.h>
>>>
>>> -register unsigned long gp_in_global __asm__("gp");
>>> -
>>>   #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
>>>   #include <linux/stackprotector.h>
>>>   unsigned long __stack_chk_guard __read_mostly;
>>> @@ -207,7 +205,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>>          if (unlikely(args->fn)) {
>>>                  /* Kernel thread */
>>>                  memset(childregs, 0, sizeof(struct pt_regs));
>>> -               childregs->gp = gp_in_global;
>>>                  /* Supervisor/Machine, irqs on: */
>>>                  childregs->status = SR_PP | SR_PIE;
>>>
>>> --
>>> 2.40.1
>>>
>>>
>> Can you help express in more detail what the problem was before fixing it?
> It's a KASLR bypass, since gp_in_global is the address of the kernel symbol
> __global_pointer$.
>
> The /* Kernel thread */ comment is somewhat inaccurate in that it is also used
> for user_mode_helper threads, which exec a user process, e.g. /sbin/init or
> when /proc/sys/kernel/core_pattern is a pipe. Such threads do not have
> PF_KTHREAD set and are valid targets for ptrace etc. even before they exec.
>
> childregs is the *user* context during syscall execution and it is observable
> from userspace in at least five ways:
>
> 1. kernel_execve does not currently clear integer registers, so the starting
>     register state for PID 1 and other user processes started by the kernel has
>     sp = user stack, gp = kernel __global_pointer$, all other integer registers
>     zeroed by the memset in the patch comment.


So as I  did not this know this path really well, I played a bit and I 
can confirm that usermode processes reach userspace with the gp = kernel:

Thread 1 hit Breakpoint 12, 0x00007fff82487fc4 in ?? ()
1: x/i $pc
=> 0x7fff82487fc4:    mv    a0,sp
3: /x $gp = 0xffffffff817fee50


>
>     This is a bug in its own right, but I'm unwilling to bet that it is the only
>     way to exploit the issue addressed by this patch.
>
> 2. ptrace(PTRACE_GETREGSET): you can PTRACE_ATTACH to a user_mode_helper thread
>     before it execs, but ptrace requires SIGSTOP to be delivered which can only
>     happen at user/kernel boundaries.
>
> 3. /proc/*/task/*/syscall: this is perfectly happy to read pt_regs for
>     user_mode_helpers before the exec completes, but gp is not one of the
>     registers it returns.
>
> 4. PERF_SAMPLE_REGS_USER: LOCKDOWN_PERF normally prevents access to kernel
>     addresses via PERF_SAMPLE_REGS_INTR, but due to this bug kernel addresses
>     are also exposed via PERF_SAMPLE_REGS_USER which is permitted under
>     LOCKDOWN_PERF. I have not attempted to write exploit code.
>
> 5. Much of the tracing infrastructure allows access to user registers. I have
>     not attempted to determine which forms of tracing allow access to user
>     registers without already allowing access to kernel registers.
>
> Does this help? How much of this should be in the commit message?


I'd put them all, but up to you, at least the first usecase that I was 
able to reproduce should be added to the commit log.

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

And this should go to -fixes.

Thanks,

Alex


>
> -s
>
>> Thanks,
>> Yunhui
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

