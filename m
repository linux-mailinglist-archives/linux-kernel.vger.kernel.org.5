Return-Path: <linux-kernel+bounces-123149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E668902FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23751293022
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A82212F360;
	Thu, 28 Mar 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aenOfU0z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6E42061
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639524; cv=none; b=DEJjjU/H7uovBEW8Fua87etBYoSBbOL91x58dF/9oHIBtshJtNtqlVVa+jmVDjJSi6WwHzUVuMPdrVUa0mw+WvSe55CFTlnf0oyLw8lUcZrON03neHx6uN3WHKtLeycuAUcRcTnUPFN4qa+EuBW3TmD+X9qvUVX4AHqXosFXLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639524; c=relaxed/simple;
	bh=c9g5mwSpVy3hiMoth92zcsO4xxWRRkLQ3kv/xtNYjA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oedLF73qxkRJIvdFaldrAab8y207pgdnzYmUCxcKEXwVRp16XSAMxfWRIhdUflBu8rJkv+ZmUZrkDKJohKryGxYHsnq8wu7z2p5tzGXDP2hBGH/uyx1oPLe+lQW+t1lhA7fVECiJfSpZyVFExd4ulTGArWBI09Dukp8xfB9jeHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aenOfU0z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711639520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ofPVa/BdlOYuNMFk2CErIL7QvXQvd+LBg/dx9Ue/pSY=;
	b=aenOfU0zag/FQ81ZajcYdc3n5zhnFXNdubS1DcntpwSIhDBYYPCT3S0odC0z9PM0BiL9mz
	e0Rmrg5ZwRhk98SAjsDxc7fAgD1w4dXp+cW9JKa96Xo7caUDvHsSvK/n+5xZu/uPi49f32
	FB4j/88iJua5jY77xhMYdXzH2LudH0U=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-Nzn11KBJNwi3cVc8xxVzAA-1; Thu, 28 Mar 2024 11:25:19 -0400
X-MC-Unique: Nzn11KBJNwi3cVc8xxVzAA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c3d7e8b1a4so897744b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639518; x=1712244318;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofPVa/BdlOYuNMFk2CErIL7QvXQvd+LBg/dx9Ue/pSY=;
        b=SUZJPihFLzi8UnA71YeRu9VR0S7GUjd6AArJNyphz03U1zdL+9xCEGeowH41eXflq5
         PCYQWMyp1MOryZ5WU5IdDTP44k5KOH6bypoq80q4Zm9yVM3DbFHctNPY0igmEV4Wqhqy
         sww5nNfeKriZqOdwTZMl+KukaFfZPXqgc5qKNIAKMKkZ9yAtYcircvvTLAeAt0hfLndj
         TzeDKLa9X2/wZDn5JEzjfFtespgIuaVrD4SV9sKMtXiAB/nN0/dQq/qSM+lKqkKcpTli
         VQp7CpAeS3z09RsIF7y3/jxQXLBLcOjXUN0v0PLTHWJQ6jyvgDbMCE6yRoYQurrj6S9Z
         NVYg==
X-Gm-Message-State: AOJu0YxMzULsPNvjcrki5IeGsjCgrzMBvtNWV2NyLE76WfMqc4EY976/
	Pr7TSA5UxTYTSdtc2aEhnxeOleiGRZ3wNScC9mBQuC4hX75mDtYCUXdfe0XjCTNUGOeHPg1K55a
	p/2r30MBb4+vykzfdEeSgqscPP58Habr0WUkM4apFZWUm0hFww7QwMNxh3plt9Qd3HlPf8kXvKv
	fSIqgqCIZshkt68ga6DT9U6oBj2wibItMn0X9XbkNq9aKhHA==
X-Received: by 2002:a05:6808:bc9:b0:3c3:80e4:94fb with SMTP id o9-20020a0568080bc900b003c380e494fbmr3248916oik.37.1711639517010;
        Thu, 28 Mar 2024 08:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbNhYx/dEJ9uEEwOCNUO8n6W9PhgjPi4GkWGn1nH3ChfQz+8eoftSwu4ZJI+e1crMKIwFi0Q==
X-Received: by 2002:a05:6808:bc9:b0:3c3:80e4:94fb with SMTP id o9-20020a0568080bc900b003c380e494fbmr3248854oik.37.1711639515991;
        Thu, 28 Mar 2024 08:25:15 -0700 (PDT)
Received: from thinkpad2021 ([71.217.52.195])
        by smtp.gmail.com with ESMTPSA id mf13-20020a0562145d8d00b006903af52cbfsm731983qvb.40.2024.03.28.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:25:15 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:25:13 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Cc: "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: 6.8-rt8 testing
