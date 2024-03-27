Return-Path: <linux-kernel+bounces-121470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C488E85E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E0C1F33223
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB412E1E3;
	Wed, 27 Mar 2024 14:58:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC512D744
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551486; cv=none; b=TLbJv+CDPex+g85ehIJ3FZVNTvTD4ifckFKgGpqApKe0WcJZ2nRvp70GW54sP9qD1kgrKoLT1m+QM18GtvND2ccOCvBTo3jU2xousp84TNs2tEqGlOUOZ595T6Ys/V6SWjaAc5VYk5S2xYFrvm92I1BUt97UZY+vIG2qPE0CgB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551486; c=relaxed/simple;
	bh=Gvk3JygpGH/sWwMChmLiDYSa5LkU3bPpUocHaHE7BT8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qO0dg/HV0D90XepvNH/zX/f8DQQsh0AeiemH3hr/UQ74qVUhqyDCBFaObH5ywLwxJJ7qAzB1M5oYsv22I/HW3LABalEWyaLyxJHs09s6jDvkMfQlwCiwRa9bLP7CL88VN8W85EXvu/ZYhDm37kUnaphF/4Lwa/43nGDt+EXUwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a6a04d9so801309339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711551483; x=1712156283;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSQw7s4r42qfOoaEXGyys4P93EVeiXWibRD7pWoFeNE=;
        b=kYPKd8eD55BQ06smtcNsRdTOL4NJipPhQHho/H7ycrW/XlLlvCf1n1HpXXQ2AFcsff
         DBx0K5TWyXJuGS7NiI4N1VRM9FBgt+rCblk8/r4t45s5zZlVJY8Ei6hdWwHc0xxbvUaT
         vxDFONxDXgKRruokcpbnPaMbPIfum+jrA9FFz+tTzDozPTkWOw1xCUsohpfoqRAOIQcu
         ClwAJ9kpVR1OCvSN5fcIvsJ/H9zY3HutpCRe0aJ1n21TYFWwey8kfzXe9r5PoTgq/gBc
         JPJbAwHhwXP6a3SqigN7wi17Xd54l3pQCwWqcWIT+L+6qWmLTlmp/R9NHjX7j0rulmW2
         Becw==
X-Forwarded-Encrypted: i=1; AJvYcCUUap1zdnIaaikmAzn2WzDYcmsqB6Xfpc2jyZ+nzCiPfzeDHdc0kduoqQjHNbBQAVulhxnH3KYEINClENk22K4EZawHDFBvnc+Nfasb
X-Gm-Message-State: AOJu0Yza2qXxnauGnP7y+aLEdWzQsbDPYcPCx7tygwQrK8TgAjSZ/a8O
	YZfAPTN9Ukj8HAI5FstA/OYoWUw3OMJY4nFCaUyTLX0J3C+PNx2Pw7m3FuvCyiAJ3UOk5sbYL/X
	iXnRrWw6SneSCpchVtPDaAvkThI8S/tSRVSTnKHAZyfNsTKS3JL6t/kQ=
X-Google-Smtp-Source: AGHT+IGtavCGVMYpCWjn99uzXLOo1uh6FbVqOg2YQDR+lUlMbEp2CvEb0vLEcUeXkUka+rktds6SB4ShrjngyUZFuUUD7fLC0klW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3788:b0:47c:15ed:deae with SMTP id
 w8-20020a056638378800b0047c15eddeaemr671318jal.2.1711551483125; Wed, 27 Mar
 2024 07:58:03 -0700 (PDT)
