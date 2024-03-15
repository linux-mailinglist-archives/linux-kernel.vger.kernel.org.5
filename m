Return-Path: <linux-kernel+bounces-104842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B101387D46B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA3B1F236CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF6524CE;
	Fri, 15 Mar 2024 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RW1LLZqY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D368BEC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710530492; cv=none; b=ecn1jEYY1jsTDtV5Co2IBVZupRyg/apO7LC6SHKRoZBGv2WtLCnvwjgpKfR/8ojwwUH7hC0mkdRb6Ow7uL6GIBrfrxqbet8bfkcskwaeOD65ufcmWzSMifOw86dK2Y37XbgMLLqZy1/ePyMJpb9zhq+LZn2dyjcdcrBBZXqGNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710530492; c=relaxed/simple;
	bh=gHoQnEHvQiCaNX89bwWLhWxhmd9Dcm6C+Zvs+EQxiCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kQUbWpEum+IrOLn8xPP7DAm6GWUGtFG9ELFJBea1Jm9ztDQZoWNsk5QQGra6rXEHy21JXlMUzz2uu5AtpraSvV0Vv/n4h+IxUbhzMPvvskUZarFtCdV8FFcYpxd0/EsHsMJSaaaGrmTz/NpnbTcjadXFqMrp+X7Gg5jhgem/7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RW1LLZqY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710530487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kkM7je8ozv1ufmdv28yH9lmlummAlHg5602Z7+uS8A0=;
	b=RW1LLZqYe3XtTC/vQXXWXa6wmx2oyjMo1JPZpE+D8P54UYQUzQ5EVGUf5XhkWDPfThpTCW
	fMyVLUYccZ5LqJGvajehPfPiGVVaa0aeXGq2gTCHyiI5TyHx4VmqvRFFtAQttkAbNMIR8t
	SdFI8ir3JjA5UD9iJ12L5odbBrnIudI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-6O6QMGa_O4-kJWrvomejPw-1; Fri, 15 Mar 2024 15:21:25 -0400
X-MC-Unique: 6O6QMGa_O4-kJWrvomejPw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68fa064556eso20416006d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710530484; x=1711135284;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkM7je8ozv1ufmdv28yH9lmlummAlHg5602Z7+uS8A0=;
        b=S2bpgrzrH0BrW0Q6JTxL8Bh70+DDeQtPvXovhqN91hE77+bI1FNBZL9YZw+xu9ncHA
         6hivLGZqpdfpTlf5XZFJ8V/JykKuqYMTWi7sk+/xYPZTgtlc0k0gQnlTmM5woXYxFEB/
         w8CN6xWx3+xyMukapoaoamR5T7BiJCoL0t4tjpOi91+SHH8VV6sldsIB75HL7HuNEe2s
         o5Zddxbgr1mlLon182F1KhDMZguepsy0UcoxtT+IA4Ja2fDDmr72xuxdxI3pgj/GYvL+
         R1s+ve2N7hZLpv+tFryBghsBDb1UqRXLMq0zOLqHuXq33U5l5J1SCZxkG+MbOkzUipCs
         Psjg==
X-Forwarded-Encrypted: i=1; AJvYcCWhXul7zSJQQ/qA4608oZ8ZQ5gtLZqqKbIH6hGnzzNnD23v1eoOEDihMcW4zHJni6ghLCNvqnNI8WXzbwUjflNE8W3Pd7ACX/4BoypA
X-Gm-Message-State: AOJu0Yxy2RsIqw6L4XJz+lFSFlKwrxd1FzEIWvpzi9lFNQPqq7KW/SMd
	Prw1bw/j8XJ26EKKdoNSnz+P2zjDMkXhtxRyiXq3Wfo7amWvcAM9CkzmhRkVRD22NvOeSq3w32O
	FJiDCPHZA2Ofn1qsS7Mzs8iz5YfJMBR1Z+4gYppV4RG1CWDih+Ly2fd9C/qgqFw==
X-Received: by 2002:a05:6214:971:b0:691:49d5:471 with SMTP id do17-20020a056214097100b0069149d50471mr5798805qvb.47.1710530483761;
        Fri, 15 Mar 2024 12:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9BJJq7fLhOJfkz90iy/oaRoGzM/q1+bBtscxhEGF7JiWgXpdF39He/O8IZzR9wywx2ou4FA==
X-Received: by 2002:a05:6214:971:b0:691:49d5:471 with SMTP id do17-20020a056214097100b0069149d50471mr5798771qvb.47.1710530482997;
        Fri, 15 Mar 2024 12:21:22 -0700 (PDT)
Received: from thinkpad2021 ([2607:fb90:ee2a:307:2baf:9d87:8580:8fca])
        by smtp.gmail.com with ESMTPSA id kj25-20020a056214529900b00690df461ecbsm2312628qvb.10.2024.03.15.12.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 12:21:22 -0700 (PDT)
Date: Fri, 15 Mar 2024 15:21:19 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Bruno Goncalves <bgoncalv@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: NMIs reported by console_blast.sh with 6.6.20-rt25
Message-ID: <ZfSfrzak9WS0ZFv7@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello John,

The real-time team at Red Hat is discussing backporting the rt patchset in =
6.6
to RHEL 9/Stream 9. I decided to test v6.6.20-rt25 from stable-rt with
console_blast.sh. It reported similar NMIs from my testing of 6.7.0-rt6 with
that high cpu count server over uart 8250; which is expected since the patc=
hset
is similar.

One interesting thing is that 6.7.0-rt6 fully preemptive + realtime tuned p=
rofile
did not return any NMIs while 6.6 did with that same configuration.

