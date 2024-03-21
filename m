Return-Path: <linux-kernel+bounces-110543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2605F886059
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D658E287E72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7BB133404;
	Thu, 21 Mar 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5or/Xz8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD31332B6;
	Thu, 21 Mar 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044631; cv=none; b=oDfDYmWPP4dc6/H2EZ02pz1DMutbOcs1G8llYim36rBBUMKUlNdJJglHlOnui25PALEglk+D+50ABsa4ZKJtCUqt/7iR5xlzhBPXB3A+cTQB6zMFJot+Vjd04HT2t66squ82dvCSgcXLEDCLE4XbrHmivkaUh5zTQt6Di/nuvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044631; c=relaxed/simple;
	bh=C/Xs/YhoEIKUB5a72gt+BlmWEN/hpBUi8RqVqzQGdU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W1vfNfJbxg3VHP/Akv2zsIzVCZbeU7NcTGH51/QJIlLxwyNkpivPf4DIKLUB52iUhw3gIqskCoaxbDAizU+7uMtUs5Kz+hMMvYP8A5utUf6QAZR3ZJpmTp/nQL6cHLVS4NLBAyjzFJ49idgJ5LzguAm9lXD6AW7hTqtGsLzTcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5or/Xz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D638C433F1;
	Thu, 21 Mar 2024 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711044631;
	bh=C/Xs/YhoEIKUB5a72gt+BlmWEN/hpBUi8RqVqzQGdU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l5or/Xz8OLwlWXFIJwiS/LM+xBUv08OZl7NI8BcUn11G6kr2g19+W6IZDamAVCltX
	 FB+b4repBxbi+qcbU+0/JDZaRRK9T+mbMEXgADHgiMsug52fR0QVHEO4BOc164YyIG
	 aHTN83CBjUQfikXkDeL2GbukbHhbV0za8vyFT/fgMX9Jt28RPxkfDfeqm6UwIc8un/
	 PP336dtMGRpO9sSaGq5gEvCKBr64/AmUM6FcQu+1bF/pzY3/LJU0ZUXRJGKuQooSbh
	 r6AflhHkBoyfYMdGjoj4NVcVsgA/hlpucNs/JZ6Bfo8pY7msEj4VucSue+UbfMTnoU
	 HD46/kGFj+nEg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Guo Ren <guoren@kernel.org>, Ley
 Foon Tan <leyfoon.tan@starfivetech.com>, Deepak Gupta
 <debug@rivosinc.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, Bjorn
 Topel <bjorn@rivosinc.com>, Song Shuai <suagrfillet@gmail.com>, Cl'ement
 L'eger <cleger@rivosinc.com>, Al Viro <viro@zeniv.linux.org.uk>, Jisheng
 Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Robbin
 Ehn <rehn@rivosinc.com>, Brendan Sweeney <brs@rivosinc.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
In-Reply-To: <CABgGipUayONdvaH0nexBJUai=qT3yqURhinTbDWxORfMDQ_5pw@mail.gmail.com>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
 <8734suqsth.fsf@all.your.base.are.belong.to.us>
 <mb61pplvw6grf.fsf@gmail.com>
 <87zfv0onre.fsf@all.your.base.are.belong.to.us>
 <87il1oedx8.fsf@all.your.base.are.belong.to.us>
 <CABgGipWPuvwi43v1+60-=0_MN_q_CD0ZGasxHHVWJ37cig5MmA@mail.gmail.com>
 <87msqsotr8.fsf@all.your.base.are.belong.to.us>
 <CABgGipUayONdvaH0nexBJUai=qT3yqURhinTbDWxORfMDQ_5pw@mail.gmail.com>
Date: Thu, 21 Mar 2024 19:10:27 +0100
Message-ID: <877chve9rg.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Chiu <andy.chiu@sifive.com> writes:

> On Thu, Mar 21, 2024 at 4:48=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Andy,
>>
>> Pulling out the A option:
>>
>> >> > A) Use auipc/jalr, only patch jalr to take us to a common
>> >> >    dispatcher/trampoline
>> >> >
>> >> >  | <func_trace_target_data_8B> # probably on a data cache-line !=3D=
 func .text to avoid ping-pong
>> >> >  | ...
>> >> >  | func:
>> >> >  |   ...make sure ra isn't messed up...
>> >> >  |   aupic
>> >> >  |   nop <=3D> jalr # Text patch point -> common_dispatch
>> >> >  |   ACTUAL_FUNC
>> >> >  |
>> >> >  | common_dispatch:
>> >> >  |   load <func_trace_target_data_8B> based on ra
>> >> >  |   jalr
>> >> >  |   ...
>> >> >
>> >> > The auipc is never touched, and will be overhead. Also, we need a m=
v to
>> >> > store ra in a scratch register as well -- like Arm. We'll have two =
insn
>> >> > per-caller overhead for a disabled caller.
>> >
>> > My patch series takes a similar "in-function dispatch" approach. A
>> > difference is that the <func_trace_target_data_8B_per_function> is
>> > embedded within each function entry. I'd like to have it moved to a
>> > run-time allocated array to reduce total text size.
>>
>> This is what arm64 has as well. It's a 8B + 1-2 dirt cheap movish like
>> instructions (save ra, prepare jump with auipc). I think that's a
>> reasonable overhead.
>>
>> > Another difference is that my series changes the first instruction to
>> > "j ACTUAL_FUNC" for the "ftrace disable" case. As long as the
>> > architecture guarantees the atomicity of the first instruction, then
>> > we are safe. For example, we are safe if the first instruction could
>> > only be "mv tmp, ra" or "j ACTUAL_FUNC". And since the loaded address =
is
>> > always valid, we can fix "mv + jalr" down so we don't have to
>> > play with the exception handler trick. The guarantee from arch would
>> > require ziccif (in RVA22) though, but I think it is the same for us
>> > (unless with stop_machine). For ziccif, I would rather call that out
>> > during boot than blindly assume.
>>
>> I'm maybe biased, but I'd prefer the A) over your version with the
>> unconditional jump. A) has the overhead of two, I'd say, free
>> instructions (again "Meten is Weten!" ;-)).
>
> Yes, I'd also prefer A for less overall patch size. We can also
> optimize the overhead with a direct jump if that makes sense. Though,
> we need to sort out a way to map functions to corresponding
> trampolines. A direct way I could image is CALL_OPS'ish patching
> style, if the ftrace destination has to be patched in a per-function
> manner. For example:
>
> <index-in-dispatch-list>
> func_symbol:
> auipc t0, common_dispatch:high <=3D> j actual_func:
> jalr t0, common_dispatch:low(t0)
>
> common_dispatch:
> load t1, index + dispatch-list
> ld t1, 0(t1)
> jr t1

Yup, exactly like that (but I'd put the acutal target ptr in there,
instead of an additional indirection. Exactly what Mark does for arm64).

When we enter the common_dispatch, the ptr <index-in-dispatch-list>
would be -12(t0).

As for patching auipc or jalr, I guess we need to measure what's best.
My knee-jerk would be always auipc is better than jump -- but let's
measure. ;-)


Bj=C3=B6rn

