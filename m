Return-Path: <linux-kernel+bounces-125221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D632892269
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1B51F25D48
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172185653;
	Fri, 29 Mar 2024 17:08:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FAD1EB3D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732086; cv=none; b=cg0IkRizcgDKcJH9XDysSdkWt8iwKn/GCkJAbnSIyYLrsC1BDxo0iLT4CIErjRwknnW9HReRlZP8EvJjUi3NAvoj8UX0GSeg8ZvzEv3X3SU75EvUI8iM3cCR5rsdXFRHS6JM98pwja76J42hnzGMfjudpkJA/l8BPmwrar5tgf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732086; c=relaxed/simple;
	bh=eqBOHrVE7gHvGH5lzfADZa31M0vgCltvEcVEPY4i3OY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lj0h7LcSk0QJfjfB+LlOzlVVwaJz/DBnoA3VjeVEms3iOZJLYvYtlgeV5WKDNE66x+KE3G+iv9uaSYa22vul8hXi4PBenbCY5QOJkwQJvmDiE2pZFQisMm62AgxrWSMygAeSzG6vns5PJfLV7XkgPfmhQkxG15wwOSO4Pa/S5ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36849578ac4so18296525ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732083; x=1712336883;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zarIOOHolzPdKFxBEvsj3+/OWS3XGbA6TxA1/NyoTiU=;
        b=xNuhy7yKO7Ng3UI5dj1wMkAJ9+6ySoWn2OYq0fZG8vGosWdN+6kmCmGMizxY0D9PmQ
         T3NJBWd+tFkXhMVDq2VmdXr+VNR/hp3sjN85FUMyXuw0cNnmp0wQlTEJyo2mjIw8ZpUF
         zxIT5x3oWEuXJ92M9uYdANV0HGbhBXmwhM5bGk+tvbS6p8YfaJW7XtejZKgnhLTWM6Ht
         KYvwSb3zV56Q/R2D44OSibabfb53TMJkoCfped/t3tMQEoCu7mCIaudAqQ20EBWnzEqG
         raKn/DXV47G/IBpNHucvla0PxwTERQty/uYzy9PWQKdAdsNXAMF4g/u+zcodmcdEuFuZ
         OE2g==
X-Forwarded-Encrypted: i=1; AJvYcCXM1lgw16PZLMryfC/ek9cbo/vLMYnSkorot5ONWTlJW5EyvhSz/eZb0urJFTQuzxmygv0+WSEzU/0ynYmmOmu5pYHnchpOJmeAJPf9
X-Gm-Message-State: AOJu0YyEY2fd1Tmyq19ymMM+2TNlU5SEBmIjALDJ6mjFwb583A4JpHtI
	PiqPnGQ72NbzOIfm1jl+paryjmCLHi0jzfdNm5ZOcOxSXD7XBnr3J8nIdkRvnDb8kJgHuwXdY61
	haOI+8AUbkOTqtssIvI6+F7naPkgzDystGQSneDTrhBb/F+NH2E8lpn8=
X-Google-Smtp-Source: AGHT+IFrZEHiOOZJFKuMK7pZe9k3f+DadX4LfuU7IXROVchPRdxOdR6rraJlfuuI58hDL0A5qOlKPtXQw08wECLzZGVs9HrI7Jqp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2162:b0:368:75b2:d577 with SMTP id
 s2-20020a056e02216200b0036875b2d577mr176405ilv.5.1711732083610; Fri, 29 Mar
 2024 10:08:03 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:08:03 -0700
In-Reply-To: <20240328232737.2973-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb68540614cfae12@google.com>
Subject: Re: [syzbot] [audit?] [bpf?] INFO: rcu detected stall in
 kauditd_thread (4)
From: syzbot <syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

