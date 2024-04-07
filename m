Return-Path: <linux-kernel+bounces-134348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112889B089
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF641F215BF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81821CFAF;
	Sun,  7 Apr 2024 11:08:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053CE171C2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712488085; cv=none; b=iycGONLgKE4Bncu3B6Mz+s54Sy4nsz8+89tM3EiATKkNPqAORp5PQxA71sOzAZfp+zV+elB+8PXKNygLRTJHuLm19WW5xssS7HKmSCyU6XGcSwvhz0fMz88l6bczuvPoEwyvzOa6O/beNGR3FpF3Jr7zAWi2ng644Xt6kYGwhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712488085; c=relaxed/simple;
	bh=3p2A3mNtH5u0Qctglf7yCnGeYkAfugz/79M9/m8zzY4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DQcqsDIHFG1LgdWyVqvF1nMgKtT9uOFPfqWw4G5sweNiXtHh35tsGOBdFCbPYVi0udASc45zfpdw/ijS63jz03+TPVk0EXK6e3He2SmUKHuIntp7mve0eQ1K21fHEWIJJ2vZON8qPie9Sz9yVTvRQUxBGL+x2JBf6/J1ziSEgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5df223ae1so49119239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 04:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712488083; x=1713092883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rA4drQMgDKCfOP0rdP6fL+k233HpNLzBEAfubWbzETI=;
        b=dSLCQ5fjOLVeUsMMPRNFxVH6PSZzBLPtE04gs0hLiF55CcN5qr0fbZzRzKY+ORPdPs
         v5bFrMf5T42c+2l1thU3OziFReK2gMboYs4GO8LJl6IILLTnHd79A1VWS8uwkFlwFm1X
         JIohLLZ2PEgulDrvPArmF/62c6av4VndAE+qhPYoA8gQy6d/LXLIq7PGMihF3BODDtvH
         R6VqHrsbLACuqG9Bz3qxNJAnSWitI8jEs1Xg8eBRJv0oJqnPMrWEQk4FIpsT47pWWOSt
         pSRZq5wZDql6xRF9ENZtWFtsDlvGBBKzKdsEpymOM5CDNDrDduE3lyuPkpbx3pOuNJTM
         cAZg==
X-Forwarded-Encrypted: i=1; AJvYcCWKfh05UIPksN56DT5XcHAPo9RrI/Uv7wwNQuAN8LvBOwznGCJcoLMM+Bkpu4y0XinDzK+BEXrvhMHN1zFlLGXCvcb7/xDrPqg/Z63A
X-Gm-Message-State: AOJu0YyCT3Ur6qL3M/ZTEA+YU608qDw9f9+oPePEbIS+XXSOHW0CSTco
	+NeHP0VRQ+a8xCK6BuY24LzUiFeXNSEzrv5PrE/ZdwTxCWjlth0CNQZ9XKl6tGYYxnVVMM0Wpee
	JCBztXz9L9SE+7iZlVfw/9hvDvev/+5X7qyX3gYUdq5Gv5x9bB/834Ho=
X-Google-Smtp-Source: AGHT+IGTGaCAwjbXmB7meL6B+f132kwK04l2L0PoPaNHadUBwAXhNPciiSPfjEESD3RkHmWb8J/zRsFNT01v+X/mC1nDJA5S4txC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1612:b0:482:801b:7216 with SMTP id
 x18-20020a056638161200b00482801b7216mr269225jas.4.1712488083183; Sun, 07 Apr
 2024 04:08:03 -0700 (PDT)
Date: Sun, 07 Apr 2024 04:08:03 -0700
In-Reply-To: <20240407103306.1364-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e16c0f06157fb3e9@google.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
From: syzbot <syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in cleanup_net

     __do_sys_unshare kernel/fork.c:3393 [inline]
     __se_sys_unshare kernel/fork.c:3391 [inline]
     __x64_sys_unshare+0x38/0x40 kernel/fork.c:3391
     do_syscall_64+0xfd/0x240
     entry_SYSCALL_64_after_hwframe+0x6d/0x75
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1057 at lib/ref_tracker.c:179 ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
Modules linked in:
CPU: 1 PID: 1057 Comm: kworker/u8:7 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
Code: 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 08 e7 9f 06 eb 1a e8 f1 d1 b5 fc 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 f0 e6 9f 06 90 <0f> 0b 90 48 83 c3 44 48 89 df be 04 00 00 00 e8 5b 23 19 fd 48 89
RSP: 0018:ffffc90003c579e0 EFLAGS: 00010246
RAX: 75214a9c4e67f100 RBX: ffff88807a2b01d8 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8baac1e0 RDI: 0000000000000001
RBP: ffffc90003c57ab0 R08: ffffffff92ce55ef R09: 1ffffffff259cabd
R10: dffffc0000000000 R11: fffffbfff259cabe R12: 1ffff1100fc58348
R13: dead000000000100 R14: ffff88807a2b0228 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f71ec36bfe4 CR3: 000000002dd64000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 net_free net/core/net_namespace.c:462 [inline]
 cleanup_net+0xbf3/0xcc0 net/core/net_namespace.c:658
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa02/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16ad098d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=9ada62e1dc03fdc41982
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165c53d3180000


