Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF96A80C06F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjLKElC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:41:01 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022AED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:41:06 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb1f23d1bcso7195560fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702269665; x=1702874465;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95wp/TFC/tHKdIEk7a2qbhGs5z/GSR7vO+rq16JjIUo=;
        b=vaquuDvC3OGz/YMVhZ73mMFHIqTOsuc3jnyQT22TWmcMCFQqoml2krjvSD0UmdXa9W
         7cRZ379VBhYMpqduv9cOJrMfYNhl/uPS/apZSa83r7t9Ruox4JijzgW0z7PFP3mggt4s
         d1rqPRCDI6CFw26IDlph7ocwW7reOawUilNKXDzE2jSLGKLnTJrlIgaciOrn3YqAsZT4
         RlF+AStLTPP/0+nzlJ6uUJEDvHO3hDE25crKwZl/n45cX3dD00Zx57WpvPjMHxFgwLYd
         A7csDA5t+zrw+6GNcNWitluJPeofj7DOd5Hgtuz7LA21/NJGtvsggiOeyuCaHAApjjoX
         lyfg==
X-Gm-Message-State: AOJu0Ywqh8V2n/HyGWzw7kb3HVN9RqyhW4NoZKVKSzsDY2X+mohR+N3/
        gqtRlk7G5hicBzyUO+ennWkZ/baUmmZESpArSWZvWOGE7GkuNCw=
X-Google-Smtp-Source: AGHT+IFzNrb3oSbdPtcBn+Feuy08YaFOUfQPKUnQYjEt7iuwyjdwxXHv+M0fzXDrYfnHLexEzMV4Y3QPXUEeblMnHSLxVdCc5KSY
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3914:b0:1fa:f1fc:f655 with SMTP id
 b20-20020a056870391400b001faf1fcf655mr4442641oap.7.1702269665644; Sun, 10 Dec
 2023 20:41:05 -0800 (PST)
Date:   Sun, 10 Dec 2023 20:41:05 -0800
In-Reply-To: <20231211042442.1442601-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb959e060c348a5c@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in radix_tree_insert

RBP: 00007fe1bdd63120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007fe1bd19bf80 R15: 00007ffff40ae278
 </TASK>
nc: 0000000000000000
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11abdb067 P4D 11abdb067 PUD 11a311067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 5752 Comm: syz-executor.0 Not tainted 6.7.0-rc4-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:radix_tree_descend lib/radix-tree.c:88 [inline]
RIP: 0010:__radix_tree_create lib/radix-tree.c:655 [inline]
RIP: 0010:radix_tree_insert+0x379/0x400 lib/radix-tree.c:730
Code: ba 89 fc 89 de 44 89 ef e8 54 b3 89 fc 41 39 dd 73 6e e8 ea ba 89 fc 4c 8b 7c 24 10 4c 89 f0 41 83 c5 06 48 c7 c7 b5 cf a7 85 <41> 0f b6 0f 48 d3 e8 83 e0 3f 48 83 c0 04 49 8b 5c c7 08 48 89 de
RSP: 0018:ffffc900049d3c18 EFLAGS: 00010202
RAX: fffffffffffffffe RBX: 0000000000000042 RCX: ffffffff84b526dc
RDX: ffff888106cc0000 RSI: ffffffff84b526e6 RDI: ffffffff85a7cfb5
RBP: 000000000000003f R08: 0000000000000004 R09: 0000000000000024
R10: 0000000000000042 R11: 205d323537355420 R12: ffff88810b7746d8
R13: 000000000000002a R14: fffffffffffffffe R15: 0000000000000000
FS:  00007fe1bdd636c0(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000011ae79000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
 qrtr_node_enqueue+0x57d/0x630 net/qrtr/af_qrtr.c:348
 qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:891
 qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:992
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x52/0xa0 net/socket.c:745
 sock_write_iter+0xfb/0x180 net/socket.c:1158
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x327/0x590 fs/read_write.c:584
 ksys_write+0x13b/0x170 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe1bd07cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe1bdd630c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe1bd19bf80 RCX: 00007fe1bd07cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fe1bdd63120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007fe1bd19bf80 R15: 00007ffff40ae278
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:radix_tree_descend lib/radix-tree.c:88 [inline]
RIP: 0010:__radix_tree_create lib/radix-tree.c:655 [inline]
RIP: 0010:radix_tree_insert+0x379/0x400 lib/radix-tree.c:730
Code: ba 89 fc 89 de 44 89 ef e8 54 b3 89 fc 41 39 dd 73 6e e8 ea ba 89 fc 4c 8b 7c 24 10 4c 89 f0 41 83 c5 06 48 c7 c7 b5 cf a7 85 <41> 0f b6 0f 48 d3 e8 83 e0 3f 48 83 c0 04 49 8b 5c c7 08 48 89 de
RSP: 0018:ffffc900049d3c18 EFLAGS: 00010202
RAX: fffffffffffffffe RBX: 0000000000000042 RCX: ffffffff84b526dc
RDX: ffff888106cc0000 RSI: ffffffff84b526e6 RDI: ffffffff85a7cfb5
RBP: 000000000000003f R08: 0000000000000004 R09: 0000000000000024
R10: 0000000000000042 R11: 205d323537355420 R12: ffff88810b7746d8
R13: 000000000000002a R14: fffffffffffffffe R15: 0000000000000000
FS:  00007fe1bdd636c0(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000011ae79000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	ba 89 fc 89 de       	mov    $0xde89fc89,%edx
   5:	44 89 ef             	mov    %r13d,%edi
   8:	e8 54 b3 89 fc       	call   0xfc89b361
   d:	41 39 dd             	cmp    %ebx,%r13d
  10:	73 6e                	jae    0x80
  12:	e8 ea ba 89 fc       	call   0xfc89bb01
  17:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
  1c:	4c 89 f0             	mov    %r14,%rax
  1f:	41 83 c5 06          	add    $0x6,%r13d
  23:	48 c7 c7 b5 cf a7 85 	mov    $0xffffffff85a7cfb5,%rdi
* 2a:	41 0f b6 0f          	movzbl (%r15),%ecx <-- trapping instruction
  2e:	48 d3 e8             	shr    %cl,%rax
  31:	83 e0 3f             	and    $0x3f,%eax
  34:	48 83 c0 04          	add    $0x4,%rax
  38:	49 8b 5c c7 08       	mov    0x8(%r15,%rax,8),%rbx
  3d:	48 89 de             	mov    %rbx,%rsi


Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1263f02ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14707d0ae80000

