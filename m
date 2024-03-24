Return-Path: <linux-kernel+bounces-112707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE124887D2E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0081C209D5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E42318037;
	Sun, 24 Mar 2024 14:16:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F82107
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711289764; cv=none; b=Am2FT3kAXisBHoUBfQZJLDZJymRmm3bBbsMFcghNAq02WIfl3tw0SYgTy4ouGUNrKNQaYI7K1f00KHkXy37iA6/mcQsaMEzoHfVAwIMo9DHUX9KVIZKhroLS56/jWHMJrm4T444nADpV4mqva70lHazfXKGfc0lH57FVX38jlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711289764; c=relaxed/simple;
	bh=2UK1hg+qoFH0GKKaEH/okxiujsGjlbg15M8ndI83/3A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RcpBG9Sktryh3mQHHSHRHj9QiS8LJUpikWnymr+2nsUPJXlQ3uLyDlutJywiI+oMLWrfadAfjqn+7uzSd+ngA2Z98fgswOtKJEi5zaIrhy0GqQ1lIdgaceBCsC74+R1bCl8kvhXhtmaBmSAjitfVjcZ5kY4CYcm7uoR1kSN4ECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so345083039f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 07:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711289762; x=1711894562;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/7lugnWHO62/jC9jfuJBF9HV0NTTiCFeAOVR8wIKgc=;
        b=cWUp7RQ7LR/p2+PitCixoqpcF8DA1kOyvl/gGD7NsoAfowtVk23OzEz3vLVOomzMvN
         555Bq+ShJEsR7Eif5mQjDAtM5jeNDttfPRudQFaw8Jt0J09TNdpCPLii2MjJn2Xda5XN
         r9zypnW2/KOXziVOoWu2aWo+25NQx43fKGxNWXvvXC+0Ezljj4hGtKvIxaPzx/aYcj8T
         FqU1xYUGdzpE50D73loSorSc9z5qWr4xUXyMT9wstxBlj1D7h870xhqh6b6cqsMBA0qG
         zrOsEUtH6CNpmgxPokq5UzyDU5v4g9rKnikyBZOBXjLIdB7K+vG+AtZuj4UlikrzXHUF
         HEqg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7gU8Pje8RRKnHY/YDwK7K3L+s7nCR2YBifAyyuS3k8WSKQ+6B3Jj1KDhhGwj/rllneIOKlwrTM6au1yqQeT9eki7yj64gH4yCmA5
X-Gm-Message-State: AOJu0YxaE9xQ028++XxCcZ0nK0T8BtHaoSzZYhaEfz/mYtnBq3X9Ow/G
	lpejGtRuRj5oM4uLsBFtE76y7qkOZySvLLZZbKsZvbVtLsRPKXdIiKK9/OD1Cso/hmAB4GqRVkl
	UPaWGdoKJgsZFkzsOxr0KU9IgJEOXu8tHpriGU8DL6MM1F2yGQn/gmMk=
X-Google-Smtp-Source: AGHT+IH1WvaHXNkV6KijnfxtgMNFjhaBJq4Gz6kSc0XzujRlUGSN/MRtLx1FIAx4siSfoZmyfjo7ExsUOXXUhnLAa1PU8VTKkeUT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a4:b0:47c:e26:fb6a with SMTP id
 t36-20020a05663834a400b0047c0e26fb6amr229926jal.4.1711289761562; Sun, 24 Mar
 2024 07:16:01 -0700 (PDT)
Date: Sun, 24 Mar 2024 07:16:01 -0700
In-Reply-To: <20240324133644.801040-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005893e4061468b209@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

