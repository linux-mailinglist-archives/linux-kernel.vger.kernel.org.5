Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E08787CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbjHYBIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbjHYBIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:08:37 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3A519BB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:08:35 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26d3d868529so389561a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692925715; x=1693530515;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dCcBtXWiWPSYXsQYLuq3iTu3I5/TeQSFgSM9sONk/k=;
        b=h3bkohcXXImhdItW8CqypJaGfGxnc/l3PLjNf14LW4yWpcriGIPgSBN3X0ucUzL9/9
         bHPHpsnMa4tkPISxp71/F1sUGReEJcglNTYQqUyU+sfeJtAsw/JavslG7ciW68MEMppJ
         bSDz3x01Ds06xtu4uoqEf8PQRYOReHcEX3j8O+fu5uN6pn2KWX+O9PyQdMB15sffClww
         7xNqlXu8sMz2xsEcq+FZow9RZeaiCiDTlB8A/XTm5yg8jOONAqvUzeJL3aQ4N9ORCO2U
         bTT1Ao2HIer2wFgkxGuourJEm3yYPSZuMqGL7qVeZfkm3u2K522eAu5vVCNyPV2qnpGp
         DqAg==
X-Gm-Message-State: AOJu0YxyuIE+abtfw7wVW+9gjUAagVliFcFX3azx4bSInMAIu+sF+uE8
        DtjH8SwpDCfw9hyNeQvL8xDJCAEx2smHSDhmmeRtHA8nNqzF
X-Google-Smtp-Source: AGHT+IGsTCsdgvcfi7HoJRDvPTgY4swUryTP9RG3+0zAXEj1ww50udADvVEtezY+FIIXPCUItk6edHumXDBUapBXJk1Qc7PJk/v9
MIME-Version: 1.0
X-Received: by 2002:a17:90a:f2c1:b0:26d:323c:a9b4 with SMTP id
 gt1-20020a17090af2c100b0026d323ca9b4mr4320373pjb.3.1692925714997; Thu, 24 Aug
 2023 18:08:34 -0700 (PDT)
Date:   Thu, 24 Aug 2023 18:08:34 -0700
In-Reply-To: <20230824225837.3040-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfaa110603b4fbda@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
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
WARNING in l2cap_chan_del

------------[ cut here ]------------
WARNING: CPU: 0 PID: 780 at kernel/workqueue.c:1725 __queue_work+0xb52/0x1060 kernel/workqueue.c:1724
Modules linked in:
CPU: 0 PID: 780 Comm: kworker/0:2 Not tainted 6.5.0-rc6-next-20230818-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events l2cap_chan_timeout
RIP: 0010:__queue_work+0xb52/0x1060 kernel/workqueue.c:1724
Code: 03 38 d0 7c 09 84 d2 74 05 e8 ea 54 87 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 5b cf 31 00 85 db 0f 85 7f 01 00 00 e8 de d3 31 00 <0f> 0b e9 ca fa ff ff e8 d2 d3 31 00 0f 0b e9 76 fa ff ff e8 c6 d3
RSP: 0018:ffffc900046d7ac8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff888013650000 RCX: 0000000000000000
RDX: ffff88801d4d1dc0 RSI: ffffffff8155ff92 RDI: ffff888013650008
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000200000 R11: 0000000000000000 R12: ffff88806a634270
R13: ffffffff81dd2d93 R14: ffff88806a6342b8 R15: ffffffff81dd2d93
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f98dec6b6c0 CR3: 000000000c976000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __queue_delayed_work+0x1bf/0x260 kernel/workqueue.c:1950
 queue_delayed_work_on+0x106/0x130 kernel/workqueue.c:1986
 queue_delayed_work include/linux/workqueue.h:569 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1549 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1519 [inline]
 l2cap_chan_del+0x389/0x9b0 net/bluetooth/l2cap_core.c:659
 l2cap_chan_close+0xff/0xa20 net/bluetooth/l2cap_core.c:842
 l2cap_chan_timeout+0x17d/0x2f0 net/bluetooth/l2cap_core.c:452
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


Tested on:

commit:         7271b2a5 Add linux-next specific files for 20230818
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1333e4dfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1361735ba80000

