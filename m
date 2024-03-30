Return-Path: <linux-kernel+bounces-125631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A618929D5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0191C20F8D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39162BA28;
	Sat, 30 Mar 2024 08:58:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E2881F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789087; cv=none; b=AK+qM2UtIX1Fep8KgX5yerPioUZmzBrRnNajJ8ZY8PhDNHW/fgaToVLTqaEUTGx1mx5JFwj8Vf23Qb9bmUVSVGtqCMUu8DrQjjJR+WxnMWYjTKrDhP5/JsdH9zAJgPUTWjT8TJ3IbXrVCNpTKW9avKhISq+DPmlf/QR+hZfJ/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789087; c=relaxed/simple;
	bh=h9CPE8vlxHNbIG5ZG2JCd77Amdhd8Fio7AeqbnRH13g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JLzkhYq8LYoVF8y5bs/PsSBfagMpjSLZSZPk4n0BSeSRlsWMsLcyltuuICuhiU9ANE7jqnqntU8mD9QNQ1/FXBnRrdHg0UAVQtHIbKNJMmxsfj7jFu5IFvuVAGBNU/GIpzvXIhlmMJj1XLHmNpP0FKW2pCAZucC8BPebS0vwZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cef80a1e5bso251124539f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 01:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711789084; x=1712393884;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TpT1glQ+V3RK5vUTFqi50S7xiXmH1yno0yMMbvGLhQ=;
        b=DDjsgxwHnKRu5+wwd9OihQdvjh/LGTeczrGPPiG0VZPOfTSHxWLs2v1Qli7Q/VxF7D
         MgXKCWtOMpmnP/0lAx4pLlXUpAnOQOZMHMuJHG47JQiZEdi1NdoMY4uv5RtCM1doP9sn
         SUfq2z0LhrFtvHw2jLD2F3sarkwDhbhOrfYxCmuYr+oNhE0e0ElRsaTLhanOMg/jeOZ+
         XYZQgwECDkycQVomutnUk4XxKdkOOCPR2HjQb+oWbaq2ujp1G3zPp+EYbASLcwgRl66v
         iwFSi0PBMzAxbztH/6axMDkZeLKFOGOLcEMEU6c/7+Jq4C/TR/E6QTJ8Px1NAIt731DS
         Jb5w==
X-Forwarded-Encrypted: i=1; AJvYcCUkHq6C852AtWujTteTWCW6t11BpMF0iy/Zc6x3P2GUlQSeB/yIC5kH5syve8cWP9BwWE+cF3XR+u6a7SkLxRVmJf9cq+tKM2ZWHH8t
X-Gm-Message-State: AOJu0YyXdh4NZ9CGByYlIjy3Dgt431KPBO0PCvCz3yII/udwGW4eoLn0
	oRhKvLeCKMLKPIiFa4A4sYdxQOdguNYWxVfZzFqXwFnZOYkt500DirKCocP22tDdBPUFSL+n3Lt
	kP9mAf344x1qFLWvXprwSKGZJ7FlZmrz8F40GHjldn9Gcznjh0Ae3fBw=
X-Google-Smtp-Source: AGHT+IEXvL99AGanDp7vWZkL8quLqHc8AoCR46N1Odt0A6yBPeR7yHtdu4STQbu3nWBi1Ag01Lco9P4SrffQwrwLLrmiBsgNRe16
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:369:9361:5b6a with SMTP id
 j15-20020a056e02218f00b0036993615b6amr41740ila.5.1711789084277; Sat, 30 Mar
 2024 01:58:04 -0700 (PDT)
