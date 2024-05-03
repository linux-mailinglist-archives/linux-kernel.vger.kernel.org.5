Return-Path: <linux-kernel+bounces-167617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C888BAC0C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3E0281B86
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6996D152E0D;
	Fri,  3 May 2024 12:03:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2E848A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737785; cv=none; b=Q31SutU8yJ223AsfMvElZq1sXME/nraNkhi09tojqH9WMGzbkHJ3LIgAbWZZQeSt09EH6mbUhwP1z9potQw7i62+aJa2zf+jF6epY4yN+y21wgn4V3ZYWBlk6FSL4zAD6NXPfrOAsx6+VSV7STCce7ZeYxUbuRYjnPXq2EvlUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737785; c=relaxed/simple;
	bh=Tfvgm57rWXZCvAHQ95gWX30+ZUQFE+tqBAMhScTVX3w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rIoq8wrNv0SVz105YggAdClMoMhq6zdEyBNJrXyHTzf+tE0xMR5eaJ2369q5aMYukuCQ+Q37I9GY/nS0PaEpeWFnahNgNends5GZBLucepG/RIHyFS4OXvOtGLDzGFclFy6I/7mmxFJ6N/ydSQwykPGdjZZcOcxFL7qP4vmfbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dec81b8506so650530539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 05:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714737783; x=1715342583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvhlXVMsZVy7ILT0OQqr82SnKRy1BHg9zJFIo9acu94=;
        b=V7V8Q2wXr7syEbc7nhHrX3UPuQTSRzp1J0O1RyKN7tui5IzaN45xnfvZliy3J1Htkn
         GpIhKfVX0+01XgWi9Sogq9l7Ps2GjSucx+WT8iNp1v96vwCdOMlGD9XeRAc+iPGSPh+L
         78Z95Z/ys0FwFwEBH5qCoEcsGBmNBq6NEx4isT0uSC0l1y7rK5mkKCCF0tkyu9jHiek0
         2u1R1MFs01Uqesb1TiezYLWKLBB5OIO5xkW8DKD9pOMzyt/sxs2GHEHpc1tn93OgarzH
         o/829lbftMRQxZoS9/+gK+K+iP31dOTFEPc5rjtZv0HWDxDBtbmwCNU8/3FpXG3yL/dH
         IftA==
X-Gm-Message-State: AOJu0Yxv05JdolpZYFhGvNkEo+7w8NVbyt9KSpGPP4XJ/KHm5sLvmilr
	rJX274jvbswhda3BDbI14uuyYf+ETZ7rnK9VqxhSwC5eTHo63HOdPqkrSHWWRkPxHGpubRtZASw
	1Qj/YODVDd2CCStryg+WhufVCY8rM7xD20AtUwC0m/iLSXIAnMW3YU/Y=
X-Google-Smtp-Source: AGHT+IEtTVd6O4AIGhQyZgRT0GRSHJD9Y5CeDMPPLQ7yiKBLaNMFSNFBPqcBur1fJS4nTGl8YMbrnRgOYLZVhyQPzg+977qwj9+h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f8b:b0:7de:e175:fd2d with SMTP id
 fb11-20020a0566023f8b00b007dee175fd2dmr106870iob.3.1714737783003; Fri, 03 May
 2024 05:03:03 -0700 (PDT)
Date: Fri, 03 May 2024 05:03:02 -0700
In-Reply-To: <20240503091844.1161175-1-luyun@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000706ce506178b80a2@google.com>
Subject: Re: [syzbot] [kasan?] [mm?] INFO: rcu detected stall in __run_timer_base
From: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luyun@kylinos.cn, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in ktime_mono_to_any

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in kernel/time/timekeeping.c:927:20
index 3 is out of range for type 'ktime_t *[3]' (aka 'long long *[3]')
CPU: 0 PID: 5514 Comm: syz-executor.0 Not tainted 6.9.0-rc6-syzkaller-00131-gf03359bca01b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 ktime_mono_to_any+0xf7/0x100 kernel/time/timekeeping.c:927
 taprio_get_offset net/sched/sch_taprio.c:178 [inline]
 taprio_get_start_time+0xf6/0x2a0 net/sched/sch_taprio.c:1232
 taprio_change+0x30c5/0x42d0 net/sched/sch_taprio.c:1963
 taprio_init+0x9da/0xc80 net/sched/sch_taprio.c:2135
 qdisc_create+0x9d6/0x1190 net/sched/sch_api.c:1355
 tc_modify_qdisc+0xa26/0x1e40 net/sched/sch_api.c:1776
 rtnetlink_rcv_msg+0x89d/0x10d0 net/core/rtnetlink.c:6595
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2559
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fca4dc7de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fca4e9720c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fca4ddabf80 RCX: 00007fca4dc7de69
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 00007fca4dcca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fca4ddabf80 R15: 00007fffc66d5928
 </TASK>
---[ end trace ]---


Tested on:

commit:         f03359bc Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17aef62f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38cdad974684e704
dashboard link: https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1665ecc0980000


