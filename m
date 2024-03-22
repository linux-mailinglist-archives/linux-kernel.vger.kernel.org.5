Return-Path: <linux-kernel+bounces-111112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190588680C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D43B2431C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F589171C7;
	Fri, 22 Mar 2024 08:15:22 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5F16430
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095321; cv=none; b=Y2PsobN+gTFI7P2hiPTS5k+oQYi3geMWG4MQfKEi907BKrqDbF+c9vi9FJ3A07ITQ7EsTEtg/ZNGv9msmUyigR5PgVYfJ7OPrrnnO8szq2+BwXAzk8Vtu9+V3xP8m17UaNoMDXWV+HLu2a6ScU3/Z4ooHdM32U+xMDfebvuHu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095321; c=relaxed/simple;
	bh=zEJRCXQMJrexeVyZDo3UsdLYmEP+3BSVvkrhLEY/9v4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X5I3jpaMBIZspPeCUhnRfNHvbyMbPrbh8asez+8GaqIbd8Lq6l5F8pB7IRDx9hitC+VaWtlaEjwcPSPLs21WnBnWXrA4uxA1A6M4u31HAWQ68xCV14LBNMQmV+SIk486tPR9SQqjKi71KRoOx7TKbRgoq73vzGtdizpchDIjzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc74ea9c20so201854239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095319; x=1711700119;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aWJSyEOucukvV5Qf1uWpHLKKRLA5O8DS/TmbM+yScg=;
        b=jY2yI4HPh9AEdCIHQ9dBAcukhgKerDqlRjKzDHyOfLhEcdyaeu2HvdPEIJuK3CCOhf
         isbktFd5TsSrrqHOF07vm9O8ObTV0q3+uuwsj/q/NWgNh7cC6uQdvHWOqIxMq4UyFDYq
         0nOM+PZ6D/NfsjjfmFTa/ETU4WRXVKWXcPz60uFhn3VOwzZgu0tZONk7Y25b7w0Ha7n/
         Ck++mBSHhZjkkSMfOvHmcg1Dk0l+vVuopnAqVPNDyxbY0u3XbqBizsWlLoqsBKUK7wRr
         yR4plXf7m80DxH9mfj1YfNlYqfr2Z+rhU/CDyhfmRur5gM7TQHXWmfwjZ+V1uhtHa5eh
         LrnA==
X-Forwarded-Encrypted: i=1; AJvYcCWCJkFcJBamSaGB3Z7mK5FNyxdJkGsz9tDsJTxaIFv0tOFe8odfDyNf0wwdsMPKyFtJXS3yhSmhMXx892Ykem6Ra3YA6jF+ac/+apiR
X-Gm-Message-State: AOJu0Yz8AaP0rEWS4r/o4xd9HCovRIwzRRY0G+O/TCNpJrpBz8+NB1pS
	K29XUSuAri3+6S+RYksDNyI74K0CwcewYHRDOKqaq4yScvy/9rxlSCzxIkonS/Ydh3z1hruQQXZ
	x2M9CmlffUQQJr6kPheFdSQKaV1KLd/lUKCOUa4zcq/3b7kuIKIgki/0=
X-Google-Smtp-Source: AGHT+IFsSokGGYA6K3Jne8d14Hss18r69bdunOuieJOJ9OKWKJ+Rtj8kkCz2gsS3iAJb8+3IvoNpF9SzU+UR5xjqPd3R8b5GQ7Wt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1687:b0:7cc:202:7dc6 with SMTP id
 s7-20020a056602168700b007cc02027dc6mr11655iow.4.1711095319119; Fri, 22 Mar
 2024 01:15:19 -0700 (PDT)
Date: Fri, 22 Mar 2024 01:15:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac56fb06143b6cfa@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in array_map_lookup_elem
From: syzbot <syzbot+b4e65ca24fd4d0c734c3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f6cef5f8c37f Merge tag 'i3c/for-6.9' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1702fac9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d08e4cfe8c38e605
dashboard link: https://syzkaller.appspot.com/bug?extid=b4e65ca24fd4d0c734c3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13db8006180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10851d66180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2b1f746f4d37/disk-f6cef5f8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4d67da10f1c/vmlinux-f6cef5f8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df127986ea2a/bzImage-f6cef5f8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4e65ca24fd4d0c734c3@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in array_map_lookup_elem+0x14d/0x170 kernel/bpf/arraymap.c:168
 array_map_lookup_elem+0x14d/0x170 kernel/bpf/arraymap.c:168
 ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
 bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x132/0x320 kernel/trace/bpf_trace.c:2421
 __bpf_trace_ext4_es_insert_delayed_block+0x34/0x50 include/trace/events/ext4.h:2481
 trace_ext4_es_insert_delayed_block include/trace/events/ext4.h:2481 [inline]
 ext4_es_insert_delayed_block+0x11e1/0x1290 fs/ext4/extents_status.c:2082
 ext4_insert_delayed_block fs/ext4/inode.c:1676 [inline]
 ext4_da_map_blocks fs/ext4/inode.c:1777 [inline]
 ext4_da_get_block_prep+0x1714/0x1d30 fs/ext4/inode.c:1817
 ext4_block_write_begin+0x749/0x1df0 fs/ext4/inode.c:1055
 ext4_da_write_begin+0x889/0xec0 fs/ext4/inode.c:2894
 generic_perform_write+0x400/0xc60 mm/filemap.c:3974
 ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
 ext4_file_write_iter+0x208/0x3450
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Local variable stack created at:
 __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x132/0x320 kernel/trace/bpf_trace.c:2421

CPU: 0 PID: 5016 Comm: syz-executor308 Not tainted 6.8.0-syzkaller-11409-gf6cef5f8c37f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
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

