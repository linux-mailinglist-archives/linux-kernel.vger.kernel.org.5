Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFE87531DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjGNGV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjGNGVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:21:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564A02726;
        Thu, 13 Jul 2023 23:21:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bb119be881so5240625ad.3;
        Thu, 13 Jul 2023 23:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689315683; x=1691907683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ+Tlchq7Rx5JUChD94efcFz6I7nfzXVwwR7VBAwSBw=;
        b=H4q+c87H4VJCc8tpwfLc7WRMkWvucAc1d0TQMxiBZW1QHOnbr92BfH69PwNsyDY1NS
         3DFgzGCFD8xmwSns59zE5u1CCAUONY6jS/ziBDFltyIc7W+7NqFzQSY0ZhG37LkYeZ9M
         KFQanGY355c3pTdPlzz8Uj+J1k+ZQGHiznZtCtEnkX6FFO0kOjEM9cRe5HiaMP7f1H1c
         ZL/JfUaL2glLj3+ThYDRiB3shDFDDOBKS1ocfyOXKsFbbx9IpH2YHrFwW6E9W//3Z3+A
         w7Pmylqt401exPtEiAfBu/7AUByrLTcMLO8m/RHmWUzkQVB73oVnbFb6fHBACL32UPND
         n3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689315683; x=1691907683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZ+Tlchq7Rx5JUChD94efcFz6I7nfzXVwwR7VBAwSBw=;
        b=c2pF/2LzJ8vpWgO/7cCa0b5hgvpOeYQewwMya2+/ENGV+NEyibOMKRBWZoVCaKctjG
         yBbUYMLlMiXzzHE8Rzqz1452KM2eSUoTXxDLljrB6pwkS/UHaqaXlwCJ/AX0HRXU20+j
         w8Inw7RxYkHiZO+Kmgo2I9cjhWApQJDMMeriwEkTpUcw7Hi9tNYqM/XsKfqElud+IxaM
         kljE99zmTPS1RpmfsFWxr9Q1L9xyQBvkukV6zLCTb3WImvyjDzH7niIGjwt/ygadG81p
         NbR/8EJI1NCimEVet4GMTHtgNu6P7Q4PcLuRd1PaCLouo7FezRbWYgsmDxwaE/ZVxPDO
         MOVA==
X-Gm-Message-State: ABy/qLZeKci4IcK/vvFXmsmFp7777BW5MdYtzu//SZvnY9o0M0UypS7O
        MUPzedIKbE06hJBqKeBJdHbg4IHXqZaazyNUgKM=
X-Google-Smtp-Source: APBJJlHqRQ7/RS54ah94VMzM5dm+KhafA7WS2OPOLECnNVUyvSfQRFepntY/WerDzR8HD2eup+04tdgrR+LcUZ/dh4I=
X-Received: by 2002:a17:902:cec3:b0:1b8:971c:b7b7 with SMTP id
 d3-20020a170902cec300b001b8971cb7b7mr4128499plg.56.1689315682551; Thu, 13 Jul
 2023 23:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009db51a06005b64e9@google.com>