onnector registered
[    8.925501][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[    8.936918][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[    9.031871][    T1] Console: switching to colour frame buffer device 128=
x48
[    9.049570][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[    9.050924][    T1] usbcore: registered new interface driver udl
[    9.140069][    T1] brd: module loaded
[    9.257049][    T1] loop: module loaded
[    9.412333][    T1] zram: Added device: zram0
[    9.424889][    T1] null_blk: disk nullb0 created
[    9.425718][    T1] null_blk: module loaded
[    9.427782][    T1] Guest personality initialized and is inactive
[    9.429970][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[    9.431095][    T1] Initialized host personality
[    9.432024][    T1] usbcore: registered new interface driver rtsx_usb
[    9.433983][    T1] usbcore: registered new interface driver viperboard
[    9.435713][    T1] usbcore: registered new interface driver dln2
[    9.437613][    T1] usbcore: registered new interface driver pn533_usb
[    9.445487][    T1] nfcsim 0.2 initialized
[    9.446814][    T1] usbcore: registered new interface driver port100
[    9.448211][    T1] usbcore: registered new interface driver nfcmrvl
[    9.455761][    T1] Loading iSCSI transport class v2.0-870.
[    9.481077][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    9.491184][    T1] ------------[ cut here ]------------
[    9.491949][    T1] refcount_t: decrement hit 0; leaking memory.
[    9.493197][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1ed/0x210
[    9.494503][    T1] Modules linked in:
[    9.495197][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00178-g317c7bc0ef03-dirty #0
[    9.496752][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.498118][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[    9.499016][    T1] Code: 8b e8 d7 34 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 c8 c6 0f fd c6 05 fa f0 4c 0b 01 90 48 c7 c7 80 e5 8e 8b e8 b4 34 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 e2 f2 6a fd e9 44 fe ff ff
[    9.501796][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[    9.502670][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[    9.503753][    T1] RDX: ffff888016ec0000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[    9.504990][    T1] RBP: ffff888147a9da7c R08: 0000000000000001 R09: 000=
0000000000000
[    9.506141][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888147a9da7c
[    9.507308][    T1] R13: 0000000000000000 R14: 00000000034c00b9 R15: fff=
f88801687cd88
[    9.508457][    T1] FS:  0000000000000000(0000) GS:ffff8880b9200000(0000=
) knlGS:0000000000000000
[    9.509770][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.510753][    T1] CR2: ffff88823ffff000 CR3: 000000000d97a000 CR4: 000=
00000003506f0
[    9.511894][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    9.513054][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    9.514199][    T1] Call Trace:
[    9.514874][    T1]  <TASK>
[    9.515320][    T1]  ? show_regs+0x8c/0xa0
[    9.515938][    T1]  ? __warn+0xe5/0x3c0
[    9.516504][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[    9.517289][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    9.518112][    T1]  ? report_bug+0x3c0/0x580
[    9.518784][    T1]  ? handle_bug+0x3d/0x70
[    9.519418][    T1]  ? exc_invalid_op+0x17/0x50
[    9.520133][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    9.520890][    T1]  ? __warn_printk+0x199/0x350
[    9.521627][    T1]  ? __warn_printk+0x1a6/0x350
[    9.522359][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    9.523209][    T1]  __reset_page_owner+0x2ea/0x370
[    9.523932][    T1]  __free_pages_ok+0x5a9/0xbf0
[    9.524704][    T1]  ? __split_page_owner+0xdd/0x120
[    9.525413][    T1]  make_alloc_exact+0x165/0x260
[    9.526180][    T1]  vring_alloc_queue+0xc1/0x110
[    9.527000][    T1]  vring_alloc_queue_split+0x186/0x510
[    9.527845][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    9.528704][    T1]  ? kasan_save_stack+0x42/0x60
[    9.529397][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.530249][    T1]  vring_create_virtqueue_split+0xe8/0x280
[    9.531109][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.531838][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.532706][    T1]  ? virtio_scsi_init+0x75/0x100
[    9.533384][    T1]  ? do_one_initcall+0x128/0x700
[    9.534078][    T1]  ? kernel_init_freeable+0x69d/0xca0
[    9.534939][    T1]  vring_create_virtqueue+0xd7/0x140
[    9.535789][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.536450][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.537233][    T1]  setup_vq+0x123/0x2f0
[    9.537807][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.538463][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.539325][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.540143][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.540960][    T1]  vp_setup_vq+0xb1/0x380
[    9.541628][    T1]  ? iowrite16+0x55/0x80
[    9.542223][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.542989][    T1]  vp_find_vqs_msix+0x661/0xe30
[    9.543719][    T1]  vp_find_vqs+0x58/0x560
[    9.544394][    T1]  virtscsi_init+0x459/0x9f0
[    9.545082][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.545805][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.546590][    T1]  ? ioread8+0x4e/0xa0
[    9.547161][    T1]  ? vp_get+0xf6/0x140
[    9.547727][    T1]  virtscsi_probe+0x3b2/0xdd0
[    9.548378][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.549118][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[    9.550033][    T1]  ? vring_transport_features+0x49/0xb0
[    9.550796][    T1]  virtio_dev_probe+0x5ff/0x9b0
[    9.551467][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.552207][    T1]  really_probe+0x23e/0xa90
[    9.552833][    T1]  __driver_probe_device+0x1de/0x440
[    9.553620][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[    9.554433][    T1]  driver_probe_device+0x4c/0x1b0
[    9.555130][    T1]  __driver_attach+0x283/0x580
[    9.555809][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.556553][    T1]  bus_for_each_dev+0x13c/0x1d0
[    9.557221][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.557958][    T1]  bus_add_driver+0x2ed/0x640
[    9.558607][    T1]  driver_register+0x15c/0x4b0
[    9.559261][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.560012][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.560746][    T1]  virtio_scsi_init+0x75/0x100
[    9.561401][    T1]  do_one_initcall+0x128/0x700
[    9.562065][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.562813][    T1]  ? trace_kmalloc+0x2d/0xe0
[    9.563451][    T1]  ? __kmalloc+0x218/0x440
[    9.564063][    T1]  kernel_init_freeable+0x69d/0xca0
[    9.564821][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.565561][    T1]  kernel_init+0x1c/0x2b0
[    9.566160][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.566837][    T1]  ret_from_fork+0x45/0x80
[    9.567453][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.568132][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.568792][    T1]  </TASK>
[    9.569217][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    9.570203][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00178-g317c7bc0ef03-dirty #0
[    9.571565][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.572900][    T1] Call Trace:
[    9.573380][    T1]  <TASK>
[    9.573813][    T1]  dump_stack_lvl+0x3d/0x1f0
[    9.574451][    T1]  panic+0x6f5/0x7a0
[    9.574804][    T1]  ? __pfx_panic+0x10/0x10
[    9.574804][    T1]  ? show_trace_log_lvl+0x363/0x500
[    9.574804][    T1]  ? check_panic_on_warn+0x1f/0xb0
[    9.574804][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    9.574804][    T1]  check_panic_on_warn+0xab/0xb0
[    9.574804][    T1]  __warn+0xf1/0x3c0
[    9.574804][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[    9.574804][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    9.574804][    T1]  report_bug+0x3c0/0x580
[    9.574804][    T1]  handle_bug+0x3d/0x70
[    9.574804][    T1]  exc_invalid_op+0x17/0x50
[    9.574804][    T1]  asm_exc_invalid_op+0x1a/0x20
[    9.574804][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[    9.574804][    T1] Code: 8b e8 d7 34 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 c8 c6 0f fd c6 05 fa f0 4c 0b 01 90 48 c7 c7 80 e5 8e 8b e8 b4 34 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 e2 f2 6a fd e9 44 fe ff ff
[    9.574804][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[    9.574804][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[    9.574804][    T1] RDX: ffff888016ec0000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[    9.574804][    T1] RBP: ffff888147a9da7c R08: 0000000000000001 R09: 000=
0000000000000
[    9.574804][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888147a9da7c
[    9.574804][    T1] R13: 0000000000000000 R14: 00000000034c00b9 R15: fff=
f88801687cd88
[    9.574804][    T1]  ? __warn_printk+0x199/0x350
[    9.574804][    T1]  ? __warn_printk+0x1a6/0x350
[    9.574804][    T1]  __reset_page_owner+0x2ea/0x370
[    9.574804][    T1]  __free_pages_ok+0x5a9/0xbf0
[    9.574804][    T1]  ? __split_page_owner+0xdd/0x120
[    9.574804][    T1]  make_alloc_exact+0x165/0x260
[    9.574804][    T1]  vring_alloc_queue+0xc1/0x110
[    9.574804][    T1]  vring_alloc_queue_split+0x186/0x510
[    9.574804][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    9.574804][    T1]  ? kasan_save_stack+0x42/0x60
[    9.574804][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.574804][    T1]  vring_create_virtqueue_split+0xe8/0x280
[    9.574804][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.574804][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.574804][    T1]  ? virtio_scsi_init+0x75/0x100
[    9.574804][    T1]  ? do_one_initcall+0x128/0x700
[    9.574804][    T1]  ? kernel_init_freeable+0x69d/0xca0
[    9.574804][    T1]  vring_create_virtqueue+0xd7/0x140
[    9.574804][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.574804][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.574804][    T1]  setup_vq+0x123/0x2f0
[    9.574804][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.574804][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.574804][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.574804][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.574804][    T1]  vp_setup_vq+0xb1/0x380
[    9.574804][    T1]  ? iowrite16+0x55/0x80
[    9.574804][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.574804][    T1]  vp_find_vqs_msix+0x661/0xe30
[    9.574804][    T1]  vp_find_vqs+0x58/0x560
[    9.574804][    T1]  virtscsi_init+0x459/0x9f0
[    9.574804][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.574804][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.574804][    T1]  ? ioread8+0x4e/0xa0
[    9.574804][    T1]  ? vp_get+0xf6/0x140
[    9.574804][    T1]  virtscsi_probe+0x3b2/0xdd0
[    9.574804][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.574804][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[    9.574804][    T1]  ? vring_transport_features+0x49/0xb0
[    9.574804][    T1]  virtio_dev_probe+0x5ff/0x9b0
[    9.574804][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.574804][    T1]  really_probe+0x23e/0xa90
[    9.574804][    T1]  __driver_probe_device+0x1de/0x440
[    9.574804][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[    9.574804][    T1]  driver_probe_device+0x4c/0x1b0
[    9.574804][    T1]  __driver_attach+0x283/0x580
[    9.574804][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.574804][    T1]  bus_for_each_dev+0x13c/0x1d0
[    9.574804][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.574804][    T1]  bus_add_driver+0x2ed/0x640
[    9.574804][    T1]  driver_register+0x15c/0x4b0
[    9.574804][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.574804][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.574804][    T1]  virtio_scsi_init+0x75/0x100
[    9.574804][    T1]  do_one_initcall+0x128/0x700
[    9.574804][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.574804][    T1]  ? trace_kmalloc+0x2d/0xe0
[    9.574804][    T1]  ? __kmalloc+0x218/0x440
[    9.574804][    T1]  kernel_init_freeable+0x69d/0xca0
[    9.574804][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.574804][    T1]  kernel_init+0x1c/0x2b0
[    9.574804][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.574804][    T1]  ret_from_fork+0x45/0x80
[    9.574804][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.574804][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.574804][    T1]  </TASK>
[    9.574804][    T1] Kernel Offset: disabled
[    9.574804][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build932799495=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at 454571b6a
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
/syzkaller/prog.GitRevision=3D454571b6a16598f5a6e015b9fb1a04932bce7ab9 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240326-163935'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D454571b6a16598f5a6e015b9fb1a04932bce7ab9 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240326-163935'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D454571b6a16598f5a6e015b9fb1a04932bce7ab9 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240326-163935'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"454571b6a16598f5a6e015b9fb1a04932b=
ce7ab9\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11a50795180000


Tested on:

commit:         317c7bc0 Merge tag 'mmc-v6.9-rc1' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df64ec427e98bccd=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D81f5ca46b043d4a1b=
789
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D172877911800=
00


