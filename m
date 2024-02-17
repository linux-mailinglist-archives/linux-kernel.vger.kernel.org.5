Return-Path: <linux-kernel+bounces-69850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ABD858F74
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C1128265B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605A7A727;
	Sat, 17 Feb 2024 12:55:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7169DE7
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174505; cv=none; b=CwaAHmG8iA74TGd210QZla9VxqEapHkopBa73S+ei1yIoA6J99cNDOKXe867Z50FsdSlC3CdDPUI813K80K2tYpp3BfRXGzijz7bTmwU7R7noQyWbNbirwRFqOhsV+0Tfq2/QjbuqOl1WlfyMPbp5GSTxIZTqemm1FgXD6gFWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174505; c=relaxed/simple;
	bh=CYtMto8XYycvZCbk3XnCFVxTQmf1n0ubNpWj/EYG6h8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jtyLtSmMSSFYoklzZoxrR+idXhPEznJJAhPNEyohCePOHGgSTaN1DBhXQhT7Rz+di/UjUOWHS3t/xcckCHP9aZAkRBAIzvxIUyso5ZV9FFTRHkYKvsnnC7CNdI8jZEEso4/xiKCILS8ZL0mYR49d/G8Z5m37x5Nn6COV8PXi1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363ca646a1dso25913365ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708174502; x=1708779302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkAaRPRurr4hEp1GccFhPyoVGIjWvN5phI/7QkRky9g=;
        b=AAdlaQF487ODjKCa7G3k9CyFTb8QEbw32E/9kNiIWueP7NKHiS6TiwtbEC1wikc7zg
         GcdGZqkjnRaP6ZWvU4aGcYEgY9iCZ2zJkMKUFWPgy0MIoH06GujD33sSaexlV9sPxY75
         ZmxguAqt3MbSCdPfWLKsV4npVh1w/p7mJic3bbAgm9HbJKQlBqi5ct0ZONIbdUzSaEc1
         9Gvuh9j10zNbOuR+zGNcUSY2z1R5J0uTHCCb1nEolWKCr935JlwRL/REubI3ztgeGqOc
         VMx2qoum6aqHHdeuFR6o/avSLpcQWa9OXzsqHAh/J35+Zwn77Weh+/OoJO9Pp/hgSPeX
         cEPA==
X-Forwarded-Encrypted: i=1; AJvYcCVq8GQTrvK4RSbJ//jRidrBgLkJIZHTlHq9YipkN4wg/F9NkELEfSeXtDG22ddXyFK4KLXNTbOpx7htj/zarIq7DjVqvL7Srm4ZSEOQ
X-Gm-Message-State: AOJu0YzkHPQq0rpO/8JeNcAZBhuUFAqdaDxAhwhHbCtVco3uS6NYczHZ
	qAZ8GMUdcFWuetNByO0uBdMiOpdlKYowB4wY68TbCet/13TGtX/TsmztYtKexRw3l/dZX3peh2U
	HfjaASDzxTmJXd521ixGtMudKIB20a/MqJXDcBMeu9P7ceKQ7o9HTyaQ=
X-Google-Smtp-Source: AGHT+IFiqjFj+zPCUG2T48b/neQ8dLcnSdT56/gx3HSf5R7Lj52xO3g16VUKkT6Jeotsnyaqh82O5szRY6WelL83+ZM0nIICCXD5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8f:0:b0:361:a872:157a with SMTP id
 r15-20020a92cd8f000000b00361a872157amr623901ilb.6.1708174502670; Sat, 17 Feb
 2024 04:55:02 -0800 (PST)
Date: Sat, 17 Feb 2024 04:55:02 -0800
In-Reply-To: <20240217123828.GA31625@breakpoint.cc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000723bee0611935ee4@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (6)
From: syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __nf_unregister_net_hook

------------[ cut here ]------------
hook not found, pf 2 num 1
WARNING: CPU: 1 PID: 5828 at net/netfilter/core.c:517 __nf_unregister_net_hook+0x1de/0x670 net/netfilter/core.c:517
Modules linked in:
CPU: 1 PID: 5828 Comm: syz-executor.3 Not tainted 6.8.0-rc3-syzkaller-00211-g84443741faab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:__nf_unregister_net_hook+0x1de/0x670 net/netfilter/core.c:517
Code: 14 02 4c 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7a 04 00 00 8b 53 1c 48 c7 c7 a0 ab ab 8b 8b 74 24 04 e8 b2 64 c6 f8 <0f> 0b e9 ec 00 00 00 e8 f6 f9 00 f9 48 89 e8 48 c1 e0 04 49 8d 7c
RSP: 0018:ffffc90003c272b0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88807dd4da00 RCX: ffffffff814d93f9
RDX: ffff88802c4c9dc0 RSI: ffffffff814d9406 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8880699cad90
R13: ffff8880648246f8 R14: ffff888064824660 R15: ffff88807dd4da1c
FS:  00007f51415d46c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f51415b3d58 CR3: 000000007fa81000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nf_unregister_net_hook+0xd5/0x110 net/netfilter/core.c:539
 __nf_tables_unregister_hook net/netfilter/nf_tables_api.c:362 [inline]
 __nf_tables_unregister_hook+0x1a0/0x220 net/netfilter/nf_tables_api.c:341
 nf_tables_unregister_hook net/netfilter/nf_tables_api.c:369 [inline]
 nf_tables_commit+0x3cdb/0x5ae0 net/netfilter/nf_tables_api.c:10174
 nfnetlink_rcv_batch+0xf3b/0x2510 net/netfilter/nfnetlink.c:569
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:639 [inline]
 nfnetlink_rcv+0x3bf/0x430 net/netfilter/nfnetlink.c:657
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x78/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f514087cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f51415d40c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f514099c050 RCX: 00007f514087cae9
RDX: 0000000000000000 RSI: 000000002000c2c0 RDI: 0000000000000004
RBP: 00007f51408c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f514099c050 R15: 00007ffd31c3ba48
 </TASK>


Tested on:

commit:         84443741 netfilter: nf_tables: fix bidirectional offlo..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=11a08ae8180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52f6b87f61a6b59c
dashboard link: https://syzkaller.appspot.com/bug?extid=de4025c006ec68ac56fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

