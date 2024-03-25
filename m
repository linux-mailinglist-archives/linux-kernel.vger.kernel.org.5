Return-Path: <linux-kernel+bounces-116366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45388898A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BDA1F20CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525D1C6FF6;
	Mon, 25 Mar 2024 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m73uczxz"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587414431C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711329471; cv=none; b=CL3utdZkIXxbZlqKsUJazjVuvnCwGgrLHTl4w6yS8Qma/InkrsXzDRKKFY3Z4ADZXc0mncz2TMSYYWy62qPX2ts5W4204Ykb8ypAAb4sIu4GUViwRO2bC+6iRhaKBQFl8zS9xNigBzymy+iUu1DP3v7387ElMvGdsnNdbYJRh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711329471; c=relaxed/simple;
	bh=iGfzoEokTS92HFEWfJRDXTy7NKfr67I3NMju5GMj5Xk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uGHjO8ENg3rhrESmGH2gP6Jllj+YibsiY+HNlOCO5TGkrwQQ/SK/0SFQWDcMJJ+IlLmWuka9Ptxp5/zpusVX8NoDpCjVwctukHMGNxiZ9YbYMTPfp+G3sbWrRzvl155sz5r7f+6tP05orJ4Iljpdc1WJ5q4c9pJPNztGAG21n40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m73uczxz; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d46c4e1578so1245461e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711329467; x=1711934267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kU5TWHiQuvGGnyERsdh7pD0V5Thqilq1K5xPwsBWaFc=;
        b=m73uczxzqI65+p6dc19pHbbMJWTlzFJDIBGPNXZerKO/12QLoSIqlR1sWnSo7NrBJa
         ck+A136TfVNvmP5nAKe6oCfsa0oNbtWtfHDUkEDIRbdTCTH3TzugUPT6M/T2ViKOqZTo
         LYZ2uDG1PQmfwEgbdWPbEWIcLeJ+uYULjQfohc5UIiNHGiuaUW4E2Wz6kT3OtX46n9fx
         iBIReWDK/VHFuaJVB5cKfsBOmBJezfwWxlvjDIvZqHyAn1VaX//31H6Dd7qdccLfcx/o
         zWGwgmqFTuUQAxVKmYeNBoLvm8tO5XQDGmkXVdQIq2ILKHZWwr3TR2rp5IZXyuhZeVju
         VGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711329467; x=1711934267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kU5TWHiQuvGGnyERsdh7pD0V5Thqilq1K5xPwsBWaFc=;
        b=ZuMqx4v6A653LQVf/hxLLwWpJCLk34DdJ6msSnmU0no6lFyFDwHujaSGVrNDTv/G1v
         hn91sghB1ym5MeU1CtxNUlx4G85cqyGjR+ZuFr3nZF2SaUjRJvJahTUZAnWWLYG8jNhZ
         Hc0jU1v58ecd7PwTsfOliz6JswsJHFijGvWZiXfoBbZ/lk1oNVK/nuTTHys4j9ZIGTA+
         76LVnoHg1ctuoxXqXOjdnMsj6TDMaJFc4FQWXyI9OUjymAaAYRBKx49IThziyWJdV+9C
         gzjRW3eE3AmAe2Qst62G1Ty25dw3mwFtOf5KgbbYj5g8CYpU8XaHtf2RORROth5vDfip
         bofw==
X-Forwarded-Encrypted: i=1; AJvYcCXS7rh/kM7jHJRRzsM/FrSohh7N7GoiNQuojMovd4ns7pNfS+AKC10Yzi77B4tmhhY3lf+7Tms8vT5SWdqsYvvLPYOI3vLriTasZ3xz
X-Gm-Message-State: AOJu0YwrMA7a/kSHdbLHqybN+g9b6qncP7lgDxtneNHCBfKFB+lpaOze
	qeaV1RHT+5hMTQrItQk19tUOKVVa2E+aG33NjYSXDSxzENHNrkn9M1aJrANMa2OQKBozOfpYrsz
	xh2My3HMhg0ACGoiwfvf3nvTArak=