Message-ID: <ZgWL2UyknaE2T70C@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello linux-rt-users,

Did a quick look over. The NMIs seem to trigger the same flush to console when
the system crashes that was previously seen in my 6.7 linked below with the
NMI watchdog. I reran the 6.6 test and no NMI was reported with fully
preemptive and the realtime tuned profile. It was user error. Posting more of
the complete debugging logs if you need to look them over.

Caller info was enabled. No modifications to the source code were made.

Link to lscpu and previous NMI reports:

https://lore.kernel.org/linux-rt-users/ZdUmpblrzX0pcPjz@thinkpad2021/T/#mec258264be95dcba23970def7b248af0c6e942b2

https://lore.kernel.org/linux-rt-users/ZfSfrzak9WS0ZFv7@thinkpad2021/

-----------------------------
NMI Backtraces for 6.8-rt8 no forced preemption with tuned realtime profile
-----------------------------


[ T2482] Kernel panic - not syncing: sysrq triggered crash
[   C56] NMI backtrace for cpu 56
[   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
[ C56] RIP: 0010:io_serial_out (arch/x86/kernel/early_printk.c:105) 
[ C56] Code: 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 0f b6 8f c1 00 00 00 89 d0 0f b7 57 08 d3 e6 01 f2 ee <c3> cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	0f 1f 00             	nopl   (%rax)
   3:	90                   	nop
   4:	90                   	nop
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
  13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  18:	0f b6 8f c1 00 00 00 	movzbl 0xc1(%rdi),%ecx
  1f:	89 d0                	mov    %edx,%eax
  21:	0f b7 57 08          	movzwl 0x8(%rdi),%edx
  25:	d3 e6                	shl    %cl,%esi
  27:	01 f2                	add    %esi,%edx
  29:	ee                   	out    %al,(%dx)
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	0f 1f 40 00          	nopl   0x0(%rax)
  33:	90                   	nop
  34:	90                   	nop
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
   0:	c3                   	ret
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	0f 1f 40 00          	nopl   0x0(%rax)
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
  15:	90                   	nop
[   C56] RSP: 0018:ff69eb60700bfa68 EFLAGS: 00000002
[   C56] RAX: 0000000000000020 RBX: ffffffff9349b980 RCX: 0000000000000000
[   C56] RDX: 00000000000003f8 RSI: 0000000000000000 RDI: ffffffff9349b980
[   C56] RBP: 0000000000000020 R08: 6e6e75725f726e5f R09: 2020202020676e69
[   C56] R10: 00000000682e2020 R11: 00000000682e2020 R12: ffffffff9349b980
[   C56] R13: ffffffff933cd49c R14: 0000000000000000 R15: 0000000000000000
[   C56] FS:  00007fa9252d9740(0000) GS:ff24b975ff600000(0000) knlGS:0000000000000000
[   C56] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   C56] CR2: 00007fa9254b5650 CR3: 0000002088d94003 CR4: 0000000000771ef0
[   C56] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   C56] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   C56] PKRU: 55555554
[   C56] Call Trace:
[   C56]  <NMI>
[ C56] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115) 
[ C56] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discriminator 1)) 
[ C56] ? nmi_handle (arch/x86/kernel/nmi.c:150) 
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
[ C56] ? default_do_nmi (arch/x86/kernel/nmi.c:351) 
[ C56] ? exc_nmi (arch/x86/kernel/nmi.c:545) 
[ C56] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1409) 
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
[   C56]  </NMI>
[   C56]  <TASK>
[ C56] serial8250_console_putchar (./include/linux/serial_core.h:704 drivers/tty/serial/8250/8250_port.c:3340) 
[ C56] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_port.c:3336) 
[ C56] uart_console_write (drivers/tty/serial/serial_core.c:2140) 
[ C56] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c:3621) 
[ C56] nbcon_emit_next_record (kernel/printk/nbcon.c:938) 
[ C56] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1191 (discriminator 1) kernel/printk/nbcon.c:1327 (discriminator 1)) 
[ C56] vprintk_emit (kernel/printk/printk.c:2424) 
[ C56] _printk (kernel/printk/printk.c:2484) 
[ C56] panic (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/panic.c:532 kernel/panic.c:343) 
[ C56] ? _printk (kernel/printk/printk.c:2484) 
[ C56] sysrq_handle_crash (drivers/tty/sysrq.c:154) 
[ C56] __handle_sysrq (drivers/tty/sysrq.c:601) 
[ C56] write_sysrq_trigger (drivers/tty/sysrq.c:1174) 
[ C56] proc_reg_write (fs/proc/inode.c:334 fs/proc/inode.c:346) 
[ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5863 (discriminator 1) kernel/sched/core.c:5860 (discriminator 1) kernel/sched/core.c:5888 (discriminator 1)) 
[ C56] vfs_write (fs/read_write.c:588) 
[ C56] ? __do_sys_newfstatat (fs/stat.c:471 (discriminator 1)) 
[ C56] ksys_write (fs/read_write.c:643) 
[ C56] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:215) 
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:215) 
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ C56] ? __count_memcg_events (mm/memcontrol.c:722 (discriminator 1) mm/memcontrol.c:961 (discriminator 1)) 
[ C56] ? handle_mm_fault (mm/memory.c:5347 mm/memory.c:5486) 
[ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5863 (discriminator 1) kernel/sched/core.c:5860 (discriminator 1) kernel/sched/core.c:5888 (discriminator 1)) 
[ C56] ? up_read (./arch/x86/include/asm/preempt.h:103 kernel/locking/rwsem.c:1354 kernel/locking/rwsem.c:1622) 
[ C56] ? do_user_addr_fault (arch/x86/mm/fault.c:1359) 
[ C56] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[   C56] RIP: 0033:0x7fa9253e4c94
[ C56] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
All code
========
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
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
[   C56] RSP: 002b:00007fff88bc8188 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   C56] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa9253e4c94
[   C56] RDX: 0000000000000002 RSI: 0000560b1e01f490 RDI: 0000000000000001
[   C56] RBP: 00007fff88bc81b0 R08: 0000000000000410 R09: 0000000000000001
[   C56] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002
[   C56] R13: 0000560b1e01f490 R14: 00007fa9254b55c0 R15: 00007fa9254b2f20
[   C56]  </TASK>
[   C56] NMI backtrace for cpu 56
[   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
[ C56] RIP: 0010:io_serial_out (arch/x86/kernel/early_printk.c:105) 
[ C56] Code: 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 0f b6 8f c1 00 00 00 89 d0 0f b7 57 08 d3 e6 01 f2 ee <c3> cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	0f 1f 00             	nopl   (%rax)
   3:	90                   	nop
   4:	90                   	nop
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
  13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  18:	0f b6 8f c1 00 00 00 	movzbl 0xc1(%rdi),%ecx
  1f:	89 d0                	mov    %edx,%eax
  21:	0f b7 57 08          	movzwl 0x8(%rdi),%edx
  25:	d3 e6                	shl    %cl,%esi
  27:	01 f2                	add    %esi,%edx
  29:	ee                   	out    %al,(%dx)
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	0f 1f 40 00          	nopl   0x0(%rax)
  33:	90                   	nop
  34:	90                   	nop
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
   0:	c3                   	ret
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	0f 1f 40 00          	nopl   0x0(%rax)
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
  15:	90                   	nop
[   C56] RSP: 0018:ff69eb60700bfa68 EFLAGS: 00000002
[   C56] RAX: 0000000000000066 RBX: ffffffff9349b980 RCX: 0000000000000000
[   C56] RDX: 00000000000003f8 RSI: 0000000000000000 RDI: ffffffff9349b980
[   C56] RBP: 0000000000000066 R08: 303178302f303178 R09: 302b646165726874
[   C56] R10: 6461657268746b5f R11: 7866705f5f203f20 R12: ffffffff9349b980
[   C56] R13: ffffffff933cd492 R14: 0000000000000000 R15: 0000000000000000
[   C56] FS:  00007fa9252d9740(0000) GS:ff24b975ff600000(0000) knlGS:0000000000000000
[   C56] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   C56] CR2: 00007fa9254b5650 CR3: 0000002088d94003 CR4: 0000000000771ef0
[   C56] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   C56] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   C56] PKRU: 55555554
[   C56] Call Trace:
[   C56]  <NMI>
[ C56] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115) 
[ C56] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discriminator 1)) 
[ C56] ? nmi_handle (arch/x86/kernel/nmi.c:150) 
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
[ C56] ? default_do_nmi (arch/x86/kernel/nmi.c:351) 
[ C56] ? exc_nmi (arch/x86/kernel/nmi.c:545) 
[ C56] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1409) 
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105) 
[   C56]  </NMI>
[   C56]  <TASK>
[ C56] serial8250_console_putchar (./include/linux/serial_core.h:704 drivers/tty/serial/8250/8250_port.c:3340) 
[ C56] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_port.c:3336) 
[ C56] uart_console_write (drivers/tty/serial/serial_core.c:2140) 
[ C56] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c:3621) 
[ C56] nbcon_emit_next_record (kernel/printk/nbcon.c:938) 
[ C56] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1191 (discriminator 1) kernel/printk/nbcon.c:1327 (discriminator 1)) 
[ C56] vprintk_emit (kernel/printk/printk.c:2424) 
[ C56] _printk (kernel/printk/printk.c:2484) 
[ C56] panic (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/panic.c:532 kernel/panic.c:343) 
[ C56] ? _printk (kernel/printk/printk.c:2484) 
[ C56] sysrq_handle_crash (drivers/tty/sysrq.c:154) 
[ C56] __handle_sysrq (drivers/tty/sysrq.c:601) 
[ C56] write_sysrq_trigger (drivers/tty/sysrq.c:1174) 
[ C56] proc_reg_write (fs/proc/inode.c:334 fs/proc/inode.c:346) 
[ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5863 (discriminator 1) kernel/sched/core.c:5860 (discriminator 1) kernel/sched/core.c:5888 (discriminator 1)) 
[ C56] vfs_write (fs/read_write.c:588) 
[ C56] ? __do_sys_newfstatat (fs/stat.c:471 (discriminator 1)) 
[ C56] ksys_write (fs/read_write.c:643) 
[ C56] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:215) 
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:215) 
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ C56] ? __count_memcg_events (mm/memcontrol.c:722 (discriminator 1) mm/memcontrol.c:961 (discriminator 1)) 
[ C56] ? handle_mm_fault (mm/memory.c:5347 mm/memory.c:5486) 
[ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5863 (discriminator 1) kernel/sched/core.c:5860 (discriminator 1) kernel/sched/core.c:5888 (discriminator 1)) 
[ C56] ? up_read (./arch/x86/include/asm/preempt.h:103 kernel/locking/rwsem.c:1354 kernel/locking/rwsem.c:1622) 
[ C56] ? do_user_addr_fault (arch/x86/mm/fault.c:1359) 
[ C56] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[   C56] RIP: 0033:0x7fa9253e4c94
[ C56] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
All code
========
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
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
[   C56] RSP: 002b:00007fff88bc8188 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   C56] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa9253e4c94
[   C56] RDX: 0000000000000002 RSI: 0000560b1e01f490 RDI: 0000000000000001
[   C56] RBP: 00007fff88bc81b0 R08: 0000000000000410 R09: 0000000000000001
[   C56] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002
[   C56] R13: 0000560b1e01f490 R14: 00007fa9254b55c0 R15: 00007fa9254b2f20
[   C56]  </TASK>
[ T2482] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
[ T2482] Call Trace:
[ T2482]  <TASK>
[ T2482] panic (kernel/panic.c:344) 
[ T2482] ? _printk (kernel/printk/printk.c:2484) 
[ T2482] sysrq_handle_crash (drivers/tty/sysrq.c:154) 
[ T2482] __handle_sysrq (drivers/tty/sysrq.c:601) 
[ T2482] write_sysrq_trigger (drivers/tty/sysrq.c:1174) 
[ T2482] proc_reg_write (fs/proc/inode.c:334 fs/proc/inode.c:346) 
[ T2482] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5863 (discriminator 1) kernel/sched/core.c:5860 (discriminator 1) kernel/sched/core.c:5888 (discriminator 1)) 
[ T2482] vfs_write (fs/read_write.c:588) 
[ T2482] ? __do_sys_newfstatat (fs/stat.c:471 (discriminator 1)) 
[ T2482] ksys_write (fs/read_write.c:643) 
[ T2482] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ T2482] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ T2482] ? syscall_exit_to_user_mode (kernel/entry/common.c:215) 
[ T2482] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ T2482] ? syscall_exit_to_user_mode (kernel/entry/common.c:215) 
[ T2482] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ T2482] ? __count_memcg_events (mm/memcontrol.c:722 (discriminator 1) mm/memcontrol.c:961 (discriminator 1)) 
[ T2482] ? handle_mm_fault (mm/memory.c:5347 mm/memory.c:5486) 
[ T2482] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5863 (discriminator 1) kernel/sched/core.c:5860 (discriminator 1) kernel/sched/core.c:5888 (discriminator 1)) 
[ T2482] ? up_read (./arch/x86/include/asm/preempt.h:103 kernel/locking/rwsem.c:1354 kernel/locking/rwsem.c:1622) 
[ T2482] ? do_user_addr_fault (arch/x86/mm/fault.c:1359) 
[ T2482] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[ T2482] RIP: 0033:0x7fa9253e4c94
[ T2482] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
All code
========
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
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
[ T2482] RSP: 002b:00007fff88bc8188 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ T2482] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa9253e4c94
[ T2482] RDX: 0000000000000002 RSI: 0000560b1e01f490 RDI: 0000000000000001
[ T2482] RBP: 00007fff88bc81b0 R08: 0000000000000410 R09: 0000000000000001
[ T2482] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002
[ T2482] R13: 0000560b1e01f490 R14: 00007fa9254b55c0 R15: 00007fa9254b2f20
[ T2482]  </TASK>
[ T2482] Shutting down cpus with NMI
[ T2482] Kernel Offset: 0xf600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ T2482] ---[ end Kernel panic - not syncing: sysrq triggered crash ]---





