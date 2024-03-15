Return-Path: <linux-kernel+bounces-104457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5E87CE24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24D41F22515
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2234336B04;
	Fri, 15 Mar 2024 13:34:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8A36AF1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509648; cv=none; b=HzBL3imSGgg+FctpntMJ5YyEsPTWvFsrD4wrALFld4iV1Wv9uMIXnEZFNlC3dM88j1w/8BawoEK1UoyJdBga9V6nl3p+gnvkuiP/+5ugjwRcZLXfFkXsmOedfwk82SY7OJT6aBCoC3Y+CBicOJNU8+IyA45ehzAeMya7AoudhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509648; c=relaxed/simple;
	bh=W0c7RBoP2GvmOHLemz33g309xyUGIiqnW49qr4lATFQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=at8Tj4Ilpb75wEKZpl/40IxlCgQU9Xx18fyktSx2o6cQ+r64NFdOGeY0TUy5gxMe/o9+Ycma2dwISYmcW5Ad+QBwBkiNBzZMNJcPykpKxGZF1EBxJgs+qWvLzpMWYLdGgSdQyBSKaIXzjixBIxWMSHlWYGJgTYxld1o/Vy2cmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf0ebfda8so71391839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710509645; x=1711114445;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBYILq62/WBGhUO4R2+/1dzUCOQ8eA44qcf0ZmEtWng=;
        b=icb0HoGlwiAq0NxrqalulGMFVl4TONTb8+0O96iMqTEHcQ8P7u9PpLqDcWpKAHnDEW
         djLGeiOwAE1MY2KqJXBN2jQkG8dN5qGv3FTQCTKfe3BizRemy+akFDyQAHskjrcE0l33
         VJTAq/c1uaelD+TBGVY2GpLF+/GUQtNhg8bEQv0L0YJ8ZZ9T24MbKmLy1fmK02q0cMev
         BIgV3JT4sTUmeIvQjNTZGsZdqtKUapyOJDBNEpAT4gtaOa5zjk/C3Fpg2wWLNzsnRdGB
         /yK8jq6q/kd6SBuxhfEVaYFVAwr0w2yTo8pMcj3SPLAc+5STBf78GYeoXP7R/k6P+pmt
         7phQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt7r2hmgvnhyLnag5gzk70t1ZEcnvsC2rCqNK5djYQE4LI8UnJ1gZ7nAZpTxdk61l6RsdyrKLfEX9T4vk5qGsISWs3igZ+wFH2vWx+
X-Gm-Message-State: AOJu0Yx83f/svrNgNrBquovgZ902Sp2WuDOFnZ641OU2pN93XFJftGGz
	p37MxpqtpUzaY02MZ+WUflSPgneiZq8u2KciTQda0ko3vloUl1AC4ANc7gQKaZB/F+kbH5BDA5H
	CLqy9MGVBhH72Ypv6bipJLC2ALHld7h/8Gwl4hYC1ozEqW69a99o+8HY=
X-Google-Smtp-Source: AGHT+IHDYZ+GwDh75OM5Atf920lhsQbnAcq+ZcgEcKlhNupqsjRhahek9/4//69Id9fBS305bQRQj11DHx6N1m9XkVUSfPs4MnL9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:238e:b0:476:caa4:95c4 with SMTP id
 q14-20020a056638238e00b00476caa495c4mr149100jat.4.1710509643896; Fri, 15 Mar
 2024 06:34:03 -0700 (PDT)
Date: Fri, 15 Mar 2024 06:34:03 -0700
In-Reply-To: <20240315130558.2420-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5a9c60613b30fb8@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in snd_timer_close_locked
From: syzbot <syzbot+f3bc6f8108108010a03d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

