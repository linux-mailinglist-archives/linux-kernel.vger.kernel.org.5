Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B577ED8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjKPBYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPBYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:24:10 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F80192
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:24:07 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c1b986082dso279180a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700097846; x=1700702646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxwfkTeqohgRH1gvD6XBl8wbCsBiX6e3IzoyuyGWZUk=;
        b=eueBpSMet7Ei1Vzhq0h7Ia2lqkJRtBmPXWnP8vJZwmhXWs23k7gA/Z6POcPItFqJL6
         TDAAlHvdtTHCureemQiaGraslaeVPa3GSmvgp04NDsWh9el0UzuU2T2J1kaOMJGSBJFV
         5qKfOAYO+p6Ua3S+8YhJ05OvacRPxWeVewmOWLqEvT9liB1UcQv0q1PLxUfe03JqkJ92
         tNpDDj35thvCiaOHFJWZfpiEgwURnGGpZRB6u/az+8k55GBAvTaRFjDmGptcVdZ9uUxU
         50YASrxkGr+eihYJ5WJa7lwDdFGRhokMG34Z6DHnOUUfBsyDF3u/x5/GzHL+Aqso0zBr
         P/hA==
X-Gm-Message-State: AOJu0Yymn31IOu/2CxG9pwSgRvYMFD8W++Pz0+8qbN5C9qIirmIHzcPY
        FgUrmZGF5mSNsz7aJUxlttAouCIz9CFvQxooEQMTrjON7B6FI7g=
X-Google-Smtp-Source: AGHT+IHh02ioEk+czNkgT+NCmYy1ukuFIEk4V01hrsyafb2oezk0/CBZ05YhMp0ZMDU5QY/QcDoid8MPCClN4TBwSnWTfiyFwsqu
MIME-Version: 1.0
X-Received: by 2002:a65:520a:0:b0:578:a62b:56ec with SMTP id
 o10-20020a65520a000000b00578a62b56ecmr30372pgp.5.1700097846604; Wed, 15 Nov
 2023 17:24:06 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:24:06 -0800
In-Reply-To: <20231116005155.2180143-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003afd1c060a3ae082@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
divide error in drm_mode_debug_printmodeline

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5480 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-16039-gac347a0655db-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:drm_mode_vrefresh drivers/gpu/drm/drm_modes.c:1303 [inline]
RIP: 0010:drm_mode_debug_printmodeline+0x129/0x530 drivers/gpu/drm/drm_modes.c:60
Code: 66 83 f8 02 b9 01 00 00 00 0f 43 c8 0f b7 c1 48 0f af e8 44 89 f0 48 69 c8 e8 03 00 00 48 89 e8 48 d1 e8 48 01 c8 89 e9 31 d2 <48> f7 f1 49 89 c0 eb 0f e8 aa 07 66 fc eb 05 e8 a3 07 66 fc 45 31
RSP: 0018:ffffc9000566f8d0 EFLAGS: 00010246
RAX: 000000008001f400 RBX: ffff88802787f400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000100000000 R08: ffffffff8528ba49 R09: 0000000000000000
R10: ffffc9000566f8a0 R11: fffff52000acdf17 R12: 0000000000000080
R13: dffffc0000000000 R14: 0000000000000080 R15: ffff88802787f416
FS:  00007f4ac5a236c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4ac4d980c0 CR3: 0000000072607000 CR4: 00000000003506f0
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
RIP: 0033:0x7f4ac4c7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4ac5a230c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4ac4d9bf80 RCX: 00007f4ac4c7cae9
RDX: 0000000020000180 RSI: 00000000c06864a2 RDI: 0000000000000003
RBP: 00007f4ac4cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4ac4d9bf80 R15: 00007ffc9a805758
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:drm_mode_vrefresh drivers/gpu/drm/drm_modes.c:1303 [inline]
RIP: 0010:drm_mode_debug_printmodeline+0x129/0x530 drivers/gpu/drm/drm_modes.c:60
Code: 66 83 f8 02 b9 01 00 00 00 0f 43 c8 0f b7 c1 48 0f af e8 44 89 f0 48 69 c8 e8 03 00 00 48 89 e8 48 d1 e8 48 01 c8 89 e9 31 d2 <48> f7 f1 49 89 c0 eb 0f e8 aa 07 66 fc eb 05 e8 a3 07 66 fc 45 31
RSP: 0018:ffffc9000566f8d0 EFLAGS: 00010246
RAX: 000000008001f400 RBX: ffff88802787f400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000100000000 R08: ffffffff8528ba49 R09: 0000000000000000
R10: ffffc9000566f8a0 R11: fffff52000acdf17 R12: 0000000000000080
R13: dffffc0000000000 R14: 0000000000000080 R15: ffff88802787f416
FS:  00007f4ac5a236c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd5ec1c008 CR3: 0000000072607000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	66 83 f8 02          	cmp    $0x2,%ax
   4:	b9 01 00 00 00       	mov    $0x1,%ecx
   9:	0f 43 c8             	cmovae %eax,%ecx
   c:	0f b7 c1             	movzwl %cx,%eax
   f:	48 0f af e8          	imul   %rax,%rbp
  13:	44 89 f0             	mov    %r14d,%eax
  16:	48 69 c8 e8 03 00 00 	imul   $0x3e8,%rax,%rcx
  1d:	48 89 e8             	mov    %rbp,%rax
  20:	48 d1 e8             	shr    %rax
  23:	48 01 c8             	add    %rcx,%rax
  26:	89 e9                	mov    %ebp,%ecx
  28:	31 d2                	xor    %edx,%edx
* 2a:	48 f7 f1             	div    %rcx <-- trapping instruction
  2d:	49 89 c0             	mov    %rax,%r8
  30:	eb 0f                	jmp    0x41
  32:	e8 aa 07 66 fc       	call   0xfc6607e1
  37:	eb 05                	jmp    0x3e
  39:	e8 a3 07 66 fc       	call   0xfc6607e1
  3e:	45                   	rex.RB
  3f:	31                   	.byte 0x31


Tested on:

commit:         ac347a06 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=104993e0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=111d4b97680000

