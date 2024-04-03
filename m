Return-Path: <linux-kernel+bounces-130686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8F897BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12F8B28CA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0B815698B;
	Wed,  3 Apr 2024 22:30:04 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962C15696E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183403; cv=none; b=bzxvUgG3+DnWTE4K+MItfSVgNKwwoSyxOIIUT9so8dOPDu7JP0zMwAWrVmq7Z1X3ybXSLtWBgdQ7rhCF39haYYC0IQA8hkj4S0r3aCFHEPgVmK0rXngg/A3WhRwFljD4P3z1FYJxNMPDOAx9mKbK+u9IGTLltApg285kXJG/HpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183403; c=relaxed/simple;
	bh=IarqPtOGeX9xE43x5qiy9QWBMiHhpk4BQxNW4i0FHM8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmXyPV4obzzqNriZ2Fr9z7Ec13wl3oj1Fo7McGrTRIVDDJJEvZJVkh+FqGCjpYatl22klzJ4krYgKG1EF3elzZf0jthAGSUoOdFZffb4gQfOsYPxgsJbQcKi7/IXsKSmOM2AFGuQQa0PN7gP0W5Fq5c05NIbxc5+N/QhaxYL6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id b329e218-f209-11ee-abf4-005056bdd08f;
	Thu, 04 Apr 2024 01:29:59 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Apr 2024 01:29:56 +0300
To: Finn Thain <fthain@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq
 flood
Message-ID: <Zg3YZN-QupyVaTPm@surfacebook.localdomain>
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org>

Thu, Mar 28, 2024 at 03:11:33PM +1100, Finn Thain kirjoitti:
> The mitigation was intended to stop the irq completely. That might have
> been better than a hard lock-up but it turns out that you get a crash
> anyway if you're using pmac_zilog as a serial console.
> 
> That's because the pr_err() call in pmz_receive_chars() results in
> pmz_console_write() attempting to lock a spinlock already locked in
> pmz_interrupt(). With CONFIG_DEBUG_SPINLOCK=y, this produces a fatal
> BUG splat like the one below. (The spinlock at 0x62e140 is the one in
> struct uart_port.)
> 
> Even when it's not fatal, the serial port rx function ceases to work.
> Also, the iteration limit doesn't play nicely with QEMU. Please see
> bug report linked below.
> 
> A web search for reports of the error message "pmz: rx irq flood" didn't
> produce anything. So I don't think this code is needed any more. Remove it.

