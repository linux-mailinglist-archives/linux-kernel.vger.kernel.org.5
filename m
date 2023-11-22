Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794117F49EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjKVPKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKVPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:10:38 -0500
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF76E1BF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:10:32 -0800 (PST)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-2851c6f80f2so4914389a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665832; x=1701270632;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNISjNqOME+dw6YEeAsd8Brez3ACNxa0qo7QYk0nRrk=;
        b=VvDa9agUAd7uBkjukK1NBFBMVqT+BNRfZpBEeagCRilSq2tIKNpzTbhfWb/lJg/Mpp
         eEL8HqyhjocMHgloOfl15xYH84DOXwja7i0SKD9g78qiQvdv7o8fmRfsxHHXgHHFdPVV
         SkAzUJ34Mc3fIcoZTxyF/rjU7t2qI7rV4Mo8fNEcwdfq4nCbyQn5nivA/iGXOBtLznsN
         qMCbl9r6OBlLA9j/VxZqJ76j2/a2yUSojIdZmMPOCCnqRLslgSrocacRCeA6mn587WXe
         VwUe76GSmfAv/ZesfXKo2yPScN/4r7Hk+xEp+Dp3HrMPeGxc3CEfsxzsA+fyCTvgfdDd
         tn1g==
X-Gm-Message-State: AOJu0YzVL7mV1TBXzHcaDDBdh+yJhHmvbR6l2Vk7k/QHJcRL6s5TqkgR
        qi+uoKHQ4DaKGEM0slatsJH7KlxpHbGOKbJSBC7DpHssvwNz
X-Google-Smtp-Source: AGHT+IHbSXBA5o+nIc1fBib+40xR7K8epiWQcjBOGTb/NlajdNKU3+Or0JWAiBpmBYy0rwJvDpiD7vM3SoIzAtYMQovG8PRn1Fnp
MIME-Version: 1.0
X-Received: by 2002:a17:90a:9f90:b0:283:a0b1:cedc with SMTP id
 o16-20020a17090a9f9000b00283a0b1cedcmr587333pjp.4.1700665832137; Wed, 22 Nov
 2023 07:10:32 -0800 (PST)
Date:   Wed, 22 Nov 2023 07:10:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce703b060abf1e06@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_dio_write_end_io
From:   syzbot <syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, jack@suse.cz,
        joseph.qi@linux.alibaba.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ritesh.list@gmail.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    98b1cc82c4af Linux 6.7-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15e09a9f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=47479b71cdfc78f56d30
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c09a00e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151d5320e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/39c6cdad13fc/disk-98b1cc82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a77b5daef9b/vmlinux-98b1cc82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e09ae712e0d/bzImage-98b1cc82.xz

The issue was bisected to:

commit 91562895f8030cb9a0470b1db49de79346a69f91
Author: Jan Kara <jack@suse.cz>
Date:   Fri Oct 13 12:13:50 2023 +0000

    ext4: properly sync file size update after O_SYNC direct IO

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d0f0c8e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1430f0c8e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1030f0c8e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
Fixes: 91562895f803 ("ext4: properly sync file size update after O_SYNC direct IO")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4481 at fs/ext4/file.c:391 ext4_dio_write_end_io+0x1db/0x220 fs/ext4/file.c:391
Modules linked in:
CPU: 1 PID: 4481 Comm: kworker/1:2 Not tainted 6.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: dio/sda1 iomap_dio_complete_work
RIP: 0010:ext4_dio_write_end_io+0x1db/0x220 fs/ext4/file.c:391
Code: e8 6a 37 56 ff 4c 89 e2 4c 89 f6 48 89 ef e8 8c f6 ff ff 89 c3 eb 92 4c 89 ff e8 70 c7 ac ff e9 66 ff ff ff e8 46 37 56 ff 90 <0f> 0b 90 e9 34 ff ff ff e8 58 c7 ac ff e9 e9 fe ff ff 4c 89 ff e8
RSP: 0018:ffffc9000dd97c40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000000081fd RCX: ffffffff8231521e
RDX: ffff88802a403b80 RSI: ffffffff823152ea RDI: 0000000000000006
RBP: ffff88807cf83eb0 R08: 0000000000000006 R09: 0000000000004000
R10: 00000000000081fd R11: 0000000000000001 R12: 0000000000004000
R13: 0000000000004000 R14: 0000000000000000 R15: ffff88807cf83e10
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbc3a9779ee CR3: 0000000077984000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 iomap_dio_complete+0x149/0x9f0 fs/iomap/direct-io.c:91
 iomap_dio_complete_work+0x56/0x80 fs/iomap/direct-io.c:146
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


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
