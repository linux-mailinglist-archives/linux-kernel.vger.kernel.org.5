Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FD7FD54A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjK2LQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjK2LPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:15:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034F030F7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:14:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b422a274dso58585e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701256462; x=1701861262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sl2+HiAfY+wXH9mng/vAjeUNiutQNXWgRrqe3HQnyfQ=;
        b=051IbZTPPkjWTSWULPN+FU/kg1ZyXVE9y0xB+VvmzpuubXaN6Ejh+XLJE4dtk01HqL
         0IUQ31sn2U8px2kJ5jcOH0jt7113VQhl6zG9g41Vr5xh8BWBsYGgvUGuWkwutrh1wMgD
         yZf6u2q9eXahGAhs2EafbZC5f0vkSVfhtP6hchWhE3P7ac/SpET8CxWj+EGMmNY79VRB
         edrj+ZCI0pSNrcNWFeo4Jhi+2fDTSW8tstKopwxII7nLWPLnpKuXksVgy+kAGzX+K/ll
         VuJ4Pza3eP7kyKSq2NclTpmeTmXB2czm5yw2opfNb21xbSD/g4IzT/YZNgeNKIGvxuRp
         r8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701256462; x=1701861262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sl2+HiAfY+wXH9mng/vAjeUNiutQNXWgRrqe3HQnyfQ=;
        b=wTUybo4mf/3jBm7lC8obAwwwHneHh+UusmmTdJMfecdA9seubixMiizTM7lgDs4t+F
         wi76/0kVRS1tUlY9yS+zgvn820GbYdrOjyQlBGuhGMrzOBjhMmIqY1HS0nDotgauzSCx
         gzCXxRpg8OkMg/fzBpKyb78ldYXQKpRrU1Q4S8PmcYkb0MqGcKRXiI4j5BGotJsPImnJ
         kRhSwS3mlMHcaNdYkWLkQP+LRQNvAETsofxbxyaSMYEiyQxHrKppU5/QblQri3U/N+Sm
         6T5vZwNbac1XEriYvg3hfDwgDBcTZKjFpLedWiPmtyGumTz1v08vy82RwXqd4fZpYHVo
         3t2Q==
X-Gm-Message-State: AOJu0YxjoTfmvCQ4lowVKbsWLsyEbS9iG7C/v1vKlQ/kr1YsJ2t3jT0J
        PYYY77sNgkVoL4Z4K7DKlRmZkkm7cu+lwBXgBlC2sA==
X-Google-Smtp-Source: AGHT+IGO5/Eh6vVQRAIYpQfdsdkyOHSiG/a4zsIoH/Q1ysZ/oS5Tu+2TLdcyhamvkIoB0fpAKBzlu3PTn92aZVaMou4=
X-Received: by 2002:a05:600c:1d26:b0:40b:4221:4085 with SMTP id
 l38-20020a05600c1d2600b0040b42214085mr483951wms.1.1701256461620; Wed, 29 Nov
 2023 03:14:21 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f2b6b0060b488674@google.com>
In-Reply-To: <000000000000f2b6b0060b488674@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 Nov 2023 12:14:07 +0100
Message-ID: <CANn89i+6BuZA6AjocG_0zTkD1u=pNgZc_DpZMO=yUN=S1cHS3w@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in page_pool_unlist
To:     syzbot <syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com>
Cc:     almasrymina@google.com, davem@davemloft.net, hawk@kernel.org,
        ilias.apalodimas@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:06=E2=80=AFPM syzbot
<syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a379972973a8 Merge branch 'net-page_pool-add-netlink-base=
d..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1421b7ece8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dabf6d5a82dab0=
1fe
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df9f8efb58a4db2c=
a98d0
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D117d9e64e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16826ec4e8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fc5f22d6faa1/dis=
k-a3799729.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e535e5c28162/vmlinu=
x-a3799729.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/32eefbbcadbb/b=
zImage-a3799729.xz
>
> The issue was bisected to:
>
> commit 083772c9f972dcc248913b52a0dec1025baa1e16
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Sun Nov 26 23:07:30 2023 +0000
>
>     net: page_pool: record pools per netdev
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10c72162e8=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D12c72162e8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14c72162e8000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com
> Fixes: 083772c9f972 ("net: page_pool: record pools per netdev")
>
> Illegal XDP return value 4294946546 on prog  (id 2) dev N/A, expect packe=
t loss!
> general protection fault, probably for non-canonical address 0xdffffc0000=
000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 5064 Comm: syz-executor391 Not tainted 6.7.0-rc2-syzkaller-00=
533-ga379972973a8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/10/2023
> RIP: 0010:__hlist_del include/linux/list.h:988 [inline]
> RIP: 0010:hlist_del include/linux/list.h:1002 [inline]
> RIP: 0010:page_pool_unlist+0xd1/0x170 net/core/page_pool_user.c:342
> Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 4c 8b a3 f0 0=
6 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75=
 68 48 85 ed 49 89 2c 24 74 24 e8 1b ca 07 f9 48 8d
