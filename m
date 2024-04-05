Return-Path: <linux-kernel+bounces-132421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2907C8994B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC8E1F2173D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA04224DC;
	Fri,  5 Apr 2024 05:22:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27F22616
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712294525; cv=none; b=OBihENd+ZGCNONlge1ZKJ81eeXng/HM0aIUhI45bcWt+m20n60o7cpb2R4IPcMAQdcSz7uZMgu8Z64RfGc2b2DGtF9LilGY83dNKBXS+ijNQdeLTA1UQZA4HxzuCSIvjoPZ8+TAiyHwonHin6WVHWYSzCD2a3tNgYBiB26BYQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712294525; c=relaxed/simple;
	bh=X8LbLTmDP/SNt/q2slin3ChMTdZXK5kxBMVZ0ldalsM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QbyOqt3rkJ5qWkBA+LQuZ+A2WA3Pyp9fB9ZUZtSGqc4r+TgIZE1maMwuqj5wShPdcflhpCvL+E28AVu1AQyaZ6zxF10h6JoODWXfpuY+XJ8gXwN+dP4BtyX7KzL4F3YPzEl2lnQ/+wqCK4kK9wmFYgvOdwQFdWQtoPlwlMMdy4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbfd4781fcso174398339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 22:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712294523; x=1712899323;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3P8rwifKzW2udlSUn614gvRyb4wgZ4uIvkmsFEWgOnw=;
        b=BILJsh6OvgfADjYmlqVrbCXBPeKOimAt5HgWR1ls6AWZrO8nnOFtbSLNRK+DNtwfAs
         3TadDjgf/NhJJUmfk31FGxF32wFHsBxm3019z9l3iMpfla8g6DtLA5I2RVIaELdyrfvs
         K49csdN+uYRbep5bY6xdxKfjOjnd/T1xeCwrTpYsmyhsDJZKc8BMc4qi7AxIjM0QXz0m
         wucECHX7OfV6N18YPPcMYRpeM1yGmrtUtWT+KvatbGFomIN/XS+6gmlKwa4sYzinwKO6
         X32NscEdOY2X7o5GBg2qDb+PiX5hTtjo4X2fmLkJU6nHW+ABoYWmOaRi1TYDy7rO1O2Q
         DyVA==
X-Forwarded-Encrypted: i=1; AJvYcCV3SVLadoDb0IX9Gf7MIgkLszrv9Sq6zLUYY9PFKT14QHkJsaGQdPHtDWs7dIApTvcmrQ+J/7E6D8bOpAy7Ev/aMYvDaRSw2nETsICh
X-Gm-Message-State: AOJu0Yx065mEZxykLXRdan//4Nw3FpYt752U2C5AJ34XN9a/LqD8kIw9
	Jb0LMIikWm7k5ggActOWOmG/zlaqUn3xQSYvo5XiOoBL52ulh58KCmFLhBrtQVjx+Cm84XuDCSC
	qAIAIpioHekTE6vyGXVnLke+0nE2ZtxO8vlLc+WQHKga9r2LXjhu9wco=
X-Google-Smtp-Source: AGHT+IGsJUvjCj2hMbTyYsKh74zy9M9tfLx5Suy1y0PtUGoD0OlhLJorkt6pG0meaVuOSTBxMZUdZUdfhmapU4CXeYjekEINnQAV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:369:f7ca:a344 with SMTP id
 v6-20020a056e02164600b00369f7caa344mr22459ilu.0.1712294523187; Thu, 04 Apr
 2024 22:22:03 -0700 (PDT)
Date: Thu, 04 Apr 2024 22:22:03 -0700
In-Reply-To: <20240404211329.40644-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce42c6061552a26c@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in unix_del_edges
From: syzbot <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

   8.212120][    T1] usbcore: registered new interface driver dln2
