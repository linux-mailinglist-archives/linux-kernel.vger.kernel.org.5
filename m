Return-Path: <linux-kernel+bounces-151005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D048AA7D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5491C224FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5A59473;
	Fri, 19 Apr 2024 05:01:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C9522E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713502866; cv=none; b=ldmI8eRW420c8nYfQ8Uyr6Yh8Jvfx4cIrJhy8/bLqCYzp7ge4skozPE6mVZbhrJLC8h4mTGuOEe9MxUobDxfOGx3cOKs8X9ZykyOdshHzqqUGVMMZ12eYnFQQrSlgYtB5N8TVCoyI1JlvaMXAXqYUG03HovM9I4ZjfSXMOGmISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713502866; c=relaxed/simple;
	bh=fx8UYZLUdn7N+SNF7rikXDgUWR7GXzXGs4xj8/cdiHU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B0hA3BWSN77yf0vHFx5PxK3Hyp02VgJ9OcfzmQHO+rHZ5x9irM9IFfwthIYC0aS/lEyM+g5PzE0SD1JEPhG/UsFWD7itvkZoyo1ngVyic83w1QkHxJrBAiYhVZrno2vJDx4tOv0LOUvM3tCH4gnFbAhb2tU6b9GoArDNGEzlKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da41da873bso96351039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713502864; x=1714107664;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM+RwArDzfHSQztdg1xjbt4T+uP1jur3uQx6XyYopN8=;
        b=FKFe0innppwYP935lAwTmdf3HlT0vSyeQgw8A+HJtrEuYzk7BYfShZUy5D2HRCFdxc
         hgXfw6XzbHhHfxwJCMosl71akLam7nKCacQxZVGHim6WcYa1PkWXmbTrQxbtqRYBY19W
         t3JYPB0xjJcbyCj/7hu+/2D65zEb7gdmKT2Qdtr5W0E1XVC7D+Rs+uULdgqwZfaPtYK0
         xpbZ27zGb3N/500eo/Ped3vtuO5f3zv1qhJf7dh6sZWBAtdFK/vFvMejmDpJ/AQ2B+aD
         JfB3yhk+PRnvtkxNT/Vwor+TbXnPlDZUFDUxhdpE14hGAfe+0ZgnrRtATiUCovWZurge
         ILJw==
X-Forwarded-Encrypted: i=1; AJvYcCV1zUJvUt3RGZ8KSv1D2C6qA7uB4BTWMrmjxPe0rsOnPjF8b7vUzBApV6jsfIeyeNBLvh+5T86mapzotMoosldVvGWa8qjBwpNXPNpd
X-Gm-Message-State: AOJu0YzsOb3X4noH4WX90d2TxvfkOrpW+t0OQu4MrOMvCieLESZ0/Exk
	w8PBzun/yOHzuEK/sT3Reqr/xFbWQWqENYnLb+aLBvjg6e5RQd/BTOAkWIKKWVuscYxY/obvOJ4
	8rtbZnIIqA2EDg+wHtDRj39dJFRqoakK5B1+kjGs5nzD9b1sA/FTJ+kY=
X-Google-Smtp-Source: AGHT+IGiqbB8kAAm6QLXu1V+eUVcOuJs5sg9lv0pGKIbGLOInrdnJEpFqQO+JTemckKIWhhyRIrkbqoP2tQ/hVn8vB1kOGC+4OKP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8918:b0:484:d0b2:9d96 with SMTP id
 jc24-20020a056638891800b00484d0b29d96mr81881jab.2.1713502863797; Thu, 18 Apr
 2024 22:01:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:01:03 -0700
In-Reply-To: <ZiFqSrSRLhIV91og@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084c1fa06166bf95d@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
From: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, 
	vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

