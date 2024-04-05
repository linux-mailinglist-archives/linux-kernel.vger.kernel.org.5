Return-Path: <linux-kernel+bounces-132392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CAF8993FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87381C24E8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A01D53F;
	Fri,  5 Apr 2024 03:55:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316919BA3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712289306; cv=none; b=QaWFvPSsC0P8LiXIFFPTLOJe0Y05oRUTwkLPuRDM3nnLLjZs2YwynQuVP9gEur4VqB7W+QDAHI6MSdIYRHIBsQpxip4QFC0Mk+91Nbfh8I33d/YrWbBoHuHy8EQvr1EGVf+fA063NivsrNOLZ0e8KmJcxkLHm7LNw5FlAm2LwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712289306; c=relaxed/simple;
	bh=8QgA6DOlCmayaHhs1fekr3BR6y7tDejbJkvzOiyQjTk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PwvXC+Evs6d0MwL0A6xoI5/Ao/w6C+m102ZxMasgUMLT+JY+lWfrDnbxSv7g8crzFffLFCVeAKA5Ee46qCpt14okpBgMvxfrc0dPuBdIHnrECQpbHYjOrIR47K9RMhLtLrIy67mnVpkAi8O08Jp7Wtl3JFp2+/i2sBUsuZOI13I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-369ec8fd545so15514815ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 20:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712289303; x=1712894103;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daxVM/BLo0+xwP1DRhEuzZBZpx546SIeQX2MbDYDmYA=;
        b=n4hu85HUiOd3LtdV1n8FBQ/nn6wS4ft9EyjW/n/7ed2ofk5FNMzu+Og6H8RLAgQ8m7
         KDMdXxupvMru+b0xZZeUduQiKNJ6xvoBmdNzjszsG5hcJdkXLsLv4RT6oS6SNW2B7b7r
         z8zZIsi5auMlJNxI+cMJ/ECL9DTym5u82fD69E7EK1IaMYDQlXogc4xHk3qXVfbz/y+P
         Hvf/S4B7XsCvszEI2craXDKQJpC2G6KhLfw73CD2F5VJG+70yXtc7Iyfwoyc0+yI3ouF
         QAH0/5tIIxNeAAUbNkcyLpcy3AMYS/+RM0ZqfJZ3zu3USyPG5HjGuNlEkqFcr6d5OJW4
         SK8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtg1DEnsUQOFPmcLyUk9KGn8Ql9KRJn4DpXM51PwaZQ/VqDuBZhB6yfIy/J51dsr6oJv6/PTL9/LCwLjQw5/eV1Tdz7Vc0h/LqsJj0
X-Gm-Message-State: AOJu0YwJhbJ4gyuYFqOqwkbihD52vw3zaCVS942aAorVJYGcs3hg/9km
	fL7yGf7n/3zeJH6aOfOtslRM/6naclcCqjEC8URviEPpqmTcfs+vlAbl/dLcrPkYfrmQ2FpqBDe
	Dqh1aKXdmjIoDYMq5+49qMmmKTXkArVwWhFMhJvfxAvw+qrg2pYXtAFw=
X-Google-Smtp-Source: AGHT+IEOv55P0ddNX04it23/vZGe28+kuyVprry7choTO1Rkh39eQSySLwrGarJGNP0KQXz5X/s4BaG8DA6APMxVR6Aw/G22SwwT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:368:b289:38af with SMTP id
 q14-20020a92ca4e000000b00368b28938afmr11809ilo.6.1712289303215; Thu, 04 Apr
 2024 20:55:03 -0700 (PDT)
Date: Thu, 04 Apr 2024 20:55:03 -0700
In-Reply-To: <87plv4kfil.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abd40e0615516bdb@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eadavis@qq.com, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	toke@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

