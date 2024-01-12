Return-Path: <linux-kernel+bounces-24548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D55282BE2E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924321F21D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61225EE87;
	Fri, 12 Jan 2024 10:11:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D65EE67
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bec4b24a34so564473539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705054286; x=1705659086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgGYhOChlMIrhGxl8DNFGpHAHl0ZZQh2kQ8m5tGIY28=;
        b=Cwm16rHtDjHmfj3pTCHMwKX/fchJLRI3faBCLp4ijpl/DFoVuOHF3a0R9euSCXAlOU
         9pRStn3zfPMH4wqBT8OCOjsIfH044prRAEr46VJUCFdrjZMTVxQOu8kFKyD/KFuWtx35
         hTT2vNoCPO+LXiOpeoX5eCMbjDtnCh+EU9kAM25kEFoNzj2hspZGAHzwandCbMcPGa1E
         gZUW1IFjqtag9a4SSAW/8rzpXbQOIxUQ01E3T/BuROkdgyiXjYRS7oVGDM9b1u4yhMBw
         mR7g1IVhU3tXd/lD6s5/o3higT76HlmpT83gfSKxA1omD6uHVzVtKf6Jp0qgs0LIzKfc
         4q3A==
X-Gm-Message-State: AOJu0YzXZzoI2KdolLm/6l8H0DUpPcamM0hmY19wk8/MxqUgS5YIKH2t
	OecyZ/3f6A/ScgOMSVQj0fbn1Cw+PVpyQHWJY/WX7FcoqIuZ
X-Google-Smtp-Source: AGHT+IFyxUt57Zi5R0ygl3UdwU6il4gc+6aHiFDOPeKehuUQWByq4QRWcy9U2zhAzeT0vJbW0/aBGSfO7x5NQl9otdQ0gydb9eQ5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cb:b0:35f:a338:44ae with SMTP id
 11-20020a056e0220cb00b0035fa33844aemr86964ilq.3.1705054286306; Fri, 12 Jan
 2024 02:11:26 -0800 (PST)
Date: Fri, 12 Jan 2024 02:11:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ee656060ebce37a@google.com>
Subject: [syzbot] [wireguard?] KCSAN: data-race in wg_packet_send_keepalive /
 wg_packet_send_staged_packets (6)
From: syzbot <syzbot+6d5c91ea71454cf3e972@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab27740f7665 Merge tag 'linux_kselftest-next-6.8-rc1' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1526c96de80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d534f78e1db6532
dashboard link: https://syzkaller.appspot.com/bug?extid=6d5c91ea71454cf3e972
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a20a48bc4578/disk-ab27740f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/118b632bca22/vmlinux-ab27740f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b053e27eb223/bzImage-ab27740f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d5c91ea71454cf3e972@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in wg_packet_send_keepalive / wg_packet_send_staged_packets

write to 0xffff88814cd91280 of 8 bytes by task 3194 on cpu 0:
 __skb_queue_head_init include/linux/skbuff.h:2162 [inline]
 skb_queue_splice_init include/linux/skbuff.h:2248 [inline]
 wg_packet_send_staged_packets+0xe5/0xad0 drivers/net/wireguard/send.c:351
 wg_xmit+0x5b8/0x660 drivers/net/wireguard/device.c:218
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3564
 __dev_queue_xmit+0xeff/0x1d80 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 neigh_connected_output+0x231/0x2a0 net/core/neighbour.c:1592
 neigh_output include/net/neighbour.h:542 [inline]
 ip6_finish_output2+0xa66/0xce0 net/ipv6/ip6_output.c:137
 ip6_finish_output+0x1a5/0x490 net/ipv6/ip6_output.c:222
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0xeb/0x220 net/ipv6/ip6_output.c:243
 dst_output include/net/dst.h:451 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ndisc_send_skb+0x4a2/0x670 net/ipv6/ndisc.c:509
 ndisc_send_rs+0x3ab/0x3e0 net/ipv6/ndisc.c:719
 addrconf_dad_completed+0x640/0x8e0 net/ipv6/addrconf.c:4295
 addrconf_dad_work+0x891/0xbc0
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2706
 worker_thread+0x525/0x730 kernel/workqueue.c:2787
 kthread+0x1d7/0x210 kernel/kthread.c:388
 ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

read to 0xffff88814cd91280 of 8 bytes by task 3202 on cpu 1:
 skb_queue_empty include/linux/skbuff.h:1798 [inline]
 wg_packet_send_keepalive+0x20/0x100 drivers/net/wireguard/send.c:225
 wg_receive_handshake_packet drivers/net/wireguard/receive.c:186 [inline]
 wg_packet_handshake_receive_worker+0x445/0x5e0 drivers/net/wireguard/receive.c:213
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2706
 worker_thread+0x525/0x730 kernel/workqueue.c:2787
 kthread+0x1d7/0x210 kernel/kthread.c:388
 ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

value changed: 0xffff888148fef200 -> 0xffff88814cd91280

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 3202 Comm: kworker/1:8 Not tainted 6.7.0-syzkaller-01727-gab27740f7665 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: wg-kex-wg2 wg_packet_handshake_receive_worker
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

