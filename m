Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845EF7CDA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjJRLZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjJRLZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:25:30 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C121111;
        Wed, 18 Oct 2023 04:25:26 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-457c82cd87bso2105960137.0;
        Wed, 18 Oct 2023 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697628325; x=1698233125; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uog0X8NGG+6RwwBXjN2m0QDwRr3OPkoe3namh/lxFrw=;
        b=Ss6hcxZ5gEfbugEDOFIF0Bd3oZ0i5h/zjsie65PDcGLmH7l4irfg9Se47cz+Fn8IO7
         QRFRjccoHmN0BiXWGEPUT4y2iZndIvY1+diiudxuKzq/ylY/HeRjkDqvoFICk8TIdtw6
         38qUtIMmUsFDAfrmH+y9kq4UDgk+xTWG4oh/8+elcrx7XFhoPhjbcb+XcLEB2DH9tdTc
         52QZS+/VY4BHVXlkY94ohSh8j6cxbhrUxks12GKvT5kUxUKChOBAxJgxDEC5zhqI7kBo
         VAAeQDh7Y/DLQ89NFpXJtJ8Hho531kKB1Y5D3shBlmTfIS1NpZsJFvieR6GVdrnZXwXb
         9NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697628325; x=1698233125;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uog0X8NGG+6RwwBXjN2m0QDwRr3OPkoe3namh/lxFrw=;
        b=e0Y699/7hGtIm/a42wi1owBrZ9Ft9otb3eGr/t8s00XUciT6Tzceo8UUvYAChg7gqz
         ggBUYbpkzoUiAPCjtP4uKVekaJSo7qc/fN8paSX5uhiKjv9ljzx/Zu9ddK1tPbxeqcLh
         1OA7qKhPVHFuw9jDVaB+O9LMp4DnlV/U7JSOWGhsKleviP+OYHfjAxCGLudF2nQFPhL/
         +hwW18T3OmsU4Z93S8O5J8El6G3URhydwCpqpTFuhhCNyrsV0QP3+zh/w9yvj6vcThcC
         sKukXdzdsM6yMnQeZmJzKYEscBrV18F0OizDBq1unq+16TuT5I5j01cwEzEaxPSlHYV1
         mYcw==
X-Gm-Message-State: AOJu0YwfqdX71myCQm7wtSQo7T1ZlWc6V9GGcDex6rTwZkDP8vZxfr1L
        SjU0k2tZ7Mm9bXDhmREELQSa1AphUJeY48LIQZteoCN2rbo=
X-Google-Smtp-Source: AGHT+IFfniU1dTm3Weyj7grHzg3MEVDzBw2VR9Ln9g7eEvOHx/cqLE2U9+uMLGe7Ig445ZD4ATasQleyCOoaOj8K0zc=
X-Received: by 2002:a67:c093:0:b0:452:78ea:4aec with SMTP id
 x19-20020a67c093000000b0045278ea4aecmr4457965vsi.7.1697628324727; Wed, 18 Oct
 2023 04:25:24 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 18 Oct 2023 13:25:13 +0200
Message-ID: <CAA85sZsdfcbPRm+hZrasMG1SWW-Qh8OCmcM2Cbh-HvhRruU-tQ@mail.gmail.com>
Subject: [BUG] 6.5.7 nf_flow_offload_work_gc unable to handle page fault
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this happened yesterday....

cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
[97639.618937] BUG: unable to handle page fault for address: 00000000d400008b
[97639.625928] #PF: supervisor write access in kernel mode
[97639.631244] #PF: error_code(0x0002) - not-present page
[97639.636472] PGD 0 P4D 0
[97639.639099] Oops: 0002 [#1] PREEMPT SMP NOPTI
[97639.643553] CPU: 9 PID: 24400 Comm: kworker/9:2 Not tainted 6.5.7 #393
[97639.650173] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[97639.658354] Workqueue: events_power_efficient nf_flow_offload_work_gc
[97639.664896] RIP: 0010:flow_offload_teardown
(./arch/x86/include/asm/bitops.h:75
./include/asm-generic/bitops/instrumented-atomic.h:42
net/netfilter/nf_flow_table_core.c:344)
[97639.669957] Code: 00 00 e9 96 fd ff ff 66 0f 1f 44 00 00 48 83 c7
08 be 32 00 00 00 e9 82 fd ff ff 66 90 48 8b 87 b0 00 00 00 48 05 81
00 00 00 <f0> 80 20 bf f0 80 8f b8 00 00 00 04 48 8b 97 b0 00 00 00 0f
b6 42
All code
========
   0: 00 00                add    %al,(%rax)
   2: e9 96 fd ff ff        jmp    0xfffffffffffffd9d
   7: 66 0f 1f 44 00 00    nopw   0x0(%rax,%rax,1)
   d: 48 83 c7 08          add    $0x8,%rdi
  11: be 32 00 00 00        mov    $0x32,%esi
  16: e9 82 fd ff ff        jmp    0xfffffffffffffd9d
  1b: 66 90                xchg   %ax,%ax
  1d: 48 8b 87 b0 00 00 00 mov    0xb0(%rdi),%rax
  24: 48 05 81 00 00 00    add    $0x81,%rax
  2a:* f0 80 20 bf          lock andb $0xbf,(%rax) <-- trapping instruction
  2e: f0 80 8f b8 00 00 00 lock orb $0x4,0xb8(%rdi)
  35: 04
  36: 48 8b 97 b0 00 00 00 mov    0xb0(%rdi),%rdx
  3d: 0f                    .byte 0xf
  3e: b6 42                mov    $0x42,%dh

Code starting with the faulting instruction
===========================================
   0: f0 80 20 bf          lock andb $0xbf,(%rax)
   4: f0 80 8f b8 00 00 00 lock orb $0x4,0xb8(%rdi)
   b: 04
   c: 48 8b 97 b0 00 00 00 mov    0xb0(%rdi),%rdx
  13: 0f                    .byte 0xf
  14: b6 42                mov    $0x42,%dh
[97639.688823] RSP: 0018:ffffa59e889ebe10 EFLAGS: 00010206
[97639.694145] RAX: 00000000d400008b RBX: ffff8aa5801ee6f8 RCX: 0000000000000001
[97639.701374] RDX: 0000000105cd52c0 RSI: ffff8aa89302a558 RDI: ffff8aa89302a558
[97639.708602] RBP: ffff8aa5801ee650 R08: ffff8aa5801ee650 R09: ffff8aa7d5284e00
[97639.715831] R10: 0000000000000000 R11: 000000000000000e R12: ffff8aa8efc6b500
[97639.723058] R13: ffff8aa8efc70000 R14: ffff8aa8efc70005 R15: ffff8aa580051ab0
[97639.730286] FS:  0000000000000000(0000) GS:ffff8aa8efc40000(0000)
knlGS:0000000000000000
[97639.738503] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[97639.744361] CR2: 00000000d400008b CR3: 00000001115f2000 CR4: 00000000003526e0
[97639.751606] Call Trace:
[97639.754158]  <TASK>
[97639.756365] ? __die (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:434)
[97639.759535] ? page_fault_oops (arch/x86/mm/fault.c:707)
[97639.763748] ? chacha_block_generic (lib/crypto/chacha.c:83)
[97639.768220] ? exc_page_fault (arch/x86/mm/fault.c:1279
arch/x86/mm/fault.c:1486 arch/x86/mm/fault.c:1542)
[97639.772346] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)
[97639.776646] ? flow_offload_teardown
(./arch/x86/include/asm/bitops.h:75
./include/asm-generic/bitops/instrumented-atomic.h:42
net/netfilter/nf_flow_table_core.c:344)
[97639.781116] nf_flow_offload_gc_step
(./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
net/netfilter/nf_flow_table_core.c:418)
[97639.785673] nf_flow_offload_work_gc
(net/netfilter/nf_flow_table_core.c:389
net/netfilter/nf_flow_table_core.c:434
net/netfilter/nf_flow_table_core.c:442)
[97639.790226] process_one_work (kernel/workqueue.c:2605)
[97639.794351] worker_thread (./include/linux/list.h:292
kernel/workqueue.c:2752)
[97639.798129] ? process_one_work (kernel/workqueue.c:2694)
[97639.802427] kthread (kernel/kthread.c:389)
[97639.805675] ? kthread_complete_and_exit (kernel/kthread.c:342)
[97639.810580] ret_from_fork (arch/x86/kernel/process.c:151)
[97639.814273] ? kthread_complete_and_exit (kernel/kthread.c:342)
[97639.819168] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
[97639.823203]  </TASK>
[97639.825497] Modules linked in: chaoskey
[97639.829450] CR2: 00000000d400008b
[97639.832874] ---[ end trace 0000000000000000 ]---
[97639.853625] pstore: backend (erst) writing error (-28)
[97639.858880] RIP: 0010:flow_offload_teardown
(./arch/x86/include/asm/bitops.h:75
./include/asm-generic/bitops/instrumented-atomic.h:42
net/netfilter/nf_flow_table_core.c:344)
[97639.863960] Code: 00 00 e9 96 fd ff ff 66 0f 1f 44 00 00 48 83 c7
08 be 32 00 00 00 e9 82 fd ff ff 66 90 48 8b 87 b0 00 00 00 48 05 81
00 00 00 <f0> 80 20 bf f0 80 8f b8 00 00 00 04 48 8b 97 b0 00 00 00 0f
b6 42
All code
========
   0: 00 00                add    %al,(%rax)
   2: e9 96 fd ff ff        jmp    0xfffffffffffffd9d
   7: 66 0f 1f 44 00 00    nopw   0x0(%rax,%rax,1)
   d: 48 83 c7 08          add    $0x8,%rdi
  11: be 32 00 00 00        mov    $0x32,%esi
  16: e9 82 fd ff ff        jmp    0xfffffffffffffd9d
  1b: 66 90                xchg   %ax,%ax
  1d: 48 8b 87 b0 00 00 00 mov    0xb0(%rdi),%rax
  24: 48 05 81 00 00 00    add    $0x81,%rax
  2a:* f0 80 20 bf          lock andb $0xbf,(%rax) <-- trapping instruction
  2e: f0 80 8f b8 00 00 00 lock orb $0x4,0xb8(%rdi)
  35: 04
  36: 48 8b 97 b0 00 00 00 mov    0xb0(%rdi),%rdx
  3d: 0f                    .byte 0xf
  3e: b6 42                mov    $0x42,%dh

