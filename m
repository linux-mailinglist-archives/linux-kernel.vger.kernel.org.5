Return-Path: <linux-kernel+bounces-167637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E68BAC55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E044F1C2279A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27D715351B;
	Fri,  3 May 2024 12:24:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CECA62
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739067; cv=none; b=GWu3siFD4agCZli6NxSyVy4J9DbYRic5p4P3dXvvJfjNxttGqCNzRFuOps40VyuVcN+25bmJdPhxYylJ6lzybBvEE8m29+jqOHE6J3EEDUbuNY18kHn2aVzbI+QbgJdAmIqeIrXiWUaVzuq0WHWmbuWVy0Ta73C1vc5Urgcok9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739067; c=relaxed/simple;
	bh=lQA+G/qrDvpvIPLSUty/yz+9ZmJrQZje8mPUo9tK1po=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=buJ+yN0f5HqhwneHfPptxDjmRhm0NehsgX2iBXaBuZPMHEB8p9U9dW+KYzyKXpKYSQrZPJHQ2p/wADsbHou4WqGpLFvmCYsAXVUqvIiEMcvU+XmEVJa2NIvs6PwQnv+nxBy92OmwuO2YDgEhgAY+gkRM8fwXLZut+oUKYMI+zkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c7ba4fe7aso4943485ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 05:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714739065; x=1715343865;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgtA0e/mNrBatZ4jADUGKOrqubVKM0PELvXzPtRsvXo=;
        b=CW4PiIo4eib6jLlAynM5ElHvtZSz/AtYgtcXYVhiolHkc0p+u5wY4FyzyG0dVFMRZO
         Uo2m1dh+VcCKsUwManSy2LyX3SENWGK9eVAcZIMfI7JgN3mG46miZuTvEvU7CJLZbfgL
         EuWdmWgH6ny7LzSv0F8d8QSY0HzZ4Y/A47icXJC5uATFSMiezsFUo+qV/Mu6XwRzZi4X
         l50G9QfY8TfXdEeTzBXGatobgLYM7u42XYn2zoGQDRdspcmdC3OEwY2XGk4yndA7DFeU
         t7liZSA5Cutt+VXo6GhNc6NyJCOr+O+Pojl008KD43VuHV6JdLRVOerPvaWWhdrVbYt0
         g3tg==
X-Forwarded-Encrypted: i=1; AJvYcCUW6tQvbNcOMkYxPY7RUpRWU74zz33iP44y8p8BpgLgzDNG/IyrGkryp7DJCAfp9rWiTcNurHGvFH0Vlmm1qIbGDvuRuC6FAMQLCNCA
X-Gm-Message-State: AOJu0YzhoA6IPv6B0RcRYRSBXpIU3i/tHCQwjTFZFsMtXPDbU1CgObcQ
	7yihTJmf3y7y2JjZcKCSD78ANxL7TjTmazQ2FAI4pp/ZAEbAyoeSowCdT0ue+Jw9s0dfmlYJrYX
	nwgo/4bgN8pmKM/sK+e8lfOwNZlQh7v+TYCKLTaE52jbNU020LFyCJXs=
X-Google-Smtp-Source: AGHT+IFo3Hb+ssgX036xbPxKQT5E9v4lAm4X8apq1VjVHkoQbtmYpZ3rkfIW+d2b1iDAZ/zACfE8kEzCF7ZP72K8TITsN7QF7XKD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:36c:5029:1925 with SMTP id
 g6-20020a056e021a2600b0036c50291925mr156194ile.0.1714739065175; Fri, 03 May
 2024 05:24:25 -0700 (PDT)
Date: Fri, 03 May 2024 05:24:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcd2ae06178bccb0@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in skcipher_walk_virt
From: syzbot <syzbot+97b4444a5bd7bf30b3a8@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c169df180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=97b4444a5bd7bf30b3a8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b345b1c01095/disk-f03359bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d59970ea319e/vmlinux-f03359bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47407f406f40/bzImage-f03359bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97b4444a5bd7bf30b3a8@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 32768
bcachefs (loop3): mounting version 1.7: mi_btree_bitmap opts=metadata_checksum=none,data_checksum=none,nojournal_transaction_names
bcachefs (loop3): recovering from clean shutdown, journal seq 10
=====================================================
BUG: KMSAN: uninit-value in skcipher_walk_virt+0x91/0x1a0 crypto/skcipher.c:504
 skcipher_walk_virt+0x91/0x1a0 crypto/skcipher.c:504
 chacha_stream_xor+0x7c/0x710 crypto/chacha_generic.c:22
 crypto_chacha_crypt+0x79/0xb0 crypto/chacha_generic.c:45
 crypto_skcipher_encrypt+0x1a0/0x1e0 crypto/skcipher.c:671
 do_encrypt_sg fs/bcachefs/checksum.c:107 [inline]
 do_encrypt+0x99c/0xc30 fs/bcachefs/checksum.c:127
 gen_poly_key fs/bcachefs/checksum.c:190 [inline]
 bch2_checksum+0x21f/0x7c0 fs/bcachefs/checksum.c:226
 bch2_btree_node_read_done+0x1898/0x75e0 fs/bcachefs/btree_io.c:1055
 btree_node_read_work+0x8a5/0x1eb0 fs/bcachefs/btree_io.c:1324
 bch2_btree_node_read+0x3d42/0x4b50
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1748 [inline]
 bch2_btree_root_read+0xa6c/0x13d0 fs/bcachefs/btree_io.c:1772
 read_btree_roots+0x454/0xee0 fs/bcachefs/recovery.c:457
 bch2_fs_recovery+0x7adb/0x9310 fs/bcachefs/recovery.c:785
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1043
 bch2_fs_open+0x135f/0x1670 fs/bcachefs/super.c:2102
 bch2_mount+0x90d/0x1d90 fs/bcachefs/fs.c:1903
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3875
 ia32_sys_call+0x3a9a/0x40a0 arch/x86/include/generated/asm/syscalls_32.h:22
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable __req_desc.i created at:
 do_encrypt_sg fs/bcachefs/checksum.c:101 [inline]
 do_encrypt+0x8f9/0xc30 fs/bcachefs/checksum.c:127
 gen_poly_key fs/bcachefs/checksum.c:190 [inline]
 bch2_checksum+0x21f/0x7c0 fs/bcachefs/checksum.c:226

CPU: 1 PID: 15218 Comm: syz-executor.3 Not tainted 6.9.0-rc6-syzkaller-00131-gf03359bca01b #0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

