Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0957EF484
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjKQOeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:34:07 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BBCC4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:34:03 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc274dbbc6so26137495ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700231643; x=1700836443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PdnjU7sTdz8hvsnyQk5JqfOcDigpFfNJS9tc47Xufc=;
        b=ngh4i6cqP/dBzItNX7LwH+HO5cXYqk3zbVX/wDyyaXy+r7POh1W8WfWYSQoHtbPyy9
         NGK/sN7RbfzgxewT2KRcj7L1M6J+IXkp0+u23hUtLYuOJngHOFAyCw2OPLdqGm9F6ugb
         l4vysyHKgL19vyU2gCw1lIEYtrrHD4SI2XBDYA4p5MAzyq0uMpasiRvV1RLOdARgpo0q
         Zb/fkx3DS9jtvaTh9QxlL9LeuIJZ8cIHPcBX06GxRvLXfgwruPLRW0fKaXwlu316arOZ
         Bu1CuBNh87kI6QWlz3cUD49u+7udextUXfGmiIVmNufqLRmoIYadOeSIDixnCYYcLUb0
         e9wg==
X-Gm-Message-State: AOJu0YzO4Hzn7PDljvLMVMFJgiBhIhwekDo/VMa7ewmXow6n3LSFn4pc
        g4qmpwRh7s/hKVlZ4xTtbq1OLtvK/LIIW5TuCCqzpIIoXuimTOk=
X-Google-Smtp-Source: AGHT+IEXuywtPuh+tfPiLrI/aXnKJhFm8vZyeUazcYie77TLcgtzLvxzo5jCvX5EbxBlx2mxtfrJ/lbRM0Cc0hEI0BCAHN2duodn
MIME-Version: 1.0
X-Received: by 2002:a17:903:181:b0:1cc:5db8:7ea5 with SMTP id
 z1-20020a170903018100b001cc5db87ea5mr3477370plg.3.1700231643396; Fri, 17 Nov
 2023 06:34:03 -0800 (PST)
Date:   Fri, 17 Nov 2023 06:34:03 -0800
In-Reply-To: <CAJjsb4qDbsdAo0_o9tVLpiu=EsqYM1qQ5EB+hQ1O02Ve_7U3fw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002406b8060a5a07cb@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_discard_allocated_blocks
From:   syzbot <syzbot+628e71e1cb809306030f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ext4_discard_allocated_blocks

EXT4-fs error (device loop0): ext4_read_block_bitmap_nowait:483: comm syz-executor.0: Invalid block bitmap block 0 in block_group 0
EXT4-fs error (device loop0): ext4_read_block_bitmap_nowait:483: comm syz-executor.0: Invalid block bitmap block 0 in block_group 0
------------[ cut here ]------------
ext4: mb_load_buddy failed (-117)
WARNING: CPU: 0 PID: 5495 at fs/ext4/mballoc.c:4608 ext4_discard_allocated_blocks+0x5d4/0x750 fs/ext4/mballoc.c:4607
Modules linked in:
CPU: 0 PID: 5495 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-00125-g7475e51b8796 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:ext4_discard_allocated_blocks+0x5d4/0x750 fs/ext4/mballoc.c:4607
Code: 00 0f 85 9a 01 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 0b 94 45 ff 48 c7 c7 a0 67 3d 8b 44 89 fe e8 3c 48 0b ff <0f> 0b 49 bf 00 00 00 00 00 fc ff df eb 98 e8 e9 93 45 ff e9 19 fe
RSP: 0018:ffffc90004d1ecc0 EFLAGS: 00010246
RAX: a3755e8be44c1900 RBX: 0000000000000001 RCX: ffff88801dd8bb80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90004d1edd0 R08: ffffffff81547c82 R09: 1ffff11017305172
R10: dffffc0000000000 R11: ffffed1017305173 R12: ffff88807ea2070c
R13: 1ffff920009a3da0 R14: ffff88807ea206c0 R15: 00000000ffffff8b
FS:  00007f9b08e776c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b08e35d58 CR3: 0000000025e06000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_new_blocks+0x148f/0x4b30 fs/ext4/mballoc.c:6207
 ext4_ext_map_blocks+0x1e13/0x7150 fs/ext4/extents.c:4285
 ext4_map_blocks+0xa2f/0x1cb0 fs/ext4/inode.c:621
 _ext4_get_block+0x238/0x6a0 fs/ext4/inode.c:763
 ext4_block_write_begin+0x537/0x1840 fs/ext4/inode.c:1053
 ext4_write_begin+0x619/0x10b0
 ext4_da_write_begin+0x300/0xa40 fs/ext4/inode.c:2875
 generic_perform_write+0x31b/0x630 mm/filemap.c:3918
 ext4_buffered_write_iter+0xc6/0x350 fs/ext4/file.c:299
 ext4_file_write_iter+0x1dc/0x19b0
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x792/0xb20 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f9b0807cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9b08e770c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9b0819bf80 RCX: 00007f9b0807cae9
RDX: 000000000000a000 RSI: 0000000020000780 RDI: 0000000000000005
RBP: 00007f9b080c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9b0819bf80 R15: 00007ffedf6eb3a8
 </TASK>


Tested on:

commit:         7475e51b Merge tag 'net-6.7-rc2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=166ceb84e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed401e778850d03c
dashboard link: https://syzkaller.appspot.com/bug?extid=628e71e1cb809306030f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