Another aspect I noticed during my testing. I did not set grub to
start with the realtime profile at boot for this machine. When I did set
it the second (and latter) NMI did not show for fully preemptive (the
3rd set at the bottom of this email).=20

Caller info was enabled. No modifications to the source code were made.

I have not tested previous versions before 6.7.0-rt6 or 6.6.20-rt25;
with the exception of accidently testing 6.6.10-rt19. 6.6.10 also
reported NMIs during this test. If you wish to see these reports please
let me know.

Also, please let me know if I can help in any other way or if you want anyt=
hing else
tested. I will be moving to 6.8 and using BUG_ON(system_state =3D=3D SYSTEM=
_RUNNING);
in the scheduler next for my tests to see if the messages do not show.

Link to lscpu and previous NMI reports:
https://lore.kernel.org/linux-rt-users/ZdUmpblrzX0pcPjz@thinkpad2021/T/#mec=
258264be95dcba23970def7b248af0c6e942b2

-----------------------------
NMI Backtrace for 6.6.20-rt25 no forced preemption with tuned realtime prof=
ile
-----------------------------

[ T2614] Kernel panic - not syncing: sysrq triggered crash=0D
[   C56] NMI backtrace for cpu 56=0D
[   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7=
411.86B.9409.D04.2212261349 12/26/2022=0D
[ C56] RIP: 0010:io_serial_out (arch/x86/kernel/early_printk.c:105)=20
[ C56] Code: 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f=
 44 00 00 0f b6 8f c1 00 00 00 89 d0 0f b7 57 08 d3 e6 01 f2 ee <c3> cc cc =
cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
[   C56] RSP: 0018:ffa0000030a9fb28 EFLAGS: 00000002=0D
[   C56] RAX: 000000000000005f RBX: ffffffffa6ac68c0 RCX: 0000000000000000=
=0D
[   C56] RDX: 00000000000003f8 RSI: 0000000000000000 RDI: ffffffffa6ac68c0=
=0D
[   C56] RBP: 000000000000005f R08: 303378302f623178 R09: 302b6d73615f6b72=
=0D
[   C56] R10: 615f6b726f665f6d R11: 6f72665f74657220 R12: ffffffffa6ac68c0=
=0D
[   C56] R13: ffffffffa69b9434 R14: 0000000000000000 R15: 0000000000000000=
=0D
[   C56] FS:  00007f4a81d54740(0000) GS:ff11003fff600000(0000) knlGS:000000=
0000000000=0D
[   C56] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   C56] CR2: 00007f4a81f30650 CR3: 000000011ea24004 CR4: 0000000000771ee0=
=0D
[   C56] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=
=0D
[   C56] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400=
=0D
[   C56] PKRU: 55555554=0D
[   C56] Call Trace:=0D
[   C56]  <NMI>=0D
[ C56] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115)=20
[ C56] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discr=
iminator 1))=20
[ C56] ? nmi_handle (arch/x86/kernel/nmi.c:149)=20
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105)=20
[ C56] ? default_do_nmi (arch/x86/kernel/nmi.c:347)=20
[ C56] ? exc_nmi (arch/x86/kernel/nmi.c:538)=20
[ C56] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1458)=20
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105)=20
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105)=20
[ C56] ? io_serial_out (arch/x86/kernel/early_printk.c:105)=20
[   C56]  </NMI>=0D
[   C56]  <TASK>=0D
[ C56] serial8250_console_putchar (./include/linux/serial_core.h:704 driver=
s/tty/serial/8250/8250_port.c:3347)=20
[ C56] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_por=
t.c:3343)=20
[ C56] uart_console_write (drivers/tty/serial/serial_core.c:2134)=20
[ C56] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c=
:3628)=20
[ C56] nbcon_emit_next_record (kernel/printk/nbcon.c:940)=20
[ C56] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1192 (discriminator =
1) kernel/printk/nbcon.c:1326 (discriminator 1))=20
[ C56] vprintk_emit (kernel/printk/printk.c:2414)=20
[ C56] _printk (kernel/printk/printk.c:2474)=20
[ C56] panic (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bi=
tops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kerne=
l/panic.c:528 kernel/panic.c:339)=20
[ C56] ? _printk (kernel/printk/printk.c:2474)=20
[ C56] sysrq_handle_crash (drivers/tty/sysrq.c:154)=20
[ C56] __handle_sysrq (drivers/tty/sysrq.c:601)=20
[ C56] write_sysrq_trigger (drivers/tty/sysrq.c:1165)=20
[ C56] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352)=20
[ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) =
kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (discri=
minator 1) kernel/sched/core.c:5872 (discriminator 1))=20
[ C56] vfs_write (fs/read_write.c:582)=20
[ C56] ksys_write (fs/read_write.c:637)=20
[ C56] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:81=
)=20
[ C56] ? do_dup2 (fs/file.c:1142)=20
[ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)=20
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ C56] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/in=
clude/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)=
=20
[ C56] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)=20
[   C56] RIP: 0033:0x7f4a81e5fc94=0D
[ C56] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00=
 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 =
