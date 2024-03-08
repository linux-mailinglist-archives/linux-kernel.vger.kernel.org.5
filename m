Return-Path: <linux-kernel+bounces-96695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB387601B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A856B24DDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08329CFB;
	Fri,  8 Mar 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gvv0H5y9"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270B208AD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887747; cv=none; b=SCPsVhLBMsdQjvoA4mx7LNZ9ZzKXhoyUfyjbT9X+G8RBNvz6NCg57Ppx3RTAMiM2WOtPuLyrR5e0uoqG3aPOYZkn4hU1UD2cruNN8ssJjIPj5r/14tG9p0OPMesL49czh3yqBsq1RfUvW1E0xkU8m7CcKeqOW2mkTHk2ugOQiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887747; c=relaxed/simple;
	bh=p1DGgTwhlI1P1zl4hSg/A5LZIfKJVRgVKiN/oCP3hBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyOxSkiOiTOKcC/Cqt6N9ORqK5KrYS18VetDz/tUteMmM+WYr9H83BKdmmnolgUN+M74JL83XwsvfxjJyYypvbMF0I9eolEw0+lPBVmUiwcGbrZ7j2J69UJMV7M+JD59G05J9tJceJTJFd8diVo6uYMF8aFHrq0T5I70rQc9FFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gvv0H5y9; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so645770276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 00:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709887744; x=1710492544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjMdeifauFFX0ztwHg+02PgyxXha91zTywHbRxorn20=;
        b=gvv0H5y931hExaOcBzX1m8DAN9YPRj8/NqkJrYHfQuRdcTzHerVzdkYy3b1i+NVvm3
         ThaNEUnOBsMUG9y9lWxOsLbvJOtT2E/YvnRLhvTXL3U5T+5mQCFFotx56866DtX3E9Sj
         QUNAlngcASUpiS3CXye36AL+eJFBrmdGUyVhLSZOoxMi3mCR3VMpWiIh/dYgfGnJOmL1
         vSRPi1CYnHFaSwuO7aJW29w/T/6dy2Ge3B5uEJm/AZ8h+jYJuXO+1TDY7FSjNXrbYZMg
         cuJ1KqLYLUhMco2aAqxQPz1FiaH1RSmv74kq4tcLObAhQRM6oQd/qaFJeWbrjFTUjYEv
         KlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709887744; x=1710492544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjMdeifauFFX0ztwHg+02PgyxXha91zTywHbRxorn20=;
        b=De7cpFQz2ffxIb8LuriB5d8U7Q6Fsr88rIuwCLYX939pW2E+Vfz/cQ51AT2jv0Vbt+
         VATIWHwGWZibcgDjs31x+LLNDunqJmFwRv58I2B2ss2MFHB3yAmmgHrWexCnvRpVwKr/
         UZeS5YJ1qCwG3hBHtln5fkUYvRDUZnPxF1YUV/WRVWYdUTUdfKJwAxdUf/d7gJZ3FKCG
         7Yw5sv1SpYo67q3DqYMx6DfKp5kQZvuLMMiusC9o21Spp38KwCQ5sqQkYv3SI9qiJwFP
         8WcdcJmUccv25iqMsX3riwXh5gCDRr+9onlfa5qdAUy8Gjbxgk4xKtHCiTP4OandZQom
         8xJg==
X-Forwarded-Encrypted: i=1; AJvYcCW1dHO3HJ2Mtb2OD74zlND86LpKrkQwLN4S9cgmHqp0sqh6WsCPM25vlXiEa7qg5FHMM5DCFdDu2tIRLd/oS/Q/7RTJXkrBaQ2qnF9F
X-Gm-Message-State: AOJu0YxdId4ORFp3TmvMbfw5oL+ruHMmDYmKphPjokFEgHBpTGr+a677
	Q7rx1c2YR17ut4rTvvb7yv5WDZURErtQFkE07N79Vd8Brx5Wc34BxVonCRuidM3W0yin4LV6aT6
	VfM9arVcvqk3R8DlX+j/3J7YVNn+x3RPmEIGNLA==
