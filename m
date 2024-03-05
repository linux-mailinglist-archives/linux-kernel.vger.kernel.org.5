Return-Path: <linux-kernel+bounces-92590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAE687228D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A872826F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A7F1272B8;
	Tue,  5 Mar 2024 15:21:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305C84A48
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652064; cv=none; b=RZVypT8EkCqdhtSZ4ph1STb5ZEqqIu9xSNRFbjmAX22Kvvb+SmIKyXVf7Pxt24ck27A1E/xz2fFB14lgdqsB7C6qUvVafk+OeYuQijkKXGi32pEy5gI9kjP0OvU77HlvHnsV9v/329qi1LHoF5ZimB4I25rhch3G/pCDTENX9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652064; c=relaxed/simple;
	bh=secb0s0G02dw18UnSzVlWcsCMLvnMyvFv3sdV8PV3X8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N3/NbZzjSv6Ol7mS1ociz6FxiS2QfGjuVPPfv2rk9Z8/ervY+zfURGeEmf3yafCBpQjyI5pSMsoj+OpFfcCO38v1mF3paCvf0HBIFnBieZCtpOz/N0yl7H7dpqMmJ4EqR+IxjzrHUED9rADhYJPKLToVNx2G0biHIKAR1VXIm1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36541324e57so67248585ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709652062; x=1710256862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5OZflGizEcTFmP+uFFPpY8DPNB/3AAZokjZWApXZ+U=;
        b=YO3yNIjDy7G/06kySF1Y9Dyy2H1IM0O2zlf5HMAzENi/NNyaWxeHzdVTyBiNBHihdA
         jTwfe819iYxFzepm9cnxiN9AmtMKTr9B6axhv9GpkdecUYgktAnf9jiM5+n+PQ9TX7rF
         hqdhoMlP3RUeGvZTe/NdjwJ5TDI19JqYhkZcK7DrNq0ELWGhrRf7l/kSKVaAN4hl1Kvu
         BqlaVayIcZrEXLL2RjFfFUSEaHyAJU9eQiUJWzBpYAGqfEtyiFf7TCsfoyMPzB/nzjMK
         uGjTGVHdbavqj2xLNvzhsBToFPcn6irc3ihZp6zOdB9fXMNopQHw8vTe/O5DKSirlxc5
         jeQQ==
X-Gm-Message-State: AOJu0YwBs/K6LIsDHGVmYBu/1xv8aUvzM+Ay5sL/Al8GflP5aIghOiMK
	Fh0PbqyHutBesmgH00vx/N6Tf3KPKAgheRx+cN3WBULddqJzwvwrKsAdDn15qwPmVaJJm09c3R/
	ckRN9Nwa4AYxlcLZqPtU33y327zykY6CtZTI8Ismpeax6/EjPYVmc3sZ6PQ==
X-Google-Smtp-Source: AGHT+IHHQtetFdL02s67kd1hSFWRWSr2Suz9huNqhxQyg5jojujWPS1GZnZpv2sazLV7LxoUVJXgUlgOg8pXeJVmEC2iWyK1cHbP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:365:26e3:6e47 with SMTP id
 j29-20020a056e02219d00b0036526e36e47mr776975ila.0.1709652062280; Tue, 05 Mar
 2024 07:21:02 -0800 (PST)
Date: Tue, 05 Mar 2024 07:21:02 -0800
In-Reply-To: <2963e725-588c-4390-9bc1-525414bb101c@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcaf000612eb6353@google.com>
Subject: Re: [syzbot] [serial?] possible deadlock in console_flush_all (2)
From: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in locks_remove_posix

general protection fault, probably for non-canonical address 0xdffffc0020008013: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000100040098-0x000000010004009f]
CPU: 1 PID: 5487 Comm: dhcpcd-run-hook Not tainted 6.8.0-rc6-syzkaller-g8f50d5c42355-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:locks_remove_posix+0xff/0x440 fs/locks.c:2554
Code: 4d 8b be 20 02 00 00 4d 85 ff 0f 84 9f 01 00 00 e8 16 ea 7b ff 49 8d 47 50 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <80> 3c 11 00 0f 85 09 03 00 00 49 8b 57 50 48 39 d0 0f 84 6e 01 00
RSP: 0018:ffffc9000388f978 EFLAGS: 00010202
RAX: 0000000100040098 RBX: ffff888019b36500 RCX: 0000000020008013
RDX: dffffc0000000000 RSI: ffffffff820b2e1a RDI: ffff888076090730
RBP: 1ffff92000711f30 R08: 0000000000000003 R09: 0000000000004000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000388f9b0
R13: ffff88802a7e0b40 R14: ffff888076090510 R15: 0000000100040048
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000100040340 CR3: 00000000183e4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filp_flush+0x11b/0x1a0 fs/open.c:1518
 filp_close+0x1c/0x30 fs/open.c:1527
 close_files fs/file.c:432 [inline]
 put_files_struct fs/file.c:447 [inline]
 put_files_struct+0x1df/0x360 fs/file.c:444
 exit_files+0x82/0xb0 fs/file.c:464
 do_exit+0xa56/0x2ad0 kernel/exit.c:866
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
 get_signal+0x23b5/0x2790 kernel/signal.c:2893
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x13c/0x280 kernel/entry/common.c:225
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7fbec7157428
Code: Unable to access opcode bytes at 0x7fbec71573fe.
RSP: 002b:00007fff8928a8a0 EFLAGS: 00010246
RAX: 0000000100040048 RBX: 0000555b854932c0 RCX: 00007fbec7205098
RDX: 0000000000000000 RSI: 0000555b85495d30 RDI: 0000555b85494930
RBP: 0000555b85494930 R08: 0000000000000000 R09: 0000000000000000
R10: 00007fbec7205088 R11: 0000000000000246 R12: 0000000000000000
R13: 0000555b85495d30 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:locks_remove_posix+0xff/0x440 fs/locks.c:2554
Code: 4d 8b be 20 02 00 00 4d 85 ff 0f 84 9f 01 00 00 e8 16 ea 7b ff 49 8d 47 50 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <80> 3c 11 00 0f 85 09 03 00 00 49 8b 57 50 48 39 d0 0f 84 6e 01 00
RSP: 0018:ffffc9000388f978 EFLAGS: 00010202
RAX: 0000000100040098 RBX: ffff888019b36500 RCX: 0000000020008013
RDX: dffffc0000000000 RSI: ffffffff820b2e1a RDI: ffff888076090730
RBP: 1ffff92000711f30 R08: 0000000000000003 R09: 0000000000004000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000388f9b0
R13: ffff88802a7e0b40 R14: ffff888076090510 R15: 0000000100040048
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000100040340 CR3: 00000000183e4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	4d 8b be 20 02 00 00 	mov    0x220(%r14),%r15
   7:	4d 85 ff             	test   %r15,%r15
   a:	0f 84 9f 01 00 00    	je     0x1af
  10:	e8 16 ea 7b ff       	call   0xff7bea2b
  15:	49 8d 47 50          	lea    0x50(%r15),%rax
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	48 89 c1             	mov    %rax,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2e:	0f 85 09 03 00 00    	jne    0x33d
  34:	49 8b 57 50          	mov    0x50(%r15),%rdx
  38:	48 39 d0             	cmp    %rdx,%rax
  3b:	0f                   	.byte 0xf
  3c:	84 6e 01             	test   %ch,0x1(%rsi)


Tested on:

commit:         8f50d5c4 Merge branch 'Allow struct_ops maps with a la..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c2d486180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e085fc648b10d1e
dashboard link: https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121c92fe180000


