Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA747EA7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjKNAqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 19:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjKNAqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 19:46:11 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7445D53
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 16:46:07 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc5ef7e815so51031085ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 16:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699922767; x=1700527567;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdY9i4WxreFLp6T+Tntb6z+snepGb2eA6NwpVorJ4X8=;
        b=LwcDLJIB/u8Mkd6e2qw8tWd14lK3Lm/mP/2AMoWcnO19or1CDegln7mJF31zGhiaH+
         9f//PVGIu3/u5D5wWOLTd8U9T2UvVLhMDdjafT/5p8z39TyLfskzJzw9V1W9rMkovqG3
         74k0k/4DhPyFcKdF2dSTF7SS/qd9iBIxwfL47n0hb/tJOrWuRjLtwjXtkdaNn+yKx+ah
         FN/OCUAW1+wfVy6ChxN4mnwIZQGWZwKoyl7ukIGPPhJnqOgVEnArgCInU7jXwmkUefn7
         1d2ot6IdzGKbO01xeitRCMhKW2jyTsS83cwH9WS0stGKZMa1TU06WDaNZEP/AtG0+msT
         wflA==
X-Gm-Message-State: AOJu0Yw2O4xRFMAdG6HR1sHv/I4ztngy4u41z/SCE2HAxuapW0hppMGZ
        PHfa/H4ihbBad6wOa4yl8A6UmxITPQZp1UHG3s1cNuifTo9w
X-Google-Smtp-Source: AGHT+IERudvwaOO4vtDOSe88bRy7IEARwzbdGivos3k79GY11GuGPhTU8jikB4n//jT/QY271e89yBDEPOuqhKem0M4i8fPEoQp7
MIME-Version: 1.0
X-Received: by 2002:a17:902:f815:b0:1cc:2a6f:ab91 with SMTP id
 ix21-20020a170902f81500b001cc2a6fab91mr226890plb.0.1699922767377; Mon, 13 Nov
 2023 16:46:07 -0800 (PST)
Date:   Mon, 13 Nov 2023 16:46:07 -0800
In-Reply-To: <tencent_66EE4A0C753B774F674A3CED37CA96BA3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1fd99060a121c78@google.com>
Subject: Re: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in squashfs_page_actor_init_special

SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 5484 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-15156-g13d88ac54ddd-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:squashfs_page_actor_init_special+0x20e/0x4c0 fs/squashfs/page_actor.c:128
Code: 00 00 00 49 8d 6c 24 48 48 89 e8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 32 02 00 00 c7 45 00 00 00 00 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ff e8 93 34 8c ff 49 8b 2f 48 83 c5 20
RSP: 0018:ffffc90004fce4f8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffff888015ad3b80
RDX: ffff888015ad3b80 RSI: 0000000000000000 RDI: ffff888027646840
RBP: ffff888027646848 R08: ffffffff825ea873 R09: 1ffffffff21ba48f
R10: dffffc0000000000 R11: fffffbfff21ba490 R12: ffff888027646800
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000010
FS:  00007f7b9e9ea6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b9dd0662e CR3: 0000000020cfe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 squashfs_readpage_block+0x62a/0xf60 fs/squashfs/file_direct.c:70
 squashfs_read_folio+0x569/0xed0 fs/squashfs/file.c:479
 filemap_read_folio+0x19c/0x770 mm/filemap.c:2323
 filemap_create_folio mm/filemap.c:2451 [inline]
 filemap_get_pages+0xdf7/0x2080 mm/filemap.c:2504
 filemap_read+0x42b/0x10b0 mm/filemap.c:2593
 __kernel_read+0x425/0x8b0 fs/read_write.c:428
 integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0xad1/0x1b30 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x554/0xb30 security/integrity/ima/ima_api.c:290
 process_measurement+0x1373/0x21c0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3624 [inline]
 path_openat+0x2893/0x3280 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_open fs/open.c:1463 [inline]
 __se_sys_open fs/open.c:1459 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1459
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f7b9dc7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7b9e9ea0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f7b9dd9bf80 RCX: 00007f7b9dc7cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00007f7b9dcc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f7b9dd9bf80 R15: 00007fff0acb6118
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:squashfs_page_actor_init_special+0x20e/0x4c0 fs/squashfs/page_actor.c:128
Code: 00 00 00 49 8d 6c 24 48 48 89 e8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 32 02 00 00 c7 45 00 00 00 00 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ff e8 93 34 8c ff 49 8b 2f 48 83 c5 20
RSP: 0018:ffffc90004fce4f8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffff888015ad3b80
RDX: ffff888015ad3b80 RSI: 0000000000000000 RDI: ffff888027646840
RBP: ffff888027646848 R08: ffffffff825ea873 R09: 1ffffffff21ba48f
R10: dffffc0000000000 R11: fffffbfff21ba490 R12: ffff888027646800
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000010
FS:  00007f7b9e9ea6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555d54061950 CR3: 0000000020cfe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 49 8d             	add    %cl,-0x73(%rcx)
   5:	6c                   	insb   (%dx),%es:(%rdi)
   6:	24 48                	and    $0x48,%al
   8:	48 89 e8             	mov    %rbp,%rax
   b:	48 c1 e8 03          	shr    $0x3,%rax
   f:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
  14:	84 c0                	test   %al,%al
  16:	0f 85 32 02 00 00    	jne    0x24e
  1c:	c7 45 00 00 00 00 00 	movl   $0x0,0x0(%rbp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 93 34 8c ff       	call   0xff8c34cc
  39:	49 8b 2f             	mov    (%r15),%rbp
  3c:	48 83 c5 20          	add    $0x20,%rbp


Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10ed2f97680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f132ff680000

