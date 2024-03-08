Return-Path: <linux-kernel+bounces-96737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E52298760D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151D91C21D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9966254FB1;
	Fri,  8 Mar 2024 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hTAUKyXS"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E154F8A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889515; cv=none; b=tC0tCovv0GunM9y/nFpqzcDVIpK11+Ui+YXxUb7+Kpdd/A/TlXbK7xercb2rJDWUh/nMhWwT7+TVpQYTVV2pX3CYu76x1izgyFRbGP+V41laNnqoPq57QJUf/Z553yBMlDt0azFhY5ojMKhueFXLYUSrkYFoVbzwbcZVvCUm0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889515; c=relaxed/simple;
	bh=5ejNPiOaFWIbilrKYemDWxW9fOdMB7ZE3uNO640hRds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiGq0Q7bNrJoTF9OJqVvWAZZkl9+AnENFvDXTmNcRbDic+BmPNyi2cam5Di1ee87uubPVHbB8/Jzb9k8W+2uySMLn3J6gv2bl0cNGBjR5glRXvTpP5oIg+En5h3mRShdcbbsdUk7foqFzBolSPTaMHa1T0clEILqyrdqRwJRvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hTAUKyXS; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso1370186276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709889513; x=1710494313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQfStgoadcJZ3LxQhxglAjLjX8LE9J04xgEnWvSiGZM=;
        b=hTAUKyXSr8AmXU/jmCNq2ATNoLix+SLg/snzS5IV2bBx6vm2Q8onxuNL35VnJrlGVf
         99kiYXZg6ngQbPIYLKZciSe0iaV7ghjlISrdl58YmkNGOU0urksHMw7qU0DRzbZpYwT4
         d9uotmtV1sCAhdKEtpWhRL6U61Uhnfo0sUzFHZL8zbsShDOE67tAphAVKaKzJS+ledqA
         7nmGmYbYoCgXfLaulyuGo8So/s2Pv8/zrP2u2tjqlMwI3LM8+PbjwKHvp8UG2xrGvubP
         9fkB2P+iucgd+JjrxpLy7dpPE8xvQwHIR4r1b7t2j5FI2LM3Xe9stdOCG209B1+iflIE
         Ozgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709889513; x=1710494313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQfStgoadcJZ3LxQhxglAjLjX8LE9J04xgEnWvSiGZM=;
        b=sbTBQm8e8Aj5OsXX6xhSgc6oCIW/3+7Om2/NyDU0PIHsrR2LXXvVOgTaEJjRS6MlUN
         ouZJuRfCHZ4HEyPFY3T41klAapsk3VH/Pp/+vDuUfS9BUtR3WJG4A5Ugoh+AD4RsCxe1
         JFkvdOS0/NqTgdBwFyiHBV+/kWJRHhIJHfuas+Vrbho5hAoFnjdxXToore7NrZ5gTVAQ
         /5y01Sot+l4SZWjRSkt0DIbeajlJq5312/raKL3lbHzChsnMOcqshrj18wGAOMbcW4Jn
         KCtpmIbLU6LmF0rYd7GVDv1ARiX3HXY1eUpf5YmFW+rpN1JxQ8NgSoI6tkApcUdARTUW
         Eecg==
X-Forwarded-Encrypted: i=1; AJvYcCXQz6ZEuhuhkfv3x1UIx8/wIvBwPmI40jJGDQsvuxwKkV4ulfUTrnkJncksIIjasY4rAvcvxkUEaNmWfRbteJwT86znJBBmnS2YCgJo
X-Gm-Message-State: AOJu0YwWFAnr5l3np4K67XCsB6lMFRgOqhoqFjBDWNwA85BrO9ZT/+t6
	EdtlTW1hZQo+yYj/jinUNgzWRbPBw9lTM3HoTSe9n25BekHA8lkQe48jbKVdtQH50d50RbSTgYY
	6AgCK2vYqlLTtvorrel+/qQFeJhcDmjG5yJoPtA==
X-Google-Smtp-Source: AGHT+IFOh/fbBZAoKlAXSCLWZ4Jp1GE+8bu4ic4VOQKef5vFu/0bqlMTN31Em7LyWY4axsAp+J3ERv4eJUIdxxYPPyE=
X-Received: by 2002:a25:d34d:0:b0:dc7:45d3:ffd0 with SMTP id
 e74-20020a25d34d000000b00dc745d3ffd0mr18528744ybf.1.1709889512914; Fri, 08
 Mar 2024 01:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306165904.108141-1-puranjay12@gmail.com> <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <CANk7y0gbQdYw0V+CEv-z8wFGXnki8KSn4c8+i0iZ1UFNCg7wJQ@mail.gmail.com>
In-Reply-To: <CANk7y0gbQdYw0V+CEv-z8wFGXnki8KSn4c8+i0iZ1UFNCg7wJQ@mail.gmail.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 8 Mar 2024 17:18:21 +0800
Message-ID: <CABgGipUJU_joVOjPi4WZ4JJM72zaSrCA1QUAaP8hob3+LXkS0g@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Guo Ren <guoren@kernel.org>, 
	Ley Foon Tan <leyfoon.tan@starfivetech.com>, Deepak Gupta <debug@rivosinc.com>, 
	Sia Jee Heng <jeeheng.sia@starfivetech.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Song Shuai <suagrfillet@gmail.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Puranjay,