erface driver port100
[    7.311436][    T1] usbcore: registered new interface driver nfcmrvl
[    7.318515][    T1] Loading iSCSI transport class v2.0-870.
[    7.335287][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.343626][    T1] ------------[ cut here ]------------
[    7.344498][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.345816][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.347895][    T1] Modules linked in:
[    7.348644][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00245-g1cfa2f10f4e9-dirty #0
[    7.350284][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.351743][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.352725][    T1] Code: b2 00 00 00 e8 97 cf e9 fc 5b 5d c3 cc cc cc c=
c e8 8b cf e9 fc c6 05 6e 74 e8 0a 01 90 48 c7 c7 e0 33 1f 8c e8 c7 6b ac f=
c 90 <0f> 0b 90 90 eb d9 e8 6b cf e9 fc c6 05 4b 74 e8 0a 01 90 48 c7 c7
[    7.355628][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.356908][    T1] RAX: 97987c7bd8eab100 RBX: ffff8881472d6f6c RCX: fff=
f8880166d0000
[    7.358339][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.359509][    T1] RBP: 0000000000000004 R08: ffffffff81580062 R09: fff=
ffbfff1c396e0
[    7.360660][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea0000856dc0
[    7.361924][    T1] R13: ffffea0000856dc8 R14: 1ffffd400010adb9 R15: 000=
0000000000000
[    7.363052][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.364304][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.365198][    T1] CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 000=
00000003506f0
[    7.367259][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.368495][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.369779][    T1] Call Trace:
[    7.370257][    T1]  <TASK>
[    7.370879][    T1]  ? __warn+0x163/0x4e0
[    7.371456][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.372221][    T1]  ? report_bug+0x2b3/0x500
[    7.372874][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.373951][    T1]  ? handle_bug+0x3e/0x70
[    7.374586][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.375235][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.375940][    T1]  ? __warn_printk+0x292/0x360
[    7.376982][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.377792][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.378630][    T1]  __free_pages_ok+0xc60/0xd90
[    7.379362][    T1]  make_alloc_exact+0xa3/0xf0
[    7.380045][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.380857][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.381697][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.382711][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.383786][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.384631][    T1]  ? really_probe+0x2b8/0xad0
[    7.385324][    T1]  ? driver_probe_device+0x50/0x430
[    7.386103][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.387313][    T1]  ? ret_from_fork+0x4b/0x80
[    7.388031][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.389084][    T1]  vring_create_virtqueue+0xca/0x110
[    7.389967][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.390812][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.391660][    T1]  setup_vq+0xe9/0x2d0
[    7.392432][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.393181][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.393942][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.394867][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.395927][    T1]  vp_setup_vq+0xbf/0x330
[    7.397180][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.398233][    T1]  ? ioread16+0x2f/0x90
[    7.398859][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.399621][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.400563][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.401171][    T1]  virtscsi_init+0x8db/0xd00
[    7.401888][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.402696][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.403594][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.404281][    T1]  ? vp_get+0xfd/0x140
[    7.404929][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.405637][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.406398][    T1]  ? virtio_pci_modern_probe+0x1ad/0x270
[    7.407182][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    7.407898][    T1]  ? vp_set_status+0x1a/0x40
[    7.408529][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.409355][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.410072][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.410754][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.411546][    T1]  really_probe+0x2b8/0xad0
[    7.412167][    T1]  __driver_probe_device+0x1a2/0x390
[    7.412887][    T1]  driver_probe_device+0x50/0x430
[    7.413590][    T1]  __driver_attach+0x45f/0x710
[    7.414237][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.414953][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.415674][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.416541][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.417323][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.418091][    T1]  bus_add_driver+0x347/0x620
[    7.418770][    T1]  driver_register+0x23a/0x320
[    7.419601][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.420387][    T1]  virtio_scsi_init+0x65/0xe0
[    7.421063][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.421802][    T1]  do_one_initcall+0x248/0x880
[    7.422452][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.423191][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.424043][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.424842][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.425562][    T1]  ? do_initcalls+0x1c/0x80
[    7.426235][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.426902][    T1]  do_initcall_level+0x157/0x210
[    7.427580][    T1]  do_initcalls+0x3f/0x80
[    7.428174][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.428912][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.429687][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.430608][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.431281][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.432008][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.432791][    T1]  kernel_init+0x1d/0x2b0
[    7.433667][    T1]  ret_from_fork+0x4b/0x80
[    7.434410][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.435247][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.436036][    T1]  </TASK>
[    7.436777][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.437767][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00245-g1cfa2f10f4e9-dirty #0
[    7.439106][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.440461][    T1] Call Trace:
[    7.440914][    T1]  <TASK>
[    7.441323][    T1]  dump_stack_lvl+0x241/0x360
[    7.441989][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.442706][    T1]  ? __pfx__printk+0x10/0x10
[    7.443350][    T1]  ? _printk+0xd5/0x120
[    7.443977][    T1]  ? vscnprintf+0x5d/0x90
[    7.444934][    T1]  panic+0x349/0x860
[    7.445694][    T1]  ? __warn+0x172/0x4e0
[    7.446290][    T1]  ? __pfx_panic+0x10/0x10
[    7.446639][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    7.446639][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    7.446639][    T1]  __warn+0x346/0x4e0
[    7.446639][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.446639][    T1]  report_bug+0x2b3/0x500
[    7.446639][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.446639][    T1]  handle_bug+0x3e/0x70
[    7.446639][    T1]  exc_invalid_op+0x1a/0x50
[    7.446639][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.446639][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.446639][    T1] Code: b2 00 00 00 e8 97 cf e9 fc 5b 5d c3 cc cc cc c=
c e8 8b cf e9 fc c6 05 6e 74 e8 0a 01 90 48 c7 c7 e0 33 1f 8c e8 c7 6b ac f=
c 90 <0f> 0b 90 90 eb d9 e8 6b cf e9 fc c6 05 4b 74 e8 0a 01 90 48 c7 c7
[    7.446639][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.446639][    T1] RAX: 97987c7bd8eab100 RBX: ffff8881472d6f6c RCX: fff=
f8880166d0000
[    7.446639][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.446639][    T1] RBP: 0000000000000004 R08: ffffffff81580062 R09: fff=
ffbfff1c396e0
[    7.446639][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea0000856dc0
[    7.446639][    T1] R13: ffffea0000856dc8 R14: 1ffffd400010adb9 R15: 000=
0000000000000
[    7.446639][    T1]  ? __warn_printk+0x292/0x360
[    7.446639][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.446639][    T1]  __free_pages_ok+0xc60/0xd90
[    7.446639][    T1]  make_alloc_exact+0xa3/0xf0
[    7.446639][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.446639][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.446639][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.446639][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.446639][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.446639][    T1]  ? really_probe+0x2b8/0xad0
[    7.446639][    T1]  ? driver_probe_device+0x50/0x430
[    7.446639][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.446639][    T1]  ? ret_from_fork+0x4b/0x80
[    7.446639][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.446639][    T1]  vring_create_virtqueue+0xca/0x110
[    7.446639][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.446639][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.446639][    T1]  setup_vq+0xe9/0x2d0
[    7.446639][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.446639][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.446639][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.446639][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.446639][    T1]  vp_setup_vq+0xbf/0x330
[    7.446639][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.446639][    T1]  ? ioread16+0x2f/0x90
[    7.446639][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.446639][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.446639][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.446639][    T1]  virtscsi_init+0x8db/0xd00
[    7.446639][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.446639][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.446639][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.446639][    T1]  ? vp_get+0xfd/0x140
[    7.446639][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.446639][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.446639][    T1]  ? virtio_pci_modern_probe+0x1ad/0x270
[    7.446639][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    7.446639][    T1]  ? vp_set_status+0x1a/0x40
[    7.446639][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.446639][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.446639][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.446639][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.446639][    T1]  really_probe+0x2b8/0xad0
[    7.446639][    T1]  __driver_probe_device+0x1a2/0x390
[    7.496320][    T1]  driver_probe_device+0x50/0x430
[    7.496320][    T1]  __driver_attach+0x45f/0x710
[    7.496320][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.496320][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.496320][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.496320][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.496320][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.496320][    T1]  bus_add_driver+0x347/0x620
[    7.496320][    T1]  driver_register+0x23a/0x320
[    7.496320][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.496320][    T1]  virtio_scsi_init+0x65/0xe0
[    7.496320][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.496320][    T1]  do_one_initcall+0x248/0x880
[    7.496320][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.496320][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.496320][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.496320][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.496320][    T1]  ? do_initcalls+0x1c/0x80
[    7.496320][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.496320][    T1]  do_initcall_level+0x157/0x210
[    7.496320][    T1]  do_initcalls+0x3f/0x80
[    7.496320][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.496320][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.496320][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.496320][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.496320][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.496320][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.496320][    T1]  kernel_init+0x1d/0x2b0
[    7.496320][    T1]  ret_from_fork+0x4b/0x80
[    7.496320][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.496320][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.496320][    T1]  </TASK>
[    7.496320][    T1] Kernel Offset: disabled
[    7.496320][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2839934155=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D17196223180000


Tested on:

commit:         1cfa2f10 Merge tag 'for-netdev' of https://git.kernel...
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7b667bc37450fdc=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3Daf9492708df979719=
8d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D11cdcca91800=
00


