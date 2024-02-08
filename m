Return-Path: <linux-kernel+bounces-57354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F384D744
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750D51C22710
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3668B1C283;
	Thu,  8 Feb 2024 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/DlQdht"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07414F68
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353039; cv=none; b=rbU0Qv3/dXBM3PL7lI0KV7xY+Pl6OXTkCrv0L7wnDgsHts2M7kFbxODDUyeCrO4wmzFVUUk2iMeLySvYsDYF6rRsByxiUor+PLxxaFAGNwvxVJuONbixfzeBGQsJeFPB+WQwxpQHK7WZQR54Apr+BTch64n5miDzU0BAm9oir3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353039; c=relaxed/simple;
	bh=I3PHxaREy7uG6m4WydOtNT36ktMoReFD4O5ZDdGfMJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lC8Y9iQwcxyYOCautFJ3jeC8RlgkV8P3F0FfgNpQdfBiYhS0WKOM6GD0RHs6VtG1yRxEFk1aiWtQ8szkH0PbIw8eIeZWLJ8oQNDDo9TKlSsD4hCgaf1zlsLrM+4LB2kQVN0TWIhBx3RvUDr7/wPivyoVqSlw1L9HCPqZUdPEbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/DlQdht; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707353035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wZTHy0v889IWfoR3nEfgdVjsFacIV4n4t/JV1cyfusA=;
	b=Q/DlQdhtHa0PfQWaO93Iw4RctWldnN/Lt2hIIeSc1IVn8pWiSIfWgZVuCz7r3lJutIKYew
	eDYWDq3d+uFJEgc6gpieKdcjXRoEcoVqIMQqKCNAk8/FsbCt7XaMfRrZvwYKriivi/dTjH
	rB0FZsZe4ExjXnq4oRtrHJ+1UwVmYQc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-lbZBmZXCOmajh21mTeEwZA-1; Wed, 07 Feb 2024 19:43:54 -0500
X-MC-Unique: lbZBmZXCOmajh21mTeEwZA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68c4f4bdcaaso21439526d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 16:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707353034; x=1707957834;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZTHy0v889IWfoR3nEfgdVjsFacIV4n4t/JV1cyfusA=;
        b=Cfa6lib5h1RvY4WYzuNH/lRSLmEh75VnB/fUi9FVPm26lzMJIIEH/PUgg57/f0+9GN
         JjW85sesp2IPEwkZ/ltPO34laUjEkHjox+OD/R+hYvETMJb9pXVutQbXEbds/ByVNj+F
         93UUQLlRRoSMiltfBmfsWMTjJXUgwxUxbnChPwRsgBOPm8cC7uCRaiNQMkX+hQAPHaiY
         qSBjnGWTTHyOFpByPvF7LfTQkPk+G0lsNVT8WnAjcDqIbSbuxgTdeH7SloW92cnJLiiC
         3eJgYfoyzhs99FCq7nDtxo8jMhPbfnQaQqPG43VL0RFX5A77yD8PKrm561G/OVvyACf5
         XnIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIx5LanaRytUiDL1JDCOuBXHcjIfaGoJxfCFOwUMIv22or8HRCgIM0Ts3q8TERSBLNtKI2/PDb7Ri34bumHw7oGmyi9zbBMROGbZrX
X-Gm-Message-State: AOJu0YzJHFBOTbK569MGgG2YszSlqeZiPshKI3EHYIQwY1qa/2LTRPH4
	Kez0mNa2it1e4t5C5ZCtIAdlBOXuUh1cowX97u3ZMfav0+yUfJx/nspp3vJuRRabM0xwPpIQISE
	H/lj09a1q4O7QYr9Eu3wcglE1gk4c0bus5ddAleFlmi4u62EHp9569cKDFq0LVA==
X-Received: by 2002:a05:6214:1c0c:b0:68c:6824:42e with SMTP id u12-20020a0562141c0c00b0068c6824042emr8832733qvc.62.1707353033555;
        Wed, 07 Feb 2024 16:43:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnFVi+ySoAf6ZJed2uSS9UokjJmJruWLUaD/V2ZViUT7vNuWw7Pr+ZMFCQimVPtnD0vCNfWg==
