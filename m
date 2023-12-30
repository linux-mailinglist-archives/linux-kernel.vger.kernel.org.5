Return-Path: <linux-kernel+bounces-13302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1CD820339
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054D028263D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B98EA8;
	Sat, 30 Dec 2023 01:22:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B78801
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7fef9ef2aso915871239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 17:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703899324; x=1704504124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjyRYCqYJuuEo6FJuDOysy/2ZFJvNq4BZm5lHPU7uFs=;
        b=BERzV2aR5FyCfWZOKeshvhcvgt5j4egV7BYfWWXojF8xD0PjLudfq52epAD4V0z/hY
         4326GxNPr3YA9Dj6VOOtZbO/n8NDQT1z5nEij6AYcLuTZzRLjMHwVNnFsAXMTKGF2aWa
         sJpRA/bDw3tOKPJmJq5ci23iPOKhYfNlpcHZjUDytzzSm6OKcAv/QThpczA7Zvdh6i8V
         5d3JG7YuXWl9NETxL4vjRC+2qrafXOJrti7rn8+uPJiSPNM+dwrHJgjkHFKurHY2huLM
         CNZ8Cc2wik2M1v1PJzf9HONqjHlGjdyZVqY2Nmr4c1uXBvsDi03eraJV/xnU9VfxT8W4
         dyOg==
X-Gm-Message-State: AOJu0YxLpISOJFBptp157tO4pfDLI9qabh8YeEXCi1EVEyTl41+amgvl
	NfzvtTvnpwAC5E6de4MWhrTtz7LNrPzK+ULl2+cKsbMCB4l3
X-Google-Smtp-Source: AGHT+IHfe1v//oWosqfIIIN7y2rRRt+3aZSHiPkuK9az+XNaKSGFiPOFXrNvczhucFrN1JhCbYSkZ7FrwI7yXCsEC+/J1GyaVjER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:35f:c8aa:b526 with SMTP id
 i12-20020a056e021d0c00b0035fc8aab526mr1770140ila.2.1703899324306; Fri, 29 Dec
 2023 17:22:04 -0800 (PST)
Date: Fri, 29 Dec 2023 17:22:04 -0800
In-Reply-To: <20231230010350.2074-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f55b69060daff97a@google.com>
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
CPU: 1 PID: 5576 Comm: syz-executor.0 Not tainted 6.7.0-rc7-syzkaller-00041-gf016f7547aee-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:292 [inline]
RIP: 0010:rb_erase+0xbb/0x1360 lib/rbtree.c:443
Code: 5e 10 4c 89 f5 48 ba 00 00 00 00 00 fc ff df 48 85 db 75 0b e9 e8 04 00 00 48 89 dd 48 89 c3 4c 8d 63 10 4c 89 e0 48 c1 e8 03 <80> 3c 10 00 0f 85 de 0b 00 00 48 8b 43 10 48 85 c0 75 dc 4c 8d 7b
RSP: 0018:ffffc9000526fd20 EFLAGS: 00010216
RAX: 0000170900000017 RBX: 0000b848000000a8 RCX: ffff88806486d408
RDX: dffffc0000000000 RSI: ffff88806486d408 RDI: ffff88802919b810
RBP: ffffffff84f351e0 R08: 0000000000000000 R09: fffffbfff1e327ba
R10: ffffc9000526fd70 R11: 0000000000000000 R12: 0000b848000000b8
R13: ffff88802808eff8 R14: ffff88802919b800 R15: 0000000000000001
FS:  0000555556b94480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f01823cd5e8 CR3: 0000000023343000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 drm_prime_del_handles+0x55/0xb0 drivers/gpu/drm/drm_prime.c:203
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
RIP: 0033:0x7f32ec87bbda
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffe0da98170 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f32ec87bbda
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f32ec99d980 R08: 0000001b2ea60000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000014e33
R13: ffffffffffffffff R14: 00007f32ec400000 R15: 0000000000014af2
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:292 [inline]
RIP: 0010:rb_erase+0xbb/0x1360 lib/rbtree.c:443
Code: 5e 10 4c 89 f5 48 ba 00 00 00 00 00 fc ff df 48 85 db 75 0b e9 e8 04 00 00 48 89 dd 48 89 c3 4c 8d 63 10 4c 89 e0 48 c1 e8 03 <80> 3c 10 00 0f 85 de 0b 00 00 48 8b 43 10 48 85 c0 75 dc 4c 8d 7b
RSP: 0018:ffffc9000526fd20 EFLAGS: 00010216
RAX: 0000170900000017 RBX: 0000b848000000a8 RCX: ffff88806486d408
RDX: dffffc0000000000 RSI: ffff88806486d408 RDI: ffff88802919b810
RBP: ffffffff84f351e0 R08: 0000000000000000 R09: fffffbfff1e327ba
R10: ffffc9000526fd70 R11: 0000000000000000 R12: 0000b848000000b8
R13: ffff88802808eff8 R14: ffff88802919b800 R15: 0000000000000001
FS:  0000555556b94480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f01823cd5e8 CR3: 0000000023343000 CR4: 0000000000350ef0
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

commit:         f016f754 Merge tag 'gpio-fixes-for-v6.7-rc8' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14b493a1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7bcb8f62f1e2c3e
dashboard link: https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1510031de80000