Date: Sat, 30 Mar 2024 01:58:04 -0700
In-Reply-To: <tencent_F85DE45D93995ACF9C8DD7A5FD0DC0921A07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c8d570614dcf412@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in tick_setup_sched_timer
From: syzbot <syzbot+e4374f6c021d422de3d1@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drm_connector registered
[   11.107844][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[   11.126768][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[   11.235459][    T1] Console: switching to colour frame buffer device 128=
x48
[   11.259808][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[   11.267554][    T1] usbcore: registered new interface driver udl
[   11.374239][    T1] brd: module loaded
[   11.501139][    T1] loop: module loaded
[   11.677668][    T1] zram: Added device: zram0
[   11.695347][    T1] null_blk: disk nullb0 created
[   11.700275][    T1] null_blk: module loaded
[   11.706181][    T1] Guest personality initialized and is inactive
[   11.713576][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[   11.721442][    T1] Initialized host personality
[   11.726520][    T1] usbcore: registered new interface driver rtsx_usb
[   11.734397][    T1] usbcore: registered new interface driver viperboard
[   11.742268][    T1] usbcore: registered new interface driver dln2
[   11.749350][    T1] usbcore: registered new interface driver pn533_usb
[   11.763332][    T1] nfcsim 0.2 initialized
[   11.767821][    T1] usbcore: registered new interface driver port100
[   11.775500][    T1] usbcore: registered new interface driver nfcmrvl
[   11.790533][    T1] Loading iSCSI transport class v2.0-870.
[   11.814992][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[   11.834309][    T1] ------------[ cut here ]------------
[   11.840069][    T1] refcount_t: decrement hit 0; leaking memory.
[   11.846833][    T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1ed/0x210
[   11.856073][    T1] Modules linked in:
[   11.860032][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-g486291a0e624-dirty #0
[   11.869766][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[   11.879854][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[   11.886039][    T1] Code: 8b e8 67 29 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 58 bb 0f fd c6 05 0d eb 4c 0b 01 90 48 c7 c7 80 e5 8e 8b e8 44 29 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 72 e7 6a fd e9 44 fe ff ff
[   11.905771][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[   11.912115][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[   11.920354][    T1] RDX: ffff888016ec0000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[   11.928321][    T1] RBP: ffff888020fac3bc R08: 0000000000000001 R09: 000=
0000000000000
[   11.936315][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888020fac3bc
[   11.944311][    T1] R13: 0000000000000000 R14: 00000000007400b9 R15: fff=
f888016853988
[   11.952567][    T1] FS:  0000000000000000(0000) GS:ffff8880b9300000(0000=
) knlGS:0000000000000000
[   11.961512][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.968083][    T1] CR2: 0000000000000000 CR3: 000000000d97a000 CR4: 000=
00000003506f0
[   11.976181][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   11.984211][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   11.992239][    T1] Call Trace:
[   11.995530][    T1]  <TASK>
[   11.998452][    T1]  ? show_regs+0x8c/0xa0
[   12.002745][    T1]  ? __warn+0xe5/0x3c0
[   12.006810][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[   12.012328][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   12.017871][    T1]  ? report_bug+0x3c0/0x580
[   12.022448][    T1]  ? handle_bug+0x3d/0x70
[   12.026794][    T1]  ? exc_invalid_op+0x17/0x50
[   12.031602][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   12.036639][    T1]  ? __warn_printk+0x199/0x350
[   12.041521][    T1]  ? __warn_printk+0x1a6/0x350
[   12.046283][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   12.051884][    T1]  __reset_page_owner+0x2ea/0x370
[   12.057140][    T1]  __free_pages_ok+0x5a9/0xbf0
[   12.061993][    T1]  ? __split_page_owner+0xdd/0x120
[   12.067111][    T1]  make_alloc_exact+0x165/0x260
[   12.072448][    T1]  vring_alloc_queue+0xc1/0x110
[   12.077349][    T1]  vring_alloc_queue_split+0x186/0x510
[   12.082874][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[   12.088882][    T1]  ? kasan_save_stack+0x42/0x60
[   12.093828][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.099615][    T1]  vring_create_virtqueue_split+0xe8/0x280
[   12.105518][    T1]  ? __pfx_vp_notify+0x10/0x10
[   12.110328][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[   12.116731][    T1]  ? virtio_scsi_init+0x75/0x100
[   12.121740][    T1]  ? do_one_initcall+0x128/0x700
[   12.126695][    T1]  ? kernel_init_freeable+0x69d/0xca0
[   12.132157][    T1]  vring_create_virtqueue+0xd7/0x140
[   12.137433][    T1]  ? __pfx_vp_notify+0x10/0x10
[   12.142247][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.148576][    T1]  setup_vq+0x123/0x2f0
[   12.152766][    T1]  ? __pfx_vp_notify+0x10/0x10
[   12.157544][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.163473][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.169167][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.174836][    T1]  vp_setup_vq+0xb1/0x380
[   12.179545][    T1]  ? iowrite16+0x55/0x80
[   12.183910][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.189632][    T1]  vp_find_vqs_msix+0x661/0xe30
[   12.194484][    T1]  vp_find_vqs+0x58/0x560
[   12.198919][    T1]  virtscsi_init+0x459/0x9f0
[   12.203694][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   12.209111][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   12.214606][    T1]  ? ioread8+0x4e/0xa0
[   12.218920][    T1]  ? vp_get+0xf6/0x140
[   12.223023][    T1]  virtscsi_probe+0x3b2/0xdd0
[   12.227732][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   12.233079][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[   12.239751][    T1]  ? vring_transport_features+0x49/0xb0
[   12.245404][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   12.250546][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   12.255937][    T1]  really_probe+0x23e/0xa90
[   12.260516][    T1]  __driver_probe_device+0x1de/0x440
[   12.265804][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   12.271660][    T1]  driver_probe_device+0x4c/0x1b0
[   12.276686][    T1]  __driver_attach+0x283/0x580
[   12.281478][    T1]  ? __pfx___driver_attach+0x10/0x10
[   12.286756][    T1]  bus_for_each_dev+0x13c/0x1d0
[   12.291626][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   12.297077][    T1]  bus_add_driver+0x2ed/0x640
[   12.301781][    T1]  driver_register+0x15c/0x4b0
[   12.306529][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   12.311922][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   12.317285][    T1]  virtio_scsi_init+0x75/0x100
[   12.322232][    T1]  do_one_initcall+0x128/0x700
[   12.327308][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   12.332699][    T1]  ? trace_kmalloc+0x2d/0xe0
[   12.337296][    T1]  ? __kmalloc+0x218/0x440
[   12.341776][    T1]  kernel_init_freeable+0x69d/0xca0
[   12.346990][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.351965][    T1]  kernel_init+0x1c/0x2b0
[   12.356292][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.361247][    T1]  ret_from_fork+0x45/0x80
[   12.365684][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.370654][    T1]  ret_from_fork_asm+0x1a/0x30
[   12.375521][    T1]  </TASK>
[   12.378535][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   12.380634][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-g486291a0e624-dirty #0
[   12.380634][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[   12.380634][    T1] Call Trace:
[   12.380634][    T1]  <TASK>
[   12.380634][    T1]  dump_stack_lvl+0x3d/0x1f0
[   12.380634][    T1]  panic+0x6f5/0x7a0
[   12.380634][    T1]  ? __pfx_panic+0x10/0x10
[   12.380634][    T1]  ? show_trace_log_lvl+0x363/0x500
[   12.428930][    T1]  ? check_panic_on_warn+0x1f/0xb0
[   12.428930][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   12.428930][    T1]  check_panic_on_warn+0xab/0xb0
[   12.428930][    T1]  __warn+0xf1/0x3c0
[   12.428930][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[   12.428930][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   12.428930][    T1]  report_bug+0x3c0/0x580
[   12.428930][    T1]  handle_bug+0x3d/0x70
[   12.428930][    T1]  exc_invalid_op+0x17/0x50
[   12.428930][    T1]  asm_exc_invalid_op+0x1a/0x20
[   12.478917][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[   12.478917][    T1] Code: 8b e8 67 29 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 58 bb 0f fd c6 05 0d eb 4c 0b 01 90 48 c7 c7 80 e5 8e 8b e8 44 29 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 72 e7 6a fd e9 44 fe ff ff
[   12.478917][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[   12.478917][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[   12.478917][    T1] RDX: ffff888016ec0000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[   12.478917][    T1] RBP: ffff888020fac3bc R08: 0000000000000001 R09: 000=
0000000000000
[   12.528953][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888020fac3bc
[   12.528953][    T1] R13: 0000000000000000 R14: 00000000007400b9 R15: fff=
f888016853988
[   12.528953][    T1]  ? __warn_printk+0x199/0x350
[   12.528953][    T1]  ? __warn_printk+0x1a6/0x350
[   12.528953][    T1]  __reset_page_owner+0x2ea/0x370
[   12.528953][    T1]  __free_pages_ok+0x5a9/0xbf0
[   12.528953][    T1]  ? __split_page_owner+0xdd/0x120
[   12.528953][    T1]  make_alloc_exact+0x165/0x260
[   12.579003][    T1]  vring_alloc_queue+0xc1/0x110
[   12.579003][    T1]  vring_alloc_queue_split+0x186/0x510
[   12.579003][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[   12.579003][    T1]  ? kasan_save_stack+0x42/0x60
[   12.579003][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.579003][    T1]  vring_create_virtqueue_split+0xe8/0x280
[   12.579003][    T1]  ? __pfx_vp_notify+0x10/0x10
[   12.579003][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[   12.579003][    T1]  ? virtio_scsi_init+0x75/0x100
[   12.628847][    T1]  ? do_one_initcall+0x128/0x700
[   12.628847][    T1]  ? kernel_init_freeable+0x69d/0xca0
[   12.628847][    T1]  vring_create_virtqueue+0xd7/0x140
[   12.628847][    T1]  ? __pfx_vp_notify+0x10/0x10
[   12.628847][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.628847][    T1]  setup_vq+0x123/0x2f0
[   12.628847][    T1]  ? __pfx_vp_notify+0x10/0x10
[   12.628847][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.628847][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.628847][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.678924][    T1]  vp_setup_vq+0xb1/0x380
[   12.678924][    T1]  ? iowrite16+0x55/0x80
[   12.678924][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   12.678924][    T1]  vp_find_vqs_msix+0x661/0xe30
[   12.678924][    T1]  vp_find_vqs+0x58/0x560
[   12.678924][    T1]  virtscsi_init+0x459/0x9f0
[   12.678924][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   12.678924][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   12.678924][    T1]  ? ioread8+0x4e/0xa0
[   12.678924][    T1]  ? vp_get+0xf6/0x140
[   12.728908][    T1]  virtscsi_probe+0x3b2/0xdd0
[   12.728908][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   12.728908][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[   12.728908][    T1]  ? vring_transport_features+0x49/0xb0
[   12.728908][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   12.728908][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   12.728908][    T1]  really_probe+0x23e/0xa90
[   12.728908][    T1]  __driver_probe_device+0x1de/0x440
[   12.728908][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   12.778943][    T1]  driver_probe_device+0x4c/0x1b0
[   12.778943][    T1]  __driver_attach+0x283/0x580
[   12.778943][    T1]  ? __pfx___driver_attach+0x10/0x10
[   12.778943][    T1]  bus_for_each_dev+0x13c/0x1d0
[   12.778943][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   12.778943][    T1]  bus_add_driver+0x2ed/0x640
[   12.778943][    T1]  driver_register+0x15c/0x4b0
[   12.778943][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   12.778943][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   12.778943][    T1]  virtio_scsi_init+0x75/0x100
[   12.828878][    T1]  do_one_initcall+0x128/0x700
[   12.828878][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   12.828878][    T1]  ? trace_kmalloc+0x2d/0xe0
[   12.828878][    T1]  ? __kmalloc+0x218/0x440
[   12.828878][    T1]  kernel_init_freeable+0x69d/0xca0
[   12.828878][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.828878][    T1]  kernel_init+0x1c/0x2b0
[   12.828878][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.828878][    T1]  ret_from_fork+0x45/0x80
[   12.828878][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.878911][    T1]  ret_from_fork_asm+0x1a/0x30
[   12.878911][    T1]  </TASK>
[   12.878911][    T1] Kernel Offset: disabled
[   12.878911][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3952729973=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 120789fd6
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
/syzkaller/prog.GitRevision=3D120789fd6691dd038dbe206ceeed95be5c006364 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240327-181839'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D120789fd6691dd038dbe206ceeed95be5c006364 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240327-181839'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D120789fd6691dd038dbe206ceeed95be5c006364 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240327-181839'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"120789fd6691dd038dbe206ceeed95be5c=
006364\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1464b30d180000


Tested on:

commit:         486291a0 Merge tag 'drm-fixes-2024-03-30' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df64ec427e98bccd=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3De4374f6c021d422de=
3d1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16783ae51800=
00


