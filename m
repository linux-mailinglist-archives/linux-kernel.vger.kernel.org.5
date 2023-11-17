Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1B7EF19A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjKQLVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbjKQLVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:21:10 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25923194
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:21:06 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ce5bad4515so10452495ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220065; x=1700824865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcSvppJtdA553ODVyRJNvFWaDMxzJXchcZ1GuyL+NVc=;
        b=ZlQM4i8NJ5AnC7sbwMCuawZMRc0Fy37y7iQo3Rfx/GKpFr2x5RFVNGvqmRycyUaff2
         oC3CYiW+jb6MSwSRmEIB3WJN9LQyBLq9Zy/DgJHPD2JC0riV7iWpH0cgrUlxWIQ2ICvb
         leCZDo9nQUmXcTBKd3XhbdA33AoFOz2ZbXROvHpVBwpcpSeMETiFOv9wOYjSo/71oSuT
         oJJ2e5HTWpurVLgDwMW0+wvL3r3twAVooKaHRNYbU/8tj7H7BIdzFO32U4rpcmx6BqiH
         0HscDwIHF6o7THe4e5dJvnV/lKl/rwWobmuYPplgW7dlEu0RvqzkuMEefeH01OAUMcnC
         pw/w==
X-Gm-Message-State: AOJu0YxNecnlFFQiEoJDWgrKKPHmyDjQpJcccnkZV2as9ZUcdu45/1gH
        gJbWUk7yAHGOuxkgov5b6XWivADewq+wvQ4qwTvJ9mMEF1SjzAU=
X-Google-Smtp-Source: AGHT+IEUc3j1vpmQ3fBHTppP7tX/EUSHYjSEmvBIACdFWClzrCaF5UY7yT8alCvZ5Xr/nqokYuFtguRPyWIF2CEg4ZT+lAVbvg7Z
MIME-Version: 1.0
X-Received: by 2002:a17:903:451:b0:1cc:229a:89f7 with SMTP id
 iw17-20020a170903045100b001cc229a89f7mr2841952plb.5.1700220065702; Fri, 17
 Nov 2023 03:21:05 -0800 (PST)
Date:   Fri, 17 Nov 2023 03:21:05 -0800
In-Reply-To: <CAJjsb4q_f5EL64d-Cuipk0Vr9aqK2-NtV_NToMnx67yDdxzydg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e6813060a5755f1@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_mmu_notifier_invalidate_range_start
 (3)
From:   syzbot <syzbot+c74f40907a9c0479af10@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
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
WARNING in kvm_mmu_notifier_invalidate_range_start

kvm_intel: L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5493 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:592 __kvm_handle_hva_range arch/x86/kvm/../../../virt/kvm/kvm_main.c:592 [inline]
WARNING: CPU: 1 PID: 5493 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:592 kvm_mmu_notifier_invalidate_range_start+0x91b/0xa90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:811
Modules linked in:
CPU: 1 PID: 5493 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-00125-g7475e51b8796 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__kvm_handle_hva_range arch/x86/kvm/../../../virt/kvm/kvm_main.c:592 [inline]
RIP: 0010:kvm_mmu_notifier_invalidate_range_start+0x91b/0xa90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:811
Code: 1b 8c 7e 00 45 84 e4 0f 85 9f f8 ff ff e8 dd 90 7e 00 0f 0b e9 93 f8 ff ff e8 d1 90 7e 00 0f 0b e9 d9 fd ff ff e8 c5 90 7e 00 <0f> 0b e9 e6 fc ff ff e8 b9 90 7e 00 0f 0b e9 a9 fc ff ff e8 ad 90
RSP: 0018:ffffc900053a7ac8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000020ffc000 RCX: ffffffff810a0d7b
RDX: ffff88802a5f3b80 RSI: ffffffff810a141b RDI: 0000000000000006
RBP: ffffc900053a7d60 R08: 0000000000000006 R09: 0000000020ffc000
R10: 0000000020ffc000 R11: ffffffff9160a110 R12: ffffc90002de6a30
R13: 0000000000000001 R14: 0000000020ffc000 R15: ffffc90002def810
FS:  00007fd41f5c36c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd41f5c2f78 CR3: 0000000020bf3000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mn_hlist_invalidate_range_start mm/mmu_notifier.c:493 [inline]
 __mmu_notifier_invalidate_range_start+0x3b5/0x8e0 mm/mmu_notifier.c:548
 mmu_notifier_invalidate_range_start include/linux/mmu_notifier.h:457 [inline]
 do_pagemap_scan+0xbd3/0xcc0 fs/proc/task_mmu.c:2422
 do_pagemap_cmd+0x5e/0x80 fs/proc/task_mmu.c:2478
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fd41e87cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd41f5c30c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd41e99bf80 RCX: 00007fd41e87cae9
RDX: 0000000020000040 RSI: 00000000c0606610 RDI: 0000000000000005
RBP: 00007fd41e8c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd41e99bf80 R15: 00007ffeb2042478
 </TASK>


Tested on:

commit:         7475e51b Merge tag 'net-6.7-rc2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=151eb384e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8be8f62c2cfe457
dashboard link: https://syzkaller.appspot.com/bug?extid=c74f40907a9c0479af10
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