-----------------------------
NMI Backtraces for 6.8-rt8 no forced preemption with tuned throughput-performance profile
-----------------------------

[ T2549] sysrq: Trigger a crash
[ T2549] Kernel panic - not syncing: sysrq triggered crash
[    C0] NMI backtrace for cpu 0
[    C0] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
[ C0] RIP: 0010:io_serial_in (arch/x86/kernel/early_printk.c:100) 
[ C0] Code: cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 0f b6 8f c1 00 00 00 0f b7 57 08 d3 e6 01 f2 ec <0f> b6 c0 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
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
[    C0] RSP: 0018:ff6f5a3e30adfb18 EFLAGS: 00000002
[    C0] RAX: ffffffff8b5e1500 RBX: 0000000000000000 RCX: 0000000000000000
[    C0] RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffff8dc9b980
[    C0] RBP: 000000000000270e R08: ffffffff8dbcd46b R09: ff6f5a3e30adfa77
[    C0] R10: 0000000033353532 R11: 0000000035353254 R12: 0000000000000020
[    C0] R13: ffffffff8dc9b980 R14: 0000000000000000 R15: 0000000000000000
[    C0] FS:  00007f992140b740(0000) GS:ff4bee3e7f800000(0000) knlGS:0000000000000000
[    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    C0] CR2: 00007f99215e7650 CR3: 0000000106bcc001 CR4: 0000000000771ef0
[    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    C0] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[    C0] PKRU: 55555554
[    C0] Call Trace:
[    C0]  <NMI>
[ C0] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115) 
[ C0] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discriminator 1)) 
[ C0] ? nmi_handle (arch/x86/kernel/nmi.c:150) 
[ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
[ C0] ? default_do_nmi (arch/x86/kernel/nmi.c:351) 
[ C0] ? exc_nmi (arch/x86/kernel/nmi.c:545) 
[ C0] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1409) 
[ C0] ? mem16_serial_in (drivers/tty/serial/8250/8250_port.c:381) 
[ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
[ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
[ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
[    C0]  </NMI>
[    C0]  <TASK>
[ C0] wait_for_xmitr (drivers/tty/serial/8250/8250.h:117 drivers/tty/serial/8250/8250.h:139 drivers/tty/serial/8250/8250_port.c:2098 drivers/tty/serial/8250/8250_port.c:2116) 
[ C0] serial8250_console_putchar (./include/linux/serial_core.h:704 drivers/tty/serial/8250/8250_port.c:3340) 
[ C0] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_port.c:3336) 
[ C0] uart_console_write (drivers/tty/serial/serial_core.c:2140) 
[ C0] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c:3621) 
[ C0] nbcon_emit_next_record (kernel/printk/nbcon.c:938) 
[ C0] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1191 (discriminator 1) kernel/printk/nbcon.c:1327 (discriminator 1)) 
[ C0] vprintk_emit (kernel/printk/printk.c:2424) 
[ C0] _printk (kernel/printk/printk.c:2484) 
[ C0] panic (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/panic.c:532 kernel/panic.c:343) 
[ C0] ? _printk (kernel/printk/printk.c:2484) 
[ C0] sysrq_handle_crash (drivers/tty/sysrq.c:154) 
[ C0] __handle_sysrq (drivers/tty/sysrq.c:601) 
[ C0] write_sysrq_trigger (drivers/tty/sysrq.c:1174) 
[ C0] proc_reg_write (fs/proc/inode.c:334 fs/proc/inode.c:346) 
[ C0] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5863 (discriminator 1) kernel/sched/core.c:5860 (discriminator 1) kernel/sched/core.c:5888 (discriminator 1)) 
[ C0] vfs_write (fs/read_write.c:588) 
[ C0] ? syscall_exit_to_user_mode (kernel/entry/common.c:215) 
[ C0] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ C0] ksys_write (fs/read_write.c:643) 
[ C0] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ C0] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[    C0] RIP: 0033:0x7f9921516c94
[ C0] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
All code
========
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
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
[    C0] RSP: 002b:00007ffdcc3fdb68 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[    C0] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f9921516c94
[    C0] RDX: 0000000000000002 RSI: 000055dd6e9f9490 RDI: 0000000000000001
[    C0] RBP: 00007ffdcc3fdb90 R08: 0000000000000410 R09: 0000000000000001
[    C0] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002
[    C0] R13: 000055dd6e9f9490 R14: 00007f99215e75c0 R15: 00007f99215e4f20
[    C0]  </TASK>
[ T2549] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
[ T2549] Call Trace:
[ T2549]  <TASK>
[ T2549] panic (kernel/panic.c:344) 
[ T2549] ? _printk (kernel/printk/printk.c:2484) 
[ T2549] sysrq_handle_crash (drivers/tty/sysrq.c:154) 
[ T2549] __handle_sysrq (drivers/tty/sysrq.c:601) 
[ T2549] write_sysrq_trigger (drivers/tty/sysrq.c:1174) 
[ T2549] proc_reg_write (fs/proc/inode.c:334 fs/proc/inode.c:346) 
[ T2549] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5863 (discriminator 1) kernel/sched/core.c:5860 (discriminator 1) kernel/sched/core.c:5888 (discriminator 1)) 
[ T2549] vfs_write (fs/read_write.c:588) 
[ T2549] ? syscall_exit_to_user_mode (kernel/entry/common.c:215) 
[ T2549] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ T2549] ksys_write (fs/read_write.c:643) 
[ T2549] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ T2549] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[ T2549] RIP: 0033:0x7f9921516c94
[ T2549] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
All code
========
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
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
[ T2549] RSP: 002b:00007ffdcc3fdb68 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ T2549] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f9921516c94
[ T2549] RDX: 0000000000000002 RSI: 000055dd6e9f9490 RDI: 0000000000000001
[ T2549] RBP: 00007ffdcc3fdb90 R08: 0000000000000410 R09: 0000000000000001
[ T2549] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002
[ T2549] R13: 000055dd6e9f9490 R14: 00007f99215e75c0 R15: 00007f99215e4f20
[ T2549]  </TASK>
[    C0] NMI backtrace for cpu 0
[    C0] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
[ C0] RIP: 0010:delay_halt_tpause (arch/x86/lib/delay.c:118) 
[ C0] Code: cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8d 04 37 31 c9 48 89 c2 48 c1 ea 20 66 0f ae f1 <c3> cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	cc                   	int3
   1:	0f 1f 00             	nopl   (%rax)
   4:	90                   	nop
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
  14:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  19:	48 8d 04 37          	lea    (%rdi,%rsi,1),%rax
  1d:	31 c9                	xor    %ecx,%ecx
  1f:	48 89 c2             	mov    %rax,%rdx
  22:	48 c1 ea 20          	shr    $0x20,%rdx
  26:	66 0f ae f1          	tpause %ecx
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  34:	90                   	nop
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
   0:	c3                   	ret
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
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
  15:	90                   	nop
