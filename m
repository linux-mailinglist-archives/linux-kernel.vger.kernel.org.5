Return-Path: <linux-kernel+bounces-165908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E77D8B933F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23619282F67
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0371757E;
	Thu,  2 May 2024 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhQIcLda"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076F12B77;
	Thu,  2 May 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714615439; cv=none; b=aaNfuZr2OQygb6L5OKhl96mE/D/DYJOT3YSiLEvc6mGxia6KkMXQqYLWeFh/yUwR0/hYmryWl8UkTUwpn2PoXOW4ihhbrjRe6YU5UtsE9/RauoChT3oEBZAXi8Yp75Cpv0DYgir5UU16cVnY08uHLndrlbfBRE4dOdSelrdTneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714615439; c=relaxed/simple;
	bh=SWeXBcXKkGPsnHoi2Nzn5QOh0E73YoSqFU3TTZEHOKs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VFdvo6Nb7AKdr0TQYrnBYF0N6n7MQfZrs40UoLktR9ERl2an9LskQjXP01mBIZeeiDjCKsIC9S8id3oiHjNup3CBX5LejFeE+Pn/ZuYHHAHW3HoGEaRzqgoclh87dlbir5CNyWPFD+xK3jdhe7iHMfHx4m5OxRjscxeZkQmQAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhQIcLda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61933C072AA;
	Thu,  2 May 2024 02:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714615438;
	bh=SWeXBcXKkGPsnHoi2Nzn5QOh0E73YoSqFU3TTZEHOKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YhQIcLdaveuK6MKu9y1bDPu7YCeJeaD5GJ35EMerY6iX3OsYP+KVxeTI+M0gEZQbs
	 LxO+v7yucUYCdXnMxtB2jBZe6xTl6o61vJb4R2yUuZlI/0AvHG4TY/VVikUFRSux50
	 gw3mNFE5e07MSAqwmvg1EXJyNPHjPdJqheM8nxMdWoU/Azn6W5Byp3CMODzXHf3s9a
	 /k+7PeaHHzE+y6eRMY8KPhYObFbk091HF3G+gVHvMmPrvMWxWX+UJkO/5YwSlsLYsF
	 fsEtpqtSpMPA2EkSrwsyNkC/Fuc86iYSQS6bdNM2fAroRhz83u1/uEGQo3Hv5h3uG0
	 90V/Mvci7IfiA==
Date: Thu, 2 May 2024 11:03:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3] kprobe/ftrace: bail out if ftrace was killed
Message-Id: <20240502110348.016f190e0b0565b7e9ecdb48@kernel.org>
In-Reply-To: <CAJF2gTT8a4PBU3ekZFNTi6EuETT9hhKfhXrPgGGpn92rQMNSvg@mail.gmail.com>
References: <20240501162956.229427-1-stephen.s.brennan@oracle.com>
	<CAJF2gTT8a4PBU3ekZFNTi6EuETT9hhKfhXrPgGGpn92rQMNSvg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 2 May 2024 01:35:16 +0800
Guo Ren <guoren@kernel.org> wrote:

