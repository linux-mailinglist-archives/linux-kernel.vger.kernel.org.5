Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7A7EBF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjKOJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjKOJe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:34:27 -0500
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFDF9B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:34:23 -0800 (PST)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-2804a04e233so470472a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700040863; x=1700645663;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/t0lEw3p/vZO05YnEwKgHGluUWWfn7aL9x+C3DpAhTc=;
        b=luQp2rj9ZfkPie1wpf3I0iTSGnX4E8ksukhX1HpideX/P9CcoBUTqUwrrB9G+J0mhx
         eI8x0LS3OI4JfRimEaL0K6FEBVYasNypkXHau/88w5paPy6H6nRH0EhKMyCFQoRD36sA
         0YOkX8REgljHL+Z2MCXBKubw4itUMyckiSyg75TQahqePpJ9XR19c4Z1Hm/kVB+TqADD
         au0kXUQLNfEYazY2rjoAMiafIg8KhulC3fP6biNLXF188vNA83AwqqyT+ProEbskXZrx
         Ly9OfEywpBREHyG9K4Xx/RMOHTJGOvKadn+UalOTM5+4BzKti+EvBFR8SBN3UvZlAT86
         BGkw==
X-Gm-Message-State: AOJu0YybKB9d/jDEsRWUodgQwIhOya0EFpb2PcZraoytSaujGENYQdoZ
        Q5f7SU7gp9SqDJEl/Y0iL2kbmPrjJUr4p1C/Jhgn73B19c2u
X-Google-Smtp-Source: AGHT+IFvMfMDmr6cezYAA1mQANi5q/XcWzxQSsZnPDcV9zeLVrAXbSKZPYCR8jzzMhlbmid/RnmEct3DGCDIa40MGx8hKaUWLZgC
MIME-Version: 1.0
X-Received: by 2002:a17:90a:f416:b0:27d:466:6c23 with SMTP id
 ch22-20020a17090af41600b0027d04666c23mr3730091pjb.3.1700040863056; Wed, 15
 Nov 2023 01:34:23 -0800 (PST)
Date:   Wed, 15 Nov 2023 01:34:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf0b1f060a2d9bea@google.com>
Subject: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     airlied@gmail.com, airlied@linux.ie, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
        mripard@kernel.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac347a0655db Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=101ba588e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11252f97680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fd2498e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8fcb90d89768/disk-ac347a06.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/360d9341a71c/vmlinux-ac347a06.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a370aa406c63/bzImage-ac347a06.xz

The issue was bisected to:

commit ea40d7857d5250e5400f38c69ef9e17321e9c4a2
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri Oct 9 23:21:56 2020 +0000

    drm/vkms: fbdev emulation support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1058223f680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1258223f680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1458223f680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com
Fixes: ea40d7857d52 ("drm/vkms: fbdev emulation support")

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5068 Comm: syz-executor357 Not tainted 6.6.0-syzkaller-16039-gac347a0655db #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:drm_mode_vrefresh drivers/gpu/drm/drm_modes.c:1303 [inline]
RIP: 0010:drm_mode_debug_printmodeline+0x118/0x4e0 drivers/gpu/drm/drm_modes.c:60
Code: 00 41 0f b7 07 66 83 f8 02 b9 01 00 00 00 0f 43 c8 0f b7 c1 0f af e8 44 89 f0 48 69 c8 e8 03 00 00 89 e8 d1 e8 48 01 c8 31 d2 <48> f7 f5 49 89 c6 eb 0c e8 fb 07 66 fc eb 05 e8 f4 07 66 fc 48 89
RSP: 0018:ffffc9000391f8d0 EFLAGS: 00010246
RAX: 000000000001f400 RBX: ffff888025045000 RCX: 000000000001f400
RDX: 0000000000000000 RSI: 0000000000008000 RDI: ffff888025045018
RBP: 0000000000000000 R08: ffffffff8528b9af R09: 0000000000000000
R10: ffffc9000391f8a0 R11: fffff52000723f17 R12: 0000000000000080
R13: dffffc0000000000 R14: 0000000000000080 R15: ffff888025045016
FS:  0000555556932380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007fcff000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_mode_setcrtc+0x83b/0x1880 drivers/gpu/drm/drm_crtc.c:794
 drm_ioctl_kernel+0x362/0x500 drivers/gpu/drm/drm_ioctl.c:792
 drm_ioctl+0x636/0xb00 drivers/gpu/drm/drm_ioctl.c:895
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6c63dd6729
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcde0dd0e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffcde0dd2b8 RCX: 00007f6c63dd6729
RDX: 0000000020000180 RSI: 00000000c06864a2 RDI: 0000000000000003
RBP: 00007f6c63e49610 R08: 00000000fffff4e6 R09: 00007ffcde0dd2b8
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcde0dd2a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:drm_mode_vrefresh drivers/gpu/drm/drm_modes.c:1303 [inline]
RIP: 0010:drm_mode_debug_printmodeline+0x118/0x4e0 drivers/gpu/drm/drm_modes.c:60
Code: 00 41 0f b7 07 66 83 f8 02 b9 01 00 00 00 0f 43 c8 0f b7 c1 0f af e8 44 89 f0 48 69 c8 e8 03 00 00 89 e8 d1 e8 48 01 c8 31 d2 <48> f7 f5 49 89 c6 eb 0c e8 fb 07 66 fc eb 05 e8 f4 07 66 fc 48 89
RSP: 0018:ffffc9000391f8d0 EFLAGS: 00010246
RAX: 000000000001f400 RBX: ffff888025045000 RCX: 000000000001f400
RDX: 0000000000000000 RSI: 0000000000008000 RDI: ffff888025045018
RBP: 0000000000000000 R08: ffffffff8528b9af R09: 0000000000000000
R10: ffffc9000391f8a0 R11: fffff52000723f17 R12: 0000000000000080
R13: dffffc0000000000 R14: 0000000000000080 R15: ffff888025045016
FS:  0000555556932380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000064392c CR3: 000000007fcff000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 41 0f             	add    %al,0xf(%rcx)
   3:	b7 07                	mov    $0x7,%bh
   5:	66 83 f8 02          	cmp    $0x2,%ax
   9:	b9 01 00 00 00       	mov    $0x1,%ecx
   e:	0f 43 c8             	cmovae %eax,%ecx
  11:	0f b7 c1             	movzwl %cx,%eax
  14:	0f af e8             	imul   %eax,%ebp
  17:	44 89 f0             	mov    %r14d,%eax
  1a:	48 69 c8 e8 03 00 00 	imul   $0x3e8,%rax,%rcx
  21:	89 e8                	mov    %ebp,%eax
  23:	d1 e8                	shr    %eax
  25:	48 01 c8             	add    %rcx,%rax
  28:	31 d2                	xor    %edx,%edx
* 2a:	48 f7 f5             	div    %rbp <-- trapping instruction
  2d:	49 89 c6             	mov    %rax,%r14
  30:	eb 0c                	jmp    0x3e
  32:	e8 fb 07 66 fc       	call   0xfc660832
  37:	eb 05                	jmp    0x3e
  39:	e8 f4 07 66 fc       	call   0xfc660832
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