X-Google-Smtp-Source: AGHT+IFnaTedNwwzhlvVq+X0WG6IJ09kWtyousiLexTeokG9oBiFC/uLVZ6WGg6Am/YuzONgEMN9pIeoEwf/reRV5lU=
X-Received: by 2002:a25:d697:0:b0:dc2:398b:fa08 with SMTP id
 n145-20020a25d697000000b00dc2398bfa08mr19391957ybg.31.1709887744419; Fri, 08
 Mar 2024 00:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306165904.108141-1-puranjay12@gmail.com> <34c9d54a-0f19-4671-8b05-9adf3b6c9a1a@ghiti.fr>
 <CANk7y0jO5dysnsazCq-r=G-EvWUPTwQaW257PcqEbq8SvVRf2Q@mail.gmail.com>
In-Reply-To: <CANk7y0jO5dysnsazCq-r=G-EvWUPTwQaW257PcqEbq8SvVRf2Q@mail.gmail.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 8 Mar 2024 16:48:53 +0800
Message-ID: <CABgGipUou53koSDuCODiB5gTs96iKZayCkqgQUbDngoT_b+ifA@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
	Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Song Shuai <suagrfillet@gmail.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 8:19=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> Hi Alex,
>
> On Wed, Mar 6, 2024 at 9:35=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
> >
> > Hi Puranjay,
> >
> > On 06/03/2024 17:59, Puranjay Mohan wrote:
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
> > >
> > > We use -fpatchable-function-entry to reserve 8 bytes above the functi=
on
> > > entry by emitting 2 4 byte or 4 2 byte  nops depending on the presenc=
e of
> > > CONFIG_RISCV_ISA_C. These 8 bytes are patched at runtime with a point=
er
> > > to the associated ftrace_ops for that callsite. Functions are aligned=
 to
> > > 8 bytes to make sure that the accesses to this literal are atomic.
> > >
> > > This approach allows for directly invoking ftrace_ops::func even for
> > > ftrace_ops which are dynamically-allocated (or part of a module),
> > > without going via ftrace_ops_list_func.
> > >
> > > I've benchamrked this with the ftrace_ops sample module on Qemu, with
> > > the next version, I will provide benchmarks on real hardware:
> > >
> > > Without this patch:
> > >
> > > +-----------------------+-----------------+--------------------------=
--+
> > > |  Number of tracers    | Total time (ns) | Per-call average time    =
  |
> > > |-----------------------+-----------------+--------------------------=
--|
> > > | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns=
) |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        0 |          0 |        15615700 |        156 |             =
- |
> > > |        0 |          1 |        15917600 |        159 |             =
- |
> > > |        0 |          2 |        15668000 |        156 |             =
- |
> > > |        0 |         10 |        14971500 |        149 |             =
- |
> > > |        0 |        100 |        15417600 |        154 |             =
- |
> > > |        0 |        200 |        15387000 |        153 |             =
- |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        1 |          0 |       119906800 |       1199 |          104=
3 |
> > > |        1 |          1 |       137428600 |       1374 |          121=
8 |
> > > |        1 |          2 |       159562400 |       1374 |          121=
8 |
> > > |        1 |         10 |       302099900 |       3020 |          286=
4 |
> > > |        1 |        100 |      2008785500 |      20087 |         1993=
1 |
> > > |        1 |        200 |      3965221900 |      39652 |         3949=
6 |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        1 |          0 |       119166700 |       1191 |          103=
5 |
> > > |        2 |          0 |       157999900 |       1579 |          142=
3 |
> > > |       10 |          0 |       425370100 |       4253 |          409=
7 |
> > > |      100 |          0 |      3595252100 |      35952 |         3579=
6 |
> > > |      200 |          0 |      7023485700 |      70234 |         7007=
8 |
> > > +----------+------------+-----------------+------------+-------------=
--+
> > >
> > > Note: per-call overhead is estimated relative to the baseline case wi=
th
> > > 0 relevant tracers and 0 irrelevant tracers.
> > >
> > > With this patch:
> > >
> > > +-----------------------+-----------------+--------------------------=
--+
> > > |   Number of tracers   | Total time (ns) | Per-call average time    =
  |
