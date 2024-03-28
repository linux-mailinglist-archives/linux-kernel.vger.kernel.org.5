Return-Path: <linux-kernel+bounces-123488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31973890957
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96A2298231
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8813791D;
	Thu, 28 Mar 2024 19:38:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9089A1EA6E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654685; cv=none; b=CdexwJNd1qr9wOc8H2HE3qwnyE4pQgFu9Fx3NhvIEBYu/davD93XCJZZpkjbCuve3a4lqxhKs38rixV8Y5+VQNfzBEx9VPDLdgq2LLkKXJv6uwNWrgoYcnK5I4b4UvMxDIM2Xy1AsFk5AFbJodG5r7IIGOh0eJ9i5Ns92KgzevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654685; c=relaxed/simple;
	bh=exNEKF/YQsj45MgYcxCysLvtY5AxPbPvuwWCphmKdNw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Cz1l0UEuUwUrdNbwxyDeTAsurkSb5f/VSOJmGS1G9VZGRkPDjzxDX77NbS84S5ReRLPQM/ZompFgwWeO/P5eZqlc17gu9c8HqjGAREs7/ub3XdR0jn9txw4J6EXIPUb4BaYeeycVA2yNdnMUaMoYr5ixvfH3UzNijFTsTD+RqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36899df83f3so9835795ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654683; x=1712259483;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piHc08A9JwmcxLDecbpa4dXTyxWVp0ll54Au3jlcTbI=;
        b=MqVQpA40rOtt7x6LAVg25hr+U6pIpCQYwpaDaqK43o6a+Ota6/gQCUnh2bExB6zRnq
         Ml6dFBX1GTWQ4ggN8KDkWJTx0LUMz9JKv5UcrVyCOYq93APvp00u4MKSP1//wYsKwFgb
         LTKhBF9qqVhQniOue9uuIAM3aPLx/fXtiTh71E4oMtDlC65vdkTDE8w94+3CSy6nEOg+
         JzY/FzEINvs4nSO7wFFhfPUJIiEeAkofUFm3/yqyVaLDqA/O3DkMZ57HiTwmh+1ahQKV
         YbH6zPNXSkcg6PJIhdXisTJSylvCkNW7FCtWjGQrNxL2n5gaRsKvKPNNnWaJ2imXhFgi
         v3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWgJGfEOE3L4nr/8EXzrMSr8U9XV2QPjIb1RP7NBEEDt5oELZMpLKLLK7GErkD2VlJ+DVN540G2KxijqkRNT/WQLTuIqBk2x/mB1m+9
X-Gm-Message-State: AOJu0YypKpj/j7lWH/Vk3NyJVD75lcA8m+sgk9jssyyVrNp4PRw/GDM7
	czvEqMtmKTnDv6k2hVTGUPrPTn2ea017e42gOqgMhEx8RaHkdSMpAI0xW+YoGS4ttsBg/NR6JQm
	5IPGJ7n/Y2pr9MRK2IMWXidief3zFUS1IoXrvRtOZuyAEYHKjorqgkko=
X-Google-Smtp-Source: AGHT+IH5RiLJDEcBpc+sA+N9L7fZzJyVVM6uKnMu+flXrokcTophdCKA14GJiR2hpFgQ6tZeUNIj+5SaEZFhxZWlQZv47e6e4kdw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:370b:b0:366:bbfb:5866 with SMTP id
 ck11-20020a056e02370b00b00366bbfb5866mr35796ilb.3.1711654682751; Thu, 28 Mar
 2024 12:38:02 -0700 (PDT)
Date: Thu, 28 Mar 2024 12:38:02 -0700
In-Reply-To: <20240328-weitreichend-messbar-55898594245a@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000580ad90614bda9bd@google.com>
Subject: Re: [syzbot] [fs?] WARNING: ODEBUG bug in bdev_super_lock
From: syzbot <syzbot+9c0a93c676799fdf466c@syzkaller.appspotmail.com>
To: brauner@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:


