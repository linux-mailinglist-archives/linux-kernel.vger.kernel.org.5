Return-Path: <linux-kernel+bounces-112560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB864887B83
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2FD1C20CD2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2331C05;
	Sun, 24 Mar 2024 03:14:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32E1A38C0
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711250045; cv=none; b=ZYAs3i96AlGM7fZAL1aMCrfpSOQUHBG3dF0va2+vxxMge6N7AMo6zdoxSfKBjuceVYkhF5hy+0znPFtPg0xfq8kVFq2LNVGQXteB2ycsA+QRN0lEeUQGtkhqOzzyo3MyRIjne6wJg6cNw7Qa8EdAZW29KO808jUjXfPIbNFWIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711250045; c=relaxed/simple;
	bh=g8PXWktX3ez60JcdTmFuqoIEd/CNU6Fj3uLpcZyt804=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pUnznFGJ9FA69XnZsqq7zbCjDxfdfBRykg8XiKfkH4QYqFkNTf917n3BoI5e6idf4kMBuoW0o2JLw/NwshyguyBOqmfUYMtBjc2rLXYp91QbjKHsCcTzaWvnC1Ar2Wh5H0GDRVcT2CMtAV3LgKzFNI1l/lXq2FXKj3o99jyiRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3686d27fcf5so23159645ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 20:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711250043; x=1711854843;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ktyj99bZHrGgPPjj8FnDHTNx69k2IC/XvslG9cLrEdc=;
        b=VvCC+tui/S7awBkBL+dbMUkm8SRXd6ZZE5XD6vqWWhl7jhfqZceBmPZJvyfscy6eag
         W3dFI+X4kT3AIp1sWl1QsREwv/BEP2bKemCKku/NGblhy6CRSyK17/4hmA+bmA1IuTs1
         qQCO2BMj7pn3X94N/xHel7iNLxBfJlRkb0f00wftfdndMKE4+HZ21xoUHZPb2PKXzbl3
         Knk65O82QJlWRYOkz5R0Ahd1Qa70RMSGnYH6fjgKu6gg7N7eP0mAuWtwu56Z4aYnaV3G
         +S/kPuPIdi3PzxNryigMJ9M1wogQreRcPsdJnv4iZHCDg0PaMKIYLC0y6W7S3XioiJQC
         NG8g==
X-Forwarded-Encrypted: i=1; AJvYcCUF31sCeQ130keFgsGH8IGUE8f5GSozxxjdfNYCGOh9mxmjO0XKrkbUiW6/Gb/2iWJBeapzCPf3Aa32MKx3J5or/WZ0E4bRBSWV3P+3
X-Gm-Message-State: AOJu0YxTkQBF70YHApGTCjQI+rijOVYJEl4oKiHhZy+qwD1pFA6Fm3+e
	i0Bv3krU3PbeeQNu9j2JlNOFSpxUWueHePmZ7s2tDGIcEoiBKfhFEi6RroQCNt/KxGe4Gu4Ic4h
	R+QAkKK8UUb/Wr+N37RlC2xi2YF1GBMA5mtsey7Nvi0dPqS/BbkQC71U=
X-Google-Smtp-Source: AGHT+IH7TjmTAHoPDK29xwmmmCJUqd654U2dSPQLAulhuW9kauRKKUjCox0xKikjMAtJ4UPBTSSZj5ef1AnGRXXa4vZ3tjAs9SFF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:1905:0:b0:367:d6da:8dbd with SMTP id
 5-20020a921905000000b00367d6da8dbdmr228925ilz.4.1711250043186; Sat, 23 Mar
 2024 20:14:03 -0700 (PDT)
Date: Sat, 23 Mar 2024 20:14:03 -0700
In-Reply-To: <20240323225322.644483-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2401906145f721d@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

