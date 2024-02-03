Return-Path: <linux-kernel+bounces-51232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70B1848824
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51766B23012
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59AC5F871;
	Sat,  3 Feb 2024 18:02:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2F5F46B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983347; cv=none; b=ZtPd1Sk8yaLaEYzVJ+gfUtqB9yYF0il8V33IG07OEQTqdwLzcUBCOKpBBwjaZaDhEzUDIChxTzXFiAqcCJMY906kMDqljxHwrINaZU0U18uN9eeRrxuVpZkzZq0vL3j5s6WuyFiDF1h2xLJtGFnvobWMkGTVBAC5hqM3gIdMghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983347; c=relaxed/simple;
	bh=OpCzJScOy0ans3iiys9Fl96fMziZDxp4Vey98NXQChM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kgx2M1gvH9eRJbRGiH9W+abjiS7sEQ3BynBsyBuQF+T1dI2v0Rx2TNfrSQeoQqlhJKBbK5aes8WkvYPr9jfn3N1HGUVmQ4eKmdeA+NSNG2ASHuUyAZ8usqEQVnOPCEk4MGarZ+vEzNSr8Kr0jj0nwGJHkCgFBfj8+8t0QuwVEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363930ba977so23100285ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 10:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706983345; x=1707588145;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8BIMaJkzTu28fgRsqkRky1lvWyIrpmgdUG1PvF/ySk=;
        b=HiBelQTgE/x4WsN8phCuiVkykFjegMjlxmW7fUbLqFfKNGshJgZ49qt5JGH9gw1x0t
         uYz/K0Qtdv+iNVML5YTGJkr+fx3HV/0PGavXnkyr3N1YMTJsvpPAiWL8Pj7qPvz93OZX
         zScv2Ih96SH8LiihAjtiB1Uzao4+GT1Y3StzWSrgWSvlRQG4Kw+ll/gxVGEDpllypyr0
         RGoBIWOiYYAlyCyv9tHphogdxhfWvzYh5S/R3HNt5rqdTM4ss4qQqOyFSsMXlvfKuDP/
         vSEC7x6YZztEl6cvuvXLKOb+j8D8rGaAE3GTIEKaAECzDUJad/+QBwkwPhEqyA0n47/t
         JI6g==
X-Gm-Message-State: AOJu0Yweoz4gS9/KAEp0qAulSsSbOszAiauU71GTnUlYjpqQqw9gNJxO
	fU+etvSYRiMpRuQc/Zle0Ji5Q3a5M93c+iQ+nKrSGlGhcyR7LYPr2Bg62zESlgf8q4HnE439iT7
	odIDWRa+f80yTPn1Ud5xpwFA5aU9/4KupY6w9Y1D/coOt1s0xUbEqAdU=
X-Google-Smtp-Source: AGHT+IFVH57x8djBTsWSbkgJpBPmul6zpkIYvLlGOKoSGp7EJ0VvzJhUZeG2pWp0ummMPOfUlSPC209EyFmq81ZT3+GYIcNZ2Opk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:363:9ffd:beca with SMTP id
 l7-20020a056e0212e700b003639ffdbecamr493499iln.5.1706983345171; Sat, 03 Feb
 2024 10:02:25 -0800 (PST)
Date: Sat, 03 Feb 2024 10:02:25 -0800
In-Reply-To: <000000000000cb54de060d2cc266@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed365206107e0783@google.com>
Subject: Re: [syzbot] [riscv?] kernel panic: Kernel stack overflow (2)
From: syzbot <syzbot+5c1ebfe49c5e8e998e75@syzkaller.appspotmail.com>
To: aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6613476e225e Linux 6.8-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=144ac160180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=877e61347079aad5
dashboard link: https://syzkaller.appspot.com/bug?extid=5c1ebfe49c5e8e998e75
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c57b90180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d369ffe80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-6613476e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33ea806d02dd/vmlinux-6613476e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33195f72f823/Image-6613476e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c1ebfe49c5e8e998e75@syzkaller.appspotmail.com

 s11: ff60000011241a00 t3 : 0000000000000004 t4 : 1fec00000224849b
 t5 : 0000000000000002 t6 : 1fec0000022484c6
status: 0000000200000100 badaddr: ff2000000493ffc0 cause: 000000000000000f
Kernel panic - not syncing: Kernel stack overflow
CPU: 1 PID: 3859 Comm: kworker/1:3 Not tainted 6.8.0-rc1-syzkaller #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue: usb_hub_wq hub_event
Call Trace:
[<ffffffff80010868>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:121
[<ffffffff858a9b60>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:127
[<ffffffff85904e9c>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff85904e9c>] dump_stack_lvl+0xe8/0x154 lib/dump_stack.c:106
[<ffffffff85904f24>] dump_stack+0x1c/0x24 lib/dump_stack.c:113
[<ffffffff858aa5b2>] panic+0x33c/0x77a kernel/panic.c:344
[<ffffffff80010396>] handle_bad_stack+0xe0/0xf4 arch/riscv/kernel/traps.c:412
[<ffffffff80214a26>] mark_usage kernel/locking/lockdep.c:4599 [inline]
[<ffffffff80214a26>] __lock_acquire+0xaa8/0x784c kernel/locking/lockdep.c:5091
SMP: stopping secondary CPUs
Rebooting in 86400 seconds..


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