> RSP: 0018:ffffc900039ff768 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff88814ae02000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88814ae026f0
> RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d57fdc
> R10: ffffffff8eabfee3 R11: ffffffff8aa0008b R12: 0000000000000000
> R13: ffff88814ae02000 R14: dffffc0000000000 R15: 0000000000000001
> FS:  000055555717a380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000002555398 CR3: 0000000025044000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __page_pool_destroy net/core/page_pool.c:851 [inline]
>  page_pool_release+0x507/0x6b0 net/core/page_pool.c:891
>  page_pool_destroy+0x1ac/0x4c0 net/core/page_pool.c:956
>  xdp_test_run_teardown net/bpf/test_run.c:216 [inline]
>  bpf_test_run_xdp_live+0x1578/0x1af0 net/bpf/test_run.c:388
>  bpf_prog_test_run_xdp+0x827/0x1530 net/bpf/test_run.c:1254
>  bpf_prog_test_run kernel/bpf/syscall.c:4041 [inline]
>  __sys_bpf+0x11bf/0x4920 kernel/bpf/syscall.c:5402
>  __do_sys_bpf kernel/bpf/syscall.c:5488 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5486 [inline]
>  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5486
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f616195a4a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe858ce5c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007ffe858ce798 RCX: 00007f616195a4a9
> RDX: 0000000000000048 RSI: 0000000020000340 RDI: 000000000000000a
> RBP: 00007f61619cd610 R08: 0000000000000000 R09: 00007ffe858ce798
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffe858ce788 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__hlist_del include/linux/list.h:988 [inline]
> RIP: 0010:hlist_del include/linux/list.h:1002 [inline]
> RIP: 0010:page_pool_unlist+0xd1/0x170 net/core/page_pool_user.c:342
> Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 4c 8b a3 f0 0=
6 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75=
 68 48 85 ed 49 89 2c 24 74 24 e8 1b ca 07 f9 48 8d
> RSP: 0018:ffffc900039ff768 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff88814ae02000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88814ae026f0
> RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d57fdc
> R10: ffffffff8eabfee3 R11: ffffffff8aa0008b R12: 0000000000000000
> R13: ffff88814ae02000 R14: dffffc0000000000 R15: 0000000000000001
> FS:  000055555717a380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2640df1b10 CR3: 0000000025044000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   df 48 89                fisttps -0x77(%rax)
>    3:   fa                      cli
>    4:   48 c1 ea 03             shr    $0x3,%rdx
>    8:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>    c:   0f 85 90 00 00 00       jne    0xa2
>   12:   4c 8b a3 f0 06 00 00    mov    0x6f0(%rbx),%r12
>   19:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   20:   fc ff df
>   23:   4c 89 e2                mov    %r12,%rdx
>   26:   48 c1 ea 03             shr    $0x3,%rdx
> * 2a:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping in=
struction
>   2e:   75 68                   jne    0x98
>   30:   48 85 ed                test   %rbp,%rbp
>   33:   49 89 2c 24             mov    %rbp,(%r12)
>   37:   74 24                   je     0x5d
>   39:   e8 1b ca 07 f9          call   0xf907ca59
>   3e:   48                      rex.W
>   3f:   8d                      .byte 0x8d
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.gi=
t
main

```
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 1426434a7e1587797da92f3199c0012559b51271..07becd4eceddcd4be9e5bea6479=
f8ffd16dac851
100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -339,7 +339,8 @@ void page_pool_unlist(struct page_pool *pool)
        mutex_lock(&page_pools_lock);
        netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_DEL_NTF);
        xa_erase(&page_pools, pool->user.id);
-       hlist_del(&pool->user.list);
+       if (!hlist_unhashed(&pool->user.list))
+               hlist_del(&pool->user.list);
        mutex_unlock(&page_pools_lock);
 }

```
