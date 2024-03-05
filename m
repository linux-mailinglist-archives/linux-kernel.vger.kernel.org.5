Return-Path: <linux-kernel+bounces-92210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCA9871CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF86A1C22C94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07EE5822C;
	Tue,  5 Mar 2024 11:04:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3055E58
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636646; cv=none; b=ujoClrNbmg/TRS88ftV1sLS3irSCdN+5A3xc1SLfKg/5ThKQIL4n6AUjyNrHn1r3uvNOB8JR9Cyge89I/tJFGI2kizJ3L0aEMtDKQMobbQCOyVFMq4F3Sx9rsPGCQoR6nH7lAQ2t+66qTx3d0X4lG/qFgaX4TVkZ1Jsw3HqQWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636646; c=relaxed/simple;
	bh=RThZHMySOiz8w1V29Xt3gTRou2ASCksR01yIEmartbs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l3cbe6GZOC6XBYMhhQx/7HrOSQ8YJue9wzTAAtE6eyFqpTYPc0s0lHwsGEETP/q0pTxyUvtavHnWA1sPK3YFWfa6Z5RBDZ7EhCfJpDB62k1lTjqU6DFn31DsRbgJLTzfAb8WZij5UFAEO8eo3tqWSj7qEC3YzveUt+9LFPyxhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7857e6cb8so734934639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636644; x=1710241444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czbnCHU202cwLCNNc2Qhgv3x5O0cQlwUUB5S6dG8XCc=;
        b=g4/iK0UMg7EnuamU+kKrbYutZ16cfMVhLUqb7N5+zptRbK/CglxXATKoA2U44Ta1aI
         qlMVz6tPolqKRGs7wEkQG3i17afh0UnuqdZXWbxtWHLXe/cX+2pu+sGp62sVqmjL9Yy7
         bCQKC8SNU1UyCLfVTSF9lOKfsEeNe7YGltDE4kNy31Mf1cPsopMLxzNtQ4f7cZzsyRF6
         uJkCCo87Dsj6A1AH/Pt0lC4AlvdYq/ftF4tKi/Es/T56l+ExMqjEqvJNVdajQqpjt730
         5PbqFACclWj5oA/SI/okynLWUWV5iKprZlqkLJyzUi8iRS1JLmUbq9GfWXT0zwAmZhO/
         2fPQ==
X-Gm-Message-State: AOJu0YxYULEWj5L+ZJpijm33Br+exsUROohRDki8euci5h/PGri/H3CS
	a1YRe8JaSQVZqTbLTQ3iXsGM1z6+40+9+rc5XfDKbi2ez5gRdqwWCH74hoY0ZgFZobzy41ZdjMy
	MWuM9HbLcalJbQ9KmehOWiWrqtSmmrafI+hpv+UMF14kwEjLx7TeQfYvdtw==
X-Google-Smtp-Source: AGHT+IEuZUZmiEchiydOXb9eysFJuudSyNP1Cf9z55wRtSRC9Dhl5Qq9fzFk4g5upMWnGsKXnMpBN6X5ksR2ZRZy8FR7Rxmaxo3V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15cd:b0:7c8:440b:30c0 with SMTP id
 f13-20020a05660215cd00b007c8440b30c0mr133512iow.0.1709636643929; Tue, 05 Mar
 2024 03:04:03 -0800 (PST)
