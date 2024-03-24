Return-Path: <linux-kernel+bounces-112619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD4887C11
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED761F216C5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF415E96;
	Sun, 24 Mar 2024 09:13:20 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3328E7
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711271600; cv=none; b=FtWIyPR7BVTOieBk5NVWqH9/AChZAMQgl52eNkghdMvB6nuWspjKRNyVCYlpYuTFx+eBB2iWs6P//g6A4S2ni5CdtVf3prG5PD3h91WYeAnJuS9Kf2X0YwDAxj5tNpwHe5fgY+huOyZiTs5VOPKwgQRJWDz4JKZ7MIsoy7mvzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711271600; c=relaxed/simple;
	bh=LASdfWo+PAdGiOWJsIajv8GovHi3jxThnj11KlTG52Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SA8329KWXyIQy2VJ3BCxKAVvn698LYGnlX+G0ID0lGnSIqLuH7f4mOy3zgJrJ973RlJ0qTv2zf3rbAWVPB4WrKIDlPyQHM5ikum2Qh4mcwpG8JdKtHXLpbskSWqEe1PwbDSYT5HjbxazqY2zFSKtSBYFRfxjVWtNOe9Iu6aVeQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc7a6a04d9so431813839f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 02:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711271598; x=1711876398;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2v3BJFcKstkwg7hoqZAn50p0nglp/lBvTndnPiDHQMw=;
        b=ImBfusb/Xsqgu/L/JVGOYbnB572AnHmrv0u5UTGw/8xCNFNjpUedRcfiYSDIApR+zJ
         g+gbn4C5xG0eIWtgvprXme5VLWRVETPE2scOFG/gPRMnK94zKGqQG0hsqKOJLEB8yO2M
         KiWMeDgsZwcmdCcGVv7EJYtTrGgcZPKEF0cLzxswLVk/7Lmjs3jdGjei55bQBNJOHhlh
         6yiVJ5lQL97IWL7eiA14PXAOKTyZPRDoGIAMr+LxrbxiIy3fYC8fiJKeRNI46krbY1Jx
         gmQ+R2VKU4Uug4lOfrASexPkVAl5J5DG7e7jAd8YOUQDI8T+vARM8vRjQS7LfKgB41G8
         GK2w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ48qu2HLk+JfjUw8rQ6hxCOVxEPQ3aqCZYgIfaXqKgIekiwJRfYDxExRbdYZkK6l/6af3LVuJ/gbOWKZCkagJ7IqyawYJe6nAg2HH
X-Gm-Message-State: AOJu0YxE+O1OAo/1MCUPbJ0qK3XM3/F0NWkwTzz6Ozs9Eh4KsnLdzZxM
	sneZU3zzJf7geffErCZH5Ry5JTQJNMFW3TWuFSAxLheONWol55xtH/aKGbRpArBj5l5CyACXqUy
	X9Z8GUtQUW2tl3ffGpHxrtXoSSGR3RI9HSVyQElg+3NqYGssQ39sZpQM=
X-Google-Smtp-Source: AGHT+IE2Erp9hG/EtxcXYrxZy7aKdtVfdgxRgjHaWaofsnaACkVw9yX/ugLprT+4qe2yjy7yb9PLgGOBUXl3eRenEgd05piajHxU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3586:b0:476:c0ae:98a with SMTP id
 v6-20020a056638358600b00476c0ae098amr261041jal.4.1711271596021; Sun, 24 Mar
 2024 02:13:16 -0700 (PDT)
Date: Sun, 24 Mar 2024 02:13:16 -0700
In-Reply-To: <0000000000008fcf9806083e7405@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009871740614647751@google.com>
Subject: Re: [syzbot] [kernel?] KMSAN: kernel-infoleak-after-free in
 copy_siginfo_to_user (2)
From: syzbot <syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, luto@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    70293240c5ce Merge tag 'timers-urgent-2024-03-23' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=139071be180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
dashboard link: https://syzkaller.appspot.com/bug?extid=cfc08744435c4cf94a40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14694231180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15846fc1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0de52742d0b8/disk-70293240.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f304697881bf/vmlinux-70293240.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b9d8a9376f0/bzImage-70293240.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak-after-free in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _copy_to_user+0xbc/0x110 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 copy_siginfo_to_user+0x40/0x130 kernel/signal.c:3380
 ptrace_request+0xfa7/0x36e0 kernel/ptrace.c:1046
 arch_ptrace+0x43b/0x680 arch/x86/kernel/ptrace.c:848
 __do_sys_ptrace kernel/ptrace.c:1285 [inline]
 __se_sys_ptrace+0x2d8/0x760 kernel/ptrace.c:1258
 __x64_sys_ptrace+0xbd/0x110 kernel/ptrace.c:1258
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
 copy_siginfo include/linux/signal.h:18 [inline]
 ptrace_getsiginfo kernel/ptrace.c:685 [inline]
 ptrace_request+0xf33/0x36e0 kernel/ptrace.c:1044
 arch_ptrace+0x43b/0x680 arch/x86/kernel/ptrace.c:848
 __do_sys_ptrace kernel/ptrace.c:1285 [inline]
 __se_sys_ptrace+0x2d8/0x760 kernel/ptrace.c:1258
 __x64_sys_ptrace+0xbd/0x110 kernel/ptrace.c:1258
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
 copy_siginfo include/linux/signal.h:18 [inline]
 collect_signal kernel/signal.c:587 [inline]
 __dequeue_signal+0x501/0xad0 kernel/signal.c:616
 dequeue_signal+0x14b/0xb20 kernel/signal.c:639
 get_signal+0xb46/0x2d00 kernel/signal.c:2790
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
 do_syscall_64+0xe4/0x1f0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 slab_free_hook mm/slub.c:2073 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x257/0xa80 mm/slub.c:4344
 __sigqueue_free kernel/signal.c:451 [inline]
 collect_signal kernel/signal.c:594 [inline]
 __dequeue_signal+0xa58/0xad0 kernel/signal.c:616
 dequeue_signal+0x14b/0xb20 kernel/signal.c:639
 get_signal+0xb46/0x2d00 kernel/signal.c:2790
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
 do_syscall_64+0xe4/0x1f0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Bytes 12-15 of 48 are uninitialized
Memory access of size 48 starts at ffff8881240cfc60
Data copied to user address 0000000014dcf540

CPU: 1 PID: 5012 Comm: strace-static-x Not tainted 6.8.0-syzkaller-13213-g70293240c5ce #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

