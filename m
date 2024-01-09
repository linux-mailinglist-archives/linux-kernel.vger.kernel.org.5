Return-Path: <linux-kernel+bounces-21193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8638C828B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA50828248A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F5E3BB26;
	Tue,  9 Jan 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="Qvus/sT/"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFA3C466
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso3375008e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1704822853; x=1705427653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeM+hho/qwbP9Z55ZVvdC0wwc1f1sWXXK1EVcgFxsIo=;
        b=Qvus/sT/+nA2q0woVUrPGBWCFUKZL1B6aNU9v5fLikXcsQwJo1KYrMQbMRW5+x8FTh
         FJSweKrqHATBfo/S2KhJQadbhKb4MTTPxmVrXfQqLDDA3gKaJvrToCnpZtlgYz+eKrxn
         Wi7GytCXvj1sgHIjJiKHmUS9njp7n85HNz6Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822853; x=1705427653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeM+hho/qwbP9Z55ZVvdC0wwc1f1sWXXK1EVcgFxsIo=;
        b=MizVO2dQJIHNlzEp86/XdUKKG3AuvA2rmiKbHP1RPuRhgxCpUenHe24Eu3xUG5kVF3
         ixC/6jC0ecxKKqBgk03MX3jYwdolWBOF1DaMTCHrD2thdfoZgRFrriyNKvjp3fBEYK6C
         gEuq3OT4OB00jlw3ezOsFOyM6obfesT9OprUig5c1EyDjiwFfY5W7MwdyquruCO0rWiX
         ZKvZ7uvOYw9ORmYILPXx5zIO8Ob5kaOO84d7NG3uOusVZiEfQgHAROOsd1+3zFTCdu2Q
         8O67dn1KKYezytHEN6HpT7o+Tq977mc9ZoYSw/P1LpLyggWdyZd/GaLYJ1mq90JCeu6s
         O2cQ==
X-Gm-Message-State: AOJu0YxAoMXqEHLnXzBr/KcNRSKSlrq9UD2jD+f0DoCu4QbC4Y2RCfRI
	EmH9jUkZrYP6CpE3wwv3p58O8YKSQ5Jppok8+fSEuaurU/Dk
X-Google-Smtp-Source: AGHT+IH3m0+wbSzkJ3HS0+ZxHNhvZU64C2KWl2ZLlE00HvrrjpKMtf0cf5i3Ja1KwC83KNs3w46QjXNSKdQtgEFskAs=
X-Received: by 2002:a05:651c:2208:b0:2cd:52fd:9bb with SMTP id
 y8-20020a05651c220800b002cd52fd09bbmr1112283ljq.30.1704822852166; Tue, 09 Jan
 2024 09:54:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108-fencei-v5-0-aa1e51d7222f@rivosinc.com>
 <20240108-fencei-v5-2-aa1e51d7222f@rivosinc.com> <CAOnJCUJQ-M1bVC_VhogMLo47mRyk3Pzq-GFH5P7ADn70BN9ObA@mail.gmail.com>
 <ZZyth6Ijtsmy5D84@ghost> <CAOnJCUL60H16edo6icR-1bzTVk0Tdr+hRf3izharUEEvxCrwhA@mail.gmail.com>
In-Reply-To: <CAOnJCUL60H16edo6icR-1bzTVk0Tdr+hRf3izharUEEvxCrwhA@mail.gmail.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 9 Jan 2024 09:54:00 -0800
Message-ID: <CAOnJCU+FonOS4N_WiHPij4ZWv=qAdHo4WY9_+kzLT738CqhM1w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX
 prctl
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 11:51=E2=80=AFPM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Mon, Jan 8, 2024 at 6:20=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
> >
> > On Mon, Jan 08, 2024 at 05:24:47PM -0800, Atish Patra wrote:
> > > On Mon, Jan 8, 2024 at 10:42=E2=80=AFAM Charlie Jenkins <charlie@rivo=
sinc.com> wrote:
> > > >
> > > > Provide documentation that explains how to properly do CMODX in ris=
cv.
> > > >
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > ---
> > > >  Documentation/arch/riscv/cmodx.rst | 88 ++++++++++++++++++++++++++=
++++++++++++
> > > >  Documentation/arch/riscv/index.rst |  1 +
> > > >  2 files changed, 89 insertions(+)
> > > >
> > > > diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arc=
h/riscv/cmodx.rst
> > > > new file mode 100644
> > > > index 000000000000..afd7086c222c
> > > > --- /dev/null
> > > > +++ b/Documentation/arch/riscv/cmodx.rst
> > > > @@ -0,0 +1,88 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > +Concurrent Modification and Execution of Instructions (CMODX) for =
RISC-V Linux
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +CMODX is a programming technique where a program executes instruct=
ions that were
> > > > +modified by the program itself. Instruction storage and the instru=
ction cache
> > > > +(icache) are not guaranteed to be synchronized on RISC-V hardware.=
 Therefore, the
