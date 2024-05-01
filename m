Return-Path: <linux-kernel+bounces-165641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37CF8B8EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1AE1F216FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0838C1B59A;
	Wed,  1 May 2024 17:24:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150F18C08;
	Wed,  1 May 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584258; cv=none; b=eymU2cdFcUW6R7PQGAqIaapIvAu4JlA1QakKZXciA4VkDYkwqZUeOBpOXDfvC4NaEJems3lasXlLFdRvPZl+aTfbynTyoecuS2p3piS0GVMthR2/8Ti4MyqJh0jCSI4TnufdxwFOhseQBrIu4y7fHRkFzGpHSg5eZKlkVx1xze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584258; c=relaxed/simple;
	bh=l3KI1mpm3TLzcA+uIN1rJJ4uvAsCdYr6Lv0kEgC1Fmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlSQAI+PHahM+RKuB+SFuYxRvbO5soPogUOmPCsEbYCZxWGM36Bt71EoETadFDEdwzDmcS1Vaw6QMU1G19hVL7W7K7fkF4b+U2uziKBYrcuNaIgkD4CHmYjBQIyaKtuUbeNSDgqWm+aWnkjjPAQqC6KOT9rpThNSm5AFPs+s1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622E2C072AA;
	Wed,  1 May 2024 17:24:14 +0000 (UTC)
Date: Wed, 1 May 2024 13:24:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Guo Ren <guoren@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller
 <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Subject: Re: [PATCH v3] kprobe/ftrace: bail out if ftrace was killed
Message-ID: <20240501132458.3ea28f6b@gandalf.local.home>
In-Reply-To: <20240501162956.229427-1-stephen.s.brennan@oracle.com>
References: <20240501162956.229427-1-stephen.s.brennan@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 May 2024 09:29:56 -0700
Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> If an error happens in ftrace, ftrace_kill() will prevent disarming
> kprobes. Eventually, the ftrace_ops associated with the kprobes will be
> freed, yet the kprobes will still be active, and when triggered, they
> will use the freed memory, likely resulting in a page fault and panic.
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
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
> Changes in v3:
>   Don't expose ftrace_is_dead(). Create a "kprobe_ftrace_disabled"
>   variable and check it directly in the kprobe handlers.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks,

-- Steve

