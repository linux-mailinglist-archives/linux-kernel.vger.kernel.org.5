Return-Path: <linux-kernel+bounces-155731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218ED8AF64C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAA41C21821
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D313E3EF;
	Tue, 23 Apr 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LO8UzzYJ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4913E03F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895759; cv=none; b=U32+mPtcjsEE5/nZM81qATIt/BCy/z+ahPpEfcLtDSh3TY+fDSbewocVOdznFlDaAODahElXnrxFAZNsL/++u42ApwY8i9qPEjd3ACN4kKeg8puFdUsnvOghSDIuFdBfaoI+awRcskjnCY8qOOUXxdSE3hH4pmUiVwzPJdaknG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895759; c=relaxed/simple;
	bh=oHr4V0B2KflqCc0Ka3IbL9iOQa60OfEeAqPCKm/aUVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCSPgSYgv3Os+HO9MO0VIC8yA7u7kwRPv2UD4w4eKPF57VuBCJRM7zCro2Jnj8uewJHTZ5cZyzIQUUEtjcPyVGRISTLNx39leivxNR69NArbHJeOwDFYf79GLxP3QfFkUTY/222AzgMtF9QosTkTim4P/kJZWffOUU14YHpw7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=LO8UzzYJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dd041acff1so46338071fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1713895756; x=1714500556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIJNaEMv/4rmQZaBdsoVMDghW+jCtKelSwdikaTLbBE=;
        b=LO8UzzYJqgnQDqZ6Ra2y3m9p9nby8V/t69UWS/K2hIpGBRGOPUcxkvWpX/sZwMo304
         We0racFTh6YKanm7IJu4hU3isYHwBNqs+U6yCvl1NGaA4guI0zD93DgKc13PGkoAsRrT
         wmPY11eIZqFlWtWLHAYP5g8biSXqsATYSIRzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895756; x=1714500556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIJNaEMv/4rmQZaBdsoVMDghW+jCtKelSwdikaTLbBE=;
        b=tu4JY2fCGPna1vTC++IvmDA470nlQ+XyIDdO/UrRc/L40e0JXsb/pPpHSczNNxdxF8
         iauc/yM3GOHcl7oqfWFZgHDzYty83iJ+HpBkZYG4Tv8fTk/3fWnO6AOXQPgpxosRcFt1
         zpUn2RdAc6x6WQpNCZPcye5q1A16gyW6jh2ABdPhgNYuvgR9b2cfa9q6BD13F6H9Me5O
         4XWdPbkK9fr1eds8U8F0E+qyiyRWS5Pc+bY3e5RnI2Ofsyh6aXFoO1+Wzphd45zCEvln
         h7iM/QoGbHgrANy+3x9TdFhwbS+h6tDm8OrofNAiP5HVdByp9HaAr40Kv5rlF8a+lx2E
         idow==
X-Gm-Message-State: AOJu0Yylc6GyOD02R+YuQQRKvsXhldYR5Q8aK2b5lutLOe+pzNFsKIah
	8oOunGhi0yqBEW567vh+0FRvV6RChQeS1nNyN+amNlG7cl32cr1aujdXFopbYj3e4pUHIptMNQw
	sr+c68VgwM9VHp6DsNCH3BSyOl3hyIPjQqQn8SA==
X-Google-Smtp-Source: AGHT+IHH0toDmiKEgZ+Oi1Xjq6HwMaXiK5Puk/ytGD4pZ77NlsuSVA2xPYuc6UoBKumI0D+B73PdFPiYibAPE4xphx4=
X-Received: by 2002:a2e:93c5:0:b0:2da:15cf:1e23 with SMTP id
 p5-20020a2e93c5000000b002da15cf1e23mr28753ljh.17.1713895756037; Tue, 23 Apr
 2024 11:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407090558.3395-1-jiangshanlai@gmail.com> <20240407090558.3395-11-jiangshanlai@gmail.com>
In-Reply-To: <20240407090558.3395-11-jiangshanlai@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 23 Apr 2024 14:09:03 -0400
Message-ID: <CAEXW_YQUuGazgpLbERz7Y3nOq5nEkR+kx_Us9E30x1diiE2-eQ@mail.gmail.com>
Subject: Re: [PATCH V2 10/11] x86/rcu: Add rcu_preempt_count
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 5:06=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.co=
m> wrote:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> Implement PCPU_RCU_PREEMPT_COUNT for x86.
> Mainly copied from asm/preempt.h
>
> Make rcu_read_[un]lock() inlined for rcu-preempt.

Changelog is wrong. You inlined rcu_read_[un]lock in previous patch,
not this one?

- Joel