[    9.827096][    T1] ------------[ cut here ]------------
[    9.828078][    T1] refcount_t: decrement hit 0; leaking memory.
[    9.829800][    T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    9.831609][    T1] Modules linked in:
[    9.832246][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-g22650a99821d #0
[    9.833858][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.835637][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    9.836865][    T1] Code: b2 00 00 00 e8 d7 db e9 fc 5b 5d e9 d0 85 e0 0=
6 e8 cb db e9 fc c6 05 8f 84 e8 0a 01 90 48 c7 c7 60 32 1f 8c e8 07 78 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 ab db e9 fc c6 05 6c 84 e8 0a 01 90 48 c7 c7
[    9.840203][    T1] RSP: 0018:ffffc90000066e18 EFLAGS: 00010246
[    9.841605][    T1] RAX: 73a55f6856218c00 RBX: ffff88802101cc6c RCX: fff=
f8880166d0000
[    9.842848][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    9.844053][    T1] RBP: 0000000000000004 R08: ffffffff815800c2 R09: fff=
ffbfff1c396e0
[    9.845853][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000502cdc0
[    9.847348][    T1] R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 000=
0000000000000
[    9.848493][    T1] FS:  0000000000000000(0000) GS:ffff8880b9500000(0000=
) knlGS:0000000000000000
[    9.850332][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.851729][    T1] CR2: 0000000000000000 CR3: 000000000e132000 CR4: 000=
0000000350ef0
[    9.853028][    T1] Call Trace:
[    9.853740][    T1]  <TASK>
[    9.854296][    T1]  ? __warn+0x163/0x4e0
[    9.855289][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.856339][    T1]  ? report_bug+0x2b3/0x500
[    9.857091][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.858009][    T1]  ? handle_bug+0x3e/0x70
[    9.859055][    T1]  ? exc_invalid_op+0x1a/0x50
[    9.859887][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    9.860670][    T1]  ? __warn_printk+0x292/0x360
[    9.861387][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.862309][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    9.863096][    T1]  __free_pages_ok+0xc60/0xd90
[    9.863791][    T1]  make_alloc_exact+0xa3/0xf0
[    9.864692][    T1]  vring_alloc_queue_split+0x20a/0x600
[    9.865642][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    9.866530][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    9.867393][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    9.868249][    T1]  ? virtio_dev_probe+0x993/0xaf0
[    9.869255][    T1]  ? really_probe+0x2ba/0xad0
[    9.869940][    T1]  ? driver_probe_device+0x50/0x430
[    9.870721][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    9.871561][    T1]  ? ret_from_fork+0x4d/0x80
[    9.872295][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.873627][    T1]  vring_create_virtqueue+0xca/0x110
[    9.874772][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.875523][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.876526][    T1]  setup_vq+0xe9/0x2d0
[    9.877345][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.878322][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.879538][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.880573][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.881434][    T1]  vp_setup_vq+0xc1/0x330
[    9.882087][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    9.883422][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.884655][    T1]  ? ioread16+0x2f/0x90
[    9.885417][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.886541][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    9.887569][    T1]  vp_find_vqs+0x4c/0x4e0
[    9.888212][    T1]  virtscsi_init+0x8dd/0xd00
[    9.889003][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.889853][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.890890][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.891703][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    9.892486][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.893269][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.894149][    T1]  ? vp_get+0xfd/0x140
[    9.894862][    T1]  virtscsi_probe+0x3ea/0xf60
[    9.895725][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.896569][    T1]  ? kernfs_add_one+0x156/0x8b0
[    9.897285][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.897970][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.898863][    T1]  ? virtio_features_ok+0x10c/0x270
[    9.899770][    T1]  virtio_dev_probe+0x993/0xaf0
[    9.900613][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.901586][    T1]  really_probe+0x2ba/0xad0
[    9.902274][    T1]  __driver_probe_device+0x1a2/0x390
[    9.903055][    T1]  driver_probe_device+0x50/0x430
[    9.903839][    T1]  __driver_attach+0x45f/0x710
[    9.904538][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.905334][    T1]  bus_for_each_dev+0x23b/0x2b0
[    9.906039][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.906776][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.907541][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    9.908385][    T1]  bus_add_driver+0x347/0x620
[    9.909339][    T1]  driver_register+0x23a/0x320
[    9.910264][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.911222][    T1]  virtio_scsi_init+0x65/0xe0
[    9.911916][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.912708][    T1]  do_one_initcall+0x24a/0x880
[    9.913383][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.914212][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.914975][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    9.915956][    T1]  ? __pfx_parse_args+0x10/0x10
[    9.916686][    T1]  ? do_initcalls+0x1c/0x80
[    9.917333][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.918045][    T1]  ? rcu_is_watching+0x15/0xb0
[    9.918900][    T1]  do_initcall_level+0x157/0x210
[    9.919645][    T1]  do_initcalls+0x3f/0x80
[    9.920262][    T1]  kernel_init_freeable+0x435/0x5d0
[    9.921097][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    9.921899][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.922815][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.923507][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.924275][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.924987][    T1]  kernel_init+0x1d/0x2b0
[    9.925673][    T1]  ret_from_fork+0x4d/0x80
[    9.926323][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.927030][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.927820][    T1]  </TASK>
[    9.928310][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    9.928873][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-g22650a99821d #0
[    9.928873][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.928873][    T1] Call Trace:
[    9.928873][    T1]  <TASK>
[    9.928873][    T1]  dump_stack_lvl+0x241/0x360
[    9.928873][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    9.928873][    T1]  ? __pfx__printk+0x10/0x10
[    9.928873][    T1]  ? _printk+0xd5/0x120
[    9.928873][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.928873][    T1]  ? vscnprintf+0x5d/0x90
[    9.928873][    T1]  panic+0x349/0x860
[    9.928873][    T1]  ? __warn+0x172/0x4e0
[    9.928873][    T1]  ? __pfx_panic+0x10/0x10
[    9.928873][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    9.928873][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    9.928873][    T1]  __warn+0x346/0x4e0
[    9.928873][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.928873][    T1]  report_bug+0x2b3/0x500
[    9.928873][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.928873][    T1]  handle_bug+0x3e/0x70
[    9.928873][    T1]  exc_invalid_op+0x1a/0x50
[    9.928873][    T1]  asm_exc_invalid_op+0x1a/0x20
[    9.928873][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    9.928873][    T1] Code: b2 00 00 00 e8 d7 db e9 fc 5b 5d e9 d0 85 e0 0=
6 e8 cb db e9 fc c6 05 8f 84 e8 0a 01 90 48 c7 c7 60 32 1f 8c e8 07 78 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 ab db e9 fc c6 05 6c 84 e8 0a 01 90 48 c7 c7
[    9.928873][    T1] RSP: 0018:ffffc90000066e18 EFLAGS: 00010246
[    9.928873][    T1] RAX: 73a55f6856218c00 RBX: ffff88802101cc6c RCX: fff=
f8880166d0000
[    9.928873][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    9.928873][    T1] RBP: 0000000000000004 R08: ffffffff815800c2 R09: fff=
ffbfff1c396e0
[    9.928873][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000502cdc0
[    9.928873][    T1] R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 000=
0000000000000
[    9.928873][    T1]  ? __warn_printk+0x292/0x360
[    9.928873][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    9.928873][    T1]  __free_pages_ok+0xc60/0xd90
[    9.928873][    T1]  make_alloc_exact+0xa3/0xf0
[    9.928873][    T1]  vring_alloc_queue_split+0x20a/0x600
[    9.928873][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    9.928873][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    9.928873][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    9.928873][    T1]  ? virtio_dev_probe+0x993/0xaf0
[    9.928873][    T1]  ? really_probe+0x2ba/0xad0
[    9.928873][    T1]  ? driver_probe_device+0x50/0x430
[    9.928873][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    9.928873][    T1]  ? ret_from_fork+0x4d/0x80
[    9.928873][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.928873][    T1]  vring_create_virtqueue+0xca/0x110
[    9.928873][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.928873][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.928873][    T1]  setup_vq+0xe9/0x2d0
[    9.928873][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.928873][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.928873][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.928873][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.928873][    T1]  vp_setup_vq+0xc1/0x330
[    9.928873][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    9.928873][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.928873][    T1]  ? ioread16+0x2f/0x90
[    9.928873][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.928873][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    9.928873][    T1]  vp_find_vqs+0x4c/0x4e0
[    9.928873][    T1]  virtscsi_init+0x8dd/0xd00
[    9.928873][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.928873][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.928873][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.928873][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    9.928873][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.928873][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.928873][    T1]  ? vp_get+0xfd/0x140
[    9.928873][    T1]  virtscsi_probe+0x3ea/0xf60
[    9.928873][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.928873][    T1]  ? kernfs_add_one+0x156/0x8b0
[    9.928873][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.928873][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.928873][    T1]  ? virtio_features_ok+0x10c/0x270
[    9.928873][    T1]  virtio_dev_probe+0x993/0xaf0
[    9.928873][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.928873][    T1]  really_probe+0x2ba/0xad0
[    9.928873][    T1]  __driver_probe_device+0x1a2/0x390
[    9.928873][    T1]  driver_probe_device+0x50/0x430
[    9.928873][    T1]  __driver_attach+0x45f/0x710
[    9.928873][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.928873][    T1]  bus_for_each_dev+0x23b/0x2b0
[    9.928873][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.928873][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.928873][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    9.928873][    T1]  bus_add_driver+0x347/0x620
[    9.928873][    T1]  driver_register+0x23a/0x320
[    9.928873][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.928873][    T1]  virtio_scsi_init+0x65/0xe0
[    9.928873][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.928873][    T1]  do_one_initcall+0x24a/0x880
[    9.928873][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.928873][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.928873][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    9.928873][    T1]  ? __pfx_parse_args+0x10/0x10
[    9.928873][    T1]  ? do_initcalls+0x1c/0x80
[    9.928873][    T1]  ? srso_return_thunk+0x5/0x5f
[    9.928873][    T1]  ? rcu_is_watching+0x15/0xb0
[    9.928873][    T1]  do_initcall_level+0x157/0x210
[    9.928873][    T1]  do_initcalls+0x3f/0x80
[    9.928873][    T1]  kernel_init_freeable+0x435/0x5d0
[    9.928873][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    9.928873][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.928873][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.928873][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.928873][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.928873][    T1]  kernel_init+0x1d/0x2b0
[    9.928873][    T1]  ret_from_fork+0x4d/0x80
[    9.928873][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.928873][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.928873][    T1]  </TASK>
[    9.928873][    T1] Kernel Offset: disabled
[    9.928873][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build4004819836=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D13bf0c95180000


Tested on:

commit:         22650a99 fs,block: yield devices early
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git=
 vfs.fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D151a91b67a26126=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9c0a93c676799fdf4=
66c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

