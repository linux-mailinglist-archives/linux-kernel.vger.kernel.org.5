Return-Path: <linux-kernel+bounces-79910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4486288F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4231BB21623
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C917D800;
	Sun, 25 Feb 2024 00:21:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA49624
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708820464; cv=none; b=Ik9MXez+JxMyE2zYJw3XCBZViwYBPDbLbNrEyGSoYIoOnsvxyox5SVsFUseD5XedFYE5HvGrz6qVH1HsDjE0+MEJJg/t0Q7i97+O8HMV7TGuRNCsdgx+dG7oBGvN6X2xEa7+UCNXjRuLYmDY/ecXPaBf5k4NxMaq5C121hL6Bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708820464; c=relaxed/simple;
	bh=/cpdffst3ik3mfLxbRDWafSGmCPpkErnZC0a+1ckNPA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KVtwz+I/KHii8Q4Zsm2txdcbUcOoNAsRvbSEljmj9hhpPG9Ioi/HtUZowf5NA+FViwLNbv3N4N4rBua/D/1IkZH6SVaqXhOZz0MM5mBzR0SWNnVQ9HPlQk1qQ6OoTaAqcCwCPgLaGnidp0E/xrNb84orR9EJUa+xaFzsoSOd1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c4a0dc9f57so240038139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 16:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708820462; x=1709425262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x904ySXw9Y+j29YCKlCYb2ijUV2+X4dXrehSnwEUd28=;
        b=E4QifouPaghkH2/sTyIPackjWeO+1gRXwQDwj+F+gLfKDRh8TJcSyDDSrj+NNsY8hh
         nMkwvhpdcnsdpbkALxELQ2a5+WA56VUwpX6NfecHHUvKLxd6OzHth6lrW5fdPZN5B17W
         xQRito4UiBJR7GZecK60/EbuDagppBPJYxay116sIpVUjrAPwT56QPoe2RMuyJFYn5X5
         wx89JpmFMH/Xug9TQm+8URsNilfQ+XWrb7XtidtJnYUW0C1pZG1XmNTh+dJ4JSLqpMLJ
         yuqGZtNlY2yhZKWeHAy1Fxn7FHANCBTVu4jD+/7TYR1bEAJ4RC91LvRF3a6P9Brl6TRp
         GEVA==
X-Gm-Message-State: AOJu0Yxkcm7e9wrlUL8HOjjcGjtX9tdYnS4JruQJ7RANqpPfVWjcv1K/
	HKLNbRPY9lCx+qbWBv3huaFfUXJOePx+icbIo0ei6kUA88lxOhuqS4GlcDoODW1y2bpTT13dUGl
	Bdh06HjDwfk1n1i/AjHBPzGIh4/mBGzklqfexRFWbCWc5CrBTZsnhOt2S5Q==
X-Google-Smtp-Source: AGHT+IG6Mtgw4wYZxfC8uS1X9rpefletXdQlAtArOm+QE3tN89wQkj5DqUKLcznp1TM6Dt3obkPbn9IXWOhZWoGiPVs0qy+JNy2r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218d:b0:474:7f73:994b with SMTP id
 s13-20020a056638218d00b004747f73994bmr7363jaj.5.1708820462066; Sat, 24 Feb
 2024 16:21:02 -0800 (PST)
Date: Sat, 24 Feb 2024 16:21:02 -0800
In-Reply-To: <b912d540-d689-4c6b-af4b-7c6fbc0f263d@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0639f061229c460@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
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
 virtscsi_add_cmd+0x838/0xad0 drivers/scsi/virtio_scsi.c:501
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

Bytes 0-4095 of 4096 are uninitialized
Memory access of size 4096 starts at ffff888037212000

CPU: 1 PID: 51 Comm: kworker/1:1H Not tainted 6.7.0-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: kblockd blk_mq_run_work_fn
=====================================================


Tested on:

commit:         0dd3ee31 Linux 6.7
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.7
console output: https://syzkaller.appspot.com/x/log.txt?x=1462a106180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=373206b1ae2fe3d4
dashboard link: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1455d9d8180000


