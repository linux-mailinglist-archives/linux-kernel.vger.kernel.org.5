Return-Path: <linux-kernel+bounces-80606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A03866A48
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4111C21994
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A41BDD8;
	Mon, 26 Feb 2024 06:49:19 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C91BDCF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930158; cv=none; b=jcwDUEbX4w7C3JmYLNg4anlW4zpc6dD2BC6zk5I3RK2sYzhI2q4CHkzuZnQVZH/Ebi84QC2YfepmnxfWC9FgvzLVsB/pnzc0MHvr1YfEkE0R/hwCyNn4CBfQFzsIAISEsUOBsGxRnkv560lsglNkl8CgZjD2OxLOA3YQ6kGXYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930158; c=relaxed/simple;
	bh=skqVvvgaswYH/WEaOwX9w475uwS/p84Gka6Zk3K+GN8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dcUU1Oy/fbSpK50lswwBoYlalGxHAfaw2xYoN4D56sy9epoafvTF9cIL0azuSdvV9mo/yj3DPdALYuyPtZa9mc9A6CSdNnuxZC+LKg3ra6T7WIvwdrz1ztBTkZ/XSxKsAeDPmEzi0OLanOYwjNbfCYhW9mrThH3WHIA25LV20Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c7c9831579so62610139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708930155; x=1709534955;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiwReltw5l/9lgFXelRMQJoGyzLPKT+OcNcrGA3d1ls=;
        b=NoTck+txzju28vqMFIsLJRX9D/GEmv/a8Ak2l3SohnnqccQF+UU1rcRVSK4WmuIWj5
         Eq0WIyFCmxnNJO82wFHCTx+vAG9kNgXsQxyymgKx9gS/J/r/KucGPMVaQZElDxmXZbOJ
         jJf/iSzw9jOBe+If7NCF+5PJb0FPoVNteUHgAAsag5oOeAJy581YsU4xI/vs08HBfw8V
         B0R2Z6TKgKkIZXS5ON8tekRxJvXE/5U3P9KUFDhGEHxx2xGq+m4kg8RaE/GZWGftuKLY
         yPV8UlsXZB1WWOZKQd5g2U1joDdbGPQI3ub56TaV7U9OibwKDF+XWVvgqyNxRQOhDRf9
         ZC2A==
X-Forwarded-Encrypted: i=1; AJvYcCXElTBRmiUQHUcz6UpKqKRPhWP1e8w8ik+ZBz3gUKpLEm2N2/vQ1edZyWLyoD+PjLmM2ReGqBGohAdE7YCn0s6M5NR1vxj8cbfkD4yQ
X-Gm-Message-State: AOJu0YykDZu926t0DZnSYOtsE2I3rs2aegAiEvO0bsxnmMiWaR9iVqxg
	ORnAr3ROw933+En/JIUK5lzdbf41rut9JxbVGfLPasOEbqPO03jbX8UWP36sHBRyLuXqvIWE+eT
	YfW1GzK3qDcGRPfGP5kQI77z7s82iVArV7U2ClQ1oBdgrNjQfFMt19M8=
X-Google-Smtp-Source: AGHT+IHtNvAlMcbT0OKeWgo2OEqBQ8gNaZFbz+QtW2/TAnVfx6wWYxq/kZKND5fNwECz+V/kxSF+e0PVg89UHGOn93RL+a8vRnvl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:b0:363:b9d6:1261 with SMTP id
 i8-20020a056e0212c800b00363b9d61261mr348596ilm.0.1708930155728; Sun, 25 Feb
 2024 22:49:15 -0800 (PST)
Date: Sun, 25 Feb 2024 22:49:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0d7ac0612434e59@google.com>
Subject: [syzbot] [wireless?] WARNING in drv_unassign_vif_chanctx
From: syzbot <syzbot+1c8a495af056338d5c19@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a770cdc4382 tun: Fix xdp_rxq_info's queue_index when deta..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14aec3aa180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=1c8a495af056338d5c19
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54ceb0944449/disk-2a770cdc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69b79e7b7a86/vmlinux-2a770cdc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dedbc599c2f7/bzImage-2a770cdc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c8a495af056338d5c19@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 14618 at net/mac80211/driver-ops.c:343 drv_unassign_vif_chanctx+0x477/0x6c0 net/mac80211/driver-ops.c:343
Modules linked in:
CPU: 1 PID: 14618 Comm: syz-executor.1 Not tainted 6.8.0-rc5-syzkaller-00129-g2a770cdc4382 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:drv_unassign_vif_chanctx+0x477/0x6c0 net/mac80211/driver-ops.c:343
Code: e9 48 b8 00 00 00 00 00 fc ff df 0f b6 04 03 84 c0 0f 85 08 01 00 00 41 8b 16 48 c7 c7 40 27 bb 8c 48 89 ee e8 8a 18 83 f6 90 <0f> 0b 90 90 e9 db fc ff ff 48 c7 c1 0c 9a 85 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc90018017130 EFLAGS: 00010246
RAX: c575d6a35704e800 RBX: 1ffff11005a0b29a RCX: 0000000000040000
RDX: ffffc9000b9f4000 RSI: 000000000001c717 RDI: 000000000001c718
RBP: ffff88802d058128 R08: ffffffff81577ab2 R09: 1ffff110172a51a2
R10: dffffc0000000000 R11: ffffed10172a51a3 R12: ffff88802d05a740
R13: ffff88802d058c80 R14: ffff88802d0594d0 R15: ffff88802e178e20
FS:  00007f013e91c6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c01c04b000 CR3: 000000008cbc6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_assign_link_chanctx+0x16d/0x8b0 net/mac80211/chan.c:878
 __ieee80211_link_release_channel+0x306/0x460 net/mac80211/chan.c:1801
 ieee80211_teardown_sdata net/mac80211/iface.c:810 [inline]
 ieee80211_if_change_type+0x222/0xad0 net/mac80211/iface.c:1897
 ieee80211_change_iface+0xd2/0x4f0 net/mac80211/cfg.c:219
 rdev_change_virtual_intf net/wireless/rdev-ops.h:74 [inline]
 cfg80211_change_iface+0x75e/0xed0 net/wireless/util.c:1209
 nl80211_set_interface+0x592/0x810 net/wireless/nl80211.c:4229
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0xad6/0xe50 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f013dc7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f013e91c0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f013ddac050 RCX: 00007f013dc7dda9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000008
RBP: 00007f013dcca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f013ddac050 R15: 00007ffc6b796908
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

