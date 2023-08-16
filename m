Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3330677E710
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbjHPQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344995AbjHPQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:56:57 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1786BE4C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:56:56 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-564fa3b49e1so59496a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205015; x=1692809815;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pq13cnJasbv8djRVhp2bcs4ZOGirzCWQ2VqEdvLtad0=;
        b=lTfkcWU4kcwPCFtuT9asir66q9V5JLbsxwrQSyo+vLZFCk9A618T3hmbMSuHRpnOA7
         66NuIHfz+/M71MBMwJz1GONy0+fnQs7CELNo/beWp7a9it0CwIJlIhYcDG4YTK9VOrWz
         XHr3lYAUdWFGgr+hvuOFNh4yHTDl4fVTy2svyXTl1tAA9RqP6JfP2CFNfUcGeKbHNtAg
         noV6ey9HbIl6EqKiJNF21lZQcn5vJA8E63IigaovKZrbYCv5Bi175NhkZa29wJuBRQfu
         m92dTDbhtQp2T63hPTaVV1jWnuRSScSFRyJK6XtUNyGOr/dBcphJuLi0Y5JVXxekOmKt
         6aXw==
X-Gm-Message-State: AOJu0YxhCqlonqcYhLdUR+2SB5zGIYR2oPSlu4XiCrbuvIqbD+mmDzej
        /YwBMBR5nX9E6sQmfm93OfvSuQP4ZDsdiWJlDoi2qm5vN1ib
X-Google-Smtp-Source: AGHT+IEzrcEQMA/8GvXNSdJnOKOmvEiOw3JdXZVzOWtetW/oNG4rKu0vEHo8zF4ovFoHFb1m9to9roX1OJENtH9dzJn6bMJr7bI7
MIME-Version: 1.0
X-Received: by 2002:a63:ee4b:0:b0:565:ed29:8244 with SMTP id
 n11-20020a63ee4b000000b00565ed298244mr24838pgk.3.1692205015582; Wed, 16 Aug
 2023 09:56:55 -0700 (PDT)
Date:   Wed, 16 Aug 2023 09:56:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d74dd506030d2e4b@google.com>
Subject: [syzbot] [mm?] kernel BUG in do_page_mkwrite
From:   syzbot <syzbot+cfba1abcb2cf7b39a320@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, javierm@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, richardcochran@gmail.com,
        suijingfeng@loongson.cn, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de, zackr@vmware.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2ccdd1b13c59 Linux 6.5-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=143b6d3ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fc59e2140295873
dashboard link: https://syzkaller.appspot.com/bug?extid=cfba1abcb2cf7b39a320
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1032446ba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16576b4fa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e6e598627dd6/disk-2ccdd1b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/486c6739d779/vmlinux-2ccdd1b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5da0f3ac1d56/bzImage-2ccdd1b1.xz

The issue was bisected to:

