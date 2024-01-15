Return-Path: <linux-kernel+bounces-26606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E482E414
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D545F1F230CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD281B7ED;
	Mon, 15 Jan 2024 23:47:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FAE1B7E4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36134783014so5958295ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705362423; x=1705967223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zA8BcSJfX9ZFbSQlqDRwumhFC1+FjHRg2tk39RzpGQc=;
        b=MtO0b6WFoxjPI+YhIMQF/Y28LrdQYEiMefk8FOWDfUFR0QJ+7roTBfOc/ZC5/Rh9Gs
         91L8YyUdphz1uBgSlaIDivKU5FOzD0TGf98Ds/QbQ/aHotuUBEBL4KJgA5wb1tUdM6Df
         Ul3HSqQxgFWtEtaNYbBoNWXoLuxz4KktKpNTDEMt3XkEOtrl+eqCxPVM4YUUCUOhAtDP
         tjK7YS0BD5JCqwQtKKPmtJqQE99xBp523vreNd4upiBe1a9+QA/0w1LN/bY3ctzXNeE8
         pDbW2AzpST57yrz2NdH1CmdFeprrB/9obytJ0xqi2AwidMWCvLYAt4o0pLPvZpXxd57u
         Zblg==
X-Gm-Message-State: AOJu0YxIOo/F2x2Gi9dUfV6gtSiEdP5QKZ3nGjkqoQAZKGKVPfdRCrjO
	/DeY64yTlkYzcBuASCSvgodLTScl0rKfNSv7/9gpZuRQPysg
X-Google-Smtp-Source: AGHT+IFpRs2SOIokon/qqFdXPaspVCfc1gTfa4Brj4p9eq1VBNUMLipNKyHk1j7c/wv6Sjl1QRQHRLbiZsHWgzz+nq3fCUCAjEDv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:360:97cb:111b with SMTP id
 h28-20020a056e021d9c00b0036097cb111bmr964260ila.4.1705362423613; Mon, 15 Jan
 2024 15:47:03 -0800 (PST)
Date: Mon, 15 Jan 2024 15:47:03 -0800
In-Reply-To: <tencent_BDD63DCB3762971636DA4B4474F177116609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000790f45060f04a10f@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in
 getname_kernel (2)
From: syzbot <syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in btrfs_dev_replace_by_ioctl

BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
================================================================================
UBSAN: array-index-out-of-bounds in fs/btrfs/dev-replace.c:746:2
index 4087 is out of range for type '__u8[1025]' (aka 'unsigned char[1025]')
CPU: 1 PID: 5479 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00200-g3bd7d7488169-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 btrfs_dev_replace_by_ioctl+0x1c1/0x2000 fs/btrfs/dev-replace.c:746
 btrfs_ioctl_dev_replace+0x2c9/0x390 fs/btrfs/ioctl.c:3299
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0c8fe7cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0c90c160c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0c8ff9bf80 RCX: 00007f0c8fe7cba9
RDX: 0000000020000540 RSI: 00000000ca289435 RDI: 0000000000000005
RBP: 00007f0c8fec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0c8ff9bf80 R15: 00007fff3e1d0738
 </TASK>
================================================================================


Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12e95ba3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117c0debe80000


