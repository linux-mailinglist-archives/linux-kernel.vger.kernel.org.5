Return-Path: <linux-kernel+bounces-137912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561E989E96D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE4B281814
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605014A8C;
	Wed, 10 Apr 2024 05:07:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5910A1F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725625; cv=none; b=IoO37Q+sYmfzGuvRP+/XXfid5XQU2jXT/pgSRDBpBHV2BHmfA0clcB6getauBesyOMQ0hSeEuYsSLpz2dc6N5Whj1ezZ2+A5HYCjSCLD8jKkCUgQNAxxISbJcMYGhLYfqCSgEPF9R3r/qye4mjDMjFgZ5d5abDk4NqZpIN0rvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725625; c=relaxed/simple;
	bh=eTrn6QX5pIue5F/RGIJB62frGcZkdNtDXcjN1+rVqvg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ws7Jwm7Zf+uzwtAqjcbZWc3KuoCoRxUU/a2MbAKYtMom0GiuxWhKAE8ATfYW3LHk74kJE2RyoIDVFAEdNZdczSzyFUBbkC13M/bvZp4siRdCx9D5qB97GosUBcs9hbtFQyqNfXjZvUU2pjcQRe/q+pxZIsX8H848d/buc4id4Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso529553239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 22:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712725623; x=1713330423;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQla9t1Pwn9WVAGIGyPeGPTdLOHeiXvlVjAgUVQKPRY=;
        b=B4YoNYzzzkTuHRSFemNf+gkx2Mpj0ZwYdoxqQOxCfJy6/duEN0hwRjC74Kays3HnGp
         ItpHxrBkHS83EW7RFIkRnZsa2ZLWfgpik7salnhhqZa9JdyRLe8x8Y6TjdNbABBbsYqZ
         F/a3TF51ZJWIgys5io3uAxl1zwrP8zqKIoORKt2f30ZaHF8bRS0mkwdR57sKIMLwNnr1
         zoxqcOhVxNnwsb84DAuIil+DRRBOxMPUY7y/dWI5x5uGW70D5yvBXEigfQ2VrwHhhGZ+
         mJX3f7tQf7u4PJB20aJwpPGr8V9Vc+7Dpw2gK9NOKWeslJBPqgHAwC5senwY8qdM4RIx
         +i8w==
X-Forwarded-Encrypted: i=1; AJvYcCUY5FYq7dXvwgit8FyngjTt5N/sq/A6hmpvY+XovBNhFmcrEqlxuE2OyxzpfsS0yUhZiK2xWXRVlhuMwc1NQbbCw0VwF11+GFv3xOAa
X-Gm-Message-State: AOJu0Yznq+37L1q1BNmE9q+QgEJs8dDZ4auqiQg28zX/ML/McH/u1xAr
	nqFR/3t8EQtsy6NYLp5yUNX4tXfPquEOerliD8kLU82R2vOmUalqIf6vI3B++KYkJu6v626zHPo
	+LLEsZwGnnirprhuN/XKL14tC1oLYdSHeOhw5f9deU+JyVIGXPLxzu50=
X-Google-Smtp-Source: AGHT+IGJl7SwcQjZCscSPFuQ3rwg7saWOQ0eS8u5ckLVWwUIumzFp0MEOBgSQnlUIgSc7BLR4uax9CgF1Jv62wp5qbvRK8u7t4VF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2711:b0:47c:6d4:3e57 with SMTP id
 m17-20020a056638271100b0047c06d43e57mr90450jav.0.1712725623188; Tue, 09 Apr
 2024 22:07:03 -0700 (PDT)
Date: Tue, 09 Apr 2024 22:07:03 -0700
In-Reply-To: <ZhUNOvAuGLgvdTm1@Laptop-X1>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e416d0615b702bf@google.com>
Subject: Re: [syzbot] [net?] KASAN: global-out-of-bounds Read in __nla_validate_parse
From: syzbot <syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com>
To: edumazet@google.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, liuhangbin@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

