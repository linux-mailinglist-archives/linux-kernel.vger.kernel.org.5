Return-Path: <linux-kernel+bounces-122868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C52F388FEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF3F28E5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FED7EEF6;
	Thu, 28 Mar 2024 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NTNWV+Rm"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D6651AB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627783; cv=none; b=G0Qc0YA2eUKohmsCiGI/Eio1dN9GiZo9LOzUICl2kGhzsumlEerEq1kEMl0HDvz/e2ovrd7kRHGWex0ckOlPcjrYXkHmQORM/MhQ79sYp6ghVk/crWtMxcvK5dzfdB26+ac9LHIXokD7opMWR0INwHMAvT44tNypGvGfEsad5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627783; c=relaxed/simple;
	bh=vnx4g3owfrYya81NQeB0zYvkAR4Dw7dFzjBLlvRWxFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHMlmNMplzugjAMC1Vrh7JluAbUHNM2uyWXeROB+FBEUbyD/vkrR6xHtOq22cZXYHPRkBqughvujldtKgxgvQG3WGDW50jsirMLkw9XvseoNSQA43BI/ALuysnJxF2Whb+AHJEBolmPQW1ciluF96gFPSEQNw80IcxcvlswriYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NTNWV+Rm; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-229d01e81f1so451814fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711627780; x=1712232580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WXWD1P2EUdUvDGnk7t3ymrWbjSRue1eZVAHGlT2jeU=;
        b=NTNWV+Rmdz073utZqUJeJlRc5YISp5nxuAM1a+b1a86Qmt0AcpfH8uNSik8jUDVVTR
         452ZPuOJmGISHTR3r9immtawqjO3Ard2FNa3weN651/Lfi9CSn26lVIEv9HgxtzG02At
         WNF0g8+MZKjfqZl50p2NNsg5aMM+pNvbm7e0bO82C3NhICP3upEo2S72uCrfrVQWzE0z
         p9JqThRiv7UlQmIcU8wiVLNccZJ0afY1IYKGG1lUg4mrwdpIpKWroixn/3EhTfeniKOL
         7jzoxggJwVaEawpY1cLrKbC1aHFWIQnh2F2zG2VRwZ+6dGcyTki5AYaCH4SMWgB21Xx3
         R6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711627780; x=1712232580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WXWD1P2EUdUvDGnk7t3ymrWbjSRue1eZVAHGlT2jeU=;
        b=tCvtofolvusIcI9/MoDUf7RSN06KTTdbjX8UAlSMi1ofW2hg29QMF3DlChgz0M8TK1
         SPw12ybzih77w0DULH0yiptBJjDbOeJB4qMeIz+rztIGRSZhDiTm+EzhtECpQpVGhBM/
         igm9uo72WqDBkqwAoQeoptZ63fOhvK3tiLK3jKl0/LK8VAEo1c/EwNZyAX3pyfL4X1gz
         HWpkmG7Z3crzrjQ+hdi/35HZYIak6w0djPycDMfwKdYIpIHHbndLr/Yu55//OWSkfUOf
         W/L1dEY3sxMluasYxQDzK1OlYUKil5taHQsHNVSPxmkjLs+Aj98kPwa16SlgI34fWlSI
         Qu1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5K+7KlGje3LDVyQW2BnHHAmwmnkPzlBzN3wQT7A9bg0sZ5wGpQZ4Eo3mkLz7JSa6fzprtZGs270lri32H1W3yZ5fOfrhTZM301vHI
X-Gm-Message-State: AOJu0YzNtdVKwaroZtEt1589utulX025ypUa1DiPrYUu59M2vm9BsDdx
	rrcKop8lj5mZK4berzVY77FssiYeyFtD4nPm9TF3ig9ht40CQq1xEws7pAusJaKdIr1munwK7tS
	clHIay1J8NOhkHYSAoD7nuB1waWSupGuBN/Z5qg==
X-Google-Smtp-Source: AGHT+IG6KMSsNTaCJ4B801uxGRphzA7peDuz6U9DvVc2Nrjue29uyXVo1+rBJ4jLm7c2h0TDErvLIdg+N+zr8LbQtwE=
X-Received: by 2002:a05:6870:510:b0:22b:a8f3:36b7 with SMTP id
 j16-20020a056870051000b0022ba8f336b7mr24986oao.55.1711627780242; Thu, 28 Mar
 2024 05:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327061258.2370291-1-sorear@fastmail.com> <CAEEQ3w=yNEktgUucmKuUvqfwDYYztVX+jofi5Q7hG-yQWcLbTA@mail.gmail.com>
 <234c458c-15f1-423f-a2fd-0abfc6232c66@app.fastmail.com>