f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00=20
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   C56] RSP: 002b:00007ffc0e13b318 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0001=0D
[   C56] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4a81e5fc94=
=0D
[   C56] RDX: 0000000000000002 RSI: 000055a865695490 RDI: 0000000000000001=
=0D
[   C56] RBP: 00007ffc0e13b340 R08: 0000000000000410 R09: 0000000000000001=
=0D
[   C56] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002=
=0D
[   C56] R13: 000055a865695490 R14: 00007f4a81f305c0 R15: 00007f4a81f2df20=
=0D
[   C56]  </TASK>=0D
[   C56] NMI backtrace for cpu 56=0D
[   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7=
411.86B.9409.D04.2212261349 12/26/2022=0D
[ C56] RIP: 0010:io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] Code: cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 0f 1f 44 00 00 0f b6 8f c1 00 00 00 0f b7 57 08 d3 e6 01 f2 ec <0f> b6 c0 =
c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
[   C56] RSP: 0018:ffa0000030a9fb00 EFLAGS: 00000002=0D
[   C56] RAX: ffffffffa45cf400 RBX: 0000000000000000 RCX: 0000000000000000=
=0D
[   C56] RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffffa6ac68c0=
=0D
[   C56] RBP: 0000000000002710 R08: 303578302f643278 R09: 302b6b726f665f6d=
=0D
[   C56] R10: 302b6b726f665f6d R11: 6f72665f74657220 R12: 0000000000000020=
=0D
[   C56] R13: ffffffffa6ac68c0 R14: 0000000000000000 R15: 0000000000000000=
=0D
[   C56] FS:  00007f4a81d54740(0000) GS:ff11003fff600000(0000) knlGS:000000=
0000000000=0D
[   C56] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   C56] CR2: 00007f4a81f30650 CR3: 000000011ea24004 CR4: 0000000000771ee0=
=0D
[   C56] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=
=0D
[   C56] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400=
=0D
[   C56] PKRU: 55555554=0D
[   C56] Call Trace:=0D
[   C56]  <NMI>=0D
[ C56] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115)=20
[ C56] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discr=
iminator 1))=20
[ C56] ? nmi_handle (arch/x86/kernel/nmi.c:149)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] ? default_do_nmi (arch/x86/kernel/nmi.c:347)=20
[ C56] ? exc_nmi (arch/x86/kernel/nmi.c:538)=20
[ C56] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1458)=20
[ C56] ? mem16_serial_out (drivers/tty/serial/8250/8250_port.c:382)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[   C56]  </NMI>=0D
[   C56]  <TASK>=0D
[ C56] wait_for_xmitr (drivers/tty/serial/8250/8250.h:117 drivers/tty/seria=
l/8250/8250.h:139 drivers/tty/serial/8250/8250_port.c:2106 drivers/tty/seri=
al/8250/8250_port.c:2124)=20
[ C56] serial8250_console_putchar (./include/linux/serial_core.h:704 driver=
s/tty/serial/8250/8250_port.c:3347)=20
[ C56] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_por=
t.c:3343)=20
[ C56] uart_console_write (drivers/tty/serial/serial_core.c:2134)=20
[ C56] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c=
:3628)=20
[ C56] nbcon_emit_next_record (kernel/printk/nbcon.c:940)=20
[ C56] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1192 (discriminator =
1) kernel/printk/nbcon.c:1326 (discriminator 1))=20
[ C56] vprintk_emit (kernel/printk/printk.c:2414)=20
[ C56] _printk (kernel/printk/printk.c:2474)=20
[ C56] panic (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bi=
tops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kerne=
l/panic.c:528 kernel/panic.c:339)=20
[ C56] ? _printk (kernel/printk/printk.c:2474)=20
[ C56] sysrq_handle_crash (drivers/tty/sysrq.c:154)=20
[ C56] __handle_sysrq (drivers/tty/sysrq.c:601)=20
[ C56] write_sysrq_trigger (drivers/tty/sysrq.c:1165)=20
[ C56] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352)=20
[ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) =
kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (discri=
minator 1) kernel/sched/core.c:5872 (discriminator 1))=20
[ C56] vfs_write (fs/read_write.c:582)=20
[ C56] ksys_write (fs/read_write.c:637)=20
[ C56] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:81=
)=20
[ C56] ? do_dup2 (fs/file.c:1142)=20
[ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)=20
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ C56] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/in=
clude/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)=
=20
[ C56] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)=20
[   C56] RIP: 0033:0x7f4a81e5fc94=0D
[ C56] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00=
 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 =
