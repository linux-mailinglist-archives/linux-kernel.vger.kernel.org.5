Return-Path: <linux-kernel+bounces-73375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B0F85C19F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C32847BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFE6763E6;
	Tue, 20 Feb 2024 16:45:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA792599
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447522; cv=none; b=WAFyJEer3r5dF7J64m9124lSsjzcG3uJNUoWFyLHJ85lNi0GxI3PtSDeHCJRcdNma0Es6nLz+1GXf56Hk7fFLhEn7Kgs8xVwONEyKNgAzKXAxARruHUEUrhJCey4RtQI7AOZhlgnxkZUM5WPWUn/Joc2T+N7YSBqRdjCiaRhKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447522; c=relaxed/simple;
	bh=c1D4rlM510gY5weSBkSUuBGYNxAQhU4aPR/vVy8FzCw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LfsZYj869ilTDB6nRGO7LU4OtQDCCr2sXX8EEajSEHsn/8vQB1Ka3duWHfpDHj4WFW8TRljcmJ8xk7zZyF3UojYfs0fLRi/+HcqcNcu6Eaju7OA0uoxU7mXx4Dl32p0ADojjyMbwEVmfNRl24vQu9psKsQJFTd/YAs8CGNnsb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c42b7ee0a5so400356139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708447520; x=1709052320;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fH7I8lnvkBfxk8NOEzSyJJEy+42o1cCaA4kwg+bg9TA=;
        b=v4zO7Ep9htQuI8znmESmvGgPpOhxXJp5/fMnZa+rQWNB/kWnmT0FoZXzXzOZ8WWJAA
         uu1SVbi7Nx4sspB17SPcsvK786hmGIzVwDGSyJQ9dCl8nevUKjrzPFLF38KwJGnawpmM
         07y/WO9I+LWlBbXOxS4/QEkCScagwZYUsZU9G0Sp+EVQBPE7Yw/60n32GQAr1A5VnY7l
         W+zqgep6eNPR6qq4gwRnaBkT3vIq+xVAPN1p3w8acxPV60uRow0/wpLZbtXocJEra7ZB
         f9Lz2K1iKykCMY8P+3Cofhvb2XpWbAKuVeTI93MzJjKTwKWKGTzsuDPi0TItUGiWCKdR
         pvvw==
X-Forwarded-Encrypted: i=1; AJvYcCWlQR8PkHRbEnYSw76PcRXD+1ZenKCufVSyw2J7dvskuxpxNXbZNyCECNzc0QIOilWWSDgdwQSVq9i3ETomdtJ/6lo78AABKOZz73ho
X-Gm-Message-State: AOJu0YzUS/KJ9NryzlAhTm3uqVltshGJeuSPWOqeYTajZzK2uBLzou9x
	OnVPz5cqD1kKtL8D9orxun16zJ+MwW1yl3bUrMBN0lpFH6yCj3J1XWLl+3zuUabqhrbfSVAZmPW
	gf1PDOPHwnVZE18STZuybH0hUPK6Yq6ch7ISqZ5Iw5SeRDrBiI2n16vc=
X-Google-Smtp-Source: AGHT+IHxdIbbLMjWj4k1XdrDZd+xTYRzC3kxcOX/Dr3+dPrhkWC/GonpOLzzeGNmCxGg29CKcz5Y2fz+VJ9WxOQYK/gA1rl1eQkG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4911:b0:471:52c3:4661 with SMTP id
 cx17-20020a056638491100b0047152c34661mr477424jab.5.1708447518817; Tue, 20 Feb
 2024 08:45:18 -0800 (PST)
Date: Tue, 20 Feb 2024 08:45:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a02930611d2efbb@google.com>
Subject: [syzbot] [input?] [usb?] INFO: rcu detected stall in sys_syslog (2)
From: syzbot <syzbot+269f9ad9bc32451d5fb5@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cff3a4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=269f9ad9bc32451d5fb5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f4a68a180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d430539932db/disk-4f5e5092.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6369586e33b7/vmlinux-4f5e5092.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c1e38f80254/bzImage-4f5e5092.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+269f9ad9bc32451d5fb5@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-...D
 } 2649 jiffies s: 5869 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
 kthread+0x2ef/0x390 kernel/kthread.c:388
