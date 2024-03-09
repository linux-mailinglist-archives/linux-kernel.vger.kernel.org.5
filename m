Return-Path: <linux-kernel+bounces-97946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA38877221
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3258C281B22
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3BA45961;
	Sat,  9 Mar 2024 16:02:34 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99044C65
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710000154; cv=none; b=B3GtTTf8g/OeY1P3eLIwPqU6AVqQvHoUAvavgGbwOgo4Nf5HHuzPfkLb3hGqfecwPlEneHG4ZhyJm9R5MR7LtC87NnQfn7yqBktjTarqLJzS8Rmi8noidsHUgVYb1ueZuCCPZqaeDZVBjHP2HBwwuibm9Xg0/O0QNwpn4k4BDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710000154; c=relaxed/simple;
	bh=IlNrku6gx4ITKYYDutuHTeSlU+G5G6ZUR+kyBRWRaxU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OchLYQsSYioP6OI7OkO1rIiiPHSHeXR5nZWJSZS9iwz6aTRyQw/5ElKGSYTVjaDT+JoGVkBqzBUAAkMIa4AQ9+4pqBIRrldZ+lwl1K4HFFVDkeu4FmfMF/sPy/2Ka6NklHWor2R9sckk0xt7RjU1c1Pr1eIjOL2+PxiAJv29QIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3662e583684so17786875ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 08:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710000151; x=1710604951;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DP1DpJ1i+QrXcPetYGEJb/XTbYsSwgXExEyAIL0rh6k=;
        b=VuwG7fyyeqo1ae/xwJhoJVoHEHVR1PxAlpm48LltsmihXGb4uf8czDnqYji0hwg+9F
         v1oMqw664u91Jqkr/eOFl6WUovAOsX429MA6FtwnAs6Us0GvyAynhw0OOUY8P9suHR6B
         kkPErnC47VGIwVBeNPQsPHk3sDqor6wtff/Gk5wtJYn0tuUnPCDkZN9DxKQlID9/HlNm
         VUegI1CQdQInOcdDYAJlSTEKXN0gpg+ULxNLlE5qlXhggEREJb+I2Gu4Y47H/eCe4d5c
         tmdGU39UsYrvYqLlyzAftzM2aGNZkzpKycvQa6b4qJP5Lavr0Pu0HUeHrP7jQy0B5h80
         2KGA==
X-Forwarded-Encrypted: i=1; AJvYcCXAQ+TKBRqXvN2Fw9iNbkO095KjPaW9XJtxlzyXqtRJZVtesvZak4MlfpnqlaRa9y+MRKpHkVvmu78Wvn8LxfJIOv2ZtXXbcTkNMNwC
X-Gm-Message-State: AOJu0YzDmAiLstB4tJS7tfksSl6bwjhgDrL1BeKLDmLmvygqHJhsO8ba
	tGDiemGKT2NewOd97TZUZwze/wvcWFd0RP7dChG3RgTxIWPsfBOvEaNwFMfHuDyBGTTJcEPFn4S
	CE3fxSO2PN8snNkeln0yAg7rIBtKo/DmHxqyxI/moOnEe75CzAJQrjTw=
X-Google-Smtp-Source: AGHT+IEnqyTXCKSaxdQhDPFxJ8eQG150S4a4p8lsjTHwF8btT+LJXq03mW7lZ6jdcK/owA+1HcGU/bIv3caTBoQsj1oarwHDYhAI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8e:b0:365:7607:3f4b with SMTP id
 h14-20020a056e021d8e00b0036576073f4bmr61509ila.2.1710000151675; Sat, 09 Mar
 2024 08:02:31 -0800 (PST)
Date: Sat, 09 Mar 2024 08:02:31 -0800
In-Reply-To: <00000000000088981b06133bc07b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b652f06133c6f27@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in __nla_validate_parse
From: syzbot <syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, petrm@nvidia.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d7e14e534493 Merge tag 'mlx5-socket-direct-v3' of git://gi..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1179b11e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63afafeedf00ef8f
dashboard link: https://syzkaller.appspot.com/bug?extid=65bb09a7208ce3d4a633
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113a3399180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156404d6180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6e15425ce891/disk-d7e14e53.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/290e40cea50b/vmlinux-d7e14e53.xz
kernel image: https://storage.googleapis.com/syzbot-assets/099bac6ed92e/bzImage-d7e14e53.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at lib/nlattr.c:411!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5074 Comm: syz-executor243 Not tainted 6.8.0-rc7-syzkaller-02431-gd7e14e534493 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:validate_nla lib/nlattr.c:411 [inline]
RIP: 0010:__nla_validate_parse+0x2f61/0x2f70 lib/nlattr.c:635
Code: 48 8b 4c 24 18 80 e1 07 38 c1 0f 8c e0 f7 ff ff 48 8b 7c 24 18 e8 ff 0e 1d fd e9 d1 f7 ff ff e8 d5 c2 91 06 e8 50 64 ba fc 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc900041b6ec0 EFLAGS: 00010293
RAX: ffffffff84d90ad0 RBX: ffffffff8caa11e0 RCX: ffff8880283bd940
RDX: 0000000000000000 RSI: 000000000000004e RDI: 0000000000000015
RBP: ffffc900041b7100 R08: ffffffff84d8df5b R09: 0000000000000000
R10: ffffc900041b71a0 R11: fffff52000836e46 R12: 0000000000000008
R13: 1ffff11003d97c83 R14: 000000000000004e R15: 0000000000000008
FS:  0000555556b10380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 000000007aa22000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __nla_parse+0x40/0x60 lib/nlattr.c:732
 __nlmsg_parse include/net/netlink.h:756 [inline]
 nlmsg_parse include/net/netlink.h:777 [inline]
 rtm_del_nexthop+0x257/0x6d0 net/ipv4/nexthop.c:3256
 rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e0/0xcb0 net/netlink/af_netlink.c:1902
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f70bac1d369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcffdc2f38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffcffdc3108 RCX: 00007f70bac1d369
RDX: 0000000000000000 RSI: 0000000020000640 RDI: 0000000000000003
RBP: 00007f70bac90610 R08: 0000000000000000 R09: 00007ffcffdc3108
R10: 00007f70bac589e3 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcffdc30f8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:validate_nla lib/nlattr.c:411 [inline]
RIP: 0010:__nla_validate_parse+0x2f61/0x2f70 lib/nlattr.c:635
Code: 48 8b 4c 24 18 80 e1 07 38 c1 0f 8c e0 f7 ff ff 48 8b 7c 24 18 e8 ff 0e 1d fd e9 d1 f7 ff ff e8 d5 c2 91 06 e8 50 64 ba fc 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc900041b6ec0 EFLAGS: 00010293
RAX: ffffffff84d90ad0 RBX: ffffffff8caa11e0 RCX: ffff8880283bd940
RDX: 0000000000000000 RSI: 000000000000004e RDI: 0000000000000015
RBP: ffffc900041b7100 R08: ffffffff84d8df5b R09: 0000000000000000
R10: ffffc900041b71a0 R11: fffff52000836e46 R12: 0000000000000008
R13: 1ffff11003d97c83 R14: 000000000000004e R15: 0000000000000008
FS:  0000555556b10380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 000000007aa22000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

