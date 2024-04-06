Return-Path: <linux-kernel+bounces-133968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE989AB93
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDEA1F21A24
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866B839FF4;
	Sat,  6 Apr 2024 15:15:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5A376E7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712416506; cv=none; b=JZyYll1n6ClvosGhhvzbZRNM9vb0TSwwZu/TdqrgXjkEOObRh74ZiOFKJtjMhnkS3Z3cfWuKAn4XAjvExq+UgAB7dlwuGnNv7MPPJF7s7f5VWjRol+THOVpTuPckM527B4vhA9bwtZre2Y62AlAkUyfVJ/93d4Ht4mtudLsSvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712416506; c=relaxed/simple;
	bh=CKBenssBGzjJlgAc02vWXNgpnbPMdt6v5r5iZT6m+1s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HiqTxy/2eD8ubQKwQsWvBWBC6J7oTcuQHmivQhqXwLU5OqFUGgu4PMji0uvG/AIo7PGy+cL66g++4gB+BZi8oMQuf8/TyGrd40ii/t0/4dw4b4ENMFy05ejqEHTwyeoV278VX6ql9ensK5haUK7KgYJt84mqSOEcZZbCge77ERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36854f4e9b3so31800005ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 08:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712416504; x=1713021304;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnO/znTh5UoeroiIt/dEXCh2utdXHDFH/n3fM2JwmB8=;
        b=ThuvJTzDCaEgDkF4w3AjRR0GL3I8wnEs7GTmDYyycr5p6J4+aeze599/mOPNuur0sE
         iKrrMcOufINJLrEOS1sXZMajjPo1NtAxOoJ1Wv+CEJRKWhzn2BfNTpHqcMgFYHmwzOZw
         6WxBX3K2UDN6ave19AOBWPS4GTbDXNM4a4aHgl1E+1s7myrcR05UIjVUum/whaLUlQd8
         MBWv/yAYwOZ+fiXquiE6rUqFbrN9AcNLLtDhCHlya4L2DhxdhS3dFUmNUzojaAXxtgN7
         T/qxOKI1reNqeW8dkhVAZQ+CjdH91oTUedG4AWNIzghvrRPfBNp4ModoxBcEUbFS8QFl
         E5og==
X-Forwarded-Encrypted: i=1; AJvYcCUSz3dENkSbmSElSRbEMXe+TLe/oi11imswyA1KhJ7Li09TEZKLBQlHwiqmnmsfPYPt1bIjL/7/cmurZCueza1hMvyMBxVn3HiJwn4Y
X-Gm-Message-State: AOJu0YylzDcz2nLggIMO47hXQIlVvef+A2RpaKFX3EC+9e3MS8i+rVjB
	GHnBoJGRzr9bH4Txf3cIkxdBLsLth1oX8ZRdI1Dfq5Ne9tnOQG6hXksw7kl/9mxmsM/tlkf8Tu9
	QZVhZ1uk/ZgrTIkIwnfPaHjJOLbkrr1Fit8wJJRSGNs1ZxLgBXrjfRGo=
X-Google-Smtp-Source: AGHT+IE/DMWL6MR4sC2ywZ9c3w11FAtPe8ojHVsRekWZiesOW74RMOuh3Fy2d8nXxJ7rILA62POzVLTgUTwY7vCf13H4fbSVgc5x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0b:b0:368:8135:4559 with SMTP id
 i11-20020a056e021b0b00b0036881354559mr345309ilv.6.1712416503874; Sat, 06 Apr
 2024 08:15:03 -0700 (PDT)
Date: Sat, 06 Apr 2024 08:15:03 -0700
In-Reply-To: <20240405052841.97772-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006be40806156f09db@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in unix_del_edges
From: syzbot <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