X-Received: by 2002:a05:6214:1c0c:b0:68c:6824:42e with SMTP id u12-20020a0562141c0c00b0068c6824042emr8832715qvc.62.1707353033129;
        Wed, 07 Feb 2024 16:43:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFTxcKfb/4KYivOSnqCrz0favsL+KjSiO7jRbxtaahiwNgRf5J32GC6nZfRCij3Xd/h4ieziJeHxskhx1RDnljVZEE0VDctFzRIYubEFjnzHgnZumWFPzWZDmSHx6uSdqSO05HUwy20pp2YN+uzGsV+E5Y+ujxhFqsgg/A3jyJGg3SSA1pjamH9mXZq1FdA96wyVfWgxOiPUqo7NaKG4bVMlgtVJ+HPMGRJYqwkVBx2TT1uuVDw34DY7ToEN/SFNNzEQ==
Received: from thinkpad2021 ([71.217.33.204])
        by smtp.gmail.com with ESMTPSA id ng8-20020a0562143bc800b0068c9d0561d1sm1089880qvb.83.2024.02.07.16.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 16:43:52 -0800 (PST)
Date: Wed, 7 Feb 2024 19:43:49 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
	jlelli@redhat.com, Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: NMI Reported with console_blast.sh
Message-ID: <ZcQjxa4UA6hzXHnU@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello John,

You asked me to test the upstream kernel with a printk torture (console_blash.sh) with the different scheduler settings on a very large core system. Wanted to post to the mailing list to show what I tested with.

As far as I can tell; all the scheduler settings correctly get to and trip the sysrq trigger to make it crash at the end of the script.

But, with every state, except for fully pre-emeptive, I got an NMI call trace before the sysrq trigger that expectedly crashes the system.

This is on a Fedora 39 Server installed on a 2x56 core, 224 thread machine in Red Hat's lab with the lscpu below with 6.7.0-rt6. I have only decoded and attached NoForcedPreemption below. Please ask if you want additional ones but they all look similar when I checked.

CCing Derek who is handling the printk backport and my personal email
for kernel development.