Date: Tue, 05 Mar 2024 03:04:03 -0800
In-Reply-To: <aeb26d27-cd0f-4992-b303-f21abeacab21@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db4e330612e7ccde@google.com>
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
CPU: 0 PID: 3920 Comm: syz-executor.0 Not tainted 6.8.0-rc7-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at usercopy_abort+0x98/0x9c mm/usercopy.c:102
LR is at __wake_up_klogd.part.0+0x7c/0xac kernel/printk/printk.c:3899
pc : [<8183e740>]    lr : [<802b7f34>]    psr: 60000013
sp : df9e9e50  ip : df9e9d98  fp : df9e9e74
r10: 0000001a  r9 : 840c9800  r8 : 83735450
r7 : dde752c0  r6 : 00000000  r5 : 0000008c  r4 : 00000050
r3 : 840c9800  r2 : 00000000  r1 : 00000000  r0 : 00000066
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 84841ec0  DAC: fffffffd
Register r0 information: non-paged memory
Register r1 information: NULL pointer
Register r2 information: NULL pointer
Register r3 information: slab task_struct start 840c9800 pointer offset 0 size 3072
Register r4 information: non-paged memory
Register r5 information: non-paged memory
Register r6 information: NULL pointer
Register r7 information: non-slab/vmalloc memory
Register r8 information: slab task_struct start 83735400 pointer offset 80 size 3072
Register r9 information: slab task_struct start 840c9800 pointer offset 0 size 3072
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xdf9e8000 allocated at kernel_clone+0xac/0x3c8 kernel/fork.c:2902
Register r12 information: 2-page vmalloc region starting at 0xdf9e8000 allocated at kernel_clone+0xac/0x3c8 kernel/fork.c:2902
Process syz-executor.0 (pid: 3920, stack limit = 0xdf9e8000)
Stack: (0xdf9e9e50 to 0xdf9ea000)
9e40:                                     81fda684 81fadca8 81fc2424 00000050
9e60: 0000008c 840c9800 df9e9ea4 df9e9e78 804a922c 8183e6b4 0000008c df9e9e88
9e80: 80216278 83735450 0000008c 00000000 837354dc dde752c0 df9e9edc df9e9ea8
9ea0: 804e1c20 804a9160 0000008c 00000001 df9e9ecc 83735450 0000008c 00000001
9ec0: 00000000 00000000 840c9800 0000001a df9e9ef4 df9e9ee0 8020a090 804e1a40
9ee0: 00000000 0000000c df9e9f6c df9e9ef8 8020a680 8020a01c 00000000 00000000
9f00: df9e9f1c df9e9f10 81862d34 802798b0 df9e9f6c df9e9f20 8027f524 81862d10
9f20: df9e9f54 00000000 8027b25c 60000013 818110f0 81827f88 df9e9f54 553a7b00
9f40: 0000000f 83735400 0000000f 553a7b00 83735400 0000000f 00000001 00000000
9f60: df9e9fa4 df9e9f70 80253494 8020a398 8020301c 553a7b00 df9e9fac 00000000
9f80: 00000000 0014c2cc 0000001a 80200288 840c9800 0000001a 00000000 df9e9fa8
9fa0: 80200060 80253268 00000000 00000000 0000000f 00000004 00000001 00000000
9fc0: 00000000 00000000 0014c2cc 0000001a 7e859326 7e859327 003d0f00 76bd60fc
9fe0: 76bd5f08 76bd5ef8 000167e8 00050bd0 60000010 0000000f 00000000 00000000
Backtrace: 
[<8183e6a8>] (usercopy_abort) from [<804a922c>] (__check_heap_object+0xd8/0xf4 mm/slub.c:5386)
[<804a9154>] (__check_heap_object) from [<804e1c20>] (check_heap_object mm/usercopy.c:196 [inline])
[<804a9154>] (__check_heap_object) from [<804e1c20>] (__check_object_size mm/usercopy.c:251 [inline])
[<804a9154>] (__check_heap_object) from [<804e1c20>] (__check_object_size+0x1ec/0x30c mm/usercopy.c:213)
 r8:dde752c0 r7:837354dc r6:00000000 r5:0000008c r4:83735450
[<804e1a34>] (__check_object_size) from [<8020a090>] (check_object_size include/linux/thread_info.h:215 [inline])
[<804e1a34>] (__check_object_size) from [<8020a090>] (__copy_from_user include/linux/uaccess.h:101 [inline])
[<804e1a34>] (__check_object_size) from [<8020a090>] (user_regset_copyin include/linux/regset.h:268 [inline])
[<804e1a34>] (__check_object_size) from [<8020a090>] (fpa_set+0x80/0xa0 arch/arm/kernel/ptrace.c:589)
 r10:0000001a r9:840c9800 r8:00000000 r7:00000000 r6:00000001 r5:0000008c
 r4:83735450
[<8020a010>] (fpa_set) from [<8020a680>] (copy_regset_from_user include/linux/regset.h:337 [inline])
[<8020a010>] (fpa_set) from [<8020a680>] (arch_ptrace+0x2f4/0x3e4 arch/arm/kernel/ptrace.c:764)
 r5:0000000c r4:00000000
[<8020a38c>] (arch_ptrace) from [<80253494>] (__do_sys_ptrace kernel/ptrace.c:1288 [inline])
[<8020a38c>] (arch_ptrace) from [<80253494>] (sys_ptrace+0x238/0x4dc kernel/ptrace.c:1261)
 r7:00000000 r6:00000001 r5:0000000f r4:83735400
[<8025325c>] (sys_ptrace) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdf9e9fa8 to 0xdf9e9ff0)
9fa0:                   00000000 00000000 0000000f 00000004 00000001 00000000
9fc0: 00000000 00000000 0014c2cc 0000001a 7e859326 7e859327 003d0f00 76bd60fc
9fe0: 76bd5f08 76bd5ef8 000167e8 00050bd0
 r10:0000001a r9:840c9800 r8:80200288 r7:0000001a r6:0014c2cc r5:00000000
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
console output: https://syzkaller.appspot.com/x/log.txt?x=132bc62a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57d422b95aec4095
dashboard link: https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e46dbc180000


