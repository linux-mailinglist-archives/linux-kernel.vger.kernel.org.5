Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6CF797EED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjIGXEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjIGXEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:04:08 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA1BCF3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 16:04:04 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1bf08cf3365so18645885ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 16:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127844; x=1694732644;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qIVdRmDrLBZvUQgIhZ+mgd7I9aUWm7XLJQ2fXiufrs=;
        b=ifT6REBKdhp25HtqQGUq0+L8VZqoki/KUdzcZEIjmKw3lsd2hPwbzI26Tc6GJfgv6X
         7l3CdM5CNq97uxXf9yfVgdzomCRs9fLmybzMUMaO7hY2iSrPoKNQBRCY7O45cG1sPDYg
         mNfjbnCk9wfbAfzlrjria4cbofL7MoOR0PfzVqn19nqnDOotN0+GSPsCHTDYa9K/H29R
         VOT6yRWT7LGPj+VHyq1L+JfX5RrT7rADDiP8NFaBmgesLt5F6b82N8sWDwN9LjvGWAST
         CfepDElu4fJmc18k29ozR98frSkyeh0gJNmkXMVSPrhg9cD0c1nedpYFhW8dr630HKNT
         EfBw==
X-Gm-Message-State: AOJu0YwxM51aIMI9/q8Fko/0mMaZFewkPsUR73JI0FR/PWIOO3CtQtFi
        4Ga6ng5dg8NdMI3jffFldXGtHSMNKtFTA5yq5hnSeCcIlVZY
X-Google-Smtp-Source: AGHT+IGjFM79VIw0E5WUJx5G1zVppF7bce/T74F7G7tTulEu1jqtVclFnpL+a50hmITRN9O2pAiGamjUDwI3vodd28iu3mpnxdk+
MIME-Version: 1.0
X-Received: by 2002:a17:902:ea0a:b0:1c3:5d5b:e294 with SMTP id
 s10-20020a170902ea0a00b001c35d5be294mr368960plg.7.1694127844341; Thu, 07 Sep
 2023 16:04:04 -0700 (PDT)
Date:   Thu, 07 Sep 2023 16:04:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005dc3d00604cce08d@google.com>
Subject: [syzbot] [gfs2?] memory leak in gfs2_trans_begin
From:   syzbot <syzbot+45a7939b6f493f374ee1@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cda4e7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe0cf825f8fbc075
dashboard link: https://syzkaller.appspot.com/bug?extid=45a7939b6f493f374ee1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f3a658680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0a6ca0af2bd5/disk-3f86ed6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba67b3d88c83/vmlinux-3f86ed6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a64bda3d2e5/bzImage-3f86ed6e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6406b55aec21/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45a7939b6f493f374ee1@syzkaller.appspotmail.com

2023/09/05 14:30:51 executed programs: 30
BUG: memory leak
unreferenced object 0xffff8881214cbc60 (size 144):
  comm "syz-executor.7", pid 5069, jiffies 4294970978 (age 14.110s)
  hex dump (first 32 bytes):
    ae 04 1f 82 ff ff ff ff 02 00 00 00 00 00 00 00  ................
    08 00 00 00 00 00 00 00 06 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821f3e39>] kmem_cache_zalloc include/linux/slab.h:710 [inline]
    [<ffffffff821f3e39>] gfs2_trans_begin+0x29/0xa0 fs/gfs2/trans.c:115
    [<ffffffff821f04ae>] gfs2_statfs_sync+0x1ae/0x250 fs/gfs2/super.c:298
    [<ffffffff821f0d01>] gfs2_make_fs_ro+0x1b1/0x430 fs/gfs2/super.c:566
    [<ffffffff821f14ac>] gfs2_put_super+0x2bc/0x2d0 fs/gfs2/super.c:623
    [<ffffffff8168f43e>] generic_shutdown_super+0x9e/0x170 fs/super.c:693
    [<ffffffff8168f58d>] kill_block_super+0x1d/0x50 fs/super.c:1646
    [<ffffffff821d4a7f>] gfs2_kill_sb+0x1bf/0x1f0 fs/gfs2/ops_fstype.c:1795
    [<ffffffff8169065a>] deactivate_locked_super+0x4a/0x110 fs/super.c:481
    [<ffffffff816907bc>] deactivate_super fs/super.c:514 [inline]
    [<ffffffff816907bc>] deactivate_super+0x9c/0xb0 fs/super.c:510
    [<ffffffff816cd041>] cleanup_mnt+0x121/0x210 fs/namespace.c:1254
    [<ffffffff812d2b5f>] task_work_run+0x8f/0xe0 kernel/task_work.c:179
    [<ffffffff81361556>] resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
    [<ffffffff81361556>] exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
    [<ffffffff81361556>] exit_to_user_mode_prepare+0x116/0x140 kernel/entry/common.c:204
    [<ffffffff84b29c41>] __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
    [<ffffffff84b29c41>] syscall_exit_to_user_mode+0x21/0x50 kernel/entry/common.c:296
    [<ffffffff84b25fb4>] do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
