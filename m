Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7197CDFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbjJRO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344873AbjJRO2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:28:03 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F41189
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:28:01 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3ae30e1ad6cso10859070b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697639280; x=1698244080;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdMBNL3S2x6JknCQNvPePRN6XZ2zBEfRh1DVc58bPSA=;
        b=YrOMQsVnqxCaQI5XYPCDQTi/aZRVzHpuxfuKWDVcFfx4GwiNmmx99MqvWeFoKa1Kgo
         hQlvNkSGic5+AsSNzIPShf7kkKu/8XyZd4IVjIhWgtiI3ATitqlulb3cCjfO6uorTU1/
         Mh4RNUrK5L0qoxtIeI67bm/5lvAWTq6s/+tgEaZQ9cFiiT/SmuJl4UDpvWe3D6KgPT0V
         l+/pZTtMM1O6HUYidEL6Ek7t+XamP7LBHfVUzmYG8kZMzHNhCLaJlEDS/wF+SZir0OJx
         mLs7jIjxBzxeb4g7D9Hi0HEVppv4aWZukRN5utszOSjwRiw9mlv2M732KsrKILNfuOqR
         4dmQ==
X-Gm-Message-State: AOJu0YzcwQh/42hyp2yh8dTt1vQgGVc+OwKMriT/LI6AEoSEOwM629Xi
        mmOGT+2FVPj7UrHq4C5w38Ax9JkBGRd0ombg55phlIrvNP40
X-Google-Smtp-Source: AGHT+IH5x77WTQFzLiRumx9QRmlIW1x9csdWG+C9yZ4XNpdGNpfb61NuTSsTMsCGzbBMsDzUBEgm2yxf0y4jfQacuqmDkoK4xRm/
MIME-Version: 1.0
X-Received: by 2002:a05:6808:219b:b0:3b2:f40e:9493 with SMTP id
 be27-20020a056808219b00b003b2f40e9493mr13347oib.6.1697639280434; Wed, 18 Oct
 2023 07:28:00 -0700 (PDT)
Date:   Wed, 18 Oct 2023 07:28:00 -0700
In-Reply-To: <0000000000000c44b0060760bd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004467c80607fe72f1@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING: suspicious RCU usage in gfs2_permission
From:   syzbot <syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, gfs2@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        postmaster@duagon.onmicrosoft.com, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13af5fe5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=3e5130844b0c0e2b4948
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c8d09680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a07475680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2375f16ed327/disk-2dac7569.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c80aee6e2e6c/vmlinux-2dac7569.xz
kernel image: https://storage.googleapis.com/syzbot-assets/664dc23b738d/bzImage-2dac7569.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5ce278ef6f36/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
=============================
WARNING: suspicious RCU usage
6.6.0-rc6-next-20231018-syzkaller #0 Not tainted
-----------------------------
fs/gfs2/inode.c:1877 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor120/5052.

stack backtrace:
CPU: 1 PID: 5052 Comm: syz-executor120 Not tainted 6.6.0-rc6-next-20231018-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20c/0x3b0 kernel/locking/lockdep.c:6711
 gfs2_permission+0x3f9/0x4c0 fs/gfs2/inode.c:1877
 do_inode_permission fs/namei.c:462 [inline]
 inode_permission fs/namei.c:529 [inline]
 inode_permission+0x384/0x5e0 fs/namei.c:504
 may_open+0x11c/0x400 fs/namei.c:3249
 do_open fs/namei.c:3619 [inline]
 path_openat+0x17aa/0x2ce0 fs/namei.c:3778
 do_filp_open+0x1de/0x430 fs/namei.c:3808
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f5b23a31a11
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 7a 06 0b 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffe9ecd33a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007f5b23a31a11
RDX: 0000000000010000 RSI: 0000000020037f80 RDI: 00000000ffffff9c
RBP: 0000000020037f80 R08: 00007ffe9ecd3470 R09: 0000000000037f13
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffe9ecd3470 R14: 0000000000000003 R15: 0000000001000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
