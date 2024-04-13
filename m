Return-Path: <linux-kernel+bounces-143524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F078A3A80
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC28B21978
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B124A168DA;
	Sat, 13 Apr 2024 02:27:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640D8C1A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712975247; cv=none; b=vBnXck79PjD50RiNF57dQjWE5KubpXzBDgYnF1c/v4OleQO6URwutYHQAkZ/Zt1BDdwtL8jtkctj/ZOW0UtcWXase4OiQiGLaS9l+dO1odlBPVZ8ederfyFoIcJBQR6P6efWdAfVFEAsJ4t/fHhJ+P91i50gKBa+YRUR0VrRj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712975247; c=relaxed/simple;
	bh=VlwQ4wR3c+gOVAmJlO2LaFAC69KfefrN/1KxDxizliU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F1LgWzXaEWpXQdNfkd82SYeUeIqBYoyylInPhhlEK09ZW906B9pPxg/7e6Rl7hxjaWjfzcMSooCTQepHPHVUrHxx7A8EPXHA6/mtJCiVKc4UlMUJHFQmNJRvDYJ0ErctSx7l5FhG8vd+L/lEu4EcrL4aJc7JKrKyHE2NAeKvIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5efba3f8fso175954739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712975245; x=1713580045;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGpFiZMoct/gTKw486CudPM82VeVmjUMnBJvMxioOug=;
        b=AL2G1RL4x/8sDp2mLuzu3gpv1q4B9jNcJP7eYZX/TAQ5giepkwUUgFpfmHFIDdw4tz
         JB6iGeLOeS4Cr0Kc85mCQqrCI+pMyAKuP+GyNV8v3BogmJBNQU9xcyUjXYxENJRDWXag
         dSRqJjcrkl+jn+tpd24/lDAhsYmPtvQ/GCm6n+ks1cxi4Vv1vIiYBHqog2v2D+bL6pJ4
         slBRRYTOwipiQ9C1R0TgGt/BZmYUgJtub3OWtLldZkMzYKA/F2IqpItTMeAz/+kjcQlY
         QldODa/9X2JC2jm7wBEb4rJbY3EFXfOFKlFxpBE/pLv4HmLXX7+hPIpet7HHiidL0JvB
         XAHA==
X-Forwarded-Encrypted: i=1; AJvYcCUQP7OCEhx6JXHd6lEEuR0EBsRUQyUUZkFESzzSAy8pNCdjZb6E4qANxSzfm9k/36pISyyboUlUdtOGRFLqZoYbifpjdGqV5qHekd/H
X-Gm-Message-State: AOJu0Yx5qlvPOUG87MOxskoeY5decYet/DFCEktTEMdMUb87LWOZAbUX
	44lqgeJaTzu+bOzQmO8dLr4NJi7ESpwKsuZlaseBPphkxyQI4u68JH6jdp1vf5T2l8UK+VML5A5
	ECQaGSp8IPJEoGYilE34f8JMmNNwfYk/+p+IRmIl09v/4s8X2quMRCFU=
X-Google-Smtp-Source: AGHT+IHfcl5Kh+4PDWY92bV+Hcoj+JIhrgUf7vFKqM4wkeIxu9S/k/ExVOpCoENytMxVuej6SRqool+l6LT95MstiEbIWqKYC9kf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2494:b0:47c:6d4:3e57 with SMTP id
 x20-20020a056638249400b0047c06d43e57mr137698jat.0.1712975245105; Fri, 12 Apr
 2024 19:27:25 -0700 (PDT)
Date: Fri, 12 Apr 2024 19:27:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe696d0615f120bb@google.com>
Subject: [syzbot] [mm?] KMSAN: kernel-infoleak in bpf_probe_write_user
From: syzbot <syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fec50db7033e Linux 6.9-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16509ba1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13e7da432565d94c
dashboard link: https://syzkaller.appspot.com/bug?extid=79102ed905e5b2dc0fc3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a4af9d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12980f9d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/901017b36ccc/disk-fec50db7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16bfcf5618d3/vmlinux-fec50db7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc9c5a1e7d02/bzImage-fec50db7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in __copy_to_user_inatomic include/linux/uaccess.h:125 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_nofault+0x129/0x1f0 mm/maccess.c:149
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 __copy_to_user_inatomic include/linux/uaccess.h:125 [inline]
 copy_to_user_nofault+0x129/0x1f0 mm/maccess.c:149
 ____bpf_probe_write_user kernel/trace/bpf_trace.c:349 [inline]
 bpf_probe_write_user+0x104/0x180 kernel/trace/bpf_trace.c:327
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x6a5/0xa30 mm/slub.c:4377
 vfs_writev+0x12bf/0x1450 fs/read_write.c:978
 do_writev+0x251/0x5c0 fs/read_write.c:1018
 __do_sys_writev fs/read_write.c:1091 [inline]
 __se_sys_writev fs/read_write.c:1088 [inline]
 __x64_sys_writev+0x98/0xe0 fs/read_write.c:1088
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Local variable stack created at:
 __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

Bytes 0-7 of 8 are uninitialized
Memory access of size 8 starts at ffff888121ec7ae8
Data copied to user address 00000000ffffffff

CPU: 1 PID: 4779 Comm: dhcpcd Not tainted 6.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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

