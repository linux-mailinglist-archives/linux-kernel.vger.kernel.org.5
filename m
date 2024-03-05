Return-Path: <linux-kernel+bounces-92146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD80871BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBEA1F24C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7406086F;
	Tue,  5 Mar 2024 10:27:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46F60866
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634426; cv=none; b=CMZqdDvYLa2ZGTr3sVkIOVmiK/G8CBxakAIjm/KwBgPbfjjgOG0Bx4uZESDhB0pBdKmYCxBowKQBUQlo1h5aKPRppbD5Qyztg2eB/y7yNAknfkXpFMFEZKMVWtCCT8AbUKTvAnRpg7mitOqbTrGCEo1CzQEhOFxDA4BJqnctlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634426; c=relaxed/simple;
	bh=Lj2shro+qrm//gaCBEnVwEFldIgVBCr1i1Smg1wA5MI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oGB0dl1pW/eZPJB9zKf93SS6AHFaakQ/lsTxx3CzMQ1I440A999EUWysTIX2QnXHwXNF4ra2th9lvHCylMI1JYig6x7BH0AprB7x3xK1RCCpK0IEjMUftAJe+/UlltPmAte+Ps8/tYBLeEdHe+2WoSOOW8pB/xSpAHCRs4/ZjFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3652d6907a1so77913585ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709634424; x=1710239224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yn7B4XXQeSpbpwUplkZFEdhl0H/NStnvsin4aUQK51k=;
        b=L8kRYZafn4JMhL4PWXLtazIC1zFODFzU+/TWLqx4mJwkNHUii1oVfwfhAJXuhSRu6s
         ZxJJjOHEvOn9IZF40A6ukWhqYX99SpyrCzP7Q9J5hq1Q5rbuz8a8zgMdfeuTb01yNNhR
         WS5ctSiXZnh314SWDx1h0kQcIW1F3yDhtaiR41RC1JYgdC68Btf78S9oKhZePWAyKMo0
         K71tIUzfIxJCFq4XfDAwGAxMQtBK2FRDc6C2Cy2gvaqwgU9cb/ltKbTE93sGSfBmIKsS
         tfPqGYtOJ4SY5K7swvU/UjfqiFQAcDtua7ywuZnanQs7PWatsEQpAtdSoFMpZGWgAbwK
         /0nw==
X-Gm-Message-State: AOJu0YxjQMeBhxkDWpzy8SappQR78dxu/UpkY1vpwy/nuhCOCk2DPiB5
	6/kLuNVgKIgsSsNJ6mYFUkVoKQLA3mDPUtNoe7LOQkXHYHWRTvr4TQFJ0iDARc9r5r7CBtXOGrt
	xv/AtTL9l2sejwxHri7XkdK0UO8zuB3LUUr81OrWzl6/JP3lJpTcuslpA8Q==
X-Google-Smtp-Source: AGHT+IF1KTUcL7MTFPgiYAgUNE+bT1tbcDlRfvXRylPuN7H0GGYtZvp41ZrIH1QBJdfAF+JhEqsKXPO/S2wYfeGoREtc25EJpKg4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:363:b9d6:1261 with SMTP id
 j29-20020a056e02219d00b00363b9d61261mr830520ila.0.1709634423873; Tue, 05 Mar
 2024 02:27:03 -0800 (PST)
Date: Tue, 05 Mar 2024 02:27:03 -0800
In-Reply-To: <1fec6a8b-7083-4b08-858a-0793f996ed52@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087ec580612e7488e@google.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
From: syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: bad usercopy in fpa_set

