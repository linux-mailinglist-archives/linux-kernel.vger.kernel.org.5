Return-Path: <linux-kernel+bounces-133944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DCA89AB44
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40AE1C20D3B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAE1376E7;
	Sat,  6 Apr 2024 14:05:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F63714C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712412305; cv=none; b=jprwpeyUfr0gYw1SsXM6wgooMotPF5+o4cHejRp3uTkfVzUcvk97H4UF1RK2eMCBxeTd10qSSmKIhGq2H75BGuo3HPWgA2wVVa1NgleZeq7f2kbyUalkpoUFL+h2TepaDDu+i2CTU9nXA+v8rO9BIS1GCecLPMIIKTm9kKRju2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712412305; c=relaxed/simple;
	bh=sx5oJC0NTPui1YKGxjxj+ftGk4CUx3mfFvxSw1ja1jQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lSTWSBtTleIB3CbVZODAP7eo8nKn7MS02tFeWIWbDmtbAUfD2bABPof/uCsYXJ1d2yEfdZiYFCfy/bmLjOgqeXHQ+8xuBrjaMuBvbMGPf6F+GMSD/aTU0dERaCCWAivQ/enoFM1VuMSKCMbUb18JPQM1k0RW90+keVmJje98Cmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so331301539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 07:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712412303; x=1713017103;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6+/CHLLhzAoSPyK84wgw/BGVaUrwrOXLiRz4O2urJ4=;
        b=ic1bwVrqvFRPAHLeYXTvWY7v3lrcs+wG99kYwz1fUMhsh9q6kazr2T/qB7adebKkSI
         DmH07iMYvVFbPPMG42GrEwLpUaE6JevgFzW8xCEGlGJ+UNp5Qc0xIN3Rppl81ZWhAW5F
         yIDdjkoh4m4WjFKbVHy/qF7lTuJ1Vc/31JwEx1Kz/0LQFCmnUKT347jdDUIG81+lfafF
         72+SFXacB30m9T43hqESFt5yhtlgs6mfnnlI6SPH4gOofgKttRWvPo7mOM7lJYnrhF82
         sqijX+KxV3z1+TJFhloQsaJ3P/dG4Wu/ml/bhUpHjWbE+BOOv0eUnafR/xSm24gpCU+B
         PgMw==
X-Gm-Message-State: AOJu0Yze/JQvcpSJ+fiDl6rC6PeUK7u2STfVPDe8ctvCeQsk/nL6hKlE
	dIs98XrYvuuMfFYme4aoIYYI35kNvcXXIOgz/ufdDIKydJKzQq0XHvwhCP1LEvK/h/1hw3WOn1j
	Sc8ZZ5+rjaUkv5D2GT8BD1PTS97NUdCFglgSVEA1EROGsvmIPVxnHCVbIrQ==
X-Google-Smtp-Source: AGHT+IEVW3WwhsKxhBKYXhDnRBRbPtaSHE4guSKe5f06eG+B1TTHgkD91TcyYcapfq9hFvm2tGi/r4CZE+pzCUAxVxOXQJ01AJCc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2656:b0:47f:bbce:999f with SMTP id
 n22-20020a056638265600b0047fbbce999fmr278526jat.0.1712412303300; Sat, 06 Apr
 2024 07:05:03 -0700 (PDT)
