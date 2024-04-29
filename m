Return-Path: <linux-kernel+bounces-161990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482B8B5445
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D2C1F2185C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D40B2575A;
	Mon, 29 Apr 2024 09:29:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B86A17C60
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382964; cv=none; b=Mq4QaToaA6Sa0meLbR7N4z6R5OwGCh3yHWhQ6e7ebUIJh+apzEj6055NTTlTCfzSrkf5l/P8EyS1xWB+coApkFISZNPON197D/PRDSpc+/TGcBrE2zmfNrNfHB0fkITJRTEApvh+fs0a+88ok/5M1bLhsL2AM5+YrpblQmOT+Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382964; c=relaxed/simple;
	bh=q45+hjjmLxml1aJNtwd5XFVUIciX6r6bmdXOp91wvSo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y/C1FR6GDl9jWDAlLIS1NvodIk+3RR4I+0bXJLCC66QKIHbmmDP98bFVK3SmW6Krs97XDMrSqmY7M9Y5EM0/VA2TiWd3b24xXlRs19qjnGIW+W6CrSzDER2zsTib+r4C0QtKbBU+/9c4Yvz86H4m1g3jLjp4bgE27+8JKyAPLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da41da873bso551979239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 02:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714382961; x=1714987761;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJ+5Yb2Ln58wiDSoBQwENTmi0SaJH0WHD9oB1lDL3Cs=;
        b=gkEFI8hA6L7XBni8Uspkk4gBRvIIzJ0ODW6d2fh4LoBl/20rCmsOu9Dcr9kcLtg1mQ
         aXblxHw3OiI/V+8347Yxjkb3D65iC+9FJEGHez4rhfZMTh/RHJLuwAl+G7ghNI8Du+j7
         leyWns8jf8APoR9rMU7b7wEVK2zJ2PFpLrTcSN5AxPvs5+QZy/La6wIMw5PAMVaItgND
         x2twtst5SHAU9C66sAWef9bRhuuIosHOwP5uC9gY0PYUafEkCeOVU1aK6GBNTAnYc6SG
         umbycFg259eqhNNmhsSzXjui59U8LdPh+P51IwCIzgUns7eZsRvEkbUT9t7w6LJg4Hfd
         xnNA==
X-Forwarded-Encrypted: i=1; AJvYcCVIr0xdBSg/CYGcS8X29FkTOKaDtJvtoyATVd/RWZkcBK56/8OxiQinigZSzWI6s1FPAykeyvz3fGmNAnImrKvh6q7TdRBfpd7SJ/AO
X-Gm-Message-State: AOJu0Yz0ZOIf4+i8vOY7VOCo6UqttcjpUa6jWhjz7+IPs4TiGHpSSrxs
	uEJCf3tOJoUs9gy0YkeARGMDQnQeVcy/siZcwuld3RurrvRfXOAJ/cnx28lRpeL3INeX5x80GAO
	djzXuzJ2k5e6xyToKVytnUCILejJnO+hsgkvEnHpyGsYg97Ag6XAD7FU=
X-Google-Smtp-Source: AGHT+IGOSnK61WCYmFa2d18gGFKctUlhzvIRl1iR74ZajCvsYB5LqaVvQwzRqZSp1JoOOne0FxaTR9iW9re5ONjKvGOV33tYi3hj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12eb:b0:36b:3c17:28d0 with SMTP id
 l11-20020a056e0212eb00b0036b3c1728d0mr238702iln.6.1714382961663; Mon, 29 Apr
 2024 02:29:21 -0700 (PDT)
Date: Mon, 29 Apr 2024 02:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070759a061738e388@google.com>
Subject: [syzbot] [wireless?] WARNING in _ieee80211_change_chanctx
From: syzbot <syzbot+bc0f5b92cc7091f45fb6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12aea028980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=545d4b3e07d6ccbc
dashboard link: https://syzkaller.appspot.com/bug?extid=bc0f5b92cc7091f45fb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc2737f2e766/disk-e88c4cfc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c53581da70d1/vmlinux-e88c4cfc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c90cde48e98f/bzImage-e88c4cfc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc0f5b92cc7091f45fb6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3146 at net/mac80211/chan.c:501 _ieee80211_change_chanctx+0x363/0x11c0 net/mac80211/chan.c:501
Modules linked in:
CPU: 0 PID: 3146 Comm: syz-executor.2 Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:_ieee80211_change_chanctx+0x363/0x11c0 net/mac80211/chan.c:501
Code: 0f 8e 1a 0c 00 00 8b 7b 08 48 c7 c6 00 e3 4f 8c 49 89 fc e8 5f d5 33 f7 41 83 fc 05 76 0f 41 83 fc 0d 74 09 e8 0e da 33 f7 90 <0f> 0b 90 e8 05 da 33 f7 48 8b 74 24 10 ba 01 00 00 00 48 8b 3c 24
RSP: 0018:ffffc90003376e20 EFLAGS: 00010287
RAX: 0000000000001a65 RBX: ffffc90003376fd0 RCX: ffffc90004012000
RDX: 0000000000040000 RSI: ffffffff8a59e842 RDI: 0000000000000005
RBP: ffff88807b6f80b6 R08: 0000000000000005 R09: 000000000000000d
R10: 0000000000000006 R11: 0000000000000000 R12: 0000000000000006
R13: 0000000000000000 R14: ffff88805de532f8 R15: ffff88807b6f8000
FS:  00007f75cdf286c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d823000 CR3: 0000000040486000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000003
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_change_chanctx net/mac80211/chan.c:547 [inline]
 ieee80211_recalc_chanctx_chantype+0x69c/0x870 net/mac80211/chan.c:773
 ieee80211_link_change_chanreq+0x7aa/0xd70 net/mac80211/chan.c:1920
 ieee80211_set_ap_chanwidth+0x181/0x320 net/mac80211/cfg.c:4343
 rdev_set_ap_chanwidth net/wireless/rdev-ops.h:1136 [inline]
 __nl80211_set_channel+0x4cb/0x990 net/wireless/nl80211.c:3418
 nl80211_set_wiphy+0xcc8/0x2d00 net/wireless/nl80211.c:3575
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1113
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2559
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f75cd27dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f75cdf280c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f75cd3abf80 RCX: 00007f75cd27dea9
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f75cd2ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f75cd3abf80 R15: 00007ffd05dbb2b8
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

