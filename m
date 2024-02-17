Return-Path: <linux-kernel+bounces-69825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2680858F0A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E2D1F2222B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052E651B1;
	Sat, 17 Feb 2024 11:23:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABFF1CD23
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708168986; cv=none; b=XwWKbCtuoA07vO2+EJyhTaS0ReJwUBnp4lG7/8MuZZ5ohrNJI8YZNClqWCTFb4Uj+3nJSEyqLkjZvJsjQoTf6qexU1+ogoa3qpxglfYG6LglwY1y2SwVoI9lGsVYK7gaEW0ZgK0NhnwYiuSqP/3/cTTxx4mkOJMEjgeX/Ba25v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708168986; c=relaxed/simple;
	bh=tMQKrR0rm7HiGth+JlKNoIUuA6/YBioKTR8TCU6T6UY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j9fchYSc580/R/F+PcMaCl2nXD+2wxn8HseVPk94SpdUTdP9/VSqQIOYSrmaIULm1ABexiFVvTFT5T7mfALyU02v9R7apwK+uhjVcOevuz0fGz6GM0sn9OBV4sHwS5ZhTy/f1snLN07P7mPZUoNYaW8rEdweijNVpLkU6alT5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfeae6a263so172136839f.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 03:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708168983; x=1708773783;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDlzEfjMcMjYU6gDxUrc3RhekDh2TAxT4/Rpj+doU2E=;
        b=JIAyeWiXGIC9l88zkNaA0yRm70a+t+NuQ0bKdQCtNswPcqN3kAADe8VOXbudretEVp
         DeF4qgQtcP70jEeAey4bBkcKFgKMdhWtlYTpTCtjnmEkrVyO4dHthkeq6jLokrXYm9CE
         FYV/bvSYSNX1WNd/upE7JwBb4nwWsNFs6/Q1VjlkubSKAh0j8eyszffoA5BZ2qHn54kD
         uX6KRl1sPslyGFsZ3inN6nDcXJtvMCDJ5aKOHsksMj/kFcxKMRuhDHUp1hyzpi3rAEZF
         dqVxNW1jedxmtZ/4oh6HC988JBA34j8bWbYEYlU+s0ht8k5vlCyBoZ7q5GwN6E39KddB
         UCeg==
X-Forwarded-Encrypted: i=1; AJvYcCX4jKOeW+a5RS1WewCMtcZKx/WYKRdBr/BD27jUS4ZNdwRGoCj7QC3oKtG4sPNB9XzvaJQpV612XZcDFNNl49lc1rtAsJFQBgTXnCv1
X-Gm-Message-State: AOJu0Ywig4aOsJvNpaX8w7TYJnuObW6O/bLQ1jzocPTIQWWVJbhIeyw2
	FOUCEW4wAtYGytWrWz9fHSggzGz9vHf2bUwN6UhIqL4us+b5R2tPOIqC9Pajy2p2bes0yIZWxud
	vrn7P2U7EUHgBPZlokry2lE2nLmwKIUq7WTYdjs+DTv9Yb7btDM1CF0s=
X-Google-Smtp-Source: AGHT+IH20x6EfwBj//pm1jybOk2D6Hd3ZX8otHlfIrKsZuABtwi5ydUJBUeqwBeSefL4J93T/trWUyxJRz7FlnxF4bWZIcGpcLb9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2e:b0:363:cdfb:7fd1 with SMTP id
 e14-20020a056e020b2e00b00363cdfb7fd1mr554072ilu.1.1708168983334; Sat, 17 Feb
 2024 03:23:03 -0800 (PST)
Date: Sat, 17 Feb 2024 03:23:03 -0800
In-Reply-To: <20240217105742.1194-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077d62606119215ff@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From: syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

