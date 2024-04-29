Return-Path: <linux-kernel+bounces-162390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387208B5A77
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEF21C21573
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0158E7640E;
	Mon, 29 Apr 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyORC9o2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649C74E11;
	Mon, 29 Apr 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398493; cv=none; b=Bx3nJaq6+ORDpsE0y3q9YGrux+vU/ZVyMa+Ecn+G6cy+Urip+PK+HdZz+t5zpiSJSjGoM7cbhdx1fdzAcqhwlaveQ5LfIg6nHX/BghnChDgeu10k2PQ9e8vuH7XOTjd1LVXCXYrXtefRlPMc/Autd5e7MT91oKEweIvH3Od+rfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398493; c=relaxed/simple;
	bh=2OmxYBcG8kYWa15/HKPOVgxwdgSzJ8/xMevqt/hqwIo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iykIDcNFJPk5Gh0ScGi69j7sSEOGBELBYdkPhQtxZZkye8DUhdaEUncCM+7nYLDiA60JDHB0iDkFsUCoybLlmPajyGCQhALlhaScJfXy/YkZyoXOkWhLwC58+TApD9Cq1gaQtf6KnDg7SsMgL2sJMsZ/y1YwuZAni07kA5PAw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyORC9o2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427D1C113CD;
	Mon, 29 Apr 2024 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714398492;
	bh=2OmxYBcG8kYWa15/HKPOVgxwdgSzJ8/xMevqt/hqwIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lyORC9o2Lm+u2avM+eOyj/ccYiyuxZQLnwqOF6FZV49QnzRN+Dcvvb8f+L/I+DIcc
	 bR6gzWrxR06bLVpEA1X1PfPHzCF0nDSdsFIGgv/R/Ztx7jvyn/LZvp5GTSxbA3X+Ea
	 5Q5++mVTUse/so5L++FV3pac1nAd6FyimPuc/dQPplc7m0nyf+JoSS48zL0c07gOKG
	 +Q9TxDTXUAv++YZPpMLvDQVzMH1VHt+BXIScwupTc1u15EnhRP870WSg23oHheSEFh
	 X/E2DhZuUkcbr1ov6EZLQFmBffBmxl2jf1fX5T3O6khvfYPOQWnrKD7j3rIrd7dwdJ
	 AMHlyJcx5ffMw==
Date: Mon, 29 Apr 2024 22:48:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Guo Ren <guoren@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] kprobe/ftrace: bail out if ftrace was killed
Message-Id: <20240429224803.49d420b514e22d51412e1602@kernel.org>
In-Reply-To: <20240426225834.993353-1-stephen.s.brennan@oracle.com>
References: <20240426225834.993353-1-stephen.s.brennan@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Stephen,

On Fri, 26 Apr 2024 15:58:34 -0700
Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> If an error happens in ftrace, ftrace_kill() will prevent disarming
> kprobes. Eventually, the ftrace_ops associated with the kprobes will be
> freed, yet the kprobes will still be active, and when triggered, they
> will use the freed memory, likely resulting in a page fault and panic.

Hmm, indeed.

> 
> This behavior can be reproduced quite easily, by creating a kprobe and
> then triggering a ftrace_kill(). For simplicity, we can simulate an
> ftrace error with a kernel module like [1]:
> 
> [1]: https://github.com/brenns10/kernel_stuff/tree/master/ftrace_killer
> 
>   sudo perf probe --add commit_creds
>   sudo perf trace -e probe:commit_creds
>   # In another terminal
>   make
>   sudo insmod ftrace_killer.ko  # calls ftrace_kill(), simulating bug
>   # Back to perf terminal
>   # ctrl-c
>   sudo perf probe --del commit_creds
> 
> After a short period, a page fault and panic would occur as the kprobe
> continues to execute and uses the freed ftrace_ops. While ftrace_kill()
> is supposed to be used only in extreme circumstances, it is invoked in
> FTRACE_WARN_ON() and so there are many places where an unexpected bug
> could be triggered, yet the system may continue operating, possibly
> without the administrator noticing. If ftrace_kill() does not panic the
> system, then we should do everything we can to continue operating,
> rather than leave a ticking time bomb.