In-Reply-To: <234c458c-15f1-423f-a2fd-0abfc6232c66@app.fastmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 28 Mar 2024 20:09:29 +0800
Message-ID: <CAEEQ3wm3pJmAndvW1FvH0x2kKNsD8q2-TykasYdNqB1njk-R9A@mail.gmail.com>
Subject: Re: [External] [PATCH] riscv: process: Fix kernel gp leakage
To: "Stefan O'Rear" <sorear@fastmail.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Thu, Mar 28, 2024 at 12:54=E2=80=AFAM Stefan O'Rear <sorear@fastmail.com=
> wrote:
>
> On Wed, Mar 27, 2024, at 4:43 AM, yunhui cui wrote:
> > Hi Stefan,
> >
> > On Wed, Mar 27, 2024 at 2:14=E2=80=AFPM Stefan O'Rear <sorear@fastmail.=
com> wrote:
> >>
> >> childregs represents the registers which are active for the new thread
> >> in user context. For a kernel thread, childregs->gp is never used sinc=
e
> >> the kernel gp is not touched by switch_to. For a user mode helper, the
> >> gp value can be observed in user space after execve or possibly by oth=
er
> >> means.
> >>
> >> Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
> >> Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
> >> ---
> >>  arch/riscv/kernel/process.c | 3 ---
> >>  1 file changed, 3 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> >> index 92922dbd5b5c..51042f48da17 100644
> >> --- a/arch/riscv/kernel/process.c
> >> +++ b/arch/riscv/kernel/process.c
> >> @@ -27,8 +27,6 @@
> >>  #include <asm/vector.h>
> >>  #include <asm/cpufeature.h>
> >>
> >> -register unsigned long gp_in_global __asm__("gp");
> >> -
> >>  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_=
PER_TASK)
> >>  #include <linux/stackprotector.h>
> >>  unsigned long __stack_chk_guard __read_mostly;
> >> @@ -207,7 +205,6 @@ int copy_thread(struct task_struct *p, const struc=
t kernel_clone_args *args)
> >>         if (unlikely(args->fn)) {
> >>                 /* Kernel thread */
> >>                 memset(childregs, 0, sizeof(struct pt_regs));
> >> -               childregs->gp =3D gp_in_global;
> >>                 /* Supervisor/Machine, irqs on: */
> >>                 childregs->status =3D SR_PP | SR_PIE;
> >>
> >> --
> >> 2.40.1
> >>
> >>
> > Can you help express in more detail what the problem was before fixing =
it?
>
> It's a KASLR bypass, since gp_in_global is the address of the kernel symb=
ol
> __global_pointer$.
>
> The /* Kernel thread */ comment is somewhat inaccurate in that it is also=
 used
> for user_mode_helper threads, which exec a user process, e.g. /sbin/init =
or
> when /proc/sys/kernel/core_pattern is a pipe. Such threads do not have
> PF_KTHREAD set and are valid targets for ptrace etc. even before they exe=
c.
>
> childregs is the *user* context during syscall execution and it is observ=
able
> from userspace in at least five ways:
>
> 1. kernel_execve does not currently clear integer registers, so the start=
ing
>    register state for PID 1 and other user processes started by the kerne=
l has
>    sp =3D user stack, gp =3D kernel __global_pointer$, all other integer =
registers
>    zeroed by the memset in the patch comment.
>
>    This is a bug in its own right, but I'm unwilling to bet that it is th=
e only
>    way to exploit the issue addressed by this patch.
>
> 2. ptrace(PTRACE_GETREGSET): you can PTRACE_ATTACH to a user_mode_helper =
thread
>    before it execs, but ptrace requires SIGSTOP to be delivered which can=
 only
>    happen at user/kernel boundaries.
>
> 3. /proc/*/task/*/syscall: this is perfectly happy to read pt_regs for
>    user_mode_helpers before the exec completes, but gp is not one of the
>    registers it returns.
>
> 4. PERF_SAMPLE_REGS_USER: LOCKDOWN_PERF normally prevents access to kerne=
l
>    addresses via PERF_SAMPLE_REGS_INTR, but due to this bug kernel addres=
ses
>    are also exposed via PERF_SAMPLE_REGS_USER which is permitted under
>    LOCKDOWN_PERF. I have not attempted to write exploit code.
>
> 5. Much of the tracing infrastructure allows access to user registers. I =
have
>    not attempted to determine which forms of tracing allow access to user
>    registers without already allowing access to kernel registers.
>
> Does this help? How much of this should be in the commit message?

Fine enough, Thanks.

Thanks,
Yunhui

