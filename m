Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9259B808FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443692AbjLGSTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443685AbjLGSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:19:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457E1709
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:19:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so817a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701973181; x=1702577981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRsjDb6mA+FW2hKeekZ90f1y/ZH6v6PCtS6U4SICFAk=;
        b=KzIwMpJTfZeNIqNfJ9r8lAjvk7yzra8V0SKnuDZpVG4EVgjiI1yiCkMZeHe5EBG1Ik
         LjHQhInBPTe6qCCin3sRYiQQU19Lhm4W14sbIMYXLYgs9plGILPDEz/04J4UZ/twL14H
         oJoL87SutqLKoG4uMAqFvT7AUjJyQd/JBL2C6YEOnea2gethUC2psgCqaRC+Gi6BBxtn
         BscryLnXbzrNAEZn0GbFflid1sN33l98r8fwz7CzLn7tvrQzzsgbGt7ybOf+Dgu0a0bk
         pXVwjE+NS5R4v8iFMlgZEWywlv1xnpGPCO6q+LWD05J8RKvj1iIwPhufPAgRU4j+vNtT
         itgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973181; x=1702577981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRsjDb6mA+FW2hKeekZ90f1y/ZH6v6PCtS6U4SICFAk=;
        b=itqbJiuDtMMYJoij9jC1dxYlOaHwFSMMhUG4L32yV0YajIzu3YxJW/lRKcza0Ba/5F
         gYBo8XfbG1Q8qNKx4qguMMRk577RuMdUBi0QfRZS3L0QPJbWbNy1GvFMjG1Vee3rZyX8
         zIaShO8NqP53ra0hvQAVcJeRtJk3Hco5FeyYhuGxlRxDC7U+gFmxhTH8wd/3ERSBjVZ1
         6FpNMFKu7evBty5DuU95/0LmuHBFALDCSesUpY+THUXHs/h43/vTTBtoWcDZ7RHgwAW+
         ju9DIFPfyMDnck4LcB+VpvtGkoQlrU+NrQucvx/rGDRMQE/GTjWSFGVMiodHrwKZXW+6
         4htg==
X-Gm-Message-State: AOJu0YxtKIpQTqFHg3cmDi7Szss7nIO6IToC5bCHxNTDAvbno0CMA0xz
        Cu8TC4mylmhvQMY8YNyFdgJQ3W58e/7ouGai9ki4Fg==
X-Google-Smtp-Source: AGHT+IHRfNGL1P9OzT4Cp9l/Wze2RoKcUSJ4KqtV64stTzlksC8rSqSWHEkKwp+vlO8que08QNJlW86Rz56rabtjFZE=
X-Received: by 2002:a50:c356:0:b0:54a:ee8b:7a8c with SMTP id
 q22-20020a50c356000000b0054aee8b7a8cmr555edb.0.1701973181300; Thu, 07 Dec
 2023 10:19:41 -0800 (PST)
MIME-Version: 1.0
References: <000000000000cb5b07060bef7ac0@google.com>
In-Reply-To: <000000000000cb5b07060bef7ac0@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Dec 2023 19:19:30 +0100
Message-ID: <CANn89iLN+LyL5mDt37NmHSan_dpa5-pxqaWQVGSHb6kuK37=0A@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_route_info_create
To:     syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>,
        Kui-Feng Lee <thinker.li@gmail.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 7:17=E2=80=AFPM syzbot
<syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5a08d0065a91 ipv6: add debug checks in fib6_info_release(=
)
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D175698dae8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df8715b6ede5c4=
b90
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc15aa445274af86=
74f41
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16070374e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D145e1574e8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/12a59d7df47f/dis=
k-5a08d006.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/14f0ca0a861e/vmlinu=
x-5a08d006.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ae9306decbe5/b=
zImage-5a08d006.xz
>
> The issue was bisected to:
>
> commit 5a08d0065a915ccf325563d7ca57fa8b4897881c
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Dec 5 17:32:50 2023 +0000
>
>     ipv6: add debug checks in fib6_info_release()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1137437ae8=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1337437ae8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1537437ae8000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
> Fixes: 5a08d0065a91 ("ipv6: add debug checks in fib6_info_release()")
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5062 at include/net/ip6_fib.h:332 fib6_info_release =
include/net/ip6_fib.h:332 [inline]
> WARNING: CPU: 0 PID: 5062 at include/net/ip6_fib.h:332 ip6_route_info_cre=
ate+0x1a1a/0x1f10 net/ipv6/route.c:3829
> Modules linked in:
> CPU: 0 PID: 5062 Comm: syz-executor399 Not tainted 6.7.0-rc3-syzkaller-00=
805-g5a08d0065a91 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/10/2023
> RIP: 0010:fib6_info_release include/net/ip6_fib.h:332 [inline]
> RIP: 0010:ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
> Code: 49 83 7f 40 00 75 28 e8 04 ae 50 f8 49 8d bf a0 00 00 00 48 c7 c6 c=
0 ae 37 89 e8 41 2c 3a f8 e9 65 f4 ff ff e8 e7 ad 50 f8 90 <0f> 0b 90 eb ad=
 e8 dc ad 50 f8 90 0f 0b 90 eb cd e8 d1 ad 50 f8 e8
> RSP: 0018:ffffc900039cf8e0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000400000 RCX: ffffffff8936e418
> RDX: ffff888014695940 RSI: ffffffff8936e469 RDI: 0000000000000005
> RBP: ffffc900039cf9d0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000400000 R11: ffffffff8aa0008b R12: ffffffffffffffed
> R13: ffff88802560682c R14: ffffc900039cfac4 R15: ffff888025606800
> FS:  00005555567bb380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200001c2 CR3: 00000000793d5000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ip6_route_add+0x26/0x1f0 net/ipv6/route.c:3843
>  ipv6_route_ioctl+0x3ff/0x590 net/ipv6/route.c:4467
>  inet6_ioctl+0x265/0x2b0 net/ipv6/af_inet6.c:575
>  sock_do_ioctl+0x113/0x270 net/socket.c:1220
>  sock_ioctl+0x22e/0x6b0 net/socket.c:1339
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f73fa33f369
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffce78f30b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffce78f3288 RCX: 00007f73fa33f369
> RDX: 00000000200001c0 RSI: 000000000000890b RDI: 0000000000000003
> RBP: 00007f73fa3b2610 R08: 0000000000000000 R09: 00007ffce78f3288
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffce78f3278 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
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

As discussed in another thread, the root cause is:

commit 3dec89b14d37ee635e772636dad3f09f78f1ab87
Author: Kui-Feng Lee <thinker.li@gmail.com>
Date:   Tue Aug 15 11:07:05 2023 -0700

    net/ipv6: Remove expired routes with a separated list of routes.

    FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a =
tree
    can be expensive if the number of routes in a table is big, even if mos=
t of
    them are permanent. Checking routes in a separated list of routes havin=
g
    expiration will avoid this potential issue.

    Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
    Reviewed-by: David Ahern <dsahern@kernel.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>