f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00=20
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   C56] RSP: 002b:00007ffc0e13b318 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0001=0D
[   C56] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4a81e5fc94=
=0D
[   C56] RDX: 0000000000000002 RSI: 000055a865695490 RDI: 0000000000000001=
=0D
[   C56] RBP: 00007ffc0e13b340 R08: 0000000000000410 R09: 0000000000000001=
=0D
[   C56] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002=
=0D
[   C56] R13: 000055a865695490 R14: 00007f4a81f305c0 R15: 00007f4a81f2df20=
=0D
[   C56]  </TASK>=0D
[ T2614] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7=
411.86B.9409.D04.2212261349 12/26/2022=0D
[ T2614] Call Trace:=0D
[ T2614]  <TASK>=0D
[ T2614] dump_stack_lvl (lib/dump_stack.c:107)=20
[ T2614] panic (kernel/panic.c:340)=20
[ T2614] ? _printk (kernel/printk/printk.c:2474)=20
[ T2614] sysrq_handle_crash (drivers/tty/sysrq.c:154)=20
[ T2614] __handle_sysrq (drivers/tty/sysrq.c:601)=20
[ T2614] write_sysrq_trigger (drivers/tty/sysrq.c:1165)=20
[ T2614] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352)=20
[ T2614] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1=
) kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (disc=
riminator 1) kernel/sched/core.c:5872 (discriminator 1))=20
[ T2614] vfs_write (fs/read_write.c:582)=20
[ T2614] ksys_write (fs/read_write.c:637)=20
[ T2614] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:=
81)=20
[ T2614] ? do_dup2 (fs/file.c:1142)=20
[ T2614] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)=20
[ T2614] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ T2614] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/=
include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561=
)=20
[ T2614] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)=20
[ T2614] RIP: 0033:0x7f4a81e5fc94=0D
[ T2614] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 =
00 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 0=
0 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00=20
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[ T2614] RSP: 002b:00007ffc0e13b318 EFLAGS: 00000202=0D
[ T2614] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4a81e5fc94=
=0D
[ T2614] RDX: 0000000000000002 RSI: 000055a865695490 RDI: 0000000000000001=
=0D
[ T2614] RBP: 00007ffc0e13b340 R08: 0000000000000410 R09: 0000000000000001=
=0D
[ T2614] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002=
=0D
[ T2614] R13: 000055a865695490 R14: 00007f4a81f305c0 R15: 00007f4a81f2df20=
=0D
[ T2614]  </TASK>=0D
[ T2614] Shutting down cpus with NMI=0D
[ T2614] Kernel Offset: disabled=0D
[ T2614] ---[ end Kernel panic - not syncing: sysrq triggered crash ]---=0D
[disconnect]=0D
=1B]777;notify;Command completed;KRB5CCNAME=3D/dev/null console -M conserve=
r-02.hosts.prod.psi.bos.redhat.com intel-eaglestream-spr-15.khw3.lab.eng.bo=
s.redhat.com=1B=1B]777;precmd=1B=1B]0;j@thinkpad2021:~/BTWork/records/2023/=
12Dec-testprintkupstream/6.6.20-rt25=1B=1B]7;file://thinkpad2021/home/j/BTW=
ork/records/2023/12Dec-testprintkupstream/6.6.20-rt25=1B=1B[?2004h=1B[38;5;=
166mj=1B[38;5;228m6.6.20-rt25=1B[38;5;43m=1B[38;5;71m=0D=0D
>$ =1B(B=1B[mexit=0D
=1B[?2004l=0D=1B]777;preexec=1Bexit=0D

Script done on 2024-03-08 12:25:38-05:00 [COMMAND_EXIT_CODE=3D"0"]







-----------------------------
NMI Backtrace for 6.6.20-rt25 no forced preemption with tuned throughput-pe=
rformance profile
-----------------------------


[ T2546] sysrq: Trigger a crash=0D
[ T2546] Kernel panic - not syncing: sysrq triggered crash=0D
[   C56] NMI backtrace for cpu 56=0D
[   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7=
411.86B.9409.D04.2212261349 12/26/2022=0D
[ C56] RIP: 0010:io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] Code: cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 0f 1f 44 00 00 0f b6 8f c1 00 00 00 0f b7 57 08 d3 e6 01 f2 ec <0f> b6 c0 =
c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
[   C56] RSP: 0018:ffa00000308e7ae8 EFLAGS: 00000002=0D
[   C56] RAX: ffffffff8d7cf400 RBX: 0000000000000000 RCX: 0000000000000000=
=0D
[   C56] RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffff8fcc68c0=
=0D
[   C56] RBP: 000000000000270f R08: 6469703e2d727275 R09: 2020202020202020=
=0D
[   C56] R10: 00000000632e2020 R11: 00000000632e2020 R12: 0000000000000020=
=0D
[   C56] R13: ffffffff8fcc68c0 R14: 0000000000000000 R15: 0000000000000000=
=0D
[   C56] FS:  00007f4c17301740(0000) GS:ff11003fff600000(0000) knlGS:000000=
0000000000=0D
[   C56] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   C56] CR2: 00007f4c174dd650 CR3: 000000010994c004 CR4: 0000000000771ee0=
=0D
[   C56] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=
=0D
[   C56] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400=
=0D
[   C56] PKRU: 55555554=0D
[   C56] Call Trace:=0D
[   C56]  <NMI>=0D
[ C56] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115)=20
[ C56] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discr=
iminator 1))=20
[ C56] ? nmi_handle (arch/x86/kernel/nmi.c:149)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] ? default_do_nmi (arch/x86/kernel/nmi.c:347)=20
[ C56] ? exc_nmi (arch/x86/kernel/nmi.c:538)=20
[ C56] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1458)=20
[ C56] ? mem16_serial_out (drivers/tty/serial/8250/8250_port.c:382)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[   C56]  </NMI>=0D
[   C56]  <TASK>=0D
[ C56] wait_for_xmitr (drivers/tty/serial/8250/8250.h:117 drivers/tty/seria=
l/8250/8250.h:139 drivers/tty/serial/8250/8250_port.c:2106 drivers/tty/seri=
al/8250/8250_port.c:2124)=20
[ C56] serial8250_console_putchar (./include/linux/serial_core.h:704 driver=
s/tty/serial/8250/8250_port.c:3347)=20
[ C56] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_por=
t.c:3343)=20
[ C56] uart_console_write (drivers/tty/serial/serial_core.c:2134)=20
[ C56] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c=
:3628)=20
[ C56] nbcon_emit_next_record (kernel/printk/nbcon.c:940)=20
[ C56] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1192 (discriminator =
1) kernel/printk/nbcon.c:1326 (discriminator 1))=20
[ C56] vprintk_emit (kernel/printk/printk.c:2414)=20
[ C56] _printk (kernel/printk/printk.c:2474)=20
[ C56] panic (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bi=
tops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kerne=
l/panic.c:528 kernel/panic.c:339)=20
[ C56] ? _printk (kernel/printk/printk.c:2474)=20
[ C56] sysrq_handle_crash (drivers/tty/sysrq.c:154)=20
[ C56] __handle_sysrq (drivers/tty/sysrq.c:601)=20
[ C56] write_sysrq_trigger (drivers/tty/sysrq.c:1165)=20
[ C56] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352)=20
[ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) =
kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (discri=
minator 1) kernel/sched/core.c:5872 (discriminator 1))=20
[ C56] vfs_write (fs/read_write.c:582)=20
[ C56] ? __do_sys_newfstatat (fs/stat.c:466 (discriminator 1))=20
[ C56] ksys_write (fs/read_write.c:637)=20
[ C56] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:81=
)=20
[ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)=20
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ C56] ? up_read (./arch/x86/include/asm/preempt.h:104 kernel/locking/rwsem=
=2Ec:1354 kernel/locking/rwsem.c:1622)=20
[ C56] ? do_user_addr_fault (arch/x86/mm/fault.c:1368)=20
[ C56] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/in=
clude/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)=
=20
[ C56] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)=20
[   C56] RIP: 0033:0x7f4c1740cc94=0D
[ C56] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00=
 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 =