> On Thu, May 2, 2024 at 12:30 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
> >
> > If an error happens in ftrace, ftrace_kill() will prevent disarming
> > kprobes. Eventually, the ftrace_ops associated with the kprobes will be
> > freed, yet the kprobes will still be active, and when triggered, they
> > will use the freed memory, likely resulting in a page fault and panic.
> >
> > This behavior can be reproduced quite easily, by creating a kprobe and
> > then triggering a ftrace_kill(). For simplicity, we can simulate an
> > ftrace error with a kernel module like [1]:
> >
> > [1]: https://github.com/brenns10/kernel_stuff/tree/master/ftrace_killer
> >
> >   sudo perf probe --add commit_creds
> >   sudo perf trace -e probe:commit_creds
> >   # In another terminal
> >   make
> >   sudo insmod ftrace_killer.ko  # calls ftrace_kill(), simulating bug
> >   # Back to perf terminal
> >   # ctrl-c
> >   sudo perf probe --del commit_creds
> >
> > After a short period, a page fault and panic would occur as the kprobe
> > continues to execute and uses the freed ftrace_ops. While ftrace_kill()
> > is supposed to be used only in extreme circumstances, it is invoked in
> > FTRACE_WARN_ON() and so there are many places where an unexpected bug
> > could be triggered, yet the system may continue operating, possibly
> > without the administrator noticing. If ftrace_kill() does not panic the
> > system, then we should do everything we can to continue operating,
> > rather than leave a ticking time bomb.
> >
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > ---
> > Changes in v3:
> >   Don't expose ftrace_is_dead(). Create a "kprobe_ftrace_disabled"
> >   variable and check it directly in the kprobe handlers.
> > Link to v1/v2 discussion:
> >   https://lore.kernel.org/all/20240426225834.993353-1-stephen.s.brennan@oracle.com/
> >
> >  arch/csky/kernel/probes/ftrace.c     | 3 +++
> >  arch/loongarch/kernel/ftrace_dyn.c   | 3 +++
> >  arch/parisc/kernel/ftrace.c          | 3 +++
> >  arch/powerpc/kernel/kprobes-ftrace.c | 3 +++
> >  arch/riscv/kernel/probes/ftrace.c    | 3 +++
> >  arch/s390/kernel/ftrace.c            | 3 +++
> >  arch/x86/kernel/kprobes/ftrace.c     | 3 +++
> >  include/linux/kprobes.h              | 7 +++++++
> >  kernel/kprobes.c                     | 6 ++++++
> >  kernel/trace/ftrace.c                | 1 +
> >  10 files changed, 35 insertions(+)
> >
> > diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> > index 834cffcfbce3..7ba4b98076de 100644
> > --- a/arch/csky/kernel/probes/ftrace.c
> > +++ b/arch/csky/kernel/probes/ftrace.c
> > @@ -12,6 +12,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> >         struct kprobe_ctlblk *kcb;
> >         struct pt_regs *regs;
> >
> > +       if (unlikely(kprobe_ftrace_disabled))
> > +               return;
> > +
> For csky part.
> Acked-by: Guo Ren <guoren@kernel.org>

Thanks Stephen, Guo and Steve!

Let me pick this to probes/for-next!

Thank you,

