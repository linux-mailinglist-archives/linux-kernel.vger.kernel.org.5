Return-Path: <linux-kernel+bounces-62388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DB851F88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7311F2292D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E704CDEB;
	Mon, 12 Feb 2024 21:26:19 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024854C63F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773178; cv=none; b=HwU77Khf9N3JtMah85/6Nt5V5GcxYmJ8nb5DrLejnUB6xqMX5AFm/wfyjV+kgFQyZKqJSRHuwQJNPffrjkKcEdtZt0v0pYOIBIzMCGimDEeVX41QI5JKIeabiDHpck9eoJbjhrxst4V0FM9e91rbJQ3j/pSDeeF54ad2eSID39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773178; c=relaxed/simple;
	bh=gdBrqYwMAIQdRKLaqdduNKTUrHZMgfta/ChCSoiv/JI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OLm2P3MmObrY58PZKTDrPjFVD7ly81WqE+sH3bKD9QPkMKGrLCej0utCF2W6/u+DU+gVmMbwkirMmtu0lIh6qTod+SYHoNMME2+6Rjn5JftTC5M9NQuembJbqkx90zbT5O0gUlopJ7il9mWol8mIfaEYZbwOdSgPoi1tKBvMpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363dfc1a546so37156805ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773176; x=1708377976;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wagcq9COHb24z/xuskXRn8d6kbGmFHER+wSRaPPVz+w=;
        b=oXa1vhyzC1Fdb7rfGoVHV90OtjL4zcbbENvQAAlMGcAyyipjWY2xkD7wSozGfyrMnh
         Uq8xR9ifXGepbZfnLofJlolpsgX5sTIJZUzLQnO8UQxlF1KXxU/5ErDlWDT8IqsER/bx
         zVjhPI4/WUablc4afXD0Mh92+hDDvIgLxZpMi6McRkGUOciH6WaOMi15hBrNEMp77bXK
         epunI6w67o18fA6W9T6PIDHjPm+N4h8EVYKTGp6Hff6yOaQeKx6o3LZVFXVCQNndAayX
         itui6SGC7c9o0INrwOCaG2WDqjkLar4kuhC5a9Rt22r1jVhfGA/mlghArWEub+22bcTF
         xu9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8dge+MmghNstciDfLjrulzY7uTTON6DEG+0OeF89pwfYbYeVBWNdLZRtH0fmd7cBC2qaESQv7unJby4/kqmVYZqq7gAb0acFwYDm+
X-Gm-Message-State: AOJu0YwGIeIPiaJczi+dsh9kptPoSqFTOBq8bk2uLhLgzb2zisS3fm/p
	kj7j4nTwhjcavBkygqhAEO6pd2/T7iNgNO6YEYSknQMlIzcfJCpv+bGkvz4uS5QYSb9gTKANRTY
	oZ3B3sNHOMs7+oZ4jBCjmMyNNTZ/W9N35GVvn0976e06u+FFMk4FtWo8=
X-Google-Smtp-Source: AGHT+IEQ6Yr7NUwr1aO5sIMrfITNumwjXzV8MO5Y/AwbsS6q1SAgcgqkhs5f5Cb/5wsoXRVEZPgBYlQuasVbw4LiOOqFFgIk1CeV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4904:b0:471:fe5:c48b with SMTP id
 cx4-20020a056638490400b004710fe5c48bmr88097jab.3.1707773176154; Mon, 12 Feb
 2024 13:26:16 -0800 (PST)
Date: Mon, 12 Feb 2024 13:26:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085930e061135ed45@google.com>
Subject: [syzbot] [wireguard?] KCSAN: data-race in wg_packet_receive /
 wg_packet_receive (7)
From: syzbot <syzbot+fd07f3da9110f5f18b4f@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5b6244cf87c Merge tag 'block-6.8-2024-02-10' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126f51e0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cd0dc1b46a5bc5c
dashboard link: https://syzkaller.appspot.com/bug?extid=fd07f3da9110f5f18b4f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1a21353ecf6/disk-a5b6244c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/675fe8a43c32/vmlinux-a5b6244c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1848dc711f3f/bzImage-a5b6244c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd07f3da9110f5f18b4f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in wg_packet_receive / wg_packet_receive

