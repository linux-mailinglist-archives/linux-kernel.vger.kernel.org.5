Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7437FE9E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344694AbjK3HpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjK3HpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:45:01 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CF7D6C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:45:06 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c5fe3b00f6so647051a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701330305; x=1701935105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvDVdklXpOO28r2h4hM/HbFeKnvYdtyejaI7kcvG/3Y=;
        b=qZ58e+LTB3hr04BN+vv3XWwnrlqlUyLNBRXIztEidE4+zV/Kt+ujVIW+GzXm9ejlNJ
         J4xLjSfDe9dSeHTqjXRnALbMu3X4KrmA04Wsj6IDS8ah8Uwid2YyZDpUUzqvGqG4g6vW
         XyrzUxqWLc6VFLSHPdOXjbJPTswCjd23cDk6Kjld1IV2Rdooz3ESxVA2xYf5wp+28fTu
         V+wdnHkZF0ZYqLPM16T2ICu0ZeKk3CCdkcTEPpHE7LZPUhdC7gDf3pq0EfJYrD5DOUQl
         DqZbdCc6tukShdJiAzQXdNjBKweoaGR7W30aohw1obxCe9kw/xuGTTpuKRD92qdtGaA8
         CIEw==
X-Gm-Message-State: AOJu0YyEoxoKHZrcRZ9ZTrg7XCpLYEKg0fPVLqxN9Oq9mY0w3e0jXwk6
        tDT+Rl5RvdQSLRsVnxgO66ipQAGH6/pnJ8t1Zy4qhDM6352fPP4=
X-Google-Smtp-Source: AGHT+IF0DxaOnUA6efG+zkn0dRYM3rvuXN8AzplCWV2JW76tPQ2PYT/atIzSO3RqgWFDtssFVeB7pcPBYZzlR8LePyiOXP3/lhKi
MIME-Version: 1.0
X-Received: by 2002:a63:e310:0:b0:5b9:63f2:e4cc with SMTP id
 f16-20020a63e310000000b005b963f2e4ccmr3477838pgh.2.1701330305575; Wed, 29 Nov
 2023 23:45:05 -0800 (PST)
Date:   Wed, 29 Nov 2023 23:45:05 -0800
In-Reply-To: <20231130072806.1240587-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000826f8f060b59d4ea@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_write_inode
From:   syzbot <syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in __exfat_truncate

=====================================
WARNING: bad unlock balance detected!
6.1.0-syzkaller-11044-gf9ff5644bcc0-dirty #0 Not tainted
-------------------------------------
syz-executor.1/5525 is trying to release lock (&sbi->s_lock) at:
[<ffffffff8247908a>] __exfat_truncate+0x45a/0x7f0 fs/exfat/file.c:163
but there are no more locks to release!

other info that might help us debug this:
4 locks held by syz-executor.1/5525:
 #0: ffff88802a1e4460 (sb_writers#14){.+.+}-{0:0}, at: do_renameat2+0x3eb/0xd20 fs/namei.c:4866
 #1: ffff88802a1e4748 (&type->s_vfs_rename_key#2){+.+.}-{3:3}, at: lock_rename+0x58/0x280 fs/namei.c:2994
 #2: ffff88806489b970 (&sb->s_type->i_mutex_key#21/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #2: ffff88806489b970 (&sb->s_type->i_mutex_key#21/1){+.+.}-{3:3}, at: lock_rename+0xa4/0x280 fs/namei.c:2998
 #3: ffff88806489d9b0 (&sb->s_type->i_mutex_key#21/2){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #3: ffff88806489d9b0 (&sb->s_type->i_mutex_key#21/2){+.+.}-{3:3}, at: lock_rename+0xd8/0x280 fs/namei.c:2999

stack backtrace:
CPU: 1 PID: 5525 Comm: syz-executor.1 Not tainted 6.1.0-syzkaller-11044-gf9ff5644bcc0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x100/0x178 lib/dump_stack.c:106
 print_unlock_imbalance_bug include/trace/events/lock.h:69 [inline]
 __lock_release kernel/locking/lockdep.c:5345 [inline]
 lock_release.cold+0x49/0x4e kernel/locking/lockdep.c:5688
 __mutex_unlock_slowpath+0xa3/0x640 kernel/locking/mutex.c:907
 __exfat_truncate+0x45a/0x7f0 fs/exfat/file.c:163
 exfat_evict_inode+0x263/0x340 fs/exfat/inode.c:624
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x5ea/0x8c0 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
 __dentry_kill+0x3b8/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:745 [inline]
 dput+0x6aa/0xf70 fs/dcache.c:913
 do_renameat2+0x46a/0xd20 fs/namei.c:4932
 __do_sys_rename fs/namei.c:4976 [inline]
 __se_sys_rename fs/namei.c:4974 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:4974
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f464c67cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f464361e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f464c79c050 RCX: 00007f464c67cb29
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000020000040
RBP: 00007f464c6c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f464c79c050 R15: 00007ffd9781fcc8
 </TASK>


Tested on:

commit:         f9ff5644 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1140c364e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bf08f50e8fff9ad
dashboard link: https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12aa5254e80000

