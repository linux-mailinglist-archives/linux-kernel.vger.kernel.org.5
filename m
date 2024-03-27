Return-Path: <linux-kernel+bounces-122195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA30588F354
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC12C1C31376
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD91552F4;
	Wed, 27 Mar 2024 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtouuH+v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9115382F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711583071; cv=none; b=GG/qBBm+NG8+jdAhXtQvKsMYBcfZ+dtKOcs4Pz42M5gwv9IQjmGOaDgWmBBxAd3HNMjfmeyCG0urNfB/tS7Ru5VNB0NPmbwyQl7a3IOi7TB5aZfQmoo8obWsUpd+8dhxvRJgajVbvXu/JdtHHv8jW07ci3zSI4J4JsDf0UyKycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711583071; c=relaxed/simple;
	bh=5z+lLKmbGQmLcjzHz2sWRj1qwMwM3a25xNX+FwluHX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebEPBA3wik1z8ZIaoofhXNt4GMzgsujHHZRgAwjFe+JiaiFhdegCdoP49TRkQmUr7AdOVHZe8VQBOA1i1cEs2VcDkOzTSwZuZsBg0dGEjLqP02IO0zbyoBkS0IEaQcjHsPU2jQDsMe0ZOHAu1eIBpZg5so3luM8Uf0gQN9zO2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtouuH+v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711583068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhk9NYPfUweEFh6ve/NzzlDjLOgk0fwFo8nwSoTf6GU=;
	b=RtouuH+vZoCaqSRr1atqZRQ4acWWwvml4zR4Tqy9fpawd0idWLs9Rw+hifaEmfIogF4Qxc
	W1GFy9wo2qJ6Dbj2qvCtS6PMuGhEYEqVhRUtDZtu9attZ5PlhvJlBIl6d2FvPF12ilREiX
	A12u2GfnU9lFPta7F6SwuulPBPc1ctc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-w44-eessNJmNiN0f5A_VLA-1; Wed, 27 Mar 2024 19:44:23 -0400
X-MC-Unique: w44-eessNJmNiN0f5A_VLA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-60cc00203faso7044467b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711583063; x=1712187863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhk9NYPfUweEFh6ve/NzzlDjLOgk0fwFo8nwSoTf6GU=;
        b=oOYJzIv0reaWke5KUOxTDHnqfgBdjMzTBBAWc5NjWY3eNwGDq56YZra1rz2gHF8Ggg
         a6jQml1fkQxomI5wzb6mbB980o3A25OyRWNdYcZus3rRdhA+SjExSLQSAfrQZDv5iFOq
         oYQghsnQDm/UG5AQUhJ4pxXRfn+73XHF9xJu16hVg5oLoITokajjQH2M4wYbCRDX4p9B
         XckJz54u2buQEXka6VV6usF1t3kBi98caQnK3PljdeTzU7d7EPLAZdBTfDYuzqbbbbS7
         8apJUEljHsRf3SeYdMRQnvQPVyMmyubhD8/mpKTx6WI0ahcUHlQf1DvkPGBwrwlyrqQu
         bFWw==
X-Forwarded-Encrypted: i=1; AJvYcCWoQaGFyF0KUJNWkZErcppbuQECwFpE0Nwd+Vc20NKoxsQmhdmPyohER/LX60OKJlOYZfHY22zNI+hnDwIRB9HmE1WSpeUKAEaE9jfp
X-Gm-Message-State: AOJu0YwT50lF/StJz9dRCSyR4u55i3E725IeZ9zrzZjgTaX1/BUWB8a/
	vCc3tJCuT1XtCbyxCDGoFEWJVWRd7SFlVDS8+tZOQvImH/dVFPHccn5EWaLN4z2dL/EKKzThSAn
	XAcvK/dHv+hR5jy6WrKJomeI7S4oWqKVJwavwMHF/jiJ1vBLTAdAptHuGer5NFQ==
X-Received: by 2002:a81:7bc2:0:b0:613:f654:fbb2 with SMTP id w185-20020a817bc2000000b00613f654fbb2mr1114860ywc.33.1711583063026;
        Wed, 27 Mar 2024 16:44:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpv3qYfHMjiLZg+EzCeM+1gQR1vaA9VWToTC2dlQUPT586+OXEddkjGFmTdge74/HnI7Fbsg==
