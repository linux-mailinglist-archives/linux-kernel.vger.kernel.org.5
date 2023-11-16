Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA237EDC75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjKPH7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPH7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:59:08 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC25199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:59:04 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc5ef7e815so6371425ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700121544; x=1700726344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnA8iHs7xq1KZM8kvqlqtG/0prEjsL1oVNKyjAcmm0c=;
        b=tfBhD4oYH5gWR5pwjkbpAsE46mD0zNCZCNNUPy6Td1ELfQtBZKz1gV8/0qZV8jE9hq
         p6EGsFU+88sPP3KAJ5KkH9BqD2c5dI8Pj2Wt9wxkePSvbPSecZtSpmcvExo9HLq31WTd
         Y5onpsFYAdwhfJCHkF6/R6OW9jEMPl45PX/iciIW4IObhDe4uAMCgw9pgGaOscJyXpMd
         hIY0pTLuLPPpjBj+MwRciIs0RA8W6xQU35FB1/+e6CWjRWReBS3IQV1My79ydpfh9Jlc
         315WGKKf8cqkTvLoAq1lGwwx9GN3bqgYIygOvUKi9cCP7FGQvSniOLVnMlP9X3R2ohhe
         GGAg==
X-Gm-Message-State: AOJu0YzH411hs+oIXY+8jOnEc88nAc7D5ZmspbzETVfeNomSTFEGAm/E
        +wkHcmILW4TyJXY8aoq8f3hR5pMBA29jNx7XkrUiOT2/pr93
X-Google-Smtp-Source: AGHT+IHmQP75bQ2q7dOV/S2dLZYETfFJrRugHitc6r4h+klWC8VIAXi0M1AO5FyyCidd0b8g+mSwdxvk44J2e2ArOjc2TpsRA1Ed
MIME-Version: 1.0
X-Received: by 2002:a17:903:258a:b0:1cc:1389:512e with SMTP id
 jb10-20020a170903258a00b001cc1389512emr2008274plb.4.1700121544358; Wed, 15
 Nov 2023 23:59:04 -0800 (PST)
Date:   Wed, 15 Nov 2023 23:59:04 -0800
In-Reply-To: <c659f5c9-5e4f-0aac-7d1c-ee3be4740a0d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba0007060a40644f@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in __pte_offset_map_lock
From:   syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com, jannh@google.com,
        jose.pekkarinen@foxhound.fi, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
CPU: 0 PID: 6731 Comm: syz-executor.5 Not tainted 6.7.0-rc1-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
lr : lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
sp : ffff800097066d40
x29: ffff800097067000 x28: ffff8000808f70ac x27: ffff700012e0ce18
x26: 1ffff00011c64088 x25: 0000000000000000 x24: 0000000000000000
x23: ffff700012e0cdd0 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000022 x18: ffff800097067750
x17: ffff80008e31d000 x16: ffff80008a73b6ac x15: 0000000000000001
x14: ffff80008e320448 x13: ffff800097066e80 x12: dfff800000000000
x11: ffff80008031ef10 x10: ffff80008e320444 x9 : 00000000000000f3
x8 : 0000000000000004 x7 : ffff8000808f70ac x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000022
Call trace:
 __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __pte_offset_map_lock+0x154/0x360 mm/pgtable-generic.c:378
 pte_offset_map_lock include/linux/mm.h:2946 [inline]
 filemap_map_pages+0x5cc/0x112c mm/filemap.c:3531
 do_fault_around mm/memory.c:4588 [inline]
 do_read_fault mm/memory.c:4621 [inline]
 do_fault mm/memory.c:4764 [inline]
 do_pte_missing mm/memory.c:3732 [inline]
 handle_pte_fault mm/memory.c:5040 [inline]
 __handle_mm_fault mm/memory.c:5181 [inline]
 handle_mm_fault+0x35ec/0x49f8 mm/memory.c:5346
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
Code: 90070528 b9424108 34000208 d343fe68 (386c6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	90070528 	adrp	x8, 0xe0a4000
   4:	b9424108 	ldr	w8, [x8, #576]
   8:	34000208 	cbz	w8, 0x48
   c:	d343fe68 	lsr	x8, x19, #3
* 10:	386c6908 	ldrb	w8, [x8, x12] <-- trapping instruction


Tested on:

commit:         b85ea95d Linux 6.7-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14cf3388e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fffc11e84313b7c6
dashboard link: https://syzkaller.appspot.com/bug?extid=89edd67979b52675ddec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136db347680000

