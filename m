Return-Path: <linux-kernel+bounces-109183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2F48815D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E211F225FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF0A15A8;
	Wed, 20 Mar 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TmtgrB8q"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F015C3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952945; cv=none; b=G1wFfP3MUTSpNOh3m3g+BYeRvVa7GrkgXys3ZVXCmFJRS2TOkqfosU0E2H5Z+4YzkD1cU8OzTsh9c3FASUJD9EZLloCbKly7g9ocsGKwY6S+B/YjIDIHHfN60jF+nLCXEDGkk1ITxCqn3kDuHcgJweiaw7R2SpVnhAr38TnVTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952945; c=relaxed/simple;
	bh=n/qBSqnoCDaEZUwEdc6nE4mkAewNmm2ZujXyWNcmjVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5ifqvh1n2j4zrR/WhrvyDWxRdualUX4onKCwKpiZGSr0OMAXdalpmAtBXv+XY9fCmA0e+RzU0tS9Ua00CUtNZZSmfWNsKJs7wL2cK91NX9Ou3xk5vOwc6mXDyQgC+GmQKUWU8p7qTHeN2ZPowhIJMquomYAeAqNa0QVW3EXUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TmtgrB8q; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a0579a955so83350557b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710952942; x=1711557742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C0go5GeoUF1aqwd5WJWdc0gTbFG3QELgzX8R+DzOuI=;
        b=TmtgrB8qSmdhSIUJJmtXLRW8gm5340i+fgOoGBz8u+wZP7w+hm/8WtrBVwzcunYKFS
         FnHeMbICSdBxLiVrwGudi4+B4C6lETQf1OnpfwlhS9ny+iFaUdlbjpNeDcV//aAoQVoa
         3i0yzoux+iZChf5s3W24yPuvHZzxKBf4KVO9Z/TeXRN/36wKZPCPAueak45fuGwP76SR
         x6pimA/KaYPNMMglSNoTxcAeQTn/b1vyN3IP+Q7l8motqWKYADKeZXmbn1kgFYrS86yZ
         JhGvQeyzeUMzBEHDY7ptlW9yMZwDBtRMMrph8cGkEcxn28J7KT8xH4PhTTLv5IodGqUR
         VLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952942; x=1711557742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/C0go5GeoUF1aqwd5WJWdc0gTbFG3QELgzX8R+DzOuI=;
        b=ehGFVjUycROifuWFCvZlU98HI4pPLFwh0ifgUVwOBrYNZy1zGbbxt42GziUjUGkTGL
         a10dTL0wOLVdXXLFNgv+cNS7AU3S5HGoAc+2JXzRKyndppM3GV6nHEBkIJsYG9FvqGZD
         r7/+HQW14FeXAacmvVXUqxBvjXcR4nLyG4eggBX0cM8sGFWGizVi1ruI6zzImLltWg1v
         rwE2nV11jVpc7AQrl3ucxnoa+BrWVomIHYCijrtOzBI7SpEtmQsDUiNtWgzeApclO9mE
         etd7+Bbra2nfejxL01usLUXpJAYjGc87y2uEUSiL4JvJc29i8N6bOcrBf2QBiPIyX3i3
         Rtdg==
X-Forwarded-Encrypted: i=1; AJvYcCU191e12z+/fQEuPHJ28SrdUKeotpV+IYtld6pROw04qKOFyWtmPEo7iiF5iWTHFu5scigcfk5TvO6QknXfgqchpPCOquh9Ul7wWpZr
X-Gm-Message-State: AOJu0Yz9ocF9h5q7rpftrGki0CbFhvQKvsw2ydr1lZ08lWoWTibl8pmP
	GtadqWmc9hgRkFboO+K1SyRhSjJ1Oln1Cho4aNf0zicWMB73mBQb6sYPm87U06so/aQa5yJqrxH
	tC4o5OM9gvIw/IoqKyT53hScpb4C4ayBnmPSqYinzjqVWYfA63YY=
