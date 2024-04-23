Return-Path: <linux-kernel+bounces-155955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 055628AFBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334FB1C21F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C961B143C4E;
	Tue, 23 Apr 2024 22:25:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BF143860
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911131; cv=none; b=j6p2fomOmUaE/xql5J9hlxdItVldzdteyoXUltlEd6zFtyATGNpzEBZYYzp6sH7Vb6Hb3O4OmXzcd1j3iul0aT6pGyXaVvh2+03S5BMD8HLnNyWYFrdVi0oxKfGMk5R7qR1+bkQSPav0nwI8e5tepKpaTQVEAhus/uzaNvHZ9SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911131; c=relaxed/simple;
	bh=5NKc+KzJv4XeC9iiJoL21wYs9nyIBRjvAj5KvZ1W4A4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cWDslsz6kWDCizeAQN7hndwJmmiFtdKW7Cg1rd5A+I80ovTOnYNIu2bL1YVMZjjg4tf6flQyy5Y/4APsd36TVL7r/hwlLN9q4DQPKvxIO5j/vUxIn0WwIPs9aL4XMbow4UraORBASTK4easRotOH9V1rrFKCuu5uNvlBEcN/wzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ddceae0763so168936339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713911129; x=1714515929;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sedmCRB2uj77q0fSKeZqXQWSbzSs2fuWMeWh1CFXBaM=;
        b=CECiYiExM1MeZ8ZXVoV9kk79ECxzcBS0p6hTef72JcA0dXO6d0FQ4gMc/dt/6XXmi8
         ccHD7yIYgIntV9yUC7ggmvGv01harh+lpL1kt+1Mc7lflL6BYkeuSUg5xguKEOUkBUYt
         ScKsVi3oduJcpGTDL3MjIzqtSEGZo21okHCA1TgktrRb5VWWDV9I6UWNDYlY1UibT3Be
         FSMD0ddlhsJdeInIYCqCF8MnUHvUIZqsrBcENj4gY4AYlQebaZJkLhTEu7/iVHjibxS2
         s0eHj/pn/2PmSwhBFcTEa5LNIo4/FXc+1gZ1O3CdWXX9KvcNuP0E6EZ2eOdSnc1xLYaM
         rb+g==
X-Forwarded-Encrypted: i=1; AJvYcCVRDv8AB/XqcS8Kpl5GRr/LbN4swETwyG3DhLNDcutRk7mBcvv+Qijw0ZMEvzI691SrbdRQf3tE8ucvvwL0mmqdt0IaxyN+hTgI6rU4
X-Gm-Message-State: AOJu0Yz2w3EByyvYTSGHlvGCs87wzSj4SqB9ZrhGw9woFl6qm8lf/mL6
	Cn9qcur+4PpKb95y9/dfxHSXUKvePR3i/YdNT5jcFwG5difVKNE95rSAj85PbTaOdAdvTBx/gw4
	YKLjzTYslEnoJWrdVjovDuu+DKmpT/74YEHc1f/TDVb+vEPYQRTxxkME=
X-Google-Smtp-Source: AGHT+IE67aMdA0tSXgLd6wNUNc5Qs/GVAVjjQKKTFh1BI8qt4IDBG2m2u4C2yNjHtD6EgyroMTQPGZidXRrviYu5qquW6nUdqssa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:840a:b0:482:e78a:899c with SMTP id
 iq10-20020a056638840a00b00482e78a899cmr72874jab.3.1713911129199; Tue, 23 Apr
 2024 15:25:29 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:25:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000866ea0616cb082c@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
From: syzbot <syzbot+241c815bda521982cb49@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3cdb45594619 Merge tag 's390-6.9-4' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=115a2547180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
dashboard link: https://syzkaller.appspot.com/bug?extid=241c815bda521982cb49
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109bb8f7180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e54bab180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4befd8e98bed/disk-3cdb4559.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/efc09f95602f/vmlinux-3cdb4559.xz
kernel image: https://storage.googleapis.com/syzbot-assets/29a54be03694/bzImage-3cdb4559.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/784deb2bb8a2/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14dc8b53180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16dc8b53180000
console output: https://syzkaller.appspot.com/x/log.txt?x=12dc8b53180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:886:2
index 524288 is out of range for type 'struct mutex[128]'
CPU: 1 PID: 111 Comm: jfsCommit Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:415
 diFree+0x21c3/0x2fb0 fs/jfs/jfs_imap.c:886
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x2a8/0x630 fs/inode.c:667
 txUpdateMap+0x829/0x9f0 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 1 PID: 111 Comm: jfsCommit Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 panic+0x349/0x860 kernel/panic.c:348
 check_panic_on_warn+0x86/0xb0 kernel/panic.c:241
 ubsan_epilogue lib/ubsan.c:222 [inline]
 __ubsan_handle_out_of_bounds+0x141/0x150 lib/ubsan.c:415
 diFree+0x21c3/0x2fb0 fs/jfs/jfs_imap.c:886
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x2a8/0x630 fs/inode.c:667
 txUpdateMap+0x829/0x9f0 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