NMI Call Trace for NoForcedPreemption
---
task:cpuhp/222       state:S stack:0     pid:1349  tgid:1349  ppid:2      flags:0x00004000
Call Trace:
<TASK>
__schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
? try_to_wake_up (./arch/x86/include/asm/preempt.h:104 ./include/linux/preempt.h:484 ./include/linux/preempt.h:484 kernel/sched/core.c:4217) 
? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
smpboot_thread_fn (kernel/smpboot.c:160) 
kthread (kernel/kthread.c:388) 
? __pfx_kthread (kernel/kthread.c:341) 
ret_from_fork (arch/x86/kernel/process.c:147) 
? __pfx_kthread (kernel/kthread.c:341) 
ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
</TASK>
sysrq: Trigger a crash
Kernel panic - not syncing: sysrq triggered crash
NMI backtrace for cpu 56
Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
RIP: 0010:io_serial_in (arch/x86/kernel/early_printk.c:100) 
Code: cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 0f b6 8f c1 00 00 00 0f b7 57 08 d3 e6 01 f2 ec <0f> b6 c0 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	cc                   	int3
   1:	0f 1f 40 00          	nopl   0x0(%rax)
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	0f b6 8f c1 00 00 00 	movzbl 0xc1(%rdi),%ecx
  21:	0f b7 57 08          	movzwl 0x8(%rdi),%edx
  25:	d3 e6                	shl    %cl,%esi
  27:	01 f2                	add    %esi,%edx
  29:	ec                   	in     (%dx),%al
  2a:*	0f b6 c0             	movzbl %al,%eax		<-- trapping instruction
  2d:	c3                   	ret
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	0f 1f 00             	nopl   (%rax)
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f b6 c0             	movzbl %al,%eax
   3:	c3                   	ret
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	0f 1f 00             	nopl   (%rax)
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
RSP: 0018:ff4f21361ec27b28 EFLAGS: 00000002
RAX: ffffffff863d6e00 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffff88ad49c0
RBP: 000000000000270d R08: ffffffff889c73ab R09: 0000000000ffff0a
R10: 0000000000000005 R11: 0000000000000002 R12: 0000000000000020
R13: ffffffff88ad49c0 R14: 0000000000000000 R15: 0000000000000000
FS:  00007faac4483740(0000) GS:ff4f03763f600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faac465f650 CR3: 0000002085d0e006 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<NMI>
? nmi_cpu_backtrace (lib/nmi_backtrace.c:115) 
? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discriminator 1)) 
? nmi_handle (arch/x86/kernel/nmi.c:150) 
? io_serial_in (arch/x86/kernel/early_printk.c:100) 
? default_do_nmi (arch/x86/kernel/nmi.c:351) 
? exc_nmi (arch/x86/kernel/nmi.c:545) 
? end_repeat_nmi (arch/x86/entry/entry_64.S:1394) 
? mem16_serial_out (drivers/tty/serial/8250/8250_port.c:375) 
? io_serial_in (arch/x86/kernel/early_printk.c:100) 
? io_serial_in (arch/x86/kernel/early_printk.c:100) 
? io_serial_in (arch/x86/kernel/early_printk.c:100) 
</NMI>
<TASK>
wait_for_xmitr (drivers/tty/serial/8250/8250.h:117 drivers/tty/serial/8250/8250.h:139 drivers/tty/serial/8250/8250_port.c:2098 drivers/tty/serial/8250/8250_port.c:2116) 
serial8250_console_putchar (./include/linux/serial_core.h:703 drivers/tty/serial/8250/8250_port.c:3339) 
? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_port.c:3335) 
uart_console_write (drivers/tty/serial/serial_core.c:2105) 
serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c:3620) 
nbcon_emit_next_record (kernel/printk/nbcon.c:940) 
__nbcon_atomic_flush_all (kernel/printk/nbcon.c:1192 (discriminator 1) kernel/printk/nbcon.c:1326 (discriminator 1)) 
vprintk_emit (kernel/printk/printk.c:2413) 
_printk (kernel/printk/printk.c:2473) 
panic (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/panic.c:532 kernel/panic.c:343) 
? _printk (kernel/printk/printk.c:2473) 
sysrq_handle_crash (drivers/tty/sysrq.c:154) 
__handle_sysrq (drivers/tty/sysrq.c:601) 
write_sysrq_trigger (drivers/tty/sysrq.c:1165) 
proc_reg_write (fs/proc/inode.c:337 fs/proc/inode.c:349) 
? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5839 (discriminator 1) kernel/sched/core.c:5836 (discriminator 1) kernel/sched/core.c:5864 (discriminator 1)) 
vfs_write (fs/read_write.c:582) 
? __do_sys_newfstatat (fs/stat.c:466 (discriminator 1)) 
ksys_write (fs/read_write.c:637) 
do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
? do_syscall_64 (arch/x86/entry/common.c:102) 
? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1515 arch/x86/mm/fault.c:1563) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
RIP: 0033:0x7faac458ec74
Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d f5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
All code
========
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d f5 76 0d 00 00 	cmpb   $0x0,0xd76f5(%rip)        # 0xd7716
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
RSP: 002b:00007ffd2e5539b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007faac458ec74
RDX: 0000000000000002 RSI: 00005580d5ed8490 RDI: 0000000000000001
RBP: 00007ffd2e5539e0 R08: 0000000000000410 R09: 0000000000000001
R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002
R13: 00005580d5ed8490 R14: 00007faac465f5c0 R15: 00007faac465cf20
</TASK>
Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:107) 
panic (kernel/panic.c:344) 
? _printk (kernel/printk/printk.c:2473) 
sysrq_handle_crash (drivers/tty/sysrq.c:154) 
__handle_sysrq (drivers/tty/sysrq.c:601) 
write_sysrq_trigger (drivers/tty/sysrq.c:1165) 
proc_reg_write (fs/proc/inode.c:337 fs/proc/inode.c:349) 
? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5839 (discriminator 1) kernel/sched/core.c:5836 (discriminator 1) kernel/sched/core.c:5864 (discriminator 1)) 
vfs_write (fs/read_write.c:582) 
? __do_sys_newfstatat (fs/stat.c:466 (discriminator 1)) 
ksys_write (fs/read_write.c:637) 
do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
? do_syscall_64 (arch/x86/entry/common.c:102) 
? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1515 arch/x86/mm/fault.c:1563) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
RIP: 0033:0x7faac458ec74
Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d f5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
All code
========
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d f5 76 0d 00 00 	cmpb   $0x0,0xd76f5(%rip)        # 0xd7716
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
RSP: 002b:00007ffd2e5539b8 EFLAGS: 00000202
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007faac458ec74
RDX: 0000000000000002 RSI: 00005580d5ed8490 RDI: 0000000000000001
RBP: 00007ffd2e5539e0 R08: 0000000000000410 R09: 0000000000000001
R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002
R13: 00005580d5ed8490 R14: 00007faac465f5c0 R15: 00007faac465cf20
</TASK>
Shutting down cpus with NMI
Kernel Offset: 0x4c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: sysrq triggered crash ]---
---

