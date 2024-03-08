Return-Path: <linux-kernel+bounces-96900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB28762BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F8C1C214A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5FB55C3A;
	Fri,  8 Mar 2024 11:09:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958EB54746
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896148; cv=none; b=gC2AdmAdTcH7Y1ThAIXr43J3RNMFCJtXju2xguDqAR53ta+cX+9rw8Hus+Q/aJuwbR4XgjCOMkjqEjL0g4rwX711zwXGvpMbUxasJru8G9Lqyzk3kprzEVejRNRohVxRW+y/XAj3GpMDHvPHgh8I5zRIKJqJKYOg89LDrldv0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896148; c=relaxed/simple;
	bh=InVsPlGa/oC2mWvE7uuhw6EB0RATtgGeOqDFzW91fP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kz1JwvJIuR7O/YmApYrb4aeI2kEZKK67kjwoNhmwps3DEzwOIt5wZKYFLm3H5wyJdHeNBWU+uh2hHSJDmHLyHpxC6ObXp8uzicIVjrFZc0OtyVcmzCqH/isIf6WvMPTJa5i4yb3T7reIUrBqCwDKwDfxOCD58N8ixdnhqIeFrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c873aa5a95so202007539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896145; x=1710500945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEbuChj5eIZGQlWrDZYJUG+HqnhIBLeST7zZy/quj04=;
        b=bjwKYhTNWJO9gUfuBCVuiACI00LVCYPU20QXf/bcpsxKefep9tbN0AbE2AxAtMdfsh
         7m/QuteQGmysYD7DuAQCp++MnRqJjfaGNImRse9Zzx4OS3QpSQXQ74Itdx5rp1K9+s8Z
         0lbLk74Nyf4qBSuXHfBwejKRZofcLLUhxsscHII3AWOWn4S5NajVvDUdEadepPfUk1J0
         HONXG4skjzmuq4o5jLfbnyOKzT/ThqNG+ned4Zv7kdpRbfTOKkyKv8BZgSycr0sRpAkk
         /S7owhoq5Z0NvVHffkPhx6lbnj2wyd0CiiK97wBtGC/4agd6XaeegcEvNKks+BRiIkPP
         DsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC0B5hm935D/6DAMvXjko7PxH8LgZ31W6GeGXhN07KMwul7I0t3m35zhYup3nQHiTwKvMjmZPzOBjcYnd8Bhpe16ETbFYRiBqjs4jJ
X-Gm-Message-State: AOJu0YzISdJX4lfvYBXoEYY0fQEgNOY24y1VJdrLPBepdwFvcF5wTzgi
	kpnwPYe8eei3FqHDwuENLcFkbB721xtD318MNyHw9uY49gR/m6Ixuv2FvfpW2KOajZ5pIl7rnJr
	XgWwa3MribbvKhgOCaMHTVW6IKOVkqVdAQuhQ42al+BAcKzDUOW942Q0=
X-Google-Smtp-Source: AGHT+IEJycdb1fTd51Ph8XJ+JPS0/dBQIqO4aBtp/iCnQ3v2YnJfnKnzMsQnCsb7C0tpT3MkmpLazuU5zr0sRwULQOrADVKjb9vL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144e:b0:474:ebfd:1749 with SMTP id
 l14-20020a056638144e00b00474ebfd1749mr768384jad.0.1709896145793; Fri, 08 Mar
 2024 03:09:05 -0800 (PST)
Date: Fri, 08 Mar 2024 03:09:05 -0800
In-Reply-To: <20240308105058.1649-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f8a2c061324380f@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
From: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: null-ptr-deref Write in ipvlan_process_v4_outbound

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add include/linux/refcount.h:182 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc include/linux/refcount.h:239 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:256 [inline]
BUG: KASAN: null-ptr-deref in ipvlan_process_v4_outbound+0x3f6/0x7b0 drivers/net/ipvlan/ipvlan_core.c:444
Write of size 4 at addr 0000000000000274 by task syz-executor.0/5580

CPU: 0 PID: 5580 Comm: syz-executor.0 Not tainted 6.8.0-rc7-syzkaller-g3aaa8ce7a335-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_report+0xe6/0x540 mm/kasan/report.c:491
 kasan_report+0x142/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:182 [inline]
 __refcount_inc include/linux/refcount.h:239 [inline]
 refcount_inc include/linux/refcount.h:256 [inline]
 ipvlan_process_v4_outbound+0x3f6/0x7b0 drivers/net/ipvlan/ipvlan_core.c:444
 ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:544 [inline]
 ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:606 [inline]
 ipvlan_queue_xmit+0xaa2/0x11f0 drivers/net/ipvlan/ipvlan_core.c:672
 ipvlan_start_xmit+0x4a/0x150 drivers/net/ipvlan/ipvlan_main.c:222
 __netdev_start_xmit include/linux/netdevice.h:4986 [inline]
 netdev_start_xmit include/linux/netdevice.h:5000 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x242/0x770 net/core/dev.c:3563
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:342
 qdisc_restart net/sched/sch_generic.c:407 [inline]
 __qdisc_run+0xbed/0x2150 net/sched/sch_generic.c:415
 __dev_xmit_skb net/core/dev.c:3839 [inline]
 __dev_queue_xmit+0xfc6/0x3b10 net/core/dev.c:4317
 packet_snd net/packet/af_packet.c:3081 [inline]
 packet_sendmsg+0x47f4/0x6240 net/packet/af_packet.c:3113
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f5d1287dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5d136b40c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f5d129abf80 RCX: 00007f5d1287dda9
RDX: 0000000000005c13 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007f5d128ca47a R08: 0000000000000000 R09: 000000000000002f
R10: 0000000000000806 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5d129abf80 R15: 00007fffdca46778
 </TASK>
==================================================================


Tested on:

commit:         3aaa8ce7 Merge tag 'mm-hotfixes-stable-2024-03-07-16-1..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12503a49180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=165e1d0fff4d3c47
dashboard link: https://syzkaller.appspot.com/bug?extid=e5167d7144a62715044c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154b4001180000


