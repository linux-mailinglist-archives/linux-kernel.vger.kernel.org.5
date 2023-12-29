Return-Path: <linux-kernel+bounces-13075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F023681FF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75551B225C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692DE111AF;
	Fri, 29 Dec 2023 12:23:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984DB11193
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fcbc79fd3so124785185ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 04:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703852584; x=1704457384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfuh7QOehlQL8hJA5WaXOjpb9WjD99H5CtOQrTPuErQ=;
        b=U1jZ/oZk6ZV8IRq38f6XrkrLwFXdW1Fy9+QrqVaF6k7veiTBu1T56qHFtnClMyDA1h
         RoLP+snNJzh5bDskHEqhTsW6Mdx19Th4q8fnm0UT4HWZ9h1xEa9Sudi1ez7MDmrcTzfw
         M0ZSZ3KxxUYGSG/TlLMruFmWWvQNN5ZMVQ/w4jMleci6k/saDI465Vr3PDHCjSYoDVOM
         UtYOeZWapdhXjSbcg73LhLGhr54nSC0hPpQsrDTfacTeUuIgEkwu2DFawWVeykoI62P9
         7iLaIxBb/tJnYygItHQ6YHZHtlDtVGhrDvPl7e2xybLF8XGnUZLuy4o0S8ZDjodM12rk
         Xg5A==
X-Gm-Message-State: AOJu0Ywyalq79goUEAER2WuU1H22zAJbpZzXO9cEncM+QkUPNcGthdWY
	tc78AKUicWPjCOE14BKRkOzB6JK8y3eaDNpfqN/8w0pWiwDL
X-Google-Smtp-Source: AGHT+IFI8zUlvR0dsOjKEA9e4hWnPCwz9AJegw2Wp/0Vex0zZPRYQExYrqBQOCNKLpQwcsyZzWGcwiNFwUHeEcjOiju8WU0MlKLg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2191:b0:360:1684:9509 with SMTP id
 j17-20020a056e02219100b0036016849509mr671261ila.2.1703852584817; Fri, 29 Dec
 2023 04:23:04 -0800 (PST)
Date: Fri, 29 Dec 2023 04:23:04 -0800
In-Reply-To: <20231229112851.2000-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001161a5060da518a6@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_prime_destroy_file_private (2)
From: syzbot <syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in drm_prime_del_handles

general protection fault, probably for non-canonical address 0xe000130900000017: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0x0000b848000000b8-0x0000b848000000bf]
CPU: 0 PID: 5576 Comm: syz-executor.0 Not tainted 6.7.0-rc7-syzkaller-00029-g8735c7c84d1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:292 [inline]
RIP: 0010:rb_erase+0xbb/0x1360 lib/rbtree.c:443
Code: 5e 10 4c 89 f5 48 ba 00 00 00 00 00 fc ff df 48 85 db 75 0b e9 e8 04 00 00 48 89 dd 48 89 c3 4c 8d 63 10 4c 89 e0 48 c1 e8 03 <80> 3c 10 00 0f 85 de 0b 00 00 48 8b 43 10 48 85 c0 75 dc 4c 8d 7b
RSP: 0018:ffffc900052b7d20 EFLAGS: 00010216
RAX: 0000170900000017 RBX: 0000b848000000a8 RCX: ffff88802836d408
RDX: dffffc0000000000 RSI: ffff88802836d408 RDI: ffff8880297d2c10
RBP: ffffffff84f35220 R08: 0000000000000000 R09: fffffbfff1e327aa
R10: ffffc900052b7d70 R11: 0000000000000000 R12: 0000b848000000b8
R13: ffff888020c8c5f8 R14: ffff8880297d2c00 R15: 0000000000000001
FS:  0000555556db8480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ad1c2fd58 CR3: 0000000017726000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 drm_prime_del_handles+0x55/0xb0 drivers/gpu/drm/drm_prime.c:201
 drm_file_free.part.0+0x73b/0xba0 drivers/gpu/drm/drm_file.c:290
 drm_file_free drivers/gpu/drm/drm_file.c:247 [inline]
 drm_close_helper.isra.0+0x180/0x1f0 drivers/gpu/drm/drm_file.c:308
 drm_release+0x22a/0x4f0 drivers/gpu/drm/drm_file.c:495
 __fput+0x270/0xb70 fs/file_table.c:394
 __fput_sync+0x47/0x50 fs/file_table.c:475
 __do_sys_close fs/open.c:1587 [inline]
 __se_sys_close fs/open.c:1572 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1572
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6ad0e7bbda
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffc7c5e8f10 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f6ad0e7bbda
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f6ad0f9d980 R08: 0000001b2e860000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000013a70
R13: ffffffffffffffff R14: 00007f6ad0a00000 R15: 000000000001372f
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:292 [inline]
RIP: 0010:rb_erase+0xbb/0x1360 lib/rbtree.c:443
Code: 5e 10 4c 89 f5 48 ba 00 00 00 00 00 fc ff df 48 85 db 75 0b e9 e8 04 00 00 48 89 dd 48 89 c3 4c 8d 63 10 4c 89 e0 48 c1 e8 03 <80> 3c 10 00 0f 85 de 0b 00 00 48 8b 43 10 48 85 c0 75 dc 4c 8d 7b
RSP: 0018:ffffc900052b7d20 EFLAGS: 00010216
RAX: 0000170900000017 RBX: 0000b848000000a8 RCX: ffff88802836d408
RDX: dffffc0000000000 RSI: ffff88802836d408 RDI: ffff8880297d2c10
RBP: ffffffff84f35220 R08: 0000000000000000 R09: fffffbfff1e327aa
R10: ffffc900052b7d70 R11: 0000000000000000 R12: 0000b848000000b8
R13: ffff888020c8c5f8 R14: ffff8880297d2c00 R15: 0000000000000001
FS:  0000555556db8480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ad1c2fd58 CR3: 0000000017726000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	5e                   	pop    %rsi
   1:	10 4c 89 f5          	adc    %cl,-0xb(%rcx,%rcx,4)
   5:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
   c:	fc ff df
   f:	48 85 db             	test   %rbx,%rbx
  12:	75 0b                	jne    0x1f
  14:	e9 e8 04 00 00       	jmp    0x501
  19:	48 89 dd             	mov    %rbx,%rbp
  1c:	48 89 c3             	mov    %rax,%rbx
  1f:	4c 8d 63 10          	lea    0x10(%rbx),%r12
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction
  2e:	0f 85 de 0b 00 00    	jne    0xc12
  34:	48 8b 43 10          	mov    0x10(%rbx),%rax
  38:	48 85 c0             	test   %rax,%rax
  3b:	75 dc                	jne    0x19
  3d:	4c                   	rex.WR
  3e:	8d                   	.byte 0x8d
  3f:	7b                   	.byte 0x7b


Tested on:

commit:         8735c7c8 Merge tag '6.7rc7-smb3-srv-fix' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=133148d9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7bcb8f62f1e2c3e
dashboard link: https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1041c931e80000