: registered new interface driver rtsx_usb
[    7.671002][    T1] usbcore: registered new interface driver viperboard
[    7.672903][    T1] usbcore: registered new interface driver dln2
[    7.674419][    T1] usbcore: registered new interface driver pn533_usb
[    7.681042][    T1] nfcsim 0.2 initialized
[    7.681871][    T1] usbcore: registered new interface driver port100
[    7.683273][    T1] usbcore: registered new interface driver nfcmrvl
[    7.690221][    T1] Loading iSCSI transport class v2.0-870.
[    7.709703][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.720575][    T1] ------------[ cut here ]------------
[    7.721959][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.723401][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.725405][    T1] Modules linked in:
[    7.726102][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-00031-g96fca68c4fbf-dirty #0
[    7.727850][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.729277][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.730342][    T1] Code: b2 00 00 00 e8 07 05 e7 fc 5b 5d c3 cc cc cc c=
c e8 fb 04 e7 fc c6 05 d9 7d e4 0a 01 90 48 c7 c7 40 33 1f 8c e8 67 81 a9 f=
c 90 <0f> 0b 90 90 eb d9 e8 db 04 e7 fc c6 05 b6 7d e4 0a 01 90 48 c7 c7
[    7.733682][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.734579][    T1] RAX: 4c11f4fbdf346600 RBX: ffff888020cfe13c RCX: fff=
f8880166d0000
[    7.736062][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.737626][    T1] RBP: 0000000000000004 R08: ffffffff815880a2 R09: fff=
ffbfff1c39b48
[    7.738967][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea000502cdc0
[    7.740234][    T1] R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 000=
0000000000000
[    7.741505][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.743319][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.744266][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    7.745934][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.747137][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.748484][    T1] Call Trace:
[    7.749033][    T1]  <TASK>
[    7.749520][    T1]  ? __warn+0x163/0x4e0
[    7.750519][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.751478][    T1]  ? report_bug+0x2b3/0x500
[    7.752127][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.752989][    T1]  ? handle_bug+0x3e/0x70
[    7.753676][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.754367][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.755231][    T1]  ? __warn_printk+0x292/0x360
[    7.756237][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.757213][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.758709][    T1]  __free_pages_ok+0xc60/0xd90
[    7.759783][    T1]  make_alloc_exact+0xa3/0xf0
[    7.760537][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.761574][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.762858][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.764032][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.765068][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.766076][    T1]  ? really_probe+0x2b8/0xad0
[    7.766989][    T1]  ? driver_probe_device+0x50/0x430
[    7.767862][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.768991][    T1]  ? ret_from_fork+0x4b/0x80
[    7.769824][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.770902][    T1]  vring_create_virtqueue+0xca/0x110
[    7.771856][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.772808][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.773886][    T1]  setup_vq+0xe9/0x2d0
[    7.774638][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.775418][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.776418][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.777523][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.778656][    T1]  vp_setup_vq+0xbf/0x330
[    7.779318][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.780244][    T1]  ? ioread16+0x2f/0x90
[    7.780897][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.781822][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.782771][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.783720][    T1]  virtscsi_init+0x8db/0xd00
[    7.784741][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.785550][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.786659][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.787673][    T1]  ? vp_get+0xfd/0x140
[    7.788473][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.789468][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.790246][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.791590][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.793149][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.794179][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.795928][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.796830][    T1]  really_probe+0x2b8/0xad0
[    7.797762][    T1]  __driver_probe_device+0x1a2/0x390
[    7.799008][    T1]  driver_probe_device+0x50/0x430
[    7.800080][    T1]  __driver_attach+0x45f/0x710
[    7.800982][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.802135][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.803466][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.804685][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.805788][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.807328][    T1]  bus_add_driver+0x347/0x620
[    7.808200][    T1]  driver_register+0x23a/0x320
[    7.808976][    T1]  virtio_scsi_init+0x69/0xe0
[    7.809707][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.811269][    T1]  do_one_initcall+0x248/0x880
[    7.812854][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.813969][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.815128][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    7.816629][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.817705][    T1]  ? do_initcalls+0x1c/0x80
[    7.818397][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.819245][    T1]  do_initcall_level+0x157/0x210
[    7.820362][    T1]  do_initcalls+0x3f/0x80
[    7.821273][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.822360][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.824148][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.825527][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.826406][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.827457][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.828321][    T1]  kernel_init+0x1d/0x2b0
[    7.829196][    T1]  ret_from_fork+0x4b/0x80
[    7.829955][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.830754][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.832029][    T1]  </TASK>
[    7.832583][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.833890][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-00031-g96fca68c4fbf-dirty #0
[    7.835440][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.835440][    T1] Call Trace:
[    7.835440][    T1]  <TASK>
[    7.835440][    T1]  dump_stack_lvl+0x241/0x360
[    7.835440][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.835440][    T1]  ? __pfx__printk+0x10/0x10
[    7.835440][    T1]  ? _printk+0xd5/0x120
[    7.835440][    T1]  ? vscnprintf+0x5d/0x90
[    7.835440][    T1]  panic+0x349/0x860
[    7.835440][    T1]  ? __warn+0x172/0x4e0
[    7.845404][    T1]  ? __pfx_panic+0x10/0x10
[    7.845404][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    7.845404][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    7.845404][    T1]  __warn+0x346/0x4e0
[    7.845404][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.845404][    T1]  report_bug+0x2b3/0x500
[    7.845404][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.845404][    T1]  handle_bug+0x3e/0x70
[    7.845404][    T1]  exc_invalid_op+0x1a/0x50
[    7.855352][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.855352][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.855352][    T1] Code: b2 00 00 00 e8 07 05 e7 fc 5b 5d c3 cc cc cc c=
c e8 fb 04 e7 fc c6 05 d9 7d e4 0a 01 90 48 c7 c7 40 33 1f 8c e8 67 81 a9 f=
c 90 <0f> 0b 90 90 eb d9 e8 db 04 e7 fc c6 05 b6 7d e4 0a 01 90 48 c7 c7
[    7.855352][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.855352][    T1] RAX: 4c11f4fbdf346600 RBX: ffff888020cfe13c RCX: fff=
f8880166d0000
[    7.855352][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.865369][    T1] RBP: 0000000000000004 R08: ffffffff815880a2 R09: fff=
ffbfff1c39b48
[    7.865369][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea000502cdc0
[    7.865369][    T1] R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 000=
0000000000000
[    7.865369][    T1]  ? __warn_printk+0x292/0x360
[    7.865369][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.865369][    T1]  __free_pages_ok+0xc60/0xd90
[    7.865369][    T1]  make_alloc_exact+0xa3/0xf0
[    7.875273][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.875273][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.875273][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.875273][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.875273][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.875273][    T1]  ? really_probe+0x2b8/0xad0
[    7.875273][    T1]  ? driver_probe_device+0x50/0x430
[    7.875273][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.875273][    T1]  ? ret_from_fork+0x4b/0x80
[    7.875273][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.885398][    T1]  vring_create_virtqueue+0xca/0x110
[    7.885398][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.885398][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.885398][    T1]  setup_vq+0xe9/0x2d0
[    7.885398][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.885398][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.885398][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.885398][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.885398][    T1]  vp_setup_vq+0xbf/0x330
[    7.895327][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.895327][    T1]  ? ioread16+0x2f/0x90
[    7.895327][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.895327][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.895327][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.895327][    T1]  virtscsi_init+0x8db/0xd00
[    7.895327][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.895327][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.895327][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.895327][    T1]  ? vp_get+0xfd/0x140
[    7.895327][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.895327][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.905395][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.905395][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.905395][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.905395][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.905395][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.905395][    T1]  really_probe+0x2b8/0xad0
[    7.905395][    T1]  __driver_probe_device+0x1a2/0x390
[    7.905395][    T1]  driver_probe_device+0x50/0x430
[    7.905395][    T1]  __driver_attach+0x45f/0x710
[    7.915312][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.915312][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.915312][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.915312][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.915312][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.915312][    T1]  bus_add_driver+0x347/0x620
[    7.915312][    T1]  driver_register+0x23a/0x320
[    7.915312][    T1]  virtio_scsi_init+0x69/0xe0
[    7.915312][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.915312][    T1]  do_one_initcall+0x248/0x880
[    7.925360][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.925360][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.925360][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    7.925360][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.925360][    T1]  ? do_initcalls+0x1c/0x80
[    7.925360][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.925360][    T1]  do_initcall_level+0x157/0x210
[    7.925360][    T1]  do_initcalls+0x3f/0x80
[    7.925360][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.925360][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.935268][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.935268][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.935268][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.935268][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.935268][    T1]  kernel_init+0x1d/0x2b0
[    7.935268][    T1]  ret_from_fork+0x4b/0x80
[    7.935268][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.935268][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.935268][    T1]  </TASK>
[    7.935268][    T1] Kernel Offset: disabled
[    7.935268][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3076711685=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at c8349e485
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
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c8349e48534ea6d8f01515335d95de8ebf=
5da8df\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D112cfbcd180000


Tested on:

commit:         96fca68c Merge tag 'nfsd-6.9-3' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git=
 linus
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd239903bd07761e=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dad1b592fc44836554=
38b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10fd1a3b1800=
00


