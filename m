Return-Path: <linux-kernel+bounces-108589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1305D880CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65A11F213BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8AD2C68A;
	Wed, 20 Mar 2024 08:02:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF111181
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921725; cv=none; b=sLNXuJ+nfPGpNpmSvJlwZ7SLpByBlrkl9egjy7fzwifU/xGkK5yN676P5GuqhYSsbLaHuNWkKY0BFu35xR7ac8quQx80YvIm6bPFZCM91QQwgIcqsmSs9Dp81rOa1QmlqAcPSjNh0HajjVf6xrHpempJdjssBgRD6CC019sTiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921725; c=relaxed/simple;
	bh=FxKCY4s/W6RhBh8EB1c3AXT+49U1UdjMORkFQ5eHvW4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hJHKBd+7UQDBEMihEokbG2peaDInMgbS+OvMCjMIyqQhYvmmG7TFWNAB0r4Ph+8O4mULbSuifTrbDuDslN1/p7OLYWNsu4qIV+6q2QxjjlPqVhtRszPYCu84YSJ71fvhh4kNw+3E3Dy+918mARDYDI44yj3mNmsnUiAoe+1nu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36854f4e9b3so5147685ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710921723; x=1711526523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZryK2M/d5ViFlT3YE/LNIF2qPsWg9M+/iJ+gGJOEUgQ=;
        b=eBMXPJ46tS91Ox6QRTXnns1NnwJ7Purt0H6QC0sXvkiKxq4GkoWILSEF9D8p51Q45a
         vOuAex0dY4CD9FCxQbCA5kAkAR7pJXt86TGXHdiuiAM7ltKWLkowApLyEJ5zLLVn1XNH
         UNHmKyvGwn077o2yyYQy1CSl9LYDyKfKsY6Mwxtew8Ab1HTmRuhsd8i+DRbsE/tRiiN4
         egF+FcZ6wIil5DNsMi9pU0dwzRei9W4k3lLqwz3hEAtDYHc1XbFaIyZoCGb4SIcp5EST
         aM0bIEMZYZ3dQt/dqhwJxOOqqZwBA0xJNq+JXin7x7gvccTLzycN7nEwoinEXWiHm2Km
         GHkg==
X-Forwarded-Encrypted: i=1; AJvYcCU6jEfLwVrpFi/IFlQ9WygY7M90sDWHRENPjJSDxAQhMTPZAuT++/0tDBt3yziWxyyrL6UvlVGEDvMjBwrLrink7GY+1OHQwi2RPXS3
X-Gm-Message-State: AOJu0YxnG43c8QgmlyFYUqG9jcTiqO/n9FuyB6iJXFvaWd0TGaRLoZsq
	dzeAt1FAFAxAKL4ljhCdwMqGTaa267srzgLoRzBiEeSLV8yKlm5VsAiUkNewBE1NDrbZrbmdUXI
	9ho+SD1VKIDpPIaQRzVO+RH/S7n5YyMgjq87nNKV921e068ekIsOtJXE=
X-Google-Smtp-Source: AGHT+IFq9OweNJwLdUtGBz0GkaFuGnKTaPbVmFqYZ8dQT/jkVzHLImUXRnF/Fn/PglFFDbve7uitvNLB7C7hqrbJZSRtzBJnMej3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:366:be6a:10b7 with SMTP id
 i8-20020a056e02152800b00366be6a10b7mr366927ilu.2.1710921723377; Wed, 20 Mar
 2024 01:02:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 01:02:03 -0700
In-Reply-To: <tencent_79DD6EEACCA727D846F212CE8679C998EE06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f8e88061413011f@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
From: syzbot <syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in check_stack_range_initialized

mio: -8, mao: -8, as: -2147483647, check_stack_range_initialized
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in kernel/bpf/verifier.c:7193:12
index -1 is out of range for type 'u8[8]' (aka 'unsigned char[8]')
CPU: 0 PID: 5496 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-05230-g114b5b3b4bde-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:415
 check_stack_range_initialized+0x13d8/0x1630 kernel/bpf/verifier.c:7193
 check_helper_mem_access+0x2eb/0xfa0 kernel/bpf/verifier.c:7297
 check_helper_call+0x263c/0x7220 kernel/bpf/verifier.c:10255
 do_check+0x9e29/0x10530 kernel/bpf/verifier.c:17804
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20503
 do_check_main kernel/bpf/verifier.c:20594 [inline]
 bpf_check+0x136ab/0x19010 kernel/bpf/verifier.c:21264
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fb440a7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb4417ef0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fb440babf80 RCX: 00007fb440a7dda9
RDX: 0000000000000090 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007fb440aca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb440babf80 R15: 00007ffc0626c2f8
 </TASK>
---[ end trace ]---


Tested on:

commit:         114b5b3b bpf, arm64: fix bug in BPF_LDX_MEMSX
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14084006180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=33f4297b5f927648741a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c4aa31180000


