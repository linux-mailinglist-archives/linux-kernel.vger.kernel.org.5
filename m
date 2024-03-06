Return-Path: <linux-kernel+bounces-93819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E5E873528
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792D81F2121D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A666D77F2A;
	Wed,  6 Mar 2024 10:57:21 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5F77A05
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722641; cv=none; b=pYT6fol+gQ7NMM5XxStD7h46wn1G3XMKoAn15QedMgbG82XzGiCVlZCr1sMqGDCUy8NkTrnRnI8GmgenMrsUxNCA+AfoHNW3ifjpd4fBi2SX2/nQzBJ1N1wy9q0pfxSiFAyP6LDynL0moOzR+a/reKyxr8n5P4PbVdu/ByJciq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722641; c=relaxed/simple;
	bh=XsLw6ackKx33O4QozjLGkHXzho6GlTehmojGjYysM3A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i+YxQXk9FJ54CXOC/7rv4F8eRC95koKeSrUY2AI69PZSKP7iTAiKzA8iwgsjuBX3dzn4NrEhEVBcYcLkBn7K1ku1MqfpxztQwKhw2kO2X41/Oeehxa/06blE2lgQ757gONAdoPdJ9NUW3x3cY4iIJHGA37HZ5SpP6cp3jcwf1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8440b33b6so96892039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 02:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722638; x=1710327438;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCr0TsSg56p14urXWsXr6XqDfXQJ+JrQT+/U6eWZWoU=;
        b=ouOqZHSsEsaMSEnLgdtdzuvtecS3WX5riUrMmG7m8oExlGhr/G+FYG0GzW+mVIV4kF
         TQvwiK/eVdaBsS30qKhD6LV0kulgJy9VhEsJ89hauwzPUbaJ0ZSDuFVwENaJgTU0sxkv
         lQ0HFi/JJ/RS4IQL16kW08s3XPR7JpBYi8qUb47p26HB05aUSDVbnASfEmkwqVQ4qmAf
         4/8xFvwmWI7hWu3OqbD/3kGu7ysXagXF/1ok8f2y83jJOO19iwi8ZKmmO8Av0GrgxbHY
         vhZvGO5WfF1rwp67KewGL4p7wYNU1fY+Y24K20H+lDFis0q1mU7o4k4NKZRr/DdrHbsv
         mvDg==
X-Forwarded-Encrypted: i=1; AJvYcCW1zFFfycu7uCqtPXdifvwAjfSmSaQA8T99H+Ij3zopwKb8eqQHWMKuYNtbB1B0Ph+KprABXkku7ezuwJUnRHaelVX3ZRpN5n6oMMim
X-Gm-Message-State: AOJu0YxXI/+HLfKJIxdZ6vaC8MDCi7m7wBdsFWh1UFKscIVbXwqVn35l
	zN2Wv6JCT/Hq5R8C03vVIXvbEK0JBo67IQl4nEHjJ7zeY0pHR2SmLMVlJjoMzYLPClbunq5Vn4o
	ooUgN4fcrp/bToXuoqqGeug3LqRcTgAMyKSWcnqV0GAC7OnY6bVpgWWY=
X-Google-Smtp-Source: AGHT+IGujKW2GhxdCNQ+Pa5KCV/cUet5XpNsDkba1TrtXtNMS5JvOpNbY2oFFSHru0lhN+xwADASaEzKIqfHM3WdDRjqcBtD0+mh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16ca:b0:474:b9df:7315 with SMTP id
 g10-20020a05663816ca00b00474b9df7315mr747827jat.2.1709722638714; Wed, 06 Mar
 2024 02:57:18 -0800 (PST)
Date: Wed, 06 Mar 2024 02:57:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b9c410612fbd266@google.com>
Subject: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
From: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, fw@strlen.de, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    805d849d7c3c Merge tag 'acpi-6.8-rc7' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e106ac180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=e5167d7144a62715044c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d490ca180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1025fa6a180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/17c4652fa589/disk-805d849d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7fc3b5760ca4/vmlinux-805d849d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d88bfccc316a/bzImage-805d849d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sk_fullsock include/net/sock.h:2823 [inline]
BUG: KASAN: slab-use-after-free in ip_skb_dst_mtu+0x830/0x9b0 include/net/ip.h:499
Read of size 1 at addr ffff88802dc5a012 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc6-syzkaller-00037-g805d849d7c3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x167/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x180 mm/kasan/report.c:601
 sk_fullsock include/net/sock.h:2823 [inline]
 ip_skb_dst_mtu+0x830/0x9b0 include/net/ip.h:499
 __ip_finish_output+0x12b/0x400 net/ipv4/ip_output.c:306
 ipvlan_process_v4_outbound+0x3ef/0x700 drivers/net/ipvlan/ipvlan_core.c:442
 ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:540 [inline]
 ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
 ipvlan_queue_xmit+0xaa2/0x11f0 drivers/net/ipvlan/ipvlan_core.c:668
 ipvlan_start_xmit+0x4a/0x150 drivers/net/ipvlan/ipvlan_main.c:222
 __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
 netdev_start_xmit include/linux/netdevice.h:5003 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x242/0x770 net/core/dev.c:3563
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:342
 qdisc_restart net/sched/sch_generic.c:407 [inline]
 __qdisc_run+0xbed/0x2150 net/sched/sch_generic.c:415
 qdisc_run+0xda/0x270 include/net/pkt_sched.h:125
 net_tx_action+0x877/0xa30 net/core/dev.c:5197
 __do_softirq+0x2bb/0x942 kernel/softirq.c:553


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

