Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF0754677
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGODN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGODNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:13:54 -0400
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67E35BD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:13:53 -0700 (PDT)
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-566659e9556so3545726eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689390832; x=1691982832;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSfrWYFfOOuvEmLeDsQiplx/675CCat2k6SwRj9bpqE=;
        b=GiuZpMWxvXxWiWMZOtyDD+lgEDH8IMHFgWj1sqJFXdyjcFNQxgjYruTuRKgEMVltlc
         g9CqQgTSYU1WT5aCJQS4AGp8pdK0HND4RCtgf/O/ZZ9nrDzgVo0ox4xc8fVBeGv6MEs5
         KuS/oIsmlel0b6f3jqlkYeCzj3+q26pIay5ozWvVIKaD26GjFFX/iR3HWhbmg2bj+Mth
         HUjuvc2e1DXH1bmV/JSsgXB8a3JhleaOg8bABI4utTk8ufAEGywj7nQxQiv1pmQkzxJf
         5gAOPGJro3Ua47g4A4kJ/DTOKEFWUzzATDHRQ0QLV1q5vtSN+3DghdYS0b38kcYWS2/m
         HERQ==
X-Gm-Message-State: ABy/qLYRF8NY1RdHslh4oa544lslhIY1zIitT3jiannM9QxmqTgYXWq5
        n7aMAGQwnSvQNNsNd3X90/OA6Nv0/63KgQ+/7j7ztX5fAaAa
X-Google-Smtp-Source: APBJJlHN0BPIT8LZkDkvRBAqIkZh1f4mHHJg2tytQiA8PD1PmLvoNqND4wDbUjbqd8Vr7YTIvwnOoAyNrfybE/0WfMIiFvzBNvfs
MIME-Version: 1.0
X-Received: by 2002:a05:6808:151f:b0:3a3:671b:7dee with SMTP id
 u31-20020a056808151f00b003a3671b7deemr8740843oiw.11.1689390832500; Fri, 14
 Jul 2023 20:13:52 -0700 (PDT)
Date:   Fri, 14 Jul 2023 20:13:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075472b06007df4fb@google.com>
Subject: [syzbot] [nfc?] memory leak in skb_copy (2)
From:   syzbot <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
To:     bongsu.jeon@samsung.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fe3ef8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75da4f0a455bdbd3
dashboard link: https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162f1cbca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/441fb7ea58b8/disk-3f01e9fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8fa7790ba0c3/vmlinux-3f01e9fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e7a6471dadf/bzImage-3f01e9fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811fff5e00 (size 240):
  comm "kworker/u4:0", pid 10, jiffies 4294989700 (age 28.220s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e1c0bd>] __alloc_skb+0x1fd/0x230 net/core/skbuff.c:634
    [<ffffffff83e1efcf>] skb_copy+0x6f/0x180 net/core/skbuff.c:1925
    [<ffffffff82c3526f>] virtual_nci_send+0x3f/0xb0 drivers/nfc/virtual_ncidev.c:58
    [<ffffffff84990da9>] nci_send_frame+0x69/0xb0 net/nfc/nci/core.c:1347
    [<ffffffff84990e82>] nci_cmd_work+0x92/0xc0 net/nfc/nci/core.c:1567
    [<ffffffff812b19e4>] process_one_work+0x2c4/0x620 kernel/workqueue.c:2597
    [<ffffffff812b233d>] worker_thread+0x5d/0x5c0 kernel/workqueue.c:2748
    [<ffffffff812bbde3>] kthread+0x133/0x180 kernel/kthread.c:389
    [<ffffffff81002b5f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

BUG: memory leak
unreferenced object 0xffff88810d74e500 (size 640):
  comm "kworker/u4:0", pid 10, jiffies 4294989700 (age 28.220s)
  hex dump (first 32 bytes):
    20 00 01 01 00 00 00 00 00 00 00 00 00 00 00 00   ...............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e18976>] kmalloc_reserve+0xe6/0x180 net/core/skbuff.c:559
    [<ffffffff83e1bf95>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:644
    [<ffffffff83e1efcf>] skb_copy+0x6f/0x180 net/core/skbuff.c:1925
    [<ffffffff82c3526f>] virtual_nci_send+0x3f/0xb0 drivers/nfc/virtual_ncidev.c:58
    [<ffffffff84990da9>] nci_send_frame+0x69/0xb0 net/nfc/nci/core.c:1347
    [<ffffffff84990e82>] nci_cmd_work+0x92/0xc0 net/nfc/nci/core.c:1567
    [<ffffffff812b19e4>] process_one_work+0x2c4/0x620 kernel/workqueue.c:2597
    [<ffffffff812b233d>] worker_thread+0x5d/0x5c0 kernel/workqueue.c:2748
    [<ffffffff812bbde3>] kthread+0x133/0x180 kernel/kthread.c:389
    [<ffffffff81002b5f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