X-Google-Smtp-Source: AGHT+IGYNdFruVqknweeMZibIxK5wVlRKsW3ccyqWtS2kmgKboBe+PUMsfNihhXKHZf27wB2CGJ+gDtjeYC6VWYGmH8=
X-Received: by 2002:a81:ab50:0:b0:60f:ed06:bee7 with SMTP id
 d16-20020a81ab50000000b0060fed06bee7mr6253031ywk.50.1710952942198; Wed, 20
 Mar 2024 09:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306165904.108141-1-puranjay12@gmail.com> <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N> <8734suqsth.fsf@all.your.base.are.belong.to.us>
 <mb61pplvw6grf.fsf@gmail.com> <87zfv0onre.fsf@all.your.base.are.belong.to.us> <87il1oedx8.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87il1oedx8.fsf@all.your.base.are.belong.to.us>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 21 Mar 2024 00:41:00 +0800
Message-ID: <CABgGipWPuvwi43v1+60-=0_MN_q_CD0ZGasxHHVWJ37cig5MmA@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
	Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, 
	Bjorn Topel <bjorn@rivosinc.com>, Song Shuai <suagrfillet@gmail.com>, 
	"Cl'ement L'eger" <cleger@rivosinc.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Robbin Ehn <rehn@rivosinc.com>, Brendan Sweeney <brs@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B6rn,

On Fri, Mar 15, 2024 at 4:50=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
> > Puranjay Mohan <puranjay12@gmail.com> writes:
> >
> >> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
> >>
> >>>
> >>> Hmm, depending on RISC-V's CMODX path, the pro/cons CALL_OPS vs dynam=
ic
> >>> trampolines changes quite a bit.
> >>>
> >>> The more I look at the pains of patching two instruction ("split
> >>> immediates"), the better "patch data" + one insn patching look.
> >>
> >> I was looking at how dynamic trampolines would be implemented for RISC=
-V.
> >>
> >> With CALL-OPS we need to patch the auipc+jalr at function entry only, =
the
> >> ops pointer above the function can be patched atomically.
> >>
> >> With a dynamic trampoline we need a auipc+jalr pair at function entry =
to jump
> >> to the trampoline and then another auipc+jalr pair to jump from trampo=
line to
> >> ops->func. When the ops->func is modified, we would need to update the
> >> auipc+jalr at in the trampoline.
> >>
> >> So, I am not sure how to move forward here, CALL-OPS or Dynamic trampo=
lines?
> >
> > Yeah. Honestly, we need to figure out the patching story prior
> > choosing the path, so let's start there.
> >
> > After reading Mark's reply, and discussing with OpenJDK folks (who does
> > the most crazy text patching on all platforms), having to patch multipl=
e
> > instructions (where the address materialization is split over multiple
> > instructions) is a no-go. It's just a too big can of worms. So, if we
> > can only patch one insn, it's CALL_OPS.
> >
> > A couple of options (in addition to Andy's), and all require a
> > per-function landing address ala CALL_OPS) tweaking what Mark is doing
> > on Arm (given the poor branch range).
> >
> > ...and maybe we'll get RISC-V rainbows/unicorns in the future getting
> > better reach (full 64b! ;-)).
> >
> > A) Use auipc/jalr, only patch jalr to take us to a common
> >    dispatcher/trampoline
> >
> >  | <func_trace_target_data_8B> # probably on a data cache-line !=3D fun=
c .text to avoid ping-pong
> >  | ...
> >  | func:
> >  |   ...make sure ra isn't messed up...
> >  |   aupic
> >  |   nop <=3D> jalr # Text patch point -> common_dispatch
> >  |   ACTUAL_FUNC
> >  |
> >  | common_dispatch:
> >  |   load <func_trace_target_data_8B> based on ra
> >  |   jalr
> >  |   ...
> >
> > The auipc is never touched, and will be overhead. Also, we need a mv to
> > store ra in a scratch register as well -- like Arm. We'll have two insn
> > per-caller overhead for a disabled caller.
> >
> > B) Use jal, which can only take us +/-1M, and requires multiple
> >    dispatchers (and tracking which one to use, and properly distribute
> >    them. Ick.)
> >
> >  | <func_trace_target_data_8B> # probably on a data cache-line !=3D fun=
c .text to avoid ping-pong
> >  | ...
> >  | func:
> >  |   ...make sure ra isn't messed up...
> >  |   nop <=3D> jal # Text patch point -> within_1M_to_func_dispatch
> >  |   ACTUAL_FUNC
> >  |
> >  | within_1M_to_func_dispatch:
> >  |   load <func_trace_target_data_8B> based on ra
> >  |   jalr
> >
> > C) Use jal, which can only take us +/-1M, and use a per-function
> >    trampoline requires multiple dispatchers (and tracking which one to
> >    use). Blows up text size A LOT.
> >
> >  | <func_trace_target_data_8B> # somewhere, but probably on a different=
 cacheline than the .text to avoid ping-ongs
