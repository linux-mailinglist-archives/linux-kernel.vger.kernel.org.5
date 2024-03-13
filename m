Return-Path: <linux-kernel+bounces-101343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E419587A5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924D51F2398F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D19D3B297;
	Wed, 13 Mar 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4fAOocrd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tKWI8G0v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA839AF5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325428; cv=none; b=klr+nCXPfg8L1kgH2WN1Q6/JBemQAK3gIjXBNNs13WAWKap71zKBF6155r4JvglPCCRrHjJmr6xSVLy9oLSNATHv3LiDqFFw19+jJJ+tfj8Se5V89uLmVvR2l9w7MYKMWEvwLB9+5EwVqxpIMCt0QNtYddyOP0n82zbU7NkYtvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325428; c=relaxed/simple;
	bh=nK3QjjpaX3/0ZIKsnAmkPj0Jlh5rS5f3t2spCRnENEY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EnX4pN26MLACrgouLxovVxKPyByyQ1l6aXz6AP7GWum5dMnQs88Js/Xzz8f/MUur2Ni0I1umyYiZm9wIRE0CrWc/Sb18Ra/mRUj+JeG9Gtww++X4rC6itBfj+qj/HPfUNRBSY/4HAeN62/WoM/gPNXtYvO3I6Yle6miYFEchQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4fAOocrd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tKWI8G0v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710325425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhPElN2nsY3pxw/EXeL4pxaimHbX1HxGdoLyxOF3Llc=;
	b=4fAOocrdQLqbqEnuhF3QEKD4N8wegjJrGROjzJgJDJsL7/j8xWz01piO1Hd5jt51Pr+21i
	sWanXRgRl2ysMjiFYFlm2krq/bcGcjF3RT9uqpRp3V0OCt7b7hNMgSJTDxvACLXd9P7EPj
	m9HbTevohFHt2QtXjPb9RvuBSjpbdDPWvfkBckCbDuCTjdMHe2a3c0PDQBi3ubZy6479Ey
	fJzmHRG6jmKIwxzVBVJdbJNko2zh7TvDl4K1i25OVVkfesw4maNJw/dWbW+OqEz9Kod6ym
	STXs//cn1vIYPjXH/PX70JZ2dYzIODQRqso2zs1Mo8QpBEpum5tlQFEmkXoU9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710325425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhPElN2nsY3pxw/EXeL4pxaimHbX1HxGdoLyxOF3Llc=;
	b=tKWI8G0vruTW/ZBmFCpE3SD4QiODxfUx+s/fIoS4UlFpH6KqtECQ60yeBRh5+VfxTjqBMD
	nuzTl6nq5Z45cDAg==
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de,
 brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
 dave.hansen@linux.intel.com, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 hch@infradead.org, hpa@zytor.com, jacob.jun.pan@linux.intel.com,
 jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com,
 kent.overstreet@linux.dev, kinseyho@google.com,
 kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org,
 mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com,
 mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com,
 peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com,
 rostedt@goodmis.org, surenb@google.com, urezki@gmail.com,
 vincent.guittot@linaro.org, vschneid@redhat.com, pasha.tatashin@soleen.com
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
In-Reply-To: <20240311164638.2015063-12-pasha.tatashin@soleen.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
Date: Wed, 13 Mar 2024 11:23:44 +0100
Message-ID: <87v85qo2fj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 11 2024 at 16:46, Pasha Tatashin wrote:
> @@ -413,6 +413,9 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
>  	}
>  #endif
>  
> +	if (dynamic_stack_fault(current, address))
> +		return;
> +
>  	irqentry_nmi_enter(regs);
>  	instrumentation_begin();
>  	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index d6375b3c633b..651c558b10eb 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1198,6 +1198,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
>  	if (is_f00f_bug(regs, hw_error_code, address))
>  		return;
>  
> +	if (dynamic_stack_fault(current, address))
> +		return;

T1 schedules out with stack used close to the fault boundary.

   switch_to(T2)

Now T1 schedules back in

   switch_to(T1)
     __switch_to_asm()
        ...
        switch_stacks()         <- SP on T1 stack
!        ...                    
!       jmp __switch_to()
!    __switch_to()
!       ...
!       raw_cpu_write(pcpu_hot.current_task, next_p);

After switching SP to T1's stack and up to the point where
pcpu_hot.current_task (aka current) is updated to T1 a stack fault will
invoke dynamic_stack_fault(T2, address) which will return false here:

	/* check if address is inside the kernel stack area */
	stack = (unsigned long)tsk->stack;
	if (address < stack || address >= stack + THREAD_SIZE)
		return false;

because T2's stack does obviously not cover the faulting address on T1's
stack. As a consequence double fault will panic the machine.

Thanks,

        tglx

