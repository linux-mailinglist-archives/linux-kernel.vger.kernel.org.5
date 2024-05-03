Return-Path: <linux-kernel+bounces-168111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3BF8BB3D1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9656D1F2586E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E552158868;
	Fri,  3 May 2024 19:19:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110457C82
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763967; cv=none; b=PvlZHDFSRO29QcY49gnp6N3h7edkJTqZCQ0gMh0NXTSVtzsb+0tNhOmTekus5WfJHNv66MHOTvYOlHzcQTSM/BhQxLdNmRhiuqdeS1U47KwVyBkY7RPFU4yGGZ6zK5V7er2oG0DnYk3jN5viMPEpiPRw0TWurdRd5mHGYeP1/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763967; c=relaxed/simple;
	bh=kJw4Nxpl/ECPGT5QfyfmhtgM8yNJUkmbHzdzUkLRdvo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sYOD/qlXb5Fu7xGoP0opzDsy0L75NMHNJ26+zr6ziZ5UCjyLencJYQ4tScNnUwx5Yv3u6ZbArTfJEY+Oz4cObsTgSiGhATYGflbMOQJXv68Xdf1OKpHgQ0HYqEhJ35EbCZMcAHj2UxT3yhZ+zc09k3RXS3bRMdZbH87QuToV/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da41c44da7so1912339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763965; x=1715368765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qnsRLW7cqSlV4zcaKSMwF+Vp1XMnKteA9A1GTQ+p10=;
        b=njiEZy5pEpQSQQDwWhipTm6sdCsB4MKqM8K7ZqANN/Z1xOI26dCO6tO5kbI7F8KSKh
         drJUuh0yusY/KkszEr75KVMF0XyrJ6wtLWa4VJtJvrdxsJEEWygjhu5mo2C91dl59Bt0
         1O1IHs+MKilgi9pCzGcuHa/snbsPgwlxvXw0QMo3vyRMuOeyXIqspEiBLcfQ3K82KB6Q
         Yg591N+hVV44SP96UpJttkozaZeOIfF1E3ajG6u5qyCaWwSF6vMjPfU3gTTkAhaYUhhG
         bEvL6FsOvne4luCnG7HTpxfRKZiBl+S4Z+eJkSP6uCXsIxI/sLV3+vsLBE8t1gw8375E
         7uvA==
X-Forwarded-Encrypted: i=1; AJvYcCWgbNZEaDwd6zqLPZIH4lNX12CyywGhmFAV2y+luB9FbGUcxNSv/hZMEXidnQOtl9hlsDhq/6GrBoEEsjtwoYpJ2VE6L2o7edbIRfpa
X-Gm-Message-State: AOJu0YyKZ0ecbaN5V+5qsiVbzAbjtChTp4IhzKTRQgfUV+dy7LjMGxO/
	26zkXTHwG7wytu1XjaateBh40OwQWOfcsHhiy1JjBT9cnYYSm3+CLodjYw2O/idDVF2AeXGY0F7
	F8eWhZ+6eAVTfJNN0lXkavU4Qm5tCQjt92abrgNOOkGJfLM0np3kKeKM=
X-Google-Smtp-Source: AGHT+IFC5qQF+9TFJEVRQwaGYfGWBnDfUJ/RplpNTeqFyZDfrZuJC5hUgIFlW/KONEPhC0XL+/00hLKW+95QZR+xU5bHk3Ol0Ngp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:a412:0:b0:488:59cc:eb4c with SMTP id
 c18-20020a02a412000000b0048859cceb4cmr46582jal.3.1714763964884; Fri, 03 May
 2024 12:19:24 -0700 (PDT)
Date: Fri, 03 May 2024 12:19:24 -0700
In-Reply-To: <00000000000078baec06178e6601@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000400d06179199d8@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_trans_srcu_unlock
From: syzbot <syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11e60b38980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d42c70980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ce8250980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3ee5200440e/disk-f03359bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c651e70b4ae3/vmlinux-f03359bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/196f43b316ad/bzImage-f03359bc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4b5f0e6cc6de/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com

------------[ cut here ]------------
btree trans held srcu lock (delaying memory reclaim) for 29 seconds
WARNING: CPU: 0 PID: 5076 at fs/bcachefs/btree_iter.c:2873 check_srcu_held_too_long fs/bcachefs/btree_iter.c:2871 [inline]
WARNING: CPU: 0 PID: 5076 at fs/bcachefs/btree_iter.c:2873 bch2_trans_srcu_unlock+0x4f1/0x600 fs/bcachefs/btree_iter.c:2887
Modules linked in:
CPU: 0 PID: 5076 Comm: syz-executor304 Not tainted 6.9.0-rc6-syzkaller-00131-gf03359bca01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:check_srcu_held_too_long fs/bcachefs/btree_iter.c:2871 [inline]
RIP: 0010:bch2_trans_srcu_unlock+0x4f1/0x600 fs/bcachefs/btree_iter.c:2887
Code: 2b 1f 48 c1 eb 02 48 b9 c3 f5 28 5c 8f c2 f5 28 48 89 d8 48 f7 e1 48 c1 ea 02 48 c7 c7 40 26 11 8c 48 89 d6 e8 e0 a5 49 fd 90 <0f> 0b 90 90 e9 c0 fe ff ff 44 89 f9 80 e1 07 38 c1 0f 8c 38 fb ff
RSP: 0018:ffffc90003edf1b0 EFLAGS: 00010246
RAX: bf0e0aad7b822500 RBX: 00000000000002da RCX: ffff888029225a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000ffffac70 R08: ffffffff81588e32 R09: 1ffff1101728519a
R10: dffffc0000000000 R11: ffffed101728519b R12: dffffc0000000000
R13: 1ffff11003c1100d R14: 1ffff11003c11008 R15: ffff88801e088068
FS:  000055556aeb6380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559d71bf4968 CR3: 000000001b6f2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_trans_begin+0x1482/0x1920 fs/bcachefs/btree_iter.c:2963
 __bchfs_fallocate fs/bcachefs/fs-io.c:608 [inline]
 bchfs_fallocate fs/bcachefs/fs-io.c:733 [inline]
 bch2_fallocate_dispatch+0x1181/0x3810 fs/bcachefs/fs-io.c:780
 vfs_fallocate+0x564/0x6c0 fs/open.c:330
 do_vfs_ioctl+0x2592/0x2e50 fs/ioctl.c:883
 __do_sys_ioctl fs/ioctl.c:902 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f180396cb19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe82aad958 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0073746e6576652e RCX: 00007f180396cb19
RDX: 0000000020000000 RSI: 0000000040305828 RDI: 0000000000000005
RBP: 652e79726f6d656d R08: 000055556aeb74c0 R09: 000055556aeb74c0
R10: 000055556aeb74c0 R11: 0000000000000246 R12: 00007ffe82aad980
R13: 00007ffe82aadba8 R14: 431bde82d7b634db R15: 00007f18039b503b
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

