Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B09D77A492
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 03:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjHMBed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 21:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 21:34:32 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00197E6C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 18:34:34 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26b10d67487so2806803a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 18:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691890474; x=1692495274;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftXAVMyGGIJKgNjCt9ne8ax5LBGW8zpfwqSKCNafOpY=;
        b=JyC6VUga7ZCeWn+CqTiAnl3MVDy1WZ6E8Bm1/1H4ovDdZlpxSoFtsAww7sv7Q8cOaq
         Y2TScqBau1a5XDWxGB5lqByrV5vxm2Q9bO8ncGXq3X09hqfAmxrXQqDzS3Z0iInKh5Ov
         PVRzgvD2OFLvp/NnDHG2O7+2gpui97B9ruiy7VKboNLAljYz7J7CrscXhviJdYJBHQ/V
         RtFnZHRmwyymVn5cWmLe6Ii9oe4G6UccMlYQtqRbmHOOi9mckVcUm5Sjcg9gahsbGJEM
         uY4ZkIQv2B5AfzSRvIW/5UksyZ76BLUDZ6yCbwDnxPnBV331Rdfos8OmL0+LBGSXW2u7
         PDZg==
X-Gm-Message-State: AOJu0YwILEI+X6T41jEqxeImb52m+jTA+TajcRuA8GUKJ3vol71Ipi/G
        GR7tgnpJCNBrSqFv4HYrG1gLyn2ISQqLmV0RSoZOh2raSlh9
X-Google-Smtp-Source: AGHT+IH5haRrYrGeSv87wbXQOESKxwrHRUyWAwNm/PrxkGna/I1tvRICIIIcegLovW8lU7pYLsiF5EpbltpeTxMwI4/c/cRPI+AM
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1395:b0:687:3aa0:9010 with SMTP id
 t21-20020a056a00139500b006873aa09010mr2698899pfg.5.1691890474476; Sat, 12 Aug
 2023 18:34:34 -0700 (PDT)
Date:   Sat, 12 Aug 2023 18:34:34 -0700
In-Reply-To: <20230813010800.1071-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000baea640602c3f2e9@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_sync_fs
From:   syzbot <syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in udf_sync_fs

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5372 at fs/udf/super.c:2341 udf_sync_fs+0x321/0x450
Modules linked in:
CPU: 1 PID: 5372 Comm: syz-executor.0 Not tainted 6.5.0-rc5-syzkaller-00296-gf8de32cc060b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:udf_sync_fs+0x321/0x450 fs/udf/super.c:2340
Code: 04 25 28 00 00 00 48 3b 84 24 80 00 00 00 0f 85 34 01 00 00 31 c0 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 cf ad 88 fe <0f> 0b e9 78 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 8c fd ff
RSP: 0018:ffffc900064b7be0 EFLAGS: 00010293
RAX: ffffffff83030a61 RBX: 0000000000000200 RCX: ffff888022cabb80
RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000004e25
RBP: ffffc900064b7cb0 R08: ffffffff830308d2 R09: 1ffffffff1d30e8d
R10: dffffc0000000000 R11: fffffbfff1d30e8e R12: 0000000000004e25
R13: ffff88802baba018 R14: ffffc900064b7c40 R15: ffff8880679f7000
FS:  0000555555808480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555811938 CR3: 000000002b2fe000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sync_filesystem+0xec/0x220 fs/sync.c:56
 generic_shutdown_super+0x6f/0x340 fs/super.c:472
 kill_block_super+0x68/0xa0 fs/super.c:1417
 deactivate_locked_super+0xa4/0x110 fs/super.c:330
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f506367de17
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc04cedad8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f506367de17
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc04cedb90
RBP: 00007ffc04cedb90 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffc04ceec50
R13: 00007f50636c73b9 R14: 0000000000014bdb R15: 0000000000000007
 </TASK>


Tested on:

commit:         f8de32cc Merge tag 'tpmdd-v6.5-rc7' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=134267c3a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
dashboard link: https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13debc65a80000

