Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4CF7E9B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjKMLhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMLhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:37:08 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34D7D69
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:37:04 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b7fb057153so4988800a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699875424; x=1700480224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FGgxHd7xvW7thBmKUYmavnY0qcupLf2KuY+8MU1ANg=;
        b=DFEgh9wEPxxc/+hjoYEoD83hr/amFv7g1Q+pSYJvf9p7EeT+Iycd1ivTM9Xi6V5rw2
         lYKIofX+3G5hqGdbmsAK2mTmDD265sIEYssnOaDgxRc29SJcIR0TDuvYRMhtw1rFJOzy
         oLCZuNgjfTjbKFr86dbtQKPuqU5G4UNH7H+8SbWwsijp5qNX7K3hH2FxpkeG4lx2HSxr
         h9OAPqvkdJqbVoUQv0/E3X1b9skCKvc/cnDCScgOFdxXKFl3JLQM4Gdab+w5ToyRmmH/
         P3aWliwWhuupEcfeAbsTsTYzB44J7fIQhDITq51wfzEAvu0ZZvKiaMRLz77Q8FBz3mvC
         dr3A==
X-Gm-Message-State: AOJu0YzoVIA9/WxT5dM2mhJxh+xrJDo+bIutPp+eF4IrFau/WpouB9R3
        HjVf9CpwmoF/GignVRetJMjsP1+fK9vPZCAkyW7nx7Esu8OL
X-Google-Smtp-Source: AGHT+IEUWnz3JZi5pGVtPd5jjj0CCrlbuy2yBO3ZnupS0bqDWL71tylNJbdJzrhbeMP+XemoNTsR9jOmSnQHt6QiC48n34Ma82Pz
MIME-Version: 1.0
X-Received: by 2002:a65:52c9:0:b0:5bd:303d:cc1d with SMTP id
 z9-20020a6552c9000000b005bd303dcc1dmr1691946pgp.9.1699875424200; Mon, 13 Nov
 2023 03:37:04 -0800 (PST)
Date:   Mon, 13 Nov 2023 03:37:04 -0800
In-Reply-To: <tencent_D7CE758776D767783C3B36E297FC37544A09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d26da4060a071686@google.com>
Subject: Re: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
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
general protection fault in squashfs_readahead

SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
p: ffff888020f895a0, bs: 4096, bl: 12, mp: 1, start: 0, fe: 0, squashfs_readahead
general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 1 PID: 5475 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-15156-g13d88ac54ddd-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:squashfs_readahead+0x5a1/0x1dd0 fs/squashfs/file.c:572
Code: 89 84 24 10 01 00 00 42 80 3c 30 00 74 08 4c 89 ef e8 e3 06 8d ff 48 c1 2c 24 0c 49 8b 5d 00 48 83 c3 20 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 c0 06 8d ff 4c 8b 03 48 c7 c7 60
RSP: 0018:ffffc900052c6380 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000020 RCX: ffff888019ac0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900052c65b0 R08: ffffffff825dd62d R09: 1ffff92000a58c0c
R10: dffffc0000000000 R11: fffff52000a58c0d R12: ffffc900052c6998
R13: ffff888020f895a0 R14: dffffc0000000000 R15: ffffc900052c64e0
FS:  00007fc5c7f106c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005649916ab2e8 CR3: 00000000209b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 read_pages+0x183/0x830 mm/readahead.c:160
 page_cache_ra_unbounded+0x68e/0x7c0 mm/readahead.c:269
 page_cache_sync_readahead include/linux/pagemap.h:1266 [inline]
 filemap_get_pages+0x49c/0x2080 mm/filemap.c:2497
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
RIP: 0033:0x7fc5c727cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc5c7f100c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fc5c739bf80 RCX: 00007fc5c727cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00007fc5c72c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc5c739bf80 R15: 00007ffd8245e0c8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:squashfs_readahead+0x5a1/0x1dd0 fs/squashfs/file.c:572
Code: 89 84 24 10 01 00 00 42 80 3c 30 00 74 08 4c 89 ef e8 e3 06 8d ff 48 c1 2c 24 0c 49 8b 5d 00 48 83 c3 20 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 c0 06 8d ff 4c 8b 03 48 c7 c7 60
RSP: 0018:ffffc900052c6380 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000020 RCX: ffff888019ac0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900052c65b0 R08: ffffffff825dd62d R09: 1ffff92000a58c0c
R10: dffffc0000000000 R11: fffff52000a58c0d R12: ffffc900052c6998
R13: ffff888020f895a0 R14: dffffc0000000000 R15: ffffc900052c64e0
FS:  00007fc5c7f106c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005649916ab2e8 CR3: 00000000209b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 84 24 10 01 00 00 	mov    %eax,0x110(%rsp)
   7:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
   c:	74 08                	je     0x16
   e:	4c 89 ef             	mov    %r13,%rdi
  11:	e8 e3 06 8d ff       	call   0xff8d06f9
  16:	48 c1 2c 24 0c       	shrq   $0xc,(%rsp)
  1b:	49 8b 5d 00          	mov    0x0(%r13),%rbx
  1f:	48 83 c3 20          	add    $0x20,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 c0 06 8d ff       	call   0xff8d06f9
  39:	4c 8b 03             	mov    (%rbx),%r8
  3c:	48                   	rex.W
  3d:	c7                   	.byte 0xc7
  3e:	c7                   	(bad)
  3f:	60                   	(bad)


Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1407c024e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12723810e80000

