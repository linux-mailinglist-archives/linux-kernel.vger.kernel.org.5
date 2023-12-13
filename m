Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9990811098
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjLML4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378838AbjLML4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:56:00 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B8B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:56:05 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso48734a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702468564; x=1703073364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72HNi6AbpaEgv+rI78YtWOIoCer2iNuEb00Lz0/QMD4=;
        b=tEFf7CMgsV9jE1/g7oUb9/m4unsq0P8BxZyJWnfKrK7ZX6k2UkmmwxYfBbBe8Aw/Bv
         X0tPq3iiJoxvJQ/KcZ3Gie8ZepnP6Xag3UMJycjgjBmeqs0m7FuNEGq/MkMFUKhBPq+e
         CvibBObHfJ0ZemMhgR1592UR39ktOtiulr19x8KzNUXVD9bbGlj9x2Yp0lo0moCxpQ7U
         buM7ET9dAQsg7iApIrkMT2n4EwHXiB4ivtUaBgmqrG8zr3UFwBcTWYmMYpz3/mKvOBE0
         4/bcv/PmUUvLGJnjlOONQW65JzEkcYAeD7sk9Uf96q9Ev5cZRC6Y3xhSjPTm7Mpmn66G
         RgCA==
X-Gm-Message-State: AOJu0YzZQ4oyPRcoRUwqHyWnPNdLvTlO+9TdP31SYO6YYf2ox2qGURTv
        dkmb7jdUmQQdC8zyM4R86jp+BVbroo+KkbBTyr6Gs/1TuAPS
X-Google-Smtp-Source: AGHT+IH1y1KEQVzK63c1RqgFSqkGziKyfAHgpXoe1uWmw2wN4OU0NNQPZhOhAP0NAeEmZ/BKrHAxjwYekcYTc3P8aAT96oZt9mjH
MIME-Version: 1.0
X-Received: by 2002:a65:62da:0:b0:5ca:4060:b1f4 with SMTP id
 m26-20020a6562da000000b005ca4060b1f4mr68534pgv.5.1702468564550; Wed, 13 Dec
 2023 03:56:04 -0800 (PST)
Date:   Wed, 13 Dec 2023 03:56:04 -0800
In-Reply-To: <tencent_2D190DCF9D0DA225C98D87922ADDA1DD8607@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000080e3d060c62da64@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ext4_do_writepages

------------[ cut here ]------------
kernel BUG at fs/ext4/inode.c:2587!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 10 Comm: kworker/u4:0 Not tainted 6.4.0-rc3-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:ext4_do_writepages+0x27a1/0x34a0 fs/ext4/inode.c:2587
Code: fc ff df 44 89 64 24 18 48 c1 ea 03 80 3c 02 00 0f 84 bc ed ff ff 48 8b 7c 24 08 e8 49 aa a8 ff e9 ad ed ff ff e8 ef 2f 55 ff <0f> 0b e8 e8 2f 55 ff 48 8b 84 24 b0 00 00 00 48 8d 78 40 48 b8 00
RSP: 0018:ffffc900000f73e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807592bc50 RCX: 0000000000000000
RDX: ffff888016a41dc0 RSI: ffffffff82306c61 RDI: 0000000000000007
RBP: ffffc900000f75f0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88802aede678 R14: ffff88807592beb0 R15: 7fffffffffffffff
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561e569a2950 CR3: 000000002a00e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_writepages+0x30b/0x780 fs/ext4/inode.c:2792
 do_writepages+0x1b4/0x690 mm/page-writeback.c:2551
 __writeback_single_inode+0x158/0xe70 fs/fs-writeback.c:1603
 writeback_sb_inodes+0x599/0x1010 fs/fs-writeback.c:1894
 wb_writeback+0x2ca/0xa90 fs/fs-writeback.c:2068
 wb_do_writeback fs/fs-writeback.c:2211 [inline]
 wb_workfn+0x29c/0xfd0 fs/fs-writeback.c:2251
 process_one_work+0x9f9/0x15f0 kernel/workqueue.c:2405
 worker_thread+0x687/0x1110 kernel/workqueue.c:2552
 kthread+0x33a/0x430 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_do_writepages+0x27a1/0x34a0 fs/ext4/inode.c:2587
Code: fc ff df 44 89 64 24 18 48 c1 ea 03 80 3c 02 00 0f 84 bc ed ff ff 48 8b 7c 24 08 e8 49 aa a8 ff e9 ad ed ff ff e8 ef 2f 55 ff <0f> 0b e8 e8 2f 55 ff 48 8b 84 24 b0 00 00 00 48 8d 78 40 48 b8 00
RSP: 0018:ffffc900000f73e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807592bc50 RCX: 0000000000000000
RDX: ffff888016a41dc0 RSI: ffffffff82306c61 RDI: 0000000000000007
RBP: ffffc900000f75f0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88802aede678 R14: ffff88807592beb0 R15: 7fffffffffffffff
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f629e29e378 CR3: 000000000c772000 CR4: 0000000000350ef0


Tested on:

commit:         44c026a7 Linux 6.4-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c7b6fae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2045748b9f1055b
dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133a9fbce80000