> > > |-----------------------+-----------------+--------------------------=
--|
> > > | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns=
) |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        0 |          0 |        15254600 |        152 |             =
- |
> > > |        0 |          1 |        16136700 |        161 |             =
- |
> > > |        0 |          2 |        15329500 |        153 |             =
- |
> > > |        0 |         10 |        15148800 |        151 |             =
- |
> > > |        0 |        100 |        15746900 |        157 |             =
- |
> > > |        0 |        200 |        15737400 |        157 |             =
- |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        1 |          0 |        47909000 |        479 |           32=
7 |
> > > |        1 |          1 |        48297400 |        482 |           33=
0 |
> > > |        1 |          2 |        47314100 |        473 |           32=
1 |
> > > |        1 |         10 |        47844900 |        478 |           32=
6 |
> > > |        1 |        100 |        46591900 |        465 |           31=
3 |
> > > |        1 |        200 |        47178900 |        471 |           31=
9 |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        1 |          0 |        46715800 |        467 |           31=
5 |
> > > |        2 |          0 |       155134500 |       1551 |          139=
9 |
> > > |       10 |          0 |       442672800 |       4426 |          427=
4 |
> > > |      100 |          0 |      4092353900 |      40923 |         4077=
1 |
> > > |      200 |          0 |      7135796400 |      71357 |         7120=
5 |
> > > +----------+------------+-----------------+------------+-------------=
--+
> > >
> > > Note: per-call overhead is estimated relative to the baseline case wi=
th
> > > 0 relevant tracers and 0 irrelevant tracers.
> > >
> > > As can be seen from the above:
> > >
> > >   a) Whenever there is a single relevant tracer function associated w=
ith a
> > >      tracee, the overhead of invoking the tracer is constant, and doe=
s not
> > >      scale with the number of tracers which are *not* associated with=
 that
> > >      tracee.
> > >
> > >   b) The overhead for a single relevant tracer has dropped to ~1/3 of=
 the
> > >      overhead prior to this series (from 1035ns to 315ns). This is la=
rgely
> > >      due to permitting calls to dynamically-allocated ftrace_ops with=
out
> > >      going through ftrace_ops_list_func.
> > >
> > > Why is this patch a RFC patch:
> > >   1. I saw some rcu stalls on Qemu and need to debug them and see if =
they
> > >      were introduced by this patch.
> >
> >
> > FYI, I'm currently working on debugging such issues (and other) with th=
e
> > *current* ftrace implementation, so probably not caused by your
> > patchset. But keep debugging too, maybe this introduces other issues or
> > even better, you'll find the root cause :)
> >
> >
> > >   2. This needs to be tested thoroughly on real hardware.
> > >   3. Seeking reviews to fix any fundamental problems with this patch =
that I
> > >      might have missed due to my lack of RISC-V architecture knowledg=
e.
> > >   4. I would like to benchmark this on real hardware and put the resu=
lts in
> > >      the commit message.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > ---
> > >   arch/riscv/Kconfig              |  2 ++
> > >   arch/riscv/Makefile             |  8 +++++
> > >   arch/riscv/include/asm/ftrace.h |  3 ++
> > >   arch/riscv/kernel/asm-offsets.c |  3 ++
> > >   arch/riscv/kernel/ftrace.c      | 59 ++++++++++++++++++++++++++++++=
+++
> > >   arch/riscv/kernel/mcount-dyn.S  | 42 ++++++++++++++++++++---
> > >   6 files changed, 112 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 0bfcfec67ed5..e474742e23b2 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -78,6 +78,7 @@ config RISCV
> > >       select EDAC_SUPPORT
> > >       select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYN=
AMIC_FTRACE)
> > >       select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FT=
RACE
> > > +     select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
> >
> >
> > A recent discussion [1] states that -falign-functions cannot guarantee
> > this alignment for all code and that gcc developers came up with a new
> > option [2]: WDYT? I have added Andy and Evgenii in +cc to help on that.
>
> I saw arm64 uses the same and assumes this guarantee, maybe it is broken =
too?
> Will look into the discussion and try to use the other option. I am
> currently using Clang to build the kernel.

