Return-Path: <linux-kernel+bounces-97736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76867876E99
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EAF1F22A5A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D19208A9;
	Sat,  9 Mar 2024 01:32:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463C20317
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 01:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709947924; cv=none; b=Zzm5o5pGuKtTYecRR0lTXMSLSpRJp7bkJCZ7Rr4d7Q5BsKgyaWxuipLxgtgt5EA7cesIWBvBp03R0n5+aWCO5dDuZz6h8fq+7cnt5evwBzJVPO49l+UpL51kK+VnT5Qax3fLnbHyPKRZmix006iAAx2InTZp8F5LIIz6QDDoChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709947924; c=relaxed/simple;
	bh=5o/dssgIgsOZ47h1oDA6cffFWWV+X0exc1WsWr1rKGM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OObN11DrO0+MgQg2/UY771EEdYySpwH6kTu/pGnkOUkPtWantrTN+iK+L8XY8/M+/RqTlkzZWJcM56FD9eLC2EzWXAhQwM6z0hlP36l5/2oxyVCAIRxXFl9MfGPYBWDMprR/RgQFxJZub2ent4t7cfQcf5uV577HipTH7czWpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bc32b2226aso285034139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 17:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709947921; x=1710552721;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6xpnyE/gfeDHc5Z9+W6kL1tufnBacy0BoTtBms6mUU=;
        b=mueAnb2U9xyeiwmsog7345Cdm60yfuRy62UAc7/wdsAJZlbVUnuecvKy9cZcuXV4js
         QhAxn4z+XF/pVGZ+i2AM2vHf92ExaYsOyPyCjkgwAzUi3RGyptK0l/S+UOwMVKtXKsFV
         +Hy19cbFh0tesk76ULe2b5AelTy7xegm94H58nV8nCeLYdIqbLbwCS5pXYIx4MUdq5rz
         24HL2A530QRLJ4tfaNraLMPFZWIHtM5lgHDWy5e/+n33J4dBLdslfAhv9M+OU5zveVh1
         HktJ5Wb0UL9gOwe0igEsqlwFmT7ja9tUHyqpyG8RHV5J5w/JOLOoaiAjklGesrlMOHo5
         fXhg==
X-Forwarded-Encrypted: i=1; AJvYcCWJKIR55aGpgjXSyy1JgJgsoTFO+TLIbYq91VlR6V2kC/FUt8wjmGUw8sOHkTRoyhgvPtY1Vmv76DcnOm2vHiCQGXz2DxrKE0TJqX8P
X-Gm-Message-State: AOJu0YyVd0wHzSbbBa2nU/0yTQGPO5IyWTD7JdmQu16WI9dkRfcdHW9O
	7OwX1B3xvRn/qSzULHjnit4lD0nX7+9xe8koIZN7w2jPMUS/ROGDXTE2nMhuVQ6cV+AxKdUp+gQ
	rbbHETA2q0JKW5sZYD62qpILXrVJ4Ocf/YwOW/svnTXAaPvlmLb+6OHw=
X-Google-Smtp-Source: AGHT+IEZXf1kYdtA2wkUG2cW5hM8MvR+Z1TGuMREhg5IqkbEocVU2FyFr9M6RqzWB/scLfXxJp6IgEMiLwau1qMNIhLXYBMmI7tf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1589:b0:7c7:f56b:d343 with SMTP id
 e9-20020a056602158900b007c7f56bd343mr4657iow.4.1709947921444; Fri, 08 Mar
 2024 17:32:01 -0800 (PST)
Date: Fri, 08 Mar 2024 17:32:01 -0800
In-Reply-To: <20240308231459.1827-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071531306133046d3@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
From: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

