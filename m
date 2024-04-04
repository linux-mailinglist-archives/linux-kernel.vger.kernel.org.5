Return-Path: <linux-kernel+bounces-131727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666CD898B28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CDF1C22A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668DD1292F3;
	Thu,  4 Apr 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/bAQlDg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2F84FDF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244765; cv=none; b=nntYdTj3y95W8aH4dYw7Y6ba6S2PfvM8kc6u/oKIMEefpGIxCJjRNYYHanUonjXEwJ4vW7exA4tFXKUn3iInYPkCcXNfMU00zbqiURyNECyqu/klS7hS7I56/WPFZ0VlW7Ctk947pTCMdr0hJHBSSGJa4e2YPlokI1mssTl6Yy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244765; c=relaxed/simple;
	bh=zsZ3ishnWX9uJ0W4Rc2EEdN3fsoDdgAdyOvP1ggjlak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n317qnPZYtqUiwi11sa8iBxF3Qu5QXydhpLFwqkHDJetRfXgldaH83IVvv7A7UqOOD1Ts2ZbY8n7ZonqNDqdKuWve8521SjjA97sKDopwn6WdnPbw45RaAhUJh/M5pyz6b0I2aXDNHsDX+PMl75xM2FOp85j6qk9N/9GyJJlCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/bAQlDg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712244762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAwr5RwMwHn0D/njvN++F10eAqx2FSSGd5SI+w45dIE=;
	b=I/bAQlDgJvQbE/+zZpVKYGPROUKIRxjo7sG7GhG14SfG33raKFl5EDmQESfODhtJAk2LxM
	6j0BSvpURSWzer/kWmdc/bmv307tjDSpoLAUqCj7Pop+D4jnawsLv+PT0VQxxeBZUkuUFx
	xKEaD+NnI9RTvA5sE6Wpi1TexuTUVJQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-VtgH5F9MM_mRjDojD5iFkg-1; Thu,
 04 Apr 2024 11:32:39 -0400
X-MC-Unique: VtgH5F9MM_mRjDojD5iFkg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E167F28AC1DD;
	Thu,  4 Apr 2024 15:32:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.21])
	by smtp.corp.redhat.com (Postfix) with SMTP id 79CAC492BCA;
	Thu,  4 Apr 2024 15:32:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Apr 2024 17:31:13 +0200 (CEST)
Date: Thu, 4 Apr 2024 17:31:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] MIPS: scall: Save thread_info.syscall unconditionally on
 entry
Message-ID: <20240404153107.GF7153@redhat.com>
References: <20240328-mips_save_syscall-v1-1-9e1d62d6999d@flygoat.com>
 <465b3f19-56dc-4953-a677-58fd853f2f88@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <465b3f19-56dc-4953-a677-58fd853f2f88@app.fastmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 04/04, Jiaxun Yang wrote:
> 
> 
> 在2024年3月28日三月 下午2:27，Jiaxun Yang写道：
> > thread_info.syscall is used by syscall_get_nr to supply syscall nr
> > over a thread stack frame.
> >
> > Previously, thread_info.syscall is only saved at syscall_trace_enter
> > when syscall tracing is enabled. However rest of the kernel code do
> > expect syscall_get_nr to be available without syscall tracing. The
> > previous design breaks collect_syscall.
> >
> > Move saving process to syscall entry to fix it.
> >
> > Reported-by: Xi Ruoyao <xry111@xry111.site>
> > Link: https://github.com/util-linux/util-linux/issues/2867
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Ping, this needs to be in fixes tree.

Just in case... I see nothing wrong, but I can't review this patch.
I know nothing about arch/mips/ so I can't really understand these
low-level changes.

Oleg.

