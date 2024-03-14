Return-Path: <linux-kernel+bounces-103351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507BD87BE6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAEB2844AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52206FE27;
	Thu, 14 Mar 2024 14:06:40 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D66F06E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425200; cv=none; b=EHW8fiYCC4PznSc3JfU9WsfcMRBGJkiSO4aASKBY/CEG3eEpJB4zaX9ZRkzQFWT0XSI1j9yzf+ZlcE3krpKPXydA0Pr+YXt2OYbYsz8Tw1yJFtNpT6j+V9RADCx0n1/viQ3nUPRaJzfBpUN4YABHxYveqXkiNDcFnmu/hrL6Ogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425200; c=relaxed/simple;
	bh=UZuOmmwRfASoQKWo4geglWknyDomMsq10mOT60vTCig=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hpZd5p8mcvmZwIZWpURPkRJH5ea0KwtbTmpwD33IyzyVF2TlFdEGbSENRdfdhT4JMv/D4BYFLwheR60n9FPb03mHiMWF9cLlO0+vnIajVu7dVFs5DEXGainC4A6qmOUq9EHFhGtwEF+WnWJjapx3jAX4+2+HOc26V506PvnWBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c86ecb5b37so78650039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425198; x=1711029998;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDAkd5UMH7mB7hZKOiwizlWb+VCYA9qCfshmpZCjJqg=;
        b=fBStDXd5TENVHj2txw8mlpBAevOBd67WGG5QMAbjwVCQ+EBb96eSXq1GKeOQ04Oi7o
         kugs2nb5XbDMTSuJ9/J8KJJrjsSMOATC/iaJAk0BcBEXCSOe0lZIMcqmAOdMiTeuDY/b
         cnW3uIjLW7S2PYW7SJlSQp/74OXdpTT27+hjr6sn90t0kcJIftTouTdNeh5GEcaS/zne
         +veCbXu4dJ/kZfOZv4P8nrtzhGIyncHU699kn3NMRcLMUkemjuMx3KVSkFnbe2YukmKq
         vuowHQMeUrntpTdS0X3KP43GdeBEJuazr67A2wNOPcQ1Iy3mc4azuqM/RUcQGzkMul7K
         vbBg==
X-Forwarded-Encrypted: i=1; AJvYcCVEmyfpXoA+Q8T87HiqNglJGd7TP0ztWwaog2OvYpyPdaee4XTvQIZ7rvPMm9IxEaoHk4cL/1YqUYEEMGiTnHwS0JvWUmGRuOBhyLYJ
X-Gm-Message-State: AOJu0Yy0V7BmuQQNcXuv2ht7e51n7IfiwZr7dmkRqRCKB2f2qdNweY2Y
	s1IvThSNQkOnvSFOSGbo0ggrLvypnY1to8xrQ6b5yIoD1P1xgeDmrrDpMRrt6MQNCNPgWS3luSZ
	FVMet3rGEqzlmE7o1YUOkN38ASIJD0VFDLHV5eFVlfrLvymOQiwYJZyw=
X-Google-Smtp-Source: AGHT+IGLA0FjQR/ndgg1v0X+OtUhZ9n3w3GxaR8Kv9rXL93hD/4DvfSaFpEYmAFv4NWOTZ5sApFex7YV5DP61A9PyvwX3ndzZSa2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2644:b0:474:f191:6e20 with SMTP id
 n4-20020a056638264400b00474f1916e20mr113041jat.5.1710425198066; Thu, 14 Mar
 2024 07:06:38 -0700 (PDT)
Date: Thu, 14 Mar 2024 07:06:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058907006139f66b4@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in dev_queue_xmit_nit / packet_setsockopt
From: syzbot <syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e6a901180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=943916f31352dd09
dashboard link: https://syzkaller.appspot.com/bug?extid=c669c1136495a2e7c31f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6e7a2dd336dc/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8cb00a02987d/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f325a1992de8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in dev_queue_xmit_nit / packet_setsockopt

write to 0xffff888107804542 of 1 bytes by task 22618 on cpu 0:
 packet_setsockopt+0xd83/0xfd0 net/packet/af_packet.c:4003
 do_sock_setsockopt net/socket.c:2311 [inline]
 __sys_setsockopt+0x1d8/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0x66/0x80 net/socket.c:2340
 do_syscall_64+0xd3/0x1d0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

read to 0xffff888107804542 of 1 bytes by task 27 on cpu 1:
 dev_queue_xmit_nit+0x82/0x620 net/core/dev.c:2248
 xmit_one net/core/dev.c:3527 [inline]
 dev_hard_start_xmit+0xcc/0x3f0 net/core/dev.c:3547
 __dev_queue_xmit+0xf24/0x1dd0 net/core/dev.c:4335
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 batadv_send_skb_packet+0x264/0x300 net/batman-adv/send.c:108
 batadv_send_broadcast_skb+0x24/0x30 net/batman-adv/send.c:127
 batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
 batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x3f0/0x4b0 net/batman-adv/bat_iv_ogm.c:1700
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0x465/0x990 kernel/workqueue.c:3335
 worker_thread+0x526/0x730 kernel/workqueue.c:3416
 kthread+0x1d1/0x210 kernel/kthread.c:388
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

value changed: 0x00 -> 0x01

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 27 Comm: kworker/u8:1 Tainted: G        W          6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
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

