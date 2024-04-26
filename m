Return-Path: <linux-kernel+bounces-160029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F36498B3809
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B9EB2394D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901C1146D60;
	Fri, 26 Apr 2024 13:12:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73C146D49
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137125; cv=none; b=obhU0147sJDaUn4WxoUOQZ9NCKBLZ7F7APsAWrVDtHBflPHHEBswdSwAzqbYo7pjDIkHmsaEqR4jnUDdtAlWZPLC92vUEb3X97blA2I6LzZtxDIlLSNoCD8EQdtKenCKD22xaTQCPc6/K7fskjd14dMBvzkflwl7KLoopTX5ICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137125; c=relaxed/simple;
	bh=2HWrKHnQB3y3kaZh/I5NhxDQVa8ppYkVN9OZu4QxCTI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E5FsbHE2fijBVo6xqvXxgJLiJ8F2RBEGJ4uiYjHTGgbpy/cpmC6WUqEpZQ/LNzuayTi6EHOMpLOlSiF8JpjL+dQFjLnGfcwhAvTD3fke6KR2GqCF4FF4eEk0OXFh7l34OQpIQjAcgzeMcmLYdKTSn/bp3q0c/XTR9aCFQfoiG/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7de9cd658acso217694539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714137123; x=1714741923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts53iA26p3OpLI1ZICu2/XpftwDXOXj+U0QYGTgGKLI=;
        b=sHRiTjr9/0se8RaVbTe/58DHQKGTkXfwPTrbYUOAJp3fnqhtfHNvGQ5P5iRObW8aIZ
         ++2rIva7hXb56CuNZO+YxwNWOOHi7f3HczhO9j/eVaXHxU9OeAZnJNRMHDNjw6gEqY6P
         EDrV5XldYABsIMeuSFDaL1cNCXrBGZ6NRSEhk7I1Jcrd3q5IAQeDbYPskNwy9vPs+G4U
         BCHI8C39lRMi4+LJO5zsZtlNWs3DZoYY3ciEobEicpdBncP/nvXExBTnoE+hqWjwWbXB
         6RNjxNdl0Uzn6SSeMSbfiOiCONlRxMgoFQwwZV3vIpxDxAAIta1uB1d/XokxLjJquEms
         xklg==
X-Forwarded-Encrypted: i=1; AJvYcCXlgdJWHvIDKKZky3KCDo/Nypv6iXilPQEWqHTk92D+kNfvd/4BwYxVgsyyk46nESXgXRaA9basdBAkiQI3xkytFzwQgvPZ1q9UfCEH
X-Gm-Message-State: AOJu0Yz+H7pW213R2KFvoY+/p83L75WcmH+/B6z85xlHVvoWSh5+zfNS
	Fnyg06tDU1EE9NfJLYxJRzJIoil+W8AlFIo9QI/arBEDtgQ69Ob/Xc552j942fYIe6hhXWIQDiV
	FvhJXqD68xjbTgzc0TbasJUDfJTDwoyxLnncttiFeCjaMzYEEA+Hu4kg=
X-Google-Smtp-Source: AGHT+IGI/xbsgVKAYSHDAusPXfIqrtaaH+8I6+DujHrhxjMODAop0NgasSbrfKKD9UxEleaVxMbH0pB5RMOLs7xlHbegjzcw6Leo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22cc:b0:485:4f60:6015 with SMTP id
 j12-20020a05663822cc00b004854f606015mr153017jat.6.1714137123577; Fri, 26 Apr
 2024 06:12:03 -0700 (PDT)
Date: Fri, 26 Apr 2024 06:12:03 -0700
In-Reply-To: <20240426110215.3361-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058f1b00616ffa6bf@google.com>
Subject: Re: [syzbot] [input?] [ext4?] possible deadlock in uinput_request_submit
From: syzbot <syzbot+159077b1355b8cd72757@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in uinput_destroy_device

input: syz1 as /devices/virtual/input/input6070
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 21743 Comm: syz-executor144 Not tainted 6.9.0-rc4-next-20240418-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:976
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1289
 __lock_acquire+0xda/0x1fd0 kernel/locking/lockdep.c:5014
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 complete_with_flags kernel/sched/completion.c:20 [inline]
 complete+0x28/0x1c0 kernel/sched/completion.c:47
 uinput_flush_requests drivers/input/misc/uinput.c:213 [inline]
 uinput_destroy_device+0x129/0x8f0 drivers/input/misc/uinput.c:298
 uinput_release+0x3e/0x50 drivers/input/misc/uinput.c:751
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:877
 do_group_exit+0x207/0x2c0 kernel/exit.c:1026
 __do_sys_exit_group kernel/exit.c:1037 [inline]
 __se_sys_exit_group kernel/exit.c:1035 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1035
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb846ea6639
Code: Unable to access opcode bytes at 0x7fb846ea660f.
RSP: 002b:00007fff8074c3d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb846ea6639
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fb846f222d0 R08: ffffffffffffffb8 R09: 000000000000046f
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb846f222d0
R13: 0000000000000000 R14: 00007fb846f23040 R15: 00007fb846e74780
 </TASK>