f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00=20
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   C56] RSP: 002b:00007ffe88b9b298 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0001=0D
[   C56] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4c1740cc94=
=0D
[   C56] RDX: 0000000000000002 RSI: 00005634f890b490 RDI: 0000000000000001=
=0D
[   C56] RBP: 00007ffe88b9b2c0 R08: 0000000000000410 R09: 0000000000000001=
=0D
[   C56] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002=
=0D
[   C56] R13: 00005634f890b490 R14: 00007f4c174dd5c0 R15: 00007f4c174daf20=
=0D
[   C56]  </TASK>=0D
[   C56] NMI backtrace for cpu 56=0D
[   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7=
411.86B.9409.D04.2212261349 12/26/2022=0D
[ C56] RIP: 0010:io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] Code: cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 0f 1f 44 00 00 0f b6 8f c1 00 00 00 0f b7 57 08 d3 e6 01 f2 ec <0f> b6 c0 =
c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
[   C56] RSP: 0018:ffa00000308e7ae8 EFLAGS: 00000002=0D
[   C56] RAX: ffffffff8d7cf400 RBX: 0000000000000000 RCX: 0000000000000000=
=0D
[   C56] RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffff8fcc68c0=
=0D
[   C56] RBP: 000000000000270f R08: 64656c74746f7268 R09: 2020202020202020=
=0D
[   C56] R10: 00000000742e2020 R11: 00000000742e2020 R12: 0000000000000020=
=0D
[   C56] R13: ffffffff8fcc68c0 R14: 0000000000000000 R15: 0000000000000000=
=0D
[   C56] FS:  00007f4c17301740(0000) GS:ff11003fff600000(0000) knlGS:000000=
0000000000=0D
[   C56] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   C56] CR2: 00007f4c174dd650 CR3: 000000010994c004 CR4: 0000000000771ee0=
=0D
[   C56] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=
=0D
[   C56] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400=
=0D
[   C56] PKRU: 55555554=0D
[   C56] Call Trace:=0D
[   C56]  <NMI>=0D
[ C56] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115)=20
[ C56] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discr=
iminator 1))=20
[ C56] ? nmi_handle (arch/x86/kernel/nmi.c:149)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] ? default_do_nmi (arch/x86/kernel/nmi.c:347)=20
[ C56] ? exc_nmi (arch/x86/kernel/nmi.c:538)=20
[ C56] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1458)=20
[ C56] ? mem16_serial_out (drivers/tty/serial/8250/8250_port.c:382)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[ C56] ? io_serial_in (arch/x86/kernel/early_printk.c:100)=20
[   C56]  </NMI>=0D
[   C56]  <TASK>=0D
[ C56] wait_for_xmitr (drivers/tty/serial/8250/8250.h:117 drivers/tty/seria=
l/8250/8250.h:139 drivers/tty/serial/8250/8250_port.c:2106 drivers/tty/seri=
al/8250/8250_port.c:2124)=20
[ C56] serial8250_console_putchar (./include/linux/serial_core.h:704 driver=
s/tty/serial/8250/8250_port.c:3347)=20
[ C56] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_por=
t.c:3343)=20
[ C56] uart_console_write (drivers/tty/serial/serial_core.c:2134)=20
[ C56] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c=
:3628)=20
[ C56] nbcon_emit_next_record (kernel/printk/nbcon.c:940)=20
[ C56] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1192 (discriminator =
1) kernel/printk/nbcon.c:1326 (discriminator 1))=20
[ C56] vprintk_emit (kernel/printk/printk.c:2414)=20
[ C56] _printk (kernel/printk/printk.c:2474)=20
[ C56] panic (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bi=
tops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kerne=
l/panic.c:528 kernel/panic.c:339)=20
[ C56] ? _printk (kernel/printk/printk.c:2474)=20
[ C56] sysrq_handle_crash (drivers/tty/sysrq.c:154)=20
[ C56] __handle_sysrq (drivers/tty/sysrq.c:601)=20
[ C56] write_sysrq_trigger (drivers/tty/sysrq.c:1165)=20
[ C56] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352)=20
[ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) =
kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (discri=
minator 1) kernel/sched/core.c:5872 (discriminator 1))=20
[ C56] vfs_write (fs/read_write.c:582)=20
[ C56] ? __do_sys_newfstatat (fs/stat.c:466 (discriminator 1))=20
[ C56] ksys_write (fs/read_write.c:637)=20
[ C56] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:81=
)=20
[ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)=20
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ C56] ? up_read (./arch/x86/include/asm/preempt.h:104 kernel/locking/rwsem=
=2Ec:1354 kernel/locking/rwsem.c:1622)=20
[ C56] ? do_user_addr_fault (arch/x86/mm/fault.c:1368)=20
[ C56] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/in=
clude/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)=
=20
[ C56] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)=20
[   C56] RIP: 0033:0x7f4c1740cc94=0D
[ C56] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00=
 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 =