connector registered
[    9.359254][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[    9.371403][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[    9.467368][    T1] Console: switching to colour frame buffer device 128=
x48
[    9.484342][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[    9.486204][    T1] usbcore: registered new interface driver udl
[    9.578720][    T1] brd: module loaded
[    9.693765][    T1] loop: module loaded
[    9.866647][    T1] zram: Added device: zram0
[    9.881604][    T1] null_blk: disk nullb0 created
[    9.882855][    T1] null_blk: module loaded
[    9.885500][    T1] Guest personality initialized and is inactive
[    9.888414][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[    9.889712][    T1] Initialized host personality
[    9.890736][    T1] usbcore: registered new interface driver rtsx_usb
[    9.892808][    T1] usbcore: registered new interface driver viperboard
[    9.895104][    T1] usbcore: registered new interface driver dln2
[    9.896706][    T1] usbcore: registered new interface driver pn533_usb
[    9.905496][    T1] nfcsim 0.2 initialized
[    9.907243][    T1] usbcore: registered new interface driver port100
[    9.909218][    T1] usbcore: registered new interface driver nfcmrvl
[    9.920947][    T1] Loading iSCSI transport class v2.0-870.
[    9.944531][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    9.956692][    T1] ------------[ cut here ]------------
[    9.958110][    T1] refcount_t: decrement hit 0; leaking memory.
[    9.959897][    T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1ed/0x210
[    9.961752][    T1] Modules linked in:
[    9.963568][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-13213-g70293240c5ce-dirty #0
[    9.965624][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    9.967593][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[    9.969540][    T1] Code: 8b e8 97 41 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 f8 d2 0f fd c6 05 3b 02 4d 0b 01 90 48 c7 c7 80 e3 8e 8b e8 74 41 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 82 fb 6a fd e9 44 fe ff ff
[    9.973886][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[    9.975016][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[    9.976375][    T1] RDX: ffff888016ec8000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[    9.977761][    T1] RBP: ffff8881482bf6cc R08: 0000000000000001 R09: 000=
0000000000000
[    9.979278][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f8881482bf6cc
[    9.980489][    T1] R13: 0000000000000000 R14: 0000000006d600b9 R15: fff=
f888016898588
[    9.981672][    T1] FS:  0000000000000000(0000) GS:ffff8880b9300000(0000=
) knlGS:0000000000000000
[    9.983784][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.984872][    T1] CR2: 0000000000000000 CR3: 000000000d97a000 CR4: 000=
00000003506f0
[    9.985995][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    9.987164][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    9.988333][    T1] Call Trace:
[    9.988860][    T1]  <TASK>
[    9.989504][    T1]  ? show_regs+0x8c/0xa0
[    9.990098][    T1]  ? __warn+0xe5/0x3c0
[    9.990778][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[    9.991767][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    9.993725][    T1]  ? report_bug+0x3c0/0x580
[    9.994547][    T1]  ? handle_bug+0x3d/0x70
[    9.995476][    T1]  ? exc_invalid_op+0x17/0x50
[    9.996166][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    9.997066][    T1]  ? __warn_printk+0x199/0x350
[    9.998094][    T1]  ? __warn_printk+0x1a6/0x350
[    9.998882][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    9.999734][    T1]  __reset_page_owner+0x2ea/0x370
[   10.000503][    T1]  __free_pages_ok+0x5a9/0xbf0
[   10.001625][    T1]  ? __split_page_owner+0xdd/0x120
[   10.002958][    T1]  make_alloc_exact+0x165/0x260
[   10.003811][    T1]  vring_alloc_queue+0xc1/0x110
[   10.004793][    T1]  vring_alloc_queue_split+0x186/0x510
[   10.005541][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[   10.006529][    T1]  ? kasan_save_stack+0x42/0x60
[   10.007279][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.008113][    T1]  vring_create_virtqueue_split+0xe8/0x280
[   10.008947][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.009744][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[   10.010701][    T1]  ? virtio_scsi_init+0x75/0x100
[   10.011622][    T1]  ? do_one_initcall+0x128/0x700
[   10.012973][    T1]  ? kernel_init_freeable+0x69d/0xca0
[   10.013767][    T1]  vring_create_virtqueue+0xd7/0x140
[   10.014563][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.015363][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.016157][    T1]  setup_vq+0x123/0x2f0
[   10.016919][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.017685][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.018631][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.019563][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.020595][    T1]  vp_setup_vq+0xb1/0x380
[   10.021346][    T1]  ? iowrite16+0x55/0x80
[   10.022721][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.023661][    T1]  vp_find_vqs_msix+0x661/0xe30
[   10.024641][    T1]  vp_find_vqs+0x58/0x560
[   10.025268][    T1]  virtscsi_init+0x459/0x9f0
[   10.025910][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   10.026731][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   10.027554][    T1]  ? ioread8+0x4e/0xa0
[   10.028865][    T1]  ? vp_get+0xf6/0x140
[   10.029652][    T1]  virtscsi_probe+0x3b2/0xdd0
[   10.030336][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   10.031081][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[   10.032065][    T1]  ? vring_transport_features+0x49/0xb0
[   10.033373][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   10.034073][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   10.034830][    T1]  really_probe+0x23e/0xa90
[   10.035538][    T1]  __driver_probe_device+0x1de/0x440
[   10.036331][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   10.037275][    T1]  driver_probe_device+0x4c/0x1b0
[   10.038113][    T1]  __driver_attach+0x283/0x580
[   10.039309][    T1]  ? __pfx___driver_attach+0x10/0x10
[   10.040179][    T1]  bus_for_each_dev+0x13c/0x1d0
[   10.041034][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   10.041888][    T1]  bus_add_driver+0x2ed/0x640
[   10.043313][    T1]  driver_register+0x15c/0x4b0
[   10.044142][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.045056][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.045867][    T1]  virtio_scsi_init+0x75/0x100
[   10.047082][    T1]  do_one_initcall+0x128/0x700
[   10.047828][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   10.048864][    T1]  ? trace_kmalloc+0x2d/0xe0
[   10.049704][    T1]  ? __kmalloc+0x218/0x440
[   10.050337][    T1]  kernel_init_freeable+0x69d/0xca0
[   10.051075][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.051845][    T1]  kernel_init+0x1c/0x2b0
[   10.052956][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.053716][    T1]  ret_from_fork+0x45/0x80
[   10.054503][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.055226][    T1]  ret_from_fork_asm+0x1a/0x30
[   10.056190][    T1]  </TASK>
[   10.056638][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   10.057903][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-13213-g70293240c5ce-dirty #0
[   10.059393][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   10.060851][    T1] Call Trace:
[   10.061436][    T1]  <TASK>
[   10.061914][    T1]  dump_stack_lvl+0x3d/0x1f0
[   10.062473][    T1]  panic+0x6f5/0x7a0
[   10.062473][    T1]  ? __pfx_panic+0x10/0x10
[   10.062473][    T1]  ? show_trace_log_lvl+0x363/0x500
[   10.062473][    T1]  ? check_panic_on_warn+0x1f/0xb0
[   10.062473][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.062473][    T1]  check_panic_on_warn+0xab/0xb0
[   10.062473][    T1]  __warn+0xf1/0x3c0
[   10.062473][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[   10.062473][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.062473][    T1]  report_bug+0x3c0/0x580
[   10.062473][    T1]  handle_bug+0x3d/0x70
[   10.062473][    T1]  exc_invalid_op+0x17/0x50
[   10.062473][    T1]  asm_exc_invalid_op+0x1a/0x20
[   10.062473][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[   10.062473][    T1] Code: 8b e8 97 41 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 f8 d2 0f fd c6 05 3b 02 4d 0b 01 90 48 c7 c7 80 e3 8e 8b e8 74 41 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 82 fb 6a fd e9 44 fe ff ff
[   10.062473][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[   10.062473][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[   10.062473][    T1] RDX: ffff888016ec8000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[   10.062473][    T1] RBP: ffff8881482bf6cc R08: 0000000000000001 R09: 000=
0000000000000
[   10.062473][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f8881482bf6cc
[   10.062473][    T1] R13: 0000000000000000 R14: 0000000006d600b9 R15: fff=
f888016898588
[   10.062473][    T1]  ? __warn_printk+0x199/0x350
[   10.062473][    T1]  ? __warn_printk+0x1a6/0x350
[   10.062473][    T1]  __reset_page_owner+0x2ea/0x370
[   10.062473][    T1]  __free_pages_ok+0x5a9/0xbf0
[   10.062473][    T1]  ? __split_page_owner+0xdd/0x120
[   10.062473][    T1]  make_alloc_exact+0x165/0x260
[   10.062473][    T1]  vring_alloc_queue+0xc1/0x110
[   10.062473][    T1]  vring_alloc_queue_split+0x186/0x510
[   10.062473][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[   10.062473][    T1]  ? kasan_save_stack+0x42/0x60
[   10.062473][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.062473][    T1]  vring_create_virtqueue_split+0xe8/0x280
[   10.062473][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.062473][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[   10.062473][    T1]  ? virtio_scsi_init+0x75/0x100
[   10.062473][    T1]  ? do_one_initcall+0x128/0x700
[   10.062473][    T1]  ? kernel_init_freeable+0x69d/0xca0
[   10.062473][    T1]  vring_create_virtqueue+0xd7/0x140
[   10.062473][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.062473][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.062473][    T1]  setup_vq+0x123/0x2f0
[   10.062473][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.062473][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.062473][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.062473][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.062473][    T1]  vp_setup_vq+0xb1/0x380
[   10.062473][    T1]  ? iowrite16+0x55/0x80
[   10.062473][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.062473][    T1]  vp_find_vqs_msix+0x661/0xe30
[   10.112351][    T1]  vp_find_vqs+0x58/0x560
[   10.112351][    T1]  virtscsi_init+0x459/0x9f0
[   10.112351][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   10.112351][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   10.112351][    T1]  ? ioread8+0x4e/0xa0
[   10.112351][    T1]  ? vp_get+0xf6/0x140
[   10.112351][    T1]  virtscsi_probe+0x3b2/0xdd0
[   10.112351][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   10.112351][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[   10.112351][    T1]  ? vring_transport_features+0x49/0xb0
[   10.112351][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   10.112351][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   10.112351][    T1]  really_probe+0x23e/0xa90
[   10.112351][    T1]  __driver_probe_device+0x1de/0x440
[   10.112351][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   10.112351][    T1]  driver_probe_device+0x4c/0x1b0
[   10.112351][    T1]  __driver_attach+0x283/0x580
[   10.112351][    T1]  ? __pfx___driver_attach+0x10/0x10
[   10.112351][    T1]  bus_for_each_dev+0x13c/0x1d0
[   10.112351][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   10.112351][    T1]  bus_add_driver+0x2ed/0x640
[   10.112351][    T1]  driver_register+0x15c/0x4b0
[   10.112351][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.112351][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.112351][    T1]  virtio_scsi_init+0x75/0x100
[   10.112351][    T1]  do_one_initcall+0x128/0x700
[   10.112351][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   10.112351][    T1]  ? trace_kmalloc+0x2d/0xe0
[   10.112351][    T1]  ? __kmalloc+0x218/0x440
[   10.112351][    T1]  kernel_init_freeable+0x69d/0xca0
[   10.112351][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.112351][    T1]  kernel_init+0x1c/0x2b0
[   10.112351][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.112351][    T1]  ret_from_fork+0x45/0x80
[   10.112351][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.112351][    T1]  ret_from_fork_asm+0x1a/0x30
[   10.112351][    T1]  </TASK>
[   10.112351][    T1] Kernel Offset: disabled
[   10.112351][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2080839175=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D14bff946180000


Tested on:

commit:         70293240 Merge tag 'timers-urgent-2024-03-23' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8f186ceee5fcb0b=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd2a2c639d03ac200a=
4f1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D153af9591800=
00


