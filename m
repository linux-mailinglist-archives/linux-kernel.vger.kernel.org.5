Return-Path: <linux-kernel+bounces-94564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9963C87417A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532AE28272E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09F14A82;
	Wed,  6 Mar 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IF22+C//"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C212E7F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709757630; cv=none; b=mwjc9LLxDx7dJEQc4e3Yw7GAC0mtbANl3c6L6rwsw2uSvaAjXoRG/g3FA+uO7ZRILuJCSAfBbFPikLf2OIzMzW5d9ybCJRpxILQK8DI1RsXjf9dslYLh0yK5pOf36sUCN0wVIZ2m/BeGDT2DMV35dCr35HdNF/pDbZGt9ppWGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709757630; c=relaxed/simple;
	bh=Xtmn5eZuoRYGUPwEZUSP+0NSl+3b5TM+JwdWgf2bntg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kOO+Lxq47byU8pSwtudden9MqU7qpYTSgwUF/Kxu+1yk9YHf1oVMVJLdMx+if5B0A+L+kp3D2T/HlSLzwKCJMAQeuH+z/D9mw0Nd/X4JGQ5Bcre6uyTeWs8VAqX6GBD41r+PgZjK/gHVpwSJ6Qau9f0sr7uomJ5MMgdzpZxaxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=IF22+C//; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 426KdmEp1568117
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 6 Mar 2024 12:39:48 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 426KdmEp1568117
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1709757590;
	bh=T+TFJC5MWmKywYtHsaL1+tz57km/tmqpnjzR2/q4Iy8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=IF22+C//PAdzoFM8/VC1KFqG86Yd4ozJyBLsozfUBX6dL48f4gjVLkL49nu+pfrmS
	 tdDItHryquTqMaCAnNDb/lfU4fdOih7nPD1rscZBjqobxd5R4klrzAuFw9bfNo5fDo
	 Ga9x/AR6CxYeyZCZkPtK4/TkBldMs5EFH9eOx1StAn5z5qFQmzZZ/4YGyTOtaniCPu
	 v7LydORJLK3MIafxsts6K+MW780pijaPNPoxCGzPhPCnAsJdNN7DEE4zLUuVEzhoYi
	 GMcpIAa3ksyd92zD2RbM7eBLLZWLLNECVhZU0XfErLpuM8uhp1GxVLHMyz8M+JHV2V
	 iYAXCLEh7Kwfg==
Date: Wed, 06 Mar 2024 12:39:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, arnd@arndb.de, andrew.cooper3@citrix.com,
        brgerst@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/1=5D_x86/fred=3A_Fix_init=5Ft?= =?US-ASCII?Q?ask_thread_stack_pointer_initialization?=
User-Agent: K-9 Mail for Android
In-Reply-To: <f982f5ad-36be-4173-a15b-b898252c103c@zytor.com>
References: <20240304083333.449322-1-xin@zytor.com> <f982f5ad-36be-4173-a15b-b898252c103c@zytor.com>
Message-ID: <82259B6F-2F57-4099-869D-84891D996664@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 6, 2024 10:28:25 AM PST, Xin Li <xin@zytor=2Ecom> wrote:
>On 3/4/2024 12:33 AM, Xin Li (Intel) wrote:
>> As TOP_OF_KERNEL_STACK_PADDING is defined as 0 on x86_64, no one notice=
d
>> it's missing in the calculation of the =2Esp field in INIT_THREAD until=
 it
>> is defined to 16 with CONFIG_X86_FRED=3Dy=2E
>>=20
>> Subtract TOP_OF_KERNEL_STACK_PADDING from the =2Esp field of INIT_THREA=
D=2E
>>=20
>> Fixes: 65c9cc9e2c14 ("x86/fred: Reserve space for the FRED stack frame"=
)
>> Fixes: 3adee777ad0d ("x86/smpboot: Remove initial_stack on 64-bit")
>> Reported-by: kernel test robot <oliver=2Esang@intel=2Ecom>
>> Closes: https://lore=2Ekernel=2Eorg/oe-lkp/202402262159=2E183c2a37-lkp@=
intel=2Ecom
>> Signed-off-by: Xin Li (Intel) <xin@zytor=2Ecom>
>> ---
>
>Should this fix, if it looks good, be included for the coming merge
>window?
>
>Thanks!
>    Xin
>
>>=20
>> Change Since v1:
>> * Apply offset TOP_OF_KERNEL_STACK_PADDING to all uses of __end_init_ta=
sk
>>    (Brian Gerst)=2E
>> ---
>>   arch/x86/include/asm/processor=2Eh | 6 ++++--
>>   arch/x86/kernel/head_64=2ES        | 3 ++-
>>   arch/x86/xen/xen-head=2ES          | 2 +-
>>   3 files changed, 7 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/processor=2Eh b/arch/x86/include/asm/=
processor=2Eh
>> index 26620d7642a9=2E=2E17fe81998ce4 100644
>> --- a/arch/x86/include/asm/processor=2Eh
>> +++ b/arch/x86/include/asm/processor=2Eh
>> @@ -664,8 +664,10 @@ static __always_inline void prefetchw(const void *=
x)
>>   #else
>>   extern unsigned long __end_init_task[];
>>   -#define INIT_THREAD {							    \
>> -	=2Esp	=3D (unsigned long)&__end_init_task - sizeof(struct pt_regs), \
>> +#define INIT_THREAD {							\
>> +	=2Esp	=3D (unsigned long)&__end_init_task -			\
>> +		  TOP_OF_KERNEL_STACK_PADDING -				\
>> +		  sizeof(struct pt_regs),				\
>>   }
>>     extern unsigned long KSTK_ESP(struct task_struct *task);
>> diff --git a/arch/x86/kernel/head_64=2ES b/arch/x86/kernel/head_64=2ES
>> index d4918d03efb4=2E=2Ec38e43589046 100644
>> --- a/arch/x86/kernel/head_64=2ES
>> +++ b/arch/x86/kernel/head_64=2ES
>> @@ -26,6 +26,7 @@
>>   #include <asm/apicdef=2Eh>
>>   #include <asm/fixmap=2Eh>
>>   #include <asm/smp=2Eh>
>> +#include <asm/thread_info=2Eh>
>>     /*
>>    * We are not able to switch in one step to the final KERNEL ADDRESS =
SPACE
>> @@ -66,7 +67,7 @@ SYM_CODE_START_NOALIGN(startup_64)
>>   	mov	%rsi, %r15
>>     	/* Set up the stack for verify_cpu() */
>> -	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
>> +	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%r=
ip), %rsp
>>     	leaq	_text(%rip), %rdi
>>   diff --git a/arch/x86/xen/xen-head=2ES b/arch/x86/xen/xen-head=2ES
>> index a0ea285878db=2E=2E04101b984f24 100644
>> --- a/arch/x86/xen/xen-head=2ES
>> +++ b/arch/x86/xen/xen-head=2ES
>> @@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
>>   	ANNOTATE_NOENDBR
>>   	cld
>>   -	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
>> +	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%r=
ip), %rsp
>>     	/* Set up %gs=2E
>>   	 *
>>=20
>> base-commit: e13841907b8fda0ae0ce1ec03684665f578416a8
>

Absolutely=2E