> > > > +program must enforce its own synchronization with the unprivileged=
 fence.i
> > > > +instruction.
> > > > +
> > > > +However, the default Linux ABI prohibits the use of fence.i in use=
rspace
> > > > +applications. At any point the scheduler may migrate a task onto a=
 new hart. If
> > > > +migration occurs after the userspace synchronized the icache and i=
nstruction
> > > > +storage with fence.i, the icache will no longer be clean. This is =
due to the
> > > > +behavior of fence.i only affecting the hart that it is called on. =
Thus, the hart
> > > > +that the task has been migrated to may not have synchronized instr=
uction storage
> > > > +and icache.
> > > > +
> > > > +There are two ways to solve this problem: use the riscv_flush_icac=
he() syscall,
> > > > +or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl() and emit fenc=
e.i in
> > > > +userspace. The syscall performs a one-off icache flushing operatio=
n. The prctl
> > > > +changes the Linux ABI to allow userspace to emit icache flushing o=
perations.
> > > > +
> > > > +prctl() Interface
> > > > +---------------------
> > > > +
> > > > +Call prctl() with ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` as the first a=
rgument. The
> > > > +remaining arguments will be delegated to the riscv_set_icache_flus=
h_ctx
> > > > +function detailed below.
> > > > +
> > > > +.. kernel-doc:: arch/riscv/mm/cacheflush.c
> > > > +       :identifiers: riscv_set_icache_flush_ctx
> > > > +
> > >
> > > Document the arguments of the prctl as well ?
> >
> > Do you mean to include the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` key in the
> > comment of riscv_set_icache_flush_ctx? The args to
> > riscv_set_icache_flush_ctx are the args to the prctl except for the key=
.
> >
>
> No, I mean describe the argument2(ctx) and argument3(per_thread) as well.
> Since this is a documentation of the new prctl, we should document all
> args so that an user
> can use it without grepping through the kernel sources.
>

Never mind. I missed the identifiers tag for kernel doc. Thanks for
the reminder.
The patch looks good to me.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

> > - Charlie
> >
> > >
> > > > +Example usage:
> > > > +
> > > > +The following files are meant to be compiled and linked with each =
other. The
> > > > +modify_instruction() function replaces an add with 0 with an add w=
ith one,
> > > > +causing the instruction sequence in get_value() to change from ret=
urning a zero
> > > > +to returning a one.
> > > > +
> > > > +cmodx.c::
> > > > +
> > > > +       #include <stdio.h>
> > > > +       #include <sys/prctl.h>
> > > > +
> > > > +       extern int get_value();
> > > > +       extern void modify_instruction();
> > > > +
> > > > +       int main()
> > > > +       {
> > > > +               int value =3D get_value();
> > > > +               printf("Value before cmodx: %d\n", value);
> > > > +
> > > > +               // Call prctl before first fence.i is called inside=
 modify_instruction
> > > > +               prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CT=
X_SW_FENCEI, 0);
> > > > +               modify_instruction();
> > > > +
> > > > +               value =3D get_value();
> > > > +               printf("Value after cmodx: %d\n", value);
> > > > +               return 0;
> > > > +       }
> > > > +
> > > > +cmodx.S::
> > > > +
> > > > +       .option norvc
> > > > +
> > > > +       .text
> > > > +       .global modify_instruction
> > > > +       modify_instruction:
> > > > +       lw a0, new_insn
> > > > +       lui a5,%hi(old_insn)
> > > > +       sw  a0,%lo(old_insn)(a5)
> > > > +       fence.i
> > > > +       ret
> > > > +
> > > > +       .section modifiable, "awx"
> > > > +       .global get_value
> > > > +       get_value:
> > > > +       li a0, 0
> > > > +       old_insn:
> > > > +       addi a0, a0, 0
> > > > +       ret
> > > > +
> > > > +       .data
> > > > +       new_insn:
> > > > +       addi a0, a0, 1
> > > > diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arc=
h/riscv/index.rst
> > > > index 4dab0cb4b900..eecf347ce849 100644
> > > > --- a/Documentation/arch/riscv/index.rst
> > > > +++ b/Documentation/arch/riscv/index.rst
> > > > @@ -13,6 +13,7 @@ RISC-V architecture
> > > >      patch-acceptance
> > > >      uabi
> > > >      vector
> > > > +    cmodx
> > > >
> > > >      features
> > > >
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > >
> > >
> > > --
> > > Regards,
> > > Atish
>
>
>
> --
> Regards,
> Atish



--=20
Regards,
Atish

