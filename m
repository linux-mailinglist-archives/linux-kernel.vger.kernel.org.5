Return-Path: <linux-kernel+bounces-138172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0605289EDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D3B282952
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC33413D8AF;
	Wed, 10 Apr 2024 08:30:29 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798F13D638
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737829; cv=none; b=LQiFgX/mq8ESfXUxtQy+RpmCr9hHQ/kFiFSqWmytMqq/cv5+7Jr+C5vyh7HQ6GrBKKd1dqLT9fFM486mITE7iYCrbWmuCbUo6fxPeRoLxZ2owPTXGA7+9oBIfea0kKADM3CjGFpteKEWj+hiPhnpBnGta++SMdGRtU++xypYJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737829; c=relaxed/simple;
	bh=mW0aBaeqUfMX1rzNtXjpa5pNHLY1I/opo01JKHESxXg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BCPzP1TL1paoApG65+ur4PP61LiyHa6fZpQ/6d9StWdZ6PkvPVe9mk9ahdwIhvmWrib+Dpeixg7EgEkf+3WnmDkfs1OO6CrpmYPZ6iQMuwIQtcUPMNXBSyvpHZ5IMxF/XxAhNXShrlDoH8HuK47nU5oTXk+LU+8kO3IdKpn/MlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5e2b1cfabso305244239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712737827; x=1713342627;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7DCNdIZYurC5sAPUAfNj0Q9O+CaR27Xm5XOqYN/hoU=;
        b=prKcxuaSLGGCplbVSCuQ26pG7RjfzfAm55M9UUkEMmNr132ni+BQXHJ0vfZ6zYRTX2
         na8S11fESjZP3EBxwoA+3bGH5sFKbfoBSRX7alk+bmfjs5LMgByuDk9UiY7pG7esMHxz
         tsGnp66/8KlSrpRdOg0yfEOEB8n+LLfFHJOaNOE1JzAzfbZ6gBjA2tgp77ya9KpbBykr
         1g0KNKAk5dEsUIb+OVQ9ogMPNvUf/yYcjGjcdcY7a9D6GvGtyvesAO4AIR+aIUipE5mu
         YzRRDgeG8Qq7kroWH4XdMDRvk6zlw4fARdG7IiBq+qTWrL0wGBru3YHzDl46yxMk4Isp
         noMQ==
X-Gm-Message-State: AOJu0YxZSF1Jkvth0B2zmmzI/zHd62AHEwGLi/l7bdsYwxZRigW0/BJJ
	aelfKSyU+b3V3U6hJe8JFG4q3tVpqAuw0aLd9sgpqggi9RtK2VOoinBplmvSEE7A3+ZGJVzn0nG
	ICjHUI1sGFTNc3GqNd0tZz4iCT4Vjywalba7g/o1AbE9WK5Sg9mPfS9JILw==
X-Google-Smtp-Source: AGHT+IFapSAxUhGDtunsT3Av39/SAZlu2MkIDiGdU2eZFSr+f+OtpYyoz2rHNmvXS82XqWliS6M4of0KASramQWEoMFaObZbFFaW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1342:b0:482:bb7b:a4b3 with SMTP id
 u2-20020a056638134200b00482bb7ba4b3mr52366jad.1.1712737826862; Wed, 10 Apr
 2024 01:30:26 -0700 (PDT)
Date: Wed, 10 Apr 2024 01:30:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c387ee0615b9d96b@google.com>
Subject: [syzbot] [kernel?] KCSAN: data-race in free_pid / zap_pid_ns_processes
 (5)
From: syzbot <syzbot+335b9cda8abe9f28e1a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    20cb38a7af88 Merge tag 'for-6.9-rc2-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b8252d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=624180927e9036c3
dashboard link: https://syzkaller.appspot.com/bug?extid=335b9cda8abe9f28e1a4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f043ce1e5189/disk-20cb38a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3313ef4e0ece/vmlinux-20cb38a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e166298ab90/bzImage-20cb38a7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+335b9cda8abe9f28e1a4@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in free_pid / zap_pid_ns_processes

read-write to 0xffff88811257b5c8 of 4 bytes by task 10493 on cpu 1:
 free_pid+0x80/0x170 kernel/pid.c:143
 __change_pid+0x19a/0x1c0 kernel/pid.c:367
 detach_pid+0x1c/0x30 kernel/pid.c:372
 __unhash_process kernel/exit.c:133 [inline]
 __exit_signal kernel/exit.c:202 [inline]
 release_task+0x6e7/0xc30 kernel/exit.c:259
 exit_notify kernel/exit.c:774 [inline]
 do_exit+0xf7d/0x1740 kernel/exit.c:898
 do_group_exit+0x102/0x150 kernel/exit.c:1027
 get_signal+0xf2f/0x1080 kernel/signal.c:2911
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
 do_syscall_64+0xe2/0x1d0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

read to 0xffff88811257b5c8 of 4 bytes by task 10223 on cpu 0:
 zap_pid_ns_processes+0x1ec/0x2c0 kernel/pid_namespace.c:249
 find_child_reaper kernel/exit.c:610 [inline]
 forget_original_parent kernel/exit.c:699 [inline]
 exit_notify kernel/exit.c:736 [inline]
 do_exit+0x14b4/0x1740 kernel/exit.c:898
 do_group_exit+0x102/0x150 kernel/exit.c:1027
 get_signal+0xf2f/0x1080 kernel/signal.c:2911
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
 do_syscall_64+0xe2/0x1d0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

value changed: 0x00000002 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 10223 Comm: syz-executor.4 Tainted: G        W          6.9.0-rc3-syzkaller-00011-g20cb38a7af88 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
==================================================================


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

