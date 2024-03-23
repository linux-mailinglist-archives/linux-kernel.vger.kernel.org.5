Return-Path: <linux-kernel+bounces-112499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5CA887A90
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C140D1F21913
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A85A4E1;
	Sat, 23 Mar 2024 22:10:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685C18659
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711231805; cv=none; b=WQFryR0MHfO8TahCpD0Uws8qkUqw9FHmVjz/EQD96fD+bOkZl+lBIfw8Pkh6LEwacHj3IApvLaFaxJ+4iFre8UiWfCGdUBWomQSPDFb09AkkJ0G8hM8jtjwK+ubrSbF5bceEMp4P0n7IR9OafmjL2t0s6Eo+ST4lA1uAW00IADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711231805; c=relaxed/simple;
	bh=a1PEb5QJK0bwIIxXm5OdmhRsLvfvuT35jUY89UvmMfg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T58CizKnUWxr0VDN7JbYkUI3/owCJ9xgqoxDhNtSXxaHkdjTrK3EKyHDgxjLHl6WvRdYI6mV2bpmRPGYPmelrN46vV7bKy50xGCPMP5fLVqnFV1UDLmsX/AIIKvD7pi9EMJncB+/mD7Yt8953SUglJQIZC4vbClejn1dUabgIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c88a694b46so293248739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 15:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711231803; x=1711836603;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ur5vMW+lvqHgifzBexuHvlINnfDrbXoDqT/QQxoOXy8=;
        b=QVnzX1p3ihM++oEXZf1w4Ru1k74fW0o055DAgG9+2hYdqg/UXCkhj89dXkQ1bbjNBh
         GFxhwgceWvnHYm8Zo9dYywWCLaxWgUBtYDM9XYVLYvQWRPO37jClbxGuPtt+02aQzE3X
         JJjFa3Tz234PN0BP0VbudkzOxsmsnWYqhZUIBj+N9rjiN3qJt/J23zWIrImgbv3F8TT9
         oizJTw7QN8huLO6WyLlvNixgoqR0rf94K84fY0ErX72VYGp2lzz8cJDhQEsIVeceikZD
         QfydTEfH/FqncItTtaqXbTkbGaifX1OdbX2tFu6lnCaM8oY7siQ7TCiNmednfnoEPGfQ
         O5bg==
X-Forwarded-Encrypted: i=1; AJvYcCXNGVgUz+o/P7fjjdYAMnDGzJndhKAad5AtQ04Z3Pfu2Qd+hcIBkyVMZMKIEx+5atF6vGNSXls66galhDxTSJg0TYWD4pBdmHRGFhyI
X-Gm-Message-State: AOJu0Yyo5vyLXVAlaPAL0Tn/Rqd5RMO0h8D30NsxixUC10dQ/xNi/Tzr
	2oFYSrk5velNCveadueBXULjFYnCoCT31actMkzHZLtzE7ftQJ+TMw9nDZBbkmKADEhg16+xdIU
	kSasohi4gu6gn1c4RmbDz/MIqxbAdxN1icsz43WR289IGPKK586JA0z4=
X-Google-Smtp-Source: AGHT+IGvudRQn7w4gWXXjWFzeoI1/4JCrqjxRbSuZ8DWZwiaQDW79iwl6OOetdw3fWD9zOIC5vqVRQxp1/P9HOWTAi3X+6fFmWa8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1654:b0:7cc:27d:d69d with SMTP id
 y20-20020a056602165400b007cc027dd69dmr96946iow.2.1711231802990; Sat, 23 Mar
 2024 15:10:02 -0700 (PDT)
Date: Sat, 23 Mar 2024 15:10:02 -0700
In-Reply-To: <20240323212122.569974-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bef95006145b33eb@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

