Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30C87E82E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjKJTkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjKJTjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:39:47 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75EA3AE3F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:38:04 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc2a0c7c6cso22510655ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699630684; x=1700235484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ur/WIJSmfPyJzvii2xW+yxcTVmdevk5HaQf1vEB1c9U=;
        b=LbbEgFBCu0MKjlqvelK2UJuL5pNp0ne1Rz/JlPjKstOwnQ/+gxAUNs+1XUABUJ4Vqm
         0BhKIoZzCtwJdkGDVdUY9Upo78Pr//tGmEQ5kYia/+ohPpNx2L8g87J35y4mSRf79nPM
         yFLdTnIbbTbyWOewIzgr4TwS9lme2wbve9xS8zTd4J+0ZjFCZeqcSmvhbxRVM75gv4X/
         eVhJYNdG24Gxzid2tND9dIhqY3FONki8gSleqo01tblwgiXpM1i/MLLhiColrjwQub21
         qbzgmNgqnQBWYvaNBeQN3aC7Qb81JOeVw1Dp2/Et1Sl025koSseGt6arcDbym1XqynhA
         QcYg==
X-Gm-Message-State: AOJu0Yz2Va6khtCoKsUVuzsLh/zVj8qbObus26SJuctfnlatVyphIeID
        uGxGJ2/+cucf2TLkdpi3BU9K82oYannHoj1WIE0OLXultB6TXt0=
X-Google-Smtp-Source: AGHT+IG37jRbI9e49RJzeV69FmIrTK6cJ5DirCOs7ob1AAHNC1y0D6W4rEyxjBy8yK4hV0QUmaMDXWeiJ1QoX3q9/guaEoTMhD6N
MIME-Version: 1.0
X-Received: by 2002:a17:902:efc1:b0:1cc:56cc:787e with SMTP id
 ja1-20020a170902efc100b001cc56cc787emr1335805plb.4.1699630684287; Fri, 10 Nov
 2023 07:38:04 -0800 (PST)
Date:   Fri, 10 Nov 2023 07:38:04 -0800
In-Reply-To: <GV1PR10MB656399107C3F56D67CBE65C2E8AEA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fbb830609ce1b6b@google.com>
Subject: Re: [syzbot] [usb] kernel BUG in __page_table_check_zero
From:   syzbot <syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
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
kernel BUG in __page_table_check_zero

RBP: 00007f6cf0ffe120 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000011012 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007f6cf1d9bf80 R15: 00007ffc98ff0338
 </TASK>
==> if* vma_use_count 1
------------[ cut here ]------------
kernel BUG at mm/page_table_check.c:146!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5467 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-15859-g89cdf9d55601-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__page_table_check_zero+0x2d5/0x4a0 mm/page_table_check.c:146
Code: 98 ff 48 ff cb e9 b5 fd ff ff e8 e6 9f 98 ff 48 ff cb e9 27 fe ff ff e8 d9 9f 98 ff 0f 0b e8 d2 9f 98 ff 0f 0b e8 cb 9f 98 ff <0f> 0b f3 0f 1e fa 4c 89 f6 48 81 e6 ff 0f 00 00 31 ff e8 f4 a3 98
RSP: 0018:ffffc900049f7800 EFLAGS: 00010293
RAX: ffffffff81f620c5 RBX: dffffc0000000000 RCX: ffff8880263f1dc0
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880160ea044
RBP: ffff8880160ea044 R08: ffff8880160ea047 R09: 1ffff11002c1d408
R10: dffffc0000000000 R11: ffffed1002c1d409 R12: 0000000000000000
R13: 1ffffffff243299c R14: 000000000000000a R15: ffff8880160ea000
FS:  00007f6cf0ffe6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f9eb7b1680 CR3: 000000001d34c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_table_check_free include/linux/page_table_check.h:41 [inline]
 free_pages_prepare mm/page_alloc.c:1138 [inline]
 __free_pages_ok+0xc43/0xd70 mm/page_alloc.c:1267
 dec_usb_memory_use_count+0x259/0x350 drivers/usb/core/devio.c:198
 usbdev_mmap+0x89e/0x9d0
 call_mmap include/linux/fs.h:2025 [inline]
 mmap_region+0xef2/0x2240 mm/mmap.c:2851
 do_mmap+0x8d3/0xfa0 mm/mmap.c:1379
 vm_mmap_pgoff+0x1dc/0x410 mm/util.c:546
 ksys_mmap_pgoff+0x4ff/0x6d0 mm/mmap.c:1425
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6cf1c7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6cf0ffe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f6cf1d9bf80 RCX: 00007f6cf1c7cae9
RDX: 0000000001000002 RSI: 0000000000400000 RDI: 0000000020000000
RBP: 00007f6cf0ffe120 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000011012 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007f6cf1d9bf80 R15: 00007ffc98ff0338
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__page_table_check_zero+0x2d5/0x4a0 mm/page_table_check.c:146
Code: 98 ff 48 ff cb e9 b5 fd ff ff e8 e6 9f 98 ff 48 ff cb e9 27 fe ff ff e8 d9 9f 98 ff 0f 0b e8 d2 9f 98 ff 0f 0b e8 cb 9f 98 ff <0f> 0b f3 0f 1e fa 4c 89 f6 48 81 e6 ff 0f 00 00 31 ff e8 f4 a3 98
RSP: 0018:ffffc900049f7800 EFLAGS: 00010293
RAX: ffffffff81f620c5 RBX: dffffc0000000000 RCX: ffff8880263f1dc0
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880160ea044
RBP: ffff8880160ea044 R08: ffff8880160ea047 R09: 1ffff11002c1d408
R10: dffffc0000000000 R11: ffffed1002c1d409 R12: 0000000000000000
R13: 1ffffffff243299c R14: 000000000000000a R15: ffff8880160ea000
FS:  00007f6cf0ffe6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f9eb7b1680 CR3: 000000001d34c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         89cdf9d5 Merge tag 'net-6.7-rc1' of git://git.kernel.o..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=107ab1c0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=97c84b399d02b00b
dashboard link: https://syzkaller.appspot.com/bug?extid=7a9bbb158a7a1071eb27
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f7a747680000