[    8.213619][    T1] usbcore: registered new interface driver pn533_usb
[    8.219690][    T1] nfcsim 0.2 initialized
[    8.220521][    T1] usbcore: registered new interface driver port100
[    8.221680][    T1] usbcore: registered new interface driver nfcmrvl
[    8.228707][    T1] Loading iSCSI transport class v2.0-870.
[    8.246261][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    8.257029][    T1] ------------[ cut here ]------------
[    8.258477][    T1] refcount_t: decrement hit 0; leaking memory.
[    8.260137][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    8.261845][    T1] Modules linked in:
[    8.262516][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00587-g1148c4098e91-dirty #0
[    8.264650][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.266787][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.267720][    T1] Code: b2 00 00 00 e8 67 bc e9 fc 5b 5d c3 cc cc cc c=
c e8 5b bc e9 fc c6 05 01 d6 e7 0a 01 90 48 c7 c7 e0 33 1f 8c e8 97 58 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 3b bc e9 fc c6 05 de d5 e7 0a 01 90 48 c7 c7
[    8.270554][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.271418][    T1] RAX: 974e1ecb508eeb00 RBX: ffff8880215be1cc RCX: fff=
f8880166d0000
[    8.272570][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000000
[    8.274748][    T1] RBP: 0000000000000004 R08: ffffffff815800a2 R09: fff=
ffbfff1c396e0
[    8.276442][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000085edc0
[    8.278522][    T1] R13: ffffea000085edc8 R14: 1ffffd400010bdb9 R15: 000=
0000000000000
[    8.279919][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    8.281604][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.282666][    T1] CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 000=
00000003506f0
[    8.284991][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.286484][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.287637][    T1] Call Trace:
[    8.288094][    T1]  <TASK>
[    8.288507][    T1]  ? __warn+0x163/0x4e0
[    8.289131][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.290261][    T1]  ? report_bug+0x2b3/0x500
[    8.291100][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.292002][    T1]  ? handle_bug+0x3e/0x70
[    8.292662][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.294170][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.295054][    T1]  ? __warn_printk+0x292/0x360
[    8.295831][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.296625][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.297711][    T1]  __free_pages_ok+0xc60/0xd90
[    8.298434][    T1]  make_alloc_exact+0xa3/0xf0
[    8.299241][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.300331][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.301458][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.302182][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.303012][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.303941][    T1]  ? really_probe+0x2b8/0xad0
[    8.304920][    T1]  ? driver_probe_device+0x50/0x430
[    8.305769][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.306675][    T1]  ? ret_from_fork+0x4b/0x80
[    8.307401][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.308459][    T1]  vring_create_virtqueue+0xca/0x110
[    8.309400][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.310185][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.311281][    T1]  setup_vq+0xe9/0x2d0
[    8.311917][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.312811][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.313707][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.314501][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.315275][    T1]  vp_setup_vq+0xbf/0x330
[    8.315908][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.316689][    T1]  ? ioread16+0x2f/0x90
[    8.317266][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.318047][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.318749][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.319372][    T1]  virtscsi_init+0x8db/0xd00
[    8.320086][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.320818][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.322142][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.322957][    T1]  ? vp_get+0xfd/0x140
[    8.323715][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.324363][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.325113][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.325945][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.326777][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.327803][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.328575][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.329366][    T1]  really_probe+0x2b8/0xad0
[    8.330008][    T1]  __driver_probe_device+0x1a2/0x390
[    8.330931][    T1]  driver_probe_device+0x50/0x430
[    8.331626][    T1]  __driver_attach+0x45f/0x710
[    8.332858][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.333710][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.334423][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.335724][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.336563][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.337303][    T1]  bus_add_driver+0x347/0x620
[    8.337947][    T1]  driver_register+0x23a/0x320
[    8.338742][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.339660][    T1]  virtio_scsi_init+0x65/0xe0
[    8.340487][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.341518][    T1]  do_one_initcall+0x248/0x880
[    8.342203][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.343126][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.344315][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.345151][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.345841][    T1]  ? do_initcalls+0x1c/0x80
[    8.347111][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.347855][    T1]  do_initcall_level+0x157/0x210
[    8.348760][    T1]  do_initcalls+0x3f/0x80
[    8.349423][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.350160][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.351033][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.351922][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.352603][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.353421][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.354169][    T1]  kernel_init+0x1d/0x2b0
[    8.355176][    T1]  ret_from_fork+0x4b/0x80
[    8.356039][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.356939][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.357632][    T1]  </TASK>
[    8.358056][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.359262][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00587-g1148c4098e91-dirty #0
[    8.360836][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.362851][    T1] Call Trace:
[    8.363394][    T1]  <TASK>
[    8.363394][    T1]  dump_stack_lvl+0x241/0x360
[    8.363394][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.363394][    T1]  ? __pfx__printk+0x10/0x10
[    8.363394][    T1]  ? _printk+0xd5/0x120
[    8.363394][    T1]  ? vscnprintf+0x5d/0x90
[    8.363394][    T1]  panic+0x349/0x860
[    8.363394][    T1]  ? __warn+0x172/0x4e0
[    8.363394][    T1]  ? __pfx_panic+0x10/0x10
[    8.363394][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.363394][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.363394][    T1]  __warn+0x346/0x4e0
[    8.363394][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.363394][    T1]  report_bug+0x2b3/0x500
[    8.363394][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.363394][    T1]  handle_bug+0x3e/0x70
[    8.363394][    T1]  exc_invalid_op+0x1a/0x50
[    8.363394][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.363394][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.363394][    T1] Code: b2 00 00 00 e8 67 bc e9 fc 5b 5d c3 cc cc cc c=
c e8 5b bc e9 fc c6 05 01 d6 e7 0a 01 90 48 c7 c7 e0 33 1f 8c e8 97 58 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 3b bc e9 fc c6 05 de d5 e7 0a 01 90 48 c7 c7
[    8.363394][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.363394][    T1] RAX: 974e1ecb508eeb00 RBX: ffff8880215be1cc RCX: fff=
f8880166d0000
[    8.363394][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000000
[    8.363394][    T1] RBP: 0000000000000004 R08: ffffffff815800a2 R09: fff=
ffbfff1c396e0
[    8.363394][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000085edc0
[    8.363394][    T1] R13: ffffea000085edc8 R14: 1ffffd400010bdb9 R15: 000=
0000000000000
[    8.363394][    T1]  ? __warn_printk+0x292/0x360
[    8.363394][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.363394][    T1]  __free_pages_ok+0xc60/0xd90
[    8.363394][    T1]  make_alloc_exact+0xa3/0xf0
[    8.363394][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.363394][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.363394][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.363394][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.363394][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.363394][    T1]  ? really_probe+0x2b8/0xad0
[    8.363394][    T1]  ? driver_probe_device+0x50/0x430
[    8.363394][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.363394][    T1]  ? ret_from_fork+0x4b/0x80
[    8.363394][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.363394][    T1]  vring_create_virtqueue+0xca/0x110
[    8.363394][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.363394][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.363394][    T1]  setup_vq+0xe9/0x2d0
[    8.363394][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.363394][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.363394][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.363394][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.363394][    T1]  vp_setup_vq+0xbf/0x330
[    8.363394][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.363394][    T1]  ? ioread16+0x2f/0x90
[    8.413403][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.413403][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.413403][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.413403][    T1]  virtscsi_init+0x8db/0xd00
[    8.413403][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.413403][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.413403][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.413403][    T1]  ? vp_get+0xfd/0x140
[    8.413403][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.413403][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.413403][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.413403][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.413403][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.413403][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.413403][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.413403][    T1]  really_probe+0x2b8/0xad0
[    8.413403][    T1]  __driver_probe_device+0x1a2/0x390
[    8.413403][    T1]  driver_probe_device+0x50/0x430
[    8.413403][    T1]  __driver_attach+0x45f/0x710
[    8.413403][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.413403][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.413403][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.413403][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.413403][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.413403][    T1]  bus_add_driver+0x347/0x620
[    8.413403][    T1]  driver_register+0x23a/0x320
[    8.413403][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.413403][    T1]  virtio_scsi_init+0x65/0xe0
[    8.413403][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.413403][    T1]  do_one_initcall+0x248/0x880
[    8.413403][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.413403][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.413403][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.413403][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.413403][    T1]  ? do_initcalls+0x1c/0x80
[    8.413403][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.413403][    T1]  do_initcall_level+0x157/0x210
[    8.413403][    T1]  do_initcalls+0x3f/0x80
[    8.413403][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.413403][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.413403][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.413403][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.413403][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.413403][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.413403][    T1]  kernel_init+0x1d/0x2b0
[    8.413403][    T1]  ret_from_fork+0x4b/0x80
[    8.413403][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.413403][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.413403][    T1]  </TASK>
[    8.413403][    T1] Kernel Offset: disabled
[    8.413403][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2976360966=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 0ee3535ea
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
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"0ee3535ea8ff21d50e44372bb1cfd147e2=
99ab5b\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11b3cca9180000


Tested on:

commit:         1148c409 Merge branch 'selftests-net-groundwork-for-yn..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-ne=
xt.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D898d2273d9f2e9d=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3D7f7f201cc2668a8fd=
169
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D162dcca91800=
00


