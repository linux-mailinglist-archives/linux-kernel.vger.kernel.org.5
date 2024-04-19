Return-Path: <linux-kernel+bounces-151808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3428AB424
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C905C1F220D1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB856477;
	Fri, 19 Apr 2024 17:08:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FD1E502
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546486; cv=none; b=HHgBt1aBPeJFtXZQkQ0L2zVJEIQ0E+v/EIEpYWRC0r4kFHTUTtUglCluRPP0gPGZsNwXaR8DdsvHqAc3Xi6jAHdtNj6M8AkyMRw/9QOfNYM+hXJAgN/OIHmcWlNTDkkgoeKrkjNi/isTGSazYjcDDlJ+0YFj3kRl9GxpUeflafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546486; c=relaxed/simple;
	bh=DYUd44HGsZ4+CLVvrxKgs0bc9Uc36HhS6i6VgSTBxgw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bf8rNyGiU0wsJ0LowL+gFH8Vf9Yfg+lQ8YXjWkEUa65dtymMYWpwFx7kKom1P4Ku0pXt+FbOZ6CTo0dcmiFptLFqjySY/GBB8VVIib+nf4S4sqtl1vu1V0ITq7HGkQriunSYYvt4N9OJEdR2kxHG5Rf30NVhzlwKdbZUWQ1dCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da41c4b1eeso165018039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713546483; x=1714151283;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+P1dPkpHR+yT43dEdWHWIw+7nfxokV8QdrMSj1QwHA=;
        b=IGro+Csf3C0B0y5HTkIzWg1zIXA8enP9+btudElfU3ss26OmeNOS+YDWFq+ufmr1N9
         jWUh5tnjGNVTBe22G0IVpxyQBp8eB2+2TTo7IlqlOoO8ORjL8cxgIQy3oB/nFwRpJJy1
         FFQcUTBXsl3OKibbgV57EI29m3LoSiyree21xiW1GSdVO4dJXhoKwmfRXOs0K5mgH6rr
         ZZN9WvTk4G1PCNHHRgVByuF/jecXJ1PihhxlhMHUdP/8ZGISf+U5/BxFaf+/86yPx0cW
         iTCIFzKf7bFVs8+lHxy1LIqzoPHbHxG6MdXYrsN7HoSGfmiWWv3vw5cURP8U8wlxU9wf
         oPOg==
X-Forwarded-Encrypted: i=1; AJvYcCXH0NTEfvt6KgOGU1kngUx2jCfbagF0g36aLY0PiSeYQFGsmIf7Vd4O9xTeE/w1vsPO0RPNy9uf6WoTNhfvbbNAhx4ZZjFfVaXtsxz+
X-Gm-Message-State: AOJu0Yyxp+dRpOWAlX5ecQRJnuy6HrKhc79FaQXqqac3qCmntcE5+pKK
	l5rsXvE9EGpTINmkvbw+0X9nmBxqRnEvEEVdtjYO0+pQnHNwUpU42LJ0lABcqzoLjSHDSeSkHe7
	cV4Rw4dNj+kZbqIk6tp36o/nBTLriDcN8XX2TJWqzKbXFt/xKhtPpDmE=
X-Google-Smtp-Source: AGHT+IEKvUjfY2eANkaNnNNT2JpMP++BGs0p/NVS1ffzyQ62rl/+fr9Apzh4P70IQrNsRO3Ph0GrcPsTNWYI1Y4z74aNcOrR44pR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:870e:b0:484:a4c7:ee08 with SMTP id
 iw14-20020a056638870e00b00484a4c7ee08mr243319jab.0.1713546483516; Fri, 19 Apr
 2024 10:08:03 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:08:03 -0700
