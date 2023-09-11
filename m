Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9279B438
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379144AbjIKWln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbjIKVJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 17:09:58 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012304217
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:58:31 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-68fb5a36001so2093592b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694465794; x=1695070594;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vao4EZOBAKv3ccKiIjbqy1yRf/zmM6Bv8JSbHDux0Q=;
        b=J0dCg6SGYai9JFpK+LzDQ78ysGE/6RyL+FFjErMTMR9StiYiKAefY8NNwasB4e3Imv
         FjjkE3x1iHRjRZ2odSfC+8pb0ot29QRT3XV3BpXRBsBueld/kgTs2AMPOTLmDlBajzw/
         EOEYafGesBZsp+7Hx49fj+tLPxJ7W7rBsK6ko/6EE4nPaqxLF+hWE1HtEwfvEIWvXCye
         M/Pl/Z030mKg1PibyPI5yTQqH3JG6r9owOh3roaQlrqeM1VhHd644ewjSVC1zxOuY7RO
         Sm7ibOOOnlGs4B/pwn6JbJx5XISqdNYvqOLG4OaAnnto+dxUACZr9PaYUMfc1ZtUx9lO
         3Row==
X-Gm-Message-State: AOJu0YyQCVAOW8pgZJyFzfq2X4o0Yfsb7JHzz6NmeEW1UZ8VZlZ01L5L
        oJX88oqC7C6+8w1d0B1v4YUS9jhd//PuvQ4bOpigkJn8OXWc
X-Google-Smtp-Source: AGHT+IHsUyJqK1GSL/YM9V/v1y61+H5dGOhZcGqOJhTXboSbyrCyrad04IXbXCKh26op3S3kTI6JwPjOuqwoB5HStcFLKSk9M3SN
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2191:b0:68e:3761:39fd with SMTP id
 h17-20020a056a00219100b0068e376139fdmr4464929pfi.4.1694465794200; Mon, 11 Sep
 2023 13:56:34 -0700 (PDT)
Date:   Mon, 11 Sep 2023 13:56:34 -0700
In-Reply-To: <000000000000aa181605ededf1fa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf5cab06051b8fde@google.com>
Subject: Re: [syzbot] [kernel?] memory leak in binder_transaction (2)
From:   syzbot <syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com>
To:     arve@android.com, brauner@kernel.org, cmllamas@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
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

HEAD commit:    0bb80ecc33a8 Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177ee3c8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99ce3535087fc27
dashboard link: https://syzkaller.appspot.com/bug?extid=7f10c1653e35933c0f1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107b832c680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147332b4680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce21ae500663/disk-0bb80ecc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d2f34908198/vmlinux-0bb80ecc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c6f5eecda20/bzImage-0bb80ecc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810e2d6de0 (size 32):
  comm "syz-executor338", pid 5046, jiffies 4294968230 (age 13.590s)
  hex dump (first 32 bytes):
    e0 6d 2d 0e 81 88 ff ff e0 6d 2d 0e 81 88 ff ff  .m-......m-.....
    04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81573b75>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff83d41873>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff83d41873>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83d41873>] binder_transaction+0x573/0x4050 drivers/android/binder.c:3152
    [<ffffffff83d45a05>] binder_thread_write+0x6b5/0x1860 drivers/android/binder.c:4010
    [<ffffffff83d486dc>] binder_ioctl_write_read drivers/android/binder.c:5066 [inline]
    [<ffffffff83d486dc>] binder_ioctl+0x1b2c/0x3cf0 drivers/android/binder.c:5352
    [<ffffffff816b25f2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816b25f2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816b25f2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b25f2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
