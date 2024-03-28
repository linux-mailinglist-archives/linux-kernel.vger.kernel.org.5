Return-Path: <linux-kernel+bounces-123427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FD4890876
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443741C2638B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393C136E2F;
	Thu, 28 Mar 2024 18:44:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF712F38B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651445; cv=none; b=p8V14Uh6eKUjNKxJ3Siubcm30+V4Doon7BQFKPPYFTpLXgXPQLQqLWmP2OFnLFWITaev6zi4t4wJniZLwfR76sI1MVy+yAaAjDMvLpFY6rtJM8GxTlSL1HI8F+2dBG5tdnrj2QGaHXi0O3WafDSm0uPktw3wkw/Cs1nNgu6Togg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651445; c=relaxed/simple;
	bh=Hf5lKCzqVsHDqmjTDvCGg/9Y9HmfC3Nc7wgnT0c8/6k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eGkMzrrScWl4PVGxP0ft8AHlRjkhoxZ6pY9sEKXTle2aFK7FfmKnjaIQejUlp70/2dvScvscjcIWNUAY3gE/XOishfIkij03/G3NNmVtLafqcjElgllxMJPf8Plo6GjOCnXNhxTWTAEm2LBXg7+2y/M4bxw2wBDS5B/gABtYmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d096c4d64eso24786239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651443; x=1712256243;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9YRYj6MWJVWvv6E4iu8ypEAwxfBNL3P+kraxeSrAF0=;
        b=FIiOKSBzmZ8x+zhv6VrnUi1RryYN+S/ETCDGsOi9lNGiQPgts+9uBIOlw52YWMtiZL
         hR+AVnU8LgS4z+NisC4bc48iULAguCHMfcY/Bf0iHeD2nwxMJ/UikzlWnZUhNsEQr585
         Og/f8rhnG6f7+TrKxSOw+oIxKe4t4Z/xH1KjGCchE8qRG66S2SBSi17rwwakrkO7Fgxe
         nZEcR0Ove8Bp9A93VoNvXkX49vJl93pg1vrmBciRwCjmTw4Ozi+9ALeGQWGivdBuUtIA
         PVT8ucn6I2E4PNi1r06gPpMGutv2Pf33zTh89vz3H1uk/+QihElDKTsLuAcLP1ELiTGZ
         J1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE4xo9jW1JK3D++BrkIA5mHs1P+uTnaQW80Tp1rwR+YgwTBBTgAgfRTE0yJjYiIqmPDoBLwkFTNr6OHMvYG5NcHjgXejtSi0HLcg0r
X-Gm-Message-State: AOJu0YziSx+N8l9x5q7XSngZpJaA1o9r8J88/J2iFC9ZN0SSdn41sFTf
	pi3zSa3sQXZaST3VaJj+b+lA9wQuD5/QFTa3GnEAlG/feLYhqgemcJ0GLOdBBTYm07LCo1L8hMR
	Bxbq2YGv5oa/VvvNBJK1FkeKatoAlTetmewXZS+DQQqUm5lqT0FJp6Co=
X-Google-Smtp-Source: AGHT+IF73xvwUbXUzbDonWL38gLFDdbtZQsPDBoLmVbttqAeLuYJIU+2/6vpsK0WDHtSYCpyOVtLdJMtpvCE2XnmI0BgI8Tt/Z8Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1543:b0:7c8:56ec:ac1 with SMTP id
 h3-20020a056602154300b007c856ec0ac1mr7609iow.2.1711651443155; Thu, 28 Mar
 2024 11:44:03 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:44:03 -0700
In-Reply-To: <tencent_171E741F760F671C3CCD379896E236784A09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fc5760614bce8e6@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

