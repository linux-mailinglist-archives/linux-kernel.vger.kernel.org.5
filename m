Return-Path: <linux-kernel+bounces-134809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939089B73B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27371F210E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89918BFC;
	Mon,  8 Apr 2024 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzBhiL+F"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512917494
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712554818; cv=none; b=Q2KBSuZzHb0QwSpmHcuH3cve1Hx/QTnfZAVsJ2KNArHYa0mzz0n362ZGk1J9cvL0Af8IqlVz8rBsTM72TBGUIJLMCVtLozDANLv+wCJ5JlGt1LeKBn7c8rHN8qmZtzBPXSzOF/Kj43FW8QzCPaBdhAWOZVwzmIQNt3xOlFbIY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712554818; c=relaxed/simple;
	bh=hwP9/93yTUBSNOHrkALltgu6WO2MGK1MOTDRWzQCIYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kg+K/MQOYZwutvXoprtuDGOD+vmjdLsG1H2U3HJOXDOjexRXf9kqIkUKkuNqJO4EzXzhZOVeG46HHnGOJSY+aLxQhsZ4ZUl4Zr+HqWVxcxqCiuYf3eGqXt/sPzeZjt7igI7BUbgT51vEBS7PnswqFTvAv7oQ5YSUDrTMMOBtrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzBhiL+F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4166a46e3cdso28175e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 22:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712554815; x=1713159615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIWC9vvwzsPFLiTiHNlbceQ+j7iysO2Db2TSf4ijONQ=;
        b=SzBhiL+F4hMpShwm85bOBkkkF/flyu0t4smPP83vt+dygUrvxDm1a0UlU7MJ9pNX9P
         xD3C359a+kbSCTm8z73acjExlzzDrw7SDM/WvvF7cPUq8Oe/C235HEMjtWOMPhDRRTjC
         DEsyZ/5t4PdNXrTGIIzjL6pONcFQsmBa9hvEg+LenZruOisR8fxj1WtDnDJi1SmeV/y/
         7QX0E7JfKAvKvrkSoFzyxDO8nygeFDawfgw5Xeb3C2tyvuA7mSw2vurdM/RU3kBiyIMc
         5oWWkBSJefndJczlv2Z7qA97LSxsU427XMrIVAnxtp89S57Q8af3EismFg/2e0kRKe/1
         XK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712554815; x=1713159615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIWC9vvwzsPFLiTiHNlbceQ+j7iysO2Db2TSf4ijONQ=;
        b=Z7ZZsJiH506t6hanHkS8Jy3NfODIcWPrgfBNbGv/hd1cTXireOZZlfzoUwKr5zQYNO
         k7bnciQ64L30wcZXkV8jjFEyLzqoWIoWyTOlV5qVNCM5GL3GABQOF9/XQ7Woqt6MLFuh
         1I9pHaVhe7LidTrxRlb5Xw9GQNTlQ3OGWHiV6B3J0BxpMhNF51LCRT2m/0BHOARL0aIz
         m89fQZjKCkx4cennl8yj6NO+oS8br/x+1VhoeWECo6vwnDRBDjKw2s3LKUlV4IRAlLtN
         uDOmc337W2VZWSkWUsx7e/Ra9PLNkHtk+SmWt8M3BcM1jEXbHmHRR1GRWwPqyOoFJPRU
         atyg==
X-Forwarded-Encrypted: i=1; AJvYcCUz3b7VebFZj6CMC5lU2ilVwFabS9ctlkSUEAwvs9Ixgv0guixsS7Pnkziu1aFaRgxWFYVp/MT1rRjp4WwdMDF4TcFTRb/+VkDuyBJQ
X-Gm-Message-State: AOJu0YzpRp7BI54ci8sOx1YeqD7wyPuULQagp/BPeLKctGKbKVjwS5Kt
	GrwDdmj/HVAf2V2uOGay2kEv2IzPVvPW88ENbD1exyqB4U6gmz/CwU0GskmmvALNf3lI3SVeqA9
	3Ji7srunmuluQaOCVdmJ+ScdPGsy75gNcKTOv
