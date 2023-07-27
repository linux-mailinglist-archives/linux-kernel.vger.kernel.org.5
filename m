Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51278764740
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjG0Gwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjG0Gwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:52:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FCB2681;
        Wed, 26 Jul 2023 23:52:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe0bb9500aso1026820e87.1;
        Wed, 26 Jul 2023 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690440744; x=1691045544;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Du0yvbf9NxdTgxrqf+OyhmCHz7Ody3Ln+8gs6M4cVY=;
        b=RpjNCjau8+nwrrE1C1P1o4DQUts3zk9IS5QhdtjQ6bwObce4QxhLY55D0ZoGDr6mbW
         DXQ2mWDUzb7sZakyfF3CPvb6Hz0jhKFqz69phya3u/un1Snxk/Q4qzORIwEOOIFxJ1ae
         uKM+SPAJCO3TW0+wfsbEmxv4oMVtWG8xzmGnMA1MFhnNA5mLr6/2p4sCdXu8SbRP4w3f
         dq3mfj9vnExLKLgEZKnqZVAvS/518815w3a3Ed2w2ldl4nmShPkc/HxcM1Q4VQ1jkrXl
         LXF2LdVMHMKAigD2Fc599ko7ctYr32KF+YclrFeKBOqAn8kMK6pRuUUiqggsiEyaAH6E
         aHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690440744; x=1691045544;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Du0yvbf9NxdTgxrqf+OyhmCHz7Ody3Ln+8gs6M4cVY=;
        b=Ycv+ksS7YN+ztthAAIcWa86vKnGcgJMTyflZSABq8C4QlH4F58FCoo/zVw+z0tKJcE
         6myMXcpkR0yqEsR3eYIUPgtHRqLF3JGynlFH1zjfvUmpzJclTGPBaQ76kdeWTQy633yW
         fCZxXau9DtRBTaxNjYf73v0smK7L95arnnwaaNt28/PRMOsOI6rabIVeMrnFJ12L3iig
         DVRQfA40hM1vEjy82eYMYil5JM1LkjheAvRTJUWW5pkNLO751FbVeeM7tq+WimV/ooPX
         E5POe8r2YvsqRxp4RYHSx0qA10CYHm8SKVRZOvzITQpNyTLXkqqCt8w9IN7Teb+4Rrn7
         tUSQ==
X-Gm-Message-State: ABy/qLaq40BbylAiWFZKeENfTyvfDT+2VWV2apcoHE0kO1v+/vcKWET/
        H4u5aUje0C4krVlUfMonV5GR9ZZn/Ola8hsRHvYFxbumj08=
X-Google-Smtp-Source: APBJJlFnFKXaZIgGUl+TIeDRhRu5uowJbTum6YVfLjT8BuS2n+Xuz0/7PYGW+luge6ZJm5Yucs1CoD4pjb1HAAM3nTA=
X-Received: by 2002:a2e:8310:0:b0:2b4:6e21:637e with SMTP id
 a16-20020a2e8310000000b002b46e21637emr1058625ljh.16.1690440743471; Wed, 26
 Jul 2023 23:52:23 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Thu, 27 Jul 2023 14:52:11 +0800
Message-ID: <CALcu4rZG=idKgo4EzYYHo+Q=JBLFnqG9NmqJ-09ewB=9Cj1fQQ@mail.gmail.com>
Subject: UBSAN array-index-out-of-bounds in do_journal_end
To:     reiserfs-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: fdf0eaf11452d72945af31804e2a1048ee1b574c (tag: v6.5-rc2)

git tree: upstream

console output:
https://drive.google.com/file/d/1rvB5Fwc85GjfGwkk0bcYKZksB5l-_nOX/view?usp=drive_link
kernel config: https://drive.google.com/file/d/1V146PezNdRzu1BRVfwwYsIwNCZvAOBxJ/view?usp=drive_link
C reproducer: https://drive.google.com/file/d/1FLDqzxv4t92J7EMPqQdkg6ca6XtZJhCd/view?usp=drive_link
Syzlang reproducer:
https://drive.google.com/file/d/1uPPRLIylpS116iXrlHMzKNga-fBwRAo1/view?usp=drive_link
Similar report:
https://groups.google.com/g/syzkaller-bugs/c/osuwOxyjReQ/m/-FJKSzllAQAJ

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

