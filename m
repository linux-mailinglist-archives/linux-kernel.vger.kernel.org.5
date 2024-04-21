Return-Path: <linux-kernel+bounces-152519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C0B8ABFAC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A454BB2103F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA318628;
	Sun, 21 Apr 2024 14:58:20 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38A18050
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713711500; cv=none; b=pHKSsuCgJlPDLp3GNlDvwLeI2WnHQi7JSJ6e0sSyM8hqQs90e4w2Ov/7hvelfV+jd3mV+skYysptQ+9r92Q/xf4xFBLyml1bY/N0jjzwoDSlOmn9ChhxbosslJdS2TWOIhNruW/gJOpT4hagFvaIMYgEM8U6tk61iLcPlGttIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713711500; c=relaxed/simple;
	bh=0oJjik4wpuUNzHjJSKUChu56oAAvkAz6NbclYtNoQvQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vCLmql6nmIPJG8n1yDV+/e91bZhexS3nJpVhRDGZAUtu6XUXPqnRCvohMJqYVjL2yN/5BOV3kYnDEhVgykw4A7/y30ThX0CjdnDRJoH56XdKd7KlCASc/uDN9f0JCe0wyU+vAGDi6eO2STrURCysP3h4kg2LkMbOKIOZKPKfHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da42114485so384977739f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 07:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713711498; x=1714316298;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBuLxUT8scRkJshgJrnxESrUxQfDXTehWiXm5MU5oC4=;
        b=YydTuQJTr9+mIB2vpVDkqov/uvZGZ8VxoDawagABnPeN4Q8vQFl8VZczRzepQXqZOd
         06T9I9AZkaognU7L1upM/MaN8jgymp6cOMQVXDzFp9C6QZ3eY7uUxk/SWyBeHMvRww7c
         DPMz45rN1ttD/o9/JzSd4C7cgofsVwnxY9l8EZgszHjkpgqXorUIhAJ30kWgUO6V033M
         OwkjpC1TOaC4z90ps0OQ7E1ZKx61pqoQK8IXLU1qLj0eltuSoFfD06QbJK5RXVwvsdjM
         MsR4VzUge/7wPoaP80WKSa+Z5HpDSRlwmL+mzRYYKblVGL4ugiVkibDuGJmfDjehvXYE
         bLyw==
X-Forwarded-Encrypted: i=1; AJvYcCWZUeReQYp4zBrhHVibT67/TX3c2nmuPyAA0IxmJVs/ttrf76NRMSbdhaObNN0RYdUh3PtUp2uR9rf8xQgr+QhyOmUb2QFFamo0G0QC
X-Gm-Message-State: AOJu0YzO4qmlmeIAna6ZwTkGmcVQMb988moRuo+qrgJ1obOQ66OHUVXV
	imIc2Mxw9eCeKI5HQ+JoXsPe/gH3/b1bJE1hD+sP8lCInAyh7fjLe9FJcJbaNLnLrXUnJAowE48
	RcUROOOC2206KaH6Gr2MDu71vOLqaJ2MxmgsuRJunBDcqqc49qp1JAiA=
X-Google-Smtp-Source: AGHT+IHlZN4DwkPSOimznCste2/NnqjATls3ifbKOSZLRmQmG3Y/nk0jCQ/QL+LEjyjIW5910PbmJYomP4Bp4JdFtS1hmXuAYIwf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:379d:b0:485:aae:bd7b with SMTP id
 w29-20020a056638379d00b004850aaebd7bmr302450jal.5.1713711497181; Sun, 21 Apr
 2024 07:58:17 -0700 (PDT)
Date: Sun, 21 Apr 2024 07:58:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000991aa06169c8dd5@google.com>
Subject: [syzbot] [efi?] BUG: soft lockup in sync_hw_clock
From: syzbot <syzbot+b3dc5d82ebb394dabe43@syzkaller.appspotmail.com>
To: ardb@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5d2afe8745b Merge branches 'for-next/kbuild', 'for-next/m..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=114b08e7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=560f5db1d0b3f6d0
dashboard link: https://syzkaller.appspot.com/bug?extid=b3dc5d82ebb394dabe43
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17220cc3180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125a17b3180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/50bff35e1638/disk-b5d2afe8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4eeaa73e7ed1/vmlinux-b5d2afe8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e796b089aa9/Image-b5d2afe8.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3dc5d82ebb394dabe43@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u8:9:2072]
Modules linked in:
irq event stamp: 3823076
hardirqs last  enabled at (3823075): [<ffff80008ae6ec90>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (3823075): [<ffff80008ae6ec90>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (3823076): [<ffff80008ae6c87c>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
hardirqs last disabled at (3823076): [<ffff80008ae6c87c>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
softirqs last  enabled at (3823050): [<ffff8000800218e4>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (3823050): [<ffff8000800218e4>] __do_softirq+0xb10/0xd2c kernel/softirq.c:583
softirqs last disabled at (3823039): [<ffff80008002ad34>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
CPU: 0 PID: 2072 Comm: kworker/u8:9 Not tainted 6.9.0-rc3-syzkaller-gb5d2afe8745b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_freezable_pwr_efficient sync_hw_clock (events_freezable_pwr_ef)
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : finish_lock_switch+0xc0/0x1e4 kernel/sched/core.c:5164
lr : raw_spin_rq_unlock_irq kernel/sched/sched.h:1397 [inline]
lr : finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5163
sp : ffff80009c8c7290
x29: ffff80009c8c7290 x28: 1fffe000367bc6df x27: ffff80008ee81218
x26: ffff80008ee80664 x25: 1fffe000367bc6f1 x24: ffff80008ee80000
x23: dfff800000000000 x22: ffff0001b3de3788 x21: ffff0001b3de2c98
x20: 0000000000000000 x19: ffff0001b3de2c80 x18: 1fffe000367b9996
x17: ffff80008ee7d000 x16: ffff800080333fec x15: 0000000000000001
x14: 1fffe000367bc590 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 0000000000000000
x8 : 00000000003a55e1 x7 : ffff8000802aabc8 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : ffff80008afdfb40 x0 : ffff800124ffb000
Call trace:
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline]
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline]
 raw_spin_rq_unlock_irq kernel/sched/sched.h:1397 [inline]
 finish_lock_switch+0xc0/0x1e4 kernel/sched/core.c:5163
 finish_task_switch+0x120/0x614 kernel/sched/core.c:5281
 context_switch kernel/sched/core.c:5412 [inline]
 __schedule+0x14c0/0x24ec kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xbc/0x238 kernel/sched/core.c:6838
 schedule_timeout+0xb8/0x348 kernel/time/timer.c:2558
 do_wait_for_common+0x30c/0x468 kernel/sched/completion.c:95
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x48/0x60 kernel/sched/completion.c:148
 __efi_queue_work+0x124/0x1a8 drivers/firmware/efi/runtime-wrappers.c:337
 virt_efi_set_time+0x74/0xb4 drivers/firmware/efi/runtime-wrappers.c:364
 efi_set_time+0x208/0x430 drivers/rtc/rtc-efi.c:184
 rtc_set_time+0x43c/0x888 drivers/rtc/interface.c:158
 update_rtc kernel/time/ntp.c:597 [inline]
 sync_hw_clock+0x2e8/0x480 kernel/time/ntp.c:656
 process_one_work+0x7b8/0x15d4 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:3416
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860


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

