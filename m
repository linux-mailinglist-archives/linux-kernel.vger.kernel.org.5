Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5270F7DA4E9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 04:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjJ1CzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 22:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjJ1CzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 22:55:08 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6057FAC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 19:55:06 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ccf7049ed4so3495288a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 19:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698461705; x=1699066505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aR2EYcdT/+ZYKuCi72uavc/IbUKXTNdVfdel1R8uEMY=;
        b=mbnDLfQ+cFro/QlueWe40+aIpdv9S6W4wTz1AKh1a2LGaQ2fBceybBF48PaEmD5HNB
         HMxqhOwdRhXCFH9j1+TzbNvhr2zAXon8/LO3iRITCxzU2nzkQe8NYkc4GlMwraMSoGrk
         POJbSb1xaI7xqmsqqswA4pSuZlnpoXNIXh5/07fR0or5FPevRyRClN1VOc1O1fmmsV+s
         HqIaoouRcGr30tk0VM8fy+lB1XsIkGxQuwgZZBfWCat0/eGjysS6+PgnKVXH2ekM0YPX
         A54tWZoz12WKH9bpIcFxhmOinHF4mliU1q5mzC7awgE6LxYaSq4eGn8DlcmQeV71Mi/2
         kgyg==
X-Gm-Message-State: AOJu0Yxxzg20FOw1wwqBh33kqXFHpDRTNHNdrtQaZ0/RPXal4lqLQr25
        msxcAZBGkS02DiiWiK44GwcqK9a0ceXl2eW0Fl47KWyM2jQJ
X-Google-Smtp-Source: AGHT+IFJ4m9Y2ajTgC8Ai7QWjnphs4APBhij6387uDcj417KGyi69yDZZY9OO4gVG7e6tsHJJ33bsJiUTiotu5zm0CeoBWEVhX02
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4198:b0:397:f54a:22d6 with SMTP id
 dj24-20020a056808419800b00397f54a22d6mr1232739oib.9.1698461705769; Fri, 27
 Oct 2023 19:55:05 -0700 (PDT)
Date:   Fri, 27 Oct 2023 19:55:05 -0700
In-Reply-To: <20231028011908.956-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a318600608bdee98@google.com>
Subject: Re: [syzbot] [net?] BUG: corrupted list in ptp_open
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: corrupted list in ptp_release

list_del corruption. prev->next should be ffff88806d1f9048, but was ffff88814ad945e8. (prev=ffff88814ad99048)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:62!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9040 Comm: syz-executor.1 Not tainted 6.6.0-rc6-next-20231020-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__list_del_entry_valid_or_report+0x11f/0x1b0 lib/list_debug.c:62
Code: 9f e9 8a e8 c3 a3 3a fd 0f 0b 48 89 ca 48 c7 c7 c0 9f e9 8a e8 b2 a3 3a fd 0f 0b 48 89 c2 48 c7 c7 20 a0 e9 8a e8 a1 a3 3a fd <0f> 0b 48 89 d1 48 c7 c7 a0 a0 e9 8a 48 89 c2 e8 8d a3 3a fd 0f 0b
RSP: 0018:ffffc90009f37e08 EFLAGS: 00010086
RAX: 000000000000006d RBX: ffff88806d1f8000 RCX: ffffffff816bb8d9
RDX: 0000000000000000 RSI: ffffffff816c4d42 RDI: 0000000000000005
RBP: ffff88807dbfcbe0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000001 R12: 0000000000000246
R13: ffff88806d1f9048 R14: ffff88806d1f9008 R15: ffff88806d1f9050
FS:  0000555556b75480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fec1cd98000 CR3: 00000000263b9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 ptp_release+0xc4/0x2b0 drivers/ptp/ptp_chardev.c:150
 posix_clock_release+0xa4/0x160 kernel/time/posix-clock.c:157
 __fput+0x270/0xbb0 fs/file_table.c:394
 __fput_sync+0x47/0x50 fs/file_table.c:475
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close fs/open.c:1575 [inline]
 __x64_sys_close+0x86/0xf0 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fec1cc7b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffc3d751870 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fec1cc7b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000032 R08: 0000001b2df60000 R09: 00007fec1cd9bf8c
R10: 00007ffc3d7519c0 R11: 0000000000000293 R12: 00007fec1c8000a8
R13: ffffffffffffffff R14: 00007fec1c800000 R15: 0000000000028903
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x11f/0x1b0 lib/list_debug.c:62
Code: 9f e9 8a e8 c3 a3 3a fd 0f 0b 48 89 ca 48 c7 c7 c0 9f e9 8a e8 b2 a3 3a fd 0f 0b 48 89 c2 48 c7 c7 20 a0 e9 8a e8 a1 a3 3a fd <0f> 0b 48 89 d1 48 c7 c7 a0 a0 e9 8a 48 89 c2 e8 8d a3 3a fd 0f 0b
RSP: 0018:ffffc90009f37e08 EFLAGS: 00010086
RAX: 000000000000006d RBX: ffff88806d1f8000 RCX: ffffffff816bb8d9
RDX: 0000000000000000 RSI: ffffffff816c4d42 RDI: 0000000000000005
RBP: ffff88807dbfcbe0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000001 R12: 0000000000000246
R13: ffff88806d1f9048 R14: ffff88806d1f9008 R15: ffff88806d1f9050
FS:  0000555556b75480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fec1cd98000 CR3: 00000000263b9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         20305791 Add linux-next specific files for 20231020
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16c52007680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37404d76b3c8840e
dashboard link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17bc6cfd680000