OK, the patch looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
> 
> Apologies for the wide net cast here. I recognize that a change like this
> may need to be split up and go through arch-specific trees. I hoped to get
> feedback on the patch itself. If it's satisfactory and the architecture
> maintainers prefer it split out, I'm glad to do it. Thanks!
> 
>  arch/csky/kernel/probes/ftrace.c     | 3 +++
>  arch/loongarch/kernel/ftrace_dyn.c   | 3 +++
>  arch/parisc/kernel/ftrace.c          | 3 +++
>  arch/powerpc/kernel/kprobes-ftrace.c | 3 +++
>  arch/riscv/kernel/probes/ftrace.c    | 3 +++
>  arch/s390/kernel/ftrace.c            | 3 +++
>  arch/x86/kernel/kprobes/ftrace.c     | 3 +++
>  include/linux/ftrace.h               | 2 ++
>  8 files changed, 23 insertions(+)
> 
> diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> index 834cffcfbce3..3931bf9f707b 100644
> --- a/arch/csky/kernel/probes/ftrace.c
> +++ b/arch/csky/kernel/probes/ftrace.c
> @@ -12,6 +12,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  	struct kprobe_ctlblk *kcb;
>  	struct pt_regs *regs;
>  
> +	if (unlikely(ftrace_is_dead()))
> +		return;
> +
>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>  	if (bit < 0)
>  		return;
> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
> index 73858c9029cc..82c952cb5be0 100644
> --- a/arch/loongarch/kernel/ftrace_dyn.c
> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> @@ -287,6 +287,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  	struct kprobe *p;
>  	struct kprobe_ctlblk *kcb;
>  
> +	if (unlikely(ftrace_is_dead()))
> +		return;
> +
>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>  	if (bit < 0)
>  		return;
> diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
> index 621a4b386ae4..3660834f54c3 100644
> --- a/arch/parisc/kernel/ftrace.c
> +++ b/arch/parisc/kernel/ftrace.c
> @@ -206,6 +206,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  	struct kprobe *p;
>  	int bit;
>  
> +	if (unlikely(ftrace_is_dead()))
> +		return;
> +
>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>  	if (bit < 0)
>  		return;
> diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> index 072ebe7f290b..85eb55aa1457 100644
> --- a/arch/powerpc/kernel/kprobes-ftrace.c
> +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> @@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  	struct pt_regs *regs;
>  	int bit;
>  
> +	if (unlikely(ftrace_is_dead()))
> +		return;
> +
>  	bit = ftrace_test_recursion_trylock(nip, parent_nip);
>  	if (bit < 0)
>  		return;
> diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
> index 7142ec42e889..8814fbe4c888 100644
> --- a/arch/riscv/kernel/probes/ftrace.c
> +++ b/arch/riscv/kernel/probes/ftrace.c
> @@ -11,6 +11,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  	struct kprobe_ctlblk *kcb;
>  	int bit;
>  
> +	if (unlikely(ftrace_is_dead()))
> +		return;
> +
>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>  	if (bit < 0)
>  		return;
> diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
> index c46381ea04ec..ccbe8ccf945b 100644
> --- a/arch/s390/kernel/ftrace.c
> +++ b/arch/s390/kernel/ftrace.c
> @@ -296,6 +296,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  	struct kprobe *p;
>  	int bit;
>  
> +	if (unlikely(ftrace_is_dead()))
> +		return;
> +
>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>  	if (bit < 0)
>  		return;
> diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
> index dd2ec14adb77..c73f9ab7ff50 100644
> --- a/arch/x86/kernel/kprobes/ftrace.c
> +++ b/arch/x86/kernel/kprobes/ftrace.c
> @@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  	struct kprobe_ctlblk *kcb;
>  	int bit;
>  
> +	if (unlikely(ftrace_is_dead()))
> +		return;
> +
>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>  	if (bit < 0)
>  		return;
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 54d53f345d14..ba83e99c1fbe 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -399,6 +399,7 @@ int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *a
>  #define register_ftrace_function(ops) ({ 0; })
>  #define unregister_ftrace_function(ops) ({ 0; })
>  static inline void ftrace_kill(void) { }
> +static inline int ftrace_is_dead(void) { return 0; }
>  static inline void ftrace_free_init_mem(void) { }
>  static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
>  static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
> @@ -914,6 +915,7 @@ static inline bool is_ftrace_trampoline(unsigned long addr)
>  
>  /* totally disable ftrace - can not re-enable after this */
>  void ftrace_kill(void);
> +int ftrace_is_dead(void);
>  
>  static inline void tracer_disable(void)
>  {
> -- 
> 2.39.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

