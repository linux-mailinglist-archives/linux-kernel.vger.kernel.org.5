Return-Path: <linux-kernel+bounces-162649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7675C8B5E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3255B283682
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35B983A09;
	Mon, 29 Apr 2024 16:05:34 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3BF83CAE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406734; cv=none; b=PxjpF3WTcSSFtzIVYQ+EdlLDGzcahf8s55codlJHl2WW46ChZoBJ86igszhwBkCA/lhmcAgzbeAtZC8P2y2js72W7s9D/BNT2eOurWRUNYZhKavlu/+b4FXAwtmUyZ7MEBb65RzrBXxq6VSeCXX17Nh7cyPNDwRHDzz97O/Z/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406734; c=relaxed/simple;
	bh=hiRsBpZoZcTi5qoEJ1/IvH/Ifa7hifEK7POZMgl74j0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rKaBLWxdAx+93Ypz1cl+IrYmp1CziEc4mXoquMLyzSKlOFd8TysV2gDO1UmhdaeWppR9ahj9zHfbvnG3PteoZ76AEGJfX9M5FKcYPrsyRKGqCotoQkBI+WaDKhpjl5rTrgUk+oeWYTzZCd4eGNTbnIj5UaR/iBcweFBuDhxm5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dece812270so113276639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406732; x=1715011532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93rlfPbij6l5AfI5569BrabwgqGsAA8Z5rOA/e+b6Xo=;
        b=XDTzCocJ3YV5Ey8PYkh6w7DQLw2vJOK5NcXW6eiHl5Nxvl9/mL6LLdFWMBAsMg6+VU
         7QgMELEF0RYJ9Q2nY1xfshTbOtip1IAlcCCgGLBVUWXAqr/gmEmta7hUXWL9+WT4uTu7
         kFVZK0b//zM/5EkX3emMDLbE5e1PBGPidD+hnWgA6FvlwXD76W6qPvV5HhmTMMeFHqaX
         7CeFfewMF5TA0orLcllAHUOQStG7LxV/VkQjT9IAIHVP66vHfkzbVyN0bOsuB+dF6MeB
         ksz/vjnMwsCakRG0xYVR3tt9D0G8VM2PzqgVY//vPtZCu3nH/klyFzKSHmxtRn/eZuEX
         e5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUGKBaRFrdT+NMrI0ehKa3VlW+Kd53AKMtJp8w2H0Sx30ykm1Ad2PYOpDRv6r+T++2Ybcg5OqLIZ0Ls3iv//oR0vYKRZAw40/aRIdYP
X-Gm-Message-State: AOJu0Yzvssu9j67T9vuznE0oYYhEAxIVBR+4oD7iEKB2JWuEIjufafjD
	4QwVhUH7fjurPqr2pFSYvbKnfKuL3NwqLAbYnVgBBMgvPddQwc/ZX9cn+9jIp92bxqpmSmLJEjR
	D1NV7XyZsI4Izox0Tu7S5JP5WzN7B8D7h1KITriI56Ar+e1/amt8dnG4=
X-Google-Smtp-Source: AGHT+IGv85KPokVkT162yvZpYCbRMU9EmRQ9fqyjXZXn1tM/O9TOHf/WV0VlbQPMLkv8KF8jnGZmSeiDnkJq+lhTd/gzX8sv5s4J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3d86:b0:487:30aa:adb6 with SMTP id
 ci6-20020a0566383d8600b0048730aaadb6mr15264jab.2.1714406732068; Mon, 29 Apr
 2024 09:05:32 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:05:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000440b0a06173e6ca8@google.com>
Subject: [syzbot] [ext4?] KMSAN: uninit-value in ext4_inlinedir_to_tree
From: syzbot <syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12fbc980980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=776c05250f36d55c
dashboard link: https://syzkaller.appspot.com/bug?extid=eaba5abe296837a640c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e2cd27180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1741a028980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76771e00ba79/disk-e88c4cfc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c957ed943a4f/vmlinux-e88c4cfc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e719306ed8e3/bzImage-e88c4cfc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9d3c2a1fa449/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
EXT4-fs warning (device loop0): __ext4fs_dirhash:270: inode #12: comm syz-executor253: Siphash requires key
=====================================================
BUG: KMSAN: uninit-value in ext4_inlinedir_to_tree+0xde2/0x15a0 fs/ext4/inline.c:1415
 ext4_inlinedir_to_tree+0xde2/0x15a0 fs/ext4/inline.c:1415
 ext4_htree_fill_tree+0x1941/0x1cd0 fs/ext4/namei.c:1210
 ext4_dx_readdir fs/ext4/dir.c:597 [inline]
 ext4_readdir+0x4bbf/0x5b00 fs/ext4/dir.c:142
 iterate_dir+0x688/0x870 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64+0x169/0x530 fs/readdir.c:394
 __x64_sys_getdents64+0x96/0xe0 fs/readdir.c:394
 x64_sys_call+0x343d/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:218
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable hinfo created at:
 ext4_htree_fill_tree+0x52/0x1cd0 fs/ext4/namei.c:1185
 ext4_dx_readdir fs/ext4/dir.c:597 [inline]
 ext4_readdir+0x4bbf/0x5b00 fs/ext4/dir.c:142

CPU: 1 PID: 5020 Comm: syz-executor253 Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


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