IIRC it should be fine if you're building with Clang. The
"-falign-function" flag for gcc is not aligning cold functions. So I
think we'd need some Kconfig checks for the difference.

>
> >
> > [1]
> > https://lore.kernel.org/linux-riscv/4fe4567b-96be-4102-952b-7d39109b218=
6@yadro.com/
> > [2]
> > https://gcc.gnu.org/git/gitweb.cgi?p=3Dgcc.git;h=3D0f5a9a00e3ab1fe96142=
f304cfbcf3f63b15f326
> >
> >
> > >       select GENERIC_ARCH_TOPOLOGY
> > >       select GENERIC_ATOMIC64 if !64BIT
> > >       select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> > > @@ -127,6 +128,7 @@ config RISCV
> > >       select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPP=
ORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
> > >       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > >       select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > > +     select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_WIT=
H_REGS && !CFI_CLANG)
> > >       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > >       select HAVE_FUNCTION_GRAPH_TRACER
> > >       select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
> > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > index 252d63942f34..875ad5dc3d32 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -14,12 +14,20 @@ endif
> > >   ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
> > >       LDFLAGS_vmlinux +=3D --no-relax
> > >       KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> > > +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS), y)
> > > +ifeq ($(CONFIG_RISCV_ISA_C),y)
> > > +     CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D8,4
> > > +else
> > > +     CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4,2
> > > +endif
> > > +else
> > >   ifeq ($(CONFIG_RISCV_ISA_C),y)
> > >       CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4
> > >   else
> > >       CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
> > >   endif
> > >   endif
> > > +endif
> > >
> > >   ifeq ($(CONFIG_CMODEL_MEDLOW),y)
> > >   KBUILD_CFLAGS_MODULE +=3D -mcmodel=3Dmedany
> > > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm=
/ftrace.h
> > > index 329172122952..c9a84222c9ea 100644
> > > --- a/arch/riscv/include/asm/ftrace.h
> > > +++ b/arch/riscv/include/asm/ftrace.h
> > > @@ -28,6 +28,9 @@
> > >   void MCOUNT_NAME(void);
> > >   static inline unsigned long ftrace_call_adjust(unsigned long addr)
> > >   {
> > > +     if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> > > +             return addr + 8;
> > > +
> > >       return addr;
> > >   }
> > >
> > > diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-=
offsets.c
> > > index a03129f40c46..7d7c4b486852 100644
> > > --- a/arch/riscv/kernel/asm-offsets.c
> > > +++ b/arch/riscv/kernel/asm-offsets.c
> > > @@ -488,4 +488,7 @@ void asm_offsets(void)
> > >       DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe=
), STACK_ALIGN));
> > >       OFFSET(STACKFRAME_FP, stackframe, fp);
> > >       OFFSET(STACKFRAME_RA, stackframe, ra);
> > > +#ifdef CONFIG_FUNCTION_TRACER
> > > +     DEFINE(FTRACE_OPS_FUNC,         offsetof(struct ftrace_ops, fun=
c));
> > > +#endif
> > >   }
> > > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > > index f5aa24d9e1c1..e2e75e15d32e 100644
> > > --- a/arch/riscv/kernel/ftrace.c
> > > +++ b/arch/riscv/kernel/ftrace.c
> > > @@ -82,9 +82,52 @@ static int __ftrace_modify_call(unsigned long hook=
_pos, unsigned long target,
> > >       return 0;
> > >   }
> > >
> > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > > +static const struct ftrace_ops *riscv64_rec_get_ops(struct dyn_ftrac=
e *rec)
> > > +{
> > > +     const struct ftrace_ops *ops =3D NULL;
> > > +
> > > +     if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
> > > +             ops =3D ftrace_find_unique_ops(rec);
> > > +             WARN_ON_ONCE(!ops);
> > > +     }
> > > +
> > > +     if (!ops)
> > > +             ops =3D &ftrace_list_ops;
> > > +
> > > +     return ops;
> > > +}
> > > +
> > > +static int ftrace_rec_set_ops(const struct dyn_ftrace *rec,
> > > +                           const struct ftrace_ops *ops)
> > > +{
> > > +     unsigned long literal =3D rec->ip - 8;
> > > +
> > > +     return patch_text_nosync((void *)literal, &ops, sizeof(ops));
>
> ^^
> I will change this to use a new function that does a 64 bit write and
> doesn't do flush_icache_range() as naturally aligned writes are
> atomic and therefore synchronization is not required here.

Yes, it's atomic. But it doesn't guarantee ordering if fence.i is not
executed, IIUC. I am not sure if CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
assumes seeing the updated ftrace_rec argument right after the patch
completes. If that is the case then probably a batched fence.i is
needed on local + remote cores.

>
> > > +}
> > > +
> > > +static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec)
> > > +{
> > > +     return ftrace_rec_set_ops(rec, &ftrace_nop_ops);
> > > +}
> > > +
> > > +static int ftrace_rec_update_ops(struct dyn_ftrace *rec)
> > > +{
> > > +     return ftrace_rec_set_ops(rec, riscv64_rec_get_ops(rec));
> > > +}
> > > +#else
> > > +static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec) { return 0=
; }
> > > +static int ftrace_rec_update_ops(struct dyn_ftrace *rec) { return 0;=
 }