[    C0] RSP: 0018:ff6f5a3e30adfcf8 EFLAGS: 00000002
[    C0] RAX: 0000018b5534ddb6 RBX: 0000000000000121 RCX: 0000000000000000
[    C0] RDX: 000000000000018b RSI: 0000000000000121 RDI: 0000018b5534dc95
[    C0] RBP: 0000018b5534dc95 R08: ffffffff8dbcd468 R09: ff6f5a3e30adf96f
[    C0] R10: 0000000039343532 R11: 0000000034353254 R12: 000000000001ed2a
[    C0] R13: 0000000000000000 R14: 0000000000000063 R15: 0000000000000000
[    C0] FS:  00007f992140b740(0000) GS:ff4bee3e7f800000(0000) knlGS:0000000000000000
[    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    C0] CR2: 00007f99215e7650 CR3: 0000000106bcc001 CR4: 0000000000771ef0
[    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    C0] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[    C0] PKRU: 55555554
[    C0] Call Trace:
[    C0]  <NMI>
[ C0] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115) 
[ C0] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discriminator 1)) 
[ C0] ? nmi_handle (arch/x86/kernel/nmi.c:150) 
[ C0] ? delay_halt_tpause (arch/x86/lib/delay.c:118) 
[ C0] ? default_do_nmi (arch/x86/kernel/nmi.c:351) 
[ C0] ? exc_nmi (arch/x86/kernel/nmi.c:545) 
[ C0] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1409) 
[ C0] ? delay_halt_tpause (arch/x86/lib/delay.c:118) 
[ C0] ? delay_halt_tpause (arch/x86/lib/delay.c:118) 
[ C0] ? delay_halt_tpause (arch/x86/lib/delay.c:118) 
[    C0]  </NMI>
[    C0]  <TASK>
[ C0] delay_halt.part.0 (arch/x86/lib/delay.c:163) 
[ C0] native_stop_other_cpus (./include/linux/bitmap.h:400 ./include/linux/cpumask.h:684 arch/x86/kernel/smp.c:201) 
[ C0] panic (./arch/x86/include/asm/smp.h:54 kernel/panic.c:264 kernel/panic.c:365) 
[ C0] ? _printk (kernel/printk/printk.c:2484) 
[ C0] sysrq_handle_crash (drivers/tty/sysrq.c:154) 
[ C0] __handle_sysrq (drivers/tty/sysrq.c:601) 
[ C0] write_sysrq_trigger (drivers/tty/sysrq.c:1174) 
[ C0] proc_reg_write (fs/proc/inode.c:334 fs/proc/inode.c:346) 
[ C0] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5863 (discriminator 1) kernel/sched/core.c:5860 (discriminator 1) kernel/sched/core.c:5888 (discriminator 1)) 
[ C0] vfs_write (fs/read_write.c:588) 
[ C0] ? syscall_exit_to_user_mode (kernel/entry/common.c:215) 
[ C0] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ C0] ksys_write (fs/read_write.c:643) 
[ C0] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ C0] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[    C0] RIP: 0033:0x7f9921516c94
[ C0] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
All code
========
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
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
[    C0] RSP: 002b:00007ffdcc3fdb68 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[    C0] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f9921516c94
[    C0] RDX: 0000000000000002 RSI: 000055dd6e9f9490 RDI: 0000000000000001
[    C0] RBP: 00007ffdcc3fdb90 R08: 0000000000000410 R09: 0000000000000001
[    C0] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002
[    C0] R13: 000055dd6e9f9490 R14: 00007f99215e75c0 R15: 00007f99215e4f20
[    C0]  </TASK>
[    C0] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 381.956 msecs
[ T2549] Shutting down cpus with NMI
[ T2549] Kernel Offset: 0x9e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ T2549] ---[ end Kernel panic - not syncing: sysrq triggered crash ]---