> Make rcu_read_lock() only one instruction.
> Make rcu_read_unlock() only two instructions in the fast path.
>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/Kconfig                   |   1 +
>  arch/x86/include/asm/current.h     |   3 +
>  arch/x86/include/asm/rcu_preempt.h | 107 +++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/common.c       |   4 ++
>  4 files changed, 115 insertions(+)
>  create mode 100644 arch/x86/include/asm/rcu_preempt.h
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4fff6ed46e90..e805cac3763d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -256,6 +256,7 @@ config X86
>         select HAVE_OBJTOOL                     if X86_64
>         select HAVE_OPTPROBES
>         select HAVE_PAGE_SIZE_4KB
> +       select HAVE_PCPU_RCU_PREEMPT_COUNT
>         select HAVE_PCSPKR_PLATFORM
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_EVENTS_NMI
> diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/curren=
t.h
> index bf5953883ec3..dcc2ef784120 100644
> --- a/arch/x86/include/asm/current.h
> +++ b/arch/x86/include/asm/current.h
> @@ -24,6 +24,9 @@ struct pcpu_hot {
>                         unsigned long           top_of_stack;
>                         void                    *hardirq_stack_ptr;
>                         u16                     softirq_pending;
> +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +                       int                     rcu_preempt_count;
> +#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
>  #ifdef CONFIG_X86_64
>                         bool                    hardirq_stack_inuse;
>  #else
> diff --git a/arch/x86/include/asm/rcu_preempt.h b/arch/x86/include/asm/rc=
u_preempt.h
> new file mode 100644
> index 000000000000..cb25ebe038a5
> --- /dev/null
> +++ b/arch/x86/include/asm/rcu_preempt.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_RCU_PREEMPT_H
> +#define __ASM_RCU_PREEMPT_H
> +
> +#include <asm/rmwcc.h>
> +#include <asm/percpu.h>
> +#include <asm/current.h>
> +
> +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +
> +/* We use the MSB mostly because its available */
> +#define RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED    0x80000000
> +
> +/*
> + * We use the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit as an inverted
> + * current->rcu_read_unlock_special.s such that a decrement hitting 0
> + * means we can and should call rcu_read_unlock_special().
> + */
> +#define RCU_PREEMPT_INIT       (0 + RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED)
> +
> +/*
> + * We mask the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit so as not to
> + * confuse all current users that think a non-zero value indicates we
> + * are in a critical section.
> + */
> +static inline int pcpu_rcu_preempt_count(void)
> +{
> +       return raw_cpu_read_4(pcpu_hot.rcu_preempt_count) & ~RCU_PREEMPT_=
UNLOCK_SPECIAL_INVERTED;
> +}
> +
> +static inline void pcpu_rcu_preempt_count_set(int count)
> +{
> +       int old, new;
> +
> +       old =3D raw_cpu_read_4(pcpu_hot.rcu_preempt_count);
> +       do {
> +               new =3D (old & RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED) |
> +                       (count & ~RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED);
> +       } while (!raw_cpu_try_cmpxchg_4(pcpu_hot.rcu_preempt_count, &old,=
 new));
> +}
> +
> +/*
> + * We fold the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit into the RCU
> + * preempt count such that rcu_read_unlock() can decrement and test for
> + * the need of unlock-special handling with a single instruction.
> + *
> + * We invert the actual bit, so that when the decrement hits 0 we know
> + * we both reach a quiescent state (no rcu preempt count) and need to
> + * handle unlock-special (the bit is cleared), normally to report the
> + * quiescent state immediately.
> + */
> +
> +static inline void pcpu_rcu_preempt_special_set(void)
> +{
> +       raw_cpu_and_4(pcpu_hot.rcu_preempt_count, ~RCU_PREEMPT_UNLOCK_SPE=
CIAL_INVERTED);
> +}
> +
> +static inline void pcpu_rcu_preempt_special_clear(void)
> +{
> +       raw_cpu_or_4(pcpu_hot.rcu_preempt_count, RCU_PREEMPT_UNLOCK_SPECI=
AL_INVERTED);
> +}
> +
> +static inline bool pcpu_rcu_preempt_special_test(void)
> +{
> +       return !(raw_cpu_read_4(pcpu_hot.rcu_preempt_count) & RCU_PREEMPT=
_UNLOCK_SPECIAL_INVERTED);
> +}
> +
> +static inline void pcpu_rcu_preempt_switch(int count, bool special)
> +{
> +       if (likely(!special))
> +               raw_cpu_write(pcpu_hot.rcu_preempt_count, count | RCU_PRE=
EMPT_UNLOCK_SPECIAL_INVERTED);
> +       else
> +               raw_cpu_write(pcpu_hot.rcu_preempt_count, count);
> +}
> +
> +/*
> + * The various rcu_preempt_count add/sub methods
> + */
> +
> +static __always_inline void pcpu_rcu_preempt_count_add(int val)
> +{
> +       raw_cpu_add_4(pcpu_hot.rcu_preempt_count, val);
> +}
> +
> +static __always_inline void pcpu_rcu_preempt_count_sub(int val)
> +{
> +       raw_cpu_add_4(pcpu_hot.rcu_preempt_count, -val);
> +}
> +
> +/*
> + * Because we keep RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED set when we do
> + * _not_ need to handle unlock-special for a fast-path decrement.
> + */
> +static __always_inline bool pcpu_rcu_preempt_count_dec_and_test(void)
> +{
> +       return GEN_UNARY_RMWcc("decl", __my_cpu_var(pcpu_hot.rcu_preempt_=
count), e,
> +                              __percpu_arg([var]));
> +}
> +
> +#define pcpu_rcu_read_unlock_special()                                  =
       \
> +do {                                                                    =
       \
> +       rcu_read_unlock_special();                                       =
       \
> +} while (0)
> +
> +#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +
> +#endif /* __ASM_RCU_PREEMPT_H */
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 5c1e6d6be267..918b1f5cb75d 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1995,6 +1995,10 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) =
=3D {
>         .current_task   =3D &init_task,
>         .preempt_count  =3D INIT_PREEMPT_COUNT,
>         .top_of_stack   =3D TOP_OF_INIT_STACK,
> +
> +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +       .rcu_preempt_count      =3D RCU_PREEMPT_INIT,
> +#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
>  };
>  EXPORT_PER_CPU_SYMBOL(pcpu_hot);
>  EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
> --
> 2.19.1.6.gb485710b
>
>

