Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1B7EBE89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343519AbjKOIZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:25:07 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B21BDF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:25:04 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b7f3f47547so6456495a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700036704; x=1700641504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHrY1iqEw/2CIpX97IAw8M1CVZOhARwdawHwKkG87PI=;
        b=YUvH/xtD6I4iY+ydQZMRNB0n/5miskoQ44ghMpS5IbWcT6gE+xZegYN8y3ke9Z+eRS
         vZQmkQgzNJrC/Qb3hvqCGvgvXZK8oM7EPR8rLI4PyY5X3Ou+fzbN/Renq6J9+w/5l+9C
         dE16VDhg+sI6hyA33xjoWGWgGFmfwhMv/2r8nnXiYe7ajtE2dBH1Ek2aFGCxO0Zi1EuK
         4e7cnYHGmUJOgMJkO2RqhEj8OCujVES0vyNkFWhqAEFR0m3eAoPL7WLaz9GDgamNk2f/
         12r4yTZZrLhNrsLSmZt4vhHCIUyOYeEySxuJOo6+zX+mSluL+G/tG6B5QAhT7hpU/J/l
         NNJA==
X-Gm-Message-State: AOJu0YzLRbPiOxL0sfMb83U98ztGJIHe1Woe6OXrcFk1Gw6XyRG78Qqf
        GVldrKHxfR6QTrL+tOlwT9CefkI7htkl8QlljFIBf+7feJWtltQ=
X-Google-Smtp-Source: AGHT+IFFKCXsJyqDLibURcmN3dZjm86p0/32kATBLhdWQ69ipqDkQ7Q1m4dPahlc9CmZm11HZkvTvliG+0T+OEt0JIr1DLY4NBAN
MIME-Version: 1.0
X-Received: by 2002:a63:e313:0:b0:5bd:bab6:4cf with SMTP id
 f19-20020a63e313000000b005bdbab604cfmr1095311pgh.1.1700036703809; Wed, 15 Nov
 2023 00:25:03 -0800 (PST)
Date:   Wed, 15 Nov 2023 00:25:03 -0800
In-Reply-To: <CA+LQOUdo3f8U5NgwFHq21uLf1mVZC3OkOg54N4yuxM4c00pqxQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5f87e060a2ca319@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_gem_object_handle_put_unlocked
From:   syzbot <syzbot+ef3256a360c02207a4cb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mukattreyee@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in drm_gem_object_handle_put_unlocked

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007f37b0f9bf80 R15: 00007ffdb4a472f8
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5572 at drivers/gpu/drm/drm_gem.c:225 drm_gem_object_handle_put_unlocked+0x299/0x390 drivers/gpu/drm/drm_gem.c:225
Modules linked in:
CPU: 1 PID: 5572 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-00019-gc42d9eeef8e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:drm_gem_object_handle_put_unlocked+0x299/0x390 drivers/gpu/drm/drm_gem.c:225
Code: ea 03 0f b6 04 02 84 c0 74 0c 3c 03 7f 08 4c 89 f7 e8 db 00 24 fd c7 83 20 01 00 00 00 00 00 00 e9 98 fe ff ff e8 87 2d cd fc <0f> 0b 5b 5d 41 5c 41 5d 41 5e e9 78 2d cd fc e8 73 2d cd fc 48 8d
RSP: 0018:ffffc90004f47bb8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880440f1800 RCX: ffffffff84bb752f
RDX: ffff88801f5fd940 RSI: ffffffff84bb7759 RDI: 0000000000000005
RBP: ffff8880440f1804 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801c368000
R13: ffff8880440f1808 R14: 0000000000000000 R15: ffff8880440f1818
FS:  00007f37b1b6a6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37b1b69c98 CR3: 00000000286d0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_gem_handle_create_tail+0x32a/0x540 drivers/gpu/drm/drm_gem.c:407
 drm_gem_shmem_create_with_handle drivers/gpu/drm/drm_gem_shmem_helper.c:417 [inline]
 drm_gem_shmem_dumb_create+0x21a/0x310 drivers/gpu/drm/drm_gem_shmem_helper.c:505
 drm_mode_create_dumb drivers/gpu/drm/drm_dumb_buffers.c:96 [inline]
 drm_mode_create_dumb_ioctl+0x268/0x2f0 drivers/gpu/drm/drm_dumb_buffers.c:102
 drm_ioctl_kernel+0x28c/0x4d0 drivers/gpu/drm/drm_ioctl.c:792
 drm_ioctl+0x5cb/0xbf0 drivers/gpu/drm/drm_ioctl.c:895
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f37b0e7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f37b1b6a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f37b0f9bf80 RCX: 00007f37b0e7cae9
RDX: 0000000020000080 RSI: 00000000c02064b2 RDI: 0000000000000003
RBP: 00007f37b1b6a120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007f37b0f9bf80 R15: 00007ffdb4a472f8
 </TASK>


Tested on:

commit:         c42d9eee Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1304223f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54e2bd738b08eef2
dashboard link: https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
