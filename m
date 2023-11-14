Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EC57EB487
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjKNQLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjKNQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:11:10 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AEECA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:11:07 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-282d66095a4so6240153a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978266; x=1700583066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++6kxN1/uQJuTRGn9jUMzcXPyZxyKRXBJaDJqJ22rLc=;
        b=KQMx3L741iyyYX3QlNMe6z2hPhdf4H811+aJ9L3RWNPUwD5rmWYQsUpNNL6kxKIpSF
         MFbgms6bjPGIAwmX2tCQU9ZeOsfF3H4QWwmY3FBkjF8/e/k4HcBsbpJMpT9wEE+dSu4T
         nAY/1h+polpAxnnF13qhqey/vILpaMvp6NJffSTR85mwrYzRdfGU2LMMoIKre9BRv0Bj
         6lFLStKuGLNjSJNp8/nOCCJf7d5a47MxZbIv03E346kUmC26ryAZrWn5WSBYhNlJqrFY
         BJTignqBL9G4QOEV2wjBr21dx/YHvfxVeVUaK19zr+cpkCDRk8EaEg6gVjb4CE9jjKFk
         OUaQ==
X-Gm-Message-State: AOJu0Yx0LL1DJeQlb3rJitBaLriwgm8A/323B2SW90+w30is7/YvmpWO
        lX0A0oWOwqHeRiW1kRaHPtvRHDqC9iDTrY/wSgd0ejSsdtxK
X-Google-Smtp-Source: AGHT+IHpRo79FFzwNlcvD88sO2aAARJURm1Oo9PimDNZ+V4dKF6Jz430CgP81Kz27An1N2zk1GqAmkOdDuls0MASTPirB6nWEJOr
MIME-Version: 1.0
X-Received: by 2002:a17:90b:515:b0:27d:15e2:b248 with SMTP id
 r21-20020a17090b051500b0027d15e2b248mr2483137pjz.8.1699978266622; Tue, 14 Nov
 2023 08:11:06 -0800 (PST)
Date:   Tue, 14 Nov 2023 08:11:06 -0800
In-Reply-To: <58662b6bdb914d8c6411d0994e791d53@foxhound.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5419b060a1f086e@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in __pte_offset_map_lock
From:   syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>
To:     jose.pekkarinen@foxhound.fi, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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
BUG: unable to handle kernel paging request in __pte_offset_map_lock

Unable to handle kernel paging request at virtual address dfff800000000004
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000004] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 7577 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
lr : lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
sp : ffff8000980e6d40
x29: ffff8000980e7000 x28: ffff8000808f70a8 x27: ffff70001301ce18
x26: 1ffff00011c62088 x25: 0000000000000000 x24: 0000000000000000
x23: ffff70001301cdd0 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000022 x18: ffff8000980e7750
x17: 0000000000000000 x16: ffff80008a7375ec x15: 0000000000000001
x14: ffff80008e310448 x13: ffff8000980e6e80 x12: dfff800000000000
x11: ffff80008031ef10 x10: ffff80008e310444 x9 : 00000000000000f3
x8 : 0000000000000004 x7 : ffff8000808f70a8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000022
Call trace:
 __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __pte_offset_map_lock+0x154/0x288 mm/pgtable-generic.c:375
 pte_offset_map_lock include/linux/mm.h:2946 [inline]
 filemap_map_pages+0x5cc/0x112c mm/filemap.c:3531
 do_fault_around mm/memory.c:4586 [inline]
 do_read_fault mm/memory.c:4619 [inline]
 do_fault mm/memory.c:4762 [inline]
 do_pte_missing mm/memory.c:3730 [inline]
 handle_pte_fault mm/memory.c:5038 [inline]
 __handle_mm_fault mm/memory.c:5179 [inline]
 handle_mm_fault+0x35ec/0x49f8 mm/memory.c:5344
 faultin_page mm/gup.c:956 [inline]
 __get_user_pages+0x3e0/0xa24 mm/gup.c:1239
 populate_vma_page_range+0x254/0x328 mm/gup.c:1677
 __mm_populate+0x240/0x3d8 mm/gup.c:1786
 mm_populate include/linux/mm.h:3379 [inline]
 vm_mmap_pgoff+0x2bc/0x3d4 mm/util.c:551
 ksys_mmap_pgoff+0xd0/0x5b0 mm/mmap.c:1425
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Code: 900704a8 b9424108 34000208 d343fe68 (386c6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	900704a8 	adrp	x8, 0xe094000
   4:	b9424108 	ldr	w8, [x8, #576]
   8:	34000208 	cbz	w8, 0x48
   c:	d343fe68 	lsr	x8, x19, #3
* 10:	386c6908 	ldrb	w8, [x8, x12] <-- trapping instruction


Tested on:

commit:         b85ea95d Linux 6.7-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=174d171f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fffc11e84313b7c6
dashboard link: https://syzkaller.appspot.com/bug?extid=89edd67979b52675ddec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167d4a3f680000

