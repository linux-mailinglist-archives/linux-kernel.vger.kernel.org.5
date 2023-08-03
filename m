Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B562976E3B3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjHCI4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjHCI4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:56:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC69E57
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:56:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so10382211fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691052976; x=1691657776;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xPtx3A5jQsXRpizvYaftyisJzQjgAMgHVhDt5G0UMmo=;
        b=kq8V9ZbENfF3VnfYRJ9egcACIJ7aUSUnJX1RTQOpAEG/exUYTcRtvTyre4RROgBTvS
         qsrHZ6vugGCDb42/mOyVXkajosEDO1y+Ew89ZIlVy6JYQkuTUF54mj9beYCn1lRJMNwz
         gAiP+KMU2w0VIdLUuzRu1eP9pMzApBMsBK/f/HxhfxuMpp5NmEme+hBKyFsnXDp905K8
         Mjwl/prbxxCxocHTxVQbOOc3vZXkUYytYXTA2RG3co36j7GwTaFP9XxzZls+tms5kdP8
         fFc1ZlbwCdYfKGOk6oWWCiKpxw2qRPnfPDG49o3WlSnGTC/5B/VilkwBkwt6fgmADlyy
         /rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052976; x=1691657776;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPtx3A5jQsXRpizvYaftyisJzQjgAMgHVhDt5G0UMmo=;
        b=SCyj43Veqo4eIxUdsneStXKZHyViQEjO1RfztLOd7lwIovY0bpF7Ro1q4lVb1gYIvb
         sNGedCvC0mpE8BRK55omuha/hf5wXeqrC14zYZaaqmJP4U5nnt4LbCADUYi0jz6bxpJo
         7B6ZkBJHgwpKr5CWy755P1Pf7o0g3N0M3g/WnQx+QF0Vl6Yg2kgQIH3brflBj91Iflvs
         5PMecZKP1wq5BMLXcYoPgOLwPUm5iAvvywc9qSpMI8zOQo/CDOq8dfWR6oEIUXcWRHrt
         y3gxZ3bnKOjDi0WYUlZNr0scKEHpj683/6H8vw4rYzrdnjpWphj5+OiEksxf062uFSX8
         bWDA==
X-Gm-Message-State: ABy/qLa4M1B5QxUh/+H0UbGRPL4T5hvuAHpLZ2sUHnKzpzIYBMzXJ++2
        RtWIY3wn10aFzfRm+iyl/2PBoKKZLH1CdkO9v5ksr74l5QY=
X-Google-Smtp-Source: APBJJlFngGKzsmqVPas6vZTcZ5oaooqs3axRTekNwzlbDcxKywYV6r7A/3Rf0/QNIQpGmi5UMTKon5iW4o5aVVWPwcA=
X-Received: by 2002:a2e:b604:0:b0:2b9:b6e7:bd7 with SMTP id
 r4-20020a2eb604000000b002b9b6e70bd7mr7515637ljn.29.1691052975739; Thu, 03 Aug
 2023 01:56:15 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Thu, 3 Aug 2023 16:56:03 +0800
Message-ID: <CALcu4rbFsnB5hsiv310tRNNBioLve0n553O1cX1mS9+HdA8r+w@mail.gmail.com>
Subject: WARNING in try_grab_page
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the Linux kernel, the following crash
was triggered on:

HEAD commit: fdf0eaf11452d72945af31804e2a1048ee1b574c (tag: v6.5-rc2)

git tree: upstream

I tried to reproduce this bug on v6.5-rc3(HEAD commit:
6eaae198076080886b9e7d57f4ae06fa782f90ef), it still exists.

console output:
https://drive.google.com/file/d/1Lq71bFwtEDix82PEf_193CLG6uh1Pjj9/view?usp=drive_link
kernel config: https://drive.google.com/file/d/1dApy7OR4KDYdhF96ZUowZQ1r-uLYTd-0/view?usp=drive_link
C reproducer: https://drive.google.com/file/d/1Dkj31wwYP7p-AEJeemD3yrIUr7-VdBqF/view?usp=drive_link
Syzlang reproducer:
https://drive.google.com/file/d/1ib6zTs4srKI1RnUcHG3mSZ5HeW7rZhnd/view?usp=drive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

