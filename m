Return-Path: <linux-kernel+bounces-112713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F8B887D3F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922E61C20A0A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440AC1863C;
	Sun, 24 Mar 2024 14:55:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C417BD6
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292105; cv=none; b=aPL8Mgdekv+nHEXVsnFsXkp7KZGa1o3KI75U0/JzgXc6r57OXedmc9yypwmGqlWy1tCD2P48aS7VHPA1+WhRbb1exb722RBezS/e1RWNCfUbjg6p8cDHKufJHf7wz5VkwKHTreWnBa+TS+O9afVoUMQsqjlUqIvr2ZhIUGNFDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292105; c=relaxed/simple;
	bh=kjyONVhGYl6Qa5YL4yc52+aUAnE4mN74OI6uL39Rzhs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i3TOsGd2C228uIMLA6xrJMlUY+P9FU4waGCQjuwWEYY0GyYiWVcuhqZKUZx+nWZ0Tz1vlWeeDKIGbWZsDCIQQs9FkrIu68HHyMJG99EHyVo0JVi5izWbkTa0V/R0BxUcR1cwADW1z2AyqYXKoBO9eJDwj9fS1niyTnfuqTEQjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so346721639f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 07:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711292102; x=1711896902;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0Co+E4Xnh0iSthGNQYnR5J0pBpXWw668MNVfs5tQr0=;
        b=sbvC8MlRC+I3E75hcKpr8ynTDlZEOjS7fUTQrzVWEVxXcYEy5gABJCi7yj/M7BwfLH
         NVd6bOeNhRdMROTappxF0kmAXNWf+sjtdak4rv/Ulry5xBMoGkFgWtu8Z4k6s3R6mY8n
         eI7iwVJ+BKBGxE1WfS4FcmVGe31o09Uc9htHHGfeRn16//eXRoC5z9RjCYJI6VaD5PAj
         xqTTTcey7ddlRMzmb8QZ1dDhhkQTYl6OARhXDhLHWd9g8aoqZnJrbSQ/oJv70VqvVcX7
         KjSv65bQeDPyqTKWLDGYb7LB5Zq7UgoGe7GuE4K5gNfxoAAFo0WmpZPshkws3Uh9mcu0
         Fusg==
X-Forwarded-Encrypted: i=1; AJvYcCU+EGNQmkd4BDGDBeMb5E1xPorhlYP8BJyh41v0uIIz44Ulg609vlegzVUNHecm/o46FeQxDNeb8fchNbCkwQiN1FljS6H5sG2tDjwd
X-Gm-Message-State: AOJu0Ywtn6hjOKfFuJDoizB/91/VVgQvbCNEp/mgu77NXOUrdTrfjcRB
	IjCMtZTSSScF2CMdoJnXxYPPQp2aT+OW28NhS/zRis1k6e7ux57B/eMJgvbzIGkDWlw2IiJhsmP
	dVrPjSdkfcgo16k1ws5brcpmVxTlOY0U6CfUQeWgHg8iPY6WtIQa4Pq0=
X-Google-Smtp-Source: AGHT+IEgjnMA0yYTRxxIZnInUQ8hRcwi9SvhsPehZjJdTHFYM800UKEPyRl5wLPfi20fM9ln46F7me2+VLv45cUua9bUaoSZWByL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3791:b0:47c:1875:7d8e with SMTP id
 w17-20020a056638379100b0047c18757d8emr97715jal.2.1711292102611; Sun, 24 Mar
 2024 07:55:02 -0700 (PDT)
Date: Sun, 24 Mar 2024 07:55:02 -0700
In-Reply-To: <20240324142705.3345-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2240d0614693df3@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