: registered new interface driver port100
[    7.829002][    T1] usbcore: registered new interface driver nfcmrvl
[    7.837538][    T1] Loading iSCSI transport class v2.0-870.
[    7.856507][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.866977][    T1] ------------[ cut here ]------------
[    7.868232][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.869519][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.870990][    T1] Modules linked in:
[    7.871688][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-09791-ge5eb28f6d1af-dirty #0
[    7.876326][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    7.878700][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.879754][    T1] Code: b2 00 00 00 e8 27 5a f7 fc 5b 5d c3 cc cc cc c=
c e8 1b 5a f7 fc c6 05 f6 81 d3 0a 01 90 48 c7 c7 e0 a7 fd 8b e8 47 2e ba f=
c 90 <0f> 0b 90 90 eb d9 e8 fb 59 f7 fc c6 05 d3 81 d3 0a 01 90 48 c7 c7
[    7.882789][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.884154][    T1] RAX: 427762defa97e000 RBX: ffff888020edeb2c RCX: fff=
f8880166c8000
[    7.885354][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.886832][    T1] RBP: 0000000000000004 R08: ffffffff8157cf32 R09: fff=
ffbfff1bf9650
[    7.888655][    T1] R10: dffffc0000000000 R11: fffffbfff1bf9650 R12: fff=
fea0000843dc0
[    7.889916][    T1] R13: ffffea0000843dc8 R14: 1ffffd40001087b9 R15: 000=
0000000000000
[    7.893126][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.895114][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.896277][    T1] CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[    7.897638][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.900434][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.902939][    T1] Call Trace:
[    7.904000][    T1]  <TASK>
[    7.904699][    T1]  ? __warn+0x163/0x4b0
[    7.905611][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.906808][    T1]  ? report_bug+0x2b3/0x500
[    7.907725][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.908788][    T1]  ? handle_bug+0x3e/0x70
[    7.909996][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.910753][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.911517][    T1]  ? __warn_printk+0x292/0x360
[    7.912828][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.914043][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.914947][    T1]  __free_pages_ok+0xc36/0xd60
[    7.916124][    T1]  make_alloc_exact+0xa3/0xf0
[    7.917078][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.918018][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.919870][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.920839][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.921640][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.922633][    T1]  ? really_probe+0x29e/0xc50
[    7.923595][    T1]  ? driver_probe_device+0x50/0x430
[    7.925027][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.926040][    T1]  ? ret_from_fork+0x4b/0x80
[    7.927657][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.929661][    T1]  vring_create_virtqueue+0xca/0x110
[    7.930785][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.931677][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.932523][    T1]  setup_vq+0xe9/0x2d0
[    7.933148][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.934298][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.936631][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.938514][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.939708][    T1]  vp_setup_vq+0xbf/0x330
[    7.940480][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.941952][    T1]  ? ioread16+0x2f/0x90
[    7.943383][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.945869][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.946930][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.948366][    T1]  virtscsi_init+0x8db/0xd00
[    7.949444][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.950722][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.952485][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.954177][    T1]  ? vp_get+0xfd/0x140
[    7.955309][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.956670][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.958350][    T1]  ? virtqueue_dma_mapping_error+0xd/0x80
[    7.960113][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    7.961499][    T1]  ? vp_set_status+0x1a/0x40
[    7.962431][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.964349][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.965595][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.966818][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.967921][    T1]  really_probe+0x29e/0xc50
[    7.968593][    T1]  __driver_probe_device+0x1a2/0x3e0
[    7.969535][    T1]  driver_probe_device+0x50/0x430
[    7.970634][    T1]  __driver_attach+0x45f/0x710
[    7.971732][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.973000][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.974208][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.975425][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.976355][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.977543][    T1]  bus_add_driver+0x347/0x620
[    7.979682][    T1]  driver_register+0x23a/0x320
[    7.981056][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.982342][    T1]  virtio_scsi_init+0x65/0xe0
[    7.983870][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.985269][    T1]  do_one_initcall+0x238/0x830
[    7.986554][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.987867][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.989039][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    7.990465][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.991527][    T1]  ? do_initcalls+0x1c/0x80
[    7.992292][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.993265][    T1]  do_initcall_level+0x157/0x210
[    7.994180][    T1]  do_initcalls+0x3f/0x80
[    7.994906][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.995937][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.996856][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.997739][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.999001][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.999909][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.000823][    T1]  kernel_init+0x1d/0x2b0
[    8.001451][    T1]  ret_from_fork+0x4b/0x80
[    8.002268][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.003408][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.004122][    T1]  </TASK>
[    8.005036][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.006846][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-09791-ge5eb28f6d1af-dirty #0
[    8.009117][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    8.011687][    T1] Call Trace:
[    8.012892][    T1]  <TASK>
[    8.013386][    T1]  dump_stack_lvl+0x241/0x360
[    8.013386][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.013386][    T1]  ? __pfx__printk+0x10/0x10
[    8.013386][    T1]  ? _printk+0xd5/0x120
[    8.013386][    T1]  ? vscnprintf+0x5d/0x90
[    8.013386][    T1]  panic+0x349/0x860
[    8.013386][    T1]  ? __warn+0x172/0x4b0
[    8.013386][    T1]  ? __pfx_panic+0x10/0x10
[    8.013386][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.013386][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.013386][    T1]  __warn+0x31e/0x4b0
[    8.013386][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.013386][    T1]  report_bug+0x2b3/0x500
[    8.013386][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.013386][    T1]  handle_bug+0x3e/0x70
[    8.013386][    T1]  exc_invalid_op+0x1a/0x50
[    8.013386][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.013386][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.013386][    T1] Code: b2 00 00 00 e8 27 5a f7 fc 5b 5d c3 cc cc cc c=
c e8 1b 5a f7 fc c6 05 f6 81 d3 0a 01 90 48 c7 c7 e0 a7 fd 8b e8 47 2e ba f=
c 90 <0f> 0b 90 90 eb d9 e8 fb 59 f7 fc c6 05 d3 81 d3 0a 01 90 48 c7 c7
[    8.013386][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.013386][    T1] RAX: 427762defa97e000 RBX: ffff888020edeb2c RCX: fff=
f8880166c8000
[    8.013386][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.013386][    T1] RBP: 0000000000000004 R08: ffffffff8157cf32 R09: fff=
ffbfff1bf9650
[    8.013386][    T1] R10: dffffc0000000000 R11: fffffbfff1bf9650 R12: fff=
fea0000843dc0
[    8.013386][    T1] R13: ffffea0000843dc8 R14: 1ffffd40001087b9 R15: 000=
0000000000000
[    8.013386][    T1]  ? __warn_printk+0x292/0x360
[    8.013386][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.013386][    T1]  __free_pages_ok+0xc36/0xd60
[    8.013386][    T1]  make_alloc_exact+0xa3/0xf0
[    8.013386][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.013386][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.013386][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.013386][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.013386][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.013386][    T1]  ? really_probe+0x29e/0xc50
[    8.013386][    T1]  ? driver_probe_device+0x50/0x430
[    8.013386][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.013386][    T1]  ? ret_from_fork+0x4b/0x80
[    8.063354][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.063354][    T1]  vring_create_virtqueue+0xca/0x110
[    8.063354][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.063354][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.063354][    T1]  setup_vq+0xe9/0x2d0
[    8.063354][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.063354][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.063354][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.063354][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.063354][    T1]  vp_setup_vq+0xbf/0x330
[    8.063354][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.063354][    T1]  ? ioread16+0x2f/0x90
[    8.063354][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.063354][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.063354][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.063354][    T1]  virtscsi_init+0x8db/0xd00
[    8.063354][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.063354][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.063354][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.063354][    T1]  ? vp_get+0xfd/0x140
[    8.063354][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.063354][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.063354][    T1]  ? virtqueue_dma_mapping_error+0xd/0x80
[    8.063354][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    8.063354][    T1]  ? vp_set_status+0x1a/0x40
[    8.063354][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.063354][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.063354][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.063354][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.063354][    T1]  really_probe+0x29e/0xc50
[    8.063354][    T1]  __driver_probe_device+0x1a2/0x3e0
[    8.063354][    T1]  driver_probe_device+0x50/0x430
[    8.063354][    T1]  __driver_attach+0x45f/0x710
[    8.063354][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.063354][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.063354][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.063354][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.063354][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.063354][    T1]  bus_add_driver+0x347/0x620
[    8.063354][    T1]  driver_register+0x23a/0x320
[    8.063354][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.063354][    T1]  virtio_scsi_init+0x65/0xe0
[    8.063354][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.063354][    T1]  do_one_initcall+0x238/0x830
[    8.063354][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.063354][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.063354][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    8.063354][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.113373][    T1]  ? do_initcalls+0x1c/0x80
[    8.113373][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.113373][    T1]  do_initcall_level+0x157/0x210
[    8.113373][    T1]  do_initcalls+0x3f/0x80
[    8.113373][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.113373][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.113373][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.113373][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.113373][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.113373][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.113373][    T1]  kernel_init+0x1d/0x2b0
[    8.113373][    T1]  ret_from_fork+0x4b/0x80
[    8.113373][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.113373][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.113373][    T1]  </TASK>
[    8.113373][    T1] Kernel Offset: disabled
[    8.113373][    T1] Rebooting in 86400 seconds..


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
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
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
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2569298022=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D161a7959180000


Tested on:

commit:         e5eb28f6 Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D839e3be5d86ffd1=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3Df3bc6f8108108010a=
03d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D132982311800=
00


