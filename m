Return-Path: <linux-kernel+bounces-98165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12198775EC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 10:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C66C1F221E6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372161EB25;
	Sun, 10 Mar 2024 09:16:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5F1BC49
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710062185; cv=none; b=l0DTGdjk2CkLTfH/LnoX600Nf0GSvcgtctH5dF2Q7aS2SkvxrvWD/tKAc9t1GxMdfo1VtsHoNMpmwjWevymwvUaTZPXBk+7bQwumkaqaXIYwIPIeKE3qVF+FaBds/50AZ6pjeBLbXCXXkADMSoLCa3kKT45Mudc5k2IprOJXQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710062185; c=relaxed/simple;
	bh=MlagqZPBrdWvUGmaWGdhxE6Ng+8nES7zjq8PZhu+dW0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=acC9EXE7l+blkbDKGS4KA/V0dBNtq6OkvYkXgfwEnlUjFzBKpzZ9ayZNDhuVULTOiuqzBmX/2Ov54fC8uprGqefU/IkXIwt8oFF4+NUAY4qae406fiHlfjXxb3TRsk1b2mDwIh4xUcLMP01fsFRLQ/xPM1XZydzszOV5I5MsIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso56606539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 01:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710062183; x=1710666983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zDRQjgkhxRVicgj40VR0YIXpagwtpa9TQqkcBjGwTE=;
        b=kaWvJdVMdd8ATWZWox2ox5whw+VRxz9fDusOpbkejuoAQXk4Hjty7i8wj68thCmfRb
         uJUt2PSYqHPMh02CFdyRg1oTrnqR0c94Islk82AT1Rbb4LR4YYePaQ5xD/WnV7A7pdDl
         08ojlfOXY92hI4CJfhPpAp3bN2vf2NgRdkBLxhxTZ0I3cWFMxe2/wrlwBv0k024AHP5H
         /vzogyotQrN+HnFadssT+hay+m+T35DbPgYSfE2UZXL7I4QOChsSis7+ruNi4or8/Jj1
         3lZBQ2ZHJ16ZpAfGhAKHffkr4P9NbruCJNGDHjBB6UsC2ZrLFlPPxBtxOPFPJ4ApiTEA
         Jg9g==
X-Forwarded-Encrypted: i=1; AJvYcCUBGZmlbUWIjXXJrOA7MKHM7hq2JJFagifFxYBOEea1cRNMgyDBFsv7qL8SSmiodiUrIXgCLxaD9tKmVgSULalA24CPpApF70PoPMex
X-Gm-Message-State: AOJu0YwG7wAJls6wZ25kItKFqJ+++nY+aCpQh8GSE95H19oWW5g5cMe2
	RXqwjx20ZGuML4+FVcEM2Jhlx+wFXGySpznvUyudl0z9lM5iZatFIFoZjoX72qrgQFogehFmyNI
	g7uzhlE7SplYn7DGwrU0Tz/uj0tA6rVbWbmjNShoepGVaafGzb8uL8D4=
X-Google-Smtp-Source: AGHT+IHHKgN8BmBXtWcmcpRxGbXFfnt/P3gNEMVRNNGsEyS+NN4qwWDDqY3mLY75SrShvLCcc1t4pjRetlQ/ZgalTKy0i1RsYaYD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218b:b0:476:e4c4:c80e with SMTP id
 s11-20020a056638218b00b00476e4c4c80emr25604jaj.6.1710062183319; Sun, 10 Mar
 2024 01:16:23 -0800 (PST)
Date: Sun, 10 Mar 2024 01:16:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb15d306134ae036@google.com>
Subject: [syzbot] [bpf?] [net?] KMSAN: uninit-value in bpf_prog_test_run_xdp
From: syzbot <syzbot+6856926fbb5e9b794e5c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3aaa8ce7a335 Merge tag 'mm-hotfixes-stable-2024-03-07-16-1..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e5861e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8d2f8f66e9a667a
dashboard link: https://syzkaller.appspot.com/bug?extid=6856926fbb5e9b794e5c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ed8171180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b728ae180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2a093f1b5a72/disk-3aaa8ce7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/efa5cb929ca6/vmlinux-3aaa8ce7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b0c044e721b/bzImage-3aaa8ce7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6856926fbb5e9b794e5c@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bpf_prog_test_run_xdp+0x1758/0x1a30 net/bpf/test_run.c:1277
 bpf_prog_test_run_xdp+0x1758/0x1a30 net/bpf/test_run.c:1277
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 bpf_test_run+0x515/0xaf0
 bpf_prog_test_run_xdp+0xea5/0x1a30 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 ___bpf_prog_run+0x76dd/0xdb80
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2227
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x42d/0xaf0 net/bpf/test_run.c:421
 bpf_prog_test_run_xdp+0xea5/0x1a30 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 ___bpf_prog_run+0x8567/0xdb80
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2227
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x42d/0xaf0 net/bpf/test_run.c:421
 bpf_prog_test_run_xdp+0xea5/0x1a30 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable stack created at:
 __bpf_prog_run512+0x45/0xe0 kernel/bpf/core.c:2227
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x42d/0xaf0 net/bpf/test_run.c:421

CPU: 0 PID: 5009 Comm: syz-executor369 Not tainted 6.8.0-rc7-syzkaller-00142-g3aaa8ce7a335 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

