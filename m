Return-Path: <linux-kernel+bounces-103785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866CD87C472
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1338B1F2229E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55036763F3;
	Thu, 14 Mar 2024 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTZXdwP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DB2A1C7;
	Thu, 14 Mar 2024 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449415; cv=none; b=chqMPv/ANUVoIOMwsjIOnh/AzDaQ/8fNm5hT6t5Q0nSqHqNeXWp2L8JAXmarnsrDhqCasjmGOZ8O1rCQ9i8I0rO3U1jnA9VMJ/1rTBm3V7u1cYgDLjC7NxKFuuUESOnHS4J2aNAtQUI80L4fqXt9/ocG5JcTfKd3C680YF3GHnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449415; c=relaxed/simple;
	bh=dkDMtvv2pEkypl9VNokAWmauFxTdX5cLHzL3XjbhbMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dqXiAYVFqBMPc4LvXx5I8dREpKHyQzAO3bdhvkekYzp2e0wCQ5Ma23ChouSl/EkcE+ClKCucyz1iC4mfZvEgCUBVX6+EdPApCxPPfBvdbzTcQ1qy6Q7ILodkmEZy7kcGZ16a/sy1As/etyLHWQNW2C2zZuBk+ybrSzVl3zmcBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTZXdwP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530BAC433F1;
	Thu, 14 Mar 2024 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710449414;
	bh=dkDMtvv2pEkypl9VNokAWmauFxTdX5cLHzL3XjbhbMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iTZXdwP6aC7xzjJ8MgcLLrQ6/iIDqdEfmXRQNgIkp9Oau1qgT57pSLXX7sP1cseXV
	 ER0FR23LtfY+R50uwGom+cHRiAn8/hp3TGEPVxJitlEigZqlpzB9qeeF38xACjfE0K
	 fHfgJVxUU2wm9w3OsEB26AhNZiUQ35VIMZNVAkMgomTRGb4pJ+D25n6SeY5ZDtl2sC
	 XduHyAmKFNOEoTGzs1ugIu+ksQALSr1qtPdnGxojMIUIuc4GtSCuyhomgglQrR6SL7
	 AIDGNHpddNLwpUUySh34r20VVWDQFt9vnn2IcApEvWbZqyda5nzA2tSJdFVfrSpGoN
	 guOU5J466Os3w==
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
 linux-trace-kernel@vger.kernel.org, Robbin Ehn <rehn@rivosinc.com>,
 	Brendan Sweeney <brs@rivosinc.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
In-Reply-To: <87zfv0onre.fsf@all.your.base.are.belong.to.us>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
 <8734suqsth.fsf@all.your.base.are.belong.to.us>
 <mb61pplvw6grf.fsf@gmail.com>
 <87zfv0onre.fsf@all.your.base.are.belong.to.us>