> >  | ...
> >  | per_func_dispatch
> >  |   load <func_trace_target_data_8B> based on ra
> >  |   jalr
> >  | func:
> >  |   ...make sure ra isn't messed up...
> >  |   nop <=3D> jal # Text patch point -> per_func_dispatch
> >  |   ACTUAL_FUNC
>
> Brendan proposed yet another option, "in-function dispatch":
>
> D)
>   | <func_trace_target_data_8B_per_function> # idk somewhere
>   | ...
>   | func:
>   |    mv tmp1, ra
>   |    aupic tmp2, <func_trace_target_data_8B_per_function:upper>
>   |    mv tmp3, zero <=3D> ld tmp3, tmp2<func_trace_target_data_8B_per_fu=
nction:lower>
>   |    nop <=3D> jalr ra, tmp3
>   |    ACTUAL_FUNC

My patch series takes a similar "in-function dispatch" approach. A
difference is that the <func_trace_target_data_8B_per_function> is
embedded within each function entry. I'd like to have it moved to a
run-time allocated array to reduce total text size.

Another difference is that my series changes the first instruction to
"j ACTUAL_FUNC" for the "ftrace disable" case. As long as the
architecture guarantees the atomicity of the first instruction, then
we are safe. For example, we are safe if the first instruction could
only be "mv tmp, ra" or "j ACTUAL_FUNC". And since the loaded address is
always valid, we can fix "mv + jalr" down so we don't have to
play with the exception handler trick. The guarantee from arch would
require ziccif (in RVA22) though, but I think it is the same for us
(unless with stop_machine). For ziccif, I would rather call that out
during boot than blindly assume.

However, one thing I am not very sure is: do we need a destination
address in a "per-function" manner? It seems like most of the time the
destination address can only be ftrace_call, or ftrace_regs_call. If
the number of destination addresses is very few, then we could
potentially reduce the size of
<func_trace_target_data_8B_per_function>.

>
> There are 4 CMODX possiblities:
>    mv, nop:  fully disabled, no problems
>    mv, jalr: We will jump to zero. We would need to have the inst
>              page/access fault handler take care of this case. Especially
>              if we align the instructions so that they can be patched
>              together, being interrupted in the middle and taking this
>              path will be rare.
>   ld, nop:   no problems
>   ld, jalr:  fully enabled, no problems
>
> Patching is a 64b store/sd, and we only need a fence.i at the end, since
> we can handle all 4 possibilities.
>
> For the disabled case we'll have:
> A) mv, aupic, nop
> D) mv, aupic, mv, nop.
>
> Puranjay, I've flipped. Let's go Mark's CALL_OPS together with a new
> text patch mechanism w/o stop_machine().
>
>
> Bj=C3=B6rn

Cheers,
Andy