-----------------------------
No NMIs backtraces found for 6.8-rt8 fully pre-emptive with tuned realtime profile
-----------------------------

[ T5507] Call Trace:
[ T5507]  <TASK>
[ T5507] __schedule (kernel/sched/core.c:5420 kernel/sched/core.c:6747) 
[ T5507] ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
[ T5507] schedule (kernel/sched/core.c:6823 kernel/sched/core.c:6837) 
[ T5507] smpboot_thread_fn (kernel/smpboot.c:160) 
[ T5507] kthread (kernel/kthread.c:388) 
[ T5507] ? __pfx_kthread (kernel/kthread.c:341) 
[ T5507] ret_from_fork (arch/x86/kernel/process.c:147) 
[ T5507] ? __pfx_kthread (kernel/kthread.c:341) 
[ T5507] ret_from_fork_asm (arch/x86/entry/entry_64.S:251) 
[ T5507]  </TASK>
[ T5507] task:irq_work/5      state:S stack:0     pid:65    tgid:65    ppid:2      flags:0x00004000
[ T5507] Call Trace:
[ T5507]  <TASK>
[ T5508]  S
[ T5507] __schedule (kernel/sched/core.c:5420 kernel/sched/core.c:6747) 
[ T5508] irq/95-nvme0q19  3530       322.126516 E       325.121736         3.000000         0.039704         4    49 
[ T5507] ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
[ T5508]         0.000000         0.039704         0.000000         0.000000
[ T5507] schedule (kernel/sched/core.c:6823 kernel/sched/core.c:6837) 
[ T5508]  /
[ T5507] smpboot_thread_fn (kernel/smpboot.c:160) 
[ T5507] kthread (kernel/kthread.c:388) 
[ T5507] ? __pfx_kthread (kernel/kthread.c:341) 
[ T5507] ret_from_fork (arch/x86/kernel/process.c:147) 
[ T5507] ? __pfx_kthread (kernel/kthread.c:341) 
[ T5507] ret_from_fork_asm (arch/x86/entry/entry_64.S:251) 
[ T5507]  </TASK>
[ T5507] task:migration/5     state:S stack:0     pid:66    tgid:66    ppid:2      flags:0x00004000
[ T5507] Stopper: 0x0 <- 0x0
[ T5507] Call Trace:
[ T5507]  <TASK>
[ T5507] __schedule (kernel/sched/core.c:5420 kernel/sched/core.c:6747) 
[ T5507] ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
[ T5507] schedule (kernel/sched/core.c:6823 kernel/sched/core.c:6837) 
[ T5507] smpboot_thread_fn (kernel/smpboot.c:160) 
[ T5507] kthread (kernel/kthread.c:388) 
[ T5507] ? __pfx_kthread (kernel/kthread.c:341) 
[ T5507] ret_from_fork (arch/x86/kernel/process.c:147) 
[ T5508] 
[ T5507] ? __pfx_kthread (kernel/kthread.c:341) 
[ T5507] ret_from_fork_asm (arch/x86/entry/entry_64.S:251) 
[ T5507]  </TASK>
[ T5508] cpu#143, 1900.000 MHz
[ T5508]   .nr_running                    : 0
[ T5508]   .nr_switches                   : 7623
[ T5508]   .nr_uninterruptible            : -5
[ T5508]   .next_balance                  : 4298.534188
[ T5508]   .curr->pid                     : 0
[ T5508]   .clock                         : 3872984.828013
[ T5508]   .clock_task                    : 3872944.105495
[ T5508]   .avg_idle                      : 1000000
[ T5508]   .max_idle_balance_cost         : 500000
[ T5508] 
[ T5508] rt_rq[143]:
[ T5508]   .rt_nr_running                 : 0
[ T5508]   .rt_throttled                  : 0
[ T5508]   .rt_time                       : 0.000000
[ T5508]   .rt_runtime                    : 0.000001
[ T5508] 
[ T5508] dl_rq[143]:
[ T5508]   .dl_nr_running                 : 0
[ T5508]   .dl_bw->bw                     : -1
[ T5508]   .dl_bw->total_bw               : 0
[ T5508] 
[ T5508] runnable tasks:
[ T5508]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
[ T5508] -------------------------------------------------------------------------------------------------------------
[ T5507] task:rcuc/5          state:S stack:0     pid:67    tgid:67    ppid:2      flags:0x00004000
[ T5507] Call Trace:
[ T5507]  <TASK>
[ T5507] __schedule (kernel/sched/core.c:5420 kernel/sched/core.c:6747) 
[ T5507] ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
[ T5507] schedule (kernel/sched/core.c:6823 kernel/sched/core.c:6837) 
[ T5507] smpboot_thread_fn (kernel/smpboot.c:160) 
[ T5507] kthread (kernel/kthread.c:388) 
[ T5507] ? __pfx_kthread (kernel/kthread.c:341) 
[ T5507] ret_from_fork (arch/x86/kernel/process.c:147) 
[ T5507] ? __pfx_kthread (kernel/kthread.c:341) 
[ T5507] ret_from_fork_asm (arch/x86/entry/entry_64.S:251) 
[ T5507]  </TASK>
[ T5504] sysrq: Trigger a crash
[ T5504] Kernel panic - not syncing: sysrq triggered crash
[ T5504] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
[ T5504] Call Trace:
[ T5504]  <TASK>
[ T5504] panic (kernel/panic.c:344) 
[ T5504] ? _printk (kernel/printk/printk.c:2484) 
[ T5504] sysrq_handle_crash (drivers/tty/sysrq.c:154) 
[ T5504] __handle_sysrq (drivers/tty/sysrq.c:601) 
[ T5504] write_sysrq_trigger (drivers/tty/sysrq.c:1174) 
[ T5504] proc_reg_write (fs/proc/inode.c:334 fs/proc/inode.c:346) 
[ T5504] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5863 (discriminator 1) kernel/sched/core.c:5860 (discriminator 1) kernel/sched/core.c:5888 (discriminator 1)) 
[ T5504] vfs_write (fs/read_write.c:588) 
[ T5504] ? syscall_exit_to_user_mode (kernel/entry/common.c:215) 
[ T5504] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ T5504] ksys_write (fs/read_write.c:643) 
[ T5504] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ T5504] ? do_user_addr_fault (arch/x86/mm/fault.c:1359) 
[ T5504] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[ T5504] RIP: 0033:0x7fdae226dc94
[ T5504] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
All code
========
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
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
[ T5504] RSP: 002b:00007ffce96577e8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ T5504] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fdae226dc94
[ T5504] RDX: 0000000000000002 RSI: 000055a5240d0490 RDI: 0000000000000001
[ T5504] RBP: 00007ffce9657810 R08: 0000000000000410 R09: 0000000000000001
[ T5504] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002
[ T5504] R13: 000055a5240d0490 R14: 00007fdae233e5c0 R15: 00007fdae233bf20
[ T5504]  </TASK>
[ T5504] Kernel Offset: 0x1b200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ T5504] ---[ end Kernel panic - not syncing: sysrq triggered crash ]---

-- 
Sincerly,
John Wyatt
Software Engineer, Core Kernel
Red Hat