006703][    T1] usbcore: registered new interface driver dln2
[    8.008304][    T1] usbcore: registered new interface driver pn533_usb
[    8.015792][    T1] nfcsim 0.2 initialized
[    8.016960][    T1] usbcore: registered new interface driver port100
[    8.018599][    T1] usbcore: registered new interface driver nfcmrvl
[    8.024908][    T1] Loading iSCSI transport class v2.0-870.
[    8.043578][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    8.053585][    T1] ------------[ cut here ]------------
[    8.054621][    T1] refcount_t: decrement hit 0; leaking memory.
[    8.056227][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    8.057690][    T1] Modules linked in:
[    8.058278][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00291-g4090fa373f0e-dirty #0
[    8.059690][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.061033][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.061863][    T1] Code: b2 00 00 00 e8 97 bb e9 fc 5b 5d c3 cc cc cc c=
c e8 8b bb e9 fc c6 05 2e c7 e7 0a 01 90 48 c7 c7 e0 33 1f 8c e8 c7 57 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 6b bb e9 fc c6 05 0b c7 e7 0a 01 90 48 c7 c7
[    8.066117][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.067097][    T1] RAX: 9bcc421b8c8b6e00 RBX: ffff8881407a5a9c RCX: fff=
f8880166d0000
[    8.068202][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.069406][    T1] RBP: 0000000000000004 R08: ffffffff815800a2 R09: fff=
ffbfff1c396e0
[    8.070770][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000502cdc0
[    8.071923][    T1] R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 000=
0000000000000
[    8.073195][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    8.074997][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.076208][    T1] CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 000=
00000003506f0
[    8.077586][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.079021][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.080171][    T1] Call Trace:
[    8.080710][    T1]  <TASK>
[    8.081192][    T1]  ? __warn+0x163/0x4e0
[    8.082027][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.083285][    T1]  ? report_bug+0x2b3/0x500
[    8.084102][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.084911][    T1]  ? handle_bug+0x3e/0x70
[    8.085560][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.086541][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.087289][    T1]  ? __warn_printk+0x292/0x360
[    8.088095][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.089127][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.090489][    T1]  __free_pages_ok+0xc60/0xd90
[    8.091183][    T1]  make_alloc_exact+0xa3/0xf0
[    8.092072][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.093385][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.094888][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.095629][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.096312][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.097239][    T1]  ? really_probe+0x2b8/0xad0
[    8.098468][    T1]  ? driver_probe_device+0x50/0x430
[    8.099254][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.100277][    T1]  ? ret_from_fork+0x4b/0x80
[    8.100955][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.101863][    T1]  vring_create_virtqueue+0xca/0x110
[    8.102735][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.103769][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.104746][    T1]  setup_vq+0xe9/0x2d0
[    8.105350][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.106064][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.106837][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.107892][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.108758][    T1]  vp_setup_vq+0xbf/0x330
[    8.109837][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.110831][    T1]  ? ioread16+0x2f/0x90
[    8.111461][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.112303][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.113109][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.113869][    T1]  virtscsi_init+0x8db/0xd00
[    8.114601][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.115406][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.116284][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.117252][    T1]  ? vp_get+0xfd/0x140
[    8.118053][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.118880][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.119741][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.120734][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.121670][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.122793][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.123599][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.124434][    T1]  really_probe+0x2b8/0xad0
[    8.125161][    T1]  __driver_probe_device+0x1a2/0x390
[    8.125961][    T1]  driver_probe_device+0x50/0x430
[    8.126905][    T1]  __driver_attach+0x45f/0x710
[    8.127791][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.128630][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.129617][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.130766][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.131869][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.133108][    T1]  bus_add_driver+0x347/0x620
[    8.134579][    T1]  driver_register+0x23a/0x320
[    8.135468][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.136268][    T1]  virtio_scsi_init+0x65/0xe0
[    8.137251][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.138124][    T1]  do_one_initcall+0x248/0x880
[    8.139180][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.140100][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.141028][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.141940][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.142812][    T1]  ? do_initcalls+0x1c/0x80
[    8.143461][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.144181][    T1]  do_initcall_level+0x157/0x210
[    8.144944][    T1]  do_initcalls+0x3f/0x80
[    8.145717][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.146491][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.147543][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.148835][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.149734][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.150860][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.151964][    T1]  kernel_init+0x1d/0x2b0
[    8.152905][    T1]  ret_from_fork+0x4b/0x80
[    8.154244][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.155345][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.156184][    T1]  </TASK>
[    8.156670][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.157851][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00291-g4090fa373f0e-dirty #0
[    8.161190][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.162871][    T1] Call Trace:
[    8.162871][    T1]  <TASK>
[    8.162871][    T1]  dump_stack_lvl+0x241/0x360
[    8.162871][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.162871][    T1]  ? __pfx__printk+0x10/0x10
[    8.162871][    T1]  ? _printk+0xd5/0x120
[    8.162871][    T1]  ? vscnprintf+0x5d/0x90
[    8.162871][    T1]  panic+0x349/0x860
[    8.162871][    T1]  ? __warn+0x172/0x4e0
[    8.162871][    T1]  ? __pfx_panic+0x10/0x10
[    8.162871][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.162871][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.162871][    T1]  __warn+0x346/0x4e0
[    8.162871][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.162871][    T1]  report_bug+0x2b3/0x500
[    8.162871][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.162871][    T1]  handle_bug+0x3e/0x70
[    8.162871][    T1]  exc_invalid_op+0x1a/0x50
[    8.162871][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.162871][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.162871][    T1] Code: b2 00 00 00 e8 97 bb e9 fc 5b 5d c3 cc cc cc c=
c e8 8b bb e9 fc c6 05 2e c7 e7 0a 01 90 48 c7 c7 e0 33 1f 8c e8 c7 57 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 6b bb e9 fc c6 05 0b c7 e7 0a 01 90 48 c7 c7
[    8.162871][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.162871][    T1] RAX: 9bcc421b8c8b6e00 RBX: ffff8881407a5a9c RCX: fff=
f8880166d0000
[    8.162871][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.162871][    T1] RBP: 0000000000000004 R08: ffffffff815800a2 R09: fff=
ffbfff1c396e0
[    8.162871][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000502cdc0
[    8.162871][    T1] R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 000=
0000000000000
[    8.162871][    T1]  ? __warn_printk+0x292/0x360
[    8.162871][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.162871][    T1]  __free_pages_ok+0xc60/0xd90
[    8.162871][    T1]  make_alloc_exact+0xa3/0xf0
[    8.162871][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.162871][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.162871][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.162871][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.162871][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.162871][    T1]  ? really_probe+0x2b8/0xad0
[    8.162871][    T1]  ? driver_probe_device+0x50/0x430
[    8.162871][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.162871][    T1]  ? ret_from_fork+0x4b/0x80
[    8.162871][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.162871][    T1]  vring_create_virtqueue+0xca/0x110
[    8.162871][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.162871][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.162871][    T1]  setup_vq+0xe9/0x2d0
[    8.162871][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.162871][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.212873][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.212873][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.212873][    T1]  vp_setup_vq+0xbf/0x330
[    8.212873][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.212873][    T1]  ? ioread16+0x2f/0x90
[    8.212873][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.212873][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.212873][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.212873][    T1]  virtscsi_init+0x8db/0xd00
[    8.212873][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.212873][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.212873][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.212873][    T1]  ? vp_get+0xfd/0x140
[    8.212873][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.212873][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.212873][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.212873][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.212873][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.212873][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.212873][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.212873][    T1]  really_probe+0x2b8/0xad0
[    8.212873][    T1]  __driver_probe_device+0x1a2/0x390
[    8.212873][    T1]  driver_probe_device+0x50/0x430
[    8.212873][    T1]  __driver_attach+0x45f/0x710
[    8.212873][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.212873][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.212873][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.212873][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.212873][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.212873][    T1]  bus_add_driver+0x347/0x620
[    8.212873][    T1]  driver_register+0x23a/0x320
[    8.212873][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.212873][    T1]  virtio_scsi_init+0x65/0xe0
[    8.212873][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.212873][    T1]  do_one_initcall+0x248/0x880
[    8.212873][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.212873][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.212873][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.212873][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.212873][    T1]  ? do_initcalls+0x1c/0x80
[    8.212873][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.212873][    T1]  do_initcall_level+0x157/0x210
[    8.212873][    T1]  do_initcalls+0x3f/0x80
[    8.212873][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.212873][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.212873][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.212873][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.212873][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.212873][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.212873][    T1]  kernel_init+0x1d/0x2b0
[    8.212873][    T1]  ret_from_fork+0x4b/0x80
[    8.212873][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.212873][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.212873][    T1]  </TASK>
[    8.212873][    T1] Kernel Offset: disabled
[    8.212873][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build264214063=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at 0ee3535ea
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
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"0ee3535ea8ff21d50e44372bb1cfd147e2=
99ab5b\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D169731ad180000


Tested on:

commit:         4090fa37 af_unix: Replace garbage collection algorithm.
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-ne=
xt.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbe1e18a11ee6904=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D7f7f201cc2668a8fd=
169
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D15b3cca91800=
00