On Fri, Mar 8, 2024 at 3:53=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> Hi Bj=C3=B6rn,
>
> On Thu, Mar 7, 2024 at 8:27=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
> >
> > Puranjay!
> >
> > Puranjay Mohan <puranjay12@gmail.com> writes:
> >
> > > This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V=
.
> > > This allows each ftrace callsite to provide an ftrace_ops to the comm=
on
> > > ftrace trampoline, allowing each callsite to invoke distinct tracer
> > > functions without the need to fall back to list processing or to
> > > allocate custom trampolines for each callsite. This significantly spe=
eds
> > > up cases where multiple distinct trace functions are used and callsit=
es
> > > are mostly traced by a single tracer.
> > >
> > > The idea and most of the implementation is taken from the ARM64's
> > > implementation of the same feature. The idea is to place a pointer to
> > > the ftrace_ops as a literal at a fixed offset from the function entry
> > > point, which can be recovered by the common ftrace trampoline.
> >
> > Not really a review, but some more background; Another rationale (on-to=
p
> > of the improved per-call performance!) for CALL_OPS was to use it to
> > build ftrace direct call support (which BPF uses a lot!). Mark, please
> > correct me if I'm lying here!
> >
> > On Arm64, CALL_OPS makes it possible to implement direct calls, while
> > only patching one BL instruction -- nice!
> >
> > On RISC-V we cannot use use the same ideas as Arm64 straight off,
> > because the range of jal (compare to BL) is simply too short (+/-1M).
> > So, on RISC-V we need to use a full auipc/jal pair (the text patching
> > story is another chapter, but let's leave that aside for now). Since we
> > have to patch multiple instructions, the cmodx situation doesn't really
> > improve with CALL_OPS.
> >
> > Let's say that we continue building on your patch and implement direct
> > calls on CALL_OPS for RISC-V as well.
> >
> > From Florent's commit message for direct calls:
> >
> >   |    There are a few cases to distinguish:
> >   |    - If a direct call ops is the only one tracing a function:
> >   |      - If the direct called trampoline is within the reach of a BL
> >   |        instruction
> >   |         -> the ftrace patchsite jumps to the trampoline
> >   |      - Else
> >   |         -> the ftrace patchsite jumps to the ftrace_caller trampoli=
ne which
> >   |            reads the ops pointer in the patchsite and jumps to the =
direct
> >   |            call address stored in the ops
> >   |    - Else
> >   |      -> the ftrace patchsite jumps to the ftrace_caller trampoline =
and its
> >   |         ops literal points to ftrace_list_ops so it iterates over a=
ll
> >   |         registered ftrace ops, including the direct call ops and ca=
lls its
> >   |         call_direct_funcs handler which stores the direct called
> >   |         trampoline's address in the ftrace_regs and the ftrace_call=
er
> >   |         trampoline will return to that address instead of returning=
 to the
> >   |         traced function
> >
> > On RISC-V, where auipc/jalr is used, the direct called trampoline would
> > always be reachable, and then first Else-clause would never be entered.
> > This means the the performance for direct calls would be the same as th=
e
> > one we have today (i.e. no regression!).
> >
> > RISC-V does like x86 does (-ish) -- patch multiple instructions, long
> > reach.
> >
> > Arm64 uses CALL_OPS and patch one instruction BL.
> >
> > Now, with this background in mind, compared to what we have today,
> > CALL_OPS would give us (again assuming we're using it for direct calls)=
:
> >
> > * Better performance for tracer per-call (faster ops lookup) GOOD
>
> ^ this was the only motivation for me to implement this patch.
>
> I don't think implementing direct calls over call ops is fruitful for
> RISC-V because once
> the auipc/jalr can be patched atomically, the direct call trampoline
> is always reachable.

Yes, the auipc/jalr instruction pair can be patched atomically just as
long as their size is naturally aligned on. However, we cannot prevent
2 instructions from being fetched atomically :P

> Solving the atomic text patching problem would be fun!! I am eager to
> see how it will be
> solved.

I have a patch series to solve the atomic code patching issue, which I
am about to respin [1]. The idea is to solve it with yet another layer
of indirection. We add a 8-B aligned space at each function entry. The
space is a pointer to the ftrace entry. During boot, each function
entry code is updated to perform a load and then take the jump from
the 8-B space. When ftrace is disabled, we patch the first 4B-aligned
instruction to a jump so as to skip the ftrace entry.

We are still discussing with Alex to see if we have a better way to do
it. If not then I'd update the patchset and re-send it. There's a
pending improvement in the series to reduce complexity. The 8-B
aligned space can be added before the function entry (just like your
patch).

>
> > * Larger text size (function alignment + extra nops) BAD
> > * Same direct call performance NEUTRAL
> > * Same complicated text patching required NEUTRAL
> >
> > It would be interesting to see how the per-call performance would
> > improve on x86 with CALL_OPS! ;-)
>
> If I remember from Steven's talk, x86 uses dynamically allocated trampoli=
nes
> for per callsite tracers, would CALL_OPS provide better performance than =
that?
>
> >
> > I'm trying to wrap my head if it makes sense to have it on RISC-V, give=
n
> > that we're a bit different from Arm64. Does the scale tip to the GOOD
> > side?
> >
> > Oh, and we really need to see performance numbers on real HW! I have a
> > VF2 that I could try this series on.
>
> It would be great if you can do it :D.
>
> Thanks,
> Puranjay
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

- [1] https://yhbt.net/lore/all/CAJF2gTSn3_cDYsF9D8dt-br2Wf_M8y02A09xgRq8kX=
i91sN3Aw@mail.gmail.com/T/

Regards,
Andy

