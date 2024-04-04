Return-Path: <linux-kernel+bounces-131229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841AA8984DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95E4281DE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84C774E10;
	Thu,  4 Apr 2024 10:15:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB40745C3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225707; cv=none; b=d7zzku1+tCLtkfzu8LZhzP3nmNhL74vtVjO2EN0b/xvL403FX8E0CdTr3UguGDZZVphXYo+HKgzccfaROGrbWz8faAIL7BnJqSW1BvueqeNgWzDj/6YDCc3v6MdrZ2GvT8WmXlTAnDIqXNXPKA8l2HMHzdii2j7fmU5TiNjuMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225707; c=relaxed/simple;
	bh=iWPRI/o1CkXUEF7DPMBj7jcLy8akddDYF2h7r0pfFIY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LZWta50NIkzA8DYOvxGj+xpYsghJLv6Ie9tCNsPv0cfaWtJVSD8x2IWE+tHkVW1rB6c91qHeiNqVXpfvKPEwKez2Hg59oUo23bsXeVueBH3ZsYjU8EJdBn7CPvolmqSnTGF7mtgLhPzSfGMCWCFoS33XSDwVsOKbbZTZh1tZIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc0370e9b0so94504039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712225705; x=1712830505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLawccQXJOuaWRXg/eu21cQNmEWahrEV1cUIvm71EZA=;
        b=LczA27+JYf+186Af2bm8cSG8iHYA8CPXY48oHRZdLargCuCD2NkuwQgoGxE83q0KtV
         ReW54IhlC7Zf0dotSnWOFtnsuhvP0G4WJ7W1YOuST15nPhRw+A5B8TeL7IZL3jbOH31Q
         fZyAay5Ze53ch+yurPWiAhM07UAvQUtly2hyhGvJL4GvFnNQ7uaGtg5qSzsD4pRmoNOm
         eLTbwN+g97CPle6TEuQ7XHxBNwXJzuRr9NQpMS33Z2E/OzRAF3Q2+j5AKOB69KWuxjPd
         rEVxtjFIvMAf0PXZ9Wd95C8C8uQ9g1TW/eyFf4dT09Hn/fond6itPjmKoGh8SMuhSQfZ
         mllg==
X-Forwarded-Encrypted: i=1; AJvYcCV1MRfJa5+WGbaNcSq0utZdTLCDaSSMQgxph0gWzWj9FdrI+Vwox9crDMKy34kk2bto9/wmNQKovUEO7Hq1LJ2hR8+scZQpSScHdHT3
X-Gm-Message-State: AOJu0Yy4coEtp+VO7A045coeRfU+uMBUWiWh9TP3VacmsE1sA1IY3g+R
	PQmUSGsPl6hG3gVOWe1XRaQoeW33qajtyCLyIx5o0oxcUxWUUuBcpYxO75JfHqGgQEvyYpS9p11
	CCIENkPYH3PaOx3GDdytVSFFNP59KWwdl3wGOMCS1kiXHVkL/E280cnk=
X-Google-Smtp-Source: AGHT+IE3AtGLdZDSFn91DYUkzM6RrGoEMOaRLq3ZeDqWb/kSzHd8tTWV3ZWrN5xkjzuqmXaVJvPP1ta8DPtsI3i2hc3gxk0yk+2R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4106:b0:480:6ac8:a3fe with SMTP id
 ay6-20020a056638410600b004806ac8a3femr15603jab.2.1712225704910; Thu, 04 Apr
 2024 03:15:04 -0700 (PDT)
Date: Thu, 04 Apr 2024 03:15:04 -0700
In-Reply-To: <20240404000049.3868-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eab61b0615429cde@google.com>
Subject: Re: [syzbot] [net?] [nfc?] WARNING: locking bug in nci_close_device (2)
From: syzbot <syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in nci_send_cmd

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5484 at kernel/workqueue.c:2322 __queue_work+0xc6a/0xec0 kernel/workqueue.c:2321
Modules linked in:
CPU: 0 PID: 5484 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__queue_work+0xc6a/0xec0 kernel/workqueue.c:2321
Code: ff e8 1a e5 35 00 eb 21 e8 13 e5 35 00 eb 1a e8 0c e5 35 00 eb 13 e8 05 e5 35 00 90 0f 0b 90 e9 74 fd ff ff e8 f7 e4 35 00 90 <0f> 0b 90 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc9000511f180 EFLAGS: 00010093
RAX: ffffffff815f0f3d RBX: ffff888028141e00 RCX: ffff888028141e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff815f0413 R09: 1ffff1100e91481f
R10: dffffc0000000000 R11: ffffed100e914820 R12: dffffc0000000000
R13: ffff888029ccf1c0 R14: ffff888029ccf000 R15: 0000000000000008
FS:  00007f9177b796c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d7c2a04000 CR3: 000000002c63c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x14f/0x250 kernel/workqueue.c:2435
 queue_work include/linux/workqueue.h:605 [inline]
 nci_send_cmd+0x1f8/0x320 net/nfc/nci/core.c:1388
 nci_reset_req net/nfc/nci/core.c:167 [inline]
 __nci_request net/nfc/nci/core.c:108 [inline]
 nci_close_device+0x321/0x680 net/nfc/nci/core.c:588
 nci_dev_down+0x3b/0x50 net/nfc/nci/core.c:641
 nfc_dev_down+0x184/0x280 net/nfc/core.c:161
 nfc_genl_dev_down+0x84/0xd0 net/nfc/netlink.c:791
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f9176e7dde9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9177b790c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9176fabf80 RCX: 00007f9176e7dde9
RDX: 0000000000000000 RSI: 0000000020000780 RDI: 0000000000000005
RBP: 00007f9176eca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9176fabf80 R15: 00007ffe23b02ca8
 </TASK>


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=108db6d3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=e29c204bd2e3906fe69c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14bceed3180000


