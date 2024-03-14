Return-Path: <linux-kernel+bounces-103456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD4587BF94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD5B1C21753
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498CB71741;
	Thu, 14 Mar 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfl+o6Vt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87853DDD9;
	Thu, 14 Mar 2024 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428857; cv=none; b=SZ4ilK/PguZv6sZ0LkDcyztq7NGviH5+ziHB2rqOQj3xEj4vZutNRZnu96mNTzPfR3biSUSi29EFqer9pV2hEsKtXLZABd1gU+XiFk6s5c4pHCdQ2TfqTJhdYpqVdqBh8RDUTo9NLVl0vzmz9obILF0B0evKGS1n7YUe+2JtbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428857; c=relaxed/simple;
	bh=GTQVrWcs6XBMnV9a14mAay7RyQJOjR0XkVbs68SqZPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F0CKbxS9CbwAI4V1LblbZvVy5KOGq75UAGoKdxwRmRdvintycE6pAceu24mLE4TEJ4jOj0QxDLaQVHj/4IPcBaifgltVGOubC4ieoXd/53Y+gaud+ENJ/VO2bkjeDt6XIvHk1akc9tTRCEwL5uBDVcDK5Ck8KovSmdGD2EhhIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfl+o6Vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F50C433F1;
	Thu, 14 Mar 2024 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710428857;
	bh=GTQVrWcs6XBMnV9a14mAay7RyQJOjR0XkVbs68SqZPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Gfl+o6VtDn9x2Fj955iyoM1+yBnt/TsF7oYp6foNPn9asCM6e9NsX2I9HbgeW5uI5
	 fcoKb3FedKukBXX05fexGqKId3twgTL/3iq3jcYCxobZ48JHMiJZeVz6tNs+6+wtPk
	 w0PHcqFQDARplTSrKVp2EpgNYKTWO/itjTRfg5WmqLw27khIRRf86AdB+DLL+0n6yq
	 YuRRZ8GgUx+px5xHy1V2xBnnxhSwa01rK/mFRerJSP2rfaYES1mWmZYix4YtILbgy8
	 IdhL0TkeHcMvr787XJOsXnCZPM+gUee6OTjB2Y6oT4qAy7EhvEt6PntEVMY5jSyrkk
	 loOBoYle/+6mg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt
 <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Bjorn Topel <bjorn@rivosinc.com>, Song
 Shuai <suagrfillet@gmail.com>, Cl'ement L'eger <cleger@rivosinc.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Robbin Ehn <rehn@rivosinc.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
In-Reply-To: <mb61pplvw6grf.fsf@gmail.com>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
 <8734suqsth.fsf@all.your.base.are.belong.to.us>
 <mb61pplvw6grf.fsf@gmail.com>
Date: Thu, 14 Mar 2024 16:07:33 +0100
Message-ID: <87zfv0onre.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
>>
>> Hmm, depending on RISC-V's CMODX path, the pro/cons CALL_OPS vs dynamic
>> trampolines changes quite a bit.
>>
>> The more I look at the pains of patching two instruction ("split
>> immediates"), the better "patch data" + one insn patching look.
>
> I was looking at how dynamic trampolines would be implemented for RISC-V.
>
> With CALL-OPS we need to patch the auipc+jalr at function entry only, the
> ops pointer above the function can be patched atomically.
>
> With a dynamic trampoline we need a auipc+jalr pair at function entry to =
jump
> to the trampoline and then another auipc+jalr pair to jump from trampolin=
e to
> ops->func. When the ops->func is modified, we would need to update the
> auipc+jalr at in the trampoline.
>
> So, I am not sure how to move forward here, CALL-OPS or Dynamic trampolin=
es?

Yeah. Honestly, we need to figure out the patching story prior
choosing the path, so let's start there.

After reading Mark's reply, and discussing with OpenJDK folks (who does
the most crazy text patching on all platforms), having to patch multiple
instructions (where the address materialization is split over multiple
instructions) is a no-go. It's just a too big can of worms. So, if we
can only patch one insn, it's CALL_OPS.

A couple of options (in addition to Andy's), and all require a
per-function landing address ala CALL_OPS) tweaking what Mark is doing
on Arm (given the poor branch range).

..and maybe we'll get RISC-V rainbows/unicorns in the future getting
better reach (full 64b! ;-)).

A) Use auipc/jalr, only patch jalr to take us to a common
   dispatcher/trampoline
=20=20
 | <func_trace_target_data_8B> # probably on a data cache-line !=3D func .t=
ext to avoid ping-pong
 | ...
 | func:
 |   ...make sure ra isn't messed up...
 |   aupic
 |   nop <=3D> jalr # Text patch point -> common_dispatch
 |   ACTUAL_FUNC
 |=20
 | common_dispatch:
 |   load <func_trace_target_data_8B> based on ra
 |   jalr
 |   ...

The auipc is never touched, and will be overhead. Also, we need a mv to
store ra in a scratch register as well -- like Arm. We'll have two insn
per-caller overhead for a disabled caller.

B) Use jal, which can only take us +/-1M, and requires multiple
   dispatchers (and tracking which one to use, and properly distribute
   them. Ick.)

 | <func_trace_target_data_8B> # probably on a data cache-line !=3D func .t=
ext to avoid ping-pong
 | ...
 | func:
 |   ...make sure ra isn't messed up...
 |   nop <=3D> jal # Text patch point -> within_1M_to_func_dispatch
 |   ACTUAL_FUNC
 |=20
 | within_1M_to_func_dispatch:
 |   load <func_trace_target_data_8B> based on ra
 |   jalr

C) Use jal, which can only take us +/-1M, and use a per-function
   trampoline requires multiple dispatchers (and tracking which one to
   use). Blows up text size A LOT.

 | <func_trace_target_data_8B> # somewhere, but probably on a different cac=
heline than the .text to avoid ping-ongs
 | ...
 | per_func_dispatch
 |   load <func_trace_target_data_8B> based on ra
 |   jalr
 | func:
 |   ...make sure ra isn't messed up...
 |   nop <=3D> jal # Text patch point -> per_func_dispatch
 |   ACTUAL_FUNC

It's a bit sad that we'll always have to have a dispatcher/trampoline,
but it's still better than stop_machine(). (And we'll need a fencei IPI
as well, but only one. ;-))

Today, I'm leaning towards A (which is what Mark suggested, and also
Robbin).. Any other options?

[Now how do we implement OPTPROBES? I'm kidding. ;-)]


Bj=C3=B6rn

