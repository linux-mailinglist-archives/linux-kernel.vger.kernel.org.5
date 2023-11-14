Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5021A7EA826
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjKNBQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNBQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:16:09 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5664FD5E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:16:06 -0800 (PST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2806501f8efso6555160a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699924566; x=1700529366;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMecVzb37CbS/WHVdEDAOBUU7xoU/DxlcbWhF9kWiuU=;
        b=raDnHa7LFJODbBDeXahpvCsWqwRzPz5rj1SlJJp1jDNaEOFdRRShH7hHds+E8yThrW
         UINaOZ7lm/ty7VYeXfsjcubNMDZBHvKLJSHg7T5BaqLnUmm2Rcm25K+wrC8FgYD77KeL
         CRyEGZk07EbUhqnxllItFbEjWj4Jq8rWcX3AjhkKcM4hIy/RBotebuhC2+Kb0hPoZfBH
         RNkKpVnxaNqXKZgGUi/KbSgipKsyvd1Rf9+8/q7M0F8ly9kW2EOjZihlp0ycVC6oi2c3
         SZNLyzdG1aVtl2KiDwqhxK9jrHvS8QIYuRJAFoGR0XAOT6KYIpLB4dszLuBd9AvqJX9q
         +pXw==
X-Gm-Message-State: AOJu0Yz3byDJbYhR1805s/plM2qEbyjxcSpHVWPAcI+ERub1pe4wO6Gx
        qgeUQHxiHrcAO5QncKrhkism1IpazMS5gyVjnQB0BZxzqXtx
X-Google-Smtp-Source: AGHT+IGv8d37dxNT3tS0GLmG02nR5+tX2SbK3uQvyeSLb2Iv+11spZFNIXirvgfia/mH6tPp4umffdO1CWjdfPtEuU1aFCzXLtMu
MIME-Version: 1.0
X-Received: by 2002:a17:90b:2b8e:b0:281:1c2e:9e6c with SMTP id
 rs14-20020a17090b2b8e00b002811c2e9e6cmr2475801pjb.5.1699924565861; Mon, 13
 Nov 2023 17:16:05 -0800 (PST)
Date:   Mon, 13 Nov 2023 17:16:05 -0800
In-Reply-To: <tencent_A2204B221B3E258FBA7BBB9A33FD9E401B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4ae73060a1287e8@google.com>
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

SQUASHFS error: Failed to read block 0x6fc: -5
SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 5484 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-15156-g13d88ac54ddd-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:squashfs_page_actor_init_special+0x20e/0x4c0 fs/squashfs/page_actor.c:128
Code: 00 00 00 49 8d 6c 24 48 48 89 e8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 32 02 00 00 c7 45 00 00 00 00 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ff e8 73 34 8c ff 49 8b 2f 48 83 c5 20
RSP: 0018:ffffc9000504e4f8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffff888023400000
RDX: ffff888023400000 RSI: 0000000000000000 RDI: ffff88801d0c0f40
RBP: ffff88801d0c0f48 R08: ffffffff825ea893 R09: 1ffffffff21ba48f
R10: dffffc0000000000 R11: fffffbfff21ba490 R12: ffff88801d0c0f00
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000010
FS:  00007f371f1fe6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562a2771d950 CR3: 0000000023dac000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 squashfs_readpage_block+0x659/0xf90 fs/squashfs/file_direct.c:73
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
RIP: 0033:0x7f371fe7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f371f1fe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f371ff9bf80 RCX: 00007f371fe7cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00007f371fec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f371ff9bf80 R15: 00007fff173cbda8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:squashfs_page_actor_init_special+0x20e/0x4c0 fs/squashfs/page_actor.c:128
Code: 00 00 00 49 8d 6c 24 48 48 89 e8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 32 02 00 00 c7 45 00 00 00 00 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ff e8 73 34 8c ff 49 8b 2f 48 83 c5 20
RSP: 0018:ffffc9000504e4f8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffff888023400000
RDX: ffff888023400000 RSI: 0000000000000000 RDI: ffff88801d0c0f40
RBP: ffff88801d0c0f48 R08: ffffffff825ea893 R09: 1ffffffff21ba48f
R10: dffffc0000000000 R11: fffffbfff21ba490 R12: ffff88801d0c0f00
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000010
FS:  00007f371f1fe6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562a2771d950 CR3: 0000000023dac000 CR4: 00000000003506f0
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
  34:	e8 73 34 8c ff       	call   0xff8c34ac
  39:	49 8b 2f             	mov    (%r15),%rbp
  3c:	48 83 c5 20          	add    $0x20,%rbp


Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1637eba8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1139bf88e80000