lscpu
---
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         52 bits physical, 57 bits virtual
  Byte Order:            Little Endian
CPU(s):                  224
  On-line CPU(s) list:   0-223
Vendor ID:               GenuineIntel
  BIOS Vendor ID:        Intel(R) Corporation
  Model name:            Intel (R) Xeon (R) CPU Max 9480
    BIOS Model name:     Intel (R) Xeon (R) CPU Max 9480  CPU @ 1.9GHz
    BIOS CPU family:     179
    CPU family:          6
    Model:               143
    Thread(s) per core:  2
    Core(s) per socket:  56
    Socket(s):           2
    Stepping:            8
    CPU(s) scaling MHz:  23%
    CPU max MHz:         3500.0000
    CPU min MHz:         800.0000
    BogoMIPS:            3800.00
    Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art
                          arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xt
                         pr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cat_l2 cdp_l3 intel_
                         ppin cdp_l2 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx
                         512dq rdseed adx smap avx512ifma clflushopt clwb intel_pt avx512cd sha_ni avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mb
                         m_local split_lock_detect user_shstk avx_vnni avx512_bf16 wbnoinvd dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512vbmi umip pku ospke wait
                         pkg avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg tme avx512_vpopcntdq la57 rdpid bus_lock_detect cldemote movdiri movdir64b enqcmd fsrm md_clear seria
                         lize tsxldtrk pconfig arch_lbr ibt amx_bf16 avx512_fp16 amx_tile amx_int8 flush_l1d arch_capabilities
Virtualization features: 
  Virtualization:        VT-x
Caches (sum of all):     
  L1d:                   5.3 MiB (112 instances)
  L1i:                   3.5 MiB (112 instances)
  L2:                    224 MiB (112 instances)
  L3:                    225 MiB (2 instances)
NUMA:                    
  NUMA node(s):          16
  NUMA node0 CPU(s):     0-13,112-125
  NUMA node1 CPU(s):     14-27,126-139
  NUMA node2 CPU(s):     28-41,140-153
  NUMA node3 CPU(s):     42-55,154-167
  NUMA node4 CPU(s):     56-69,168-181
  NUMA node5 CPU(s):     70-83,182-195
  NUMA node6 CPU(s):     84-97,196-209
  NUMA node7 CPU(s):     98-111,210-223
  NUMA node8 CPU(s):     
  NUMA node9 CPU(s):     
  NUMA node10 CPU(s):    
  NUMA node11 CPU(s):    
  NUMA node12 CPU(s):    
  NUMA node13 CPU(s):    
  NUMA node14 CPU(s):    
  NUMA node15 CPU(s):    
Vulnerabilities:         
  Gather data sampling:  Not affected
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Mmio stale data:       Not affected
  Retbleed:              Not affected
  Spec rstack overflow:  Not affected
  Spec store bypass:     Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:            Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:            Mitigation; Enhanced / Automatic IBRS, IBPB conditional, RSB filling, PBRSB-eIBRS SW sequence
  Srbds:                 Not affected
  Tsx async abort:       Not affected
---

console_blast.sh
---
#!/bin/sh
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
---