read to 0xffff88812bad5c08 of 4 bytes by interrupt on cpu 0:
 wg_cpumask_next_online drivers/net/wireguard/queueing.h:127 [inline]
 wg_queue_enqueue_per_device_and_peer drivers/net/wireguard/queueing.h:173 [inline]
 wg_packet_consume_data drivers/net/wireguard/receive.c:526 [inline]
 wg_packet_receive+0xc51/0x12c0 drivers/net/wireguard/receive.c:576
 wg_receive+0x4e/0x70 drivers/net/wireguard/socket.c:326
 udp_queue_rcv_one_skb+0xad0/0xb60 net/ipv4/udp.c:2113
 udp_queue_rcv_skb+0x20a/0x220 net/ipv4/udp.c:2191
 udp_unicast_rcv_skb+0x1c2/0x1f0 net/ipv4/udp.c:2351
 __udp4_lib_rcv+0xb93/0x1110 net/ipv4/udp.c:2427
 udp_rcv+0x4f/0x60 net/ipv4/udp.c:2609
 ip_protocol_deliver_rcu+0x356/0x6d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x13c/0x1b0 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0xec/0x1c0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:461 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0x18a/0x260 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core net/core/dev.c:5534 [inline]
 __netif_receive_skb+0x90/0x1b0 net/core/dev.c:5648
 process_backlog+0x21f/0x380 net/core/dev.c:5976
 __napi_poll+0x60/0x3c0 net/core/dev.c:6576
 napi_poll net/core/dev.c:6645 [inline]
 net_rx_action+0x32b/0x750 net/core/dev.c:6778
 __do_softirq+0xc4/0x27b kernel/softirq.c:553
 do_softirq+0x5e/0x90 kernel/softirq.c:454
 __local_bh_enable_ip+0x66/0x70 kernel/softirq.c:381
 __raw_read_unlock_bh include/linux/rwlock_api_smp.h:257 [inline]
 _raw_read_unlock_bh+0x1b/0x20 kernel/locking/spinlock.c:284
 wg_socket_send_skb_to_peer+0x109/0x130 drivers/net/wireguard/socket.c:184
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x127/0x360 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x5b8/0xa40 kernel/workqueue.c:2706
 worker_thread+0x525/0x730 kernel/workqueue.c:2787
 kthread+0x1d7/0x210 kernel/kthread.c:388
 ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

write to 0xffff88812bad5c08 of 4 bytes by interrupt on cpu 1:
 wg_cpumask_next_online drivers/net/wireguard/queueing.h:130 [inline]
 wg_queue_enqueue_per_device_and_peer drivers/net/wireguard/queueing.h:173 [inline]
 wg_packet_consume_data drivers/net/wireguard/receive.c:526 [inline]
 wg_packet_receive+0xd3a/0x12c0 drivers/net/wireguard/receive.c:576
 wg_receive+0x4e/0x70 drivers/net/wireguard/socket.c:326
 udpv6_queue_rcv_one_skb+0xb37/0xbc0 net/ipv6/udp.c:716
 udpv6_queue_rcv_skb+0x20f/0x230 net/ipv6/udp.c:778
 udp6_unicast_rcv_skb+0x195/0x1b0 net/ipv6/udp.c:921
 __udp6_lib_rcv+0xa24/0xc80 net/ipv6/udp.c:1010
 udpv6_rcv+0x4f/0x60 net/ipv6/udp.c:1124
 ip6_protocol_deliver_rcu+0x92f/0xf30 net/ipv6/ip6_input.c:438
 ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip6_input+0xbd/0x1b0 net/ipv6/ip6_input.c:492
 dst_input include/net/dst.h:461 [inline]
 ip6_rcv_finish+0x1d9/0x2d0 net/ipv6/ip6_input.c:79
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ipv6_rcv+0x74/0x150 net/ipv6/ip6_input.c:310
 __netif_receive_skb_one_core net/core/dev.c:5534 [inline]
 __netif_receive_skb+0x90/0x1b0 net/core/dev.c:5648
 process_backlog+0x21f/0x380 net/core/dev.c:5976
 __napi_poll+0x60/0x3c0 net/core/dev.c:6576
 napi_poll net/core/dev.c:6645 [inline]
 net_rx_action+0x32b/0x750 net/core/dev.c:6778
 __do_softirq+0xc4/0x27b kernel/softirq.c:553
 do_softirq+0x5e/0x90 kernel/softirq.c:454
 __local_bh_enable_ip+0x66/0x70 kernel/softirq.c:381
 __raw_read_unlock_bh include/linux/rwlock_api_smp.h:257 [inline]
 _raw_read_unlock_bh+0x1b/0x20 kernel/locking/spinlock.c:284
 wg_socket_send_skb_to_peer+0x109/0x130 drivers/net/wireguard/socket.c:184
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x127/0x360 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x5b8/0xa40 kernel/workqueue.c:2706
 worker_thread+0x525/0x730 kernel/workqueue.c:2787
 kthread+0x1d7/0x210 kernel/kthread.c:388
 ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 5475 Comm: kworker/1:6 Not tainted 6.8.0-rc3-syzkaller-00293-ga5b6244cf87c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
==================================================================


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

