Return-Path: <linux-kernel+bounces-151964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD68AB64C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9891C2103C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A922E417;
	Fri, 19 Apr 2024 21:13:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFB62E3F7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561185; cv=none; b=WQaW4610GDxAQUlsgNTkoMnp+D6PE3tqOKug5AQgJXHYKxVfhlh0FpKwS8MLK4DnrPXktytO104O3R9108P367KqzrtfmDQ/CxNFwQWCtvUuhkrfSonr6oq4l+dmVinpHg+vDgXwsFP+1OjfdRX994sS7HWy89/IwNygRFoT6YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561185; c=relaxed/simple;
	bh=qBeNX0eKRM8l2memsXLhrx1KgVTuKZafgT+y13AN9oE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=boqW9V2FzZdsw4gAwvejYtgf4BXph7jNXTXaipYeLRzUoHuGswWmzHTpqiqKusHCTuQIjitkmCppZ0E8R7uoAs03PfuzPzypOcvDbedfoNhvY0kdKKwtnLrZwXLwhoFNMCpoRB5kpJf9jn3saAJQwXun6hPxEGZLap51uqJzKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d622cae9e4so274713739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713561182; x=1714165982;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Uy2/NL1CdN2lrJCb5YM2yvIF4z5nVY0Gs3xSdjoIsk=;
        b=YiFfAlPHFE0pQpUssJ+CcJcDJs4TQu5TeWLOK7aDLttkjtJzDVrhyL1uM4hWKmekOa
         zwlZ9iYm4ONWSWDx/8zOS7sehLb7FVIZGogPXc4UzUpO7cwS5xV/kTttcqK2pHDIp0bW
         rY6gqtbIKspXAfGjrw2EnyZ5rHLWhsofOx+/Q0D3RXHsy3k6Tyypt5NOvjo8bqFm5u5u
         bC69B2apDWPqeXNG3zrTjUxDSHVsuMOmoo6LNDV0L4s1LuSy4AFi4wAVQeC0HwF75w1w
         XgeS7gNLnG/Xr7pU5MSfD+SjpoWdr4566UNrCDdup+IBX+9DCNmTtaGbJVF6IGCYyCob
         H9GA==
X-Forwarded-Encrypted: i=1; AJvYcCVQi/q/n4QpjExplgV3+LxK+GxN5bogBtPStia3SilcionyccL9c63jKXzbrUPSS+4dPrxlsxyDbP2zJaEQeVuAD6FmQR4JP1BW3Gi2
X-Gm-Message-State: AOJu0YxqrJiDLe+XaBAO6KxnXW+INigE2SITeYkw5z4dF7flB5ylWLqx
	n89C1LxMEZQkvPx9miZToh0tpnb6cpWdxI7bCT+XW0Yw+JZ8WwpwyO4ND0j4keVlT4YVNlIjHUa
	fP/Hbmm1y7o0yy09QGdUtz8dDzPhfsZvtYWw9q2qaugwuDDWSVUlo83Q=
X-Google-Smtp-Source: AGHT+IF7r/Civg1eFyblINP/5BeTY7E1Ry0kAqfIkLVwqlACHKyf1EpON7jcfC5cXlwC45AfjWMwp2KkvmSu9KP9aGaimFFLqt/s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:860d:b0:482:ced6:e5f5 with SMTP id
 iu13-20020a056638860d00b00482ced6e5f5mr237425jab.1.1713561181781; Fri, 19 Apr
 2024 14:13:01 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:13:01 -0700
In-Reply-To: <20240419203945.2526-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a94e60616798d9a@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_del_edges
From: syzbot <syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