X-Google-Smtp-Source: AGHT+IF+7lStkCL4lBJJANhunGBS5bc3rwzBOLQcATcgW2Ofp+2qgmi/DY9Xmt6GqZ1wWlXE7f4WH293YgMswq15pak=
X-Received: by 2002:a05:6122:219f:b0:4d4:b89:bd2d with SMTP id
 j31-20020a056122219f00b004d40b89bd2dmr3267197vkd.1.1711329467205; Sun, 24 Mar
 2024 18:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cnitlrt pwn <cnitlrt@gmail.com>
Date: Mon, 25 Mar 2024 09:17:35 +0800
Message-ID: <CAK55_s7Xyq=nh97=K=G1sxueOFrJDAvPOJAL4TPTCAYvmxO9_A@mail.gmail.com>
Subject: linux kernel 6.1.82 BUG: KASAN: stack-out-of-bounds in profile_pc
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,Look forward to your favourable reply
I use syzkaller found the following issue on:
Linux 6.1.82
kernel config:https://drive.google.com/file/d/10crxboyUU3LTR2TnLE5Dn8mbpMjf=
4Mmh/view?usp=3Dsharing
C reproducer: https://drive.google.com/file/d/1BiHzX7sv7IkHWNSxIOd8-lQHqZUp=
sweo/view?usp=3Dsharing

Downloadable assets:
kernel image:https://drive.google.com/file/d/1IZyKop-cvHeRXGaQbb4OqAAd7_QkY=
3um/view?usp=3Dsharing

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: cnitlrt@gmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: stack-out-of-bounds in profile_pc+0x120/0x130
arch/x86/kernel/time.c:42
Read of size 8 at addr ffff888108567cc8 by task syz-executor308/360

CPU: 0 PID: 360 Comm: syz-executor308 Not tainted 6.1.82 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x4d/0x66 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x16c/0x4a3 mm/kasan/report.c:395
 kasan_report+0xb3/0x130 mm/kasan/report.c:495
 profile_pc+0x120/0x130 arch/x86/kernel/time.c:42
 profile_tick+0x8f/0xd0 kernel/profile.c:339
 tick_sched_timer+0xce/0x100 kernel/time/tick-sched.c:1501
 __run_hrtimer kernel/time/hrtimer.c:1686 [inline]
 __hrtimer_run_queues+0x2d0/0x6c0 kernel/time/hrtimer.c:1750
 hrtimer_interrupt+0x2c9/0x6c0 kernel/time/hrtimer.c:1812
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1095 [inline]
 __sysvec_apic_timer_interrupt+0xc5/0x2a0 arch/x86/kernel/apic/apic.c:1112
 sysvec_apic_timer_interrupt+0x65/0x90 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:=
653
RIP: 0010:arch_atomic_try_cmpxchg arch/x86/include/asm/atomic.h:202 [inline=
]
RIP: 0010:atomic_try_cmpxchg_acquire
include/linux/atomic/atomic-instrumented.h:543 [inline]
RIP: 0010:queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
RIP: 0010:do_raw_spin_lock include/linux/spinlock.h:187 [inline]
RIP: 0010:__raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
RIP: 0010:_raw_spin_lock+0x8a/0xd0 kernel/locking/spinlock.c:154
Code: c7 44 24 20 00 00 00 00 e8 b3 7b bb fd be 04 00 00 00 48 8d 7c
24 20 e8 a4 7b bb fd ba 01 00 00 00 8b 44 24 20 f0 0f b1 55 00 <75> 2d
48 b8 00 00 00 00 00 fc ff df 48 c7 04 03 00 00 00 00 48 8b
RSP: 0000:ffff888108567cc8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 1ffff110210acf99 RCX: ffffffff83a9b40c
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff888108567ce8
RBP: ffffea00042d07a8 R08: 0000000000000001 R09: ffffed10210acf9e
R10: 0000000000000003 R11: ffffed10210acf9d R12: 0000000000000000
R13: 000000010b41e067 R14: 000000010b41e000 R15: ffff88810b0cbf78
 spin_lock include/linux/spinlock.h:351 [inline]
 handle_pte_fault mm/memory.c:5023 [inline]
 __handle_mm_fault+0xa0b/0x2470 mm/memory.c:5155
 handle_mm_fault+0x119/0x440 mm/memory.c:5276
 do_user_addr_fault+0x36c/0xcd0 arch/x86/mm/fault.c:1380
 handle_page_fault arch/x86/mm/fault.c:1471 [inline]
 exc_page_fault+0x78/0x120 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7ffbc6c89c35
