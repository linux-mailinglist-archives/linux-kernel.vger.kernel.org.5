Return-Path: <linux-kernel+bounces-50932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB488483EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B5B288F57
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4110A29;
	Sat,  3 Feb 2024 05:12:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0510A09
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 05:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706937149; cv=none; b=rUKCFUfHTdggvWZWz9nIcXRKmeYF1YCHBw1HerEcFSrNxlyEsLXqYpaRp/eKLKjPjiHbih9FDJjp+w29cDxC/VFCh3NGMYGFFtKhfS4VL0Qc8B/OKTeml68A4ZGsCK3JfCMNIZG3y7mypt9oWHpgiMcr+3oKl8GvlrKWk5UFC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706937149; c=relaxed/simple;
	bh=rS76oOmDnuLA/zDX3+Q9a2q9Hrbio7C96VmS2Ut7XQk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C7eGk+0lR3gJRtROWC5hKteLJ/WvHRU6UrzxYI4aCPu6FdazSMhF95RUiXHVbFXbg+scwAMI41ZQpsSQ4L58Ds6zveoM68FPo2XDqveTgqU/9wC8gWgCA/x1GGN4tLAqHPdLlvWp+6KnrFViXQv0a6+bRPzunJKg8bQ1KHQXCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b295deb1so12354175ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 21:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706937146; x=1707541946;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9qtWeK5w/0vxfxIW2f6JA8zjnJ7ABQj00L2RKys1YI=;
        b=emnA8WSj/uydMMmKr8QvgIO1Rgzcubt0QUz3StI+DIJl3LTl9P9IdZ8NwhglJJa01f
         IMyhGWvcZzxZMHD+E8e4hAstKvFOZ0xQhw7DLn4TepqB7WvVJV8CfFZmVnEmcTiHGIU3
         KrL4mA2O1mZnCWPlIAnzcC90eLJsJ2zlshnuZMGEZSI6AmtcnaY/jThVS5CCEgYtU++W
         1M+yDW/l6z+T/kewJRFyI5p8n2KloiVAfP4W+GIfDyBBmBKGPINDTe0ByZO7j0t9g2mZ
         YadWJT6YAWMyJ1718uyAdfda6a8bPGm7VB/3vnUeeKULhCgXr7FzBmC/C/OaK4NfdnlY
         cxSg==
X-Gm-Message-State: AOJu0YzCUeFUsVNzQ8D8nzxo1oRtlNcN9fUQ8Nc2+P1fh4fiB3e4XqqB
	XdaDNXWJppASbskqYzb01A0pjWeKfWS/x6LA+wzS8qmWSDRZZP+mbt47oYhtNa1DdTnBCtiBagu
	V379GbGFytE6dEUvEzqVC64rWZMK0/90ONrM/fZpW1eq6aM4YIKunvlCr/Q==
X-Google-Smtp-Source: AGHT+IEJ4NgFFk9Jxp6tm+Jvq1gbSGMteg9bwDdD0kqVdVuLkQ8HSvIsklzq8vgOxO0lfx8xBMYBhRd6XoTgtscIVxB+9L8N6bzN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56c:0:b0:363:a059:670b with SMTP id
 b12-20020a92c56c000000b00363a059670bmr288175ilj.4.1706937146794; Fri, 02 Feb
 2024 21:12:26 -0800 (PST)