Date: Wed, 27 Mar 2024 07:58:03 -0700
In-Reply-To: <tencent_87499A2ED6AEFA4CB927C7C6F992F5067F06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ab3a50614a5a2b8@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 7.829816][    T1] usbcore: registered new interface driver port100
[    7.831413][    T1] usbcore: registered new interface driver nfcmrvl
[    7.837905][    T1] Loading iSCSI transport class v2.0-870.
[    7.858722][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.869143][    T1] ------------[ cut here ]------------
[    7.870105][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.872514][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.874530][    T1] Modules linked in:
[    7.875370][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-g7033999ecd7b-dirty #0
[    7.877291][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    7.879264][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.881153][    T1] Code: b2 00 00 00 e8 57 df e9 fc 5b 5d c3 cc cc cc c=
c e8 4b df e9 fc c6 05 4f 89 e8 0a 01 90 48 c7 c7 60 33 1f 8c e8 87 7b ac f=
c 90 <0f> 0b 90 90 eb d9 e8 2b df e9 fc c6 05 2c 89 e8 0a 01 90 48 c7 c7
[    7.884566][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.885519][    T1] RAX: 2b377ad567545500 RBX: ffff888020dced4c RCX: fff=
f8880166d8000
[    7.886879][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000000
[    7.888277][    T1] RBP: 0000000000000004 R08: ffffffff815800c2 R09: fff=
ffbfff1c396e0
[    7.889846][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000501edc0
[    7.891597][    T1] R13: ffffea000501edc8 R14: 1ffffd4000a03db9 R15: 000=
0000000000000
[    7.892863][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.896023][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.897831][    T1] CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 000=
00000003506f0
[    7.899872][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.902920][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.905308][    T1] Call Trace:
[    7.906155][    T1]  <TASK>
[    7.907108][    T1]  ? __warn+0x163/0x4e0
[    7.908236][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.909628][    T1]  ? report_bug+0x2b3/0x500
[    7.911322][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.912413][    T1]  ? handle_bug+0x3e/0x70
[    7.913104][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.913916][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.914971][    T1]  ? __warn_printk+0x292/0x360
[    7.915905][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.917491][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.919275][    T1]  __free_pages_ok+0xc60/0xd90
[    7.920758][    T1]  make_alloc_exact+0xa3/0xf0
[    7.921785][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.922946][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.929618][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.930612][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.931909][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.933205][    T1]  ? really_probe+0x2b8/0xad0
[    7.934463][    T1]  ? driver_probe_device+0x50/0x430
[    7.936429][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.937419][    T1]  ? ret_from_fork+0x4b/0x80
[    7.938584][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.940730][    T1]  vring_create_virtqueue+0xca/0x110
[    7.941726][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.942814][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.943976][    T1]  setup_vq+0xe9/0x2d0
[    7.944801][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.945576][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.946948][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.948006][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.949084][    T1]  vp_setup_vq+0xbf/0x330
[    7.949824][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.950979][    T1]  ? ioread16+0x2f/0x90
[    7.951822][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.953388][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.954915][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.955862][    T1]  virtscsi_init+0x8db/0xd00
[    7.956749][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.957896][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.959614][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.961011][    T1]  ? vp_get+0xfd/0x140
[    7.962132][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.962965][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.964000][    T1]  ? vp_set+0x34d/0x350
[    7.965137][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    7.966023][    T1]  ? vp_set_status+0x1a/0x40
[    7.966940][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.968109][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.969198][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.970151][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.971070][    T1]  really_probe+0x2b8/0xad0
[    7.971988][    T1]  __driver_probe_device+0x1a2/0x390
[    7.973433][    T1]  driver_probe_device+0x50/0x430
[    7.974431][    T1]  __driver_attach+0x45f/0x710
[    7.975759][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.977202][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.978309][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.979888][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.981067][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.982284][    T1]  bus_add_driver+0x347/0x620
[    7.983346][    T1]  driver_register+0x23a/0x320
[    7.984227][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.985533][    T1]  virtio_scsi_init+0x65/0xe0
[    7.986807][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.988078][    T1]  do_one_initcall+0x248/0x880
[    7.989286][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.990438][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.991719][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.993284][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.994653][    T1]  ? do_initcalls+0x1c/0x80
[    7.995768][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.996707][    T1]  do_initcall_level+0x157/0x210
[    7.997710][    T1]  do_initcalls+0x3f/0x80
[    7.998399][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.999965][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.001669][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.003259][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.003962][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.005204][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.006149][    T1]  kernel_init+0x1d/0x2b0
[    8.007084][    T1]  ret_from_fork+0x4b/0x80
[    8.008082][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.009623][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.010782][    T1]  </TASK>
[    8.011305][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.012595][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-g7033999ecd7b-dirty #0
[    8.014252][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    8.015689][    T1] Call Trace:
[    8.016148][    T1]  <TASK>
[    8.016559][    T1]  dump_stack_lvl+0x241/0x360
[    8.017219][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.017934][    T1]  ? __pfx__printk+0x10/0x10
[    8.018600][    T1]  ? _printk+0xd5/0x120
[    8.019417][    T1]  ? vscnprintf+0x5d/0x90
[    8.020186][    T1]  panic+0x349/0x860
[    8.020754][    T1]  ? __warn+0x172/0x4e0
[    8.020754][    T1]  ? __pfx_panic+0x10/0x10
[    8.020754][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.020754][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.020754][    T1]  __warn+0x346/0x4e0
[    8.020754][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.020754][    T1]  report_bug+0x2b3/0x500
[    8.020754][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.020754][    T1]  handle_bug+0x3e/0x70
[    8.020754][    T1]  exc_invalid_op+0x1a/0x50
[    8.020754][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.020754][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.020754][    T1] Code: b2 00 00 00 e8 57 df e9 fc 5b 5d c3 cc cc cc c=
c e8 4b df e9 fc c6 05 4f 89 e8 0a 01 90 48 c7 c7 60 33 1f 8c e8 87 7b ac f=
c 90 <0f> 0b 90 90 eb d9 e8 2b df e9 fc c6 05 2c 89 e8 0a 01 90 48 c7 c7
[    8.030364][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.030364][    T1] RAX: 2b377ad567545500 RBX: ffff888020dced4c RCX: fff=
f8880166d8000
[    8.030364][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000000
[    8.030364][    T1] RBP: 0000000000000004 R08: ffffffff815800c2 R09: fff=
ffbfff1c396e0
[    8.030364][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000501edc0
[    8.030364][    T1] R13: ffffea000501edc8 R14: 1ffffd4000a03db9 R15: 000=
0000000000000
[    8.030364][    T1]  ? __warn_printk+0x292/0x360
[    8.030364][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.040252][    T1]  __free_pages_ok+0xc60/0xd90
[    8.040252][    T1]  make_alloc_exact+0xa3/0xf0
[    8.040252][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.040252][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.040252][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.040252][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.040252][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.040252][    T1]  ? really_probe+0x2b8/0xad0
[    8.040252][    T1]  ? driver_probe_device+0x50/0x430
[    8.040252][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.040252][    T1]  ? ret_from_fork+0x4b/0x80
[    8.050346][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.050346][    T1]  vring_create_virtqueue+0xca/0x110
[    8.050346][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.050346][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.050346][    T1]  setup_vq+0xe9/0x2d0
[    8.050346][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.050346][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.050346][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.050346][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.050346][    T1]  vp_setup_vq+0xbf/0x330
[    8.050346][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.050346][    T1]  ? ioread16+0x2f/0x90
[    8.050346][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.050346][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.060243][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.060243][    T1]  virtscsi_init+0x8db/0xd00
[    8.060243][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.060243][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.060243][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.060243][    T1]  ? vp_get+0xfd/0x140
[    8.060243][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.060243][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.060243][    T1]  ? vp_set+0x34d/0x350
[    8.060243][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    8.060243][    T1]  ? vp_set_status+0x1a/0x40
[    8.060243][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.060243][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.070334][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.070334][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.070334][    T1]  really_probe+0x2b8/0xad0
[    8.070334][    T1]  __driver_probe_device+0x1a2/0x390
[    8.070334][    T1]  driver_probe_device+0x50/0x430
[    8.070334][    T1]  __driver_attach+0x45f/0x710
[    8.070334][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.070334][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.070334][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.070334][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.070334][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.070334][    T1]  bus_add_driver+0x347/0x620
[    8.080263][    T1]  driver_register+0x23a/0x320
[    8.080263][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.080263][    T1]  virtio_scsi_init+0x65/0xe0
[    8.080263][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.080263][    T1]  do_one_initcall+0x248/0x880
[    8.080263][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.080263][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.080263][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.080263][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.080263][    T1]  ? do_initcalls+0x1c/0x80
[    8.080263][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.080263][    T1]  do_initcall_level+0x157/0x210
[    8.080263][    T1]  do_initcalls+0x3f/0x80
[    8.080263][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.090336][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.090336][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.090336][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.090336][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.090336][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.090336][    T1]  kernel_init+0x1d/0x2b0
[    8.090336][    T1]  ret_from_fork+0x4b/0x80
[    8.090336][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.090336][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.090336][    T1]  </TASK>
[    8.090336][    T1] Kernel Offset: disabled
[    8.090336][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3591245852=3D/tmp/go-build -gno-record-gc=
c-switches'

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
https://syzkaller.appspot.com/x/error.txt?x=3D12d2cb65180000


Tested on:

commit:         7033999e Merge tag 'printk-for-6.9-rc2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7b667bc37450fdc=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3Daf9492708df979719=
8d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1066d4211800=
00


