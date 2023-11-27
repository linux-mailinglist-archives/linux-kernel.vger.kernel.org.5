Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA92C7F96C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 01:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjK0AIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 19:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjK0AH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 19:07:58 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47409FB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 16:08:05 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2856c8a8efaso3683679a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 16:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701043685; x=1701648485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tkBIbgZ57OxJx8kjfwz5riAFC6u1LX+QCCOVqP7YCE=;
        b=PifMpASy8rtHmib8dlrrvs6gKpIQp90nVMY/tbHY/7Hyjt5cddr4SpVXlSu7nJLVcm
         mv912Tty7DB00n7d5EAcPvWqjRgpNjQe8zRQODUL9NTaOw+SS8mfpBbyDbP6/gQxFt1I
         vwvJg3E/SbwoluG2wC7RO9LnXyVGdLFRmZeQAeAtFm3GA63ar44LA0Zl6xnJdbmlh5eF
         KY81wH7IS0LVONVR+hj9hX3Ov4aqGmmC6DxXKZ362wjL4TcI4EPU9kapvrTvPAUWaKNj
         0Qj+s/PsNUlw+bdF5Mb0mfTT7sqlmg5EszVimWTnueHCfTma7fjDMvi0kPobVlG53Zg3
         wGGw==
X-Gm-Message-State: AOJu0YxuhoKTCXj/njE7Nb3SMKdgSts+AUMqFlG+k2BnLPesPuvXMt6i
        r8mHCs7Wf4IEoK7mk/4tk+L5rZA348zJGChET3T1OWvMhlV+AxU=
X-Google-Smtp-Source: AGHT+IG/TEs2+A8m+qcWG1c9/qhf1LFLgEZDjMg1HMMJX+BEIho4dssB88phymmotk9W99kolXOe6QXgo4JmZguUW+8tBy63wnuE
MIME-Version: 1.0
X-Received: by 2002:a17:90b:30cb:b0:285:6211:6e1c with SMTP id
 hi11-20020a17090b30cb00b0028562116e1cmr2023123pjb.2.1701043684763; Sun, 26
 Nov 2023 16:08:04 -0800 (PST)
Date:   Sun, 26 Nov 2023 16:08:04 -0800
In-Reply-To: <GV1PR10MB656313700D176B6E69219809E8BEA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093f1c1060b1718dd@google.com>
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (2)
From:   syzbot <syzbot+dc6ed11a88fb40d6e184@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
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
WARNING in mark_buffer_dirty

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5493 at fs/buffer.c:1176 mark_buffer_dirty+0x37b/0x3f0 fs/buffer.c:1176
Modules linked in:
CPU: 1 PID: 5493 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00265-gd2da77f431ac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:mark_buffer_dirty+0x37b/0x3f0 fs/buffer.c:1176
Code: 89 ff e8 78 cb 89 ff 48 89 ef e8 50 6a e7 ff 5b 5d e9 69 cb 89 ff e8 64 cb 89 ff 90 0f 0b 90 e9 0c fe ff ff e8 56 cb 89 ff 90 <0f> 0b 90 e9 b1 fc ff ff e8 48 cb 89 ff 90 0f 0b 90 e9 ce fc ff ff
RSP: 0018:ffffc9000356ef18 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888067e452f8 RCX: ffffffff81fcb1bb
RDX: ffff88807ed5e1c0 RSI: ffffffff81fcb50a RDI: 0000000000000001
RBP: ffff888067e44700 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000012
R13: dffffc0000000000 R14: ffff888029428000 R15: ffffed100528502c
FS:  00007f564a9a36c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f564a9a3fe8 CR3: 0000000029a41000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bfs_move_block fs/bfs/file.c:43 [inline]
 bfs_move_blocks fs/bfs/file.c:56 [inline]
 bfs_get_block+0x3eb/0xeb0 fs/bfs/file.c:125
 __block_write_begin_int+0x3c0/0x1560 fs/buffer.c:2119
 __block_write_begin fs/buffer.c:2168 [inline]
 block_write_begin+0xb1/0x490 fs/buffer.c:2227
 bfs_write_begin+0x31/0xd0 fs/bfs/file.c:177
 generic_perform_write+0x278/0x600 mm/filemap.c:3918
 __generic_file_write_iter+0x1f9/0x240 mm/filemap.c:4013
 generic_file_write_iter+0xe3/0x350 mm/filemap.c:4039
 __kernel_write_iter+0x261/0x7b0 fs/read_write.c:517
 __kernel_write+0xf6/0x140 fs/read_write.c:537
 __dump_emit fs/coredump.c:813 [inline]
 dump_emit+0x21d/0x330 fs/coredump.c:850
 writenote+0x215/0x2b0 fs/binfmt_elf.c:1422
 write_note_info fs/binfmt_elf.c:1904 [inline]
 elf_core_dump+0x27f4/0x3900 fs/binfmt_elf.c:2064
 do_coredump+0x2c97/0x3fd0 fs/coredump.c:764
 get_signal+0x2438/0x2790 kernel/signal.c:2890
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0xa/0x40 kernel/entry/common.c:309
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 002b:0000000020000008 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f5649d9bf80 RCX: 00007f5649c7cae9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 00007f5649cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5649d9bf80 R15: 00007ffee518f008
 </TASK>


Tested on:

commit:         d2da77f4 Merge tag 'parisc-for-6.7-rc3' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=156441d8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aec35c1281ec0aaf
dashboard link: https://syzkaller.appspot.com/bug?extid=dc6ed11a88fb40d6e184
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