connector registered
[    9.638214][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[    9.649661][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[    9.748228][    T1] Console: switching to colour frame buffer device 128=
x48
[    9.766879][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[    9.769266][    T1] usbcore: registered new interface driver udl
[    9.864681][    T1] brd: module loaded
[    9.979253][    T1] loop: module loaded
[   10.146705][    T1] zram: Added device: zram0
[   10.159595][    T1] null_blk: disk nullb0 created
[   10.160638][    T1] null_blk: module loaded
[   10.163494][    T1] Guest personality initialized and is inactive
[   10.165338][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[   10.166752][    T1] Initialized host personality
[   10.167782][    T1] usbcore: registered new interface driver rtsx_usb
[   10.169480][    T1] usbcore: registered new interface driver viperboard
[   10.171035][    T1] usbcore: registered new interface driver dln2
[   10.176227][    T1] usbcore: registered new interface driver pn533_usb
[   10.185872][    T1] nfcsim 0.2 initialized
[   10.187457][    T1] usbcore: registered new interface driver port100
[   10.189293][    T1] usbcore: registered new interface driver nfcmrvl
[   10.197993][    T1] Loading iSCSI transport class v2.0-870.
[   10.219498][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[   10.232577][    T1] ------------[ cut here ]------------
[   10.233791][    T1] refcount_t: decrement hit 0; leaking memory.
[   10.234959][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1ed/0x210
[   10.236551][    T1] Modules linked in:
[   10.237185][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-13213-g70293240c5ce-dirty #0
[   10.238831][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   10.240714][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[   10.241704][    T1] Code: 8b e8 97 41 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 f8 d2 0f fd c6 05 3b 02 4d 0b 01 90 48 c7 c7 80 e3 8e 8b e8 74 41 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 82 fb 6a fd e9 44 fe ff ff
[   10.247715][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[   10.248637][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[   10.250131][    T1] RDX: ffff888016ec8000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[   10.251308][    T1] RBP: ffff888021c0112c R08: 0000000000000001 R09: 000=
0000000000000
[   10.252934][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888021c0112c
[   10.254160][    T1] R13: 0000000000000000 R14: 00000000022200ba R15: fff=
f888140666d88
[   10.255366][    T1] FS:  0000000000000000(0000) GS:ffff8880b9200000(0000=
) knlGS:0000000000000000
[   10.256931][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.257864][    T1] CR2: ffff88823ffff000 CR3: 000000000d97a000 CR4: 000=
00000003506f0
[   10.259800][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   10.261255][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   10.262505][    T1] Call Trace:
[   10.262993][    T1]  <TASK>
[   10.263430][    T1]  ? show_regs+0x8c/0xa0
[   10.264145][    T1]  ? __warn+0xe5/0x3c0
[   10.264814][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[   10.265735][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.266801][    T1]  ? report_bug+0x3c0/0x580
[   10.268137][    T1]  ? handle_bug+0x3d/0x70
[   10.269121][    T1]  ? exc_invalid_op+0x17/0x50
[   10.270194][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   10.270991][    T1]  ? __warn_printk+0x199/0x350
[   10.271883][    T1]  ? __warn_printk+0x1a6/0x350
[   10.272928][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.273890][    T1]  __reset_page_owner+0x2ea/0x370
[   10.274676][    T1]  __free_pages_ok+0x5a9/0xbf0
[   10.275425][    T1]  ? __split_page_owner+0xdd/0x120
[   10.276246][    T1]  make_alloc_exact+0x165/0x260
[   10.277164][    T1]  vring_alloc_queue+0xc1/0x110
[   10.278056][    T1]  vring_alloc_queue_split+0x186/0x510
[   10.278834][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[   10.279802][    T1]  ? kasan_save_stack+0x42/0x60
[   10.280646][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.281878][    T1]  vring_create_virtqueue_split+0xe8/0x280
[   10.282754][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.283453][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[   10.284677][    T1]  ? virtio_scsi_init+0x75/0x100
[   10.285450][    T1]  ? do_one_initcall+0x128/0x700
[   10.286310][    T1]  ? kernel_init_freeable+0x69d/0xca0
[   10.287533][    T1]  vring_create_virtqueue+0xd7/0x140
[   10.288470][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.289339][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.290146][    T1]  setup_vq+0x123/0x2f0
[   10.290740][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.291480][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.292515][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.293377][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.294533][    T1]  vp_setup_vq+0xb1/0x380
[   10.295355][    T1]  ? iowrite16+0x55/0x80
[   10.295966][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.296850][    T1]  vp_find_vqs_msix+0x661/0xe30
[   10.297706][    T1]  vp_find_vqs+0x58/0x560
[   10.298344][    T1]  virtscsi_init+0x459/0x9f0
[   10.299048][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   10.299771][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   10.300807][    T1]  ? ioread8+0x4e/0xa0
[   10.301547][    T1]  ? vp_get+0xf6/0x140
[   10.302238][    T1]  virtscsi_probe+0x3b2/0xdd0
[   10.302907][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   10.303636][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[   10.304612][    T1]  ? vring_transport_features+0x49/0xb0
[   10.305447][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   10.306252][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   10.307167][    T1]  really_probe+0x23e/0xa90
[   10.307868][    T1]  __driver_probe_device+0x1de/0x440
[   10.308791][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   10.309631][    T1]  driver_probe_device+0x4c/0x1b0
[   10.310356][    T1]  __driver_attach+0x283/0x580
[   10.311185][    T1]  ? __pfx___driver_attach+0x10/0x10
[   10.312186][    T1]  bus_for_each_dev+0x13c/0x1d0
[   10.312922][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   10.313703][    T1]  bus_add_driver+0x2ed/0x640
[   10.314375][    T1]  driver_register+0x15c/0x4b0
[   10.315145][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.315944][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.316816][    T1]  virtio_scsi_init+0x75/0x100
[   10.317552][    T1]  do_one_initcall+0x128/0x700
[   10.318376][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   10.319134][    T1]  ? trace_kmalloc+0x2d/0xe0
[   10.319810][    T1]  ? __kmalloc+0x218/0x440
[   10.320418][    T1]  kernel_init_freeable+0x69d/0xca0
[   10.321177][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.321967][    T1]  kernel_init+0x1c/0x2b0
[   10.322712][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.324603][    T1]  ret_from_fork+0x45/0x80
[   10.326072][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.327715][    T1]  ret_from_fork_asm+0x1a/0x30
[   10.329055][    T1]  </TASK>
[   10.329910][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   10.331883][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-13213-g70293240c5ce-dirty #0
[   10.331958][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   10.331958][    T1] Call Trace:
[   10.331958][    T1]  <TASK>
[   10.331958][    T1]  dump_stack_lvl+0x3d/0x1f0
[   10.331958][    T1]  panic+0x6f5/0x7a0
[   10.331958][    T1]  ? __pfx_panic+0x10/0x10
[   10.331958][    T1]  ? show_trace_log_lvl+0x363/0x500
[   10.331958][    T1]  ? check_panic_on_warn+0x1f/0xb0
[   10.331958][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.331958][    T1]  check_panic_on_warn+0xab/0xb0
[   10.331958][    T1]  __warn+0xf1/0x3c0
[   10.331958][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[   10.331958][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.331958][    T1]  report_bug+0x3c0/0x580
[   10.331958][    T1]  handle_bug+0x3d/0x70
[   10.331958][    T1]  exc_invalid_op+0x17/0x50
[   10.331958][    T1]  asm_exc_invalid_op+0x1a/0x20
[   10.331958][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[   10.331958][    T1] Code: 8b e8 97 41 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 f8 d2 0f fd c6 05 3b 02 4d 0b 01 90 48 c7 c7 80 e3 8e 8b e8 74 41 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 82 fb 6a fd e9 44 fe ff ff
[   10.331958][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[   10.331958][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[   10.331958][    T1] RDX: ffff888016ec8000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[   10.331958][    T1] RBP: ffff888021c0112c R08: 0000000000000001 R09: 000=
0000000000000
[   10.331958][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888021c0112c
[   10.331958][    T1] R13: 0000000000000000 R14: 00000000022200ba R15: fff=
f888140666d88
[   10.331958][    T1]  ? __warn_printk+0x199/0x350
[   10.331958][    T1]  ? __warn_printk+0x1a6/0x350
[   10.331958][    T1]  __reset_page_owner+0x2ea/0x370
[   10.331958][    T1]  __free_pages_ok+0x5a9/0xbf0
[   10.331958][    T1]  ? __split_page_owner+0xdd/0x120
[   10.331958][    T1]  make_alloc_exact+0x165/0x260
[   10.331958][    T1]  vring_alloc_queue+0xc1/0x110
[   10.331958][    T1]  vring_alloc_queue_split+0x186/0x510
[   10.331958][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[   10.331958][    T1]  ? kasan_save_stack+0x42/0x60
[   10.331958][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.331958][    T1]  vring_create_virtqueue_split+0xe8/0x280
[   10.331958][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.331958][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[   10.331958][    T1]  ? virtio_scsi_init+0x75/0x100
[   10.331958][    T1]  ? do_one_initcall+0x128/0x700
[   10.331958][    T1]  ? kernel_init_freeable+0x69d/0xca0
[   10.331958][    T1]  vring_create_virtqueue+0xd7/0x140
[   10.331958][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.331958][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.331958][    T1]  setup_vq+0x123/0x2f0
[   10.331958][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.331958][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.331958][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.331958][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.331958][    T1]  vp_setup_vq+0xb1/0x380
[   10.331958][    T1]  ? iowrite16+0x55/0x80
[   10.331958][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.331958][    T1]  vp_find_vqs_msix+0x661/0xe30
[   10.331958][    T1]  vp_find_vqs+0x58/0x560
[   10.331958][    T1]  virtscsi_init+0x459/0x9f0
[   10.331958][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   10.331958][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   10.331958][    T1]  ? ioread8+0x4e/0xa0
[   10.331958][    T1]  ? vp_get+0xf6/0x140
[   10.331958][    T1]  virtscsi_probe+0x3b2/0xdd0
[   10.331958][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   10.331958][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[   10.331958][    T1]  ? vring_transport_features+0x49/0xb0
[   10.331958][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   10.331958][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   10.331958][    T1]  really_probe+0x23e/0xa90
[   10.331958][    T1]  __driver_probe_device+0x1de/0x440
[   10.331958][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   10.331958][    T1]  driver_probe_device+0x4c/0x1b0
[   10.331958][    T1]  __driver_attach+0x283/0x580
[   10.331958][    T1]  ? __pfx___driver_attach+0x10/0x10
[   10.331958][    T1]  bus_for_each_dev+0x13c/0x1d0
[   10.331958][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   10.331958][    T1]  bus_add_driver+0x2ed/0x640
[   10.331958][    T1]  driver_register+0x15c/0x4b0
[   10.331958][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.331958][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.331958][    T1]  virtio_scsi_init+0x75/0x100
[   10.331958][    T1]  do_one_initcall+0x128/0x700
[   10.331958][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   10.331958][    T1]  ? trace_kmalloc+0x2d/0xe0
[   10.331958][    T1]  ? __kmalloc+0x218/0x440
[   10.331958][    T1]  kernel_init_freeable+0x69d/0xca0
[   10.331958][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.331958][    T1]  kernel_init+0x1c/0x2b0
[   10.331958][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.331958][    T1]  ret_from_fork+0x45/0x80
[   10.331958][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.331958][    T1]  ret_from_fork_asm+0x1a/0x30
[   10.331958][    T1]  </TASK>
[   10.331958][    T1] Kernel Offset: disabled
[   10.331958][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2246881086=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at db5b7ff0c
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
/syzkaller/prog.GitRevision=3Ddb5b7ff0c1508e1f6bc77ba4df578cabb88b9914 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240312-201727'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Ddb5b7ff0c1508e1f6bc77ba4df578cabb88b9914 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240312-201727'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Ddb5b7ff0c1508e1f6bc77ba4df578cabb88b9914 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240312-201727'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"db5b7ff0c1508e1f6bc77ba4df578cabb8=
8b9914\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D14414711180000


Tested on:

commit:         70293240 Merge tag 'timers-urgent-2024-03-23' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8f186ceee5fcb0b=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd2a2c639d03ac200a=
4f1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D127942311800=
00