sbcore: registered new interface driver dln2
[    8.758756][    T1] usbcore: registered new interface driver pn533_usb
[    8.766300][    T1] nfcsim 0.2 initialized
[    8.767501][    T1] usbcore: registered new interface driver port100
[    8.769021][    T1] usbcore: registered new interface driver nfcmrvl
[    8.777559][    T1] Loading iSCSI transport class v2.0-870.
[    8.798614][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    8.809823][    T1] ------------[ cut here ]------------
[    8.810772][    T1] refcount_t: decrement hit 0; leaking memory.
[    8.812057][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    8.813796][    T1] Modules linked in:
[    8.814366][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc7-=
next-20240308-syzkaller-g8ffc8b1bbd50-dirty #0
[    8.816583][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    8.821133][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.822500][    T1] Code: b2 00 00 00 e8 a7 e3 ec fc 5b 5d c3 cc cc cc c=
c e8 9b e3 ec fc c6 05 16 be ea 0a 01 90 48 c7 c7 60 ab 1e 8c e8 17 b9 af f=
c 90 <0f> 0b 90 90 eb d9 e8 7b e3 ec fc c6 05 f3 bd ea 0a 01 90 48 c7 c7
[    8.825856][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.826703][    T1] RAX: f37710c6fdfb4400 RBX: ffff8881472e256c RCX: fff=
f8880166d8000
[    8.828285][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.829591][    T1] RBP: 0000000000000004 R08: ffffffff8157d172 R09: fff=
ffbfff1c39614
[    8.831826][    T1] R10: dffffc0000000000 R11: fffffbfff1c39614 R12: fff=
fea0000851dc0
[    8.833304][    T1] R13: ffffea0000851dc8 R14: 1ffffd400010a3b9 R15: 000=
0000000000000
[    8.834541][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    8.836062][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.837282][    T1] CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 000=
00000003506f0
[    8.839016][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.840940][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.842607][    T1] Call Trace:
[    8.843365][    T1]  <TASK>
[    8.843855][    T1]  ? __warn+0x163/0x4b0
[    8.844635][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.846182][    T1]  ? report_bug+0x2b3/0x500
[    8.847620][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.848738][    T1]  ? handle_bug+0x3e/0x70
[    8.849656][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.851094][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.852147][    T1]  ? __warn_printk+0x292/0x360
[    8.853031][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.853917][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.854722][    T1]  __free_pages_ok+0xc42/0xd70
[    8.855417][    T1]  make_alloc_exact+0xa3/0xf0
[    8.856076][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.856911][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.857795][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.858505][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.859456][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.860939][    T1]  ? really_probe+0x29e/0xc50
[    8.862246][    T1]  ? driver_probe_device+0x50/0x430
[    8.863277][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.864213][    T1]  ? ret_from_fork+0x4b/0x80
[    8.864929][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.865989][    T1]  vring_create_virtqueue+0xca/0x110
[    8.867234][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.868277][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.869236][    T1]  setup_vq+0xe9/0x2d0
[    8.869960][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.870658][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.871551][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.872622][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.873697][    T1]  vp_setup_vq+0xbf/0x330
[    8.874450][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.875667][    T1]  ? ioread16+0x2f/0x90
[    8.876346][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.877234][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.878105][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.879082][    T1]  virtscsi_init+0x8db/0xd00
[    8.880685][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.882808][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.883806][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.885078][    T1]  ? vp_get+0xfd/0x140
[    8.886204][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.887594][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.888451][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.889293][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.890605][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.891781][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.893220][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.894284][    T1]  really_probe+0x29e/0xc50
[    8.895013][    T1]  __driver_probe_device+0x1a2/0x3e0
[    8.896119][    T1]  driver_probe_device+0x50/0x430
[    8.897148][    T1]  __driver_attach+0x45f/0x710
[    8.898234][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.899310][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.900535][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.902736][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.903955][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.905323][    T1]  bus_add_driver+0x347/0x620
[    8.906778][    T1]  driver_register+0x23a/0x320
[    8.907994][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.909607][    T1]  virtio_scsi_init+0x65/0xe0
[    8.910777][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.912214][    T1]  do_one_initcall+0x238/0x830
[    8.913543][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.914984][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.916819][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.917969][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.919098][    T1]  ? do_initcalls+0x1c/0x80
[    8.919909][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.920983][    T1]  do_initcall_level+0x157/0x210
[    8.922112][    T1]  do_initcalls+0x3f/0x80
[    8.923091][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.924601][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.926232][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.928164][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.929328][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.930562][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.931742][    T1]  kernel_init+0x1d/0x2b0
[    8.932479][    T1]  ret_from_fork+0x4b/0x80
[    8.933443][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.934667][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.936510][    T1]  </TASK>
[    8.937427][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.939173][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc7-=
next-20240308-syzkaller-g8ffc8b1bbd50-dirty #0
[    8.942655][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    8.945439][    T1] Call Trace:
[    8.946072][    T1]  <TASK>
[    8.946896][    T1]  dump_stack_lvl+0x241/0x360
[    8.947396][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.947396][    T1]  ? __pfx__printk+0x10/0x10
[    8.947396][    T1]  ? _printk+0xd5/0x120
[    8.947396][    T1]  ? vscnprintf+0x5d/0x90
[    8.947396][    T1]  panic+0x349/0x860
[    8.947396][    T1]  ? __warn+0x172/0x4b0
[    8.947396][    T1]  ? __pfx_panic+0x10/0x10
[    8.957077][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.957077][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.957077][    T1]  __warn+0x31e/0x4b0
[    8.957077][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.957077][    T1]  report_bug+0x2b3/0x500
[    8.957077][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.957077][    T1]  handle_bug+0x3e/0x70
[    8.967207][    T1]  exc_invalid_op+0x1a/0x50
[    8.967207][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.967207][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.967207][    T1] Code: b2 00 00 00 e8 a7 e3 ec fc 5b 5d c3 cc cc cc c=
c e8 9b e3 ec fc c6 05 16 be ea 0a 01 90 48 c7 c7 60 ab 1e 8c e8 17 b9 af f=
c 90 <0f> 0b 90 90 eb d9 e8 7b e3 ec fc c6 05 f3 bd ea 0a 01 90 48 c7 c7
[    8.977080][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.977080][    T1] RAX: f37710c6fdfb4400 RBX: ffff8881472e256c RCX: fff=
f8880166d8000
[    8.977080][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.977080][    T1] RBP: 0000000000000004 R08: ffffffff8157d172 R09: fff=
ffbfff1c39614
[    8.977080][    T1] R10: dffffc0000000000 R11: fffffbfff1c39614 R12: fff=
fea0000851dc0
[    8.977080][    T1] R13: ffffea0000851dc8 R14: 1ffffd400010a3b9 R15: 000=
0000000000000
[    8.987200][    T1]  ? __warn_printk+0x292/0x360
[    8.987200][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.987200][    T1]  __free_pages_ok+0xc42/0xd70
[    8.987200][    T1]  make_alloc_exact+0xa3/0xf0
[    8.987200][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.987200][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.987200][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.987200][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.987200][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.997075][    T1]  ? really_probe+0x29e/0xc50
[    8.997075][    T1]  ? driver_probe_device+0x50/0x430
[    8.997075][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.997075][    T1]  ? ret_from_fork+0x4b/0x80
[    8.997075][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.997075][    T1]  vring_create_virtqueue+0xca/0x110
[    8.997075][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.997075][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.997075][    T1]  setup_vq+0xe9/0x2d0
[    8.997075][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.007200][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.007200][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.007200][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.007200][    T1]  vp_setup_vq+0xbf/0x330
[    9.007200][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    9.007200][    T1]  ? ioread16+0x2f/0x90
[    9.007200][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.007200][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    9.007200][    T1]  vp_find_vqs+0x4c/0x4e0
[    9.017081][    T1]  virtscsi_init+0x8db/0xd00
[    9.017081][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.017081][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.017081][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    9.017081][    T1]  ? vp_get+0xfd/0x140
[    9.017081][    T1]  virtscsi_probe+0x3ea/0xf60
[    9.017081][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.027229][    T1]  ? kernfs_add_one+0x156/0x8b0
[    9.027229][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    9.027229][    T1]  ? virtio_features_ok+0x10c/0x270
[    9.027229][    T1]  virtio_dev_probe+0x991/0xaf0
[    9.027229][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.027229][    T1]  really_probe+0x29e/0xc50
[    9.027229][    T1]  __driver_probe_device+0x1a2/0x3e0
[    9.037078][    T1]  driver_probe_device+0x50/0x430
[    9.037078][    T1]  __driver_attach+0x45f/0x710
[    9.037078][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.037078][    T1]  bus_for_each_dev+0x239/0x2b0
[    9.037078][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.037078][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.037078][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    9.037078][    T1]  bus_add_driver+0x347/0x620
[    9.037078][    T1]  driver_register+0x23a/0x320
[    9.047213][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.047213][    T1]  virtio_scsi_init+0x65/0xe0
[    9.047213][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.047213][    T1]  do_one_initcall+0x238/0x830
[    9.047213][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.047213][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.047213][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.047213][    T1]  ? __pfx_parse_args+0x10/0x10
[    9.057088][    T1]  ? do_initcalls+0x1c/0x80
[    9.057088][    T1]  ? rcu_is_watching+0x15/0xb0
[    9.057088][    T1]  do_initcall_level+0x157/0x210
[    9.057088][    T1]  do_initcalls+0x3f/0x80
[    9.057088][    T1]  kernel_init_freeable+0x435/0x5d0
[    9.057088][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    9.057088][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.057088][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.067209][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.067209][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.067209][    T1]  kernel_init+0x1d/0x2b0
[    9.067209][    T1]  ret_from_fork+0x4b/0x80
[    9.067209][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.067209][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.067209][    T1]  </TASK>
[    9.067209][    T1] Kernel Offset: disabled
[    9.067209][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3507553695=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 352ab9047
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
/syzkaller/prog.GitRevision=3D352ab9047be19ed1d8367b9113b7bde280c90124 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240228-135607'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D352ab9047be19ed1d8367b9113b7bde280c90124 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240228-135607'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D352ab9047be19ed1d8367b9113b7bde280c90124 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240228-135607'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"352ab9047be19ed1d8367b9113b7bde280=
c90124\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D142c94da180000


Tested on:

commit:         8ffc8b1b Add linux-next specific files for 20240308
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9f21b6530bb238b=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3De5167d7144a627150=
44c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D148a3de11800=
00


