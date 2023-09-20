Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE37A8997
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjITQgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbjITQgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:36:16 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC5D83
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:36:10 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3adc84193d7so5616923b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695227769; x=1695832569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZneNGLoZpE1aQ918Mnxcaup0nwMvcyoZT6gWdl0MxU=;
        b=vcfyEydAYc1WCtD54Ywb6NiynKmfCFHtbt1gdbPMxtEuMYhxvQsxlslPlNiH46SKKt
         4M2yX3o8nk8HdJznfta/egnZkGcyj58pt8QYn0mGW+mxMzFyFAZXDy0ae2rLcV/IhnkV
         MS2KwPVlmgSkM0r403bU+aONVZefgEQOeEwF2yui4CjKxdw/bdONolzJunpN5QwN55FZ
         Ty2dCc8DHeDr/BSDZfPqlu3R0Ck/eMEBkP4ivwdW7cxWEbhMZsn4sQfpeGmhTcYJPzVP
         RywZDtZUyJYPtPbCVjZAljQHC0XnPsArTC8l/K1wyDUN6r7KxyWaZK6II7/s6L4QQI+m
         hTJA==
X-Gm-Message-State: AOJu0YzAyOojkz0vAZYDpGLFLt4tf3Mh8IajSifNMxiHGwoLHWZvlz3s
        2azdrZk8TIYV18Lt04FdqH+dkt/4UyAO6F+/vidAP06q8p4R
X-Google-Smtp-Source: AGHT+IHZSCQtqLdIxxtG48MrnLBajCNsQhfUEnDcxibMj/9lNUCTNlbcAo+TTqqkLhlv3jsLIxDQNE41mspdP8vDHuFPfWRWDUya
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a13:b0:3a8:4311:3d7f with SMTP id
 bk19-20020a0568081a1300b003a843113d7fmr1409240oib.5.1695227769350; Wed, 20
 Sep 2023 09:36:09 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:36:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000170df0605ccf91a@google.com>
Subject: [syzbot] [serial?] KASAN: stack-out-of-bounds Read in sched_show_task
From:   syzbot <syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8eb8fe67e2c8 riscv: errata: fix T-Head dcache.cva encoding
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1206d6c4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89f0a88d4bc7f0f4
dashboard link: https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144d1154680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122a2a3c680000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-8eb8fe67.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a41f94065e95/vmlinux-8eb8fe67.xz
kernel image: https://storage.googleapis.com/syzbot-assets/29db706d00c4/Image-8eb8fe67.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com

