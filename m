Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE77A33FC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjIQGaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 02:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjIQG34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 02:29:56 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39EF191
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 23:29:50 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3acfa8f8df3so4187958b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 23:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694932190; x=1695536990;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmQ57cZAJwGIiVLyuIMjLQ2uhn0vbFtYjeE9gu08mvc=;
        b=c62cfdu6zADjRMHBBwj95g5x8KDQAX35bCXvVHgz3Y0Vm4mvJsY1MX4jou4JBE2Fgz
         ZyiaCrJM3dMweKNhaX9DaIbjNoUKIRzNiyLMn1xnqM4Ex/M4lI9RrH+rC0Ac0HToB2PP
         OI5gqNTwNIjDvPq3biC1c7sladRb5rrMbub2UlKRZp3JjUnzkD2VmVVXMarUylIHquQD
         bfRsSc3yjHeCCJDM5kgYf01hxOq0de+WHFnQNgF6q9Kvk8kI0Jzp6eeqlcUjMbuUyEkl
         b/U9hUPFTe47GmdeNshdC+Ctd67E8bwsoGytg6gOGb06tPueuSAjXd26cqQ7/ov1kqMG
         vflg==
X-Gm-Message-State: AOJu0YzEXWJmk2xRMRph09+MQcKVd+yFX8u2FMD3jIHd4i2w421Gp84Y
        9N3tkIMWzFN7a3zN+i7Gr7Egc661vHpqZLZFy9kG2QzkXCz9
X-Google-Smtp-Source: AGHT+IFlunnRTdOJKQsg6jqUlGHCpkuFJCFHxCbMSuuj+5l+KodzqxTAhvntRm3nktZ1RCZcG64FJwj8/EzZMVLUnh/yWPTJchy5
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1886:b0:3a7:b48d:eaf0 with SMTP id
 bi6-20020a056808188600b003a7b48deaf0mr2805854oib.10.1694932190273; Sat, 16
 Sep 2023 23:29:50 -0700 (PDT)
Date:   Sat, 16 Sep 2023 23:29:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ea6ee0605882795@google.com>
Subject: [syzbot] [dri?] linux-next boot error: WARNING: bad unlock balance in vkms_vblank_simulate
From:   syzbot <syzbot+204dd7e9a83cb8855b63@syzkaller.appspotmail.com>
To:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        mairacanal@riseup.net, melissa.srw@gmail.com,
        rodrigosiqueiramelo@gmail.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e143016b56ec Add linux-next specific files for 20230913
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=164c5ac7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76ee1517f109f01a
dashboard link: https://syzkaller.appspot.com/bug?extid=204dd7e9a83cb8855b63
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/845fe7fc2fee/disk-e143016b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d74646a84425/vmlinux-e143016b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bfbe2696ea96/bzImage-e143016b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+204dd7e9a83cb8855b63@syzkaller.appspotmail.com


=====================================
WARNING: bad unlock balance detected!
6.6.0-rc1-next-20230913-syzkaller #0 Not tainted
-------------------------------------
swapper/0/0 is trying to release lock (&vkms_out->enabled_lock) at:
[<ffffffff852f4539>] vkms_vblank_simulate+0x159/0x3d0 drivers/gpu/drm/vkms/vkms_crtc.c:34
but there are no more locks to release!

other info that might help us debug this:
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc1-next-20230913-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 __lock_release kernel/locking/lockdep.c:5430 [inline]
 lock_release+0x4b5/0x680 kernel/locking/lockdep.c:5773
 __mutex_unlock_slowpath+0xa3/0x640 kernel/locking/mutex.c:907
 vkms_vblank_simulate+0x159/0x3d0 drivers/gpu/drm/vkms/vkms_crtc.c:34
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x203/0xc10 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1063 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:1080
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:113
Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 48 8b 04 25 c0 bc 03 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d 17 b9 b2 00 fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb 9f
RSP: 0000:ffffffff8c807d70 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8a41858e
RDX: 0000000000000001 RSI: ffff88801368d800 RDI: ffff88801368d864
RBP: ffff88801368d864 R08: 0000000000000001 R09: ffffed1017306dbd
R10: ffff8880b9836deb R11: 0000000000000000 R12: ffff888017300000
R13: ffffffff8d661d60 R14: 0000000000000000 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x82/0x500 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:215 [inline]
 do_idle+0x315/0x3f0 kernel/sched/idle.c:282
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
 rest_init+0x16f/0x2b0 init/main.c:726
 arch_call_rest_init+0x13/0x30 init/main.c:823
 start_kernel+0x39f/0x480 init/main.c:1068
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
 secondary_startup_64_no_verify+0x166/0x16b
 </TASK>
----------------
Code disassembly (best guess):
   0:	ed                   	in     (%dx),%eax
   1:	c3                   	ret
   2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 00
   d:	66 90                	xchg   %ax,%ax
   f:	65 48 8b 04 25 c0 bc 	mov    %gs:0x3bcc0,%rax
  16:	03 00
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d 17 b9 b2 00 	verw   0xb2b917(%rip)        # 0xb2b93f
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 00             	nopl   (%rax)
  2f:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
  33:	3c 01                	cmp    $0x1,%al
  35:	74 0b                	je     0x42
  37:	3c 02                	cmp    $0x2,%al
  39:	74 05                	je     0x40
  3b:	8b 7f 04             	mov    0x4(%rdi),%edi
  3e:	eb 9f                	jmp    0xffffffdf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