erface driver port100
[    7.948791][    T1] usbcore: registered new interface driver nfcmrvl
[    7.955639][    T1] Loading iSCSI transport class v2.0-870.
[    7.973810][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.989145][    T1] ------------[ cut here ]------------
[    7.990111][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.991339][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.993340][    T1] Modules linked in:
[    7.994199][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-11136-g66a27abac311-dirty #0
[    7.997619][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.000127][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.001771][    T1] Code: b2 00 00 00 e8 e7 e2 ec fc 5b 5d c3 cc cc cc c=
c e8 db e2 ec fc c6 05 c6 89 ea 0a 01 90 48 c7 c7 60 ae 1e 8c e8 47 a8 af f=
c 90 <0f> 0b 90 90 eb d9 e8 bb e2 ec fc c6 05 a3 89 ea 0a 01 90 48 c7 c7
[    8.004380][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.005254][    T1] RAX: ca7328f93391fe00 RBX: ffff888020f9e75c RCX: fff=
f8880166e0000
[    8.006549][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.008086][    T1] RBP: 0000000000000004 R08: ffffffff8157e022 R09: fff=
ffbfff1c39660
[    8.009562][    T1] R10: dffffc0000000000 R11: fffffbfff1c39660 R12: fff=
fea0000851dc0
[    8.011291][    T1] R13: ffffea0000851dc8 R14: 1ffffd400010a3b9 R15: 000=
0000000000000
[    8.012581][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    8.014131][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.016303][    T1] CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 000=
00000003506f0
[    8.017899][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.019084][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.020661][    T1] Call Trace:
[    8.021839][    T1]  <TASK>
[    8.022284][    T1]  ? __warn+0x163/0x4b0
[    8.022899][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.024608][    T1]  ? report_bug+0x2b3/0x500
[    8.025925][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.030150][    T1]  ? handle_bug+0x3e/0x70
[    8.031086][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.033097][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.034748][    T1]  ? __warn_printk+0x292/0x360
[    8.037244][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.039638][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.041044][    T1]  __free_pages_ok+0xc42/0xd70
[    8.042367][    T1]  make_alloc_exact+0xa3/0xf0
[    8.044313][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.046844][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.048504][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.049295][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.050056][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.051457][    T1]  ? really_probe+0x29e/0xc50
[    8.053456][    T1]  ? driver_probe_device+0x50/0x430
[    8.054843][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.056263][    T1]  ? ret_from_fork+0x4b/0x80
[    8.057026][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.058003][    T1]  vring_create_virtqueue+0xca/0x110
[    8.058950][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.060241][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.061548][    T1]  setup_vq+0xe9/0x2d0
[    8.062720][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.066249][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.068677][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.070491][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.071820][    T1]  vp_setup_vq+0xbf/0x330
[    8.073020][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.075411][    T1]  ? ioread16+0x2f/0x90
[    8.076389][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.077767][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.078910][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.080111][    T1]  virtscsi_init+0x8db/0xd00
[    8.081712][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.082801][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.083916][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.085236][    T1]  ? vp_get+0xfd/0x140
[    8.086319][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.087214][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.090404][    T1]  ? __pfx_vp_legacy_set_queue_address+0xd/0x10
[    8.093111][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    8.094419][    T1]  ? vp_set_status+0x1a/0x40
[    8.096021][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.099934][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.101665][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.102487][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.105262][    T1]  really_probe+0x29e/0xc50
[    8.106620][    T1]  __driver_probe_device+0x1a2/0x3e0
[    8.108641][    T1]  driver_probe_device+0x50/0x430
[    8.110744][    T1]  __driver_attach+0x45f/0x710
[    8.112598][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.114221][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.115430][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.116906][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.120034][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.121570][    T1]  bus_add_driver+0x347/0x620
[    8.123679][    T1]  driver_register+0x23a/0x320
[    8.125189][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.127373][    T1]  virtio_scsi_init+0x65/0xe0
[    8.128421][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.129199][    T1]  do_one_initcall+0x238/0x830
[    8.129859][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.130668][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.132091][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.133177][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.134004][    T1]  ? do_initcalls+0x1c/0x80
[    8.134724][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.135571][    T1]  do_initcall_level+0x157/0x210
[    8.136670][    T1]  do_initcalls+0x3f/0x80
[    8.137348][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.138236][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.139208][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.142052][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.143016][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.144221][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.145741][    T1]  kernel_init+0x1d/0x2b0
[    8.146662][    T1]  ret_from_fork+0x4b/0x80
[    8.147514][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.148713][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.149784][    T1]  </TASK>
[    8.150600][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.152093][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-11136-g66a27abac311-dirty #0
[    8.154786][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.155798][    T1] Call Trace:
[    8.155798][    T1]  <TASK>
[    8.155798][    T1]  dump_stack_lvl+0x241/0x360
[    8.155798][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.155798][    T1]  ? __pfx__printk+0x10/0x10
[    8.155798][    T1]  ? _printk+0xd5/0x120
[    8.155798][    T1]  ? vscnprintf+0x5d/0x90
[    8.155798][    T1]  panic+0x349/0x860
[    8.155798][    T1]  ? __warn+0x172/0x4b0
[    8.155798][    T1]  ? __pfx_panic+0x10/0x10
[    8.155798][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.155798][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.155798][    T1]  __warn+0x31e/0x4b0
[    8.155798][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.155798][    T1]  report_bug+0x2b3/0x500
[    8.155798][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.155798][    T1]  handle_bug+0x3e/0x70
[    8.155798][    T1]  exc_invalid_op+0x1a/0x50
[    8.155798][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.155798][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.155798][    T1] Code: b2 00 00 00 e8 e7 e2 ec fc 5b 5d c3 cc cc cc c=
c e8 db e2 ec fc c6 05 c6 89 ea 0a 01 90 48 c7 c7 60 ae 1e 8c e8 47 a8 af f=
c 90 <0f> 0b 90 90 eb d9 e8 bb e2 ec fc c6 05 a3 89 ea 0a 01 90 48 c7 c7
[    8.155798][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.155798][    T1] RAX: ca7328f93391fe00 RBX: ffff888020f9e75c RCX: fff=
f8880166e0000
[    8.155798][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.155798][    T1] RBP: 0000000000000004 R08: ffffffff8157e022 R09: fff=
ffbfff1c39660
[    8.155798][    T1] R10: dffffc0000000000 R11: fffffbfff1c39660 R12: fff=
fea0000851dc0
[    8.196035][    T1] R13: ffffea0000851dc8 R14: 1ffffd400010a3b9 R15: 000=
0000000000000
[    8.196035][    T1]  ? __warn_printk+0x292/0x360
[    8.196035][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.196035][    T1]  __free_pages_ok+0xc42/0xd70
[    8.196035][    T1]  make_alloc_exact+0xa3/0xf0
[    8.196035][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.196035][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.196035][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.196035][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.196035][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.196035][    T1]  ? really_probe+0x29e/0xc50
[    8.196035][    T1]  ? driver_probe_device+0x50/0x430
[    8.196035][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.196035][    T1]  ? ret_from_fork+0x4b/0x80
[    8.196035][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.196035][    T1]  vring_create_virtqueue+0xca/0x110
[    8.196035][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.196035][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.196035][    T1]  setup_vq+0xe9/0x2d0
[    8.196035][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.196035][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.196035][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.196035][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.196035][    T1]  vp_setup_vq+0xbf/0x330
[    8.196035][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.196035][    T1]  ? ioread16+0x2f/0x90
[    8.196035][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.196035][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.196035][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.196035][    T1]  virtscsi_init+0x8db/0xd00
[    8.196035][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.196035][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.196035][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.196035][    T1]  ? vp_get+0xfd/0x140
[    8.196035][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.196035][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.196035][    T1]  ? __pfx_vp_legacy_set_queue_address+0xd/0x10
[    8.196035][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    8.196035][    T1]  ? vp_set_status+0x1a/0x40
[    8.196035][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.196035][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.196035][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.196035][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.196035][    T1]  really_probe+0x29e/0xc50
[    8.196035][    T1]  __driver_probe_device+0x1a2/0x3e0
[    8.196035][    T1]  driver_probe_device+0x50/0x430
[    8.196035][    T1]  __driver_attach+0x45f/0x710
[    8.196035][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.196035][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.196035][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.196035][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.196035][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.246039][    T1]  bus_add_driver+0x347/0x620
[    8.246039][    T1]  driver_register+0x23a/0x320
[    8.246039][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.246039][    T1]  virtio_scsi_init+0x65/0xe0
[    8.246039][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.246039][    T1]  do_one_initcall+0x238/0x830
[    8.246039][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.246039][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.246039][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.246039][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.246039][    T1]  ? do_initcalls+0x1c/0x80
[    8.246039][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.246039][    T1]  do_initcall_level+0x157/0x210
[    8.246039][    T1]  do_initcalls+0x3f/0x80
[    8.246039][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.246039][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.246039][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.246039][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.246039][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.246039][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.246039][    T1]  kernel_init+0x1d/0x2b0
[    8.246039][    T1]  ret_from_fork+0x4b/0x80
[    8.246039][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.246039][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.246039][    T1]  </TASK>
[    8.246039][    T1] Kernel Offset: disabled
[    8.246039][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1926694584=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D114224ee180000


Tested on:

commit:         66a27aba Merge tag 'powerpc-6.9-1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9f5be5e6842dd19=
2
dashboard link: https://syzkaller.appspot.com/bug?extid=3Daf9492708df979719=
8d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1624aed91800=
00