> 
> Thanks
> 
> > ---
> >  arch/mips/include/asm/ptrace.h |  2 +-
> >  arch/mips/kernel/asm-offsets.c |  1 +
> >  arch/mips/kernel/ptrace.c      | 15 ++++++---------
> >  arch/mips/kernel/scall32-o32.S | 23 +++++++++++++----------
> >  arch/mips/kernel/scall64-n32.S |  3 ++-
> >  arch/mips/kernel/scall64-n64.S |  3 ++-
> >  arch/mips/kernel/scall64-o32.S | 33 +++++++++++++++++----------------
> >  7 files changed, 42 insertions(+), 38 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> > index d14d0e37ad02..4a2b40ce39e0 100644
> > --- a/arch/mips/include/asm/ptrace.h
> > +++ b/arch/mips/include/asm/ptrace.h
> > @@ -159,7 +159,7 @@ extern unsigned long exception_ip(struct pt_regs *regs);
> >  #define exception_ip(regs) exception_ip(regs)
> >  #define profile_pc(regs) instruction_pointer(regs)
> > 
> > -extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
> > +extern asmlinkage long syscall_trace_enter(struct pt_regs *regs);
> >  extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
> > 
> >  extern void die(const char *, struct pt_regs *) __noreturn;
> > diff --git a/arch/mips/kernel/asm-offsets.c 
> > b/arch/mips/kernel/asm-offsets.c
> > index d1b11f66f748..cb1045ebab06 100644
> > --- a/arch/mips/kernel/asm-offsets.c
> > +++ b/arch/mips/kernel/asm-offsets.c
> > @@ -101,6 +101,7 @@ void output_thread_info_defines(void)
> >  	OFFSET(TI_CPU, thread_info, cpu);
> >  	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
> >  	OFFSET(TI_REGS, thread_info, regs);
> > +	OFFSET(TI_SYSCALL, thread_info, syscall);
> >  	DEFINE(_THREAD_SIZE, THREAD_SIZE);
> >  	DEFINE(_THREAD_MASK, THREAD_MASK);
> >  	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
> > diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> > index 59288c13b581..61503a36067e 100644
> > --- a/arch/mips/kernel/ptrace.c
> > +++ b/arch/mips/kernel/ptrace.c
> > @@ -1317,16 +1317,13 @@ long arch_ptrace(struct task_struct *child, 
> > long request,
> >   * Notification of system call entry/exit
> >   * - triggered by current->work.syscall_trace
> >   */
> > -asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
> > +asmlinkage long syscall_trace_enter(struct pt_regs *regs)
> >  {
> >  	user_exit();
> > 
> > -	current_thread_info()->syscall = syscall;
> > -
> >  	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
> >  		if (ptrace_report_syscall_entry(regs))
> >  			return -1;
> > -		syscall = current_thread_info()->syscall;
> >  	}
> > 
> >  #ifdef CONFIG_SECCOMP
> > @@ -1335,7 +1332,7 @@ asmlinkage long syscall_trace_enter(struct 
> > pt_regs *regs, long syscall)
> >  		struct seccomp_data sd;
> >  		unsigned long args[6];
> > 
> > -		sd.nr = syscall;
> > +		sd.nr = current_thread_info()->syscall;
> >  		sd.arch = syscall_get_arch(current);
> >  		syscall_get_arguments(current, regs, args);
> >  		for (i = 0; i < 6; i++)
> > @@ -1345,23 +1342,23 @@ asmlinkage long syscall_trace_enter(struct 
> > pt_regs *regs, long syscall)
> >  		ret = __secure_computing(&sd);
> >  		if (ret == -1)
> >  			return ret;
> > -		syscall = current_thread_info()->syscall;
> >  	}
> >  #endif
> > 
> >  	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> >  		trace_sys_enter(regs, regs->regs[2]);
> > 
> > -	audit_syscall_entry(syscall, regs->regs[4], regs->regs[5],
> > +	audit_syscall_entry(current_thread_info()->syscall,
> > +			    regs->regs[4], regs->regs[5],
> >  			    regs->regs[6], regs->regs[7]);
> > 
> >  	/*
> >  	 * Negative syscall numbers are mistaken for rejected syscalls, but
> >  	 * won't have had the return value set appropriately, so we do so now.
> >  	 */
> > -	if (syscall < 0)
> > +	if (current_thread_info()->syscall < 0)
> >  		syscall_set_return_value(current, regs, -ENOSYS, 0);
> > -	return syscall;
> > +	return current_thread_info()->syscall;
> >  }
> > 
> >  /*
> > diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> > index 18dc9b345056..2c604717e630 100644
> > --- a/arch/mips/kernel/scall32-o32.S
> > +++ b/arch/mips/kernel/scall32-o32.S
> > @@ -77,6 +77,18 @@ loads_done:
> >  	PTR_WD	load_a7, bad_stack_a7
> >  	.previous
> > 
> > +	/*
> > +	 * syscall number is in v0 unless we called syscall(__NR_###)
> > +	 * where the real syscall number is in a0
> > +	 */
> > +	subu	t2, v0,  __NR_O32_Linux
> > +	bnez	t2, 1f /* __NR_syscall at offset 0 */
> > +	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
> > +	b	2f
> > +1:
> > +	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
> > +2:
> > +
> >  	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
> >  	li	t1, _TIF_WORK_SYSCALL_ENTRY
> >  	and	t0, t1
> > @@ -114,16 +126,7 @@ syscall_trace_entry:
> >  	SAVE_STATIC
> >  	move	a0, sp
> > 
> > -	/*
> > -	 * syscall number is in v0 unless we called syscall(__NR_###)
> > -	 * where the real syscall number is in a0
> > -	 */
> > -	move	a1, v0
> > -	subu	t2, v0,  __NR_O32_Linux
> > -	bnez	t2, 1f /* __NR_syscall at offset 0 */
> > -	lw	a1, PT_R4(sp)
> > -
> > -1:	jal	syscall_trace_enter
> > +	jal	syscall_trace_enter
> > 
> >  	bltz	v0, 1f			# seccomp failed? Skip syscall
> > 
> > diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
> > index 97456b2ca7dc..97788859238c 100644
> > --- a/arch/mips/kernel/scall64-n32.S
> > +++ b/arch/mips/kernel/scall64-n32.S
> > @@ -44,6 +44,8 @@ NESTED(handle_sysn32, PT_SIZE, sp)
> > 
> >  	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
> > 
> > +	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
> > +
> >  	li	t1, _TIF_WORK_SYSCALL_ENTRY
> >  	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
> >  	and	t0, t1, t0
> > @@ -72,7 +74,6 @@ syscall_common:
> >  n32_syscall_trace_entry:
> >  	SAVE_STATIC
> >  	move	a0, sp
> > -	move	a1, v0
> >  	jal	syscall_trace_enter
> > 
> >  	bltz	v0, 1f			# seccomp failed? Skip syscall
> > diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
> > index e6264aa62e45..be11ea5cc67e 100644
> > --- a/arch/mips/kernel/scall64-n64.S
> > +++ b/arch/mips/kernel/scall64-n64.S
> > @@ -46,6 +46,8 @@ NESTED(handle_sys64, PT_SIZE, sp)
> > 
> >  	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
> > 
> > +	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
> > +
> >  	li	t1, _TIF_WORK_SYSCALL_ENTRY
> >  	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
> >  	and	t0, t1, t0
> > @@ -82,7 +84,6 @@ n64_syscall_exit:
> >  syscall_trace_entry:
> >  	SAVE_STATIC
> >  	move	a0, sp
> > -	move	a1, v0
> >  	jal	syscall_trace_enter
> > 
> >  	bltz	v0, 1f			# seccomp failed? Skip syscall
> > diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> > index d3c2616cba22..7a5abb73e531 100644
> > --- a/arch/mips/kernel/scall64-o32.S
> > +++ b/arch/mips/kernel/scall64-o32.S
> > @@ -79,6 +79,22 @@ loads_done:
> >  	PTR_WD	load_a7, bad_stack_a7
> >  	.previous
> > 
> > +	/*
> > +	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
> > +	 * where the real syscall number is in a0
> > +	 * note: NR_syscall is the first O32 syscall but the macro is
> > +	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
> > +	 * therefore __NR_O32_Linux is used (4000)
> > +	 */
> > +
> > +	subu	t2, v0,  __NR_O32_Linux
> > +	bnez	t2, 1f /* __NR_syscall at offset 0 */
> > +	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
> > +	b	2f
> > +1:
> > +	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
> > +2:
> > +
> >  	li	t1, _TIF_WORK_SYSCALL_ENTRY
> >  	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
> >  	and	t0, t1, t0
> > @@ -113,22 +129,7 @@ trace_a_syscall:
> >  	sd	a7, PT_R11(sp)		# For indirect syscalls
> > 
> >  	move	a0, sp
> > -	/*
> > -	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
> > -	 * where the real syscall number is in a0
> > -	 * note: NR_syscall is the first O32 syscall but the macro is
> > -	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
> > -	 * therefore __NR_O32_Linux is used (4000)
> > -	 */
> > -	.set	push
> > -	.set	reorder
> > -	subu	t1, v0,  __NR_O32_Linux
> > -	move	a1, v0
> > -	bnez	t1, 1f /* __NR_syscall at offset 0 */
> > -	ld	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
> > -	.set	pop
> > -
> > -1:	jal	syscall_trace_enter
> > +	jal	syscall_trace_enter
> > 
> >  	bltz	v0, 1f			# seccomp failed? Skip syscall
> > 
> >
> > ---
> > base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
> > change-id: 20240328-mips_save_syscall-be471311cc9b
> >
> > Best regards,
> > -- 
> > Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> -- 
> - Jiaxun
> 