registered new interface driver rtsx_usb
[    7.654500][    T1] usbcore: registered new interface driver viperboard
[    7.656820][    T1] usbcore: registered new interface driver dln2
[    7.658229][    T1] usbcore: registered new interface driver pn533_usb
[    7.665094][    T1] nfcsim 0.2 initialized
[    7.666287][    T1] usbcore: registered new interface driver port100
[    7.667860][    T1] usbcore: registered new interface driver nfcmrvl
[    7.677894][    T1] Loading iSCSI transport class v2.0-870.
[    7.691826][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.700510][    T1] ------------[ cut here ]------------
[    7.701647][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.702712][    T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.705030][    T1] Modules linked in:
[    7.705931][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-00895-g4cad4efa6eb2-dirty #0
[    7.707420][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.708867][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.709787][    T1] Code: b2 00 00 00 e8 97 ee e6 fc 5b 5d c3 cc cc cc c=
c e8 8b ee e6 fc c6 05 92 84 e4 0a 01 90 48 c7 c7 80 33 1f 8c e8 f7 6a a9 f=
c 90 <0f> 0b 90 90 eb d9 e8 6b ee e6 fc c6 05 6f 84 e4 0a 01 90 48 c7 c7
[    7.712924][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.714098][    T1] RAX: 802fad55264ab500 RBX: ffff888146ad6b3c RCX: fff=
f8880166d0000
[    7.715583][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.717186][    T1] RBP: 0000000000000004 R08: ffffffff81588082 R09: fff=
ffbfff1c39b48
[    7.718689][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea0000850dc0
[    7.720446][    T1] R13: ffffea0000850dc8 R14: 1ffffd400010a1b9 R15: 000=
0000000000000
[    7.721919][    T1] FS:  0000000000000000(0000) GS:ffff8880b9500000(0000=
) knlGS:0000000000000000
[    7.723283][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.724203][    T1] CR2: 0000000000000000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    7.725329][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.726405][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.727490][    T1] Call Trace:
[    7.727952][    T1]  <TASK>
[    7.728408][    T1]  ? __warn+0x163/0x4e0
[    7.729132][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.729918][    T1]  ? report_bug+0x2b3/0x500
[    7.730722][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.731598][    T1]  ? handle_bug+0x3e/0x70
[    7.732470][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.733180][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.734321][    T1]  ? __warn_printk+0x292/0x360
[    7.735110][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.736046][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.737157][    T1]  __free_pages_ok+0xc60/0xd90
[    7.737974][    T1]  make_alloc_exact+0xa3/0xf0
[    7.739152][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.739921][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.740857][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.742030][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.743130][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.744156][    T1]  ? really_probe+0x2b8/0xad0
[    7.745411][    T1]  ? driver_probe_device+0x50/0x430
[    7.746481][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.747395][    T1]  ? ret_from_fork+0x4b/0x80
[    7.748185][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.749718][    T1]  vring_create_virtqueue+0xca/0x110
[    7.750680][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.751352][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.752127][    T1]  setup_vq+0xe9/0x2d0
[    7.752740][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.753739][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.754582][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.755808][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.756624][    T1]  vp_setup_vq+0xbf/0x330
[    7.757294][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.758740][    T1]  ? ioread16+0x2f/0x90
[    7.759423][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.760184][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.761570][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.762347][    T1]  virtscsi_init+0x8db/0xd00
[    7.763210][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.764163][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.765029][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.765845][    T1]  ? vp_get+0xfd/0x140
[    7.766595][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.767420][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.768268][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.769025][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.769838][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.770612][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.771348][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.772249][    T1]  really_probe+0x2b8/0xad0
[    7.773081][    T1]  __driver_probe_device+0x1a2/0x390
[    7.774142][    T1]  driver_probe_device+0x50/0x430
[    7.775055][    T1]  __driver_attach+0x45f/0x710
[    7.775738][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.777068][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.778013][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.778935][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.779835][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.780678][    T1]  bus_add_driver+0x347/0x620
[    7.781572][    T1]  driver_register+0x23a/0x320
[    7.782416][    T1]  virtio_scsi_init+0x69/0xe0
[    7.783114][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.783862][    T1]  do_one_initcall+0x248/0x880
[    7.784838][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.785602][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.786590][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.787715][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.788740][    T1]  ? do_initcalls+0x1c/0x80
[    7.789436][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.790134][    T1]  do_initcall_level+0x157/0x210
[    7.791134][    T1]  do_initcalls+0x3f/0x80
[    7.791963][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.792838][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.793797][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.794852][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.795572][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.796447][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.797205][    T1]  kernel_init+0x1d/0x2b0
[    7.797981][    T1]  ret_from_fork+0x4b/0x80
[    7.798980][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.799980][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.801171][    T1]  </TASK>
[    7.801810][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.802882][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-00895-g4cad4efa6eb2-dirty #0
[    7.804509][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.804834][    T1] Call Trace:
[    7.804834][    T1]  <TASK>
[    7.804834][    T1]  dump_stack_lvl+0x241/0x360
[    7.804834][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.804834][    T1]  ? __pfx__printk+0x10/0x10
[    7.804834][    T1]  ? _printk+0xd5/0x120
[    7.804834][    T1]  ? vscnprintf+0x5d/0x90
[    7.804834][    T1]  panic+0x349/0x860
[    7.804834][    T1]  ? __warn+0x172/0x4e0
[    7.804834][    T1]  ? __pfx_panic+0x10/0x10
[    7.804834][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    7.814431][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    7.814431][    T1]  __warn+0x346/0x4e0
[    7.814431][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.814431][    T1]  report_bug+0x2b3/0x500
[    7.814431][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.814431][    T1]  handle_bug+0x3e/0x70
[    7.814431][    T1]  exc_invalid_op+0x1a/0x50
[    7.814431][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.814431][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.814431][    T1] Code: b2 00 00 00 e8 97 ee e6 fc 5b 5d c3 cc cc cc c=
c e8 8b ee e6 fc c6 05 92 84 e4 0a 01 90 48 c7 c7 80 33 1f 8c e8 f7 6a a9 f=
c 90 <0f> 0b 90 90 eb d9 e8 6b ee e6 fc c6 05 6f 84 e4 0a 01 90 48 c7 c7
[    7.814431][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.824572][    T1] RAX: 802fad55264ab500 RBX: ffff888146ad6b3c RCX: fff=
f8880166d0000
[    7.824572][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.824572][    T1] RBP: 0000000000000004 R08: ffffffff81588082 R09: fff=
ffbfff1c39b48
[    7.824572][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea0000850dc0
[    7.824572][    T1] R13: ffffea0000850dc8 R14: 1ffffd400010a1b9 R15: 000=
0000000000000
[    7.824572][    T1]  ? __warn_printk+0x292/0x360
[    7.824572][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.824572][    T1]  __free_pages_ok+0xc60/0xd90
[    7.824572][    T1]  make_alloc_exact+0xa3/0xf0
[    7.824572][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.824572][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.834413][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.834413][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.834413][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.834413][    T1]  ? really_probe+0x2b8/0xad0
[    7.834413][    T1]  ? driver_probe_device+0x50/0x430
[    7.834413][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.834413][    T1]  ? ret_from_fork+0x4b/0x80
[    7.834413][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.834413][    T1]  vring_create_virtqueue+0xca/0x110
[    7.834413][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.834413][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.834413][    T1]  setup_vq+0xe9/0x2d0
[    7.834413][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.844326][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.844326][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.844326][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.844326][    T1]  vp_setup_vq+0xbf/0x330
[    7.844326][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.844326][    T1]  ? ioread16+0x2f/0x90
[    7.844326][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.844326][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.844326][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.844326][    T1]  virtscsi_init+0x8db/0xd00
[    7.844326][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.844326][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.844326][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.844326][    T1]  ? vp_get+0xfd/0x140
[    7.854405][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.854405][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.854405][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.854405][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.854405][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.854405][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.854405][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.854405][    T1]  really_probe+0x2b8/0xad0
[    7.854405][    T1]  __driver_probe_device+0x1a2/0x390
[    7.854405][    T1]  driver_probe_device+0x50/0x430
[    7.854405][    T1]  __driver_attach+0x45f/0x710
[    7.854405][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.854405][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.864323][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.864323][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.864323][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.864323][    T1]  bus_add_driver+0x347/0x620
[    7.864323][    T1]  driver_register+0x23a/0x320
[    7.864323][    T1]  virtio_scsi_init+0x69/0xe0
[    7.864323][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.864323][    T1]  do_one_initcall+0x248/0x880
[    7.864323][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.864323][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.864323][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.864323][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.864323][    T1]  ? do_initcalls+0x1c/0x80
[    7.864323][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.874391][    T1]  do_initcall_level+0x157/0x210
[    7.874391][    T1]  do_initcalls+0x3f/0x80
[    7.874391][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.874391][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.874391][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.874391][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.874391][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.874391][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.874391][    T1]  kernel_init+0x1d/0x2b0
[    7.874391][    T1]  ret_from_fork+0x4b/0x80
[    7.874391][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.874391][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.874391][    T1]  </TASK>
[    7.884330][    T1] Kernel Offset: disabled
[    7.884330][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3954342966=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at af24b0505
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
/syzkaller/prog.GitRevision=3Daf24b0505c748561efb50f1d03c824d6642f6c0b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240418-062732'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Daf24b0505c748561efb50f1d03c824d6642f6c0b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240418-062732'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Daf24b0505c748561efb50f1d03c824d6642f6c0b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240418-062732'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"af24b0505c748561efb50f1d03c824d664=
2f6c0b\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11617880980000


Tested on:

commit:         4cad4efa Merge branch 'net-neigh-rcu'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-ne=
xt.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Decd971c4c871c35=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3Df3f3eef1d2100200e=
593
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D15ef206f1800=
00