connector registered
[    9.395362][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[    9.409196][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[    9.505488][    T1] Console: switching to colour frame buffer device 128=
x48
[    9.523984][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[    9.527824][    T1] usbcore: registered new interface driver udl
[    9.622433][    T1] brd: module loaded
[    9.743752][    T1] loop: module loaded
[    9.902769][    T1] zram: Added device: zram0
[    9.916379][    T1] null_blk: disk nullb0 created
[    9.918529][    T1] null_blk: module loaded
[    9.920792][    T1] Guest personality initialized and is inactive
[    9.924876][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[    9.928559][    T1] Initialized host personality
[    9.930572][    T1] usbcore: registered new interface driver rtsx_usb
[    9.932974][    T1] usbcore: registered new interface driver viperboard
[    9.935935][    T1] usbcore: registered new interface driver dln2
[    9.938724][    T1] usbcore: registered new interface driver pn533_usb
[    9.947749][    T1] nfcsim 0.2 initialized
[    9.948705][    T1] usbcore: registered new interface driver port100
[    9.950666][    T1] usbcore: registered new interface driver nfcmrvl
[    9.959408][    T1] Loading iSCSI transport class v2.0-870.
[    9.987262][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    9.998269][    T1] ------------[ cut here ]------------
[    9.999552][    T1] refcount_t: decrement hit 0; leaking memory.
[   10.001603][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1ed/0x210
[   10.006510][    T1] Modules linked in:
[   10.007509][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-13213-g70293240c5ce-dirty #0
[   10.009102][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   10.012195][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[   10.013921][    T1] Code: 8b e8 97 41 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 f8 d2 0f fd c6 05 3b 02 4d 0b 01 90 48 c7 c7 80 e3 8e 8b e8 74 41 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 82 fb 6a fd e9 44 fe ff ff
[   10.019663][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[   10.020684][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[   10.022230][    T1] RDX: ffff888016ec8000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[   10.023825][    T1] RBP: ffff88814076401c R08: 0000000000000001 R09: 000=
0000000000000
[   10.025544][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88814076401c
[   10.027340][    T1] R13: 0000000000000000 R14: 00000000000000ba R15: fff=
f88801687cd88
[   10.029016][    T1] FS:  0000000000000000(0000) GS:ffff8880b9200000(0000=
) knlGS:0000000000000000
[   10.030539][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.031427][    T1] CR2: ffff88823ffff000 CR3: 000000000d97a000 CR4: 000=
00000003506f0
[   10.032546][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   10.033980][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   10.035852][    T1] Call Trace:
[   10.036365][    T1]  <TASK>
[   10.036882][    T1]  ? show_regs+0x8c/0xa0
[   10.037493][    T1]  ? __warn+0xe5/0x3c0
[   10.038211][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[   10.039574][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.040456][    T1]  ? report_bug+0x3c0/0x580
[   10.041517][    T1]  ? handle_bug+0x3d/0x70
[   10.042234][    T1]  ? exc_invalid_op+0x17/0x50
[   10.042948][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   10.043682][    T1]  ? __warn_printk+0x199/0x350
[   10.044799][    T1]  ? __warn_printk+0x1a6/0x350
[   10.045592][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.046451][    T1]  __reset_page_owner+0x2ea/0x370
[   10.047479][    T1]  __free_pages_ok+0x5a9/0xbf0
[   10.048430][    T1]  ? __split_page_owner+0xdd/0x120
[   10.049202][    T1]  make_alloc_exact+0x165/0x260
[   10.050113][    T1]  vring_alloc_queue+0xc1/0x110
[   10.050904][    T1]  vring_alloc_queue_split+0x186/0x510
[   10.051842][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[   10.052934][    T1]  ? kasan_save_stack+0x42/0x60
[   10.053823][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.054846][    T1]  vring_create_virtqueue_split+0xe8/0x280
[   10.055854][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.056636][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[   10.057892][    T1]  ? virtio_scsi_init+0x75/0x100
[   10.058583][    T1]  ? do_one_initcall+0x128/0x700
[   10.059429][    T1]  ? kernel_init_freeable+0x69d/0xca0
[   10.060342][    T1]  vring_create_virtqueue+0xd7/0x140
[   10.061332][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.062378][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.063213][    T1]  setup_vq+0x123/0x2f0
[   10.063881][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.064796][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.065863][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.067220][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.068258][    T1]  vp_setup_vq+0xb1/0x380
[   10.068926][    T1]  ? iowrite16+0x55/0x80
[   10.069593][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.070890][    T1]  vp_find_vqs_msix+0x661/0xe30
[   10.071561][    T1]  vp_find_vqs+0x58/0x560
[   10.072362][    T1]  virtscsi_init+0x459/0x9f0
[   10.073379][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   10.074307][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   10.075361][    T1]  ? ioread8+0x4e/0xa0
[   10.076028][    T1]  ? vp_get+0xf6/0x140
[   10.076816][    T1]  virtscsi_probe+0x3b2/0xdd0
[   10.077559][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   10.078612][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[   10.079860][    T1]  ? vring_transport_features+0x49/0xb0
[   10.081158][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   10.082032][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   10.083127][    T1]  really_probe+0x23e/0xa90
[   10.083932][    T1]  __driver_probe_device+0x1de/0x440
[   10.084857][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   10.085794][    T1]  driver_probe_device+0x4c/0x1b0
[   10.086673][    T1]  __driver_attach+0x283/0x580
[   10.087529][    T1]  ? __pfx___driver_attach+0x10/0x10
[   10.088560][    T1]  bus_for_each_dev+0x13c/0x1d0
[   10.089562][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   10.090418][    T1]  bus_add_driver+0x2ed/0x640
[   10.091571][    T1]  driver_register+0x15c/0x4b0
[   10.092608][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.093646][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.094950][    T1]  virtio_scsi_init+0x75/0x100
[   10.095893][    T1]  do_one_initcall+0x128/0x700
[   10.096901][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   10.098105][    T1]  ? trace_kmalloc+0x2d/0xe0
[   10.099520][    T1]  ? __kmalloc+0x218/0x440
[   10.100634][    T1]  kernel_init_freeable+0x69d/0xca0
[   10.101566][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.102281][    T1]  kernel_init+0x1c/0x2b0
[   10.103220][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.104324][    T1]  ret_from_fork+0x45/0x80
[   10.105295][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.106249][    T1]  ret_from_fork_asm+0x1a/0x30
[   10.107540][    T1]  </TASK>
[   10.108490][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   10.110018][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-13213-g70293240c5ce-dirty #0
[   10.112294][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   10.114304][    T1] Call Trace:
[   10.114304][    T1]  <TASK>
[   10.114304][    T1]  dump_stack_lvl+0x3d/0x1f0
[   10.114304][    T1]  panic+0x6f5/0x7a0
[   10.114304][    T1]  ? __pfx_panic+0x10/0x10
[   10.114304][    T1]  ? show_trace_log_lvl+0x363/0x500
[   10.114304][    T1]  ? check_panic_on_warn+0x1f/0xb0
[   10.114304][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.114304][    T1]  check_panic_on_warn+0xab/0xb0
[   10.114304][    T1]  __warn+0xf1/0x3c0
[   10.114304][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[   10.114304][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.114304][    T1]  report_bug+0x3c0/0x580
[   10.114304][    T1]  handle_bug+0x3d/0x70
[   10.114304][    T1]  exc_invalid_op+0x17/0x50
[   10.114304][    T1]  asm_exc_invalid_op+0x1a/0x20
[   10.114304][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[   10.114304][    T1] Code: 8b e8 97 41 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 f8 d2 0f fd c6 05 3b 02 4d 0b 01 90 48 c7 c7 80 e3 8e 8b e8 74 41 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 82 fb 6a fd e9 44 fe ff ff
[   10.114304][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[   10.114304][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[   10.114304][    T1] RDX: ffff888016ec8000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[   10.114304][    T1] RBP: ffff88814076401c R08: 0000000000000001 R09: 000=
0000000000000
[   10.114304][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88814076401c
[   10.114304][    T1] R13: 0000000000000000 R14: 00000000000000ba R15: fff=
f88801687cd88
[   10.114304][    T1]  ? __warn_printk+0x199/0x350
[   10.114304][    T1]  ? __warn_printk+0x1a6/0x350
[   10.114304][    T1]  __reset_page_owner+0x2ea/0x370
[   10.114304][    T1]  __free_pages_ok+0x5a9/0xbf0
[   10.114304][    T1]  ? __split_page_owner+0xdd/0x120
[   10.114304][    T1]  make_alloc_exact+0x165/0x260
[   10.114304][    T1]  vring_alloc_queue+0xc1/0x110
[   10.114304][    T1]  vring_alloc_queue_split+0x186/0x510
[   10.114304][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[   10.114304][    T1]  ? kasan_save_stack+0x42/0x60
[   10.114304][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.114304][    T1]  vring_create_virtqueue_split+0xe8/0x280
[   10.114304][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.114304][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[   10.114304][    T1]  ? virtio_scsi_init+0x75/0x100
[   10.114304][    T1]  ? do_one_initcall+0x128/0x700
[   10.114304][    T1]  ? kernel_init_freeable+0x69d/0xca0
[   10.114304][    T1]  vring_create_virtqueue+0xd7/0x140
[   10.114304][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.114304][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.114304][    T1]  setup_vq+0x123/0x2f0
[   10.114304][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.114304][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.114304][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.114304][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.114304][    T1]  vp_setup_vq+0xb1/0x380
[   10.114304][    T1]  ? iowrite16+0x55/0x80
[   10.114304][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.114304][    T1]  vp_find_vqs_msix+0x661/0xe30
[   10.114304][    T1]  vp_find_vqs+0x58/0x560
[   10.114304][    T1]  virtscsi_init+0x459/0x9f0
[   10.114304][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   10.114304][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   10.114304][    T1]  ? ioread8+0x4e/0xa0
[   10.114304][    T1]  ? vp_get+0xf6/0x140
[   10.114304][    T1]  virtscsi_probe+0x3b2/0xdd0
[   10.114304][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   10.114304][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[   10.114304][    T1]  ? vring_transport_features+0x49/0xb0
[   10.114304][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   10.114304][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   10.114304][    T1]  really_probe+0x23e/0xa90
[   10.114304][    T1]  __driver_probe_device+0x1de/0x440
[   10.114304][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   10.114304][    T1]  driver_probe_device+0x4c/0x1b0
[   10.114304][    T1]  __driver_attach+0x283/0x580
[   10.114304][    T1]  ? __pfx___driver_attach+0x10/0x10
[   10.114304][    T1]  bus_for_each_dev+0x13c/0x1d0
[   10.114304][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   10.114304][    T1]  bus_add_driver+0x2ed/0x640
[   10.114304][    T1]  driver_register+0x15c/0x4b0
[   10.114304][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.114304][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.114304][    T1]  virtio_scsi_init+0x75/0x100
[   10.114304][    T1]  do_one_initcall+0x128/0x700
[   10.114304][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   10.114304][    T1]  ? trace_kmalloc+0x2d/0xe0
[   10.114304][    T1]  ? __kmalloc+0x218/0x440
[   10.114304][    T1]  kernel_init_freeable+0x69d/0xca0
[   10.114304][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.114304][    T1]  kernel_init+0x1c/0x2b0
[   10.114304][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.114304][    T1]  ret_from_fork+0x45/0x80
[   10.114304][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.114304][    T1]  ret_from_fork_asm+0x1a/0x30
[   10.114304][    T1]  </TASK>
[   10.114304][    T1] Kernel Offset: disabled
[   10.114304][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2524813086=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D16523d85180000


Tested on:

commit:         70293240 Merge tag 'timers-urgent-2024-03-23' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8f186ceee5fcb0b=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd2a2c639d03ac200a=
4f1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D120140061800=
00