X-Received: by 2002:a81:7bc2:0:b0:613:f654:fbb2 with SMTP id w185-20020a817bc2000000b00613f654fbb2mr1114842ywc.33.1711583062614;
        Wed, 27 Mar 2024 16:44:22 -0700 (PDT)
Received: from thinkpad2021 ([71.217.52.195])
        by smtp.gmail.com with ESMTPSA id er7-20020a05622a5e8700b0043153615c82sm98098qtb.37.2024.03.27.16.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 16:44:22 -0700 (PDT)
Date: Wed, 27 Mar 2024 19:44:20 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Bruno Goncalves <bgoncalv@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMIs reported by console_blast.sh with 6.6.20-rt25
Message-ID: <ZgSvVCDja6yFCC0Y@thinkpad2021>
References: <ZfSfrzak9WS0ZFv7@thinkpad2021>
 <20240322122921.U3WRsO4X@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322122921.U3WRsO4X@linutronix.de>

On Fri, Mar 22, 2024 at 01:29:21PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-03-15 15:21:19 [-0400], John B. Wyatt IV wrote:
> The thing is that console_blast.sh does this "show a backtrace on all
> CPUs, please" which triggers NMIs on all CPUs for backtrace. I can't
> imagine how you did obtain the backtraces without an NMI. Unless the
> tuned profile disables this somehow.

I may have misapplied it. This is a very manual process right now due to
conserver.