> 
> >         bit = ftrace_test_recursion_trylock(ip, parent_ip);
> >         if (bit < 0)
> >                 return;
> > diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
> > index 73858c9029cc..bff058317062 100644
> > --- a/arch/loongarch/kernel/ftrace_dyn.c
> > +++ b/arch/loongarch/kernel/ftrace_dyn.c
> > @@ -287,6 +287,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> >         struct kprobe *p;
> >         struct kprobe_ctlblk *kcb;
> >
> > +       if (unlikely(kprobe_ftrace_disabled))
> > +               return;
> > +
> >         bit = ftrace_test_recursion_trylock(ip, parent_ip);
> >         if (bit < 0)
> >                 return;
> > diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
> > index 621a4b386ae4..c91f9c2e61ed 100644
> > --- a/arch/parisc/kernel/ftrace.c
> > +++ b/arch/parisc/kernel/ftrace.c
> > @@ -206,6 +206,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> >         struct kprobe *p;
> >         int bit;
> >
> > +       if (unlikely(kprobe_ftrace_disabled))
> > +               return;
> > +
> >         bit = ftrace_test_recursion_trylock(ip, parent_ip);
> >         if (bit < 0)
> >                 return;
> > diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> > index 072ebe7f290b..f8208c027148 100644
> > --- a/arch/powerpc/kernel/kprobes-ftrace.c
> > +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> > @@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
> >         struct pt_regs *regs;
> >         int bit;
> >
> > +       if (unlikely(kprobe_ftrace_disabled))
> > +               return;
> > +
> >         bit = ftrace_test_recursion_trylock(nip, parent_nip);
> >         if (bit < 0)
> >                 return;
> > diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
> > index 7142ec42e889..a69dfa610aa8 100644
> > --- a/arch/riscv/kernel/probes/ftrace.c
> > +++ b/arch/riscv/kernel/probes/ftrace.c
> > @@ -11,6 +11,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> >         struct kprobe_ctlblk *kcb;
> >         int bit;
> >
> > +       if (unlikely(kprobe_ftrace_disabled))
> > +               return;
> > +
> >         bit = ftrace_test_recursion_trylock(ip, parent_ip);
> >         if (bit < 0)
> >                 return;
> > diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
> > index c46381ea04ec..7f6f8c438c26 100644
> > --- a/arch/s390/kernel/ftrace.c
> > +++ b/arch/s390/kernel/ftrace.c
> > @@ -296,6 +296,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> >         struct kprobe *p;
> >         int bit;
> >
> > +       if (unlikely(kprobe_ftrace_disabled))
> > +               return;
> > +
> >         bit = ftrace_test_recursion_trylock(ip, parent_ip);
> >         if (bit < 0)
> >                 return;
> > diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
> > index dd2ec14adb77..15af7e98e161 100644
> > --- a/arch/x86/kernel/kprobes/ftrace.c
> > +++ b/arch/x86/kernel/kprobes/ftrace.c
> > @@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> >         struct kprobe_ctlblk *kcb;
> >         int bit;
> >
> > +       if (unlikely(kprobe_ftrace_disabled))
> > +               return;
> > +
> >         bit = ftrace_test_recursion_trylock(ip, parent_ip);
> >         if (bit < 0)
> >                 return;
> > diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> > index 0ff44d6633e3..5fcbc254d186 100644
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -378,11 +378,15 @@ static inline void wait_for_kprobe_optimizer(void) { }
> >  extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> >                                   struct ftrace_ops *ops, struct ftrace_regs *fregs);
> >  extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
> > +/* Set when ftrace has been killed: kprobes on ftrace must be disabled for safety */
> > +extern bool kprobe_ftrace_disabled __read_mostly;
> > +extern void kprobe_ftrace_kill(void);
> >  #else
> >  static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
> >  {
> >         return -EINVAL;
> >  }
> > +static inline void kprobe_ftrace_kill(void) {}
> >  #endif /* CONFIG_KPROBES_ON_FTRACE */
> >
> >  /* Get the kprobe at this addr (if any) - called with preemption disabled */
> > @@ -495,6 +499,9 @@ static inline void kprobe_flush_task(struct task_struct *tk)
> >  static inline void kprobe_free_init_mem(void)
> >  {
> >  }
> > +static inline void kprobe_ftrace_kill(void)
> > +{
> > +}
> >  static inline int disable_kprobe(struct kprobe *kp)
> >  {
> >         return -EOPNOTSUPP;
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 65adc815fc6e..166ebf81dc45 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1068,6 +1068,7 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
> >
> >  static int kprobe_ipmodify_enabled;
> >  static int kprobe_ftrace_enabled;
> > +bool kprobe_ftrace_disabled;
> >
> >  static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
> >                                int *cnt)
> > @@ -1136,6 +1137,11 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
> >                 ipmodify ? &kprobe_ipmodify_ops : &kprobe_ftrace_ops,
> >                 ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
> >  }
> > +
> > +void kprobe_ftrace_kill()
> > +{
> > +       kprobe_ftrace_disabled = true;
> > +}
> >  #else  /* !CONFIG_KPROBES_ON_FTRACE */
> >  static inline int arm_kprobe_ftrace(struct kprobe *p)
> >  {
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index da1710499698..96db99c347b3 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -7895,6 +7895,7 @@ void ftrace_kill(void)
> >         ftrace_disabled = 1;
> >         ftrace_enabled = 0;
> >         ftrace_trace_function = ftrace_stub;
> > +       kprobe_ftrace_kill();
> >  }
> >
> >  /**
> > --
> > 2.39.3
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

