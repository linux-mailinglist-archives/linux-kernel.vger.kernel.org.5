Return-Path: <linux-kernel+bounces-104975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2663087D721
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811FDB21788
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461C95A0E8;
	Fri, 15 Mar 2024 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHaMtV+M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pdiQ7lY5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B50101E6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710543942; cv=none; b=HeOdJBDaaOyJZcZpY8AA4izA8BaZmWJ8h36CZpOjipx+sl1SyooPwaPYU1TcRfORmNZiqQDhXXBGu7Ck4xtPouNtadbhbgwFUqRzVlr9kAgsrbIeMBjoGpp42p0CnEUI1m40c/Zbg8CHRlMBtFgOBb0l0AGp9G7pEQSe45KDIVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710543942; c=relaxed/simple;
	bh=V5U/A5+OpC+F6/ItfRgI7fGsiCiF8dUI67NkxPmgOww=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=W17B5VyUB0K3tP0cFMiQ17E/4hLq8Oq9XEzZIt2j7JFxvMr3Gh12S5GMQj7pzRMJfb7tIlWKyj18daEounQ+q/DYYHNdMfAMqEUgAaQkNuiiXUhIuA1FMcsSR2i8Or3c7rPUUkHnFTycyQvHYELWUCZc+LINBdapuzo6vGyACus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHaMtV+M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pdiQ7lY5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710543937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=x9NYFYFkZx15URy4X5ckNXi/g1YXgdxNScGQNiBf1oA=;
	b=YHaMtV+MvPzdHmDFS23SfC3T09axix290uUpnSQDMLLU2WsWnEutEzhlXvyzUSLR9ZL2Mc
	ACeHAGRoPoBMBzEARkjuj6fHYeJliV0BILhpEVS8u3fzHp5nV4ZcMTvd3JI++JkXEGuo6h
	p5GR7P+mFy9Wooae9EDkowP97J+ydB5GkUowN5/oAYq96fO5B8HMneO7tOm4aqh2K/xNWC
	/qIndTbuuE7RbwErv/s5YDIJRfYvKbOrlAQLOegEz5bN5HZNqgqQT64k4F0dhX2YFkal1s
	RjDe5mj5BmZ93Rlh+fJWndYvBFKhzflTzkbDoKM+xjcbLEhA/kUq7f0D33NIgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710543937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=x9NYFYFkZx15URy4X5ckNXi/g1YXgdxNScGQNiBf1oA=;
	b=pdiQ7lY56iwOuXgZMXm4THmk+FU33yX/J/yJgLeY8JXCgr9vu5oBaopOSf/FA1buVu6hCJ
	/sLpoZtQ1Z30BYDQ==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
In-Reply-To: <66A5A2E7-3B29-4596-9B26-E1B0031BB74D@oracle.com>
Date: Sat, 16 Mar 2024 00:05:36 +0100
Message-ID: <87msqzjdtr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15 2024 at 18:43, Aruna Ramakrishna wrote:
>> On Mar 15, 2024, at 10:36=E2=80=AFAM, Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>>> But I=E2=80=99m not sure there is a =E2=80=9Cclean=E2=80=9D way to do t=
his. If there is, I=E2=80=99m
>>> happy to redo the patch.
>>=20
>> If it turns out to be required, desired whatever then the obvious clean
>> solution is to hand the PKRU value down:
>>=20
>>         setup_rt_frame()
>>           xxx_setup_rt_frame()
>>             get_sigframe()
>>               copy_fpstate_to_sigframe()
>>=20
>> copy_fpstate_to_sigframe() has the user fpstate pointer already so none
>> of the __update_pkru_in_sigframe() monstrosities are required. No?
>>=20
>
> Are you suggesting modifying all these functions down the chain from
> handle_signal() to take in an additional parameter?

Yes.

> Wouldn=E2=80=99t that break kABI?

If so who cares?

kABI is an out of tree madness maintained by distros, but upstream has
never supported it and never will. Aside of that kABI is a driver
interface which hardly has anything to do with the low level
architecture specific signal delivery code.

The kernel has no stable ABI, never had and never will have one, unless
hell freezes over.

> In this approach too, the snippet where the value is modified on the
> sigframe after xsave will remain unchanged, because we need the value
> before xsave to match the register contents.
>
> I guess what I=E2=80=99m saying is, half of __update_pkru_in_sigframe() w=
ill
> remain unchanged - it would just be invoked from
> copy_fpstate_to_sigframe() instead of handle_signal().

Yes, but that's the necessary and sane part of it.

> If there=E2=80=99s a way to do this without overwriting PKRU on the sigfr=
ame
> after xsave, I'd like to understand that flow.

There is none for obvious reasons unless you figure out how to resolve a
double circular hen and egg problem.

> Or if it=E2=80=99s just a matter of not needing to extract fpstate pointe=
r in
> handle_signal(), I can restructure it that way too.

It's not only the pointer retrieval. Updating xstate is obviously a FPU
specific problem and the general signal handling code simply should not
care. C does not provide encapsulation, but it does not prevent
respecting it either.

Ideally we'd hide all of this in the FPU code, which is anyway the first
one writing to the signal stack. The problem is the error case when any
of the writes after saving the FPU frame terminaly faults or any other
condition makes the signal delivery fail.

So handle_signal() should look like this:

	/* Ensure that the signal stack is writeable */
        pkru =3D sig_prepare_pkru();

	failed =3D setup_rt_frame(ksig, regs, pkru);
	if (!failed) {
		/*
		 * Clear the direction flag as per the ABI for function entry.
		 *
		 * Clear RF when entering the signal handler, because
		 * it might disable possible debug exception from the
		 * signal handler.
		 *
		 * Clear TF for the case when it wasn't set by debugger to
		 * avoid the recursive send_sigtrap() in SIGTRAP handler.
		 */
		regs->flags &=3D ~(X86_EFLAGS_DF|X86_EFLAGS_RF|X86_EFLAGS_TF);
		/*
		 * Ensure the signal handler starts with the new fpu state.
		 * This also ensures that the PKRU state is set to the
		 * initial state.
		 */
		fpu__clear_user_states(fpu);
	} else {
        	/* Restore the previous PKRU state */
                sig_restore_pkru(pkru);
        }

and then you'd have:

static inline bool copy_fpregs_to_sigframe(struct xregs_state __user *buf, =
u32 pkru)
{
	if (use_xsave()) {
		if (!xsave_to_user_sigframe(buf))
                	return false;
                if (cpu_feature_enabled(X86_FEATURE_OSPKE))
                	return !__put_user(pkru_address(buf), pkru);
                return true;
        }
	if (use_fxsr())
		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
	else
		return fnsave_to_user_sigframe((struct fregs_state __user *) buf);
}

And yes, I deliberately changed the return value of setup_rt_frame() to
bool in this mockup because nothing cares about it. The only relevant
information is whether if failed or not. That want's to be a separate
patch obivously.

Thanks,

        tglx






