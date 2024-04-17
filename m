Return-Path: <linux-kernel+bounces-148938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D524D8A8963
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC621F249B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696F717107A;
	Wed, 17 Apr 2024 16:54:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841316FF38
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372866; cv=none; b=Qpd/xYG7VZRNnyoiVShObjMDfyMVF9/ljo75b/Ev42XxFlJQPYkpNSRSPabu2Yahn9bNzVvXKZhKL0tBl2SJOBpH0SI7PF2DL3kmwaC8rTH1cy2MJ28TGzprN/oxXTd/7T17RRKHLz3q6k1fCWyJ30r/VGXiIFXN9WXeUALHmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372866; c=relaxed/simple;
	bh=zlO3QyLU6T6kAPgF315577WoowuqF+crHU62sbLQ95M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BQV68EfUmaZk/0jea1DCEoH1py8FBpxVXz+Mpg/au4Gtb9VyhvfLdE5H4oFdJvUhkZPuBhgXoIiiCmNcb8JWCIHBo6NaybN7TpSza0AOndvVDkCDz5c6m3+fAqWHgpE4GHnD2S9xpHuUW6roOrl2ajKhP1u4zbV5qE52VAn7zqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso787161939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372864; x=1713977664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94AERZMjJPIAPdPJbcKSLmYY89yKeD6SgqSo1jdF7OA=;
        b=t5xP0aRShPdlQD9ZvPetkEkUGURQ/46Q6aT+uQoVdZ0T/9/zzu6WxsRQLb/SDAnbjT
         FvFl86hhhWzujCMVI7xIQ3GMMubW5mTCbcNaCBEY95MNW6f/ZAZeJxg7xtryGKxyvS7z
         Jih2lxzk2JLD+OSDoLFFmE/v4see+2Q9KlfW07ZAfqjohoTtM8mKH5tBhifdNZy1Ac2h
         3aJlUNjYvgMxB2Lr9+wjJOcaV+4RJTAo4/2HKji78JcwIvbjTArwIqg4sKqLO7gbifpf
         J74dD7PlheRjakbDU8qBvYFwwPs3cuTPE9GFDKd1sZRG019omiDsaCom5egpQkgUh1Px
         l/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUZFpq2SqjJDZb/4Nc3baqWbQivkZuEVG1NUnOmzrkvrRnvaYBKGoxqMerYCTZsFvq7md/WLn0IQjPeKJNvfkwmQeU+TaM0TtTsd/rC
X-Gm-Message-State: AOJu0YzkCEc98X5/fOe6OzYkIikUp43LZTndeXTUHi5oqUZwfj+M/oli
	gIo4hQyjHRCHgdr8yeqfEhRBd2L5CUDXMjJVDQDSy/uv2vApeb83JjeMW/kKVXZNvtTuH99OqYW
	dbp7ATrjhF91Vu8CY4zANielzYBWeMvKWDVU/ihOsmNUKg7cLBT0127I=
X-Google-Smtp-Source: AGHT+IFNX1QrBClN+f+KBHQMg3tx/9A1nlzXeU4PiLf7pH9u6E//ldPrxBgPGlqAVdW7tvAnyXmEqGbtDVq6eeqyVtLfl9hRuoeu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8917:b0:482:fa6f:78fd with SMTP id
 jc23-20020a056638891700b00482fa6f78fdmr839217jab.0.1713372864804; Wed, 17 Apr
 2024 09:54:24 -0700 (PDT)
Date: Wed, 17 Apr 2024 09:54:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f987ff06164db4f6@google.com>
Subject: [syzbot] [gfs2?] INFO: task hung in gfs2_glock_nq
From: syzbot <syzbot+dbb72d38131e90dc1f66@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5d2afe8745b Merge branches 'for-next/kbuild', 'for-next/m..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=139e600b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=560f5db1d0b3f6d0
dashboard link: https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1745f177180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17509b6d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/50bff35e1638/disk-b5d2afe8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4eeaa73e7ed1/vmlinux-b5d2afe8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e796b089aa9/Image-b5d2afe8.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3f56655953c4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbb72d38131e90dc1f66@syzkaller.appspotmail.com

INFO: task syz-executor105:6284 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc3-syzkaller-gb5d2afe8745b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor105 state:D stack:0     pid:6284  tgid:6284  ppid:6282   flags:0x00000004
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x14bc/0x24ec kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xbc/0x238 kernel/sched/core.c:6838
 bit_wait+0x1c/0xac kernel/sched/wait_bit.c:199
 __wait_on_bit kernel/sched/wait_bit.c:49 [inline]
 out_of_line_wait_on_bit+0x208/0x334 kernel/sched/wait_bit.c:64
 wait_on_bit include/linux/wait_bit.h:76 [inline]
 gfs2_glock_wait+0xb8/0x298 fs/gfs2/glock.c:1354
 gfs2_glock_nq+0xcc8/0x169c fs/gfs2/glock.c:1616
 gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
 __gfs2_lookup+0x124/0x270 fs/gfs2/inode.c:905
 gfs2_lookup+0x2c/0x3c fs/gfs2/inode.c:930
 __lookup_slow+0x250/0x374 fs/namei.c:1692
 lookup_slow+0x60/0x84 fs/namei.c:1709
 walk_component+0x280/0x36c fs/namei.c:2004
 lookup_last fs/namei.c:2461 [inline]
 path_lookupat+0x13c/0x3d0 fs/namei.c:2485
 filename_lookup+0x1d4/0x4e0 fs/namei.c:2514
 user_path_at_empty+0x5c/0x84 fs/namei.c:2921
 user_path_at include/linux/namei.h:57 [inline]
 ksys_umount fs/namespace.c:1916 [inline]
 __do_sys_umount fs/namespace.c:1924 [inline]
 __se_sys_umount fs/namespace.c:1922 [inline]
 __arm64_sys_umount+0xf8/0x17c fs/namespace.c:1922
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffff80008f057880 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:328
2 locks held by getty/6006:
 #0: ffff0000ccbde0a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff800097b9b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x41c/0x1228 drivers/tty/n_tty.c:2201
1 lock held by syz-executor105/6284:
 #0: ffff0000df4da9a0 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:805 [inline]
 #0: ffff0000df4da9a0 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: lookup_slow+0x50/0x84 fs/namei.c:1708

=============================================



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