> [   14.560000] ttyPZ0: pmz: rx irq flood !
> [   14.560000] BUG: spinlock recursion on CPU#0, swapper/0
> [   14.560000]  lock: 0x62e140, .magic: dead4ead, .owner: swapper/0, .owner_cpu: 0
> [   14.560000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-mac-dbg-preempt-00004-g4143b7b9144a #1
> [   14.560000] Stack from 0059bcc4:
> [   14.560000]         0059bcc4 0056316f 0056316f 00002700 004b6444 0059bce4 004ad8c6 0056316f
> [   14.560000]         0059bd10 004a6546 00556759 0062e140 dead4ead 0059f892 00000000 00000000
> [   14.560000]         0062e140 0059bde8 005c03d0 0059bd24 0004daf6 0062e140 005567bf 0062e140
> [   14.560000]         0059bd34 004b64c2 0062e140 00000001 0059bd50 002e15ea 0062e140 00000001
> [   14.560000]         0059bde7 0059bde8 005c03d0 0059bdac 0005124e 005c03d0 005cdc00 0000002b
> [   14.560000]         005a3caa 005a3caa 00000000 0059bde8 0004ff00 0059be8b 00038200 000529ba
> [   14.560000] Call Trace: [<00002700>] ret_from_kernel_thread+0xc/0x14
> [   14.560000]  [<004b6444>] _raw_spin_lock+0x0/0x28
> [   14.560000]  [<004ad8c6>] dump_stack+0x10/0x16
> [   14.560000]  [<004a6546>] spin_dump+0x6e/0x7c
> [   14.560000]  [<0004daf6>] do_raw_spin_lock+0x9c/0xa6
> [   14.560000]  [<004b64c2>] _raw_spin_lock_irqsave+0x2a/0x34
> [   14.560000]  [<002e15ea>] pmz_console_write+0x32/0x9a
> [   14.560000]  [<0005124e>] console_flush_all+0x112/0x3a2
> [   14.560000]  [<0004ff00>] console_trylock+0x0/0x7a
> [   14.560000]  [<00038200>] parameq+0x48/0x6e
> [   14.560000]  [<000529ba>] __printk_safe_enter+0x0/0x36
> [   14.560000]  [<0005113c>] console_flush_all+0x0/0x3a2
> [   14.560000]  [<000542c4>] prb_read_valid+0x0/0x1a
> [   14.560000]  [<004b65a4>] _raw_spin_unlock+0x0/0x38
> [   14.560000]  [<0005151e>] console_unlock+0x40/0xb8
> [   14.560000]  [<00038200>] parameq+0x48/0x6e
> [   14.560000]  [<002c778c>] __tty_insert_flip_string_flags+0x0/0x14e
> [   14.560000]  [<00051798>] vprintk_emit+0x156/0x238
> [   14.560000]  [<00051894>] vprintk_default+0x1a/0x1e
> [   14.560000]  [<000529a8>] vprintk+0x74/0x86
> [   14.560000]  [<004a6596>] _printk+0x12/0x16
> [   14.560000]  [<002e23be>] pmz_receive_chars+0x1cc/0x394
> [   14.560000]  [<004b6444>] _raw_spin_lock+0x0/0x28
> [   14.560000]  [<00038226>] parse_args+0x0/0x3a6
> [   14.560000]  [<004b6466>] _raw_spin_lock+0x22/0x28
> [   14.560000]  [<002e26b4>] pmz_interrupt+0x12e/0x1e0
> [   14.560000]  [<00048680>] arch_cpu_idle_enter+0x0/0x8
> [   14.560000]  [<00054ebc>] __handle_irq_event_percpu+0x24/0x106
> [   14.560000]  [<004ae576>] default_idle_call+0x0/0x46
> [   14.560000]  [<00055020>] handle_irq_event+0x30/0x90
> [   14.560000]  [<00058320>] handle_simple_irq+0x5e/0xc0
> [   14.560000]  [<00048688>] arch_cpu_idle_exit+0x0/0x8
> [   14.560000]  [<00054800>] generic_handle_irq+0x3c/0x4a
> [   14.560000]  [<00002978>] do_IRQ+0x24/0x3a
> [   14.560000]  [<004ae508>] cpu_idle_poll.isra.0+0x0/0x6e
> [   14.560000]  [<00002874>] auto_irqhandler_fixup+0x4/0xc
> [   14.560000]  [<004ae508>] cpu_idle_poll.isra.0+0x0/0x6e
> [   14.560000]  [<004ae576>] default_idle_call+0x0/0x46
> [   14.560000]  [<004ae598>] default_idle_call+0x22/0x46
> [   14.560000]  [<00048710>] do_idle+0x6a/0xf0
> [   14.560000]  [<000486a6>] do_idle+0x0/0xf0
> [   14.560000]  [<000367d2>] find_task_by_pid_ns+0x0/0x2a
> [   14.560000]  [<0005d064>] __rcu_read_lock+0x0/0x12
> [   14.560000]  [<00048a5a>] cpu_startup_entry+0x18/0x1c
> [   14.560000]  [<00063a06>] __rcu_read_unlock+0x0/0x26
> [   14.560000]  [<004ae65a>] kernel_init+0x0/0xfa
> [   14.560000]  [<0049c5a8>] strcpy+0x0/0x1e
> [   14.560000]  [<004a6584>] _printk+0x0/0x16
> [   14.560000]  [<0049c72a>] strlen+0x0/0x22
> [   14.560000]  [<006452d4>] memblock_alloc_try_nid+0x0/0x82
> [   14.560000]  [<0063939a>] arch_post_acpi_subsys_init+0x0/0x8
> [   14.560000]  [<0063991e>] console_on_rootfs+0x0/0x60
> [   14.560000]  [<00638410>] _sinittext+0x410/0xadc
> [   14.560000]

First of all, please read this
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
and amend the commit message accordingly.

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: linux-m68k@lists.linux-m68k.org

Second, please move these Cc to be after the '---' line

> Link: https://github.com/vivier/qemu-m68k/issues/44
> Link: https://lore.kernel.org/all/1078874617.9746.36.camel@gaston/

Missed Fixes tag?

> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
(here is a good location for Cc:)

-- 
With Best Regards,
Andy Shevchenko



