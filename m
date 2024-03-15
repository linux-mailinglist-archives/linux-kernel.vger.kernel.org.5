Return-Path: <linux-kernel+bounces-104461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB13B87CE34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41FC2B2236D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754982C1B1;
	Fri, 15 Mar 2024 13:44:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858601C291
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510247; cv=none; b=is2iZgJ3CSCvoWYPffmelVKtwnWCWnJ+eO4Du4lc8xT+KuznKR92oaYTH2yVOULvhvwvmI3BzId4EKdxp1uPxKgijkAgRvrIVtjEzeO/Axm3mUXjy/mzzKfexXzP82MdH6yuEWTuCU3IpRYLe0BiFSmhkoGhlYVPN3KHmcNX/y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510247; c=relaxed/simple;
	bh=u0o1fC9Jqke12BvRiDhpx3aBSAjMdGe4vOfB9+oTwwY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gGwQvIVq4RNQoGcMD4MgOvQ4vGWf8xp6dUeE+bkH5HxWxKrMyAFm4xCLMbIycyw5z4ZbI+V9KMpzhLT3JwfWs5RDfvXfCbVJCKmoJOoBZ36t06e38BslV76dvBhebHlvDSB6MZ9Rr3I7xX0GQuV4ue21dVX1rNQdNXEvarbBxaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso16556239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710510244; x=1711115044;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QczE6LvN7/njsf2yX6ATYItKEIdc6vPdyj8FAEeuigk=;
        b=h1zVcin7aWtn2+HUXO3qd2gyID/h8ygGnnG4n9Sk+PJgrA4abBFbrkfJkWHKzQ2kR1
         uWBTjf/TEjjafKZmvRcPAvCU0Z+gQBhynxBPpyPk/AYo3gcS6zrr33QXTS6/0y/RWttL
         xL4tJzNfW0MOfsDvC8YOVUCAiQtGmd/pTgHXvJ2ysPahz0VPTg6X4UDTjQYeGVXzruUU
         MDLIKyO4JQchTNfzgzNGd0jmMLms4lHCc/g+Jr1tY9zE3ydZqeP0TptbjOiAH88Yu7/0
         gnhWbNUhcfif57ayj6NAvjGKAqeFQX8JC3YeZ92iK5QUpRIWqTPQclgtSBKlxADWBaLR
         dFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHOw5CzLiKPT8JTtSLwAHt5brGNagXlOmA2g9VKtkzEyVHxzXKpwwTr/ryzhVa8PX1RTERqW5MJC8scKKBvpxuj+nVaaMO4g1+Vio1
X-Gm-Message-State: AOJu0YzWLyeEG9vE0JVbbo9XtQOnsXmJeV7gyBdYR6YWEap0RpN1EpVc
	pj1nGKn+nSW8LRxaCDUva67MIR8dZ07jviMlno2N9wuK/NtJxwjoI5/KSB+qmD/zsfZdShL2xiD
	dljAVUPTOmwGp8lqpAWbhulcdXQGwOOG7xUE/wLjB7qK9hS1mpAxqhHE=
X-Google-Smtp-Source: AGHT+IFTQtuzHQxJ+n7C2Lso83Yc2O1lFWNpsS2J8moA7aLa8vlgYu4lkWnV4WNTW8xLy2YC8Jn/a6nf4k+gnDrZqug936BNuCYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3709:b0:476:f2cb:8790 with SMTP id
 k9-20020a056638370900b00476f2cb8790mr276289jav.0.1710510244795; Fri, 15 Mar
 2024 06:44:04 -0700 (PDT)
