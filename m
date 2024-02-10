Return-Path: <linux-kernel+bounces-60285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AE08502A6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997031F24321
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6424B134DD;
	Sat, 10 Feb 2024 05:30:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860986AC2
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707543027; cv=none; b=FhB6ct3ZX6/KskP2c88V+1MIbwTzDi/M23JMjgcdogD9lKbhLndsiK4TonOh2nMcfSF/mkn8a6/l+nY/AuvbuY4ZjVkGrKlGpgoGrKKXQsFS/rebYa0/sPa9u0kdm2nRp0e7oi4lsgQ6lSiFQMlHhybLlUXrhOF8XcVeJXKV2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707543027; c=relaxed/simple;
	bh=owtPcy00HdQtko1d6g+Zf5awi/yGVGZj3dIGwqg4URk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tcc+hjFDQ1dpyyP+pk/FpLU57ga/C6ap+ZemlGHI8hW9lMeoHYt7roAKomJWIkJhZQWcpYXmL4WjVG+K86G0Z5emD/aZxsgYdTubwQeo4cbD8VXOjvajqgy7D6uyzzp7zaV7vhczE/F3SCaWe5oTG3plRs3TFyrBtOq4plhIeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363ca646a1dso14574855ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 21:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707543024; x=1708147824;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHWKdh7Wa8GhzhRTMvRN0DivpJuYWmSFR6gcwIVJhOo=;
        b=MGHf7xW+6DO8AU8VaHGkidagd7Pfg22aFiQabsQQxO0K6CaFwzSxJ4aX4do0Fp4i9F
         aJZ3F/9CoLPW7W/IPrbUS4KAuZZ3rcq/QvtyMZBkXzTgMJewn4WLkEQwYjrGqBAnSPFf
         d7RpFSQgL+r75pvvGH1n8BavcKKBJDZuAoaSmC2H2u9THWUuBUyp9HnUFdf57nX9/DeS
         sYuK87JSI9lCzCf/Ld72uA9MuRTrqIvtoJVGzpjBQdrV+F/UG9j9rlmpuZ6EL1iCdUze
         KsK1WzVHcPt3RjE0IApa2cANvrEp52JuHrlsUjic7pSBXoRGBOyEUzcOrphKaCdMAef4
         iXuw==
X-Gm-Message-State: AOJu0YxwfzwSjMLnbto3W+MGRyf0Dwl4jWkdeop1E6JEILAt8BiX0vIb
	XAm7BhX7Z8NSSJeC6eOJ2F3C0F/AaMt857ELZiwIccgbIRuY2FYWTb7BinurEWPYUTBriYt9VyQ
	68V1uzt+SXHCa3j/s9k1Lqo9cCyaKRNmDD5UlQd66z6aiD+zNLoeM3qVLgQ==
X-Google-Smtp-Source: AGHT+IHbJKFFz6TBAGoOlimMT3VuP8oed8ZaOS+MmtOuz+VfWN1kZvoHKBOIJV8YMIP9sR/k8Lq/KlhqdDddLfGmRnNelbSIrUw5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:363:85de:452c with SMTP id
 h5-20020a92c265000000b0036385de452cmr119015ild.0.1707543024778; Fri, 09 Feb
 2024 21:30:24 -0800 (PST)
Date: Fri, 09 Feb 2024 21:30:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e468c06110057ab@google.com>
Subject: [syzbot] [kernel?] linux-next boot error: kernel panic: VFS: Unable
 to mount root fs on unknown-block(NUM,NUM) (2)
From: syzbot <syzbot+fbd73dc34f8681ecb8c0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac139fc7db67 Add linux-next specific files for 20240206
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12acdbffe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b5fe6166ab1fa63
dashboard link: https://syzkaller.appspot.com/bug?extid=fbd73dc34f8681ecb8c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7944e61925e3/disk-ac139fc7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5fcc1af6c7d/vmlinux-ac139fc7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be76eb66afdf/bzImage-ac139fc7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbd73dc34f8681ecb8c0@syzkaller.appspotmail.com

 (driver?)
1f00             128 mtdblock0 
 (driver?)
0800         2097152 sda 
 driver: sd
  0801         1048576 sda1 00000000-01

List of all bdev filesystems:
 reiserfs
 ext3
 ext2
 ext4
 cramfs
 squashfs
 minix
 vfat
 msdos
 exfat
 bfs
 iso9660
 hfsplus
 hfs
 vxfs
 sysv
 v7
 hpfs
 ntfs3
 ufs
 efs
 affs
 romfs
 qnx4
 qnx6
 adfs
 fuseblk
 udf
 omfs
 jfs
 xfs
 nilfs2
 befs
 ocfs2
 gfs2
 gfs2meta
 f2fs
 bcachefs
 erofs
 zonefs
 btrfs

Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,1)
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc3-next-20240206-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 panic+0x349/0x860 kernel/panic.c:348
 mount_root_generic+0x3b5/0x3e0 init/do_mounts.c:234
 prepare_namespace+0xc2/0x100 init/do_mounts.c:489
 kernel_init_freeable+0x471/0x5d0 init/main.c:1555
 kernel_init+0x1d/0x2b0 init/main.c:1432
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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