gistered new interface driver port100
[    8.605288][    T1] usbcore: registered new interface driver nfcmrvl
[    8.612384][    T1] Loading iSCSI transport class v2.0-870.
[    8.632743][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    8.649045][    T1] ------------[ cut here ]------------
[    8.651103][    T1] refcount_t: decrement hit 0; leaking memory.
[    8.653196][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    8.656346][    T1] Modules linked in:
[    8.658418][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00751-g811b83628577 #0
[    8.661088][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.663945][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.666244][    T1] Code: b2 00 00 00 e8 f7 ca e7 fc 5b 5d c3 cc cc cc c=
c e8 eb ca e7 fc c6 05 ed 2e e6 0a 01 90 48 c7 c7 60 53 1f 8c e8 f7 65 aa f=
c 90 <0f> 0b 90 90 eb d9 e8 cb ca e7 fc c6 05 ca 2e e6 0a 01 90 48 c7 c7
[    8.672287][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.674145][    T1] RAX: e9d1be24727a8200 RBX: ffff888140706ffc RCX: fff=
f8880166d0000
[    8.676538][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.679139][    T1] RBP: 0000000000000004 R08: ffffffff8157ff62 R09: fff=
ffbfff1c39af8
[    8.682784][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: fff=
fea000501ddc0
[    8.684849][    T1] R13: ffffea000501ddc8 R14: 1ffffd4000a03bb9 R15: 000=
0000000000000
[    8.687096][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    8.690385][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.692275][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    8.694842][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.697463][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.699145][    T1] Call Trace:
[    8.699945][    T1]  <TASK>
[    8.700721][    T1]  ? __warn+0x163/0x4e0
[    8.701507][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.703186][    T1]  ? report_bug+0x2b3/0x500
[    8.704498][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.706166][    T1]  ? handle_bug+0x3e/0x70
[    8.707260][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.708055][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.709269][    T1]  ? __warn_printk+0x292/0x360
[    8.710533][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.712248][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.714123][    T1]  __free_pages_ok+0xc60/0xd90
[    8.715511][    T1]  make_alloc_exact+0xa3/0xf0
[    8.716981][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.718319][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.720194][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.721462][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.722932][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.724571][    T1]  ? really_probe+0x2b8/0xad0
[    8.725948][    T1]  ? driver_probe_device+0x50/0x430
[    8.727795][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.729706][    T1]  ? ret_from_fork+0x4b/0x80
[    8.731360][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.733405][    T1]  vring_create_virtqueue+0xca/0x110
[    8.735009][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.736149][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.737338][    T1]  setup_vq+0xe9/0x2d0
[    8.738378][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.739626][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.741097][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.743341][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.745685][    T1]  vp_setup_vq+0xbf/0x330
[    8.747110][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.748754][    T1]  ? ioread16+0x2f/0x90
[    8.749696][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.751335][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.752882][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.754279][    T1]  virtscsi_init+0x8db/0xd00
[    8.755286][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.756448][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.757687][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.758997][    T1]  ? vp_get+0xfd/0x140
[    8.760105][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.761249][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.763039][    T1]  ? vp_modern_admin_cmd_exec+0x5cd/0x820
[    8.764646][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    8.766479][    T1]  ? vp_set_status+0x1a/0x40
[    8.767568][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.770008][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.771947][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.772988][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.774056][    T1]  really_probe+0x2b8/0xad0
[    8.775076][    T1]  __driver_probe_device+0x1a2/0x390
[    8.776233][    T1]  driver_probe_device+0x50/0x430
[    8.777117][    T1]  __driver_attach+0x45f/0x710
[    8.777974][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.779233][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.780598][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.781797][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.783335][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.784745][    T1]  bus_add_driver+0x347/0x620
[    8.785738][    T1]  driver_register+0x23a/0x320
[    8.787433][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.789446][    T1]  virtio_scsi_init+0x65/0xe0
[    8.790926][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.792609][    T1]  do_one_initcall+0x248/0x880
[    8.793941][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.795386][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.797023][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.798339][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.799797][    T1]  ? do_initcalls+0x1c/0x80
[    8.800781][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.802366][    T1]  do_initcall_level+0x157/0x210
[    8.803925][    T1]  do_initcalls+0x3f/0x80
[    8.805248][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.806706][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.809002][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.810542][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.812134][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.813888][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.815517][    T1]  kernel_init+0x1d/0x2b0
[    8.817233][    T1]  ret_from_fork+0x4b/0x80
[    8.818982][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.820333][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.821668][    T1]  </TASK>
[    8.822521][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.824148][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00751-g811b83628577 #0
[    8.825595][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.825595][    T1] Call Trace:
[    8.825595][    T1]  <TASK>
[    8.825595][    T1]  dump_stack_lvl+0x241/0x360
[    8.825595][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.825595][    T1]  ? __pfx__printk+0x10/0x10
[    8.825595][    T1]  ? _printk+0xd5/0x120
[    8.825595][    T1]  ? vscnprintf+0x5d/0x90
[    8.825595][    T1]  panic+0x349/0x860
[    8.825595][    T1]  ? __warn+0x172/0x4e0
[    8.825595][    T1]  ? __pfx_panic+0x10/0x10
[    8.825595][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.825595][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.825595][    T1]  __warn+0x346/0x4e0
[    8.825595][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.825595][    T1]  report_bug+0x2b3/0x500
[    8.825595][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.825595][    T1]  handle_bug+0x3e/0x70
[    8.825595][    T1]  exc_invalid_op+0x1a/0x50
[    8.825595][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.825595][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.825595][    T1] Code: b2 00 00 00 e8 f7 ca e7 fc 5b 5d c3 cc cc cc c=
c e8 eb ca e7 fc c6 05 ed 2e e6 0a 01 90 48 c7 c7 60 53 1f 8c e8 f7 65 aa f=
c 90 <0f> 0b 90 90 eb d9 e8 cb ca e7 fc c6 05 ca 2e e6 0a 01 90 48 c7 c7
[    8.865888][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.865888][    T1] RAX: e9d1be24727a8200 RBX: ffff888140706ffc RCX: fff=
f8880166d0000
[    8.865888][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.865888][    T1] RBP: 0000000000000004 R08: ffffffff8157ff62 R09: fff=
ffbfff1c39af8
[    8.865888][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: fff=
fea000501ddc0
[    8.865888][    T1] R13: ffffea000501ddc8 R14: 1ffffd4000a03bb9 R15: 000=
0000000000000
[    8.865888][    T1]  ? __warn_printk+0x292/0x360
[    8.865888][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.865888][    T1]  __free_pages_ok+0xc60/0xd90
[    8.865888][    T1]  make_alloc_exact+0xa3/0xf0
[    8.865888][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.865888][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.865888][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.865888][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.865888][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.865888][    T1]  ? really_probe+0x2b8/0xad0
[    8.865888][    T1]  ? driver_probe_device+0x50/0x430
[    8.865888][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.865888][    T1]  ? ret_from_fork+0x4b/0x80
[    8.865888][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.865888][    T1]  vring_create_virtqueue+0xca/0x110
[    8.865888][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.865888][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.865888][    T1]  setup_vq+0xe9/0x2d0
[    8.865888][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.865888][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.865888][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.865888][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.865888][    T1]  vp_setup_vq+0xbf/0x330
[    8.865888][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.865888][    T1]  ? ioread16+0x2f/0x90
[    8.915813][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.915813][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.915813][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.915813][    T1]  virtscsi_init+0x8db/0xd00
[    8.915813][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.915813][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.915813][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.915813][    T1]  ? vp_get+0xfd/0x140
[    8.915813][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.915813][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.915813][    T1]  ? vp_modern_admin_cmd_exec+0x5cd/0x820
[    8.915813][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    8.915813][    T1]  ? vp_set_status+0x1a/0x40
[    8.915813][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.915813][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.915813][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.915813][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.915813][    T1]  really_probe+0x2b8/0xad0
[    8.915813][    T1]  __driver_probe_device+0x1a2/0x390
[    8.915813][    T1]  driver_probe_device+0x50/0x430
[    8.915813][    T1]  __driver_attach+0x45f/0x710
[    8.915813][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.915813][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.915813][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.915813][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.915813][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.915813][    T1]  bus_add_driver+0x347/0x620
[    8.915813][    T1]  driver_register+0x23a/0x320
[    8.915813][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.915813][    T1]  virtio_scsi_init+0x65/0xe0
[    8.965813][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.965813][    T1]  do_one_initcall+0x248/0x880
[    8.965813][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.965813][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.965813][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.965813][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.965813][    T1]  ? do_initcalls+0x1c/0x80
[    8.965813][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.965813][    T1]  do_initcall_level+0x157/0x210
[    8.965813][    T1]  do_initcalls+0x3f/0x80
[    8.965813][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.965813][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.965813][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.965813][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.965813][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.965813][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.965813][    T1]  kernel_init+0x1d/0x2b0
[    8.965813][    T1]  ret_from_fork+0x4b/0x80
[    8.965813][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.965813][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.965813][    T1]  </TASK>
[    8.965813][    T1] Kernel Offset: disabled
[    8.965813][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1094773893=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at ca620dd8f
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
/syzkaller/prog.GitRevision=3Dca620dd8f97f5b3a9134b687b5584203019518fb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240405-142321'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dca620dd8f97f5b3a9134b687b5584203019518fb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240405-142321'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dca620dd8f97f5b3a9134b687b5584203019518fb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240405-142321'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"ca620dd8f97f5b3a9134b687b558420301=
9518fb\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11a13da9180000


Tested on:

commit:         811b8362 Merge branch 'minor-cleanups-to-skb-frag-ref-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-ne=
xt.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D537dc8b4992a9fb=
a
dashboard link: https://syzkaller.appspot.com/bug?extid=3Decd7e07b4be038658=
c9f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

