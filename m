Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43107792CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbjIERzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbjIERzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:55:31 -0400
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1452691
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:46:05 -0700 (PDT)
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-573452f333dso2528189eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 10:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693935900; x=1694540700;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JC4emxi/+91e6/de8rNAFQ4RT3D4NiRRQ3Rn+uvpGxs=;
        b=SaYpLeC322WdiTkU3ybkzAIiQU++vSoM5RdaFphGps44bBvfMc7mCpG3QJx8kGF9wi
         Y/se6Cl+innMb4+sNASXjA/hhqKjyZuoLOhdPzw0C6sbV7JWUWfvwOAXLIwmruEQ66+3
         Tc3VrSaFjYu6bgxIDa6WAsvPSYItGIHemHxR7Z9Tm8QKsVsa4WSI2CF/7HsIVnZQPdS2
         9NJi3JFdHEYXsL2T0930ErxBZ9k+v6PN646StT7wplpmeNitLDde3MXJVVO5eLtKcpli
         CEUs3wACnshjiZGL3A0LvcYD4ZlEHuWmSVIVolsDm0gAeNAK7nr59LO9rsQM1qUViYjR
         JPEQ==
X-Gm-Message-State: AOJu0YyZ7uC4/HBigETi3g6MeDz2mmHbx63Rx/0Zh4e9zgYdDKt6JlXR
        69sAaGvr17Af9dTtmaw9Fw05jy6l1rbqNkXFhoRv7WiD0fq9
X-Google-Smtp-Source: AGHT+IHVoTWcD6YUsfA9tfQOyJ0G1pEtnNjMqA02rEokMU4PiBHYiHZgMjHt0KwxaTfuqqvt1Y/Tilb/0X/B7+9cJlCiEdn4ZbNA
MIME-Version: 1.0
X-Received: by 2002:a17:90b:8c:b0:26b:b78:c94f with SMTP id
 bb12-20020a17090b008c00b0026b0b78c94fmr3267961pjb.7.1693935364108; Tue, 05
 Sep 2023 10:36:04 -0700 (PDT)
Date:   Tue, 05 Sep 2023 10:36:03 -0700
In-Reply-To: <000000000000273d0105ff97bf56@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a677fc0604a00fef@google.com>
Subject: Re: [syzbot] [mm?] WARNING in try_grab_page
From:   syzbot <syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, davem@davemloft.net,
        david@redhat.com, dhowells@redhat.com, edumazet@google.com,
        gregkh@linuxfoundation.org, herbert@gondor.apana.org.au,
        jlayton@kernel.org, kuba@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nspmangalore@gmail.com, pabeni@redhat.com, patches@lists.linux.dev,
        rohiths.msft@gmail.com, sashal@kernel.org, stable@vger.kernel.org,
        stfrench@microsoft.com, svens@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=139ce690680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=9b82859567f2e50c123e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b0c620680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152da4e7a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f4f710c5033/disk-3f86ed6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/555548fedbdc/vmlinux-3f86ed6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c06d7c39bbc0/bzImage-3f86ed6e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/120cc7b707b8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com

XFS (loop0): Quotacheck needed: Please wait.
XFS (loop0): Quotacheck: Done.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5030 at mm/gup.c:229 try_grab_page+0x287/0x460
Modules linked in:
CPU: 1 PID: 5030 Comm: syz-executor118 Not tainted 6.5.0-syzkaller-11704-g3f86ed6ec0b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:try_grab_page+0x287/0x460 mm/gup.c:229
Code: 01 49 8d 7e 60 be 04 00 00 00 e8 54 41 18 00 f0 41 83 46 60 01 42 80 3c 2b 00 0f 85 6a ff ff ff e9 6d ff ff ff e8 b9 55 be ff <0f> 0b bb f4 ff ff ff eb b6 e8 ab 55 be ff 49 ff ce e9 ca fd ff ff
RSP: 0018:ffffc90003a6ee88 EFLAGS: 00010293
RAX: ffffffff81cf4377 RBX: 0000000000000000 RCX: ffff888025da0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 000000000000000e R08: ffffffff81cf418c R09: 1ffffd400039097e
R10: dffffc0000000000 R11: fffff9400039097f R12: ffffea0001c84bf4
R13: dffffc0000000000 R14: ffffea0001c84bc0 R15: ffffea0001c84bc0
FS:  0000555555acb380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020008000 CR3: 00000000736e9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 follow_page_pte+0x560/0x18f0 mm/gup.c:651
 follow_pud_mask mm/gup.c:765 [inline]
 follow_p4d_mask mm/gup.c:782 [inline]
 follow_page_mask+0x7dc/0xe20 mm/gup.c:832
 __get_user_pages+0x643/0x15e0 mm/gup.c:1237
 __get_user_pages_locked mm/gup.c:1504 [inline]
 get_dump_page+0x146/0x2b0 mm/gup.c:2018
 dump_user_range+0x126/0x910 fs/coredump.c:913
 elf_core_dump+0x3b75/0x4490 fs/binfmt_elf.c:2142
 do_coredump+0x1b73/0x2ab0 fs/coredump.c:764
 get_signal+0x145e/0x1840 kernel/signal.c:2878
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb68edcf0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8b18d558 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffe5 RBX: 0000000000000003 RCX: 00007fb68edcf0f9
RDX: 0000000000000000 RSI: 0000000100000001 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 00007ffc8b18d7c8 R14: 0000000000000001 R15: 00007ffc8b18d590
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
