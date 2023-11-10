Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA00F7E828F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346232AbjKJT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbjKJT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:16 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E0524C10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:38:04 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b7fb057153so2017953a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699609084; x=1700213884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8e3Mie9vqeABq5CdBOwS6PJBw1upFX7qypx2Dl9hvok=;
        b=caO4ri/P9MBwYnxcTdQ2R/9sdNiNZec8Vrl5WZsZjQVI6VFuSxYODCnKfv7o8h+ag+
         R8Wbuj8D7+Uh3UmkLzLy5VPejB8k9ZA5DYOpswIEBZHmToiOEyg5yYbHk2ryUmcnYsKC
         JJPaJkSVBM6t+EwfS00cdVELekIOT7znE/OLQ34pB4MtNsHcI1BFd2Czi0x2MERY9zo0
         JZ7BmPDmkb15sGXTr1HaU/3ydXuFDqMsjnPeYeo9pfUBy0Gi1aHxJwF3cAlJyi8NdR5t
         1pWtpTG+OngFDBhV90VkvGzWiAoZQZ5DYuYoIhGiHQCe8rNXfK047JQ3iyWCFvWlh44d
         GmDg==
X-Gm-Message-State: AOJu0YxYYMjy2wIxPa3mKmNUSp4V9wDgivkGOocYfW6Ag9alg5D2cKNE
        QGe0JCgevWdJTwAT2oSGBi8CQy5yvUdsdq9q/Ydor8m6cLpOn2c=
X-Google-Smtp-Source: AGHT+IEzpP8yIFetn8tGZtkd1FzegaQBbbwFt2guVI0gceWQp0pthzKi47Dwkea6ppYXgmO61oEo7cd1DD/JtD/kyjryIgbx20zw
MIME-Version: 1.0
X-Received: by 2002:a65:6448:0:b0:585:6402:41e4 with SMTP id
 s8-20020a656448000000b00585640241e4mr1077680pgv.7.1699609084036; Fri, 10 Nov
 2023 01:38:04 -0800 (PST)
Date:   Fri, 10 Nov 2023 01:38:03 -0800
In-Reply-To: <20231110062620.819348-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b60b4e0609c9131b@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: lock held when returning to user space in btrfs_ioctl_qgroup_create

BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
BTRFS info (device loop0): checking UUID tree
================================================
WARNING: lock held when returning to user space!
6.6.0-syzkaller-15365-g305230142ae0-dirty #0 Not tainted
------------------------------------------------
syz-executor.0/5537 is leaving the kernel with locks still held!
3 locks held by syz-executor.0/5537:
 #0: ffff88806e8a2608 (sb_internal#2){.+.+}-{0:0}, at: btrfs_ioctl_qgroup_create+0x103/0x200 fs/btrfs/ioctl.c:3802
 #1: ffff888052082390 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x401/0xce0 fs/btrfs/transaction.c:294
 #2: ffff8880520823b8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x401/0xce0 fs/btrfs/transaction.c:294


Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17cb5797680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c9591f680000