WARNING: CPU: 0 PID: 10232 at mm/gup.c:229 try_grab_page+0x2dd/0x3a0
mm/gup.c:229
Modules linked in:
CPU: 0 PID: 10232 Comm: syz-executor Tainted: G    B              6.5.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:try_grab_page+0x2dd/0x3a0 mm/gup.c:229
Code: ff be 04 00 00 00 4c 89 e7 e8 cf fa 13 00 f0 41 ff 04 24 e8 65
96 cb ff 45 31 e4 5b 44 89 e0 5d 41 5c 41 5d c3 e8 53 96 cb ff <0f> 0b
e8 4c 96 cb ff 41 bc f4 ff ff ff 5b 44 89 e0 5d 41 5c 41 5d
RSP: 0018:ffffc9000e99f268 EFLAGS: 00010202
RAX: 0000000000002f80 RBX: ffffea00003ae340 RCX: ffffc90002d79000
RDX: 0000000000040000 RSI: ffffffff81ad81ed RDI: ffffea00003ae374
RBP: ffffea00003ae340 R08: 0000000000000000 R09: fffff94000075c6e
R10: ffffea00003ae377 R11: 0000000000000000 R12: ffffea00003ae374
R13: 0000000000210052 R14: ffffea00003ae340 R15: 000000000eb8d225
FS:  00007fc6339a4640(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002c3ea000 CR4: 0000000000752ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 follow_page_pte+0x18c/0x1610 mm/gup.c:651
 follow_pmd_mask mm/gup.c:727 [inline]
 follow_pud_mask mm/gup.c:765 [inline]
 follow_p4d_mask mm/gup.c:782 [inline]
 follow_page_mask+0x2e4/0xbd0 mm/gup.c:839
 __get_user_pages+0x3fa/0xcf0 mm/gup.c:1256
 __get_user_pages_locked mm/gup.c:1487 [inline]
 get_user_pages_unlocked+0x183/0x580 mm/gup.c:2387
 hva_to_pfn_slow arch/x86/kvm/../../../virt/kvm/kvm_main.c:2536 [inline]
 hva_to_pfn+0x198/0xbc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2674
 __gfn_to_pfn_memslot+0x202/0x3e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2736
 __kvm_faultin_pfn arch/x86/kvm/mmu/mmu.c:4329 [inline]
 kvm_faultin_pfn+0x21b/0x12d0 arch/x86/kvm/mmu/mmu.c:4365
 kvm_tdp_mmu_page_fault arch/x86/kvm/mmu/mmu.c:4503 [inline]
 kvm_tdp_page_fault+0x167/0x4d0 arch/x86/kvm/mmu/mmu.c:4549
 kvm_mmu_do_page_fault arch/x86/kvm/mmu/mmu_internal.h:320 [inline]
 kvm_mmu_page_fault+0x2f4/0x1a40 arch/x86/kvm/mmu/mmu.c:5756
 handle_ept_violation+0x20a/0x620 arch/x86/kvm/vmx/vmx.c:5760
 __vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6539 [inline]
 vmx_handle_exit+0x4a1/0x18d0 arch/x86/kvm/vmx/vmx.c:6556
 vcpu_enter_guest arch/x86/kvm/x86.c:10848 [inline]
 vcpu_run+0x24b6/0x44b0 arch/x86/kvm/x86.c:10951
 kvm_arch_vcpu_ioctl_run+0x416/0x1830 arch/x86/kvm/x86.c:11172
 kvm_vcpu_ioctl+0x4de/0xcc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4112
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x173/0x1e0 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc6339a4068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 000000000059c0a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007fc633984000
 </TASK>

Modules linked in:
CPU: 0 PID: 10232 Comm: syz-executor Tainted: G    B              6.5.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:try_grab_page+0x2dd/0x3a0 mm/gup.c:229
Code: ff be 04 00 00 00 4c 89 e7 e8 cf fa 13 00 f0 41 ff 04 24 e8 65
96 cb ff 45 31 e4 5b 44 89 e0 5d 41 5c 41 5d c3 e8 53 96 cb ff <0f> 0b
e8 4c 96 cb ff 41 bc f4 ff ff ff 5b 44 89 e0 5d 41 5c 41 5d
RSP: 0018:ffffc9000e99f268 EFLAGS: 00010202
RAX: 0000000000002f80 RBX: ffffea00003ae340 RCX: ffffc90002d79000
RDX: 0000000000040000 RSI: ffffffff81ad81ed RDI: ffffea00003ae374
RBP: ffffea00003ae340 R08: 0000000000000000 R09: fffff94000075c6e
R10: ffffea00003ae377 R11: 0000000000000000 R12: ffffea00003ae374
R13: 0000000000210052 R14: ffffea00003ae340 R15: 000000000eb8d225
FS:  00007fc6339a4640(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002c3ea000 CR4: 0000000000752ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 follow_page_pte+0x18c/0x1610 mm/gup.c:651
 follow_pmd_mask mm/gup.c:727 [inline]
 follow_pud_mask mm/gup.c:765 [inline]
 follow_p4d_mask mm/gup.c:782 [inline]
 follow_page_mask+0x2e4/0xbd0 mm/gup.c:839
 __get_user_pages+0x3fa/0xcf0 mm/gup.c:1256
 __get_user_pages_locked mm/gup.c:1487 [inline]
 get_user_pages_unlocked+0x183/0x580 mm/gup.c:2387
 hva_to_pfn_slow arch/x86/kvm/../../../virt/kvm/kvm_main.c:2536 [inline]
 hva_to_pfn+0x198/0xbc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2674
 __gfn_to_pfn_memslot+0x202/0x3e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2736
 __kvm_faultin_pfn arch/x86/kvm/mmu/mmu.c:4329 [inline]
 kvm_faultin_pfn+0x21b/0x12d0 arch/x86/kvm/mmu/mmu.c:4365
 kvm_tdp_mmu_page_fault arch/x86/kvm/mmu/mmu.c:4503 [inline]
 kvm_tdp_page_fault+0x167/0x4d0 arch/x86/kvm/mmu/mmu.c:4549
 kvm_mmu_do_page_fault arch/x86/kvm/mmu/mmu_internal.h:320 [inline]
 kvm_mmu_page_fault+0x2f4/0x1a40 arch/x86/kvm/mmu/mmu.c:5756
 handle_ept_violation+0x20a/0x620 arch/x86/kvm/vmx/vmx.c:5760
 __vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6539 [inline]
 vmx_handle_exit+0x4a1/0x18d0 arch/x86/kvm/vmx/vmx.c:6556
 vcpu_enter_guest arch/x86/kvm/x86.c:10848 [inline]
 vcpu_run+0x24b6/0x44b0 arch/x86/kvm/x86.c:10951
 kvm_arch_vcpu_ioctl_run+0x416/0x1830 arch/x86/kvm/x86.c:11172
 kvm_vcpu_ioctl+0x4de/0xcc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4112
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x173/0x1e0 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc6339a4068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 000000000059c0a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007fc633984000
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 10232 Comm: syz-executor Tainted: G    B              6.5.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x92/0xf0 lib/dump_stack.c:106
 panic+0x570/0x620 kernel/panic.c:340
 check_panic_on_warn+0x8e/0x90 kernel/panic.c:236
 __warn+0xee/0x340 kernel/panic.c:673
 __report_bug lib/bug.c:199 [inline]
 report_bug+0x25d/0x460 lib/bug.c:219
 handle_bug+0x3c/0x70 arch/x86/kernel/traps.c:324
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:345
 asm_exc_invalid_op+0x16/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:try_grab_page+0x2dd/0x3a0 mm/gup.c:229
Code: ff be 04 00 00 00 4c 89 e7 e8 cf fa 13 00 f0 41 ff 04 24 e8 65
96 cb ff 45 31 e4 5b 44 89 e0 5d 41 5c 41 5d c3 e8 53 96 cb ff <0f> 0b
e8 4c 96 cb ff 41 bc f4 ff ff ff 5b 44 89 e0 5d 41 5c 41 5d
RSP: 0018:ffffc9000e99f268 EFLAGS: 00010202
RAX: 0000000000002f80 RBX: ffffea00003ae340 RCX: ffffc90002d79000
RDX: 0000000000040000 RSI: ffffffff81ad81ed RDI: ffffea00003ae374
RBP: ffffea00003ae340 R08: 0000000000000000 R09: fffff94000075c6e
R10: ffffea00003ae377 R11: 0000000000000000 R12: ffffea00003ae374
R13: 0000000000210052 R14: ffffea00003ae340 R15: 000000000eb8d225
 follow_page_pte+0x18c/0x1610 mm/gup.c:651
 follow_pmd_mask mm/gup.c:727 [inline]
 follow_pud_mask mm/gup.c:765 [inline]
 follow_p4d_mask mm/gup.c:782 [inline]
 follow_page_mask+0x2e4/0xbd0 mm/gup.c:839
 __get_user_pages+0x3fa/0xcf0 mm/gup.c:1256
 __get_user_pages_locked mm/gup.c:1487 [inline]
 get_user_pages_unlocked+0x183/0x580 mm/gup.c:2387
 hva_to_pfn_slow arch/x86/kvm/../../../virt/kvm/kvm_main.c:2536 [inline]
 hva_to_pfn+0x198/0xbc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2674
 __gfn_to_pfn_memslot+0x202/0x3e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2736
 __kvm_faultin_pfn arch/x86/kvm/mmu/mmu.c:4329 [inline]
 kvm_faultin_pfn+0x21b/0x12d0 arch/x86/kvm/mmu/mmu.c:4365
 kvm_tdp_mmu_page_fault arch/x86/kvm/mmu/mmu.c:4503 [inline]
 kvm_tdp_page_fault+0x167/0x4d0 arch/x86/kvm/mmu/mmu.c:4549
 kvm_mmu_do_page_fault arch/x86/kvm/mmu/mmu_internal.h:320 [inline]
 kvm_mmu_page_fault+0x2f4/0x1a40 arch/x86/kvm/mmu/mmu.c:5756
 handle_ept_violation+0x20a/0x620 arch/x86/kvm/vmx/vmx.c:5760
 __vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6539 [inline]
 vmx_handle_exit+0x4a1/0x18d0 arch/x86/kvm/vmx/vmx.c:6556
 vcpu_enter_guest arch/x86/kvm/x86.c:10848 [inline]
 vcpu_run+0x24b6/0x44b0 arch/x86/kvm/x86.c:10951
 kvm_arch_vcpu_ioctl_run+0x416/0x1830 arch/x86/kvm/x86.c:11172
 kvm_vcpu_ioctl+0x4de/0xcc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4112
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x173/0x1e0 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc6339a4068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 000000000059c0a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007fc633984000
 </TASK>
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
