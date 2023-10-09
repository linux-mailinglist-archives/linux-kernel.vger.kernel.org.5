Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFCC7BE202
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376895AbjJIOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376693AbjJIOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:01:36 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20F299
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:01:34 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3aec0675519so8046993b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 07:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696860094; x=1697464894;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCYw3lVn+zB7uSulm5Xvei08h7Z2bTunwW6MEeThMQI=;
        b=blpo3zCvoo1F+cA+W89V3RyhWTQfU5vXlsmUlK0z0EaGtHIliZ6MKKaR30j4SPXPdS
         h/ajfUONHpN4Q5mxVGb1tc62ZkkXDvC+rUhNSVkCXc2nvnPWHrz8tnMPwYJiecCFHDk5
         Yb49a5jDiAYDcoUhgygVp9/516KFXktNR0y1Hy6iiNJMJV3MJH6gfCFFeo0CZSd8yIkZ
         BJl9pbewQmFYKwCL0PxFQzUVNQcKKr3M6nvjfYY/LHb95nOhL3AmpIPA2aknKwpGp0J4
         +7A2IjBE12qHl+rG6sClMVHrBh9jdd58WVnN8YMqnXK2pPHWpqHEb20TYGZdFgaeFZZ9
         LCeA==
X-Gm-Message-State: AOJu0YwOTs5jGfyywsib1nAgbE75dves+Sg4kidP2tyxxwRCufYYL0/Q
        FcG7oHdDd0cw0EemGACBsSGvWconABabXLfIQD6d/1x4QrBg
X-Google-Smtp-Source: AGHT+IH2mKqwMRRnomT50RuCQ8ZGQ09A618Rz2IiY/3JRRemKzyXD9IRBoE01F1ebbQwBrhSpvsgxvcicLygel5ceogVu5td8wN6
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1885:b0:3ae:24a0:da9e with SMTP id
 bi5-20020a056808188500b003ae24a0da9emr8392062oib.3.1696860094190; Mon, 09 Oct
 2023 07:01:34 -0700 (PDT)
Date:   Mon, 09 Oct 2023 07:01:34 -0700
In-Reply-To: <20231009112906.2143-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025dc9c0607490767@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in fs_bdev_sync

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6681 at fs/super.c:1464 fs_bdev_sync+0x138/0x168 fs/super.c:1464
Modules linked in:
CPU: 0 PID: 6681 Comm: syz-executor.4 Not tainted 6.6.0-rc5-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : fs_bdev_sync+0x138/0x168 fs/super.c:1464
lr : fs_bdev_sync+0x138/0x168 fs/super.c:1464
sp : ffff800097637a70
x29: ffff800097637a70 x28: ffff0000d6699bc0 x27: 0000000000000003
x26: dfff800000000000 x25: ffff700012ec6f58 x24: ffff800097637ac0
x23: 0000000000001261 x22: dfff800000000000 x21: 0000000000000001
x20: 0000000000000000 x19: ffff0000c657c000 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008031d534 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 00000000c0101282
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000d6699bc0 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : ffffffffffffffff x3 : 0000000000000000
x2 : 0000000000000015 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 fs_bdev_sync+0x138/0x168 fs/super.c:1464
 blkdev_flushbuf block/ioctl.c:371 [inline]
 blkdev_common_ioctl+0x838/0x286c block/ioctl.c:500
 blkdev_ioctl+0x35c/0xae4 block/ioctl.c:622
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 116
hardirqs last  enabled at (115): [<ffff8000809cd760>] kasan_quarantine_put+0x1a0/0x1c8 mm/kasan/quarantine.c:240
hardirqs last disabled at (116): [<ffff80008a630728>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last  enabled at (92): [<ffff800080033cf4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (90): [<ffff800080033cc0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


Tested on:

commit:         94f6f055 Linux 6.6-rc5
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=129ec4e9680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b8c825e0d5f3f72
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156813ee680000