Date: Thu, 14 Mar 2024 21:50:11 +0100
Message-ID: <87il1oedx8.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Puranjay Mohan <puranjay12@gmail.com> writes:
>
>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>>
>>>
>>> Hmm, depending on RISC-V's CMODX path, the pro/cons CALL_OPS vs dynamic
>>> trampolines changes quite a bit.
>>>
>>> The more I look at the pains of patching two instruction ("split
>>> immediates"), the better "patch data" + one insn patching look.
>>
>> I was looking at how dynamic trampolines would be implemented for RISC-V.
>>
>> With CALL-OPS we need to patch the auipc+jalr at function entry only, the
>> ops pointer above the function can be patched atomically.
>>
>> With a dynamic trampoline we need a auipc+jalr pair at function entry to=
 jump
>> to the trampoline and then another auipc+jalr pair to jump from trampoli=
ne to
>> ops->func. When the ops->func is modified, we would need to update the
>> auipc+jalr at in the trampoline.
>>
>> So, I am not sure how to move forward here, CALL-OPS or Dynamic trampoli=
nes?
>
> Yeah. Honestly, we need to figure out the patching story prior
> choosing the path, so let's start there.
>
> After reading Mark's reply, and discussing with OpenJDK folks (who does
> the most crazy text patching on all platforms), having to patch multiple
> instructions (where the address materialization is split over multiple
> instructions) is a no-go. It's just a too big can of worms. So, if we
> can only patch one insn, it's CALL_OPS.
>
> A couple of options (in addition to Andy's), and all require a
> per-function landing address ala CALL_OPS) tweaking what Mark is doing
> on Arm (given the poor branch range).
>
> ...and maybe we'll get RISC-V rainbows/unicorns in the future getting
> better reach (full 64b! ;-)).
>
> A) Use auipc/jalr, only patch jalr to take us to a common
>    dispatcher/trampoline
>=20=20=20
>  | <func_trace_target_data_8B> # probably on a data cache-line !=3D func =
text to avoid ping-pong
>  | ...
>  | func:
>  |   ...make sure ra isn't messed up...
>  |   aupic
>  |   nop <=3D> jalr # Text patch point -> common_dispatch
>  |   ACTUAL_FUNC
>  |=20
>  | common_dispatch:
>  |   load <func_trace_target_data_8B> based on ra
>  |   jalr
>  |   ...
>
> The auipc is never touched, and will be overhead. Also, we need a mv to
> store ra in a scratch register as well -- like Arm. We'll have two insn
> per-caller overhead for a disabled caller.
>
> B) Use jal, which can only take us +/-1M, and requires multiple
>    dispatchers (and tracking which one to use, and properly distribute
>    them. Ick.)
>
>  | <func_trace_target_data_8B> # probably on a data cache-line !=3D func =
text to avoid ping-pong
>  | ...
>  | func:
>  |   ...make sure ra isn't messed up...
>  |   nop <=3D> jal # Text patch point -> within_1M_to_func_dispatch
>  |   ACTUAL_FUNC
>  |=20
>  | within_1M_to_func_dispatch:
>  |   load <func_trace_target_data_8B> based on ra
>  |   jalr
>
> C) Use jal, which can only take us +/-1M, and use a per-function
>    trampoline requires multiple dispatchers (and tracking which one to
>    use). Blows up text size A LOT.
>
>  | <func_trace_target_data_8B> # somewhere, but probably on a different c=
acheline than the .text to avoid ping-ongs
>  | ...
>  | per_func_dispatch
>  |   load <func_trace_target_data_8B> based on ra
>  |   jalr
>  | func:
>  |   ...make sure ra isn't messed up...
>  |   nop <=3D> jal # Text patch point -> per_func_dispatch
>  |   ACTUAL_FUNC

Brendan proposed yet another option, "in-function dispatch":

D)=20
  | <func_trace_target_data_8B_per_function> # idk somewhere
  | ...
  | func:
  |    mv tmp1, ra
  |    aupic tmp2, <func_trace_target_data_8B_per_function:upper>
  |    mv tmp3, zero <=3D> ld tmp3, tmp2<func_trace_target_data_8B_per_func=
tion:lower>
  |    nop <=3D> jalr ra, tmp3
  |    ACTUAL_FUNC

There are 4 CMODX possiblities:
   mv, nop:  fully disabled, no problems
   mv, jalr: We will jump to zero. We would need to have the inst
             page/access fault handler take care of this case. Especially
             if we align the instructions so that they can be patched
             together, being interrupted in the middle and taking this
             path will be rare.
  ld, nop:   no problems
  ld, jalr:  fully enabled, no problems

Patching is a 64b store/sd, and we only need a fence.i at the end, since
we can handle all 4 possibilities.

For the disabled case we'll have:
A) mv, aupic, nop
D) mv, aupic, mv, nop.

Puranjay, I've flipped. Let's go Mark's CALL_OPS together with a new
text patch mechanism w/o stop_machine().


Bj=C3=B6rn