f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00=20
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   C56] RSP: 002b:00007ffe88b9b298 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0001=0D
[   C56] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4c1740cc94=
=0D
[   C56] RDX: 0000000000000002 RSI: 00005634f890b490 RDI: 0000000000000001=
=0D
[   C56] RBP: 00007ffe88b9b2c0 R08: 0000000000000410 R09: 0000000000000001=
=0D
[   C56] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002=
=0D
[   C56] R13: 00005634f890b490 R14: 00007f4c174dd5c0 R15: 00007f4c174daf20=
=0D
[   C56]  </TASK>=0D
[ T2546] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7=
411.86B.9409.D04.2212261349 12/26/2022=0D
[ T2546] Call Trace:=0D
[ T2546]  <TASK>=0D
[ T2546] dump_stack_lvl (lib/dump_stack.c:107)=20
[ T2546] panic (kernel/panic.c:340)=20
[ T2546] ? _printk (kernel/printk/printk.c:2474)=20
[ T2546] sysrq_handle_crash (drivers/tty/sysrq.c:154)=20
[ T2546] __handle_sysrq (drivers/tty/sysrq.c:601)=20
[ T2546] write_sysrq_trigger (drivers/tty/sysrq.c:1165)=20
[ T2546] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352)=20
[ T2546] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1=
) kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (disc=
riminator 1) kernel/sched/core.c:5872 (discriminator 1))=20
[ T2546] vfs_write (fs/read_write.c:582)=20
[ T2546] ? __do_sys_newfstatat (fs/stat.c:466 (discriminator 1))=20
[ T2546] ksys_write (fs/read_write.c:637)=20
[ T2546] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:=
81)=20
[ T2546] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)=20
[ T2546] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ T2546] ? up_read (./arch/x86/include/asm/preempt.h:104 kernel/locking/rws=
em.c:1354 kernel/locking/rwsem.c:1622)=20
[ T2546] ? do_user_addr_fault (arch/x86/mm/fault.c:1368)=20
[ T2546] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/=
include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561=
)=20
[ T2546] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)=20
[ T2546] RIP: 0033:0x7f4c1740cc94=0D
[ T2546] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 =
00 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 0=
0 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00=20
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[ T2546] RSP: 002b:00007ffe88b9b298 EFLAGS: 00000202=0D
[ T2546] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4c1740cc94=
=0D
[ T2546] RDX: 0000000000000002 RSI: 00005634f890b490 RDI: 0000000000000001=
=0D
[ T2546] RBP: 00007ffe88b9b2c0 R08: 0000000000000410 R09: 0000000000000001=
=0D
[ T2546] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002=
=0D
[ T2546] R13: 00005634f890b490 R14: 00007f4c174dd5c0 R15: 00007f4c174daf20=
=0D
[ T2546]  </TASK>=0D
[ T2546] Shutting down cpus with NMI=0D
[ T2546] Kernel Offset: disabled=0D
[ T2546] ---[ end Kernel panic - not syncing: sysrq triggered crash ]---=0D





-----------------------------
NMI Backtrace for 6.6.20-rt25 fully preemptive with tuned realtime profile
-----------------------------

[ T3402] sysrq: Trigger a crash=0D
[ T3406] =0D
[ T3402] Kernel panic - not syncing: sysrq triggered crash=0D
[   C56] NMI backtrace for cpu 56=0D
[   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7=
411.86B.9409.D04.2212261349 12/26/2022=0D
[ C56] RIP: 0010:delay_halt_tpause (arch/x86/lib/delay.c:118)=20
[ C56] Code: cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f=
 1f 44 00 00 48 8d 04 37 31 c9 48 89 c2 48 c1 ea 20 66 0f ae f1 <c3> cc cc =
cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
[   C56] RSP: 0018:ffa0000039cfba80 EFLAGS: 00000002=0D
[   C56] RAX: 00000099a649b2ae RBX: 00000000000006d5 RCX: 0000000000000000=
=0D
[   C56] RDX: 0000000000000099 RSI: 00000000000006d5 RDI: 00000099a649abd9=
=0D
[   C56] RBP: 00000099a649abd9 R08: 303178302f303178 R09: 302b646165726874=
=0D
[   C56] R10: 6461657268746b5f R11: 7866705f5f203f20 R12: 0000000000000020=
=0D
[   C56] R13: ffffffff9b8fd320 R14: 0000000000000000 R15: 0000000000000000=
=0D
[   C56] FS:  00007f12ca52d740(0000) GS:ff11003fff600000(0000) knlGS:000000=
0000000000=0D
[   C56] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   C56] CR2: 00007f12ca709650 CR3: 000000010fbe6003 CR4: 0000000000771ee0=
=0D
[   C56] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=
=0D
[   C56] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400=
=0D
[   C56] PKRU: 55555554=0D
[   C56] Call Trace:=0D
[   C56]  <NMI>=0D
[ C56] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115)=20
[ C56] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discr=
iminator 1))=20
[ C56] ? nmi_handle (arch/x86/kernel/nmi.c:149)=20
[ C56] ? delay_halt_tpause (arch/x86/lib/delay.c:118)=20
[ C56] ? default_do_nmi (arch/x86/kernel/nmi.c:347)=20
[ C56] ? exc_nmi (arch/x86/kernel/nmi.c:538)=20
[ C56] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1458)=20
[ C56] ? delay_halt_tpause (arch/x86/lib/delay.c:118)=20
[ C56] ? delay_halt_tpause (arch/x86/lib/delay.c:118)=20
[ C56] ? delay_halt_tpause (arch/x86/lib/delay.c:118)=20
[   C56]  </NMI>=0D
[   C56]  <TASK>=0D
[ C56] delay_halt.part.0 (arch/x86/lib/delay.c:163)=20
[ C56] wait_for_xmitr (./include/linux/nmi.h:147 drivers/tty/serial/8250/82=
50_port.c:2113 drivers/tty/serial/8250/8250_port.c:2124)=20
[ C56] serial8250_console_putchar (./include/linux/serial_core.h:704 driver=
s/tty/serial/8250/8250_port.c:3347)=20
[ C56] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_por=
t.c:3343)=20
[ C56] uart_console_write (drivers/tty/serial/serial_core.c:2134)=20
[ C56] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c=
:3628)=20
[ C56] nbcon_emit_next_record (kernel/printk/nbcon.c:940)=20
[ C56] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1192 (discriminator =
1) kernel/printk/nbcon.c:1326 (discriminator 1))=20
[ C56] vprintk_emit (kernel/printk/printk.c:2414)=20
[ C56] _printk (kernel/printk/printk.c:2474)=20
[ C56] panic (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bi=
tops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kerne=
l/panic.c:528 kernel/panic.c:339)=20
[ C56] ? _printk (kernel/printk/printk.c:2474)=20
[ C56] sysrq_handle_crash (drivers/tty/sysrq.c:154)=20
[ C56] __handle_sysrq (drivers/tty/sysrq.c:601)=20
[ C56] write_sysrq_trigger (drivers/tty/sysrq.c:1165)=20
[ C56] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352)=20
[ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) =
kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (discri=
minator 1) kernel/sched/core.c:5872 (discriminator 1))=20
[ C56] vfs_write (fs/read_write.c:582)=20
[ C56] ksys_write (fs/read_write.c:637)=20
[ C56] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:81=
)=20
[ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)=20
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ C56] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/in=
clude/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)=
=20
[ C56] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)=20
[   C56] RIP: 0033:0x7f12ca638c94=0D
[ C56] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00=
 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 =