> > -----------------------------
> > NMI Backtrace for 6.6.20-rt25 no forced preemption with tuned realtime profile
> > -----------------------------
> > 
> > [ T2614] Kernel panic - not syncing: sysrq triggered crash
> > [   C56] NMI backtrace for cpu 56
> > [   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
> > [ C56] RIP: 0010:io_serial_out (arch/x86/kernel/early_printk.c:105) 
> > [ C56] Code: 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 0f b6 8f c1 00 00 00 89 d0 0f b7 57 08 d3 e6 01 f2 ee <c3> cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90
> > All code
> > =======
> …
> >   12:	90                   	nop
> >   13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
> >   18:	0f b6 8f c1 00 00 00 	movzbl 0xc1(%rdi),%ecx
> >   1f:	89 d0                	mov    %edx,%eax
> >   21:	0f b7 57 08          	movzwl 0x8(%rdi),%edx
> >   25:	d3 e6                	shl    %cl,%esi
> >   27:	01 f2                	add    %esi,%edx
> >   29:	ee                   	out    %al,(%dx)
> >   2a:*	c3                   	ret		<-- trapping instruction
> 
> where is this output from? The `ret' opcode usually does not cause a
> trap. My guess is that the machine has been interrupted by an external
> user at this position.

Just before the sysrq that crashes the system.

[ T2618] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[ T2618]  </TASK>
[ T2618] task:kworker/185:0   state:I stack:0     pid:1131  ppid:2      flags:0x00004000
[ T2618] Workqueue:  0x0 (events)
[ T2618] Call Trace:
[ T2618]  <TASK>
[ T2618] __schedule (kernel/sched/core.c:5404 kernel/sched/core.c:6718) 
[ T2618] schedule (kernel/sched/core.c:6796 kernel/sched/core.c:6810) 
[ T2618] worker_thread (kernel/workqueue.c:2734) 
[ T2618] ? __pfx_worker_thread (kernel/workqueue.c:2727) 
[ T2618] kthread (kernel/kthread.c:388) 
[ T2618] ? __pfx_kthread (kernel/kthread.c:341) 
[ T2618] ret_from_fork (arch/x86/kernel/process.c:147) 
[ T2618] ? __pfx_kthread (kernel/kthread.c:341) 
[ T2618] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[ T2618]  </TASK>
[ T2614] sysrq: Trigger a crash
[ T2618] task:kworker/185:0H  state:I
[ T2618]  stack:0     pid:1132  ppid:2      flags:0x00004000
[ T2614] Kernel panic - not syncing: sysrq triggered crash
[   C56] NMI backtrace for cpu 56
[   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
[ C56] RIP: 0010:io_serial_out (arch/x86/kernel/early_printk.c:105) 
[ C56] Code: 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 0f b6 8f c1 00 00 00 89 d0 0f b7 57 08 d3 e6 01 f2 ee <c3> cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90

> Side note: This is using early_printk, correct?

I believe so, but it might be preempted? This is the part it stopped in.

static void io_serial_out(unsigned long addr, int offset, int value)
{
	outb(value, addr + offset);
}

> …
> 
> > [   C56] Call Trace:
> > [   C56]  <NMI>
> > [ C56] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115) 
> > [ C56] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discriminator 1)) 
> > [ C56] ? nmi_handle (arch/x86/kernel/nmi.c:149) 
> > [ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
> > [ C56] ? default_do_nmi (arch/x86/kernel/nmi.c:347) 
> > [ C56] ? exc_nmi (arch/x86/kernel/nmi.c:538) 
> > [ C56] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1458) 
> > [ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
> > [ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
> > [ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
> > [   C56]  </NMI>
> 
> This looks okay. The NMI did the backtrace as expected.
> 
> > [   C56]  <TASK>
> > [ C56] serial8250_console_putchar (./include/linux/serial_core.h:704 drivers/tty/serial/8250/8250_port.c:3347) 
> > [ C56] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_port.c:3343) 
> > [ C56] uart_console_write (drivers/tty/serial/serial_core.c:2134) 
> > [ C56] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c:3628) 
> > [ C56] nbcon_emit_next_record (kernel/printk/nbcon.c:940) 
> > [ C56] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1192 (discriminator 1) kernel/printk/nbcon.c:1326 (discriminator 1)) 
> > [ C56] vprintk_emit (kernel/printk/printk.c:2414) 
> > [ C56] _printk (kernel/printk/printk.c:2474) 
> > [ C56] panic (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/panic.c:528 kernel/panic.c:339) 
> > [ C56] ? _printk (kernel/printk/printk.c:2474) 
> > [ C56] sysrq_handle_crash (drivers/tty/sysrq.c:154) 
> > [ C56] __handle_sysrq (drivers/tty/sysrq.c:601) 
> > [ C56] write_sysrq_trigger (drivers/tty/sysrq.c:1165) 
> > [ C56] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352) 
> > [ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (discriminator 1) kernel/sched/core.c:5872 (discriminator 1)) 
> > [ C56] vfs_write (fs/read_write.c:582) 
> > [ C56] ksys_write (fs/read_write.c:637) 
> > [ C56] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:81) 
> > [ C56] ? do_dup2 (fs/file.c:1142) 
> > [ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
> > [ C56] ? do_syscall_64 (arch/x86/entry/common.c:88) 
> > [ C56] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
> > [ C56] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
> 
> According to this, someone issued a `crash' via sysrq. Why?
> 

This is part of the console_blast.sh script that John Ogness sent me.

Please see below:

#!/bin/bash
set -e

# This script is intended to be started with no arguments.
#
# It then calls itself to create a pinned process for each CPU. Those
# child processes will run in infinite loops of show-task-states via
# /proc/sysrq-trigger. This generates lots of contention on the console.
#
# Finally, it waits 10 seconds before crashing the system.

if [ $# -eq 0 ]; then
	cpus=$(($(nproc) - 1))
	for i in $(seq 0 $cpus); do
		$0 $i &
	done

	sleep 15
	echo c > /proc/sysrq-trigger
	exit 0
fi

# Setup the CPU mask for the provided CPU number. The real taskset(1)
# could simply use -c, but the busybox(1) variant does not support this.
mask=$(printf "0x%x\n" $((1 << $1)))
taskset -p $mask $$

# Wait a moment before beginning blast.
sleep 2

while true; do
	echo t > /proc/sysrq-trigger
done

> > NMI Backtrace for 6.6.20-rt25 no forced preemption with tuned throughput-performance profile
> > -----------------------------
> 
> This and the following backtrace shows the same picture: The CPU is
> crashing due to proc/sysrq request and does CPU-backtraces via NMI and
> polls in early_printk, waiting for the UART to become idle (probably).
> 
> I don't see an issue here so far.

Luis Goncalves discussed it with me after reading your response. Thank
you for your help. The NMI was needed to flush the buffers upon the
system crashing itself. Does this part about NMI watchdog need to be
documented?

-- 
Sincerly,
John Wyatt
Software Engineer, Core Kernel


