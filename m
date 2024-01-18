Return-Path: <linux-kernel+bounces-29955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FDF8315C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CB71F27F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F651D533;
	Thu, 18 Jan 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ntNZPhFf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312DE1F922;
	Thu, 18 Jan 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570072; cv=none; b=RDPgU7MhMUgTkwziOggq/EQ+eNOnqSv3UFxm9jfmj0Kz2Z2uJN9MexN1hSjyai2NKLwR5MyHcgB6Ky2mGh0U5L96ZSbDVX7bpsg6OMzzOAJZnBIt4/0RDzKA6tU+exrARaDEKTxrQ4yqw/E+kOCBgWqJrY8FU4w6y3JtH00pms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570072; c=relaxed/simple;
	bh=OdevsDZe2JFSnufBy9YDpl2ctaeieZIOsJdm8U6jml0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=CccpmEiiGuD5pt9Q8HiXGIUrWoLsdzVa2nWojJy/uY9B/Jp+4rPGiv6E/d8bTGVglFG7vc8Pl5tgY/u9g0xeNqdbfPUaQ32sy/gQR6oR07MMM8Tvak6ZNQdpu/VDKBhUoc53uKrutKNmEpzX5cLQ/748Z8jCrZIhOKWxO4LxEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ntNZPhFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA1BC43390;
	Thu, 18 Jan 2024 09:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705570071;
	bh=OdevsDZe2JFSnufBy9YDpl2ctaeieZIOsJdm8U6jml0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ntNZPhFfiYF48VAF0GU9/xT6e6ghwtvNk9U40W2fEiJaySGZ1fHbDr8o+4XheyjuV
	 PAwlta+HRFlWfkYL9xPrIvNT5hz4rw8Sh8Y50lpDXUzd7nNwOzomtm3HVH2sRe4Zdn
	 JhCJH+SNZPf2/MF2N454jgdSX4ZamjFSCCkZJUQ4=
Date: Thu, 18 Jan 2024 10:27:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: patches@amperecomputing.com, rafael@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	yury.norov@gmail.com, kuba@kernel.org, vschneid@redhat.com,
	mingo@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz,
	rppt@kernel.org, tglx@linutronix.de, jpoimboe@kernel.org,
	ndesaulniers@google.com, mikelley@microsoft.com,
	mhiramat@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org,
	cl@os.amperecomputing.com
Subject: Re: [PATCH] init: refactor the generic cpu_to_node for NUMA
Message-ID: <2024011820-path-throat-b7c8@gregkh>
References: <20240118031412.3300-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118031412.3300-1-shijie@os.amperecomputing.com>

On Thu, Jan 18, 2024 at 11:14:12AM +0800, Huang Shijie wrote:
> (0) We list the ARCHs which support the NUMA:
>        arm64, loongarch, powerpc, riscv,
>        sparc, mips, s390, x86,

I do not understand this format, what are you saying here?

Have you read the kernel documentation for how to write changelog texts?
It doesn't say "list a bunch of things", it's a bit more descriptive.

> 
> (1) Some ARCHs in (0) override the generic cpu_to_node(), such as:
>        sparc, mips, s390, x86.
> 
>     Since these ARCHs have their own cpu_to_node(), we do not care
>     about them.
> 
> (2) The ARCHs enable NUMA and use the generic cpu_to_node.
>     From (0) and (1), we can know that four ARCHs support NUMA and
>     use the generic cpu_to_node:
>         arm64, loongarch, powerpc, riscv,
> 
>     The generic cpu_to_node depends on percpu "numa_node".
> 
>     (2.1) The loongarch sets "numa_node" in:
>           start_kernel --> smp_prepare_boot_cpu()
> 
>     (2.2) The arm64, powerpc, riscv set "numa_node" in:
>        	  start_kernel --> arch_call_rest_init() --> rest_init()
>        	               --> kernel_init() --> kernel_init_freeable()
>                        --> smp_prepare_cpus()
> 
>     (2.3) The first place calling the cpu_to_node() is early_trace_init():
>           start_kernel --> early_trace_init()--> __ring_buffer_alloc()
> 	               --> rb_allocate_cpu_buffer()
> 
>     (2.4) So it safe for loongarch. But for arm64, powerpc and riscv,
>           there are at least four places in the common code where
> 	  the cpu_to_node() is called before it is initialized:
> 	   a.) early_trace_init()         in kernel/trace/trace.c
> 	   b.) sched_init()               in kernel/sched/core.c
> 	   c.) init_sched_fair_class()    in kernel/sched/fair.c
> 	   d.) workqueue_init_early()     in kernel/workqueue.c
> 
> (3) In order to fix the issue, the patch refactors the generic cpu_to_node:
>     (3.1) change cpu_to_node to function pointer,
>           and export it for kernel modules.
> 
>     (3.2) introduce _cpu_to_node() which is the original cpu_to_node().
> 
>     (3.3) introduce smp_prepare_boot_cpu_start() to wrap the original
>           smp_prepare_boot_cpu(), and set cpu_to_node with
> 	  early_cpu_to_node which works fine for arm64, powerpc,
> 	  riscv and loongarch.
> 
>     (3.4) introduce smp_prepare_cpus_done() to wrap the original
>           smp_prepare_cpus().
> 	  The "numa_node" is ready after smp_prepare_cpus(),
> 	  then set cpu_to_node with _cpu_to_node().

When you start listing different things in a changelog, that's a hint to
the reviewer to say "please break this up" as patches need to do only
one thing at a time.  As I can't follow the above text at all, that's
all the review comments I'm able to give here, sorry.

But as-is, this isn't acceptable :(

thanks,

greg k-h