usercopy: Kernel memory overwrite attempt detected to SLUB object 'task_struct' (offset 80, size 140)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 3917 Comm: syz-executor.0 Not tainted 6.8.0-rc7-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at usercopy_abort+0x98/0x9c mm/usercopy.c:102
LR is at __wake_up_klogd.part.0+0x7c/0xac kernel/printk/printk.c:3899
pc : [<8183e740>]    lr : [<802b7f34>]    psr: 60000113
sp : df9d5e50  ip : df9d5d98  fp : df9d5e74
r10: 0000001a  r9 : 83d59800  r8 : 84ccd450
r7 : ddea5c20  r6 : 00000000  r5 : 0000008c  r4 : 00000050
r3 : 83d59800  r2 : 00000000  r1 : 00000000  r0 : 00000066
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 84b822c0  DAC: 00000000
Register r0 information: non-paged memory
Register r1 information: NULL pointer
Register r2 information: NULL pointer
Register r3 information: slab task_struct start 83d59800 pointer offset 0 size 3072
Register r4 information: non-paged memory
Register r5 information: non-paged memory
Register r6 information: NULL pointer
Register r7 information: non-slab/vmalloc memory
Register r8 information: slab task_struct start 84ccd400 pointer offset 80 size 3072
Register r9 information: slab task_struct start 83d59800 pointer offset 0 size 3072
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xdf9d4000 allocated at kernel_clone+0xac/0x3c8 kernel/fork.c:2902
Register r12 information: 2-page vmalloc region starting at 0xdf9d4000 allocated at kernel_clone+0xac/0x3c8 kernel/fork.c:2902
Process syz-executor.0 (pid: 3917, stack limit = 0xdf9d4000)
Stack: (0xdf9d5e50 to 0xdf9d6000)
5e40:                                     81fda684 81fadca8 81fc2424 00000050
5e60: 0000008c 83d59800 df9d5ea4 df9d5e78 804a922c 8183e6b4 0000008c df9d5e88
5e80: 80216278 84ccd450 0000008c 00000000 84ccd4dc ddea5c20 df9d5edc df9d5ea8
5ea0: 804e1c20 804a9160 0000008c 00000001 df9d5ecc 84ccd450 0000008c 00000001
5ec0: 00000000 00000000 83d59800 0000001a df9d5ef4 df9d5ee0 8020a090 804e1a40
5ee0: 00000000 0000000c df9d5f6c df9d5ef8 8020a680 8020a01c 00000000 00000000
5f00: df9d5f1c df9d5f10 81862d34 802798b0 df9d5f6c df9d5f20 8027f524 81862d10
5f20: df9d5f54 00000000 8027b25c 60000013 818110f0 81827f88 df9d5f54 b2f514c9
5f40: 0000000f 84ccd400 0000000f b2f514c9 84ccd400 0000000f 00000001 00000000
5f60: df9d5fa4 df9d5f70 80253494 8020a398 8020301c b2f514c9 df9d5fac 00000000
5f80: 00000000 0014c2cc 0000001a 80200288 83d59800 0000001a 00000000 df9d5fa8
5fa0: 80200060 80253268 00000000 00000000 0000000f 00000004 00000001 00000000
5fc0: 00000000 00000000 0014c2cc 0000001a 7e8da326 7e8da327 003d0f00 76bf70fc
5fe0: 76bf6f08 76bf6ef8 000167e8 00050bd0 60000010 0000000f 00000000 00000000
Backtrace: 
[<8183e6a8>] (usercopy_abort) from [<804a922c>] (__check_heap_object+0xd8/0xf4 mm/slub.c:5386)
[<804a9154>] (__check_heap_object) from [<804e1c20>] (check_heap_object mm/usercopy.c:196 [inline])
[<804a9154>] (__check_heap_object) from [<804e1c20>] (__check_object_size mm/usercopy.c:251 [inline])
[<804a9154>] (__check_heap_object) from [<804e1c20>] (__check_object_size+0x1ec/0x30c mm/usercopy.c:213)
 r8:ddea5c20 r7:84ccd4dc r6:00000000 r5:0000008c r4:84ccd450
[<804e1a34>] (__check_object_size) from [<8020a090>] (check_object_size include/linux/thread_info.h:215 [inline])
[<804e1a34>] (__check_object_size) from [<8020a090>] (__copy_from_user include/linux/uaccess.h:101 [inline])
[<804e1a34>] (__check_object_size) from [<8020a090>] (user_regset_copyin include/linux/regset.h:268 [inline])
[<804e1a34>] (__check_object_size) from [<8020a090>] (fpa_set+0x80/0xa0 arch/arm/kernel/ptrace.c:589)
 r10:0000001a r9:83d59800 r8:00000000 r7:00000000 r6:00000001 r5:0000008c
 r4:84ccd450
[<8020a010>] (fpa_set) from [<8020a680>] (copy_regset_from_user include/linux/regset.h:337 [inline])
[<8020a010>] (fpa_set) from [<8020a680>] (arch_ptrace+0x2f4/0x3e4 arch/arm/kernel/ptrace.c:764)
 r5:0000000c r4:00000000
[<8020a38c>] (arch_ptrace) from [<80253494>] (__do_sys_ptrace kernel/ptrace.c:1288 [inline])
[<8020a38c>] (arch_ptrace) from [<80253494>] (sys_ptrace+0x238/0x4dc kernel/ptrace.c:1261)
 r7:00000000 r6:00000001 r5:0000000f r4:84ccd400
[<8025325c>] (sys_ptrace) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdf9d5fa8 to 0xdf9d5ff0)
5fa0:                   00000000 00000000 0000000f 00000004 00000001 00000000
5fc0: 00000000 00000000 0014c2cc 0000001a 7e8da326 7e8da327 003d0f00 76bf70fc
5fe0: 76bf6f08 76bf6ef8 000167e8 00050bd0
 r10:0000001a r9:83d59800 r8:80200288 r7:0000001a r6:0014c2cc r5:00000000
 r4:00000000
Code: e30a0688 e34801fd e58dc000 ebfff35b (e7f001f2) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e30a0688 	movw	r0, #42632	@ 0xa688
   4:	e34801fd 	movt	r0, #33277	@ 0x81fd
   8:	e58dc000 	str	ip, [sp]
   c:	ebfff35b 	bl	0xffffcd80
* 10:	e7f001f2 	udf	#18 <-- trapping instruction


Tested on:

commit:         90d35da6 Linux 6.8-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fdb512180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57d422b95aec4095
dashboard link: https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e3042e180000


