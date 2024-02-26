Return-Path: <linux-kernel+bounces-81909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC25867BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EC71C2AB25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45A12F5A4;
	Mon, 26 Feb 2024 16:28:21 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79A12F39F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964900; cv=none; b=GUp5VdX1AlPtUaDH+1hKuayad7nfm9Xwq5OOj0gtLn3ijmRtOvw/I7b9LrxXfS2qN27n5qCRmR7Q7gMXAWtAj1eMuh0Y7ZTWrpRbLrXl/iPmjcf8WkEsr6HJZnY0NNonaQ7fr8xkR05GG6AHy3dFHtMY9lPFMvjG4axBfkCM/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964900; c=relaxed/simple;
	bh=PBvLSkJ0RlMNhxfai6oORd1LycycMbzbxT3QXcIUt7o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VfjJc84orVcyfritSH0zwdWXOV2+JjkGy/fw3k1SCyUFgOeoe5+Dx1NMeGUz6ZnxeTlQ0UH+bus6hFBJ0gImRYCXiNFB8rShI5mTC1a6lUjb7BYrCSG/4KITdhhQOVxRwG3EbWGVSYCB8iDI0TID8guVZr8YtOe/yewqeZewBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3657dff68d6so36507675ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708964898; x=1709569698;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GaFtmKz1ML1BUrUdmUz99JxEkS2YkyD21nhp0myYn3o=;
        b=TvTPgPJ+c6o0xw4mrO0/bLqwSyGWMWvhnDDBGrbOq8hWPANhA7L3oNJDf/nk/L+YMN
         dsQ0Dy6IR+urR/IES/DCZAOW6HAsd6h9YUk1atZKhSiAcm6U9Iv4DUnTKylOLJfaEM0e
         C+ogU+eshuMwsvoOyi5fI7B/kPpi8uaISLTjzG3UwCPpHEYg6+ChT2r8hnP4+c47vopD
         XmqeNHfEfYPojSB6mA3BNh8q2x/TGJiHxUgyatAURyxp2oZ+OafXQJLlQAacGEnhC/Xk
         5qkL+JmHpEbsyonhB5/qz8XINTjexLWy4BFvr/EyXeHXnBKwRPU4/f4EzEF43jRgXelh
         n8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Oqt+GfdvAEqECUgPSj/yVK/XVhOKMlUDkbjEYNSIrtL4MuD2CD/2qMUhlemF3lfMT1oL4B8mGxjp6nW+9TOZV3V7N9l4NZpmdv+5
X-Gm-Message-State: AOJu0YxdpY01ASP8P9Z2xKC06dwqv9fDeOhE507dPA49qA8qevacjNst
	j0U5Sgmj0YR3IG8sbxtZxR1ejFWvb0gofrn42lGAyltVpamS0cwtUjiSt5XlkPrjfJU3zHlUGdj
	lDWQUQIdF1EZGZr99aNDyMbFWmvuAJUcWc48PuQBp1gBI2uGZ3uS0JTA=
X-Google-Smtp-Source: AGHT+IFZIWQjWGnnOclLWZCh56V9VO9E83SaMAcJ/kzj5FpSjaFbfTUUAoWSlF22hiVJa3xkwUZTH1LDpP2yVrOgtvyLvivS9Dqw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4093:b0:474:78f7:20d7 with SMTP id
 m19-20020a056638409300b0047478f720d7mr247478jam.3.1708964898244; Mon, 26 Feb
 2024 08:28:18 -0800 (PST)
Date: Mon, 26 Feb 2024 08:28:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b18c2406124b652e@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in ieee80211_amsdu_to_8023s
From: syzbot <syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    39133352cbed Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178741c2180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b015d567058472
dashboard link: https://syzkaller.appspot.com/bug?extid=d050d437fe47d479d210
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72fbd705c5a5/disk-39133352.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4715a07937bd/vmlinux-39133352.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0340c0b3a7dc/bzImage-39133352.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee80211_amsdu_to_8023s+0x8c1/0x2d40 net/wireless/util.c:856
 ieee80211_amsdu_to_8023s+0x8c1/0x2d40 net/wireless/util.c:856
 __ieee80211_rx_h_amsdu+0x91a/0x13b0 net/mac80211/rx.c:3047
 ieee80211_rx_h_amsdu net/mac80211/rx.c:3133 [inline]
 ieee80211_rx_handlers+0x571a/0x10c40 net/mac80211/rx.c:4141
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:4185 [inline]
 ieee80211_prepare_and_rx_handle+0x5640/0x9690 net/mac80211/rx.c:5033
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5239 [inline]
 ieee80211_rx_list+0x642c/0x65d0 net/mac80211/rx.c:5410
 ieee80211_rx_napi+0x84/0x3e0 net/mac80211/rx.c:5433
 ieee80211_rx include/net/mac80211.h:4983 [inline]
 ieee80211_tasklet_handler+0x19f/0x330 net/mac80211/main.c:318
 tasklet_action_common+0x391/0xd30 kernel/softirq.c:780
 tasklet_action+0x26/0x30 kernel/softirq.c:805
 __do_softirq+0x1b7/0x7c5 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0x69/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x7c/0x90 arch/x86/kernel/apic/apic.c:1076
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:649
 update_stack_state+0x146/0x270
 unwind_next_frame+0x1a2/0x480 arch/x86/kernel/unwind_frame.c:315
 arch_stack_walk+0x1df/0x2c0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0xe0 kernel/stacktrace.c:122
 kmsan_save_stack_with_flags mm/kmsan/core.c:74 [inline]
 kmsan_internal_chain_origin+0x57/0xd0 mm/kmsan/core.c:183
 __msan_chain_origin+0xc1/0x140 mm/kmsan/instrumentation.c:251
 __skb_dst_copy include/net/dst.h:282 [inline]
 skb_dst_copy include/net/dst.h:290 [inline]
 __copy_skb_header+0x362/0x840 net/core/skbuff.c:1420
 __skb_clone+0x57/0x650 net/core/skbuff.c:1471
 skb_clone+0x3aa/0x540 net/core/skbuff.c:1961
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:300 [inline]
 __netlink_deliver_tap+0x60a/0xc90 net/netlink/af_netlink.c:325
 netlink_deliver_tap net/netlink/af_netlink.c:338 [inline]
 __netlink_sendskb net/netlink/af_netlink.c:1285 [inline]
 netlink_sendskb+0x232/0x260 net/netlink/af_netlink.c:1294
 netlink_unicast+0x70e/0x1250 net/netlink/af_netlink.c:1382
 nlmsg_unicast include/net/netlink.h:1144 [inline]
 netlink_ack+0x1954/0x1a70 net/netlink/af_netlink.c:2505
 netlink_rcv_skb+0x50a/0x650 net/netlink/af_netlink.c:2549
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0xf49/0x1250 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_compat_sys_socketcall net/compat.c:475 [inline]
 __se_compat_sys_socketcall+0xcea/0x1a10 net/compat.c:423
 __ia32_compat_sys_socketcall+0x6b/0xa0 net/compat.c:423
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb5/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Local variable hdr created at:
 ieee80211_amsdu_to_8023s+0x5b/0x2d40 net/wireless/util.c:832
 __ieee80211_rx_h_amsdu+0x91a/0x13b0 net/mac80211/rx.c:3047

CPU: 1 PID: 6024 Comm: syz-executor.4 Not tainted 6.8.0-rc5-syzkaller-00029-g39133352cbed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


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