Code starting with the faulting instruction
===========================================
   0: f0 80 20 bf          lock andb $0xbf,(%rax)
   4: f0 80 8f b8 00 00 00 lock orb $0x4,0xb8(%rdi)
   b: 04
   c: 48 8b 97 b0 00 00 00 mov    0xb0(%rdi),%rdx
  13: 0f                    .byte 0xf
  14: b6 42                mov    $0x42,%dh
[97639.882876] RSP: 0018:ffffa59e889ebe10 EFLAGS: 00010206
[97639.888215] RAX: 00000000d400008b RBX: ffff8aa5801ee6f8 RCX: 0000000000000001
[97639.895461] RDX: 0000000105cd52c0 RSI: ffff8aa89302a558 RDI: ffff8aa89302a558
[97639.902707] RBP: ffff8aa5801ee650 R08: ffff8aa5801ee650 R09: ffff8aa7d5284e00
[97639.909951] R10: 0000000000000000 R11: 000000000000000e R12: ffff8aa8efc6b500
[97639.917196] R13: ffff8aa8efc70000 R14: ffff8aa8efc70005 R15: ffff8aa580051ab0
[97639.924441] FS:  0000000000000000(0000) GS:ffff8aa8efc40000(0000)
knlGS:0000000000000000
[97639.932657] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[97639.938505] CR2: 00000000d400008b CR3: 00000001115f2000 CR4: 00000000003526e0
[97639.945752] note: kworker/9:2[24400] exited with irqs disabled
[97641.461257] BUG: unable to handle page fault for address: 0000000000001000
[97641.468255] #PF: supervisor read access in kernel mode
[97641.473503] #PF: error_code(0x0000) - not-present page
[97641.478748] PGD 0 P4D 0
[97641.481392] Oops: 0000 [#2] PREEMPT SMP NOPTI
[97641.485856] CPU: 9 PID: 35705 Comm: kworker/9:1 Tainted: G      D
         6.5.7 #393
[97641.493992] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[97641.502209] Workqueue: events rht_deferred_worker
[97641.507038] RIP: 0010:rht_deferred_worker (lib/rhashtable.c:244
lib/rhashtable.c:288 lib/rhashtable.c:328 lib/rhashtable.c:432)
[97641.512201] Code: 00 48 83 e2 fe 48 0f 44 14 24 48 89 d0 f6 c2 01
0f 85 af 01 00 00 48 8b 2a 40 f6 c5 01 74 0b e9 87 02 00 00 48 89 e8
4c 89 e5 <4c> 8b 65 00 41 f6 c4 01 74 f0 48 89 c3 41 0f b7 56 d6 49 8b
46 e8
All code
========
   0: 00 48 83              add    %cl,-0x7d(%rax)
   3: e2 fe                loop   0x3
   5: 48 0f 44 14 24        cmove  (%rsp),%rdx
   a: 48 89 d0              mov    %rdx,%rax
   d: f6 c2 01              test   $0x1,%dl
  10: 0f 85 af 01 00 00    jne    0x1c5
  16: 48 8b 2a              mov    (%rdx),%rbp
  19: 40 f6 c5 01          test   $0x1,%bpl
  1d: 74 0b                je     0x2a
  1f: e9 87 02 00 00        jmp    0x2ab
  24: 48 89 e8              mov    %rbp,%rax
  27: 4c 89 e5              mov    %r12,%rbp
  2a:* 4c 8b 65 00          mov    0x0(%rbp),%r12 <-- trapping instruction
  2e: 41 f6 c4 01          test   $0x1,%r12b
  32: 74 f0                je     0x24
  34: 48 89 c3              mov    %rax,%rbx
  37: 41 0f b7 56 d6        movzwl -0x2a(%r14),%edx
  3c: 49 8b 46 e8          mov    -0x18(%r14),%rax

Code starting with the faulting instruction
===========================================
   0: 4c 8b 65 00          mov    0x0(%rbp),%r12
   4: 41 f6 c4 01          test   $0x1,%r12b
   8: 74 f0                je     0xfffffffffffffffa
   a: 48 89 c3              mov    %rax,%rbx
   d: 41 0f b7 56 d6        movzwl -0x2a(%r14),%edx
  12: 49 8b 46 e8          mov    -0x18(%r14),%rax
[97641.531118] RSP: 0018:ffffa59e85e1fe18 EFLAGS: 00010046
[97641.536457] RAX: ffff8aa89302a558 RBX: 0000000000000000 RCX: ffff8aa587720000
[97641.543703] RDX: ffff8aa89302a558 RSI: 0000000000000002 RDI: ffff8aa587720000
[97641.550948] RBP: 0000000000001000 R08: 000000003f542bae R09: 0000000000000000
[97641.558194] R10: ffffffff9fbfdf80 R11: 0000000000000000 R12: ffff8aa5877200a1
[97641.565438] R13: ffff8aa5877200b0 R14: ffff8aa5801ee6a0 R15: ffff8aa61a00d000
[97641.572683] FS:  0000000000000000(0000) GS:ffff8aa8efc40000(0000)
knlGS:0000000000000000
[97641.580899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[97641.586749] CR2: 0000000000001000 CR3: 00000001115f2000 CR4: 00000000003526e0
[97641.593994] Call Trace:
[97641.596545]  <TASK>
[97641.598754] ? __die (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:434)
[97641.601924] ? page_fault_oops (arch/x86/mm/fault.c:707)
[97641.606140] ? exc_page_fault (arch/x86/mm/fault.c:1279
arch/x86/mm/fault.c:1486 arch/x86/mm/fault.c:1542)
[97641.610263] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)
[97641.614563] ? flow_offload_fill_dir (net/netfilter/nf_flow_table_core.c:219)
[97641.619120] ? rht_deferred_worker (lib/rhashtable.c:244
lib/rhashtable.c:288 lib/rhashtable.c:328 lib/rhashtable.c:432)
[97641.623679] process_one_work (kernel/workqueue.c:2605)
[97641.627807] worker_thread (./include/linux/list.h:292
kernel/workqueue.c:2752)
[97641.631582] ? process_one_work (kernel/workqueue.c:2694)
[97641.635870] kthread (kernel/kthread.c:389)
[97641.639122] ? kthread_complete_and_exit (kernel/kthread.c:342)
[97641.644026] ret_from_fork (arch/x86/kernel/process.c:151)
[97641.647719] ? kthread_complete_and_exit (kernel/kthread.c:342)
[97641.652623] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
[97641.656658]  </TASK>
[97641.658951] Modules linked in: chaoskey
[97641.662894] CR2: 0000000000001000
[97641.666321] ---[ end trace 0000000000000000 ]---
[97641.668308] BUG: unable to handle page fault for address: 0000000000001008
[97641.678038] #PF: supervisor read access in kernel mode
[97641.683287] #PF: error_code(0x0000) - not-present page
[97641.687778] RIP: 0010:flow_offload_teardown
(./arch/x86/include/asm/bitops.h:75
./include/asm-generic/bitops/instrumented-atomic.h:42
net/netfilter/nf_flow_table_core.c:344)
[97641.688538] PGD 0
[97641.688646] Code: 00 00 e9 96 fd ff ff 66 0f 1f 44 00 00 48 83 c7
08 be 32 00 00 00 e9 82 fd ff ff 66 90 48 8b 87 b0 00 00 00 48 05 81
00 00 00 <f0> 80 20 bf f0 80 8f b8 00 00 00 04 48 8b 97 b0 00 00 00 0f
b6 42
All code
========
   0: 00 00                add    %al,(%rax)
   2: e9 96 fd ff ff        jmp    0xfffffffffffffd9d
   7: 66 0f 1f 44 00 00    nopw   0x0(%rax,%rax,1)
   d: 48 83 c7 08          add    $0x8,%rdi
  11: be 32 00 00 00        mov    $0x32,%esi
  16: e9 82 fd ff ff        jmp    0xfffffffffffffd9d
  1b: 66 90                xchg   %ax,%ax
  1d: 48 8b 87 b0 00 00 00 mov    0xb0(%rdi),%rax
  24: 48 05 81 00 00 00    add    $0x81,%rax
  2a:* f0 80 20 bf          lock andb $0xbf,(%rax) <-- trapping instruction
  2e: f0 80 8f b8 00 00 00 lock orb $0x4,0xb8(%rdi)
  35: 04
  36: 48 8b 97 b0 00 00 00 mov    0xb0(%rdi),%rdx
  3d: 0f                    .byte 0xf
  3e: b6 42                mov    $0x42,%dh

Code starting with the faulting instruction
===========================================
   0: f0 80 20 bf          lock andb $0xbf,(%rax)
   4: f0 80 8f b8 00 00 00 lock orb $0x4,0xb8(%rdi)
   b: 04
   c: 48 8b 97 b0 00 00 00 mov    0xb0(%rdi),%rdx
  13: 0f                    .byte 0xf
  14: b6 42                mov    $0x42,%dh
[97641.693605] P4D 0
[97641.693705] RSP: 0018:ffffa59e889ebe10 EFLAGS: 00010206


[97641.694081] Oops: 0000 [#3] PREEMPT SMP NOPTI
[97641.694179] RAX: 00000000d400008b RBX: ffff8aa5801ee6f8 RCX: 0000000000000001
[97641.694280] CPU: 8 PID: 0 Comm: swapper/8 Tainted: G      D
   6.5.7 #393
[97641.694383] RDX: 0000000105cd52c0 RSI: ffff8aa89302a558 RDI: ffff8aa89302a558
[97641.694494] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[97641.694622] RBP: ffff8aa5801ee650 R08: ffff8aa5801ee650 R09: ffff8aa7d5284e00
[97641.694733] RIP: 0010:memcmp (lib/string.c:681)
[97641.694862] R10: 0000000000000000 R11: 000000000000000e R12: ffff8aa8efc6b500
[97641.694973] Code: cc cc cc 48 85 c0 75 f3 0f b6 4f 01 48 83 c7 01
84 c9 75 bc eb e3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 eb 14
48 8b 06 <48> 39 07 75 17 48 83 c7 08 48 83 c6 08 48 83 ea 08 48 83 fa
07 77
All code
========
   0: cc                    int3
   1: cc                    int3
   2: cc                    int3
   3: 48 85 c0              test   %rax,%rax
   6: 75 f3                jne    0xfffffffffffffffb
   8: 0f b6 4f 01          movzbl 0x1(%rdi),%ecx
   c: 48 83 c7 01          add    $0x1,%rdi
  10: 84 c9                test   %cl,%cl
  12: 75 bc                jne    0xffffffffffffffd0
  14: eb e3                jmp    0xfffffffffffffff9
  16: 66 66 2e 0f 1f 84 00 data16 cs nopw 0x0(%rax,%rax,1)
  1d: 00 00 00 00
  21: 0f 1f 40 00          nopl   0x0(%rax)
  25: eb 14                jmp    0x3b
  27: 48 8b 06              mov    (%rsi),%rax
  2a:* 48 39 07              cmp    %rax,(%rdi) <-- trapping instruction
  2d: 75 17                jne    0x46
  2f: 48 83 c7 08          add    $0x8,%rdi
  33: 48 83 c6 08          add    $0x8,%rsi
  37: 48 83 ea 08          sub    $0x8,%rdx
  3b: 48 83 fa 07          cmp    $0x7,%rdx
  3f: 77                    .byte 0x77

Code starting with the faulting instruction
===========================================
   0: 48 39 07              cmp    %rax,(%rdi)
   3: 75 17                jne    0x1c
   5: 48 83 c7 08          add    $0x8,%rdi
   9: 48 83 c6 08          add    $0x8,%rsi
   d: 48 83 ea 08          sub    $0x8,%rdx
  11: 48 83 fa 07          cmp    $0x7,%rdx
  15: 77                    .byte 0x77
[97641.695076] R13: ffff8aa8efc70000 R14: ffff8aa8efc70005 R15: ffff8aa580051ab0
[97641.695187] RSP: 0018:ffffa59e80258ae8 EFLAGS: 00010216
[97641.695355] FS:  0000000000000000(0000) GS:ffff8aa8efc40000(0000)
knlGS:0000000000000000

[97641.695467] RAX: 17da23f697af96fd RBX: ffff8aa5801ee650 RCX: 0000000000000000
[97641.695571] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[97641.695700] RDX: 0000000000000032 RSI: ffffa59e80258ba0 RDI: 0000000000001008
[97641.695800] CR2: 0000000000001000 CR3: 00000001115f2000 CR4: 00000000003526e0
[97641.695910] RBP: ffff8aa5877200b0 R08: 00000000000000fd R09: 0000000000000001
[97641.696019] note: kworker/9:1[35705] exited with irqs disabled
[97641.696128] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[97641.697007] note: kworker/9:1[35705] exited with preempt_count 1
[97641.698365] R13: ffff8aa5801ee660 R14: ffff8aa587720000 R15: 0000000000001000
[97641.698370] FS:  0000000000000000(0000) GS:ffff8aa8efc00000(0000)
knlGS:0000000000000000
[97641.698376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[97641.698381] CR2: 0000000000001008 CR3: 0000000103466000 CR4: 00000000003526e0
[97641.698386] Call Trace:
[97641.698392]  <IRQ>
[97641.698396] ? __die (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:434)
[97641.698405] ? page_fault_oops (arch/x86/mm/fault.c:707)
[97641.698415] ? ttwu_queue_wakelist (kernel/sched/core.c:4005)
[97641.698422] ? try_to_wake_up (kernel/sched/core.c:4349)
[97641.698432] ? exc_page_fault (arch/x86/mm/fault.c:1279
arch/x86/mm/fault.c:1486 arch/x86/mm/fault.c:1542)
[97641.698440] ? pollwake (fs/select.c:219)
