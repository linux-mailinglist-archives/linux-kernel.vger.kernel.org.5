Return-Path: <linux-kernel+bounces-44761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF3E842708
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333851F27AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ABB7C0B1;
	Tue, 30 Jan 2024 14:38:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF47A734
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625505; cv=none; b=mmAzq3STgbMzOTyduduvldXS6qx45rFnjz/nGOy+ev4BUd9C4fsyXIeSb25HLZUhs18HSXSpAlKdmSE2Oe5TUDDW2Px/jT0xE+ixD7rsli99+PPo05iNGMna0S2/I1jcHQZ5yOygLQb64NnE6Zbbu2tLaXzstAjymV9peuI174E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625505; c=relaxed/simple;
	bh=ROo5bhnpYwp0pttggyRiem9w8sQ3Hui8BZ6JKXA8IGc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hXWz4RZCggPq8TpKWojzEY8RYeRBDabI239ZB0Zbcfu+at5Oq13qr7KC1m5U1o5CP6c8GC9/yd14yxCGSrzU4KjE9fdhjQ0/xlHSnDAwBpVA/C9qKX7GqRHchb++XjLG3J4GnviyPpj1NHI5S3xvya81CK++QbDspQaz0Af+dbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3637bdc8977so13164985ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706625502; x=1707230302;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2R7t2YoaqYAPsCKerlfRFKir1r7n3eDnxsYUSSi2FaE=;
        b=BPj1huRyHuki0XDclQU2OxZP30dTAkeffkEf4g5NUK0NCrPxq4c3aRVfmHIh86Mmlp
         Z6zUbeqw1knQusJh7suwUw3+uVjZsbYJF6Sh5k2kuBl1Lu7Yd2IHK3AmhUs6DGcWoxLM
         M8tNhwFjiCymZTIBi1p2KmSyQKmq6EIKA3wfgk27RBBW/STqBCmOr8HGQIxMD/gy/T4e
         Xi/vTkn0Fnm9M4ArcVnEbU3cHswHIO36bnPNtXlxKZv+858Pjrz8pCWBgvjw/2hCCYlJ
         rNFxyDfxXkMCb33vIiXJrU388kQIfPfyuj2ylSWChRAMVZLdxYgmvEDh8rqwz0TXkS8F
         rRjg==
X-Gm-Message-State: AOJu0YyjlOEvf5dQk4VSI4Qwy3+YxeTHW8ppFwqe9NPMHoLZaR8jg8+/
	9p7o5FXDkTKK1M5M4WPgfgf33k8eX+iWof//bK41i462iYNowEMOw5tg+7ePdSoBWDkxENhvyOY
	Gm9KQt6LlpPXkOud5p1cEns9UOwGLJW8ULIAEjENjGzGAEi3Km3I5uVw=
X-Google-Smtp-Source: AGHT+IGP9zFJt9ODdsJJST64s/ApoTT+dlu5lmgfnwM+imtr97ll3bRHIEGPkk+l0Y569vfoQkgmpdh19NV/+hHqEyYfm9fe3EYV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:361:9320:5b3d with SMTP id
 i1-20020a056e0212c100b0036193205b3dmr130264ilm.2.1706625502761; Tue, 30 Jan
 2024 06:38:22 -0800 (PST)
Date: Tue, 30 Jan 2024 06:38:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db5af406102ab6e8@google.com>
Subject: [syzbot] [net?] WARNING in tcp_disconnect (2)
From: syzbot <syzbot+0f423d4ae07bbb1359ac@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ff63cc2e9506 net: phy: mediatek-ge-soc: sync driver with M..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=133ee64be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
dashboard link: https://syzkaller.appspot.com/bug?extid=0f423d4ae07bbb1359ac
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09601b75d815/disk-ff63cc2e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5549b0aa031/vmlinux-ff63cc2e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1eb3b2eb752/bzImage-ff63cc2e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f423d4ae07bbb1359ac@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 26544 at net/ipv4/tcp.c:3089 tcp_disconnect+0x1857/0x1df0 net/ipv4/tcp.c:3089
Modules linked in:
CPU: 1 PID: 26544 Comm: syz-executor.2 Not tainted 6.8.0-rc1-syzkaller-00182-gff63cc2e9506 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:tcp_disconnect+0x1857/0x1df0 net/ipv4/tcp.c:3089
Code: 00 00 48 89 04 24 e9 24 e9 ff ff e8 13 fb 84 f8 be 07 00 00 00 bf 02 00 00 00 e8 74 f6 84 f8 e9 0b e9 ff ff e8 fa fa 84 f8 90 <0f> 0b 90 e9 21 fa ff ff e8 ec fa 84 f8 4d 8d af 76 08 00 00 4c 89
RSP: 0018:ffffc9000371f7c0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 000000000000d038 RCX: ffffc9000b6ed000
RDX: 0000000000040000 RSI: ffffffff890328c6 RDI: ffff888043389f18
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 000000000000d038 R11: 0000000000000002 R12: ffff88801c9a0600
R13: ffff88804338a0f6 R14: ffff888043389a38 R15: ffff888043389880
FS:  00007fee2d7bc6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f075e6d56c6 CR3: 000000003fa89000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mptcp_subflow_disconnect net/mptcp/protocol.c:2366 [inline]
 __mptcp_close_ssk+0xb26/0xfd0 net/mptcp/protocol.c:2420
 mptcp_destroy_common+0x168/0x650 net/mptcp/protocol.c:3274
 mptcp_disconnect+0x22c/0x810 net/mptcp/protocol.c:3145
 mptcp_sendmsg_fastopen net/mptcp/protocol.c:1745 [inline]
 mptcp_sendmsg+0x15ec/0x1b20 net/mptcp/protocol.c:1782
 inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:850
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fee2ca7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fee2d7bc0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fee2cbabf80 RCX: 00007fee2ca7cda9
RDX: 0000000024000084 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 00007fee2d7bc120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007fee2cbabf80 R15: 00007ffd6be957c8
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

