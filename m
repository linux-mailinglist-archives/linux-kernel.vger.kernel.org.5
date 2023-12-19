Return-Path: <linux-kernel+bounces-6120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4CF8194D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A24B22EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6DD3FB0C;
	Tue, 19 Dec 2023 23:58:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044EE3EA95
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7f94a4e22so87774439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703030304; x=1703635104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RPUwxcaMGcNgknXbLzKNZenAsKBOcBCmI4hbQ536sU=;
        b=TEKOc88ihjTDuEPB5kPx5adQgmK20yRWbFoR4CwnWmL8kXM5aJSsR9VGvOU/l4Zgjd
         Bo+mH096qgpT4AUtutoYm582TSMFBCJDE3VFuCiLqEvLj6UoRtLFnLlUairgPq/5gcd2
         ZpuVWQjUJ9DoDA3CaQrsA7A5TyydjTw8PrXBTGN9xBspuCVSnMU4VJECyHwwCl62OM5O
         Mae7RQNslb+AAepheiKNL0klYzHfSwy/SIT0pAJm8bIec0UWQyH0AFTBdS2OCmk2AWnr
         LwgsQdLU/wAJJJA36nUhfw7RuMGoyr/eBcmbOyaDmU1gvb5grjKEx5Mb2vz+lr9I/+De
         zYkA==
X-Gm-Message-State: AOJu0Yzft1nCyjVaUp2i6LdEcaMMJoS/1wXxPOsdUlkCCfqLUp+mfW5p
	XKN2carN6gOZ6LZE0g/fS2u+kekLOGr63eNLbAWtxSAN0Kpr
X-Google-Smtp-Source: AGHT+IEdyoSXQSBEDKJGIuMT2YXVb+CmvXMv//Nae85gDsZk3xglbfdnyAl5X9qD1qZKp3jP2GiZl1dYh/BEG6nhSFc5h9Ea5nqy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d147:0:b0:35d:6c12:a6e4 with SMTP id
 t7-20020a92d147000000b0035d6c12a6e4mr1064502ilg.1.1703030304085; Tue, 19 Dec
 2023 15:58:24 -0800 (PST)
Date: Tue, 19 Dec 2023 15:58:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000511e9a060ce5a45c@google.com>
Subject: [syzbot] [arm?] WARNING in do_sve_acc
From: syzbot <syzbot+95ffb6a83b20ea7f4f55@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f7168591ebf Merge tag '6.7-rc5-smb3-client-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108baf71e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cf3c4f966189832
dashboard link: https://syzkaller.appspot.com/bug?extid=95ffb6a83b20ea7f4f55
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-3f716859.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc2a62c05f31/vmlinux-3f716859.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4dac83fca8af/Image-3f716859.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95ffb6a83b20ea7f4f55@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 16446 at arch/arm64/kernel/fpsimd.c:1394 do_sve_acc+0x6c/0x10c arch/arm64/kernel/fpsimd.c:1393
Modules linked in:
CPU: 0 PID: 16446 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00134-g3f7168591ebf #0
Hardware name: linux,dummy-virt (DT)
pstate: 01400009 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : do_sve_acc+0x6c/0x10c arch/arm64/kernel/fpsimd.c:1394
lr : do_sve_acc+0x5c/0x10c arch/arm64/kernel/fpsimd.c:1391
sp : ffff800082d1be60
x29: ffff800082d1be60 x28: fbff00000648af40 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000080001000 x22: 0000ffffa04568d4 x21: 00000000ffffffff
x20: fbff00000648bec8 x19: fbff00000648af40 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : faff000029208888 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000001
x2 : 0000000000000000 x1 : ffff7ffffd52e000 x0 : 0000000000800000
Call trace:
 do_sve_acc+0x6c/0x10c arch/arm64/kernel/fpsimd.c:1393
 el0_sve_acc+0x2c/0x98 arch/arm64/kernel/entry-common.c:580
 el0t_64_sync_handler+0xf4/0x12c arch/arm64/kernel/entry-common.c:708
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:595
---[ end trace 0000000000000000 ]---


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