f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00=20
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   C56] RSP: 002b:00007ffce58c2ef8 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0001=0D
[   C56] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f12ca638c94=
=0D
[   C56] RDX: 0000000000000002 RSI: 000055b5493b8490 RDI: 0000000000000001=
=0D
[   C56] RBP: 00007ffce58c2f20 R08: 0000000000000410 R09: 0000000000000001=
=0D
[   C56] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002=
=0D
[   C56] R13: 000055b5493b8490 R14: 00007f12ca7095c0 R15: 00007f12ca706f20=
=0D
[   C56]  </TASK>=0D
[   C56] NMI backtrace for cpu 56=0D
[   C56] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7=
411.86B.9409.D04.2212261349 12/26/2022=0D
[ C56] RIP: 0010:delay_halt.part.0 (arch/x86/lib/delay.c:169)=20
[ C56] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55=
 53 48 89 fb 0f 01 f9 66 90 48 c1 e2 20 48 09 c2 48 89 d5 eb 09 <48> 01 eb =
48 89 c5 48 29 c3 48 8b 05 15 bd a0 00 48 89 de 48 89 ef=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
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
   f:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  14:	55                   	push   %rbp
  15:	53                   	push   %rbx
  16:	48 89 fb             	mov    %rdi,%rbx
  19:	0f 01 f9             	rdtscp
  1c:	66 90                	xchg   %ax,%ax
  1e:	48 c1 e2 20          	shl    $0x20,%rdx
  22:	48 09 c2             	or     %rax,%rdx
  25:	48 89 d5             	mov    %rdx,%rbp
  28:	eb 09                	jmp    0x33
  2a:*	48 01 eb             	add    %rbp,%rbx		<-- trapping instruction
  2d:	48 89 c5             	mov    %rax,%rbp
  30:	48 29 c3             	sub    %rax,%rbx
  33:	48 8b 05 15 bd a0 00 	mov    0xa0bd15(%rip),%rax        # 0xa0bd4f
  3a:	48 89 de             	mov    %rbx,%rsi
  3d:	48 89 ef             	mov    %rbp,%rdi

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 01 eb             	add    %rbp,%rbx
   3:	48 89 c5             	mov    %rax,%rbp
   6:	48 29 c3             	sub    %rax,%rbx
   9:	48 8b 05 15 bd a0 00 	mov    0xa0bd15(%rip),%rax        # 0xa0bd25
  10:	48 89 de             	mov    %rbx,%rsi
  13:	48 89 ef             	mov    %rbp,%rdi
