Return-Path: <linux-kernel+bounces-121652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F588EBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DC2B25183
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8312EBC6;
	Wed, 27 Mar 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kwt1oSbh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACHfJROo"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C612E1D4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558446; cv=none; b=uz8beWqIs9QKzkFXN25/QC+p3lmFLBcxq/ioX8P9LfsbmXRjwsIkddxVhgUKPGH7Cg6YWKlTs7oGTiGdP79vYOfW9MeAiO9qMq0JgjDBge6q0PgT/gHTfx6NaWE5vBBCHMzp+IGAtiYBIeMfRdwEfK95dZ9/BUeTfawt3gLhSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558446; c=relaxed/simple;
	bh=1KaOzETdWBrjawPdVMUJu2lDonfyH53q76EBp/S0qaU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BI3qG9+AzQmPW0YSu1r9eWzwBVB0rj6S9nPXIoiJQYqr9CzsDoxQPYc5qeWnabS2euE6yYXlDjSCqgzDt9D2YHaqrEbUMrC1aF9awGF/FwMPDBW/tgoQN/9OKqLU9zMGv1mw+1YuY4/CrFG8BnnYc9v96ywMLg1tIM0q0cZUet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kwt1oSbh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACHfJROo; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 52AEA1380053;
	Wed, 27 Mar 2024 12:54:03 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 27 Mar 2024 12:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1711558443;
	 x=1711644843; bh=N6uU6LHUMt1sWQ3PaA2EU3jjeJj0dzgfVf7qZ8Yvtn8=; b=
	kwt1oSbh0XyRDK2SRHiZZX9JxcMz2njCjAqjsUOERU6dtcMt1Y/BLdE3r6U5kjyS
	ebntq99CYGWACVCqYLGyCIm5q0CWHBpySU2JDfw0abDKMbWSOrKnb4b8CbFgf1uF
	u90og8u5LA70tl9Kbl2o4IdkzVr+ZrCp7vywupzEbbComvdYFmXTUrzTOxk5cVLx
	g/EEUnRPEhnhmzYsGXzfxBQoZNpTn+yCuDs0JWDUY7f3ashB0tqf8tj1Oxo5mG9z
	70MlBxbZlVDwZvJAgP9SnLlqozqHTfT1eQnYBluV+rn4bXfxpCqyKGBzLAIx5ANd
	mP9l5BIhkLyJM/tyCOATpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711558443; x=
	1711644843; bh=N6uU6LHUMt1sWQ3PaA2EU3jjeJj0dzgfVf7qZ8Yvtn8=; b=A
	CHfJROo80VHzPkdFVwoBVbq5GaRdlkR7uvbF4p7h3YT6kNSwB85SZ8XP81IdBOkB
	RNUiIcdhYHzEuIVcfTT3AytLh4UtI0LYbua4LBtdTyvr1kbkpnATvaVGBQ8GzjXF
	h9QOXzKHzMJwUfwS/CynroBMiaXiEHA2ujxj9BS8Xl38O9sgU68aWV2P7bbHcOe8
	vPeS0r4x8jxP1nCwgyFSWjOwGiAZLt80H6D+SW2VSjUuw7/eOYSHGkbeefwDDAeI
	dHusrbtaKQDgfi3zzDeODwOs0YksC12s5nGqxFZe2cUCXznqoUNxkU/ugS+JYwFi
	8Pe+GCDmQg56wcZuC2oBQ==
X-ME-Sender: <xms:Kk8EZqbxOmVVGjnH7J1RSD92DupqhhUgALlvwkFecIUazl-BTqKNkw>
    <xme:Kk8EZtYjMhAMGUQaSDIuUw64QCb2Kq401hWOsWDUKkduXAWe31L3TjDge1vuf9NCR
    fyHeBVgxmwUIlS6RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfu
    thgvfhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpedtueetgeeutedujefgkeelfeeglefgudeigfffvefgledu
    gfelvefggeefheduteenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsohhrvggrrhes
    fhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Kk8EZk_eM4ara4s9MKJ4e7JB-uHOUl1RqN5zvxE1ltHB_9xrxr-2YA>
    <xmx:K08EZsoNiHWkoXTuc4M_NF1G1so5xBsJWX5hyvlt_EVCj04evjZflQ>
    <xmx:K08EZlofzWXGpR88Q6dgb4ll3ibkZcXBLtRZdh2CTjYwNLfDwHIL4Q>
    <xmx:K08EZqTRXxZsa5u0FcN6PiCWA9ek9tGo86Tsua9crCFekfTMab2Yhg>
    <xmx:K08EZmcMgJSrgAdDyK5UJWA66huL20h3aGO6aDhmTwzQrVZRWGS1DA>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D1E501700098; Wed, 27 Mar 2024 12:54:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <234c458c-15f1-423f-a2fd-0abfc6232c66@app.fastmail.com>
