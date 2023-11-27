Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916447F96C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 01:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjK0ATD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 19:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjK0ATB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 19:19:01 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EE6113
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 16:19:05 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cf74396cbeso42658705ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 16:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701044345; x=1701649145;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhUvHV1+PRovYX9hJvBD2kPdim2HXfXexFcLWCB4XsM=;
        b=inpvOcDJyafiQMsDJASIS4OKuu3cynD/XNM6HVHc63TJ8pY1SZXfJeEdBKShAAamlW
         YlwX6B+OXKy5oz2zUmu8R19iNPUY+OUKP6eehjmGpiZLgmSLOLxT3dNQ/PlxhaAsrzQ5
         4ve+eXZrfDzcBu4KSu87s9sR/H+qqbO+8pBsMVhMXFUPZpySeTdcF2ZfJxmCwKbvNZBK
         ipKIpuTzp+AoVnewH81SHHtWI7sV89p2XwqZNsoJvQ/sjcq61rBcrWladymcGwC/cvzV
         ZWD5lyQhTdukn8h6zdfoBkEBICsZ9wEnf0WuaT3DHNhLblexj53lvMu+IFKdQ/9PS5Hu
         KTEA==
X-Gm-Message-State: AOJu0YwKPe0N7MfdcpChhksML+dVb1Xuw2onRpvVT83/S9iu06wMM49S
        fIKTeZ0jmbRJMk5BQJdNNNRMxFWz7WVauRqEsLuVsUQG2oT2Nig=
X-Google-Smtp-Source: AGHT+IGyctu9gdeCs6orXWPItXorPIis1aQOLh/7j4xd7J7Lt+5eB5lNkHcpPsI0eg/b/d7A1bMsBp3qljbckbeFn1iIb0owtu05
MIME-Version: 1.0
X-Received: by 2002:a17:902:8e89:b0:1cf:68c3:3c7c with SMTP id
 bg9-20020a1709028e8900b001cf68c33c7cmr2151711plb.6.1701044345104; Sun, 26 Nov
 2023 16:19:05 -0800 (PST)
Date:   Sun, 26 Nov 2023 16:19:04 -0800
In-Reply-To: <GV1PR10MB6563C810A9C42F44E4417376E8BEA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eff24f060b173ffe@google.com>
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
WARNING: CPU: 0 PID: 5488 at fs/buffer.c:1176 mark_buffer_dirty+0x37b/0x3f0 fs/buffer.c:1176
Modules linked in:
CPU: 0 PID: 5488 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00265-gd2da77f431ac-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:mark_buffer_dirty+0x37b/0x3f0 fs/buffer.c:1176
Code: 89 ff e8 78 cb 89 ff 48 89 ef e8 50 6a e7 ff 5b 5d e9 69 cb 89 ff e8 64 cb 89 ff 90 0f 0b 90 e9 0c fe ff ff e8 56 cb 89 ff 90 <0f> 0b 90 e9 b1 fc ff ff e8 48 cb 89 ff 90 0f 0b 90 e9 ce fc ff ff
RSP: 0018:ffffc9000381efc8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888070b933e0 RCX: ffffffff81fcb1bb
RDX: ffff888029eec100 RSI: ffffffff81fcb50a RDI: 0000000000000001
RBP: ffff888070b93300 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000013
R13: dffffc0000000000 R14: ffff888029be2000 R15: ffffed100537c403
FS:  00007fe0721f36c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000001ffffe40 CR3: 0000000029e95000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bfs_move_block fs/bfs/file.c:48 [inline]
 bfs_move_blocks fs/bfs/file.c:61 [inline]
 bfs_get_block+0x41b/0xe90 fs/bfs/file.c:130
 __block_write_begin_int+0x3c0/0x1560 fs/buffer.c:2119
 __block_write_begin fs/buffer.c:2168 [inline]
 block_write_begin+0xb1/0x490 fs/buffer.c:2227
 bfs_write_begin+0x31/0xd0 fs/bfs/file.c:182
 generic_perform_write+0x278/0x600 mm/filemap.c:3918
 __generic_file_write_iter+0x1f9/0x240 mm/filemap.c:4013
 generic_file_write_iter+0xe3/0x350 mm/filemap.c:4039
 __kernel_write_iter+0x261/0x7b0 fs/read_write.c:517
 __kernel_write+0xf6/0x140 fs/read_write.c:537
 __dump_emit fs/coredump.c:813 [inline]
 dump_emit+0x21d/0x330 fs/coredump.c:850
 elf_core_dump+0x21bc/0x3900 fs/binfmt_elf.c:2056
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
RAX: 0000000000000000 RBX: 00007fe07159bf80 RCX: 00007fe07147cae9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 00007fe0714c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe07159bf80 R15: 00007ffe7a2118b8
 </TASK>


Tested on:

commit:         d2da77f4 Merge tag 'parisc-for-6.7-rc3' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16ec3052e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aec35c1281ec0aaf
dashboard link: https://syzkaller.appspot.com/bug?extid=dc6ed11a88fb40d6e184
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146bba62e80000

