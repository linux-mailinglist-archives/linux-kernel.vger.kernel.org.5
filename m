Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7059576849A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjG3JNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 05:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjG3JNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 05:13:38 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE91BC3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 02:13:36 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a6e180e49aso6852593b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 02:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690708416; x=1691313216;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S61doRoyeIk8auuoxuz1WSrAQKke6YmofOVN7Avw2fA=;
        b=aZl3326pTBGctMzlbwI2T0+o8r8jOIEJTbII4gZeIV4QeyXBUmnajdSF+F5fHdFr1W
         H/RS9Tbld4M/3Blzbec/FfRx93NmKwudzyLUx0ycIjLHNjZiGq8aKiYSNi9uPBS7ITVA
         eGzWkng3ZQyjegSSnTDiGolnkHklgpPGFb0FIG3JsVH/CPUHY4oU08S67oaZWuC5Rnln
         M4Vr7is6Pd3yMOrelr5H+7fPgDnsEQOITxNeh1/LVAcDyEu0WP4IbAA54recdO8IdeN+
         C0NAJDUpK/OXOBFPRE3q4z3FHcgd3EQI7SCIKoXbhevz9hpD5jM21m0NlQRWmG/yRJL2
         iI5Q==
X-Gm-Message-State: ABy/qLadrYLKX0Zlop9eq08ET1j0f1u3GyCWaiz43dp1puTdNoFJGZYD
        jQRm2gyK9tEd6e1+5kQ0UqnRPiEPSWTJ8M9BmfjNf6yI/YVH
X-Google-Smtp-Source: APBJJlHA6WaQH9Nyt6cMT7Jzkl4yEgvTny2P5B37iozIJComYOtDx9VrAuZ9mb22G6nOj5hxRkmUsEjCnmUgSWraWVOuA1RnAZpG
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1818:b0:3a2:4d1d:2831 with SMTP id
 bh24-20020a056808181800b003a24d1d2831mr12968602oib.3.1690708416204; Sun, 30
 Jul 2023 02:13:36 -0700 (PDT)
Date:   Sun, 30 Jul 2023 02:13:36 -0700
In-Reply-To: <20230730084547.1164-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000911a550601b0baa6@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in rfkill_unregister (3)
From:   syzbot <syzbot+bb540a4bbfb4ae3b425d@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: corrupted list in nfc_llcp_register_device

list_add corruption. next->prev should be prev (ffff800090c7cc20), but was dead000000000122. (next=ffff0000e3ceb000).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 13850 Comm: syz-executor304 Not tainted 6.5.0-rc3-syzkaller-00297-gd31e3792919e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_add_valid+0xf4/0x110 lib/list_debug.c:27
lr : __list_add_valid+0xf4/0x110 lib/list_debug.c:27
sp : ffff80009ec57320
x29: ffff80009ec57320 x28: dfff800000000000 x27: 1fffe0001c79dc0d
x26: 1fffe00019d23801 x25: 1fffe00019d23800 x24: dfff800000000000
x23: dfff800000000000 x22: ffff0000e3ceb008 x21: ffff0000ce91c000
x20: ffff800090c7cc20 x19: ffff0000e3ceb000 x18: ffff80009ec56980
x17: 3032636337633039 x16: ffff80008a56521c x15: 0000000000000001
x14: 1ffff00013d8adbc x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0b5847480dd8ce00
x8 : 0b5847480dd8ce00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009ec56c38 x4 : ffff80008e14ef00 x3 : ffff800082ad14b8
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000075
Call trace:
 __list_add_valid+0xf4/0x110 lib/list_debug.c:27
 __list_add include/linux/list.h:69 [inline]
 list_add include/linux/list.h:88 [inline]
 nfc_llcp_register_device+0x58c/0x6bc net/nfc/llcp_core.c:1639
 nfc_register_device+0x88/0x2e4 net/nfc/core.c:1125
 nci_register_device+0x6ac/0x7c4 net/nfc/nci/core.c:1257
 virtual_ncidev_open+0x13c/0x1bc drivers/nfc/virtual_ncidev.c:148
 misc_open+0x2f0/0x368 drivers/char/misc.c:165
 chrdev_open+0x3e8/0x4fc fs/char_dev.c:414
 do_dentry_open+0x710/0x11b8 fs/open.c:914
 vfs_open+0x7c/0x90 fs/open.c:1048
 do_open fs/namei.c:3636 [inline]
 path_openat+0x1f2c/0x27f8 fs/namei.c:3793
 do_filp_open+0x1bc/0x3cc fs/namei.c:3820
 do_sys_openat2+0x124/0x1b8 fs/open.c:1407
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_openat fs/open.c:1438 [inline]
 __se_sys_openat fs/open.c:1433 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1433
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 91098000 aa1403e1 aa1303e3 95e86b4d (d4210000) 
---[ end trace 0000000000000000 ]---


Tested on:

commit:         d31e3792 Merge tag '6.5-rc3-smb3-client-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14847039a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32bbbdc67cf060fa
dashboard link: https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142be711a80000