In-Reply-To: <20240419163349.20540-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074ddd60616762109@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in input_event (2)
From: syzbot <syzbot+d4c06e848a1c1f9f726f@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ered new interface driver rtsx_usb
[    7.634517][    T1] usbcore: registered new interface driver viperboard
[    7.636633][    T1] usbcore: registered new interface driver dln2
[    7.637993][    T1] usbcore: registered new interface driver pn533_usb
[    7.644508][    T1] nfcsim 0.2 initialized
[    7.645311][    T1] usbcore: registered new interface driver port100
[    7.646749][    T1] usbcore: registered new interface driver nfcmrvl
[    7.653669][    T1] Loading iSCSI transport class v2.0-870.
[    7.673487][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.682830][    T1] ------------[ cut here ]------------
[    7.683827][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.685157][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.687468][    T1] Modules linked in:
[    7.688124][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-00113-g2668e3ae2ef3-dirty #0
[    7.689750][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.691310][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.692391][    T1] Code: b2 00 00 00 e8 f7 25 e7 fc 5b 5d c3 cc cc cc c=
c e8 eb 25 e7 fc c6 05 b9 a2 e5 0a 01 90 48 c7 c7 80 3d 1f 8c e8 47 c0 a9 f=
c 90 <0f> 0b 90 90 eb d9 e8 cb 25 e7 fc c6 05 96 a2 e5 0a 01 90 48 c7 c7
[    7.695171][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.696459][    T1] RAX: 215871e6f02e7200 RBX: ffff88814072374c RCX: fff=
f8880166d0000
[    7.697689][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.698819][    T1] RBP: 0000000000000004 R08: ffffffff815880a2 R09: fff=
ffbfff1c39b48
[    7.699877][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea0000846dc0
[    7.701019][    T1] R13: ffffea0000846dc8 R14: 1ffffd4000108db9 R15: 000=
0000000000000
[    7.702376][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.703947][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.704958][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    7.706361][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.707631][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.708825][    T1] Call Trace:
[    7.709413][    T1]  <TASK>
[    7.709929][    T1]  ? __warn+0x163/0x4e0
[    7.710644][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.711650][    T1]  ? report_bug+0x2b3/0x500
[    7.712569][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.713521][    T1]  ? handle_bug+0x3e/0x70
[    7.714155][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.714820][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.715528][    T1]  ? __warn_printk+0x292/0x360
[    7.716343][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.717135][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.718192][    T1]  __free_pages_ok+0xc60/0xd90
[    7.718893][    T1]  make_alloc_exact+0xa3/0xf0
[    7.719753][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.720878][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.721837][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.722631][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.723321][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.724085][    T1]  ? really_probe+0x2b8/0xad0
[    7.725035][    T1]  ? driver_probe_device+0x50/0x430
[    7.725939][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.726833][    T1]  ? ret_from_fork+0x4b/0x80
[    7.727545][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.728856][    T1]  vring_create_virtqueue+0xca/0x110
[    7.729802][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.730501][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.731766][    T1]  setup_vq+0xe9/0x2d0
[    7.732420][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.733372][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.734230][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.735111][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.735961][    T1]  vp_setup_vq+0xbf/0x330
[    7.736791][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.738100][    T1]  ? ioread16+0x2f/0x90
[    7.738752][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.739755][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.740621][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.741314][    T1]  virtscsi_init+0x8db/0xd00
[    7.742665][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.743385][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.744188][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.744880][    T1]  ? vp_get+0xfd/0x140
[    7.745886][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.746690][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.747405][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.748307][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.749465][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.750275][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.751073][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.751895][    T1]  really_probe+0x2b8/0xad0
[    7.752754][    T1]  __driver_probe_device+0x1a2/0x390
[    7.754208][    T1]  driver_probe_device+0x50/0x430
[    7.755539][    T1]  __driver_attach+0x45f/0x710
[    7.756521][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.757862][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.758718][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.759488][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.760237][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.761233][    T1]  bus_add_driver+0x347/0x620
[    7.762229][    T1]  driver_register+0x23a/0x320
[    7.763093][    T1]  virtio_scsi_init+0x69/0xe0
[    7.763779][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.764701][    T1]  do_one_initcall+0x248/0x880
[    7.765411][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.766339][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.767256][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.768182][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.769173][    T1]  ? do_initcalls+0x1c/0x80
[    7.770103][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.771124][    T1]  do_initcall_level+0x157/0x210
[    7.772065][    T1]  do_initcalls+0x3f/0x80
[    7.772851][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.773659][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.774557][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.776278][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.777202][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.777966][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.778686][    T1]  kernel_init+0x1d/0x2b0
[    7.779531][    T1]  ret_from_fork+0x4b/0x80
[    7.780153][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.780872][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.781578][    T1]  </TASK>
[    7.782050][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.783113][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-00113-g2668e3ae2ef3-dirty #0
[    7.784483][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.786150][    T1] Call Trace:
[    7.786150][    T1]  <TASK>
[    7.786150][    T1]  dump_stack_lvl+0x241/0x360
[    7.786150][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.786150][    T1]  ? __pfx__printk+0x10/0x10
[    7.786150][    T1]  ? _printk+0xd5/0x120
[    7.786150][    T1]  ? vscnprintf+0x5d/0x90
[    7.786150][    T1]  panic+0x349/0x860
[    7.786150][    T1]  ? __warn+0x172/0x4e0
[    7.786150][    T1]  ? __pfx_panic+0x10/0x10
[    7.786150][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    7.786150][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    7.786150][    T1]  __warn+0x346/0x4e0
[    7.786150][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.786150][    T1]  report_bug+0x2b3/0x500
[    7.796183][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.796183][    T1]  handle_bug+0x3e/0x70
[    7.796183][    T1]  exc_invalid_op+0x1a/0x50
[    7.796183][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.796183][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.796183][    T1] Code: b2 00 00 00 e8 f7 25 e7 fc 5b 5d c3 cc cc cc c=
c e8 eb 25 e7 fc c6 05 b9 a2 e5 0a 01 90 48 c7 c7 80 3d 1f 8c e8 47 c0 a9 f=
c 90 <0f> 0b 90 90 eb d9 e8 cb 25 e7 fc c6 05 96 a2 e5 0a 01 90 48 c7 c7
[    7.796183][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.796183][    T1] RAX: 215871e6f02e7200 RBX: ffff88814072374c RCX: fff=
f8880166d0000
[    7.796183][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.806084][    T1] RBP: 0000000000000004 R08: ffffffff815880a2 R09: fff=
ffbfff1c39b48
[    7.806084][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea0000846dc0
[    7.806084][    T1] R13: ffffea0000846dc8 R14: 1ffffd4000108db9 R15: 000=
0000000000000
[    7.806084][    T1]  ? __warn_printk+0x292/0x360
[    7.806084][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.806084][    T1]  __free_pages_ok+0xc60/0xd90
[    7.806084][    T1]  make_alloc_exact+0xa3/0xf0
[    7.806084][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.806084][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.806084][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.806084][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.816141][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.816141][    T1]  ? really_probe+0x2b8/0xad0
[    7.816141][    T1]  ? driver_probe_device+0x50/0x430
[    7.816141][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.816141][    T1]  ? ret_from_fork+0x4b/0x80
[    7.816141][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.816141][    T1]  vring_create_virtqueue+0xca/0x110
[    7.816141][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.816141][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.816141][    T1]  setup_vq+0xe9/0x2d0
[    7.816141][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.816141][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.816141][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.826063][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.826063][    T1]  vp_setup_vq+0xbf/0x330
[    7.826063][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.826063][    T1]  ? ioread16+0x2f/0x90
[    7.826063][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.826063][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.826063][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.826063][    T1]  virtscsi_init+0x8db/0xd00
[    7.826063][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.826063][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.826063][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.826063][    T1]  ? vp_get+0xfd/0x140
[    7.826063][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.826063][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.836184][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.836184][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.836184][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.836184][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.836184][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.836184][    T1]  really_probe+0x2b8/0xad0
[    7.836184][    T1]  __driver_probe_device+0x1a2/0x390
[    7.836184][    T1]  driver_probe_device+0x50/0x430
[    7.836184][    T1]  __driver_attach+0x45f/0x710
[    7.836184][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.836184][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.836184][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.846105][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.846105][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.846105][    T1]  bus_add_driver+0x347/0x620
[    7.846105][    T1]  driver_register+0x23a/0x320
[    7.846105][    T1]  virtio_scsi_init+0x69/0xe0
[    7.846105][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.846105][    T1]  do_one_initcall+0x248/0x880
[    7.846105][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.846105][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.846105][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.846105][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.846105][    T1]  ? do_initcalls+0x1c/0x80
[    7.846105][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.856222][    T1]  do_initcall_level+0x157/0x210
[    7.856222][    T1]  do_initcalls+0x3f/0x80
[    7.856222][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.856222][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.856222][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.856222][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.856222][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.856222][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.856222][    T1]  kernel_init+0x1d/0x2b0
[    7.856222][    T1]  ret_from_fork+0x4b/0x80
[    7.856222][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.856222][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.856222][    T1]  </TASK>
[    7.866111][    T1] Kernel Offset: disabled
[    7.866111][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2070068173=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 478efa7f2
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
/syzkaller/prog.GitRevision=3D478efa7f2f5af720ac23b860a65d458f3db39b0c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240411-101510'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D478efa7f2f5af720ac23b860a65d458f3db39b0c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240411-101510'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D478efa7f2f5af720ac23b860a65d458f3db39b0c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240411-101510'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"478efa7f2f5af720ac23b860a65d458f3d=
b39b0c\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12c085f7180000


Tested on:

commit:         2668e3ae Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc6e826cf3c9c6ff=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd4c06e848a1c1f9f7=
26f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D154085f71800=
00