[   C56] RSP: 0018:ffa0000039cfba88 EFLAGS: 00000093=0D
[   C56] RAX: 000000ec13deb29f RBX: 000000000000076d RCX: 0000000000004038=
=0D
[   C56] RDX: 0000000000000050 RSI: 000000000000076d RDI: 000000ec13deb24f=
=0D
[   C56] RBP: 000000ec13deb24f R08: 20203138312f7068 R09: 7570632020202020=
=0D
[   C56] R10: 38312f7068757063 R11: 2020202020205320 R12: 0000000000000020=
=0D
[   C56] R13: ffffffff9b8fd320 R14: 0000000000000000 R15: 0000000000000000=
=0D
[   C56] FS:  00007f12ca52d740(0000) GS:ff11003fff600000(0000) knlGS:000000=
0000000000=0D
[   C56] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   C56] CR2: 00007f12ca709650 CR3: 000000010fbe6003 CR4: 0000000000771ee0=
=0D
[   C56] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=
=0D
[   C56] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400=
=0D
[   C56] PKRU: 55555554=0D
[   C56] Call Trace:=0D
[   C56]  <NMI>=0D
[ C56] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115)=20
[ C56] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discr=
iminator 1))=20
[ C56] ? nmi_handle (arch/x86/kernel/nmi.c:149)=20
[ C56] ? delay_halt.part.0 (arch/x86/lib/delay.c:169)=20
[ C56] ? default_do_nmi (arch/x86/kernel/nmi.c:347)=20
[ C56] ? exc_nmi (arch/x86/kernel/nmi.c:538)=20
[ C56] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1458)=20
[ C56] ? delay_halt.part.0 (arch/x86/lib/delay.c:169)=20
[ C56] ? delay_halt.part.0 (arch/x86/lib/delay.c:169)=20
[ C56] ? delay_halt.part.0 (arch/x86/lib/delay.c:169)=20
[   C56]  </NMI>=0D
[   C56]  <TASK>=0D
[ C56] wait_for_xmitr (./include/linux/nmi.h:147 drivers/tty/serial/8250/82=
50_port.c:2113 drivers/tty/serial/8250/8250_port.c:2124)=20
[ C56] serial8250_console_putchar (./include/linux/serial_core.h:704 driver=
s/tty/serial/8250/8250_port.c:3347)=20
[ C56] ? __pfx_serial8250_console_putchar (drivers/tty/serial/8250/8250_por=
t.c:3343)=20
[ C56] uart_console_write (drivers/tty/serial/serial_core.c:2134)=20
[ C56] serial8250_console_write_atomic (drivers/tty/serial/8250/8250_port.c=
:3628)=20
[ C56] nbcon_emit_next_record (kernel/printk/nbcon.c:940)=20
[ C56] __nbcon_atomic_flush_all (kernel/printk/nbcon.c:1192 (discriminator =
1) kernel/printk/nbcon.c:1326 (discriminator 1))=20
[ C56] vprintk_emit (kernel/printk/printk.c:2414)=20
[ C56] _printk (kernel/printk/printk.c:2474)=20
[ C56] panic (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bi=
tops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kerne=
l/panic.c:528 kernel/panic.c:339)=20
[ C56] ? _printk (kernel/printk/printk.c:2474)=20
[ C56] sysrq_handle_crash (drivers/tty/sysrq.c:154)=20
[ C56] __handle_sysrq (drivers/tty/sysrq.c:601)=20
[ C56] write_sysrq_trigger (drivers/tty/sysrq.c:1165)=20
[ C56] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352)=20
[ C56] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) =
kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (discri=
minator 1) kernel/sched/core.c:5872 (discriminator 1))=20
[ C56] vfs_write (fs/read_write.c:582)=20
[ C56] ksys_write (fs/read_write.c:637)=20
[ C56] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:81=
)=20
[ C56] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)=20
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ C56] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ C56] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/in=
clude/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)=
=20
[ C56] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)=20
[   C56] RIP: 0033:0x7f12ca638c94=0D
[ C56] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00=
 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 =
f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00=20
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   C56] RSP: 002b:00007ffce58c2ef8 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0001=0D
[   C56] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f12ca638c94=
=0D
[   C56] RDX: 0000000000000002 RSI: 000055b5493b8490 RDI: 0000000000000001=
=0D
[   C56] RBP: 00007ffce58c2f20 R08: 0000000000000410 R09: 0000000000000001=
=0D
[   C56] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002=
=0D
[   C56] R13: 000055b5493b8490 R14: 00007f12ca7095c0 R15: 00007f12ca706f20=
=0D
[   C56]  </TASK>=0D
[ T3402] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7=
411.86B.9409.D04.2212261349 12/26/2022=0D
[ T3402] Call Trace:=0D
[ T3402]  <TASK>=0D
[ T3402] dump_stack_lvl (lib/dump_stack.c:107)=20
[ T3402] panic (kernel/panic.c:340)=20
[ T3402] ? _printk (kernel/printk/printk.c:2474)=20
[ T3402] sysrq_handle_crash (drivers/tty/sysrq.c:154)=20
[ T3402] __handle_sysrq (drivers/tty/sysrq.c:601)=20
[ T3402] write_sysrq_trigger (drivers/tty/sysrq.c:1165)=20
[ T3402] proc_reg_write (fs/proc/inode.c:340 fs/proc/inode.c:352)=20
[ T3402] ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1=
) kernel/sched/core.c:5847 (discriminator 1) kernel/sched/core.c:5844 (disc=
riminator 1) kernel/sched/core.c:5872 (discriminator 1))=20
[ T3402] vfs_write (fs/read_write.c:582)=20
[ T3402] ksys_write (fs/read_write.c:637)=20
[ T3402] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:=
81)=20
[ T3402] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)=20
[ T3402] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ T3402] ? do_syscall_64 (arch/x86/entry/common.c:88)=20
[ T3402] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/=
include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561=
)=20
[ T3402] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)=20
[ T3402] RIP: 0033:0x7f12ca638c94=0D
[ T3402] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 =
00 00 f3 0f 1e fa 80 3d d5 76 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 0=
0 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
   6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   b:	c3                   	ret
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00=20
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d d5 76 0d 00 00 	cmpb   $0x0,0xd76d5(%rip)        # 0xd76f6
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 54                	ja     0x86
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 54                	ja     0x5c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[ T3402] RSP: 002b:00007ffce58c2ef8 EFLAGS: 00000202=0D
[ T3402] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f12ca638c94=
=0D
[ T3402] RDX: 0000000000000002 RSI: 000055b5493b8490 RDI: 0000000000000001=
=0D
[ T3402] RBP: 00007ffce58c2f20 R08: 0000000000000410 R09: 0000000000000001=
=0D
[ T3402] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000002=
=0D
[ T3402] R13: 000055b5493b8490 R14: 00007f12ca7095c0 R15: 00007f12ca706f20=
=0D
[ T3402]  </TASK>=0D
[ T3402] Kernel Offset: disabled=0D
[ T3402] ---[ end Kernel panic - not syncing: sysrq triggered crash ]---=0D

--=20
Sincerly,
John Wyatt
Software Engineer, Core Kernel


