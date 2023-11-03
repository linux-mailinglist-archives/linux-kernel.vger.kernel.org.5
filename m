Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31037E0052
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346183AbjKCHkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjKCHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:40:13 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46458134
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:40:07 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2d8caadfbso2110172b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 00:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698997206; x=1699602006;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvyh5xNr0Do/HLqwhKdaWfIgOLYaEzNDX2qmKXdsKvk=;
        b=MLOywOHcO8W0jN5jpQnAGtJBPrTHFhgK98whg+FMF9VISqORbWTI+5m8Ht+Kdg4npX
         DXSARsktNjkaJRQs4undQitsDTduklpsx/y6DgtzGMXmkA+PnR2ywtYZmI3nHIzep2K4
         p76WWjTsDLTXcFb33qL3T4srdrOSFA1lElXmNvPLTabpwbDSLg+xubMN5rmq5vF3HHVs
         9Pn71J3XAekgKfWVhdtLzA1TYL3SB4yuSNTzRH3jVsHeOtjXNpx/ehN+mW4Ifjf/QFVc
         mAJJo+gRnbHDiUWYumdbLDP7G6emsLqdcwYXoTLAyBCeh0KQ4+CnFiYZeAwfQpVBIukK
         F+Cw==
X-Gm-Message-State: AOJu0YxjNIoVG01uOsnp8dOdcqvXIUmjdiMp8mHU06qHFm0UWbVaWy1z
        Yi5720/AlgFx1yqXxgMdxSW6B1ih0zP3keh/+oyfuVbzLHLl
X-Google-Smtp-Source: AGHT+IH4SMo/Xkv32y4i/btbaAx3thwEvpMAeDeNh8NhTz/q/0e3KccTQj3J/1eFzqraOPkjNqyOn1LTfeLKcj9YZDxhkDEq+VJJ
MIME-Version: 1.0
X-Received: by 2002:a05:6808:360a:b0:3ad:29a4:f542 with SMTP id
 ct10-20020a056808360a00b003ad29a4f542mr508434oib.5.1698997206691; Fri, 03 Nov
 2023 00:40:06 -0700 (PDT)
Date:   Fri, 03 Nov 2023 00:40:06 -0700
In-Reply-To: <CAEt2hJ5MpDyGhxVX9OHhiA78xQNWMoKT+qL7SnkDA5tUNsWCDA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fab6b506093a9cc3@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diWrite
From:   syzbot <syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com>
To:     ghandatmanas@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in txUnlock

BUG at fs/jfs/jfs_txnmgr.c:931 assert(mp->nohomeok > 0)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:931!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 107 Comm: jfsCommit Not tainted 6.6.0-syzkaller-12401-g8f6f76a6a29f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:txUnlock+0xc6e/0xca0 fs/jfs/jfs_txnmgr.c:931
Code: 18 58 4b 07 0f 0b e8 f1 9a 7b fe 48 c7 c7 40 ed e2 8a 48 c7 c6 39 e9 e2 8a ba a3 03 00 00 48 c7 c1 20 fa e2 8a e8 f2 57 4b 07 <0f> 0b e8 cb 9a 7b fe 48 c7 c7 40 ed e2 8a 48 c7 c6 39 e9 e2 8a ba
RSP: 0018:ffffc90002cafce8 EFLAGS: 00010246
RAX: 0000000000000037 RBX: 0000000000000000 RCX: af7f11a66accc000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff888027157aa8 R08: ffffffff816e5b5c R09: 1ffff92000595f3c
R10: dffffc0000000000 R11: fffff52000595f3d R12: 0000000000000a06
R13: 0000000000000000 R14: ffffc90002802000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555660e938 CR3: 0000000027c28000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_lazycommit+0x5d4/0xb80 fs/jfs/jfs_txnmgr.c:2682
 kthread+0x2cd/0x360 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txUnlock+0xc6e/0xca0 fs/jfs/jfs_txnmgr.c:931
Code: 18 58 4b 07 0f 0b e8 f1 9a 7b fe 48 c7 c7 40 ed e2 8a 48 c7 c6 39 e9 e2 8a ba a3 03 00 00 48 c7 c1 20 fa e2 8a e8 f2 57 4b 07 <0f> 0b e8 cb 9a 7b fe 48 c7 c7 40 ed e2 8a 48 c7 c6 39 e9 e2 8a ba
RSP: 0018:ffffc90002cafce8 EFLAGS: 00010246
RAX: 0000000000000037 RBX: 0000000000000000 RCX: af7f11a66accc000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff888027157aa8 R08: ffffffff816e5b5c R09: 1ffff92000595f3c
R10: dffffc0000000000 R11: fffff52000595f3d R12: 0000000000000a06
R13: 0000000000000000 R14: ffffc90002802000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555660e938 CR3: 0000000026057000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         8f6f76a6 Merge tag 'mm-nonmm-stable-2023-11-02-14-08' ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1751405b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f696cf620c46c5db
dashboard link: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1022abe3680000

