Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301E2754275
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbjGNSTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbjGNSS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:18:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438E02117
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:18:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9926623e367so296204466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689358724; x=1691950724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5rxC7sMhEP8sz5SV+W4V4TsgMdqP2wjEB0Uah+p09Q=;
        b=aOyPfjaoNpYIKkBgAwd12AmQq5VoMzvanV86KwtDq6C5mLl8bbXwwBQpKXKMtNW5PQ
         JjeKn44RAjQuA85Cd/DSCPDzEgBQVSzU7xRnb2zUELBdQqhms/vWQTPSCZ3Un6nUFn4S
         dIlpu4IKRcDwGm5CLQdeoSpdDU3ocSFGL/0BiyEuP2P8jnbb0Li/BKgDo7ybrAOBIxF3
         ZrQ/J5fAkzIPlhdxESuDIpwE4YY0VBopWXj6jG5IBVFw55fGBxbXzR4Sl5X04jznncBa
         iMxaBDzzZ/xAiCVD1peN1PCh7ab1h7ypHMcpXKmztnJQ6ZN/jpqYKau03PrmUpvp8UU4
         LwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689358724; x=1691950724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5rxC7sMhEP8sz5SV+W4V4TsgMdqP2wjEB0Uah+p09Q=;
        b=cf5gucr3Du0IEV3h+OXAu0OXgLcVC9tqhDXQFVGxhefQaEPKnixpduImH2IYA4VqKb
         9UBSA5SYeWqwss6l5dAHGOPzZRW62CJQ1w+IsUV50rAH5/ub+FVa0FvRt3flo6SZIrRR
         mQmlvBlslsw/2/PPswZ5TQ7uMLVmRFXZO7AOR7inGOye6nuvOf3an3KMPX800xO9YRJs
         keAW8Hqvmyl2E3nW6HXGryliONzeHcOGAroKqPwudZgCb9GtE9B/1joQHZ7aBOVAwmJh
         hWzyVlMAQ+X4FnNVwMKCQ5yoyy8j59TcXA5hbcUb+sSWrcksa3z/O7574Yswfr5B+cbt
         e+zg==
X-Gm-Message-State: ABy/qLbTairp3qF5+F+nA2LfpmKoW6tbLYw7Tz+iO2OI5xzc1qkw2SFL
        XPOErYyAPjrvovshNYc0qFAINvQWwPnqGViFGF0abA==
X-Google-Smtp-Source: APBJJlEZxFRm7fgzvEW8Xqbum6bSY1nsEI9jYdCPkgjwX5s2ZQs3U0Bpw6FM6iqhm+90GJVC+xHudFbzWSh7F5TTJfg=
X-Received: by 2002:a17:906:35c2:b0:98d:ef34:c0c8 with SMTP id
 p2-20020a17090635c200b0098def34c0c8mr3966023ejb.67.1689358723509; Fri, 14 Jul
 2023 11:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004edae006006a2109@google.com> <20230714085317.751f7d309116daa78ebedc14@linux-foundation.org>
In-Reply-To: <20230714085317.751f7d309116daa78ebedc14@linux-foundation.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 14 Jul 2023 11:18:07 -0700
Message-ID: <CAJHvVcjonEoHvimLrSxqhFw5o_=7EEu8se-OWB5bzPY8KnXnJw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in mfill_atomic_copy
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+42309678e0bc7b32f8e9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 8:53=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 13 Jul 2023 20:34:45 -0700 syzbot <syzbot+42309678e0bc7b32f8e9@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    fe57d0d86f03 Add linux-next specific files for 20230710
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14d46ed8a80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Deaa6217eed7=
1d333
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D42309678e0bc7=
b32f8e9
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14b63e18a=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13784d64a80=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/9e7627fb1623/d=
isk-fe57d0d8.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/848a690045db/vmli=
nux-fe57d0d8.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/36e5c3ae635e=
/bzImage-fe57d0d8.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+42309678e0bc7b32f8e9@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > kernel BUG at mm/userfaultfd.c:573!
>
> Thanks.  cc's added.

Yeah, the problem is my commit "mm: userfaultfd: check for start + len
overflow in validate_range"

userfaultfd_copy *only* calls validate_range() on the dst range, not
the src. So an invalid src range (e.g. a zero sized one) isn't noticed
until further down in the call stack where we BUG.

I think the correct fix is just to call validate_range() on both
ranges. I'll send a commit to that effect.

>
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 5031 Comm: syz-executor410 Not tainted 6.5.0-rc1-next-20230=
710-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/03/2023
> > RIP: 0010:mfill_atomic mm/userfaultfd.c:573 [inline]
> > RIP: 0010:mfill_atomic_copy+0x9ed/0x17e0 mm/userfaultfd.c:725
> > Code: 8d 8c 24 a8 00 00 00 4c 89 e7 e8 be 54 d9 ff 4c 63 f0 e9 71 fc ff=
 ff e8 51 eb a1 ff 0f 0b e8 4a eb a1 ff 0f 0b e8 43 eb a1 ff <0f> 0b e8 3c =
eb a1 ff 0f 0b 49 c7 c6 ef ff ff ff e9 54 fd ff ff e8
> > RSP: 0018:ffffc9000395fb48 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > RDX: ffff88801f67bb80 RSI: ffffffff81e32bad RDI: 0000000000000006
> > RBP: 0000000000000000 R08: 0000000000000006 R09: ffffffffffffffff
> > R10: 0000000005ffffff R11: 0000000000000001 R12: 0000200000000000
> > R13: 00005ffffffff001 R14: ffffffffffffffff R15: 0000000005ffffff
> > FS:  00005555571e03c0(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000060 CR3: 000000002ba7a000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  userfaultfd_copy fs/userfaultfd.c:1766 [inline]
> >  userfaultfd_ioctl+0xe43/0x4c40 fs/userfaultfd.c:2098
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f2e41c4b4b9
> > Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fff13a95188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007fff13a95198 RCX: 00007f2e41c4b4b9
> > RDX: 0000000020000040 RSI: 00000000c028aa03 RDI: 0000000000000003
> > RBP: 00007fff13a95190 R08: 00007fff13a95190 R09: 00007f2e41c0e380
> > R10: 00007fff13a95190 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:mfill_atomic mm/userfaultfd.c:573 [inline]
> > RIP: 0010:mfill_atomic_copy+0x9ed/0x17e0 mm/userfaultfd.c:725
> > Code: 8d 8c 24 a8 00 00 00 4c 89 e7 e8 be 54 d9 ff 4c 63 f0 e9 71 fc ff=
 ff e8 51 eb a1 ff 0f 0b e8 4a eb a1 ff 0f 0b e8 43 eb a1 ff <0f> 0b e8 3c =
eb a1 ff 0f 0b 49 c7 c6 ef ff ff ff e9 54 fd ff ff e8
> > RSP: 0018:ffffc9000395fb48 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > RDX: ffff88801f67bb80 RSI: ffffffff81e32bad RDI: 0000000000000006
> > RBP: 0000000000000000 R08: 0000000000000006 R09: ffffffffffffffff
> > R10: 0000000005ffffff R11: 0000000000000001 R12: 0000200000000000
> > R13: 00005ffffffff001 R14: ffffffffffffffff R15: 0000000005ffffff
> > FS:  00005555571e03c0(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000060 CR3: 000000002ba7a000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the bug is already fixed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to change bug's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the bug is a duplicate of another bug, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
