Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD197D8E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJ0GH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:07:54 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59651A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:07:50 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5a8ee23f043so12977637b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698386870; x=1698991670; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UbYvl6tCL9BYjy1qjOMIRbYtv6kw8c/Q8X5TDSyiFM=;
        b=yUOE+sBqV8nsCuVyy4tQpUXxK8ZJ50DlzyFv12joZxi4dqHw6vJ9DT5qzIjWbqmJRb
         D0ufiLxaVWF+e8YKSBvajYqXjgFmaBW/I64DfiKz+9EQ4OxK/6XG/mbmpLasgiom4JqC
         2BqAxf7864nNXA168BQ9Hf/oLVXQoMoE2csf76DfOEskpKd9NKteFh+hWXD5kFd7TnKd
         0pDGh4ia0RfLYfBJGmNtSc+h0NIlGPEgNDG9b/ZGTyVBsC/T+WLZxhMtEabur9MwjkHA
         JCo8KgUSfW/NIPTRPBlFtSA/YhzpST43AF0kt+/brjPE8GRpcWdSuOiJS6XzTwMApbnS
         7SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386870; x=1698991670;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UbYvl6tCL9BYjy1qjOMIRbYtv6kw8c/Q8X5TDSyiFM=;
        b=Ag9e0yL7O/craskXDyR4bTOSKnvlbfTjvAKeNyXhrz+SHzYdBYmf7N6LF6qzyTcfuv
         xuVunEptkf0T8ZK0PjDeZiNNCVlAoTv/CVpLn0uUb0k8mOMmHvyV58kSv2d4ECupMgx+
         rVYeKWNDVU979eQQJOGDzZbHQ6zrkV809HTJV4futz/a2lEUU9Kc3vibVYUoPea7TOxw
         /5z3G6RF/TWrj3b1z3PIOAIF/x0YS1uM12kaxiHNmRmvk6IJ/IZFfKwib45YzQvKxlpz
         KuQjbMlWEnFuczZbiUJhEuKDWYV42d9tqOJ98s8ier2fkJiicFFBtZJknRC5PUpOwM64
         Uk2Q==
X-Gm-Message-State: AOJu0YwlUdh8kauz1j4yfYlHQtGO7cz7dlkX4af1ADlNRmudDJmZDNUs
        RVIWDZUAVydiWQv17CydgbR9Dw==
X-Google-Smtp-Source: AGHT+IEEu7eYjdMrlk5mIlO110lV+7FPVcxu3Is1OBBfqDj52jm4BBoQUnywbHaFWQvmYdaZAhr4jA==
X-Received: by 2002:a81:c645:0:b0:59a:f131:50fa with SMTP id q5-20020a81c645000000b0059af13150famr1508357ywj.47.1698386869873;
        Thu, 26 Oct 2023 23:07:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s4-20020a0de904000000b0058fc7604f45sm412694ywe.130.2023.10.26.23.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:07:48 -0700 (PDT)
Date:   Thu, 26 Oct 2023 23:07:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     linux-arm-kernel@lists.infradead.org
cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 __pte_offset_map_lock
In-Reply-To: <0000000000005e44550608a0806c@google.com>
Message-ID: <b66659e9-a59e-fdf9-904c-ec25395b97ef@google.com>
References: <0000000000005e44550608a0806c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hope, redirecting this report to linux-arm-kernel

On Thu, 26 Oct 2023, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    78124b0c1d10 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=111b0e71680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f27cd6e68911e026
> dashboard link: https://syzkaller.appspot.com/bug?extid=89edd67979b52675ddec
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b8e671680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125a9df5680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bd512de820ae/disk-78124b0c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a47a437b1d4f/vmlinux-78124b0c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3ae8b966bcd7/Image-78124b0c.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com
> 
> Unable to handle kernel paging request at virtual address dfff800000000004
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [dfff800000000004] address between user and kernel address ranges
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 7952 Comm: syz-executor682 Not tainted 6.6.0-rc6-syzkaller-g78124b0c1d10 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
> lr : lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
> sp : ffff800098f26d40
> x29: ffff800098f27000 x28: ffff8000808df4bc x27: ffff7000131e4e18
> x26: 1ffff00011c340b9 x25: 0000000000000000 x24: 0000000000000000
> x23: ffff7000131e4dd0 x22: 0000000000000000 x21: 0000000000000000
> x20: 0000000000000000 x19: 0000000000000022 x18: ffff800098f27750
> x17: 0000ffff833dafff x16: ffff80008a632120 x15: 0000000000000001
> x14: ffff80008e1a05d0 x13: ffff800098f26e80 x12: dfff800000000000
> x11: ffff800080319468 x10: ffff80008e1a05cc x9 : 00000000000000f3
> x8 : 0000000000000004 x7 : ffff8000808df4bc x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000022
> Call trace:
>  __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
>  lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  __pte_offset_map_lock+0x154/0x360 mm/pgtable-generic.c:373
>  pte_offset_map_lock include/linux/mm.h:2939 [inline]
>  filemap_map_pages+0x698/0x11f0 mm/filemap.c:3582
>  do_fault_around mm/memory.c:4525 [inline]
>  do_read_fault mm/memory.c:4558 [inline]
>  do_fault mm/memory.c:4705 [inline]
>  do_pte_missing mm/memory.c:3669 [inline]
>  handle_pte_fault mm/memory.c:4978 [inline]
>  __handle_mm_fault mm/memory.c:5119 [inline]
>  handle_mm_fault+0x326c/0x49fc mm/memory.c:5284
>  faultin_page mm/gup.c:956 [inline]
>  __get_user_pages+0x3e0/0xa24 mm/gup.c:1239
>  populate_vma_page_range+0x254/0x328 mm/gup.c:1666
>  __mm_populate+0x240/0x3d8 mm/gup.c:1775
>  mm_populate include/linux/mm.h:3305 [inline]
>  vm_mmap_pgoff+0x2bc/0x3d4 mm/util.c:551
>  ksys_mmap_pgoff+0xd0/0x5b0 mm/mmap.c:1400
>  __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
>  __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
>  __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
>  el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
> Code: b006f948 b943a108 34000208 d343fe68 (386c6908) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	b006f948 	adrp	x8, 0xdf29000
>    4:	b943a108 	ldr	w8, [x8, #928]
>    8:	34000208 	cbz	w8, 0x48
>    c:	d343fe68 	lsr	x8, x19, #3
> * 10:	386c6908 	ldrb	w8, [x8, x12] <-- trapping instruction
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

I've spent a while worrying over this report, but have not been able
glean much from it: I'm not at all familiar with arm64 debugging, so
cannot deduce anything from the registers shown, though suspect they
would shed good light on it; but it may just be a waste of time, since
it was on a transient 6.6-rc6-based for-kernelci branch from last week.

If I read right, the reproducer is exercising MADV_PAGEOUT (splitting
huge pages) and MADV_COLLAPSE (assembling huge pages), on mmaps
MAP_FIXED MAP_SHARED MAP_ANONYMOUS i.e. shmem.

Suspicion falls on my 6.6-rc1 mm/khugepaged.c changes; but I don't see
what's wrong, and shall probably give up and ignore this - unless an
arm64 expert can take it further, or syzbot reproduces it on x86 on a
known tree.

Hugh
