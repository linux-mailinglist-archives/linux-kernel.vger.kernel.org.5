Return-Path: <linux-kernel+bounces-118351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3BE88B93C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68FC2E7A29
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359912A170;
	Tue, 26 Mar 2024 04:05:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C7129A71
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711425929; cv=none; b=ko3XwzONHS9JrKA7cm303tlCTwk7zlSyLjocRbFQMhLXClepJlK80KU0rfPEycPQzWbt32hSd9xzXiekFj85mNuJdSg29JxoAhZcleavXZ2V04Nm1GRAvJkspBhQ6ts2l/M2Gda7HW6smf/iW/9YRwHE9BZ1c8xl6N+Q9ilzpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711425929; c=relaxed/simple;
	bh=RWMooWm2hTg+urHegWoX075dxGCiiXod91LeHWx3vAQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z6Wpl0kg5s4607veIn8GO3p9RfUIAm9upOEPfH4A2ziPXqVzVkowiwBJTmmSUkRhGfnk3i6JYkQ0Suz+8+WzbzNnkp8Fh1PAma31+2STJmCMCL8utPhtoeeQwPKsuUroNpGCzSTahX4bhpSBBsBoEe3tJwv0nDY2udzIqGcS1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf1d5d35bso557587639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711425926; x=1712030726;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7qjNzAOBCybfoRNbZxcOy1j71w0Id/vFEg3S7E5tBY=;
        b=pjT5uoYqSLClWzK3GvJpFVa74YOlZNWYfiRnL5HRc/TBocAUx7HUZ3pYuvf6x9Qc2A
         t0VrBh66c8Q8Fup5TFmSh/4/JuL4vw2NmB3mtLjoSISbp4GAoIlxeXwV8AsfRo1wRp5d
         d9yJEnCSLj38nexu+CIWzpIyB7GUVx7hx9NnPNSuRunkLFEhFQAtMi61dcUJQ2zTou3f
         IKbKQtvtxYKlrHxtflY6WZ2nlaHD0wXCcTE1w5bZSSvDKtpQVf54SUgReJhGllwKFx7c
         ompThufzoKjvBjbi0rLP0dUWXlxUqeNXHSHpkQUvqSqWbYUtmvcCv5D3Ps0N4WEpJPsf
         5Eag==
X-Forwarded-Encrypted: i=1; AJvYcCXadcsd5lqIwBPLMffokRG4ZCszbngsvkfKbJ+kkzg6OQcXdvpDp40z6xz27/JnttHY6oCstt9gw0fG0zy9LX6sEPWtUEgneADQAd7w
X-Gm-Message-State: AOJu0YzyX0OwoZVmm9y09Y3DJcltOe2HKAKk6aS6czKqLHJTA32oFMaQ
	Ydk9Yjx+Op5spF6pkzODUpC6HQgLYvxxV5koItD8r4uge1EnOSo62OkcgGVUfzQgmo5oBpGMSgW
	cSDPLuwXRbSSeT8sZymfj5FeMkoEwli70mnx8xMEZXdBiu148EmrQ/zs=
X-Google-Smtp-Source: AGHT+IFts4zA2Z3bUiY9aEPSNt9BH1OB0xu+cuRCJO43hRtNgnWV2ARVS0eAAhcU5FM6y8Ev6kn3aTZtfo2Eu16PJa6cX5oo/Uec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:367:472c:e7d7 with SMTP id
 g8-20020a92cda8000000b00367472ce7d7mr484039ild.0.1711425926722; Mon, 25 Mar
 2024 21:05:26 -0700 (PDT)
Date: Mon, 25 Mar 2024 21:05:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c06870614886611@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in ieee80211_rx_handlers (2)
From: syzbot <syzbot+75af45a00cf13243ba39@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f55aa85a874 Merge tag 'fbdev-for-6.9-rc1' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1536e231180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
dashboard link: https://syzkaller.appspot.com/bug?extid=75af45a00cf13243ba39
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156ebbb9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12605691180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7189321e94a5/disk-4f55aa85.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2cca9c27d4fe/vmlinux-4f55aa85.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b707938817e2/bzImage-4f55aa85.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75af45a00cf13243ba39@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee80211_rx_h_action net/mac80211/rx.c:3783 [inline]
BUG: KMSAN: uninit-value in ieee80211_rx_handlers+0xbeb7/0x10ec0 net/mac80211/rx.c:4188
 ieee80211_rx_h_action net/mac80211/rx.c:3783 [inline]
 ieee80211_rx_handlers+0xbeb7/0x10ec0 net/mac80211/rx.c:4188
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:4223 [inline]
 ieee80211_prepare_and_rx_handle+0x5424/0x99f0 net/mac80211/rx.c:5071
 ieee80211_rx_for_interface+0x88d/0x990 net/mac80211/rx.c:5156
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5312 [inline]
 ieee80211_rx_list+0x5498/0x6690 net/mac80211/rx.c:5447
 ieee80211_rx_napi+0x84/0x3f0 net/mac80211/rx.c:5470
 ieee80211_rx include/net/mac80211.h:5083 [inline]
 ieee80211_tasklet_handler+0x19f/0x330 net/mac80211/main.c:438
 tasklet_action_common+0x395/0xd50 kernel/softirq.c:781
 tasklet_action+0x2d/0x40 kernel/softirq.c:807
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
 do_softirq+0x9a/0x100 kernel/softirq.c:455
 __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __ieee80211_tx_skb_tid_band+0x28a/0x580 net/mac80211/tx.c:6099
 ieee80211_tx_skb_tid+0x203/0x2a0 net/mac80211/tx.c:6126
 ieee80211_mgmt_tx+0x1c87/0x2210 net/mac80211/offchannel.c:979
 rdev_mgmt_tx net/wireless/rdev-ops.h:758 [inline]
 cfg80211_mlme_mgmt_tx+0xbdd/0x1b90 net/wireless/mlme.c:937
 nl80211_tx_mgmt+0xfb0/0x1570 net/wireless/nl80211.c:12650
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2559
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0xf4c/0x1260 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x10df/0x11f0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 skb_copy+0x116/0xa10 net/core/skbuff.c:2128
 mac80211_hwsim_tx_frame_no_nl+0x18e1/0x2130 drivers/net/wireless/virtual/mac80211_hwsim.c:1854
 mac80211_hwsim_tx+0x1c3b/0x2d90 drivers/net/wireless/virtual/mac80211_hwsim.c:2072
 drv_tx net/mac80211/driver-ops.h:37 [inline]
 ieee80211_tx_frags+0x5ea/0xd90 net/mac80211/tx.c:1731
 __ieee80211_tx+0x470/0x640 net/mac80211/tx.c:1785
 ieee80211_tx+0x532/0x570 net/mac80211/tx.c:1965
 ieee80211_xmit+0x54a/0x5b0 net/mac80211/tx.c:2057
 __ieee80211_tx_skb_tid_band+0x27d/0x580 net/mac80211/tx.c:6098
 ieee80211_tx_skb_tid+0x203/0x2a0 net/mac80211/tx.c:6126
 ieee80211_mgmt_tx+0x1c87/0x2210 net/mac80211/offchannel.c:979
 rdev_mgmt_tx net/wireless/rdev-ops.h:758 [inline]
 cfg80211_mlme_mgmt_tx+0xbdd/0x1b90 net/wireless/mlme.c:937
 nl80211_tx_mgmt+0xfb0/0x1570 net/wireless/nl80211.c:12650
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2559
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0xf4c/0x1260 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x10df/0x11f0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5018 Comm: syz-executor547 Not tainted 6.8.0-syzkaller-13006-g4f55aa85a874 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