connector registered
[    9.572858][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[    9.584256][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[    9.680087][    T1] Console: switching to colour frame buffer device 128=
x48
[    9.696560][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[    9.698211][    T1] usbcore: registered new interface driver udl
[    9.793530][    T1] brd: module loaded
[    9.913667][    T1] loop: module loaded
[   10.101090][    T1] zram: Added device: zram0
[   10.114153][    T1] null_blk: disk nullb0 created
[   10.115012][    T1] null_blk: module loaded
[   10.117246][    T1] Guest personality initialized and is inactive
[   10.119788][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[   10.121119][    T1] Initialized host personality
[   10.122385][    T1] usbcore: registered new interface driver rtsx_usb
[   10.124441][    T1] usbcore: registered new interface driver viperboard
[   10.125799][    T1] usbcore: registered new interface driver dln2
[   10.127995][    T1] usbcore: registered new interface driver pn533_usb
[   10.138179][    T1] nfcsim 0.2 initialized
[   10.140398][    T1] usbcore: registered new interface driver port100
[   10.142027][    T1] usbcore: registered new interface driver nfcmrvl
[   10.151644][    T1] Loading iSCSI transport class v2.0-870.
[   10.171732][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[   10.186563][    T1] ------------[ cut here ]------------
[   10.187348][    T1] refcount_t: decrement hit 0; leaking memory.
[   10.188508][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1ed/0x210
[   10.191432][    T1] Modules linked in:
[   10.192019][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-13182-g484193fecd2b-dirty #0
[   10.193638][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   10.195427][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[   10.196395][    T1] Code: 8b e8 17 42 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 e8 d2 0f fd c6 05 bb 02 4d 0b 01 90 48 c7 c7 80 e3 8e 8b e8 f4 41 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 72 fb 6a fd e9 44 fe ff ff
[   10.199935][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[   10.201025][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[   10.202204][    T1] RDX: ffff888016ec8000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[   10.203507][    T1] RBP: ffff88814168f58c R08: 0000000000000001 R09: 000=
0000000000000
[   10.204951][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88814168f58c
[   10.206164][    T1] R13: 0000000000000000 R14: 0000000006ae00b9 R15: fff=
f88801687a588
[   10.208440][    T1] FS:  0000000000000000(0000) GS:ffff8880b9200000(0000=
) knlGS:0000000000000000
[   10.210295][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.211544][    T1] CR2: ffff88823ffff000 CR3: 000000000d97a000 CR4: 000=
00000003506f0
[   10.213262][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   10.214476][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   10.215639][    T1] Call Trace:
[   10.216229][    T1]  <TASK>
[   10.216789][    T1]  ? show_regs+0x8c/0xa0
[   10.217525][    T1]  ? __warn+0xe5/0x3c0
[   10.218395][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[   10.219772][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.220616][    T1]  ? report_bug+0x3c0/0x580
[   10.221279][    T1]  ? handle_bug+0x3d/0x70
[   10.221955][    T1]  ? exc_invalid_op+0x17/0x50
[   10.222793][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   10.224072][    T1]  ? __warn_printk+0x199/0x350
[   10.225145][    T1]  ? __warn_printk+0x1a6/0x350
[   10.225925][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.226934][    T1]  __reset_page_owner+0x2ea/0x370
[   10.227736][    T1]  __free_pages_ok+0x5a9/0xbf0
[   10.228415][    T1]  ? __split_page_owner+0xdd/0x120
[   10.229191][    T1]  make_alloc_exact+0x165/0x260
[   10.229917][    T1]  vring_alloc_queue+0xc1/0x110
[   10.230635][    T1]  vring_alloc_queue_split+0x186/0x510
[   10.231420][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[   10.232251][    T1]  ? kasan_save_stack+0x42/0x60
[   10.232963][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.234590][    T1]  vring_create_virtqueue_split+0xe8/0x280
[   10.235665][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.236516][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[   10.237686][    T1]  ? virtio_scsi_init+0x75/0x100
[   10.238656][    T1]  ? do_one_initcall+0x128/0x700
[   10.239488][    T1]  ? kernel_init_freeable+0x69d/0xca0
[   10.240398][    T1]  vring_create_virtqueue+0xd7/0x140
[   10.241186][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.241965][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.243112][    T1]  setup_vq+0x123/0x2f0
[   10.243810][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.244761][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.245553][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.246547][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.247478][    T1]  vp_setup_vq+0xb1/0x380
[   10.248194][    T1]  ? iowrite16+0x55/0x80
[   10.249175][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.250422][    T1]  vp_find_vqs_msix+0x661/0xe30
[   10.251165][    T1]  vp_find_vqs+0x58/0x560
[   10.251947][    T1]  virtscsi_init+0x459/0x9f0
[   10.252881][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   10.253796][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   10.254568][    T1]  ? ioread8+0x4e/0xa0
[   10.255139][    T1]  ? vp_get+0xf6/0x140
[   10.255707][    T1]  virtscsi_probe+0x3b2/0xdd0
[   10.256452][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   10.257363][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[   10.259318][    T1]  ? vring_transport_features+0x49/0xb0
[   10.260183][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   10.260877][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   10.261663][    T1]  really_probe+0x23e/0xa90
[   10.262480][    T1]  __driver_probe_device+0x1de/0x440
[   10.263462][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   10.264576][    T1]  driver_probe_device+0x4c/0x1b0
[   10.265289][    T1]  __driver_attach+0x283/0x580
[   10.265950][    T1]  ? __pfx___driver_attach+0x10/0x10
[   10.266697][    T1]  bus_for_each_dev+0x13c/0x1d0
[   10.267364][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   10.268099][    T1]  bus_add_driver+0x2ed/0x640
[   10.268824][    T1]  driver_register+0x15c/0x4b0
[   10.269581][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.270424][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.271525][    T1]  virtio_scsi_init+0x75/0x100
[   10.272450][    T1]  do_one_initcall+0x128/0x700
[   10.273380][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   10.274148][    T1]  ? trace_kmalloc+0x2d/0xe0
[   10.274844][    T1]  ? __kmalloc+0x218/0x440
[   10.275566][    T1]  kernel_init_freeable+0x69d/0xca0
[   10.276467][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.277287][    T1]  kernel_init+0x1c/0x2b0
[   10.278215][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.279001][    T1]  ret_from_fork+0x45/0x80
[   10.279722][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.280617][    T1]  ret_from_fork_asm+0x1a/0x30
[   10.281685][    T1]  </TASK>
[   10.282111][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   10.283173][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-13182-g484193fecd2b-dirty #0
[   10.284676][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   10.286446][    T1] Call Trace:
[   10.286986][    T1]  <TASK>
[   10.287455][    T1]  dump_stack_lvl+0x3d/0x1f0
[   10.288227][    T1]  panic+0x6f5/0x7a0
[   10.288985][    T1]  ? __pfx_panic+0x10/0x10
[   10.288985][    T1]  ? show_trace_log_lvl+0x363/0x500
[   10.288985][    T1]  ? check_panic_on_warn+0x1f/0xb0
[   10.288985][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.288985][    T1]  check_panic_on_warn+0xab/0xb0
[   10.288985][    T1]  __warn+0xf1/0x3c0
[   10.288985][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[   10.288985][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[   10.288985][    T1]  report_bug+0x3c0/0x580
[   10.288985][    T1]  handle_bug+0x3d/0x70
[   10.288985][    T1]  exc_invalid_op+0x17/0x50
[   10.288985][    T1]  asm_exc_invalid_op+0x1a/0x20
[   10.288985][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[   10.298878][    T1] Code: 8b e8 17 42 d2 fc 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 e8 d2 0f fd c6 05 bb 02 4d 0b 01 90 48 c7 c7 80 e3 8e 8b e8 f4 41 d2 f=
c 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 72 fb 6a fd e9 44 fe ff ff
[   10.298878][    T1] RSP: 0000:ffffc900000673c0 EFLAGS: 00010286
[   10.298878][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fe149
[   10.298878][    T1] RDX: ffff888016ec8000 RSI: ffffffff814fe156 RDI: 000=
0000000000001
[   10.298878][    T1] RBP: ffff88814168f58c R08: 0000000000000001 R09: 000=
0000000000000
[   10.298878][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88814168f58c
[   10.298878][    T1] R13: 0000000000000000 R14: 0000000006ae00b9 R15: fff=
f88801687a588
[   10.308799][    T1]  ? __warn_printk+0x199/0x350
[   10.308799][    T1]  ? __warn_printk+0x1a6/0x350
[   10.308799][    T1]  __reset_page_owner+0x2ea/0x370
[   10.308799][    T1]  __free_pages_ok+0x5a9/0xbf0
[   10.308799][    T1]  ? __split_page_owner+0xdd/0x120
[   10.308799][    T1]  make_alloc_exact+0x165/0x260
[   10.308799][    T1]  vring_alloc_queue+0xc1/0x110
[   10.308799][    T1]  vring_alloc_queue_split+0x186/0x510
[   10.308799][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[   10.308799][    T1]  ? kasan_save_stack+0x42/0x60
[   10.308799][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.318898][    T1]  vring_create_virtqueue_split+0xe8/0x280
[   10.318898][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.318898][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[   10.318898][    T1]  ? virtio_scsi_init+0x75/0x100
[   10.318898][    T1]  ? do_one_initcall+0x128/0x700
[   10.318898][    T1]  ? kernel_init_freeable+0x69d/0xca0
[   10.318898][    T1]  vring_create_virtqueue+0xd7/0x140
[   10.318898][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.318898][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.318898][    T1]  setup_vq+0x123/0x2f0
[   10.318898][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.318898][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.328775][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.328775][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.328775][    T1]  vp_setup_vq+0xb1/0x380
[   10.328775][    T1]  ? iowrite16+0x55/0x80
[   10.328775][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.328775][    T1]  vp_find_vqs_msix+0x661/0xe30
[   10.328775][    T1]  vp_find_vqs+0x58/0x560
[   10.328775][    T1]  virtscsi_init+0x459/0x9f0
[   10.328775][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   10.328775][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   10.328775][    T1]  ? ioread8+0x4e/0xa0
[   10.328775][    T1]  ? vp_get+0xf6/0x140
[   10.328775][    T1]  virtscsi_probe+0x3b2/0xdd0
[   10.338889][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   10.338889][    T1]  ? trace_raw_output_sched_pi_setprio+0xad/0x150
[   10.338889][    T1]  ? vring_transport_features+0x49/0xb0
[   10.338889][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   10.338889][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   10.338889][    T1]  really_probe+0x23e/0xa90
[   10.338889][    T1]  __driver_probe_device+0x1de/0x440
[   10.338889][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   10.338889][    T1]  driver_probe_device+0x4c/0x1b0
[   10.338889][    T1]  __driver_attach+0x283/0x580
[   10.338889][    T1]  ? __pfx___driver_attach+0x10/0x10
[   10.338889][    T1]  bus_for_each_dev+0x13c/0x1d0
[   10.348774][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   10.348774][    T1]  bus_add_driver+0x2ed/0x640
[   10.348774][    T1]  driver_register+0x15c/0x4b0
[   10.348774][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.348774][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.348774][    T1]  virtio_scsi_init+0x75/0x100
[   10.348774][    T1]  do_one_initcall+0x128/0x700
[   10.348774][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   10.348774][    T1]  ? trace_kmalloc+0x2d/0xe0
[   10.348774][    T1]  ? __kmalloc+0x218/0x440
[   10.348774][    T1]  kernel_init_freeable+0x69d/0xca0
[   10.348774][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.348774][    T1]  kernel_init+0x1c/0x2b0
[   10.358850][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.358850][    T1]  ret_from_fork+0x45/0x80
[   10.358850][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.358850][    T1]  ret_from_fork_asm+0x1a/0x30
[   10.358850][    T1]  </TASK>
[   10.358850][    T1] Kernel Offset: disabled
[   10.358850][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1980677323=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D14e14231180000


Tested on:

commit:         484193fe Merge tag 'powerpc-6.9-2' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8f186ceee5fcb0b=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd2a2c639d03ac200a=
4f1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1298a7b61800=
00