Date: Fri, 02 Feb 2024 21:12:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049e78d061073467c@google.com>
Subject: [syzbot] [kernel?] linux-next boot error: WARNING in wq_update_node_max_active
From: syzbot <syzbot+f91f2ed0a5258704982f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    06f658aadff0 Add linux-next specific files for 20240131
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D14882997e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D854ef3e6fbbe979=
f
dashboard link: https://syzkaller.appspot.com/bug?extid=3Df91f2ed0a52587049=
82f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b4f22c20549/disk-=
06f658aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9150a87d7432/vmlinux-=
06f658aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a572351012f3/bzI=
mage-06f658aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+f91f2ed0a5258704982f@syzkaller.appspotmail.com

Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
Initmem setup node 1 [mem 0x0000000140000000-0x000000023fffffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 97 pages in unavailable ranges
On node 0, zone Normal: 3 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
ACPI: PM-Timer IO Port: 0xb008
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
ACPI: Using ACPI (MADT) for SMP configuration information
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xbfffd000-0xbfffffff]
PM: hibernation: Registered nosave memory:serialport: Connected to syzkalle=
r.us-central1-c.ci-upstream-linux-next-kasan-gce-root-test-1 port 1 (sessio=
n ID: 307732399ece189a8aef52b22bfe9e76c226ee4a91fad6ea856fd1c30fec1568, act=
ive connections: 1).
PM: hibernation: Registered nosave memory: [mem 0xfffbc000-0xffffffff]
[mem 0xc0000000-0xfffbbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_=
idle_ns: 19112604462750000 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:2
percpu: Embedded 72 pages/cpu s256200 r8192 d30520 u1048576
kvm-guest: PV spinlocks enabled
PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
Kernel command line: earlyprintk=3Dserial net.ifnames=3D0 sysctl.kernel.hun=
g_task_all_cpu_backtrace=3D1 ima_policy=3Dtcb nf-conntrack-ftp.ports=3D2000=
0 nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.ports=3D20000 nf-conntra=
ck-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000 binder.debug_mask=3D0 =
rcupdate.rcu_expedited=3D1 rcupdate.rcu_cpu_stall_cputime=3D1 no_hash_point=
ers page_owner=3Don sysctl.vm.nr_hugepages=3D4 sysctl.vm.nr_overcommit_huge=
pages=3D4 secretmem.enable=3D1 sysctl.max_rcu_stall_to_panic=3D1 msr.allow_=
writes=3Doff coredump_filter=3D0xffff root=3D/dev/sda console=3DttyS0 vsysc=
all=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 spec_store_bypass_disable=
=3Dprctl nopcid vivid.n_devs=3D16 vivid.multiplanar=3D1,2,1,2,1,2,1,2,1,2,1=
,2,1,2,1,2 netrom.nr_ndevs=3D16 rose.rose_ndevs=3D16 smp.csd_lock_timeout=
=3D100000 watchdog_thresh=3D55 workqueue.watchdog_thresh=3D140 sysctl.net.c=
ore.netdev_unregister_timeout_secs=3D140 dummy_hcd.num=3D8 panic_on_warn=3D=
1 BOOT_IMAGE=3D/boot/bzImage root=3D/dev/sda1 console=3DttyS0
Unknown kernel command line parameters "spec_store_bypass_disable=3Dprctl B=
OOT_IMAGE=3D/boot/bzImage", will be passed to user space.
random: crng init done
Fallback order for Node 0: 0 1=20
Fallback order for Node 1: 1 0=20
Built 2 zonelists, mobility grouping on.  Total pages: 2064125
Policy zone: Normal
mem auto-init: stack:all(zero), heap alloc:on, heap free:off
stackdepot: allocating hash table via alloc_large_system_hash
stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
software IO TLB: area num 2.
Memory: 6760000K/8388204K available (163840K kernel code, 38961K rwdata, 36=
628K rodata, 25688K init, 33252K bss, 1627948K reserved, 0K cma-reserved)
SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D2
allocated 167772160 bytes of page_ext
Node 0, zone      DMA: page owner found early allocated 0 pages
Node 0, zone    DMA32: page owner found early allocated 20599 pages
Node 0, zone   Normal: page owner found early allocated 0 pages
Node 1, zone   Normal: page owner found early allocated 20484 pages
Kernel/User page tables isolation: enabled
Dynamic Preempt: full
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:143 cpu_max_bits_warn inc=
lude/linux/cpumask.h:143 [inline]
WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:143 cpumask_check include=
/linux/cpumask.h:150 [inline]
WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:143 cpumask_test_cpu incl=
ude/linux/cpumask.h:516 [inline]
WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:143 wq_update_node_max_ac=
tive+0x636/0x780 kernel/workqueue.c:1513
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-next-20240131-syzkaller=
 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 11/17/2023
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:143 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:150 [inline]
RIP: 0010:cpumask_test_cpu include/linux/cpumask.h:516 [inline]
RIP: 0010:wq_update_node_max_active+0x636/0x780 kernel/workqueue.c:1513
Code: ed 71 09 31 ff 89 c3 89 c6 e8 46 65 34 00 85 db 0f 85 0d fb ff ff e8 =
59 6a 34 00 90 0f 0b 90 e9 ff fa ff ff e8 4b 6a 34 00 90 <0f> 0b 90 e9 1c f=
b ff ff 48 89 df e8 fa f8 8e 00 e9 48 fd ff ff 48
RSP: 0000:ffffffff8d407c08 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffffffff81585961
RDX: ffffffff8d495a40 RSI: ffffffff81585e45 RDI: 0000000000000005
RBP: ffff888014c91da0 R08: 0000000000000005 R09: 0000000000000007
R10: 00000000ffffffff R11: 0000000000000001 R12: ffff888014c99000
R13: 0000000000000200 R14: ffff888014c91db0 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000d57a000 CR4: 00000000000000b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 apply_wqattrs_commit+0x430/0x590 kernel/workqueue.c:4844
 apply_workqueue_attrs_locked+0xf3/0x160 kernel/workqueue.c:4871
 apply_workqueue_attrs kernel/workqueue.c:4902 [inline]
 alloc_and_link_pwqs kernel/workqueue.c:5023 [inline]
 alloc_workqueue+0x1256/0x1a90 kernel/workqueue.c:5232
 workqueue_init_early+0xcb4/0x1080 kernel/workqueue.c:7218
 start_kernel+0x199/0x480 init/main.c:958
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
 secondary_startup_64_no_verify+0x170/0x17b
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