Date: Sat, 06 Apr 2024 07:05:03 -0700
In-Reply-To: <20240405133404.21621-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c289f06156e0fcf@google.com>
Subject: Re: [syzbot] [usb?] WARNING in vmk80xx_auto_attach/usb_submit_urb
From: syzbot <syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mrvl
[    9.784484][    T1] Loading iSCSI transport class v2.0-870.
[    9.808141][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    9.819415][    T1] ------------[ cut here ]------------
[    9.820607][    T1] refcount_t: decrement hit 0; leaking memory.
[    9.823474][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    9.827302][    T1] Modules linked in:
[    9.828078][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00291-g4090fa373f0e-dirty #0
[    9.830226][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.831957][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    9.833354][    T1] Code: b2 00 00 00 e8 97 bb e9 fc 5b 5d e9 b0 a5 e0 0=
6 e8 8b bb e9 fc c6 05 ae 61 e8 0a 01 90 48 c7 c7 e0 33 1f 8c e8 c7 57 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 6b bb e9 fc c6 05 8b 61 e8 0a 01 90 48 c7 c7
[    9.837294][    T1] RSP: 0018:ffffc90000066e18 EFLAGS: 00010246
[    9.838787][    T1] RAX: 96dc241c59f63100 RBX: ffff88814728c98c RCX: fff=
f8880166c8000
[    9.840391][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    9.842751][    T1] RBP: 0000000000000004 R08: ffffffff815800a2 R09: fff=
ffbfff1c396e0
[    9.844030][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea0000841dc0
[    9.845601][    T1] R13: ffffea0000841dc8 R14: 1ffffd40001083b9 R15: 000=
0000000000000
[    9.847085][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    9.850141][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.851952][    T1] CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 000=
0000000350ef0
[    9.853463][    T1] Call Trace:
[    9.854044][    T1]  <TASK>
[    9.854492][    T1]  ? __warn+0x163/0x4e0
[    9.855826][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.856975][    T1]  ? report_bug+0x2b3/0x500
[    9.857834][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.858970][    T1]  ? handle_bug+0x3e/0x70
[    9.859857][    T1]  ? exc_invalid_op+0x1a/0x50
[    9.860997][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    9.861892][    T1]  ? __warn_printk+0x292/0x360
[    9.862956][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.864134][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    9.865156][    T1]  __free_pages_ok+0xc60/0xd90
[    9.866233][    T1]  make_alloc_exact+0xa3/0xf0
[    9.867266][    T1]  vring_alloc_queue_split+0x20a/0x600
[    9.868113][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    9.869014][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    9.869822][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    9.870755][    T1]  ? virtio_dev_probe+0x993/0xaf0
[    9.871888][    T1]  ? really_probe+0x2ba/0xad0
[    9.872937][    T1]  ? driver_probe_device+0x50/0x430
[    9.874031][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    9.875012][    T1]  ? ret_from_fork+0x4d/0x80
[    9.875851][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.877083][    T1]  vring_create_virtqueue+0xca/0x110
[    9.878156][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.878929][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.880246][    T1]  setup_vq+0xe9/0x2d0
[    9.881279][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.882209][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.883109][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.884099][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.885268][    T1]  vp_setup_vq+0xc1/0x330
[    9.886145][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    9.887958][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.889015][    T1]  ? ioread16+0x2f/0x90
[    9.890945][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.892422][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    9.893497][    T1]  vp_find_vqs+0x4c/0x4e0
[    9.894568][    T1]  virtscsi_init+0x8dd/0xd00
[    9.895622][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.896682][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.897995][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.898758][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    9.899840][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.900792][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.901742][    T1]  ? vp_get+0xfd/0x140
[    9.902743][    T1]  virtscsi_probe+0x3ea/0xf60
[    9.903919][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.905007][    T1]  ? kernfs_add_one+0x156/0x8b0
[    9.906052][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.906956][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.907722][    T1]  ? virtio_features_ok+0x10c/0x270
[    9.908520][    T1]  virtio_dev_probe+0x993/0xaf0
[    9.909668][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.911031][    T1]  really_probe+0x2ba/0xad0
[    9.912278][    T1]  __driver_probe_device+0x1a2/0x390
[    9.913175][    T1]  driver_probe_device+0x50/0x430
[    9.914100][    T1]  __driver_attach+0x45f/0x710
[    9.915051][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.916517][    T1]  bus_for_each_dev+0x23b/0x2b0
[    9.917849][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.919074][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.920152][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    9.921132][    T1]  bus_add_driver+0x347/0x620
[    9.922154][    T1]  driver_register+0x23a/0x320
[    9.923103][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.924787][    T1]  virtio_scsi_init+0x65/0xe0
[    9.926151][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.927405][    T1]  do_one_initcall+0x24a/0x880
[    9.928359][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.929498][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.930582][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    9.931642][    T1]  ? __pfx_parse_args+0x10/0x10
[    9.933094][    T1]  ? do_initcalls+0x1c/0x80
[    9.933922][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.934814][    T1]  ? rcu_is_watching+0x15/0xb0
[    9.935681][    T1]  do_initcall_level+0x157/0x210
[    9.937413][    T1]  do_initcalls+0x3f/0x80
[    9.938179][    T1]  kernel_init_freeable+0x435/0x5d0
[    9.939093][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    9.940271][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.941311][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.942104][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.943109][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.944006][    T1]  kernel_init+0x1d/0x2b0
[    9.944698][    T1]  ret_from_fork+0x4d/0x80
[    9.945390][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.946451][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.949590][    T1]  </TASK>
[    9.950112][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    9.951275][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00291-g4090fa373f0e-dirty #0
[    9.952064][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.952064][    T1] Call Trace:
[    9.952064][    T1]  <TASK>
[    9.952064][    T1]  dump_stack_lvl+0x241/0x360
[    9.952064][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    9.952064][    T1]  ? __pfx__printk+0x10/0x10
[    9.952064][    T1]  ? _printk+0xd5/0x120
[    9.952064][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.952064][    T1]  ? vscnprintf+0x5d/0x90
[    9.952064][    T1]  panic+0x349/0x860
[    9.952064][    T1]  ? __warn+0x172/0x4e0
[    9.952064][    T1]  ? __pfx_panic+0x10/0x10
[    9.952064][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    9.952064][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    9.952064][    T1]  __warn+0x346/0x4e0
[    9.952064][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.952064][    T1]  report_bug+0x2b3/0x500
[    9.952064][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.952064][    T1]  handle_bug+0x3e/0x70
[    9.952064][    T1]  exc_invalid_op+0x1a/0x50
[    9.952064][    T1]  asm_exc_invalid_op+0x1a/0x20
[    9.952064][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    9.952064][    T1] Code: b2 00 00 00 e8 97 bb e9 fc 5b 5d e9 b0 a5 e0 0=
6 e8 8b bb e9 fc c6 05 ae 61 e8 0a 01 90 48 c7 c7 e0 33 1f 8c e8 c7 57 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 6b bb e9 fc c6 05 8b 61 e8 0a 01 90 48 c7 c7
[    9.952064][    T1] RSP: 0018:ffffc90000066e18 EFLAGS: 00010246
[    9.952064][    T1] RAX: 96dc241c59f63100 RBX: ffff88814728c98c RCX: fff=
f8880166c8000
[    9.952064][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    9.952064][    T1] RBP: 0000000000000004 R08: ffffffff815800a2 R09: fff=
ffbfff1c396e0
[    9.952064][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea0000841dc0
[    9.952064][    T1] R13: ffffea0000841dc8 R14: 1ffffd40001083b9 R15: 000=
0000000000000
[    9.952064][    T1]  ? __warn_printk+0x292/0x360
[    9.952064][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    9.952064][    T1]  __free_pages_ok+0xc60/0xd90
[    9.952064][    T1]  make_alloc_exact+0xa3/0xf0
[    9.952064][    T1]  vring_alloc_queue_split+0x20a/0x600
[    9.952064][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    9.952064][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    9.952064][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    9.952064][    T1]  ? virtio_dev_probe+0x993/0xaf0
[    9.952064][    T1]  ? really_probe+0x2ba/0xad0
[    9.952064][    T1]  ? driver_probe_device+0x50/0x430
[    9.952064][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    9.952064][    T1]  ? ret_from_fork+0x4d/0x80
[    9.952064][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.952064][    T1]  vring_create_virtqueue+0xca/0x110
[    9.952064][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.952064][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.002229][    T1]  setup_vq+0xe9/0x2d0
[   10.002229][    T1]  ? __pfx_vp_notify+0x10/0x10
[   10.002229][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.002229][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.002229][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.002229][    T1]  vp_setup_vq+0xc1/0x330
[   10.002229][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[   10.002229][    T1]  ? srso_return_thunk+0x5/0x5f
[   10.002229][    T1]  ? ioread16+0x2f/0x90
[   10.002229][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[   10.002229][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[   10.002229][    T1]  vp_find_vqs+0x4c/0x4e0
[   10.002229][    T1]  virtscsi_init+0x8dd/0xd00
[   10.002229][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[   10.002229][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[   10.002229][    T1]  ? srso_return_thunk+0x5/0x5f
[   10.002229][    T1]  ? scsi_host_alloc+0xa57/0xea0
[   10.002229][    T1]  ? srso_return_thunk+0x5/0x5f
[   10.002229][    T1]  ? srso_return_thunk+0x5/0x5f
[   10.002229][    T1]  ? vp_get+0xfd/0x140
[   10.002229][    T1]  virtscsi_probe+0x3ea/0xf60
[   10.002229][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[   10.002229][    T1]  ? kernfs_add_one+0x156/0x8b0
[   10.002229][    T1]  ? srso_return_thunk+0x5/0x5f
[   10.002229][    T1]  ? srso_return_thunk+0x5/0x5f
[   10.002229][    T1]  ? virtio_features_ok+0x10c/0x270
[   10.002229][    T1]  virtio_dev_probe+0x993/0xaf0
[   10.002229][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   10.002229][    T1]  really_probe+0x2ba/0xad0
[   10.002229][    T1]  __driver_probe_device+0x1a2/0x390
[   10.002229][    T1]  driver_probe_device+0x50/0x430
[   10.002229][    T1]  __driver_attach+0x45f/0x710
[   10.002229][    T1]  ? __pfx___driver_attach+0x10/0x10
[   10.002229][    T1]  bus_for_each_dev+0x23b/0x2b0
[   10.002229][    T1]  ? __pfx___driver_attach+0x10/0x10
[   10.002229][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   10.002229][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[   10.002229][    T1]  bus_add_driver+0x347/0x620
[   10.002229][    T1]  driver_register+0x23a/0x320
[   10.002229][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.002229][    T1]  virtio_scsi_init+0x65/0xe0
[   10.002229][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.002229][    T1]  do_one_initcall+0x24a/0x880
[   10.002229][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[   10.002229][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   10.002229][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   10.002229][    T1]  ? __pfx_parse_args+0x10/0x10
[   10.002229][    T1]  ? do_initcalls+0x1c/0x80
[   10.002229][    T1]  ? srso_return_thunk+0x5/0x5f
[   10.002229][    T1]  ? rcu_is_watching+0x15/0xb0
[   10.002229][    T1]  do_initcall_level+0x157/0x210
[   10.002229][    T1]  do_initcalls+0x3f/0x80
[   10.052252][    T1]  kernel_init_freeable+0x435/0x5d0
[   10.052252][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   10.052252][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   10.052252][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.052252][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.052252][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.052252][    T1]  kernel_init+0x1d/0x2b0
[   10.052252][    T1]  ret_from_fork+0x4d/0x80
[   10.052252][    T1]  ? __pfx_kernel_init+0x10/0x10
[   10.052252][    T1]  ret_from_fork_asm+0x1a/0x30
[   10.052252][    T1]  </TASK>
[   10.052252][    T1] Kernel Offset: disabled
[   10.052252][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2744125605=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 8d446f152
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
/syzkaller/prog.GitRevision=3D8d446f1521b580230a60c9ae228bf0c26312c80b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240222-153518'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D8d446f1521b580230a60c9ae228bf0c26312c80b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240222-153518'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D8d446f1521b580230a60c9ae228bf0c26312c80b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240222-153518'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"8d446f1521b580230a60c9ae228bf0c263=
12c80b\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12e36d15180000


Tested on:

commit:         4090fa37 af_unix: Replace garbage collection algorithm.
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-ne=
xt.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7b667bc37450fdc=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3D5f29dc6a889fc42bd=
896
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10fc3af61800=
00