commit a5b44c4adb1699661d22e5152fb26885f30a2e4c
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Mon Mar 20 15:07:44 2023 +0000

    drm/fbdev-generic: Always use shadow buffering

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11349b73a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13349b73a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=15349b73a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cfba1abcb2cf7b39a320@syzkaller.appspotmail.com
Fixes: a5b44c4adb16 ("drm/fbdev-generic: Always use shadow buffering")

 vm_area_alloc_pages mm/vmalloc.c:3059 [inline]
 __vmalloc_area_node mm/vmalloc.c:3135 [inline]
 __vmalloc_node_range+0xa6e/0x1540 mm/vmalloc.c:3316
 __vmalloc_node mm/vmalloc.c:3381 [inline]
 vzalloc+0x6b/0x80 mm/vmalloc.c:3454
 drm_fbdev_generic_helper_fb_probe+0x300/0x6d0 drivers/gpu/drm/drm_fbdev_generic.c:97
 drm_fb_helper_single_fb_probe drivers/gpu/drm/drm_fb_helper.c:1668 [inline]
 __drm_fb_helper_initial_config_and_unlock+0xc31/0x1600 drivers/gpu/drm/drm_fb_helper.c:1846
 drm_fb_helper_initial_config drivers/gpu/drm/drm_fb_helper.c:1936 [inline]
 drm_fb_helper_initial_config+0x44/0x60 drivers/gpu/drm/drm_fb_helper.c:1928
 drm_fbdev_generic_client_hotplug+0x1a7/0x270 drivers/gpu/drm/drm_fbdev_generic.c:280
 drm_client_register+0x195/0x280 drivers/gpu/drm/drm_client.c:149
 drm_fbdev_generic_setup+0x11c/0x330 drivers/gpu/drm/drm_fbdev_generic.c:342
 vkms_create drivers/gpu/drm/vkms/vkms_drv.c:208 [inline]
 vkms_init+0x625/0x760 drivers/gpu/drm/vkms/vkms_drv.c:234
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5bd/0x8f0 init/main.c:1546
page_owner free stack trace missing
------------[ cut here ]------------
kernel BUG at mm/memory.c:2955!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5026 Comm: syz-executor380 Not tainted 6.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:do_page_mkwrite+0x468/0x680 mm/memory.c:2955
Code: de e8 cc 15 c2 ff 84 db 0f 85 c1 00 00 00 48 89 eb e9 76 fe ff ff e8 87 1a c2 ff 48 c7 c6 a0 b3 78 8a 48 89 ef e8 78 3d fe ff <0f> 0b 41 bc 02 00 00 00 e9 99 fe ff ff e8 66 1a c2 ff be d0 03 00
RSP: 0018:ffffc900030efba8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888079cec200 RSI: ffffffff81c30648 RDI: ffffffff8ac7eec0
RBP: ffffea0005007780 R08: 0000000000000000 R09: fffffbfff1d55d7a
R10: ffffffff8eaaebd7 R11: 0000000000000001 R12: 0000000000000200
R13: ffffea0005007780 R14: 0000000000000a55 R15: 0000000000000000
FS:  0000555557128380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb85a07fe08 CR3: 0000000023b67000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 wp_page_shared mm/memory.c:3294 [inline]
 do_wp_page+0x3a0/0x3710 mm/memory.c:3376
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x1af7/0x3b80 mm/memory.c:5079
 handle_mm_fault+0x2ab/0x9d0 mm/memory.c:5233
 do_user_addr_fault+0x446/0xfc0 arch/x86/mm/fault.c:1392
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x5c/0xd0 arch/x86/mm/fault.c:1542
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7fb859ff27a0
Code: 00 41 b8 11 80 02 00 b9 06 00 00 01 ba 00 60 b3 00 be 00 00 00 20 bf 09 00 00 00 31 c0 48 c7 04 24 00 c0 2f 00 e8 30 fc 02 00 <c6> 04 25 08 00 00 20 00 45 31 c0 48 b8 2f 64 65 76 2f 66 62 30 b9
RSP: 002b:00007ffeec409b10 EFLAGS: 00010217
RAX: 0000000020000000 RBX: 00007ffeec409ce8 RCX: 00007fb85a0223e9
RDX: 0000000001000006 RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007fb85a095610 R08: 0000000000000004 R09: 00000000002fc000
R10: 0000000000028011 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffeec409cd8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_page_mkwrite+0x468/0x680 mm/memory.c:2955
Code: de e8 cc 15 c2 ff 84 db 0f 85 c1 00 00 00 48 89 eb e9 76 fe ff ff e8 87 1a c2 ff 48 c7 c6 a0 b3 78 8a 48 89 ef e8 78 3d fe ff <0f> 0b 41 bc 02 00 00 00 e9 99 fe ff ff e8 66 1a c2 ff be d0 03 00
RSP: 0018:ffffc900030efba8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888079cec200 RSI: ffffffff81c30648 RDI: ffffffff8ac7eec0
RBP: ffffea0005007780 R08: 0000000000000000 R09: fffffbfff1d55d7a
R10: ffffffff8eaaebd7 R11: 0000000000000001 R12: 0000000000000200
R13: ffffea0005007780 R14: 0000000000000a55 R15: 0000000000000000
FS:  0000555557128380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb85a07fe08 CR3: 0000000023b67000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
