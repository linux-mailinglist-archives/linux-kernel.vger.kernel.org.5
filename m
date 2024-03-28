Return-Path: <linux-kernel+bounces-122810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3E88FDA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0C9B23B37
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E97EF14;
	Thu, 28 Mar 2024 11:00:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644A7E787
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623634; cv=none; b=V7yJR+Z2ksic+0+kWDZIvjZ6sisKXu2tazHG4uNb6VkjVaH8Xj4U5tH4vLklgiEQGys6JM4p+FQ9BxukVlDatU1/8LJvWFSLLmh4Hl5WACR8qQqeW47uczcvZQuGf85zjMKpzro8M/TPVBf2s24H4V4GuobwpcJq+ubkWLF2P4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623634; c=relaxed/simple;
	bh=6GfWPzo6l340DFtgiPm5TV5H/KlnykZiWrKpTZhUk7U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZLuX2qJ1g6KsUcxOIsi4UoZIiXduswCsfftNdRVHq1p6qiy033H9fYZJqXqkYCi30w/hBZY7N4IsWUko/lyqu3MD9nT8FPhn6ScpyVwGBPpa3T2ahtnDXH1c8I3kfbs2fL7HqClAY38bZFSxU7w8rwZlMb3dbzy1WLqMCV5k448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbef888187so68788539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711623632; x=1712228432;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2I+QMisqSNoVgUodtBJSFknn06IcL/Yj0qUYMvpcWQ=;
        b=KQboHcKN8LrJ61K0lN1aAQC+yDy95+rOvoBQVnHC2Gt0OfYU9R1D5v42LYNxKKAs0+
         tedBpOv7Ydf0QUek7rpYgN/J5p2JpRZTxtxu1oDTvSRVNHYiarwV/5f0Ejw9w192Ncwo
         tGU+/mnCobzixMCkMA5n33yX1BIlCilsn95mUw2x69io9ZUY2O1vpFgSdwA4FgC4VmYM
         4WIdgN8HNQTVNlj0DT0mySX07UH2V1VPApYNuL8Fa5zr0cjQbb5bj4gPK8kdhbcnMQXL
         RyXD9YX6hvUtxqW1xxpOfAqeygQ6HuPOSzyHN6iUT/Z0cL05R+yelb+jgmogrsuLJuYS
         vliA==
X-Forwarded-Encrypted: i=1; AJvYcCXJF9KJuzpS/oEBb90mJwnN4qofnq4u89ej7jDJhd/nqqz6VU4BoqORKg/PtmCvgoeCIpmOry2HeRXDnrrBhvgO0UtF2uUf7fWoEAad
X-Gm-Message-State: AOJu0YweTiUYaUgjm1iSFjLWAsDg/Q19BLlTTdV5av6vvzCJcThmmDCn
	wSZfrCCqbCCSwaelbF7dJTYwo5dysMwMULavOLb31Py1thFJWPo4bZh13TCL77fsoJqA1RxLjTl
	1vkIxuq13A+9hS2r2+iZONjTMuzLAqnY9JPcLuXX7F0LytLY9aA5VgO4=
X-Google-Smtp-Source: AGHT+IEDNj+ZPIyEQSPC/J1VTlpSuN4jBtj9FlHnK3MSE6N1Q2F+RRj18TBNhbBnE++ZH+ODIvHer+ZF169eLMvn84FTTXsFIFOw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640f:b0:7cc:2522:f5fd with SMTP id
 gn15-20020a056602640f00b007cc2522f5fdmr103845iob.1.1711623630417; Thu, 28 Mar
 2024 04:00:30 -0700 (PDT)
Date: Thu, 28 Mar 2024 04:00:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b02500614b66e31@google.com>
Subject: [syzbot] [wireless?] WARNING in kcov_remote_start (3)
From: syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a6bd6c933339 Add linux-next specific files for 20240328
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c85eb1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0058bda1436e073
dashboard link: https://syzkaller.appspot.com/bug?extid=0438378d6f157baae1a2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c1618ff7d25/disk-a6bd6c93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/875519f620fe/vmlinux-a6bd6c93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad92b057fb96/bzImage-a6bd6c93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 2400 at kernel/kcov.c:860 kcov_remote_start+0x549/0x7e0 kernel/kcov.c:860
Modules linked in:
CPU: 1 PID: 2400 Comm: kworker/u8:7 Not tainted 6.9.0-rc1-next-20240328-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:kcov_remote_start+0x549/0x7e0 kernel/kcov.c:860
Code: 4c 89 ff be 03 00 00 00 e8 14 99 16 03 e9 fd fa ff ff e8 8a 26 ea 09 41 f7 c6 00 02 00 00 0f 84 eb fa ff ff e9 7f fc ff ff 90 <0f> 0b 90 e8 8f 43 ea 09 89 c0 48 c7 c7 c8 d4 02 00 48 03 3c c5 d0
RSP: 0018:ffffc90009b17aa8 EFLAGS: 00010002
RAX: 0000000080000000 RBX: ffff888029649e00 RCX: 0000000000000002
RDX: dffffc0000000000 RSI: ffffffff8bcae740 RDI: ffffffff8c1f77c0
RBP: 0000000000000000 R08: ffffffff92f3358f R09: 1ffffffff25e66b1
R10: dffffc0000000000 R11: fffffbfff25e66b2 R12: ffffffff8195747e
R13: ffff88807c8cd748 R14: 0000000000000246 R15: ffff8880b952d4c8
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc66d258d58 CR3: 00000000222ca000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kcov_remote_start_common include/linux/kcov.h:48 [inline]
 ieee80211_iface_work+0x21f/0xf10 net/mac80211/iface.c:1654
 cfg80211_wiphy_work+0x221/0x260 net/wireless/core.c:437
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

