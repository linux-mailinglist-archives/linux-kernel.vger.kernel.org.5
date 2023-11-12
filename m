Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD07E8F4F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjKLJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:21:08 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7274130C2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:21:05 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6bde4f405f9so3332151b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699780865; x=1700385665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVjrCTYRe2nvig3PfqBsiJOGikcayNigDKHyRd84JT0=;
        b=hPJibM5hwAXij7V+719mfjUEZCIzWyH0FX9DFPlJ+TtO9ZBxY7TdKOKWi5YhMTAAMu
         b4/zUWUjO8myV2XJQ9Mj1OjsC52MlgKZJ5SNPMl9u2s5V/8pC8F7GtC8AcwLmBEQRb52
         XnZPR/qM8tVDEURcKjv/Bs6eXvB1m+zaUITKKBKdcT2hdgnqAE+VGs2qGPLjB5rrGuSC
         uGxubBU0eZbjHQ8u3LTB3KDmH0JX2RlY90kExl3Yk5CxP+iwdmECWpga4vpPa6mM3OIW
         Hb1EXNum1KYFUPkXFkoaZ7+81yDGgGlnoT3F+jBNcXQocSGhI8Gm/fMkRx5a9n2AOLpQ
         Mhtg==
X-Gm-Message-State: AOJu0YxTFwzPDwwq1jLa2OfH3L6yDPh6WDINISunFbmf/zLQwHjXagyo
        LFwzfqvnbtGIltEUfk8kNgthBOztbrYNKowADlQW4GQ4gpT9
X-Google-Smtp-Source: AGHT+IEu+yITQdTApV4csEmOVbD15js3mHkSdQ+58WMD7ouB8zTRrneXIPdqDIfkThrK6y/KShstLZZ7saAT7O6pJqAevaRhxkvc
MIME-Version: 1.0
X-Received: by 2002:a17:903:1301:b0:1cc:c462:d4ce with SMTP id
 iy1-20020a170903130100b001ccc462d4cemr1231200plb.11.1699780865041; Sun, 12
 Nov 2023 01:21:05 -0800 (PST)
Date:   Sun, 12 Nov 2023 01:21:04 -0800
In-Reply-To: <CAOQ4uxh3i=eLJZeNu7VWS9L7OaVVRgyX9Yqr5hx15h9dYmWaXQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a82c860609f1124d@google.com>
Subject: Re: [syzbot] [overlayfs?] memory leak in ovl_parse_param
From:   syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in ovl_parse_param

BUG: memory leak
unreferenced object 0xffff88814002d0c8 (size 8):
  comm "syz-executor.0", pid 5498, jiffies 4294944229 (age 12.660s)
  hex dump (first 8 bytes):
    2e 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e57c>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
    [<ffffffff8157e57c>] __kmalloc_node_track_caller+0x4c/0x150 mm/slab_common.c:1027
    [<ffffffff8156da4c>] kstrdup+0x3c/0x70 mm/util.c:62
    [<ffffffff81d0424e>] ovl_parse_param_lowerdir fs/overlayfs/params.c:496 [inline]
    [<ffffffff81d0424e>] ovl_parse_param+0x70e/0xc60 fs/overlayfs/params.c:576
    [<ffffffff817053ab>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:146
    [<ffffffff817054d6>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:188
    [<ffffffff817055ef>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_context.c:230
    [<ffffffff816dfe88>] do_new_mount fs/namespace.c:3333 [inline]
    [<ffffffff816dfe88>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
    [<ffffffff816e0ac1>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816e0ac1>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816e0ac1>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816e0ac1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff8881009ec0c8 (size 8):
  comm "syz-executor.0", pid 5752, jiffies 4294944765 (age 7.300s)
  hex dump (first 8 bytes):
    2e 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e57c>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
    [<ffffffff8157e57c>] __kmalloc_node_track_caller+0x4c/0x150 mm/slab_common.c:1027
    [<ffffffff8156da4c>] kstrdup+0x3c/0x70 mm/util.c:62
    [<ffffffff81d0424e>] ovl_parse_param_lowerdir fs/overlayfs/params.c:496 [inline]
    [<ffffffff81d0424e>] ovl_parse_param+0x70e/0xc60 fs/overlayfs/params.c:576
    [<ffffffff817053ab>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:146
    [<ffffffff817054d6>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:188
    [<ffffffff817055ef>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_context.c:230
    [<ffffffff816dfe88>] do_new_mount fs/namespace.c:3333 [inline]
    [<ffffffff816dfe88>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
    [<ffffffff816e0ac1>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816e0ac1>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816e0ac1>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816e0ac1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff8881009ec0e0 (size 8):
  comm "syz-executor.0", pid 5754, jiffies 4294944766 (age 7.290s)
  hex dump (first 8 bytes):
    2e 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e57c>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
    [<ffffffff8157e57c>] __kmalloc_node_track_caller+0x4c/0x150 mm/slab_common.c:1027
    [<ffffffff8156da4c>] kstrdup+0x3c/0x70 mm/util.c:62
    [<ffffffff81d0424e>] ovl_parse_param_lowerdir fs/overlayfs/params.c:496 [inline]
    [<ffffffff81d0424e>] ovl_parse_param+0x70e/0xc60 fs/overlayfs/params.c:576
    [<ffffffff817053ab>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:146
    [<ffffffff817054d6>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:188
    [<ffffffff817055ef>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_context.c:230
    [<ffffffff816dfe88>] do_new_mount fs/namespace.c:3333 [inline]
    [<ffffffff816dfe88>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
    [<ffffffff816e0ac1>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816e0ac1>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816e0ac1>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816e0ac1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



Tested on:

commit:         3f653af2 ovl: fix memory leak in ovl_parse_param()
git tree:       https://github.com/amir73il/linux ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=13a07ea7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=26eedf3631650972f17c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