BUG: unable to handle page fault for address: fffffffffffffff8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD e136067 P4D e136067 PUD e138067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 21743 Comm: syz-executor144 Not tainted 6.9.0-rc4-next-20240418-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:swake_up_locked kernel/sched/swait.c:29 [inline]
RIP: 0010:complete_with_flags kernel/sched/completion.c:24 [inline]
RIP: 0010:complete+0x9b/0x1c0 kernel/sched/completion.c:47
Code: df e8 39 fd 8b 00 4c 8b 23 49 39 dc 0f 84 e2 00 00 00 49 8d 7c 24 f8 48 89 f8 48 c1 e8 03 42 80 3c 30 00 74 05 e8 15 fd 8b 00 <49> 8b 7c 24 f8 be 03 00 00 00 31 d2 e8 04 e5 f6 ff 4c 89 e7 e8 3c
RSP: 0018:ffffc9000a91fb30 EFLAGS: 00010046
RAX: 1fffffffffffffff RBX: ffffc9000b477af8 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: fffffffffffffff8
RBP: 1ffff9200168ef56 R08: 0000000000000003 R09: fffff52001523f40
R10: dffffc0000000000 R11: fffff52001523f40 R12: 0000000000000000
R13: 0000000000000246 R14: dffffc0000000000 R15: ffffc9000b477ab8
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff8 CR3: 0000000024bc2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 uinput_flush_requests drivers/input/misc/uinput.c:213 [inline]
 uinput_destroy_device+0x129/0x8f0 drivers/input/misc/uinput.c:298
 uinput_release+0x3e/0x50 drivers/input/misc/uinput.c:751
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:877
 do_group_exit+0x207/0x2c0 kernel/exit.c:1026
 __do_sys_exit_group kernel/exit.c:1037 [inline]
 __se_sys_exit_group kernel/exit.c:1035 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1035
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb846ea6639
Code: Unable to access opcode bytes at 0x7fb846ea660f.
RSP: 002b:00007fff8074c3d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb846ea6639
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fb846f222d0 R08: ffffffffffffffb8 R09: 000000000000046f
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb846f222d0
R13: 0000000000000000 R14: 00007fb846f23040 R15: 00007fb846e74780
 </TASK>
Modules linked in:
CR2: fffffffffffffff8
---[ end trace 0000000000000000 ]---
RIP: 0010:swake_up_locked kernel/sched/swait.c:29 [inline]
RIP: 0010:complete_with_flags kernel/sched/completion.c:24 [inline]
RIP: 0010:complete+0x9b/0x1c0 kernel/sched/completion.c:47
Code: df e8 39 fd 8b 00 4c 8b 23 49 39 dc 0f 84 e2 00 00 00 49 8d 7c 24 f8 48 89 f8 48 c1 e8 03 42 80 3c 30 00 74 05 e8 15 fd 8b 00 <49> 8b 7c 24 f8 be 03 00 00 00 31 d2 e8 04 e5 f6 ff 4c 89 e7 e8 3c
RSP: 0018:ffffc9000a91fb30 EFLAGS: 00010046
RAX: 1fffffffffffffff RBX: ffffc9000b477af8 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: fffffffffffffff8
RBP: 1ffff9200168ef56 R08: 0000000000000003 R09: fffff52001523f40
R10: dffffc0000000000 R11: fffff52001523f40 R12: 0000000000000000
R13: 0000000000000246 R14: dffffc0000000000 R15: ffffc9000b477ab8
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff8 CR3: 0000000024bc2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	df e8                	fucomip %st(0),%st
   2:	39 fd                	cmp    %edi,%ebp
   4:	8b 00                	mov    (%rax),%eax
   6:	4c 8b 23             	mov    (%rbx),%r12
   9:	49 39 dc             	cmp    %rbx,%r12
   c:	0f 84 e2 00 00 00    	je     0xf4
  12:	49 8d 7c 24 f8       	lea    -0x8(%r12),%rdi
  17:	48 89 f8             	mov    %rdi,%rax
  1a:	48 c1 e8 03          	shr    $0x3,%rax
  1e:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
  23:	74 05                	je     0x2a
  25:	e8 15 fd 8b 00       	call   0x8bfd3f
* 2a:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi <-- trapping instruction
  2f:	be 03 00 00 00       	mov    $0x3,%esi
  34:	31 d2                	xor    %edx,%edx
  36:	e8 04 e5 f6 ff       	call   0xfff6e53f
  3b:	4c 89 e7             	mov    %r12,%rdi
  3e:	e8                   	.byte 0xe8
  3f:	3c                   	.byte 0x3c


Tested on:

commit:         7b4f2bc9 Add linux-next specific files for 20240418
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14aa5b27180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
dashboard link: https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179fc530980000


