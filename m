Return-Path: <linux-kernel+bounces-51782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA13848F39
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC01283AEB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5804822EF9;
	Sun,  4 Feb 2024 16:25:10 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E487722EE0
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063909; cv=none; b=Go1yHGQgt/VZDrw/tmSIc4ymZI6y+YPvMq4pMKjU0Z+FoPqtz4xOgFzP0vXNupTB6C9L6OpPCFQOsroZn+hsVxEOgaXe0mN/M5iVrUvcTcPWX3C58Ond/h/6iNhH0DJS+xKXcRCXuaRjTRVsXgTx5fqcX1da+Fhx2qOtcUy+aec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063909; c=relaxed/simple;
	bh=plU8UoPkzCaurb47JhN6xQzr89BfEnqggC31tveZ0go=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cc/BeD5fyR1OtaDnHFK4VwxeVpHciJ6xe8y+Xx0t0cuZOfQB9sYgdJgecVRE5SHakcjjaqeDCHbgM/mMRWZVuWYgTAO2URrI9KnJjjSGfyd57KRVIFEP5lOBqaTo/T+9ILvI+SholaECQedf17Qz3tUwkGdGaMnAdhzV47wgbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D244D240003;
	Sun,  4 Feb 2024 16:24:54 +0000 (UTC)
Message-ID: <035070c6-7adf-4a38-bb5a-fdc4be353c93@ghiti.fr>
Date: Sun, 4 Feb 2024 17:24:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [riscv?] kernel panic: Kernel stack overflow (2)
Content-Language: en-US
To: syzbot <syzbot+5c1ebfe49c5e8e998e75@syzkaller.appspotmail.com>,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, syzkaller-bugs@googlegroups.com
References: <000000000000ed365206107e0783@google.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <000000000000ed365206107e0783@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 03/02/2024 19:02, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    6613476e225e Linux 6.8-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=144ac160180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=877e61347079aad5
> dashboard link: https://syzkaller.appspot.com/bug?extid=5c1ebfe49c5e8e998e75
> compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: riscv64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c57b90180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d369ffe80000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-6613476e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/33ea806d02dd/vmlinux-6613476e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/33195f72f823/Image-6613476e.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5c1ebfe49c5e8e998e75@syzkaller.appspotmail.com
>
>   s11: ff60000011241a00 t3 : 0000000000000004 t4 : 1fec00000224849b
>   t5 : 0000000000000002 t6 : 1fec0000022484c6
> status: 0000000200000100 badaddr: ff2000000493ffc0 cause: 000000000000000f
> Kernel panic - not syncing: Kernel stack overflow
> CPU: 1 PID: 3859 Comm: kworker/1:3 Not tainted 6.8.0-rc1-syzkaller #0
> Hardware name: riscv-virtio,qemu (DT)
> Workqueue: usb_hub_wq hub_event
> Call Trace:
> [<ffffffff80010868>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:121
> [<ffffffff858a9b60>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:127
> [<ffffffff85904e9c>] __dump_stack lib/dump_stack.c:88 [inline]
> [<ffffffff85904e9c>] dump_stack_lvl+0xe8/0x154 lib/dump_stack.c:106
> [<ffffffff85904f24>] dump_stack+0x1c/0x24 lib/dump_stack.c:113
> [<ffffffff858aa5b2>] panic+0x33c/0x77a kernel/panic.c:344
> [<ffffffff80010396>] handle_bad_stack+0xe0/0xf4 arch/riscv/kernel/traps.c:412
> [<ffffffff80214a26>] mark_usage kernel/locking/lockdep.c:4599 [inline]
> [<ffffffff80214a26>] __lock_acquire+0xaa8/0x784c kernel/locking/lockdep.c:5091
> SMP: stopping secondary CPUs
> Rebooting in 86400 seconds..
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


I ran the reproducer locally all week-end but not luck, it did not 
trigger any panic.


