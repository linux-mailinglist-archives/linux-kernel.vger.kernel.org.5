Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8C7DD632
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjJaSjy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 14:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjJaSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:39:53 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D90AA3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:39:50 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qxtdf-0003Nw-1c;
        Tue, 31 Oct 2023 14:38:55 -0400
Message-ID: <bce5df0508221ab30a1fb121a219034631abedf5.camel@surriel.com>
Subject: Re: [syzbot] [mm?] general protection fault in
 hugetlb_vma_lock_write
From:   Rik van Riel <riel@surriel.com>
To:     syzbot <syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Date:   Tue, 31 Oct 2023 14:38:55 -0400
In-Reply-To: <00000000000078d1e00608d7878b@google.com>
References: <00000000000078d1e00608d7878b@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-10-29 at 02:27 -0700, syzbot wrote:
> 
> commit bf4916922c60f43efaa329744b3eef539aa6a2b2
> Author: Rik van Riel <riel@surriel.com>
> Date:   Fri Oct 6 03:59:07 2023 +0000
> 
>     hugetlbfs: extend hugetlb_vma_lock to private VMAs
> 

I've been trying to reproduce the issue here, but the test
case has been running for 4+ hours now on a KVM guest, with
KASAN and CONFIG_PROVE_LOCKING enabled. No crashes yet.

I'll try adapting the config file from syzkaller so the
resulting kernel boots here, but this is not looking like
an easy reproducer so far...

The crash is also confusing me somewhat, because it looks
like hugetlb_vma_lock_write() is passing a nonsense (very small
value) resv_map->rw_sema pointer down to down_write, but the
code has some protection against that:

static inline bool __vma_private_lock(struct vm_area_struct *vma)
{               
        return (!(vma->vm_flags & VM_MAYSHARE)) && vma-
>vm_private_data;
}    

void hugetlb_vma_lock_write(struct vm_area_struct *vma)
{
        if (__vma_shareable_lock(vma)) {
                struct hugetlb_vma_lock *vma_lock = vma-
>vm_private_data;
                
                down_write(&vma_lock->rw_sema);
        } else if (__vma_private_lock(vma)) {
                struct resv_map *resv_map = vma_resv_map(vma);
         
                down_write(&resv_map->rw_sema);
        }               
}

At fork time, vma->vm_private_data gets cleared in the child
process for MAP_PRIVATE hugetlb VMAs.

I do not see anything that would leave behind a tiny, but
non-zero value in that pointer.

I'll keep poking at this, but I don't know if it will
reproduce here.

> general protection fault, probably for non-canonical address
> 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000000e8-
> 0x00000000000000ef]
> CPU: 0 PID: 5048 Comm: syz-executor139 Not tainted 6.6.0-rc7-
> syzkaller-00142-g888cf78c29e2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 10/09/2023
> RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5004
> Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 c1 1e 42 0b 45 85 c0 0f 84
> be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80>
> 3c 11 00 0f 85 e8 40 00 00 49 81 3a a0 d9 5f 90 0f 84 96 0d 00
> RSP: 0018:ffffc90003aa7798 EFLAGS: 00010016
> 
> RAX: ffff88807a0b9dc0 RBX: 1ffff92000754f23 RCX: 000000000000001d
> RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 00000000000000e8
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> R10: 00000000000000e8 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000280 CR3: 00000000758bf000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  lock_acquire kernel/locking/lockdep.c:5753 [inline]
>  lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
>  down_write+0x93/0x200 kernel/locking/rwsem.c:1573
>  hugetlb_vma_lock_write mm/hugetlb.c:300 [inline]
>  hugetlb_vma_lock_write+0xae/0x100 mm/hugetlb.c:291
>  __hugetlb_zap_begin+0x1e9/0x2b0 mm/hugetlb.c:5447
>  hugetlb_zap_begin include/linux/hugetlb.h:258 [inline]
>  unmap_vmas+0x2f4/0x470 mm/memory.c:1733
>  exit_mmap+0x1ad/0xa60 mm/mmap.c:3230
>  __mmput+0x12a/0x4d0 kernel/fork.c:1349
>  mmput+0x62/0x70 kernel/fork.c:1371
>  exit_mm kernel/exit.c:567 [inline]
>  do_exit+0x9ad/0x2a20 kernel/exit.c:861
>  __do_sys_exit kernel/exit.c:991 [inline]
>  __se_sys_exit kernel/exit.c:989 [inline]
>  __x64_sys_exit+0x42/0x50 kernel/exit.c:989
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7ff2b7a78ab9
> Code: Unable to access opcode bytes at 0x7ff2b7a78a8f.
> RSP: 002b:00007fff926ea6b8 EFLAGS: 00000246 ORIG_RAX:
> 000000000000003c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff2b7a78ab9
> RDX: 00007ff2b7ab23f3 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 000000000000cfda R08: 0000000000000000 R09: 0000000000000006
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff926ea6cc
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5004
> Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 c1 1e 42 0b 45 85 c0 0f 84
> be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80>
> 3c 11 00 0f 85 e8 40 00 00 49 81 3a a0 d9 5f 90 0f 84 96 0d 00
> RSP: 0018:ffffc90003aa7798 EFLAGS: 00010016
> RAX: ffff88807a0b9dc0 RBX: 1ffff92000754f23 RCX: 000000000000001d
> RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 00000000000000e8
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> R10: 00000000000000e8 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000280 CR3: 00000000758bf000 CR4: 0000000000350ef0
> ----------------
> Code disassembly (best guess):
>    0:   45 85 c9                test   %r9d,%r9d
>    3:   0f 84 cc 0e 00 00       je     0xed5
>    9:   44 8b 05 c1 1e 42 0b    mov    0xb421ec1(%rip),%r8d        #
> 0xb421ed1
>   10:   45 85 c0                test   %r8d,%r8d
>   13:   0f 84 be 0d 00 00       je     0xdd7
>   19:   48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx
>   20:   fc ff df
>   23:   4c 89 d1                mov    %r10,%rcx
>   26:   48 c1 e9 03             shr    $0x3,%rcx
> * 2a:   80 3c 11 00             cmpb   $0x0,(%rcx,%rdx,1) <--
> trapping instruction
>   2e:   0f 85 e8 40 00 00       jne    0x411c
>   34:   49 81 3a a0 d9 5f 90    cmpq   $0xffffffff905fd9a0,(%r10)
>   3b:   0f                      .byte 0xf
>   3c:   84                      .byte 0x84
>   3d:   96                      xchg   %eax,%esi
>   3e:   0d                      .byte 0xd
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see:
> https://goo.gl/tpsmEJ#bisection
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before
> testing.
> 
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

-- 
All Rights Reversed.
