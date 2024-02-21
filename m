Return-Path: <linux-kernel+bounces-74130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70CB85D047
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490431F2433D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8103A1A5;
	Wed, 21 Feb 2024 06:13:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25E39FC3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496006; cv=none; b=p/y6W+JRF32zI5A/RwuA1by9ceoT/s+KjRwZY0sIaTLKIdRjMdHrgE0ugVFFF0wBc4aeRG9hOtKpLqs8YlL3afhaCJXFOq7RspIk5WvsjbT16R4Qu3DbaYH1IctwVA1uVjnNYg1fxuHQFMmaZtjmCW+ECnYZdntOnd4Ag1+jhVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496006; c=relaxed/simple;
	bh=D50I3E4E9uZ8Skb1OpRz0bIql4snS5AXgtxCnZXlypk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CfMTZknm7UCcn8UCWWnkwF+FiXzagbMA5OZf0tyfNvyssS37fIPCOu1T4foHYfiQJ1RThsIholztUzEQhypAMWfFTwTdaW797rjk68Jooaci5J1Mpr8jAEUkGShruHlaZNX33xAYweL8eICVbkrxrk+gtIPntp0agmccNDleMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3653311922eso28248915ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708496004; x=1709100804;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5T7eHue0xMZQbRjJLBhKECiRWQlC4MuMpelXVyZniJw=;
        b=bdP2yY2E39BWWfm2pmwPOBpU1N68UTx3N8ERin77+u4Opml4Cbn3//5tW4MOt63xYO
         1YDvykc1OpMtlixeFck80QMcBR1Zq9Q0tzYIzNXBuIGca68tT5PXZ+omB+V2GOhrmPiV
         CaqAPCTIZhwXZ0dOt/F/5rWKRCqcFtbEuFE5SsKR1pUWXFlxkCSgSfxYi0SCDuQAQ0Sw
         oMmN8KPp1TunD1w0imzn8oK8QKeAVwYsLzph2uFBjjhgwlRkqt++n71cgfM41Hxgp1lf
         AapCUwhw2S+C1wxG+6wfJUPlj0JakzyHftEGoiZ95SVhN7C4MxhISIlzr/QONaLC2A1i
         2lsw==
X-Forwarded-Encrypted: i=1; AJvYcCVVRehSgRhwD+iMR74Vv1M9TcwuZxzwDCYEedo0gewh/RUB0j7UbQ7oY0lvIeCMcZ5UEqHHa8cd/hDzCDKVBqiHqgeYSqwqFWG3cBSQ
X-Gm-Message-State: AOJu0Yx4btewMlbaS41rwNV9BqFyB3s7UA7GQRfYlXo6jw9ws3yVJH6O
	Hrrjfs4TNNQvmskh2kwGItLjNW6UidOqhPR9GQk3ZNrofFRNthw5jpbWXYsnUawfCFDrYWYr8Mw
	wEuyC9f8e+E+MoJahwNYtHX4aSxualf6Gxuh8juSGl0bEIxKNS9mog4E=
X-Google-Smtp-Source: AGHT+IHNJtqSR8RIV1Vx2dx+6OTBBzUc7S4AfWgcQak0Ln9VFw9lIZTLPM+XV5jvTCVDDwlVjAiv2thLNm9r+3jVLpY3yfnfi/wj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b44:b0:365:3db4:16ee with SMTP id
 f4-20020a056e020b4400b003653db416eemr470650ilu.2.1708496004156; Tue, 20 Feb
 2024 22:13:24 -0800 (PST)
Date: Tue, 20 Feb 2024 22:13:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d96200611de3986@google.com>
Subject: [syzbot] [media?] INFO: task hung in cec_claim_log_addrs
From: syzbot <syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com>
To: hverkuil-cisco@xs4all.nl, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    83d49ede4b18 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1719dcf8180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af5c6c699e57bbb3
dashboard link: https://syzkaller.appspot.com/bug?extid=116b65a23bc791ae49a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b9ffc8180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ddc734180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/773990dc198f/disk-83d49ede.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf9c558cd3e8/vmlinux-83d49ede.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25f87616316c/Image-83d49ede.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com

INFO: task syz-executor398:6279 blocked for more than 143 seconds.
      Tainted: G    B              6.8.0-rc5-syzkaller-g83d49ede4b18 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor398 state:D stack:0     pid:6279  tgid:6279  ppid:6193   flags:0x0000000d
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x1498/0x24b4 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6817
 schedule_timeout+0xb8/0x348 kernel/time/timer.c:2159
 do_wait_for_common+0x30c/0x468 kernel/sched/completion.c:95
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x48/0x60 kernel/sched/completion.c:148
 cec_claim_log_addrs+0x164/0x210 drivers/media/cec/core/cec-adap.c:1606
 __cec_s_log_addrs+0x1238/0x18d8 drivers/media/cec/core/cec-adap.c:1920
 cec_adap_s_log_addrs drivers/media/cec/core/cec-api.c:184 [inline]
 cec_ioctl+0x2684/0x37b0 drivers/media/cec/core/cec-api.c:528
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
INFO: task syz-executor398:6329 blocked for more than 143 seconds.
      Tainted: G    B              6.8.0-rc5-syzkaller-g83d49ede4b18 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor398 state:D stack:0     pid:6329  tgid:6329  ppid:6197   flags:0x0000000d
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x1498/0x24b4 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6817
 schedule_timeout+0xb8/0x348 kernel/time/timer.c:2159
 do_wait_for_common+0x30c/0x468 kernel/sched/completion.c:95
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x48/0x60 kernel/sched/completion.c:148
 cec_claim_log_addrs+0x164/0x210 drivers/media/cec/core/cec-adap.c:1606
 __cec_s_log_addrs+0x1238/0x18d8 drivers/media/cec/core/cec-adap.c:1920
 cec_adap_s_log_addrs drivers/media/cec/core/cec-api.c:184 [inline]
 cec_ioctl+0x2684/0x37b0 drivers/media/cec/core/cec-api.c:528
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
INFO: task syz-executor398:6367 blocked for more than 143 seconds.
      Tainted: G    B              6.8.0-rc5-syzkaller-g83d49ede4b18 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor398 state:D stack:0     pid:6367  tgid:6367  ppid:6196   flags:0x0000000d
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x1498/0x24b4 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6817
 schedule_timeout+0xb8/0x348 kernel/time/timer.c:2159
 do_wait_for_common+0x30c/0x468 kernel/sched/completion.c:95
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x48/0x60 kernel/sched/completion.c:148
 cec_claim_log_addrs+0x164/0x210 drivers/media/cec/core/cec-adap.c:1606
 __cec_s_log_addrs+0x1238/0x18d8 drivers/media/cec/core/cec-adap.c:1920
 cec_adap_s_log_addrs drivers/media/cec/core/cec-api.c:184 [inline]
 cec_ioctl+0x2684/0x37b0 drivers/media/cec/core/cec-api.c:528
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
INFO: lockdep is turned off.


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