X-Google-Smtp-Source: AGHT+IGEPJF2DbMp9F3g/z4behT0nb1A/GkBLGsynCOujqZ5X2o8cisakfbV+r0aEIhUnegvylF9PLcMhSNkJLbNZRw=
X-Received: by 2002:a05:600c:511e:b0:416:8041:28d7 with SMTP id
 o30-20020a05600c511e00b00416804128d7mr30506wms.6.1712554814370; Sun, 07 Apr
 2024 22:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c30be606158f33db@google.com>
In-Reply-To: <000000000000c30be606158f33db@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 07:40:00 +0200
Message-ID: <CANn89iLq3PdiuS=qYAtUKFcrd24z2Kw8k=gMNcBcaEFkTWpd0g@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: global-out-of-bounds Read in __nla_validate_parse
To: syzbot <syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 7:37=E2=80=AFAM syzbot
<syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8568bb2ccc27 Add linux-next specific files for 20240405
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1644633918000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D48ca5acf8d2eb=
3bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Decd7e07b4be0386=
58c9f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D134f60bd180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1043b30318000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1d120b5e779c/dis=
k-8568bb2c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a89e3589a585/vmlinu=
x-8568bb2c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/045e657c0e0d/b=
zImage-8568bb2c.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:411 [inline=
]
> BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x1f1c/0x2f70 li=
b/nlattr.c:635
> Read of size 1 at addr ffffffff8c55d030 by task syz-executor361/5080
>
> CPU: 1 PID: 5080 Comm: syz-executor361 Not tainted 6.9.0-rc2-next-2024040=
5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  validate_nla lib/nlattr.c:411 [inline]
>  __nla_validate_parse+0x1f1c/0x2f70 lib/nlattr.c:635
>  __nla_parse+0x40/0x60 lib/nlattr.c:732
>  __nlmsg_parse include/net/netlink.h:760 [inline]
>  genl_family_rcv_msg_attrs_parse+0x1d1/0x290 net/netlink/genetlink.c:945
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1093 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0x802/0xec0 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> RIP: 0033:0x7f831a5c23a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcd752ec88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007ffcd752ee58 RCX: 00007f831a5c23a9
> RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
> RBP: 00007f831a635610 R08: 00007f831a5fda23 R09: 00007ffcd752ee58
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffcd752ee48 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
>
> The buggy address belongs to the variable:
>  team_nl_policy+0x30/0x60
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xc55d
> flags: 0xfff80000002000(reserved|node=3D0|zone=3D1|lastcpupid=3D0xfff)
> raw: 00fff80000002000 ffffea0000315748 ffffea0000315748 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner info is not present (never set?)
>
> Memory state around the buggy address:
>  ffffffff8c55cf00: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffffff8c55cf80: 00 00 00 00 f9 f9 f9 f9 00 00 00 00 f9 f9 f9 f9
> >ffffffff8c55d000: 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 00 00 00 00
>                                      ^
>  ffffffff8c55d080: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 00
>  ffffffff8c55d100: 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 00 02 f9 f9
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

Probably caused by

commit 948dbafc15da900b13c2bc9e244b9e109303907b
Author: Hangbin Liu <liuhangbin@gmail.com>
Date:   Mon Apr 1 11:10:03 2024 +0800

    net: team: use policy generated by YAML spec

    generated with:

     $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
     > --spec Documentation/netlink/specs/team.yaml --source \
     > -o drivers/net/team/team_nl.c
     $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
     > --spec Documentation/netlink/specs/team.yaml --header \
     > -o drivers/net/team/team_nl.h

    The TEAM_ATTR_LIST_PORT in team_nl_policy is removed as it is only in t=
he
    port list reply attributes.

    Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
    Reviewed-by: Jiri Pirko <jiri@nvidia.com>
    Link: https://lore.kernel.org/r/20240401031004.1159713-4-liuhangbin@gma=
il.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