> > > +#endif
> > > +
> > >   int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> > >   {
> > >       unsigned int call[2];
> > > +     int ret;
> > > +
> > > +     ret =3D ftrace_rec_update_ops(rec);
> > > +     if (ret)
> > > +             return ret;
> > >
> > >       make_call_t0(rec->ip, addr, call);
> > >
> > > @@ -98,6 +141,11 @@ int ftrace_make_nop(struct module *mod, struct dy=
n_ftrace *rec,
> > >                   unsigned long addr)
> > >   {
> > >       unsigned int nops[2] =3D {NOP4, NOP4};
> > > +     int ret;
> > > +
> > > +     ret =3D ftrace_rec_set_nop_ops(rec);
> > > +     if (ret)
> > > +             return ret;
> > >
> > >       if (patch_text_nosync((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
> > >               return -EPERM;
> > > @@ -125,6 +173,13 @@ int ftrace_init_nop(struct module *mod, struct d=
yn_ftrace *rec)
> > >
> > >   int ftrace_update_ftrace_func(ftrace_func_t func)
> > >   {
> > > +     /*
> > > +      * When using CALL_OPS, the function to call is associated with=
 the
> > > +      * call site, and we don't have a global function pointer to up=
date.
> > > +      */
> > > +     if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> > > +             return 0;
> > > +
> > >       int ret =3D __ftrace_modify_call((unsigned long)&ftrace_call,
> > >                                      (unsigned long)func, true, true)=
;
> > >       if (!ret) {
> > > @@ -147,6 +202,10 @@ int ftrace_modify_call(struct dyn_ftrace *rec, u=
nsigned long old_addr,
> > >       make_call_t0(caller, old_addr, call);
> > >       ret =3D ftrace_check_current_call(caller, call);
> > >
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D ftrace_rec_update_ops(rec);
> > >       if (ret)
> > >               return ret;
> > >
> > > diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcoun=
t-dyn.S
> > > index b7561288e8da..cb241e36e514 100644
> > > --- a/arch/riscv/kernel/mcount-dyn.S
> > > +++ b/arch/riscv/kernel/mcount-dyn.S
> > > @@ -191,11 +191,35 @@
> > >       .endm
> > >
> > >       .macro PREPARE_ARGS
> > > -     addi    a0, t0, -FENTRY_RA_OFFSET
> > > +     addi    a0, t0, -FENTRY_RA_OFFSET       // ip (callsite's auipc=
 insn)
> > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > > +     /*
> > > +      * When CALL_OPS is enabled (2 or 4) nops [8B] are placed befor=
e the
> > > +      * function entry, these are later overwritten with the pointer=
 to the
> > > +      * associated struct ftrace_ops.
> > > +      *
> > > +      * -8: &ftrace_ops of the associated tracer function.
> > > +      *<ftrace enable>:
> > > +      *  0: auipc  t0/ra, 0x?
> > > +      *  4: jalr   t0/ra, ?(t0/ra)
> > > +      *
> > > +      * -8: &ftrace_nop_ops
> > > +      *<ftrace disable>:
> > > +      *  0: nop
> > > +      *  4: nop
> > > +      *
> > > +      * t0 is set to ip+8 after the jalr is executed at the callsite=
,
> > > +      * so we find the associated op at t0-16.
> > > +      */
> > > +     mv      a1, ra                          // parent_ip
> > > +     REG_L   a2, -16(t0)                     // op
> > > +     REG_L   ra, FTRACE_OPS_FUNC(a2)         // op->func
> > > +#else
> > >       la      a1, function_trace_op
> > > -     REG_L   a2, 0(a1)
> > > -     mv      a1, ra
> > > -     mv      a3, sp
> > > +     REG_L   a2, 0(a1)                       // op
> > > +     mv      a1, ra                          // parent_ip
> > > +#endif
> > > +     mv      a3, sp                          // regs
> > >       .endm
> > >
> > >   #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > > @@ -233,8 +257,12 @@ SYM_FUNC_START(ftrace_regs_caller)
> > >       SAVE_ABI_REGS 1
> > >       PREPARE_ARGS
> > >
> > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > > +     jalr ra
> > > +#else
> > >   SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
> > >       call    ftrace_stub
> > > +#endif
> > >
> > >       RESTORE_ABI_REGS 1
> > >       bnez    t1, .Ldirect
> > > @@ -247,9 +275,13 @@ SYM_FUNC_START(ftrace_caller)
> > >       SAVE_ABI_REGS 0
> > >       PREPARE_ARGS
> > >
> > > -SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>
> ^^ this hunk is a mistake, I will fix it in the next version.
>
> > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > > +     jalr ra
> > > +#else
> > > +SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
> > >       call    ftrace_stub
> > >
> > > +#endif
> > >       RESTORE_ABI_REGS 0
> > >       jr      t0
> > >   SYM_FUNC_END(ftrace_caller)
> >
> >
> > As I'm diving into ftrace right now, I'll give a proper review soon. Bu=
t
> > as a note, I noticed that the function_graph tracer, when enabled, make=
s
> > the whole system unresponsive (but still up, just very slow). A fix I
> > sent recently seems to really improve that if you're interested in
> > testing it (I am :)). You can find it here:
> > https://lore.kernel.org/linux-riscv/20240229121056.203419-1-alexghiti@r=
ivosinc.com/
>
> I saw the same issue where function_graph was making the system slow on Q=
emu.
> What hardware do you use for testing? or are you testing on Qemu as well?
>
> I tested your patch, it speeds up the process of patching the
> instructions so the following
> command completes ~2.5 seconds faster compared to without your patch.
> $ time echo function_graph > current_tracer
>
> But at runtime the system is still slow and laggy with function_graph,
> I guess because my
> Qemu setup is not powerful enough to run function_graph.
>
> Thanks,
> Puranjay
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