NMI backtrace for cpu 0
CPU: 0 PID: 5441 Comm: syz-executor.0 Not tainted 6.8.0-rc4-syzkaller-00180-g4f5e5092fdbf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x2e/0x70 kernel/kcov.c:207
Code: 48 8b 04 24 65 48 8b 0d b0 52 70 7e 65 8b 15 b1 52 70 7e f7 c2 00 01 ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 fc 15 00 00 00 <74> 2c 8b 91 d8 15 00 00 83 fa 02 75 21 48 8b 91 e0 15 00 00 48 8b
RSP: 0018:ffffc90000006128 EFLAGS: 00000046
RAX: ffffffff8b5fbfa4 RBX: 0000000000000131 RCX: ffff88805db05940
RDX: 0000000000000103 RSI: 0000000000000131 RDI: ffffc900000061e0
RBP: ffffc90000006270 R08: ffffffff8b60127a R09: 0000000000000000
R10: ffffc900000061e0 R11: fffff52000000c3f R12: 00000000ffff0a00
R13: dffffc0000000000 R14: ffffc900000061e0 R15: ffffc900000065c1
FS:  0000555555c97480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe746ba8008 CR3: 000000002f932000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 put_dec+0x14/0xe0 lib/vsprintf.c:291
 number+0x337/0xf90 lib/vsprintf.c:511
 vsnprintf+0x1542/0x1da0 lib/vsprintf.c:2890
 sprintf+0xda/0x120 lib/vsprintf.c:3028
 print_time kernel/printk/printk.c:1324 [inline]
 info_print_prefix+0x16b/0x310 kernel/printk/printk.c:1350
 record_print_text kernel/printk/printk.c:1399 [inline]
 printk_get_next_message+0x408/0xce0 kernel/printk/printk.c:2828
 console_emit_next_record kernel/printk/printk.c:2868 [inline]
 console_flush_all+0x42d/0xec0 kernel/printk/printk.c:2967
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3036
 vprintk_emit+0x508/0x720 kernel/printk/printk.c:2303
 _printk+0xd5/0x120 kernel/printk/printk.c:2328
 printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
 show_trace_log_lvl+0x438/0x520 arch/x86/kernel/dumpstack.c:285
 sched_show_task+0x50c/0x6d0 kernel/sched/core.c:9171
 show_state_filter+0x19e/0x270 kernel/sched/core.c:9216
 kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
 kbd_event+0x30fa/0x4910 drivers/tty/vt/keyboard.c:1543
 input_to_handler drivers/input/input.c:132 [inline]
 input_pass_values+0x945/0x1200 drivers/input/input.c:161
 input_event_dispose+0x402/0x650 drivers/input/input.c:389
 input_handle_event+0xa71/0xbe0 drivers/input/input.c:406
 input_event+0xa4/0xd0 drivers/input/input.c:435
 hidinput_hid_event+0x138b/0x1c90 drivers/hid/hid-input.c:1731
 hid_process_event+0x439/0x590 drivers/hid/hid-core.c:1541
 hid_input_array_field+0x3fb/0x5c0 drivers/hid/hid-core.c:1653
 hid_process_report drivers/hid/hid-core.c:1695 [inline]
 hid_report_raw_event+0xf4f/0x18a0 drivers/hid/hid-core.c:2016
 hid_input_report+0x416/0x500 drivers/hid/hid-core.c:2090
 hid_irq_in+0x4a0/0x6d0 drivers/hid/usbhid/hid-core.c:284
 __usb_hcd_giveback_urb+0x373/0x530 drivers/usb/core/hcd.c:1650
 dummy_timer+0x8aa/0x3220 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x17e/0x600 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x621/0x830 kernel/time/timer.c:2038
 run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2051
 __do_softirq+0x2bb/0x942 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x97/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__asan_memcpy+0x3b/0x70 mm/kasan/shadow.c:106
Code: 49 89 ff 48 8b 5c 24 20 48 89 f7 48 89 d6 31 d2 48 89 d9 e8 a7 e3 ff ff 84 c0 74 2c 4c 89 ff 4c 89 e6 ba 01 00 00 00 48 89 d9 <e8> 90 e3 ff ff 84 c0 74 15 4c 89 ff 4c 89 f6 4c 89 e2 5b 41 5c 41
RSP: 0018:ffffc90004e875f8 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffffff8b5fca58 RCX: ffffffff8b5fca58
RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffc90004e879c8
RBP: ffffc90004e87710 R08: 0000000000000004 R09: fffffbfff1756eb8
R10: dffffc0000000000 R11: fffffbfff1756eb8 R12: 0000000000000001
R13: dffffc0000000000 R14: ffffffff8bab75c4 R15: ffffc90004e879c8
 vsnprintf+0x948/0x1da0 lib/vsprintf.c:2786
 sprintf+0xda/0x120 lib/vsprintf.c:3028
 print_caller kernel/printk/printk.c:1335 [inline]
 info_print_prefix+0x204/0x310 kernel/printk/printk.c:1352
 get_record_print_text_size kernel/printk/printk.c:1487 [inline]
 find_first_fitting_seq+0x1b2/0x580 kernel/printk/printk.c:1516
 syslog_print_all+0x1ae/0x7e0 kernel/printk/printk.c:1664
 do_syslog+0x38d/0x890 kernel/printk/printk.c:1742
 __do_sys_syslog kernel/printk/printk.c:1820 [inline]
 __se_sys_syslog kernel/printk/printk.c:1818 [inline]
 __x64_sys_syslog+0x7c/0x90 kernel/printk/printk.c:1818
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f92d367dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec8726828 EFLAGS: 00000246 ORIG_RAX: 0000000000000067
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f92d367dda9
RDX: 000000000000003f RSI: 00007ffec8726900 RDI: 0000000000000003
RBP: 00007ffec8726900 R08: 00007ffec87e60b0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffec8726ee8
R13: 00007ffec8726ee8 R14: 0000000000000001 R15: 00000000fffffff1
 </TASK>
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
task:kworker/R-bat_e state:I stack:28848 pid:2748  tgid:2748  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 rescuer_thread+0xc45/0xda0 kernel/workqueue.c:2937
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
task:kworker/u4:10   state:I stack:25808 pid:2799  tgid:2799  ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 worker_thread+0xc26/0x1000 kernel/workqueue.c:2802
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
task:kworker/u4:11   state:I stack:24248 pid:2829  tgid:2829  ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 worker_thread+0xc26/0x1000 kernel/workqueue.c:2802
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
task:kworker/u4:12   state:I stack:23024 pid:2849  tgid:2849  ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 worker_thread+0xc26/0x1000 kernel/workqueue.c:2802
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
task:kworker/u4:13   state:I stack:26800 pid:2888  tgid:2888  ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 worker_thread+0xc26/0x1000 kernel/workqueue.c:2802
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
task:kworker/u4:14   state:I stack:29392 pid:2906  tgid:2906  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 worker_thread+0xc26/0x1000 kernel/workqueue.c:2802
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
task:kworker/R-zswap state:I stack:29744 pid:4464  tgid:4464  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 rescuer_thread+0xc45/0xda0 kernel/workqueue.c:2937
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