In-Reply-To: 
 <CAEEQ3w=yNEktgUucmKuUvqfwDYYztVX+jofi5Q7hG-yQWcLbTA@mail.gmail.com>
References: <20240327061258.2370291-1-sorear@fastmail.com>
 <CAEEQ3w=yNEktgUucmKuUvqfwDYYztVX+jofi5Q7hG-yQWcLbTA@mail.gmail.com>
Date: Wed, 27 Mar 2024 12:53:33 -0400
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "yunhui cui" <cuiyunhui@bytedance.com>
Cc: linux-riscv@lists.infradead.org,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 linux-kernel@vger.kernel.org
Subject: Re: [External] [PATCH] riscv: process: Fix kernel gp leakage
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024, at 4:43 AM, yunhui cui wrote:
> Hi Stefan,
>
> On Wed, Mar 27, 2024 at 2:14=E2=80=AFPM Stefan O'Rear <sorear@fastmail=
com> wrote:
>>
>> childregs represents the registers which are active for the new thread
>> in user context. For a kernel thread, childregs->gp is never used sin=
ce
>> the kernel gp is not touched by switch_to. For a user mode helper, the
>> gp value can be observed in user space after execve or possibly by ot=
her
>> means.
>>
>> Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
>> Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
>> ---
>>  arch/riscv/kernel/process.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>> index 92922dbd5b5c..51042f48da17 100644
>> --- a/arch/riscv/kernel/process.c
>> +++ b/arch/riscv/kernel/process.c
>> @@ -27,8 +27,6 @@
>>  #include <asm/vector.h>
>>  #include <asm/cpufeature.h>
>>
>> -register unsigned long gp_in_global __asm__("gp");
>> -
>>  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR=
_PER_TASK)
>>  #include <linux/stackprotector.h>
>>  unsigned long __stack_chk_guard __read_mostly;
>> @@ -207,7 +205,6 @@ int copy_thread(struct task_struct *p, const stru=
ct kernel_clone_args *args)
>>         if (unlikely(args->fn)) {
>>                 /* Kernel thread */
>>                 memset(childregs, 0, sizeof(struct pt_regs));
>> -               childregs->gp =3D gp_in_global;
>>                 /* Supervisor/Machine, irqs on: */
>>                 childregs->status =3D SR_PP | SR_PIE;
>>
>> --
>> 2.40.1
>>
>>
> Can you help express in more detail what the problem was before fixing=
 it?

It's a KASLR bypass, since gp_in_global is the address of the kernel sym=
bol
__global_pointer$.

The /* Kernel thread */ comment is somewhat inaccurate in that it is als=
o used
for user_mode_helper threads, which exec a user process, e.g. /sbin/init=
 or
when /proc/sys/kernel/core_pattern is a pipe. Such threads do not have
PF_KTHREAD set and are valid targets for ptrace etc. even before they ex=
ec.

childregs is the *user* context during syscall execution and it is obser=
vable
from userspace in at least five ways:

1. kernel_execve does not currently clear integer registers, so the star=
ting
   register state for PID 1 and other user processes started by the kern=
el has
   sp =3D user stack, gp =3D kernel __global_pointer$, all other integer=
 registers
   zeroed by the memset in the patch comment.

   This is a bug in its own right, but I'm unwilling to bet that it is t=
he only
   way to exploit the issue addressed by this patch.

2. ptrace(PTRACE_GETREGSET): you can PTRACE_ATTACH to a user_mode_helper=
 thread
   before it execs, but ptrace requires SIGSTOP to be delivered which ca=
n only
   happen at user/kernel boundaries.

3. /proc/*/task/*/syscall: this is perfectly happy to read pt_regs for
   user_mode_helpers before the exec completes, but gp is not one of the
   registers it returns.

4. PERF_SAMPLE_REGS_USER: LOCKDOWN_PERF normally prevents access to kern=
el
   addresses via PERF_SAMPLE_REGS_INTR, but due to this bug kernel addre=
sses
   are also exposed via PERF_SAMPLE_REGS_USER which is permitted under
   LOCKDOWN_PERF. I have not attempted to write exploit code.

5. Much of the tracing infrastructure allows access to user registers. I=
 have
   not attempted to determine which forms of tracing allow access to user
   registers without already allowing access to kernel registers.

Does this help? How much of this should be in the commit message?

-s

> Thanks,
> Yunhui
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