Code: b8 47 00 00 00 31 c0 ba 80 00 00 20 f3 a4 b9 02 00 00 00 48 c7
c6 9c ff ff ff bf 01 01 00 00 e8 a1 8d 04 00 48 83 f8 ff 74 07 <48> 89
05 d4 33 0c 00 b8 c0 00 00 20 b9 9a 00 00 00 ba c0 00 00 20
RSP: 002b:00007ffdebd040b0 EFLAGS: 00010213
RAX: 0000000000000003 RBX: 00000000000054a6 RCX: 00007ffbc6cd29ed
RDX: 0000000000000002 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 0000000000000000 R08: 00007ffdebd03b10 R09: 00000000c6c8ba40
R10: 0000000000000047 R11: 0000000000000246 R12: 00007ffdebd040b4
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to stack of task syz-executor308/360
 and is located at offset 0 in frame:
 _raw_spin_lock+0x0/0xd0 kernel/locking/spinlock.c:179

This frame has 1 object:
 [32, 36) 'val'

The buggy address belongs to the physical page:
page:00000000640c47bc refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x108567
flags: 0x200000000000000(node=3D0|zone=3D2)
raw: 0200000000000000 0000000000000000 ffffea00042159c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888108567b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888108567c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888108567c80: 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 04 f3 f3
                                              ^
 ffff888108567d00: f3 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
 ffff888108567d80: f1 f1 f1 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
----------------
Code disassembly (best guess):
   0: c7 44 24 20 00 00 00 movl   $0x0,0x20(%rsp)
   7: 00
   8: e8 b3 7b bb fd       callq  0xfdbb7bc0
   d: be 04 00 00 00       mov    $0x4,%esi
  12: 48 8d 7c 24 20       lea    0x20(%rsp),%rdi
  17: e8 a4 7b bb fd       callq  0xfdbb7bc0
  1c: ba 01 00 00 00       mov    $0x1,%edx
  21: 8b 44 24 20           mov    0x20(%rsp),%eax
  25: f0 0f b1 55 00       lock cmpxchg %edx,0x0(%rbp)
* 2a: 75 2d                 jne    0x59 <-- trapping instruction
  2c: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  33: fc ff df
  36: 48 c7 04 03 00 00 00 movq   $0x0,(%rbx,%rax,1)
  3d: 00
  3e: 48                   rex.W
  3f: 8b                   .byte 0x8b


Syzkaller reproducer:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false
Fault:false FaultCall:0 FaultNth:0}}
r0 =3D openat$sysfs(0xffffffffffffff9c,
&(0x7f0000000080)=3D'/sys/kernel/profiling', 0x2, 0x47)
write(r0, &(0x7f00000000c0)=3D"36036f1493deafdf2328cff2f08fa0e04427785d08d3=
825b73a1000b7e4e42a7561b2bb4786f42b1701bf3f273498f2354cd89ea2f278dc852638fb=
05a507ce9f729dd4260d23f2d752d5fb9a00c116545d00a0288505f73edc4fbb5f93064470b=
a6fc63d360db762a1cbd17696484030ce373fad1d8725946056bf0a66f5cda139fba5f9c4e3=
878a7b33485dfddabae74000000000000000000",
0x9a)

