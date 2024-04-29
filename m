Return-Path: <linux-kernel+bounces-162888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925028B61BA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62191C2189E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FBA13AD22;
	Mon, 29 Apr 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="d7OkmbtW"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121AA13AA45
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417843; cv=none; b=doHtOF1fg1JnsQ1B7EBZ62g3FBbbKyj7VyNR3VAef2zwQXuHbSCEz7lInzBjlk16ZesLa2Kkp3j6VPSByyQZODgPz2P22BfBv0L+CKqbJRzAVCK73uFGTcpOKXqn+ZT0ZaYP9HY3D13g+3HoCrCXlXL9F8ruqIi1hc+lkuBCqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417843; c=relaxed/simple;
	bh=YAT1esnGQFxlBOBg2MJkgKGoRoHJC6inoN61Uetw544=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eFeuW0YyVMexcChTWCrSniff/dozqGJQowowoKpeQRRkyRucwRoBC/OBMQb8oMaiWHFhOq4f4391YYw/eDwjqqFusu48dGwXW6osmLKKeK8sK2OZ72IT3Oe/KRDZKuXlnKXHpDgNjuKDQJzkpbH3hemqxofsXN6lvbOh5p8zWLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=d7OkmbtW; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43TJA7nP467894
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Apr 2024 12:10:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43TJA7nP467894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1714417808;
	bh=0Qr2TuS4+t5kKZBgsNQn7deRV1PrUlg46GbHzRW8Rw8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=d7OkmbtWo90bCAysnl25EJnml4KhN0qnj7hHlsttVZeHAw5KZHfygrkVfRYvD+pcd
	 iCjO+l1+bsbBEOs4bLmPlDm5lpFw7C360Jt16ZO0/1cWtvdvrVQRgbXoGaHs+Zzlyp
	 7opK/ZjhkdAYpMRxIWggcJ53Eb9JMqLAHQvUinTK5v8hAHE4C/HvdNhuOi4VVEBH/W
	 7fPqSqxdHHwXStFHy66a2YhukwZG6uyu7dA45OUiFQ2t1eqfIAuBJYskwQ8GrWd0Kk
	 69DCHXV0lnZIXz4FUd/e3LwrFQqq3ligrm43UkDk86nmsGlHW5qB0porQJ73LxbUNx
	 pBFlpY0GsiKww==
Date: Mon, 29 Apr 2024 12:10:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Kees Cook <keescook@chromium.org>
CC: Xin Li <xin@zytor.com>, Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86: dynamic pt_regs pointer and kernel stack randomization
User-Agent: K-9 Mail for Android
In-Reply-To: <202404290859.99763AA1@keescook>
References: <a793c733-267d-4930-8ee2-0fc0f24c3538@zytor.com> <202404290859.99763AA1@keescook>
Message-ID: <4994087F-1CB6-40ED-BA6D-B0545AD754DD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 29, 2024 9:09:02 AM PDT, Kees Cook <keescook@chromium=2Eorg> wrote=
:
>On Sun, Apr 28, 2024 at 03:28:44PM -0700, H=2E Peter Anvin wrote:
>> So the issue of having an explicit pointer to the user space pt_regs
>> structure has come up in the context of future FRED extensions, which m=
ay
>> increase the size of the exception stack frame under some circumstances=
,
>> which may not be constant in the first place=2E
>>=20
>> It struck me that this can be combined with kernel stack randomization =
in
>> such a way that it mostly amortizes the cost of both=2E
>
>I've tried to go get up to speed with what FRED changes in x86, and IIUC
>it effectively redefines the interrupt handling? Does it also change
>syscall entry? (I got the impression it does not, but the mention of
>syscalls later in your email make me think I've gotten this wrong=2E)
>
>I think currently kstack randomization isn't applied to interrupts (but
>it should be), so I'm all for finding a way to make this happen=2E
>
>> Downside: for best performance, it should be pushed into assembly entry=
/exit
>> code, although that is technically not *required* (and it is of course
>> possible to do it in C on IDT but in the one single assembly entry stub=
 for
>> FRED=2E)
>>=20
>> In the FRED code it would look like [simplified]:
>>=20
>> asm_fred_entrypoint_user:
>> 	/* Current code */
>> 	/* =2E=2E=2E */
>> 	movq %rsp,%rdi		/* part of FRED_ENTER */
>>=20
>> 	/* New code */
>> 	movq %rdi,PER_CPU_VAR(user_pt_regs_ptr)	/* [1] */
>> #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>> 	subq PER_CPU_VAR(kstack_offset),%rsp	/* [2] */
>> #endif
>> 	/* CFI annotation */
>>=20
>> 	/* Current code */
>> 	call fred_entry_from_user
>>=20
>> asm_fred_exit_uTser:
>> 	/* New code */
>> 	movq PER_CPU_VAR(user_pt_regs_ptr),%rsp
>> 	/* CFI annotation */
>>=20
>> 	/* Current code */
>> 	/* =2E=2E=2E */
>> 	ERETU
>
>If I'm understanding FRED correctly, I think this exit path
>would need to call choose_random_kstack_offset() as well=2E (For
>syscalls, add_random_kstack_offset() is used on entry and
>choose_random_kstack_offset() is used on exit, so I think we'd want the
>same pattern for interrupt handling=2E)
>
>> [1] - This instruction can be pushed into the C code in
>> fred_entry_from_user() without changing the functionality in any way=2E
>>=20
>> [2] - This is the ONLY instruction in this sequence that would be speci=
fic
>> to CONFIG_RANDOMIZE_KSTACK_OFFSET, and it probably isn't even worth pat=
ching
>> out=2E
>>=20
>> This requires a 64-bit premasked value to be generated byc
>> choose_random_kstack_offset() which would seem to be a better option fo=
r
>> performance, especially since there is already arithmetic done at that =
time=2E
>> Otherwise it requires three instructions=2E This means the randomness
>> accumulator ends up being in a separate variable from the premasked val=
ue=2E
>> This could be further very slightly optimized by adding the actual stac=
k
>> location and making this a movq, but then that value has to be
>> context-switched; this is probably not all that useful=2E
>
>Yeah, having a pre-masked value ready to go seems fine to me=2E It's
>simply a space trade-off=2E
>
>> The masking needs to consider alignment, which the current code doesn't=
;
>> that by itself adds additional code to the current code sequences=2E
>>=20
>>=20
>> That is literally *all* the code that is needed to replace
>> add_random_kstack_offset()=2E It doesn't block tailcall optimization an=
ywhere=2E
>> If user_pt_regs_ptr and kstack_offset share a cache line it becomes eve=
n
>> cheaper=2E
>>=20
>> Note that at least in the FRED case this code would be invoked even on
>> events other than system calls, some of which may be controllable by th=
e
>> user, like page faults=2E I am guessing that this is actually a plus=2E
>
>Yeah, I'd like greater coverage for ring 3->0 transitions=2E We do want t=
o
>double-check the original design choices, though=2E I *think* they still
>stand (see the comments for choose_random_kstack_offset() about entropy
>location (per-cpu area), and lifetime (across userspace execution)=2E
>
>-Kees
>

FRED replaces ALL exception handling and ring transitions, including syste=
m calls and call gates=2E=20

You can't enter ring 0 without going through the FRED entry point (and you=
 can't enter rings 1 or 2 at all, officially deprecating them from the arch=
itecture=2E)