Date: Fri, 15 Mar 2024 06:44:04 -0700
In-Reply-To: <20240315131314.2471-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086a5090613b33379@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
From: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ew interface driver port100
[    7.632420][    T1] usbcore: registered new interface driver nfcmrvl
[    7.642406][    T1] Loading iSCSI transport class v2.0-870.
[    7.663982][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.675394][    T1] ------------[ cut here ]------------
[    7.677077][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.678472][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.680768][    T1] Modules linked in:
[    7.681721][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-09791-ge5eb28f6d1af-dirty #0
[    7.683377][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    7.685668][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.686689][    T1] Code: b2 00 00 00 e8 27 5a f7 fc 5b 5d c3 cc cc cc c=
c e8 1b 5a f7 fc c6 05 f6 81 d3 0a 01 90 48 c7 c7 e0 a7 fd 8b e8 47 2e ba f=
c 90 <0f> 0b 90 90 eb d9 e8 fb 59 f7 fc c6 05 d3 81 d3 0a 01 90 48 c7 c7
[    7.690923][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.692584][    T1] RAX: 2fe2bb6c454da900 RBX: ffff888140b1401c RCX: fff=
f8880166c8000
[    7.693870][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.695339][    T1] RBP: 0000000000000004 R08: ffffffff8157cf32 R09: fff=
ffbfff1bf9650
[    7.697370][    T1] R10: dffffc0000000000 R11: fffffbfff1bf9650 R12: fff=
fea000502edc0
[    7.699567][    T1] R13: ffffea000502edc8 R14: 1ffffd4000a05db9 R15: 000=
0000000000000
[    7.702324][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.705012][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.706430][    T1] CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[    7.708231][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.710105][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.711722][    T1] Call Trace:
[    7.712321][    T1]  <TASK>
[    7.713548][    T1]  ? __warn+0x163/0x4b0
[    7.714368][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.715547][    T1]  ? report_bug+0x2b3/0x500
[    7.716268][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.717965][    T1]  ? handle_bug+0x3e/0x70
[    7.718786][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.719977][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.721309][    T1]  ? __warn_printk+0x292/0x360
[    7.722222][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.723743][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.724864][    T1]  __free_pages_ok+0xc36/0xd60
[    7.726271][    T1]  make_alloc_exact+0xa3/0xf0
[    7.727744][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.729202][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.730313][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.731456][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.732637][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.733609][    T1]  ? really_probe+0x29e/0xc50
[    7.734939][    T1]  ? driver_probe_device+0x50/0x430
[    7.735709][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.736519][    T1]  ? ret_from_fork+0x4b/0x80
[    7.737155][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.738060][    T1]  vring_create_virtqueue+0xca/0x110
[    7.738936][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.739795][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.741152][    T1]  setup_vq+0xe9/0x2d0
[    7.741988][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.742766][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.743548][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.744432][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.745311][    T1]  vp_setup_vq+0xbf/0x330
[    7.745985][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.746878][    T1]  ? ioread16+0x2f/0x90
[    7.748076][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.748975][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.749689][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.750445][    T1]  virtscsi_init+0x8db/0xd00
[    7.751140][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.751843][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.752717][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.753587][    T1]  ? vp_get+0xfd/0x140
[    7.754323][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.755144][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.756003][    T1]  ? virtqueue_dma_mapping_error+0xd/0x80
[    7.756997][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    7.757746][    T1]  ? vp_set_status+0x1a/0x40
[    7.758484][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.759510][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.760586][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.761286][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.762062][    T1]  really_probe+0x29e/0xc50
[    7.763086][    T1]  __driver_probe_device+0x1a2/0x3e0
[    7.763898][    T1]  driver_probe_device+0x50/0x430
[    7.764713][    T1]  __driver_attach+0x45f/0x710
[    7.765387][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.766680][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.767448][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.768169][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.768922][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.770033][    T1]  bus_add_driver+0x347/0x620
[    7.771031][    T1]  driver_register+0x23a/0x320
[    7.772123][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.772858][    T1]  virtio_scsi_init+0x65/0xe0
[    7.773584][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.774375][    T1]  do_one_initcall+0x238/0x830
[    7.775257][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.776297][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.778115][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.779063][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.779788][    T1]  ? do_initcalls+0x1c/0x80
[    7.780568][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.781462][    T1]  do_initcall_level+0x157/0x210
[    7.782315][    T1]  do_initcalls+0x3f/0x80
[    7.782984][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.783746][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.784523][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.785422][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.786126][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.786833][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.787600][    T1]  kernel_init+0x1d/0x2b0
[    7.788259][    T1]  ret_from_fork+0x4b/0x80
[    7.788928][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.789603][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.790432][    T1]  </TASK>
[    7.790999][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.792157][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-09791-ge5eb28f6d1af-dirty #0
[    7.793638][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    7.795183][    T1] Call Trace:
[    7.795731][    T1]  <TASK>
[    7.796384][    T1]  dump_stack_lvl+0x241/0x360
[    7.797257][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.798175][    T1]  ? __pfx__printk+0x10/0x10
[    7.798929][    T1]  ? _printk+0xd5/0x120
[    7.799824][    T1]  ? vscnprintf+0x5d/0x90
[    7.800407][    T1]  panic+0x349/0x860
[    7.800407][    T1]  ? __warn+0x172/0x4b0
[    7.800407][    T1]  ? __pfx_panic+0x10/0x10
[    7.800407][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    7.800407][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    7.800407][    T1]  __warn+0x31e/0x4b0
[    7.800407][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.800407][    T1]  report_bug+0x2b3/0x500
[    7.800407][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.800407][    T1]  handle_bug+0x3e/0x70
[    7.800407][    T1]  exc_invalid_op+0x1a/0x50
[    7.800407][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.809948][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.809948][    T1] Code: b2 00 00 00 e8 27 5a f7 fc 5b 5d c3 cc cc cc c=
c e8 1b 5a f7 fc c6 05 f6 81 d3 0a 01 90 48 c7 c7 e0 a7 fd 8b e8 47 2e ba f=
c 90 <0f> 0b 90 90 eb d9 e8 fb 59 f7 fc c6 05 d3 81 d3 0a 01 90 48 c7 c7
[    7.809948][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.809948][    T1] RAX: 2fe2bb6c454da900 RBX: ffff888140b1401c RCX: fff=
f8880166c8000
[    7.809948][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.820130][    T1] RBP: 0000000000000004 R08: ffffffff8157cf32 R09: fff=
ffbfff1bf9650
[    7.820130][    T1] R10: dffffc0000000000 R11: fffffbfff1bf9650 R12: fff=
fea000502edc0
[    7.820130][    T1] R13: ffffea000502edc8 R14: 1ffffd4000a05db9 R15: 000=
0000000000000
[    7.820130][    T1]  ? __warn_printk+0x292/0x360
[    7.820130][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.820130][    T1]  __free_pages_ok+0xc36/0xd60
[    7.829996][    T1]  make_alloc_exact+0xa3/0xf0
[    7.829996][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.829996][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.829996][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.829996][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.829996][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.829996][    T1]  ? really_probe+0x29e/0xc50
[    7.829996][    T1]  ? driver_probe_device+0x50/0x430
[    7.840103][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.840103][    T1]  ? ret_from_fork+0x4b/0x80
[    7.840103][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.840103][    T1]  vring_create_virtqueue+0xca/0x110
[    7.840103][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.840103][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.840103][    T1]  setup_vq+0xe9/0x2d0
[    7.849997][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.849997][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.849997][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.849997][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.849997][    T1]  vp_setup_vq+0xbf/0x330
[    7.849997][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.849997][    T1]  ? ioread16+0x2f/0x90
[    7.849997][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.860078][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.860078][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.860078][    T1]  virtscsi_init+0x8db/0xd00
[    7.860078][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.860078][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.860078][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.860078][    T1]  ? vp_get+0xfd/0x140
[    7.860078][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.869950][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.869950][    T1]  ? virtqueue_dma_mapping_error+0xd/0x80
[    7.869950][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    7.869950][    T1]  ? vp_set_status+0x1a/0x40
[    7.869950][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.880123][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.880123][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.880123][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.880123][    T1]  really_probe+0x29e/0xc50
[    7.880123][    T1]  __driver_probe_device+0x1a2/0x3e0
[    7.880123][    T1]  driver_probe_device+0x50/0x430
[    7.880123][    T1]  __driver_attach+0x45f/0x710
[    7.889960][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.889960][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.889960][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.889960][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.889960][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.889960][    T1]  bus_add_driver+0x347/0x620
[    7.889960][    T1]  driver_register+0x23a/0x320
[    7.889960][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.900147][    T1]  virtio_scsi_init+0x65/0xe0
[    7.900147][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.900147][    T1]  do_one_initcall+0x238/0x830
[    7.900147][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.900147][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.900147][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.900147][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.900147][    T1]  ? do_initcalls+0x1c/0x80
[    7.900147][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.900147][    T1]  do_initcall_level+0x157/0x210
[    7.900147][    T1]  do_initcalls+0x3f/0x80
[    7.900147][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.900147][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.909999][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.909999][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.909999][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.909999][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.909999][    T1]  kernel_init+0x1d/0x2b0
[    7.909999][    T1]  ret_from_fork+0x4b/0x80
[    7.909999][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.909999][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.909999][    T1]  </TASK>
[    7.909999][    T1] Kernel Offset: disabled
[    7.909999][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1592746458=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at d615901c7
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd615901c739a765329b688494cee2f8e1b5037cb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240314-145638'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd615901c739a765329b688494cee2f8e1b5037cb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240314-145638'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd615901c739a765329b688494cee2f8e1b5037cb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240314-145638'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"d615901c739a765329b688494cee2f8e1b=
5037cb\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D118ff7b9180000


Tested on:

commit:         e5eb28f6 Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D839e3be5d86ffd1=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3D28c1a5a5b041a754b=
947
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1388324e1800=
00