[<ffffffff8360b8b4>] context_switch kernel/sched/core.c:5382 [inline]
[<ffffffff8360b8b4>] __schedule+0x794/0x1884 kernel/sched/core.c:6695
[<ffffffff8360ca1c>] schedule+0x78/0xfe kernel/sched/core.c:6771
[<ffffffff83617bb6>] do_nanosleep+0x18a/0x318 kernel/time/hrtimer.c:2047
==================================================================
BUG: KASAN: out-of-bounds in walk_stackframe+0x130/0x2f2 arch/riscv/kernel/stacktrace.c:59
Read of size 8 at addr ff20000006d37c38 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.0-rc1-syzkaller-g8eb8fe67e2c8 #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000b966>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:121
[<ffffffff835c3860>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:127
[<ffffffff836036ae>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff836036ae>] dump_stack_lvl+0xe8/0x154 lib/dump_stack.c:106
[<ffffffff835cbf28>] print_address_description mm/kasan/report.c:364 [inline]
[<ffffffff835cbf28>] print_report+0x1e4/0x4f4 mm/kasan/report.c:475
[<ffffffff8057aa66>] kasan_report+0xf0/0x1ba mm/kasan/report.c:588
[<ffffffff8057bd82>] check_region_inline mm/kasan/generic.c:181 [inline]
[<ffffffff8057bd82>] __asan_load8+0x80/0xa8 mm/kasan/generic.c:260
[<ffffffff8000b712>] walk_stackframe+0x130/0x2f2 arch/riscv/kernel/stacktrace.c:59
[<ffffffff8000b966>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:121
[<ffffffff835c3860>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:127
[<ffffffff800f624a>] sched_show_task kernel/sched/core.c:9182 [inline]
[<ffffffff800f624a>] sched_show_task+0x2ee/0x414 kernel/sched/core.c:9156
[<ffffffff80100e02>] show_state_filter+0xa0/0x1e0 kernel/sched/core.c:9227
[<ffffffff80fa0c7e>] show_state include/linux/sched/debug.h:21 [inline]
[<ffffffff80fa0c7e>] fn_show_state+0x1a/0x22 drivers/tty/vt/keyboard.c:614
[<ffffffff80fa1152>] k_spec drivers/tty/vt/keyboard.c:667 [inline]
[<ffffffff80fa1152>] k_spec+0xce/0x102 drivers/tty/vt/keyboard.c:656
[<ffffffff80fa306c>] kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
[<ffffffff80fa306c>] kbd_event+0x5fa/0xa5e drivers/tty/vt/keyboard.c:1543
[<ffffffff821384ba>] input_to_handler+0x246/0x24c drivers/input/input.c:132
[<ffffffff8213d310>] input_pass_values+0x410/0x5fe drivers/input/input.c:161
[<ffffffff8213d6ec>] input_event_dispose+0x1ee/0x2c8 drivers/input/input.c:378
[<ffffffff8213f558>] input_handle_event+0xf0/0x972 drivers/input/input.c:406
[<ffffffff8213fe64>] input_event drivers/input/input.c:435 [inline]
[<ffffffff8213fe64>] input_event+0x8a/0xb2 drivers/input/input.c:427
[<ffffffff82678820>] input_sync include/linux/input.h:450 [inline]
[<ffffffff82678820>] hidinput_report_event+0x86/0xae drivers/hid/hid-input.c:1746
[<ffffffff8267261c>] hid_report_raw_event+0x1be/0xa5c drivers/hid/hid-core.c:2016
[<ffffffff82673108>] hid_input_report+0x24e/0x2f4 drivers/hid/hid-core.c:2083
[<ffffffff82738584>] hid_irq_in+0x244/0x412 drivers/hid/usbhid/hid-core.c:284
[<ffffffff81d6a49a>] __usb_hcd_giveback_urb+0x222/0x364 drivers/usb/core/hcd.c:1650
[<ffffffff81d6a856>] usb_hcd_giveback_urb+0x27a/0x290 drivers/usb/core/hcd.c:1733
[<ffffffff82027b14>] dummy_timer+0xfc2/0x204a drivers/usb/gadget/udc/dummy_hcd.c:1987
[<ffffffff801d42d2>] call_timer_fn+0x15a/0x4f2 kernel/time/timer.c:1700
[<ffffffff801d4be8>] expire_timers kernel/time/timer.c:1751 [inline]
[<ffffffff801d4be8>] __run_timers+0x57e/0x73c kernel/time/timer.c:2022
[<ffffffff801d4dec>] run_timer_softirq+0x46/0x80 kernel/time/timer.c:2035
[<ffffffff83619632>] __do_softirq+0x2ee/0x8a2 kernel/softirq.c:553
[<ffffffff8008af50>] invoke_softirq kernel/softirq.c:427 [inline]
[<ffffffff8008af50>] __irq_exit_rcu+0xfa/0x1b0 kernel/softirq.c:632
[<ffffffff8008b1e6>] irq_exit_rcu+0x10/0x72 kernel/softirq.c:644
[<ffffffff836044fa>] handle_riscv_irq+0x40/0x4c arch/riscv/kernel/traps.c:349
[<ffffffff83604bae>] do_irq+0x5c/0x86 arch/riscv/kernel/traps.c:359

The buggy address belongs to the virtual mapping at
 [ff20000006d30000, ff20000006d39000) created by:
 kernel_clone+0x118/0x896 kernel/fork.c:2909

The buggy address belongs to the physical page:
page:ff1c00000250dbc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9436f
flags: 0xffe000000000000(node=0|zone=0|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 0ffe000000000000 0000000000000000 0000000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 32, tgid 32 (kworker/u6:1), ts 67487133600, free_ts 66877452400
 __set_page_owner+0x32/0x18a mm/page_owner.c:192
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x8c/0xe2 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x84a/0x121e mm/page_alloc.c:3170
 __alloc_pages+0x19c/0x142e mm/page_alloc.c:4426
 alloc_pages+0x126/0x252 mm/mempolicy.c:2298
 vm_area_alloc_pages mm/vmalloc.c:3063 [inline]
 __vmalloc_area_node mm/vmalloc.c:3139 [inline]
 __vmalloc_node_range+0x838/0xec2 mm/vmalloc.c:3320
 alloc_thread_stack_node kernel/fork.c:309 [inline]
 dup_task_struct kernel/fork.c:1118 [inline]
 copy_process+0x225a/0x3f1e kernel/fork.c:2327
 kernel_clone+0x118/0x896 kernel/fork.c:2909
 user_mode_thread+0xea/0x11a kernel/fork.c:2987
 call_usermodehelper_exec_work kernel/umh.c:172 [inline]
 call_usermodehelper_exec_work+0xc8/0x122 kernel/umh.c:158
 process_one_work+0x54c/0xd66 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x506/0x980 kernel/workqueue.c:2784
 kthread+0x1bc/0x22c kernel/kthread.c:388
 ret_from_fork+0xa/0x1c arch/riscv/kernel/entry.S:264
page last free stack trace:
 __reset_page_owner+0x4c/0xf8 mm/page_owner.c:149
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x224/0x592 mm/page_alloc.c:2312
 free_unref_page+0x5a/0x234 mm/page_alloc.c:2405
 free_the_page mm/page_alloc.c:562 [inline]
 __free_pages+0x104/0x126 mm/page_alloc.c:4516
 vfree+0x14c/0x68e mm/vmalloc.c:2842
 delayed_vfree_work+0x42/0x58 mm/vmalloc.c:2763
 process_one_work+0x54c/0xd66 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x506/0x980 kernel/workqueue.c:2784
 kthread+0x1bc/0x22c kernel/kthread.c:388
 ret_from_fork+0xa/0x1c arch/riscv/kernel/entry.S:264

Memory state around the buggy address:
 ff20000006d37b00: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
 ff20000006d37b80: 00 00 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
>ff20000006d37c00: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
                                           ^
 ff20000006d37c80: f1 f1 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3 f3
 ff20000006d37d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
