Return-Path: <linux-kernel+bounces-97400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED2876A02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768D8283C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFD23FBB9;
	Fri,  8 Mar 2024 17:34:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7E65D471
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919270; cv=none; b=XZ4XVXSwTHkTAy+p8onT4l15GuQi3RFrGVDi6UF5kL6+vDgSr4c57sPGGZKfCYKBJdbg91Lyz2kvanyVpTUwlLp52rhb3/Y+4rmPFwxQG9CbTsnbHWbHC8K+iTkoJ8PDKEMK3cTEwm30lrrFAh4OO4fzZocKLx9vvLVwuB2gWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919270; c=relaxed/simple;
	bh=8e9/e9NFm5ntuPCTH/0anSEfGQKkPWqlsbkyI1OBVHU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WfUtbBBeSutHtHYLLm9gwy3c1AD5ruPWW+eYOV7w+wLUSt/MQWNwhkk82/p0a2I6rnsWVjlCmB0ev2WV8kNw9aI0dZk0ttz+Tx1ZQOtTa7Q9mIEIyR2wz8tH4esyA7CBuDIsts8/zdIVBxf2J3pEY9iFTfJ5p3EIZNr3sXjyxSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c855240d74so221084139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 09:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919268; x=1710524068;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PxTyDbGvCgebErQBNv/Wuktri5b5uOMubf1v6wI+Rk=;
        b=s2M7YkZTIOgxZ3GtCnAx35iJP2JMtHDzr2A3GmZU+6JkzVItAklBjx30Lh2LHiZFl8
         o4M0+m+K/sJLqTjCPYgCu+5krjpGEiTFzzsSbSZu9IekguO0PgG8BiwUcaUhlKR0+yIv
         KW5vuLi6yjOwfd6U0JYl7p5Fv7g5vE8usU3oPqDUI/gUm7aqcXNiUOEsaK4iyUpSiPgf
         hl3/maUxduekVjOJLAQ+r5GIVOt4nS42Aaan1PfqujERzKxbBiouKwR3Eg0AQw5cKoAz
         f9dXr8to/L+GIOvvQuDTS0Mppf1wMzIZN3bJSaCzSoSEAisitqkRAj5U2u/Zs0UIMWa4
         ANKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+dB3VEGh3aM/eud8EfxT9REs/JTCyhYhhJa1ISa2RquGRDAUEiTFSDt79NHpYcDf0yyL/v4Y5BctIy62BwtADA6YMQ3eaelCUjei6
X-Gm-Message-State: AOJu0YyqMWWJxmAGvO786FzGMpypt/W4dF3QUCiLMUOAwh5muyDILoul
	lIBjn858LVKILcVAQc0czr7WoSw6VG5G/OWSWFnXUqQivpKDBGzUM6ny7YiMOQO/a/m0fPTzsv4
	fLZ3xXFW0B9klwGEoQOptvvEgdHvce+ucQ9bpws0IuIJwQZ5rgSXQi84=
X-Google-Smtp-Source: AGHT+IGKOvplZ3C2VE4bK9k+BTiEDF/fOksVRR7zDG2cmmTkQ34nJIglWHpJL6Ea7GUZTj2aurqZFRiEl4MX2uSY89ezbjAGDjRQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1604:b0:7c8:65ae:84fd with SMTP id
 x4-20020a056602160400b007c865ae84fdmr150802iow.0.1709919268281; Fri, 08 Mar
 2024 09:34:28 -0800 (PST)
Date: Fri, 08 Mar 2024 09:34:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094b65a0613299ae7@google.com>
Subject: [syzbot] [net?] WARNING in sk_nulls_del_node_init_rcu
From: syzbot <syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c055fc00c07b net/rds: fix WARNING in rds_conn_connect_if_d..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16aa17f2180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=12c506c1aae251e70449
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c39eb6fb3ad1/disk-c055fc00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/110f1226eb89/vmlinux-c055fc00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1303e2df5cc4/bzImage-c055fc00.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007f3b817abf80 R15: 00007ffd3beb57b8
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 23948 at include/net/sock.h:799 sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
Modules linked in:
CPU: 0 PID: 23948 Comm: syz-executor.2 Not tainted 6.8.0-rc6-syzkaller-00159-gc055fc00c07b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
Code: e8 7f 71 c6 f7 83 fb 02 7c 25 e8 35 6d c6 f7 4d 85 f6 0f 95 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 1b 6d c6 f7 90 <0f> 0b 90 eb b2 e8 10 6d c6 f7 4c 89 e7 be 04 00 00 00 e8 63 e7 d2
RSP: 0018:ffffc900032d7848 EFLAGS: 00010246
RAX: ffffffff89cd0035 RBX: 0000000000000001 RCX: 0000000000040000
RDX: ffffc90004de1000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 1ffff1100439ac26 R08: ffffffff89ccffe3 R09: 1ffff1100439ac28
R10: dffffc0000000000 R11: ffffed100439ac29 R12: ffff888021cd6140
R13: dffffc0000000000 R14: ffff88802a9bf5c0 R15: ffff888021cd6130
FS:  00007f3b823f16c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b823f0ff8 CR3: 000000004674a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __inet_hash_connect+0x140f/0x20b0 net/ipv4/inet_hashtables.c:1139
 dccp_v6_connect+0xcb9/0x1480 net/dccp/ipv6.c:956
 __inet_stream_connect+0x262/0xf30 net/ipv4/af_inet.c:678
 inet_stream_connect+0x65/0xa0 net/ipv4/af_inet.c:749
 __sys_connect_file net/socket.c:2048 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2072
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f3b8167dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3b823f10c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f3b817abf80 RCX: 00007f3b8167dda9
RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f3b823f1120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007f3b817abf80 R15: 00007ffd3beb57b8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

