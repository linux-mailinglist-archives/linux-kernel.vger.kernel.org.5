Return-Path: <linux-kernel+bounces-79913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD96C86289D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659A6281EAF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507051373;
	Sun, 25 Feb 2024 00:52:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6BECF
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708822324; cv=none; b=mKVTcp5A1phBHGKkqw1ywzS99W8ScRyMFXT397oIE1f+uheEcox+G2Nhe5jAFoRb2rT3n0ARXR5KemYAO6njvoAhdpzMy3+ifyH5puTzJK3U0SYfuyUfChMHVskYwWskbV2WdrevxwQAsAD31+rcrTNILCSjNmdQtTzzxTH06Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708822324; c=relaxed/simple;
	bh=Hnz9DMUUkvindQlq7OfX4oKTLu+KKha/b9iXxBjsnvI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A8aQk5QRdYRHPEh+HeyG2euTrY6aWd1eg6mCV2ZUSffPyIvO1kDEPyvTrSairjdVufI6oP+YsWNOrHdyoMJGy9FjDTdj+5pgxx0E4Z3mXAsUdx8Z/ta0mcagurCPi4V+VZtALqoIyAfzHuInFMucc/Y4YsVYr2HWTVSD7AOPv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36424431577so20075765ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 16:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708822322; x=1709427122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXzS3AK265ORyYYmNaEjSVuKNNUyBRwv7amjCl792uE=;
        b=LWGWImkMx4vQIWgHkAlKi/wQ7PZC/lInb9HENFmbCAlbUN+LV54Fm9HsPrjv19ktIv
         h7+s1uFsMBJ7nhKUk6Fg+8jJmikhh4Hz+Emc2KvymNyB3VEiYvcnUZg20NJXjruGcoid
         2dN8sc5k6Ir8iF169hIO556j2SeDjnCufe8+gHdpiuHNbtDH2wB/hoK8Urr6EeOM/XqT
         q0Y+YsBapL34GfFeX85bAIa8W54Pntg2TPd83CzoVXOuO7zX/S0Dji/nlIpxWKWRR5vz
         qXY3FILfCxThxjYnXyzqnJa3Sg2wOcVfaN0qPrcFX9MdKgBW1IKwlUkrZZMwNxKT4TH9
         BzDw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ5wYnb9iV+/dw+iUfboG+GfFHEeeTmmiQHZqms3hoC1HICMSfZq8tUjEgYMZPZE0xPEZecbZ3824wi9MNFib+eXkbrphCd6JeH5wq
X-Gm-Message-State: AOJu0YzxodubI1BRBxqr5t14Md07FJyq9yu9HD7ygAITjZ1VsHWAJqx+
	r+lvN2gy0g4X6csfllB6dJIMiK2Vhkl88Pi6I5EpQsZq0Bq6/zJKZa9LTvfS1qcpxiXfgAeJ6E8
	t1OCj0hHnJV7dApuClQPLmxn3+TfM1PEO6eA4nTTyVZTQyie4GYl4myY=
X-Google-Smtp-Source: AGHT+IGRA246eEQR+BdalWbRGyq/2ZMYmg6/DldD6CwxiHhCrwWSQIWPK3/9yIIhyajGLT2KBle/ous5VmXYVLTuTzImdT4wtZkh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0a:b0:365:1c10:9ce2 with SMTP id
 s10-20020a056e021a0a00b003651c109ce2mr188048ild.2.1708822322533; Sat, 24 Feb
 2024 16:52:02 -0800 (PST)
Date: Sat, 24 Feb 2024 16:52:02 -0800
In-Reply-To: <tencent_651B062576BAD9BBBE336A9E551B294BF608@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084dd6f06122a33c5@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in virtqueue_add

=====================================================
BUG: KMSAN: uninit-value in vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
BUG: KMSAN: uninit-value in virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
BUG: KMSAN: uninit-value in virtqueue_add+0x21c6/0x6530 drivers/virtio/virtio_ring.c:2210
 vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
 virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
 virtqueue_add+0x21c6/0x6530 drivers/virtio/virtio_ring.c:2210
 virtqueue_add_sgs+0x186/0x1a0 drivers/virtio/virtio_ring.c:2244
 __virtscsi_add_cmd drivers/scsi/virtio_scsi.c:467 [inline]
 virtscsi_add_cmd+0x817/0xa90 drivers/scsi/virtio_scsi.c:501
 virtscsi_queuecommand+0x896/0xa60 drivers/scsi/virtio_scsi.c:598
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1516 [inline]
 scsi_queue_rq+0x4874/0x5790 drivers/scsi/scsi_lib.c:1758
 blk_mq_dispatch_rq_list+0x13f8/0x3600 block/blk-mq.c:2049
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0x10af/0x2500 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0x160/0x2d0 block/blk-mq-sched.c:333
 blk_mq_run_work_fn+0xd0/0x280 block/blk-mq.c:2434
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 __filemap_get_folio+0xa5a/0x1760 mm/filemap.c:1918
 ext4_da_write_begin+0x7f8/0xec0 fs/ext4/inode.c:2891
 generic_perform_write+0x3f5/0xc40 mm/filemap.c:3927
 ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
 ext4_file_write_iter+0x20f/0x3460
 __kernel_write_iter+0x329/0x930 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x593/0xcd0 fs/coredump.c:915
 elf_core_dump+0x528d/0x5a40 fs/binfmt_elf.c:2077
 do_coredump+0x32c9/0x4920 fs/coredump.c:764
 get_signal+0x2185/0x2d10 kernel/signal.c:2890
 arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0xd/0x30 kernel/entry/common.c:309
 irqentry_exit+0x16/0x40 kernel/entry/common.c:412
 exc_page_fault+0x246/0x6f0 arch/x86/mm/fault.c:1566
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:570

Bytes 0-1023 of 1024 are uninitialized
Memory access of size 1024 starts at ffff88801e7d9c00

CPU: 0 PID: 52 Comm: kworker/0:1H Not tainted 6.7.0-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: kblockd blk_mq_run_work_fn
=====================================================


Tested on:

commit:         0dd3ee31 Linux 6.7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.7
console output: https://syzkaller.appspot.com/x/log.txt?x=15dee522180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=373206b1ae2fe3d4
dashboard link: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1524ca02180000


