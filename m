Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6E7EB695
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjKNStK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjKNStJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:49:09 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55560FA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:49:06 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc0e3a2b6eso63802075ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699987746; x=1700592546;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HT+yXdfhO+0A5TqXgo1XdwiEqjD57vxnZV2hKKHD+aA=;
        b=s57nT69oHDhMT3WvLo+6JQu6nmU04OdLpf5tUjikrpesoyngccWKTQvnBzl9i1YdoV
         34o6l8ml/pgfFeXNpQ/VEH1xlVbqn9sfQOEqIfvxBqc3Ff0xVuvE/DdBwNevHhhxvYo3
         1q37ZOhhY11su5XIExwbWxIab2aWS3p5OJxV5AwKpVfLl+Ujsjkz4VABv/vnE3bRnNGQ
         0SgU70TCxwbaUTeYZ2iYTVlyC0fh/9vz+1Twx6EDa+lRxIUFq59vbR6sNxQNYoa7PCfR
         HemCS3KQ5HbhhfjUANEDcx6cppweUmg/YYX/IW9v9hCUIbJTQZNkocl+j4DQ1m/HOqEH
         xBGQ==
X-Gm-Message-State: AOJu0YwaDaQQpdJKsCYrtrAURWXMl4XgsCgDvw93cILG2icyPRzEMvVO
        lKUgMjkISffTuDEQsGZHFDmGsXeozuoe17Mb7To6BXew/8xa
X-Google-Smtp-Source: AGHT+IGDSgAqFiFmKxknBVDq7xjynFu9n9RqXpGgxpRc3xARHq3ruQ3Wl3XDH+q145MB44iJT3XOL2eYM7AEAF8z5NA0MKZuABPy
MIME-Version: 1.0
X-Received: by 2002:a17:902:efc2:b0:1cc:70f2:c1d5 with SMTP id
 ja2-20020a170902efc200b001cc70f2c1d5mr780490plb.11.1699987745870; Tue, 14 Nov
 2023 10:49:05 -0800 (PST)
Date:   Tue, 14 Nov 2023 10:49:05 -0800
In-Reply-To: <aa2ae5537093181aac903a420c029113@foxhound.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b71a62060a213dfe@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in __pte_offset_map_lock
From:   syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>
To:     jose.pekkarinen@foxhound.fi, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
CPU: 1 PID: 7876 Comm: syz-executor.4 Not tainted 6.7.0-rc1-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
lr : lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
sp : ffff800099b16d40
x29: ffff800099b17000 x28: ffff8000808f718c x27: ffff700013362e18
x26: 1ffff00011c62088 x25: 0000000000000000 x24: 0000000000000000
x23: ffff700013362dd0 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000022 x18: ffff800099b17750
x17: 0000000000000000 x16: ffff80008a7389ec x15: 0000000000000001
x14: ffff80008e310448 x13: ffff800099b16e80 x12: dfff800000000000
x11: ffff80008031ef10 x10: ffff80008e310444 x9 : 00000000000000f3
x8 : 0000000000000004 x7 : ffff8000808f718c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000022
Call trace:
 __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __pte_offset_map_lock+0x158/0x294 mm/pgtable-generic.c:375
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1052c057680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fffc11e84313b7c6
dashboard link: https://syzkaller.appspot.com/bug?extid=89edd67979b52675ddec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1071c13f680000