st device registered (name=3Dvmci, major=3D10, minor=3D118)
[    7.646156][    T1] Initialized host personality
[    7.647936][    T1] usbcore: registered new interface driver rtsx_usb
[    7.649988][    T1] usbcore: registered new interface driver viperboard
[    7.651838][    T1] usbcore: registered new interface driver dln2
[    7.653834][    T1] usbcore: registered new interface driver pn533_usb
[    7.664347][    T1] nfcsim 0.2 initialized
[    7.665691][    T1] usbcore: registered new interface driver port100
[    7.668533][    T1] usbcore: registered new interface driver nfcmrvl
[    7.675630][    T1] Loading iSCSI transport class v2.0-870.
[    7.698216][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.709913][    T1] ------------[ cut here ]------------
[    7.711179][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.712836][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.715358][    T1] Modules linked in:
[    7.716481][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-=
next-20240216-syzkaller-07658-gd37e1e4c52bc-dirty #0
[    7.719681][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[    7.722153][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.723825][    T1] Code: b2 00 00 00 e8 b7 94 f0 fc 5b 5d c3 cc cc cc c=
c e8 ab 94 f0 fc c6 05 c6 16 ce 0a 01 90 48 c7 c7 a0 5a fe 8b e8 67 69 b4 f=
c 90 <0f> 0b 90 90 eb d9 e8 8b 94 f0 fc c6 05 a3 16 ce 0a 01 90 48 c7 c7
[    7.728144][    T1] RSP: 0000:ffffc90000066e10 EFLAGS: 00010246
[    7.729780][    T1] RAX: ca34bf339345e800 RBX: ffff888020eb0f4c RCX: fff=
f8880162d8000
[    7.731521][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.733264][    T1] RBP: 0000000000000004 R08: ffffffff8157b942 R09: fff=
ffbfff1bf95cc
[    7.735392][    T1] R10: dffffc0000000000 R11: fffffbfff1bf95cc R12: fff=
fea000502ddc0
[    7.737235][    T1] R13: ffffea000502ddc8 R14: 1ffffd4000a05bb9 R15: 000=
0000000000000
[    7.738734][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.741305][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.742963][    T1] CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[    7.744872][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.746542][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.749418][    T1] Call Trace:
[    7.750267][    T1]  <TASK>
[    7.750946][    T1]  ? __warn+0x163/0x4b0
[    7.751918][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.752945][    T1]  ? report_bug+0x2b3/0x500
[    7.754131][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.755275][    T1]  ? handle_bug+0x3e/0x70
[    7.756610][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.757756][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.759043][    T1]  ? __warn_printk+0x292/0x360
[    7.760038][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.761095][    T1]  __free_pages_ok+0xc42/0xd70
[    7.761887][    T1]  make_alloc_exact+0xc4/0x140
[    7.762733][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.763909][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.765171][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.765822][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.766497][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.767234][    T1]  ? really_probe+0x29e/0xc50
[    7.767992][    T1]  ? driver_probe_device+0x50/0x430
[    7.769193][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.770403][    T1]  ? ret_from_fork+0x4b/0x80
[    7.771350][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.772638][    T1]  vring_create_virtqueue+0xca/0x110
[    7.773683][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.774585][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.775665][    T1]  setup_vq+0xe9/0x2d0
[    7.776917][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.778204][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.779467][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.781403][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.782743][    T1]  vp_setup_vq+0xbf/0x330
[    7.783647][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.784936][    T1]  ? ioread16+0x2f/0x90
[    7.785529][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.786299][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.787023][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.788532][    T1]  virtscsi_init+0x8db/0xd00
[    7.790004][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.790970][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.792125][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.793057][    T1]  ? vp_get+0xfd/0x140
[    7.793938][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.794992][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.795946][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.796940][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.798029][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.799045][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.800155][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.801103][    T1]  really_probe+0x29e/0xc50
[    7.802608][    T1]  __driver_probe_device+0x1a2/0x3e0
[    7.803793][    T1]  driver_probe_device+0x50/0x430
[    7.804857][    T1]  __driver_attach+0x45f/0x710
[    7.805550][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.806333][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.807759][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.808888][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.809993][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.811278][    T1]  bus_add_driver+0x347/0x620
[    7.812206][    T1]  driver_register+0x23a/0x320
[    7.813748][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.815079][    T1]  virtio_scsi_init+0x65/0xe0
[    7.816135][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.817203][    T1]  do_one_initcall+0x238/0x830
[    7.818686][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.819999][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.821171][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.822983][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.823803][    T1]  ? do_initcalls+0x1c/0x80
[    7.825039][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.825767][    T1]  do_initcall_level+0x157/0x210
[    7.827178][    T1]  do_initcalls+0x3f/0x80
[    7.828780][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.829898][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.831154][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.833103][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.834732][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.835783][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.836738][    T1]  kernel_init+0x1d/0x2b0
[    7.837904][    T1]  ret_from_fork+0x4b/0x80
[    7.838532][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.839490][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.840865][    T1]  </TASK>
[    7.842221][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.844095][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-=
next-20240216-syzkaller-07658-gd37e1e4c52bc-dirty #0
[    7.844711][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[    7.844711][    T1] Call Trace:
[    7.844711][    T1]  <TASK>
[    7.844711][    T1]  dump_stack_lvl+0x241/0x360
[    7.844711][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.844711][    T1]  ? __pfx__printk+0x10/0x10
[    7.844711][    T1]  ? _printk+0xd5/0x120
[    7.844711][    T1]  ? vscnprintf+0x5d/0x90
[    7.844711][    T1]  panic+0x349/0x860
[    7.844711][    T1]  ? __warn+0x172/0x4b0
[    7.844711][    T1]  ? __pfx_panic+0x10/0x10
[    7.844711][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    7.844711][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    7.844711][    T1]  __warn+0x31e/0x4b0
[    7.844711][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.844711][    T1]  report_bug+0x2b3/0x500
[    7.844711][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.844711][    T1]  handle_bug+0x3e/0x70
[    7.844711][    T1]  exc_invalid_op+0x1a/0x50
[    7.844711][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.844711][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.844711][    T1] Code: b2 00 00 00 e8 b7 94 f0 fc 5b 5d c3 cc cc cc c=
c e8 ab 94 f0 fc c6 05 c6 16 ce 0a 01 90 48 c7 c7 a0 5a fe 8b e8 67 69 b4 f=
c 90 <0f> 0b 90 90 eb d9 e8 8b 94 f0 fc c6 05 a3 16 ce 0a 01 90 48 c7 c7
[    7.844711][    T1] RSP: 0000:ffffc90000066e10 EFLAGS: 00010246
[    7.844711][    T1] RAX: ca34bf339345e800 RBX: ffff888020eb0f4c RCX: fff=
f8880162d8000
[    7.844711][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.844711][    T1] RBP: 0000000000000004 R08: ffffffff8157b942 R09: fff=
ffbfff1bf95cc
[    7.844711][    T1] R10: dffffc0000000000 R11: fffffbfff1bf95cc R12: fff=
fea000502ddc0
[    7.844711][    T1] R13: ffffea000502ddc8 R14: 1ffffd4000a05bb9 R15: 000=
0000000000000
[    7.844711][    T1]  ? __warn_printk+0x292/0x360
[    7.844711][    T1]  __free_pages_ok+0xc42/0xd70
[    7.844711][    T1]  make_alloc_exact+0xc4/0x140
[    7.844711][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.844711][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.844711][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.844711][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.844711][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.844711][    T1]  ? really_probe+0x29e/0xc50
[    7.844711][    T1]  ? driver_probe_device+0x50/0x430
[    7.844711][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.844711][    T1]  ? ret_from_fork+0x4b/0x80
[    7.844711][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.844711][    T1]  vring_create_virtqueue+0xca/0x110
[    7.844711][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.894210][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.894210][    T1]  setup_vq+0xe9/0x2d0
[    7.894210][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.894210][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.894210][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.894210][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.894210][    T1]  vp_setup_vq+0xbf/0x330
[    7.894210][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.894210][    T1]  ? ioread16+0x2f/0x90
[    7.894210][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.894210][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.894210][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.894210][    T1]  virtscsi_init+0x8db/0xd00
[    7.894210][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.894210][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.894210][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.894210][    T1]  ? vp_get+0xfd/0x140
[    7.894210][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.894210][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.894210][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.894210][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.894210][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.894210][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.894210][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.894210][    T1]  really_probe+0x29e/0xc50
[    7.894210][    T1]  __driver_probe_device+0x1a2/0x3e0
[    7.894210][    T1]  driver_probe_device+0x50/0x430
[    7.894210][    T1]  __driver_attach+0x45f/0x710
[    7.894210][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.894210][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.894210][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.894210][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.894210][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.894210][    T1]  bus_add_driver+0x347/0x620
[    7.894210][    T1]  driver_register+0x23a/0x320
[    7.894210][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.894210][    T1]  virtio_scsi_init+0x65/0xe0
[    7.894210][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.894210][    T1]  do_one_initcall+0x238/0x830
[    7.894210][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.894210][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.894210][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.894210][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.894210][    T1]  ? do_initcalls+0x1c/0x80
[    7.894210][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.894210][    T1]  do_initcall_level+0x157/0x210
[    7.894210][    T1]  do_initcalls+0x3f/0x80
[    7.894210][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.894210][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.894210][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.894210][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.894210][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.894210][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.894210][    T1]  kernel_init+0x1d/0x2b0
[    7.894210][    T1]  ret_from_fork+0x4b/0x80
[    7.894210][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.894210][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.894210][    T1]  </TASK>
[    7.894210][    T1] Kernel Offset: disabled
[    7.894210][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2616846364=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 578f75388
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D578f753887693e1375d17cf79dc1c575f6032a5d -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240215-140143'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D578f753887693e1375d17cf79dc1c575f6032a5d -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240215-140143'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D578f753887693e1375d17cf79dc1c575f6032a5d -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240215-140143'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"578f753887693e1375d17cf79dc1c575f6=
032a5d\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D10615fc8180000


Tested on:

commit:         d37e1e4c Add linux-next specific files for 20240216
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4bc446d42a7d56c=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1683f76f1b20b826d=
e67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13dd25d01800=
00