UBSAN: array-index-out-of-bounds in fs/reiserfs/journal.c:4166:22
index 1 is out of range for type '__le32 [1]'
CPU: 0 PID: 8058 Comm: syz-executor Not tainted 6.5.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd4/0xf0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xbf/0x100 lib/ubsan.c:348
 do_journal_end+0x3b3c/0x4750 fs/reiserfs/journal.c:4166
 reiserfs_sync_fs+0xe7/0x100 fs/reiserfs/super.c:78
 sync_filesystem fs/sync.c:56 [inline]
 sync_filesystem+0xef/0x250 fs/sync.c:30
 generic_shutdown_super+0x70/0x470 fs/super.c:472
 kill_block_super+0x60/0xb0 fs/super.c:1417
 deactivate_locked_super+0x85/0x140 fs/super.c:330
 deactivate_super+0x8c/0xa0 fs/super.c:361
 cleanup_mnt+0x28f/0x3b0 fs/namespace.c:1254
 task_work_run+0x153/0x230 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:297
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47afab
Code: 5f ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 b4 ff ff ff f7
d8 64 89 01 48 83 c8 ff c3 90 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 b4 ff ff ff f7 d8
RSP: 002b:00007ffe61655568 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00000000000001fc RCX: 000000000047afab
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007ffe61655610
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffe61655400
R10: 00000000025d1b03 R11: 0000000000000246 R12: 00007ffe616566d0
R13: 00000000025d1a70 R14: 0000000000000000 R15: 00007ffe61656710
 </TASK>
================================================================================

TITLE: kernel panic: UBSAN: panic_on_warn set ...
CORRUPTED: false ()
MAINTAINERS (TO): [reiserfs-devel@vger.kernel.org]
MAINTAINERS (CC): [linux-kernel@vger.kernel.org]

index 1 is out of range for type '__le32 [1]'
CPU: 0 PID: 8058 Comm: syz-executor Not tainted 6.5.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd4/0xf0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xbf/0x100 lib/ubsan.c:348
 do_journal_end+0x3b3c/0x4750 fs/reiserfs/journal.c:4166
 reiserfs_sync_fs+0xe7/0x100 fs/reiserfs/super.c:78
 sync_filesystem fs/sync.c:56 [inline]
 sync_filesystem+0xef/0x250 fs/sync.c:30
 generic_shutdown_super+0x70/0x470 fs/super.c:472
 kill_block_super+0x60/0xb0 fs/super.c:1417
 deactivate_locked_super+0x85/0x140 fs/super.c:330
 deactivate_super+0x8c/0xa0 fs/super.c:361
 cleanup_mnt+0x28f/0x3b0 fs/namespace.c:1254
 task_work_run+0x153/0x230 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:297
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47afab
Code: 5f ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 b4 ff ff ff f7
d8 64 89 01 48 83 c8 ff c3 90 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 b4 ff ff ff f7 d8
RSP: 002b:00007ffe61655568 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00000000000001fc RCX: 000000000047afab
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007ffe61655610
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffe61655400
R10: 00000000025d1b03 R11: 0000000000000246 R12: 00007ffe616566d0
R13: 00000000025d1a70 R14: 0000000000000000 R15: 00007ffe61656710
 </TASK>
================================================================================
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 0 PID: 8058 Comm: syz-executor Not tainted 6.5.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x92/0xf0 lib/dump_stack.c:106
 panic+0x570/0x620 kernel/panic.c:340
 check_panic_on_warn+0x8e/0x90 kernel/panic.c:236
 ubsan_epilogue lib/ubsan.c:223 [inline]
 __ubsan_handle_out_of_bounds+0xe7/0x100 lib/ubsan.c:348
 do_journal_end+0x3b3c/0x4750 fs/reiserfs/journal.c:4166
 reiserfs_sync_fs+0xe7/0x100 fs/reiserfs/super.c:78
 sync_filesystem fs/sync.c:56 [inline]
 sync_filesystem+0xef/0x250 fs/sync.c:30
 generic_shutdown_super+0x70/0x470 fs/super.c:472
 kill_block_super+0x60/0xb0 fs/super.c:1417
 deactivate_locked_super+0x85/0x140 fs/super.c:330
 deactivate_super+0x8c/0xa0 fs/super.c:361
 cleanup_mnt+0x28f/0x3b0 fs/namespace.c:1254
 task_work_run+0x153/0x230 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:297
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47afab
Code: 5f ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 b4 ff ff ff f7
d8 64 89 01 48 83 c8 ff c3 90 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 b4 ff ff ff f7 d8
RSP: 002b:00007ffe61655568 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00000000000001fc RCX: 000000000047afab
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007ffe61655610
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffe61655400
R10: 00000000025d1b03 R11: 0000000000000246 R12: 00007ffe616566d0
R13: 00000000025d1a70 R14: 0000000000000000 R15: 00007ffe61656710
 </TASK>
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