In-Reply-To: <0000000000009db51a06005b64e9@google.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 14 Jul 2023 14:21:10 +0800
Message-ID: <CALm+0cWBh+4GMzfRKR6rE4H4JR5aRW_m1KVdTLZLJuQyE_smRg@mail.gmail.com>
Subject: Re: [syzbot] [usb?] memory leak in raw_open
To:     syzbot <syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com>
Cc:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1c7873e33645 mm: lock newly mapped VMA with corrected orde..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1517663ca80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=832b404e095b70c0
> dashboard link: https://syzkaller.appspot.com/bug?extid=feb045d335c1fdde5bf7
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1776519ca80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117f9778a80000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/43b42bd2cf70/disk-1c7873e3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/011ba1b9e8c1/vmlinux-1c7873e3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/18b349342595/bzImage-1c7873e3.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com
>
> BUG: memory leak
> unreferenced object 0xffff88810b172000 (size 4096):
>   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 bc 96 0e 81 88 ff ff  ................
>     5d b6 9e 85 ff ff ff ff 03 00 00 00 00 00 00 00  ]...............
>   backtrace:
>     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
>     [<ffffffff8347eb55>] kmalloc include/linux/slab.h:582 [inline]
>     [<ffffffff8347eb55>] kzalloc include/linux/slab.h:703 [inline]
>     [<ffffffff8347eb55>] dev_new drivers/usb/gadget/legacy/raw_gadget.c:191 [inline]
>     [<ffffffff8347eb55>] raw_open+0x45/0x110 drivers/usb/gadget/legacy/raw_gadget.c:385
>     [<ffffffff827d1d09>] misc_open+0x1a9/0x1f0 drivers/char/misc.c:165
>     [<ffffffff8166763b>] chrdev_open+0x11b/0x340 fs/char_dev.c:414
>     [<ffffffff8165573f>] do_dentry_open+0x30f/0x990 fs/open.c:914
>     [<ffffffff8167cabb>] do_open fs/namei.c:3636 [inline]
>     [<ffffffff8167cabb>] path_openat+0x178b/0x1b20 fs/namei.c:3793
>     [<ffffffff8167e995>] do_filp_open+0xc5/0x1b0 fs/namei.c:3820
>     [<ffffffff81659453>] do_sys_openat2+0xe3/0x140 fs/open.c:1407
>     [<ffffffff81659de3>] do_sys_open fs/open.c:1422 [inline]
>     [<ffffffff81659de3>] __do_sys_openat fs/open.c:1438 [inline]
>     [<ffffffff81659de3>] __se_sys_openat fs/open.c:1433 [inline]
>     [<ffffffff81659de3>] __x64_sys_openat+0x83/0xe0 fs/open.c:1433
>     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff88810ad20d60 (size 32):
>   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
>   hex dump (first 32 bytes):
>     72 61 77 2d 67 61 64 67 65 74 2e 30 00 00 00 00  raw-gadget.0....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
>     [<ffffffff8347cd2f>] kmalloc include/linux/slab.h:582 [inline]
>     [<ffffffff8347cd2f>] raw_ioctl_init+0xdf/0x410 drivers/usb/gadget/legacy/raw_gadget.c:460
>     [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/legacy/raw_gadget.c:1250
>     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
>     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
>     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
>     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
>     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff88810e96bc00 (size 128):
>   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
>   hex dump (first 32 bytes):
>     64 75 6d 6d 79 5f 75 64 63 00 00 00 00 00 00 00  dummy_udc.......
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
>     [<ffffffff8347cd6d>] kmalloc include/linux/slab.h:582 [inline]
>     [<ffffffff8347cd6d>] raw_ioctl_init+0x11d/0x410 drivers/usb/gadget/legacy/raw_gadget.c:468
>     [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/legacy/raw_gadget.c:1250
>     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
>     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
>     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
>     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
>     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff88810e96ba80 (size 128):
>   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
>   hex dump (first 32 bytes):
>     64 75 6d 6d 79 5f 75 64 63 2e 30 00 00 00 00 00  dummy_udc.0.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
>     [<ffffffff8347cdfc>] kmalloc include/linux/slab.h:582 [inline]
>     [<ffffffff8347cdfc>] raw_ioctl_init+0x1ac/0x410 drivers/usb/gadget/legacy/raw_gadget.c:479
>     [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/legacy/raw_gadget.c:1250
>     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
>     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
>     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
>     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
>     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff88810e96bd00 (size 128):
>   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
>   hex dump (first 32 bytes):
>     00 bd 96 0e 81 88 ff ff 00 bd 96 0e 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
>     [<ffffffff833ecc6a>] kmalloc include/linux/slab.h:582 [inline]
>     [<ffffffff833ecc6a>] kzalloc include/linux/slab.h:703 [inline]
>     [<ffffffff833ecc6a>] dummy_alloc_request+0x5a/0xe0 drivers/usb/gadget/udc/dummy_hcd.c:665
>     [<ffffffff833e9132>] usb_ep_alloc_request+0x22/0xd0 drivers/usb/gadget/udc/core.c:196
>     [<ffffffff8347f13d>] gadget_bind+0x6d/0x370 drivers/usb/gadget/legacy/raw_gadget.c:292
>     [<ffffffff833e9e83>] gadget_bind_driver+0xe3/0x2e0 drivers/usb/gadget/udc/core.c:1591
>     [<ffffffff82ba069d>] call_driver_probe drivers/base/dd.c:579 [inline]
>     [<ffffffff82ba069d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
>     [<ffffffff82ba0a61>] __driver_probe_device+0xc1/0x1a0 drivers/base/dd.c:798
>     [<ffffffff82ba0b6a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:828
>     [<ffffffff82ba0eae>] __driver_attach drivers/base/dd.c:1214 [inline]
>     [<ffffffff82ba0eae>] __driver_attach+0xfe/0x1f0 drivers/base/dd.c:1154
>     [<ffffffff82b9d985>] bus_for_each_dev+0xa5/0x110 drivers/base/bus.c:368
>     [<ffffffff82b9f486>] bus_add_driver+0x126/0x2a0 drivers/base/bus.c:673
>     [<ffffffff82ba25da>] driver_register+0x8a/0x190 drivers/base/driver.c:246
>     [<ffffffff833e7524>] usb_gadget_register_driver_owner+0x64/0x160 drivers/usb/gadget/udc/core.c:1665
>     [<ffffffff8347e0e6>] raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:546 [inline]
>     [<ffffffff8347e0e6>] raw_ioctl+0x6f6/0x1120 drivers/usb/gadget/legacy/raw_gadget.c:1253
>     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
>     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
>     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
>     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
>     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
 master

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c
b/drivers/usb/gadget/legacy/raw_gadget.c
index 2acece16b890..c00f93b630ad 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -310,13 +310,12 @@ static int gadget_bind(struct usb_gadget *gadget,
        dev->eps_num = i;
        spin_unlock_irqrestore(&dev->lock, flags);

-       /* Matches kref_put() in gadget_unbind(). */
-       kref_get(&dev->count);
-
        ret = raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
        if (ret < 0)
                dev_err(&gadget->dev, "failed to queue event\n");

+       /* Matches kref_put() in gadget_unbind(). */
+       kref_get(&dev->count);
        return ret;
 }



>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
