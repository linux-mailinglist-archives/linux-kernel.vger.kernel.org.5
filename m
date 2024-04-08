Return-Path: <linux-kernel+bounces-135029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0EA89BA2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61B4B2241C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C50D39FF7;
	Mon,  8 Apr 2024 08:26:19 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52E383A1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564779; cv=none; b=PxrNH/FQEDMT+5TQAVNadbHGhE+o6jQtmZIB48mXJwGipz4iW3eDlpq6zzkw3PJYA//I14EFDEuA4pzjizHJ/ROZw5lhZMDkTab/6Iu84PVDbLnksIRP9iQnv88sX9GohKdCrA7yJHpk0KJIe57K3vwPjPV5YyLyH+XHgqhifo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564779; c=relaxed/simple;
	bh=V09Xh3jB2dR5Tb+r7rN2O9KMyinvIz5J+UJ5OTwpL6s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r7AJiQfBo6CQTrPwno/ypoDJxSENV9MfJBsE4HYV+LhiUturszRVIRyx5+w9nCeEy/8+QgOlwNe2NLV2ecgf+mtCfNGm1yAwMGuIrQlcHbiVR41Pyu+tfKWxIFyxhrdcRU/GRPKxLhyPpqyg5buXRfZCNg23otzvsUmmApFvWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d34f49058fso358558739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564776; x=1713169576;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2u4GE7YxjgBsaa0jzxgI0G0CwDzCSBPqAVU5M+kn3Y=;
        b=JZa83mc3E+9o3WBoYA77EkHa+fRTWsERiM99Glu2Q1ZO5mZpb5a6irDBi1NGI4k6Ri
         XgIbbEMEZg0U8J/dN4Vp5Xt0gLJ1JJQUD1rdPZHNMOT4Gk5Px73vvZUuwrKiXE5HwWLK
         epNSpSHH9h5eeJUaIN5fF2bef+G+rxmPqyKIU55qLuEQ6Fsn0BuQtrLJYVFwve7qOU/5
         r1RHbFVoJeRvNeWxtNzzezmxlJNRF9cG19OaP54rC4SuHY+6KEzz70DGAsUhpyIrciV4
         u/MDoya0sjeCuAtXf4KrHWNqEkrp7DxtQ6Q+69QVgiinjGs9r3xgApbD1VtvLWQYoBVX
         xbrA==
X-Forwarded-Encrypted: i=1; AJvYcCUaimU6yhLxrNnl3nSGLdOcvw426aLastsDV7W2hJqpvKqHgg70xvp7UKN1ny/xjURa9vTvwJ0HNAJMPg2I/1POVOEl9g5kkGrE7B9O
X-Gm-Message-State: AOJu0YzD4lbBio0Pqef2FMLIRbx+JRZ6R9f1CRWoCG5Hvtnk2xvpV5Kb
	ZHW9DIHxY43mEeAF+QZwBuwXzdUnnF5VqYVolK7fyaLeX4m9aJpJd04CVlh7mwxk6tML/ol6qti
	muRS67OOwOqifn63tdk+dJEhnU7NoTvlQpGxVDlBCTWSSnxFPCk8taOg=
X-Google-Smtp-Source: AGHT+IFHFn/toJGvbVqs7NpRcTjoAPSJsNgFe92mL01BdjCoHuUc4dF0a/Ngq16mUdGBnaWgl7a+/YZQ/XERPgmZsTqNzFO4iY9P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c09:b0:7d0:903f:e15c with SMTP id
 w9-20020a0566022c0900b007d0903fe15cmr318737iov.4.1712564776605; Mon, 08 Apr
 2024 01:26:16 -0700 (PDT)
Date: Mon, 08 Apr 2024 01:26:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a29f10615918f91@google.com>
Subject: [syzbot] [udf?] WARNING in __udf_add_aext (3)
From: syzbot <syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    8568bb2ccc27 Add linux-next specific files for 20240405
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D11b4c49d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D48ca5acf8d2eb3b=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D799a0e744ac47f928=
024
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16c4258d18000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16562e75180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d120b5e779c/disk-=
8568bb2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a89e3589a585/vmlinux-=
8568bb2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/045e657c0e0d/bzI=
mage-8568bb2c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c14fae515f13=
/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com

UDF-fs: INFO Mounting volume 'Li=05uxUDF', timestamp 2022/11/22 14:59 (1000=
)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5086 at fs/udf/inode.c:2053 __udf_add_aext+0x555/0x700=
 fs/udf/inode.c:2052
Modules linked in:
CPU: 1 PID: 5086 Comm: syz-executor356 Not tainted 6.9.0-rc2-next-20240405-=
syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 03/27/2024
RIP: 0010:__udf_add_aext+0x555/0x700 fs/udf/inode.c:2052
Code: b4 dc fe 49 8b 3c 24 4c 89 fe e8 86 27 ff fe 31 c0 48 83 c4 30 5b 41 =
5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 6c a5 77 fe 90 <0f> 0b 90 e9 e7 f=
b ff ff e8 5e a5 77 fe 90 0f 0b 90 e9 54 fc ff ff
RSP: 0018:ffffc9000350efb8 EFLAGS: 00010293
RAX: ffffffff831de844 RBX: 1ffff920006a1ec1 RCX: ffff888026e99e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000001e0
RBP: 00000000000001e0 R08: ffffffff831de426 R09: ffffffff831de356
R10: 0000000000000002 R11: ffff888026e99e00 R12: ffffc9000350f600
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffc9000350f608
FS:  000055558b967380(0000) GS:ffff8880b9500000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cc70f0db50 CR3: 0000000011250000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_setup_indirect_aext+0x792/0xa50 fs/udf/inode.c:2018
 udf_add_aext fs/udf/inode.c:2105 [inline]
 udf_do_extend_file+0x6f8/0x11e0 fs/udf/inode.c:576
 inode_getblk fs/udf/inode.c:816 [inline]
 udf_map_block+0x18d1/0x5560 fs/udf/inode.c:444
 __udf_get_block+0x126/0x410 fs/udf/inode.c:458
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2105
 __block_write_begin fs/buffer.c:2154 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2213
 udf_write_begin+0x10d/0x1a0 fs/udf/inode.c:261
 generic_perform_write+0x322/0x640 mm/filemap.c:4009
 udf_file_write_iter+0x2fd/0x660 fs/udf/file.c:111
 call_write_iter include/linux/fs.h:2106 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_pwrite64 fs/read_write.c:705 [inline]
 __do_sys_pwrite64 fs/read_write.c:715 [inline]
 __se_sys_pwrite64 fs/read_write.c:712 [inline]
 __x64_sys_pwrite64+0x1aa/0x230 fs/read_write.c:712
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7fc0f1893a79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1a02dcd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 6573726168636f69 RCX: 00007fc0f1893a79
RDX: 0000000000000001 RSI: 0000000020000300 RDI: 0000000000000004
RBP: 00007fc0f1907610 R08: 00007ffc1a02dea8 R09: 00007ffc1a02dea8
R10: 0000010000000005 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc1a02de98 R14: 0000000000000001 R15: 0000000000000001
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

