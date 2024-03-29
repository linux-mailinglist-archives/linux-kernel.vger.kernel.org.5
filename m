Return-Path: <linux-kernel+bounces-125164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA14892165
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3631287DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3227E772;
	Fri, 29 Mar 2024 16:17:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D0524A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729025; cv=none; b=GfVsW0N6pKzDdZ3J2SbCnPzhpbBYnsLKV93yCOrmtaFywNdS66uNOecFdN2v2GaXFFA4L1LJGE6IPf6jj80N1KaEPAXDHpvY/LCoeK139xHfSv4n2tIisUsgFWgGTICbtAAb0rnwmnhlH55VxOGFnj5VSBdbTiO/JHKP3jmBT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729025; c=relaxed/simple;
	bh=BMktWT+OwSpB3NGUdZaVNwnuO0jtwXaDENuyDPylXv4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UgszJwVv5itQi7zTIkXSWcB3l7qI8TOxa/+yxM2t5KEod3fi+0vHhDQ4UIoKtHjjWgRYJdKpQk/vbyAgc9z65KIQ158BEGQGhz0DJlaUEH2dOR+wlPOnCeSFYLlViz/lzGenRBb0WlYMcupwLzPXwGeJ7sLsOm0Tot1kNxk5LxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-368c8628504so9566315ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729022; x=1712333822;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWgQAX8rwUPY1UKFt/KwmGA/ET1QSP5OxlWCvz+D27k=;
        b=aaviRMJyCfCuGC18TlzFvntryGV3t8euH/S3Y0wmEjr6OofGuw3kWAlcNm56R5M2wV
         DEEdK+o0z+gE9Qq1Y8lQ4SFHmgyVmrAwnVJymdy9DEgz59buRCn8lIYMb2ZE+bGeReGL
         okiWWpiRJ4sU4FCZjyEZITq2GWPqld1nli2DojuWwKjxJLrPFmNA1sUtsg8ZQ/KaKHPM
         6W252niM2GL0sbAO+JmL5ruN2W/3+4N9y+rBJL18hYZ12+9QSz8RROCCF0urlbUFfsZ1
         bUOZJApUVGir/dRa5nYLxeTEkQz1q+pV7SVwZ+BX7rEl/e0QqbNaqxVJbvhCvTL3USK6
         R+kg==
X-Forwarded-Encrypted: i=1; AJvYcCVanit5bzl29JD8s3S+QSSQ8W8N6JLH7q0t2GItC5qjW2DYyK0LOOXX3x310CcMAHOPeLsJM6c/fZW5/wShit0CNc0MxVlf6Y3KatNx
X-Gm-Message-State: AOJu0Yx6tCnVZy6HBR4hdisquaoyaZ4Zswpy94DM8pwFCJgF6agY2B9x
	NVKtYp13FDB6fA4ZscdoQhVDYRA9KoiBnINcPRJ9d0gffOr2FUOJNt3Lw/rjvag9doDOnFz9jLk
	9zGdKiwqHM2Q4XbX2BJMaje3qF4s2ikYN1m8pXku+rOBv1dzLsCB5OdU=
X-Google-Smtp-Source: AGHT+IE7MIbxOn/qpEJNkYT6WffpoI3i33wVN6tArG8dhJlmgYXaHF1CoF3cmLnCTRUaPYQSR1q49mNZUfJemulUV8DRT8laTHfI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:368:b308:1d41 with SMTP id
 k10-20020a056e021a8a00b00368b3081d41mr74686ilv.4.1711729022684; Fri, 29 Mar
 2024 09:17:02 -0700 (PDT)
Date: Fri, 29 Mar 2024 09:17:02 -0700
In-Reply-To: <20240328230738.2910-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000595fc40614cef891@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
From: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

rd
[    8.126582][    T1] usbcore: registered new interface driver dln2
[    8.128975][    T1] usbcore: registered new interface driver pn533_usb
[    8.136035][    T1] nfcsim 0.2 initialized
[    8.137231][    T1] usbcore: registered new interface driver port100
[    8.138748][    T1] usbcore: registered new interface driver nfcmrvl
[    8.145859][    T1] Loading iSCSI transport class v2.0-870.
[    8.163499][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    8.175560][    T1] ------------[ cut here ]------------
[    8.176754][    T1] refcount_t: decrement hit 0; leaking memory.
[    8.178277][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    8.179920][    T1] Modules linked in:
[    8.180674][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-g317c7bc0ef03-dirty #0
[    8.183676][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.188610][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.190118][    T1] Code: b2 00 00 00 e8 b7 d1 e9 fc 5b 5d c3 cc cc cc c=
c e8 ab d1 e9 fc c6 05 6e 76 e8 0a 01 90 48 c7 c7 e0 33 1f 8c e8 e7 6d ac f=
c 90 <0f> 0b 90 90 eb d9 e8 8b d1 e9 fc c6 05 4b 76 e8 0a 01 90 48 c7 c7
[    8.193646][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.195167][    T1] RAX: f6afc450a77aa400 RBX: ffff8880207ba75c RCX: fff=
f8880166d0000
[    8.197227][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000000
[    8.198422][    T1] RBP: 0000000000000004 R08: ffffffff815800c2 R09: fff=
ffbfff1c396e0
[    8.200207][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000501edc0
[    8.201595][    T1] R13: ffffea000501edc8 R14: 1ffffd4000a03db9 R15: 000=
0000000000000
[    8.204095][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    8.206467][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.207845][    T1] CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 000=
00000003506f0
[    8.209685][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.211033][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.212686][    T1] Call Trace:
[    8.213195][    T1]  <TASK>
[    8.213986][    T1]  ? __warn+0x163/0x4e0
[    8.215506][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.216913][    T1]  ? report_bug+0x2b3/0x500
[    8.218714][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.220709][    T1]  ? handle_bug+0x3e/0x70
[    8.222091][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.223846][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.225196][    T1]  ? __warn_printk+0x292/0x360
[    8.226085][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.227407][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.228175][    T1]  __free_pages_ok+0xc60/0xd90
[    8.229175][    T1]  make_alloc_exact+0xa3/0xf0
[    8.230474][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.231715][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.233617][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.234631][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.236180][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.236983][    T1]  ? really_probe+0x2b8/0xad0
[    8.237853][    T1]  ? driver_probe_device+0x50/0x430
[    8.238614][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.239928][    T1]  ? ret_from_fork+0x4b/0x80
[    8.242045][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.245917][    T1]  vring_create_virtqueue+0xca/0x110
[    8.247389][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.248236][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.250654][    T1]  setup_vq+0xe9/0x2d0
[    8.252034][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.254018][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.256278][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.258795][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.260398][    T1]  vp_setup_vq+0xbf/0x330
[    8.261387][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.262783][    T1]  ? ioread16+0x2f/0x90
[    8.265102][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.267083][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.268386][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.270033][    T1]  virtscsi_init+0x8db/0xd00
[    8.272136][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.273670][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.275138][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.276322][    T1]  ? vp_get+0xfd/0x140
[    8.277792][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.278863][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.280218][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.282404][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.284631][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.286348][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.287773][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.288905][    T1]  really_probe+0x2b8/0xad0
[    8.290078][    T1]  __driver_probe_device+0x1a2/0x390
[    8.292149][    T1]  driver_probe_device+0x50/0x430
[    8.293916][    T1]  __driver_attach+0x45f/0x710
[    8.295546][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.296706][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.297510][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.298632][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.299941][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.301483][    T1]  bus_add_driver+0x347/0x620
[    8.302606][    T1]  driver_register+0x23a/0x320
[    8.304274][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.305978][    T1]  virtio_scsi_init+0x65/0xe0
[    8.306774][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.307813][    T1]  do_one_initcall+0x248/0x880
[    8.309150][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.310617][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.313354][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.315007][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.317331][    T1]  ? do_initcalls+0x1c/0x80
[    8.318887][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.320094][    T1]  do_initcall_level+0x157/0x210
[    8.322194][    T1]  do_initcalls+0x3f/0x80
[    8.323354][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.324941][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.326006][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.327488][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.329100][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.330857][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.332703][    T1]  kernel_init+0x1d/0x2b0
[    8.334765][    T1]  ret_from_fork+0x4b/0x80
[    8.335714][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.336933][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.337933][    T1]  </TASK>
[    8.338682][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.341330][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-g317c7bc0ef03-dirty #0
[    8.344143][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.344784][    T1] Call Trace:
[    8.344784][    T1]  <TASK>
[    8.344784][    T1]  dump_stack_lvl+0x241/0x360
[    8.344784][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.344784][    T1]  ? __pfx__printk+0x10/0x10
[    8.344784][    T1]  ? _printk+0xd5/0x120
[    8.344784][    T1]  ? vscnprintf+0x5d/0x90
[    8.354884][    T1]  panic+0x349/0x860
[    8.354884][    T1]  ? __warn+0x172/0x4e0
[    8.354884][    T1]  ? __pfx_panic+0x10/0x10
[    8.354884][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.354884][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.354884][    T1]  __warn+0x346/0x4e0
[    8.354884][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.354884][    T1]  report_bug+0x2b3/0x500
[    8.364918][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.364918][    T1]  handle_bug+0x3e/0x70
[    8.364918][    T1]  exc_invalid_op+0x1a/0x50
[    8.364918][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.364918][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.364918][    T1] Code: b2 00 00 00 e8 b7 d1 e9 fc 5b 5d c3 cc cc cc c=
c e8 ab d1 e9 fc c6 05 6e 76 e8 0a 01 90 48 c7 c7 e0 33 1f 8c e8 e7 6d ac f=
c 90 <0f> 0b 90 90 eb d9 e8 8b d1 e9 fc c6 05 4b 76 e8 0a 01 90 48 c7 c7
[    8.374911][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.374911][    T1] RAX: f6afc450a77aa400 RBX: ffff8880207ba75c RCX: fff=
f8880166d0000
[    8.374911][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000000
[    8.374911][    T1] RBP: 0000000000000004 R08: ffffffff815800c2 R09: fff=
ffbfff1c396e0
[    8.384883][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000501edc0
[    8.384883][    T1] R13: ffffea000501edc8 R14: 1ffffd4000a03db9 R15: 000=
0000000000000
[    8.384883][    T1]  ? __warn_printk+0x292/0x360
[    8.384883][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.384883][    T1]  __free_pages_ok+0xc60/0xd90
[    8.394940][    T1]  make_alloc_exact+0xa3/0xf0
[    8.394940][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.394940][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.394940][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.394940][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.404787][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.404787][    T1]  ? really_probe+0x2b8/0xad0
[    8.404787][    T1]  ? driver_probe_device+0x50/0x430
[    8.404787][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.404787][    T1]  ? ret_from_fork+0x4b/0x80
[    8.404787][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.404787][    T1]  vring_create_virtqueue+0xca/0x110
[    8.414898][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.414898][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.414898][    T1]  setup_vq+0xe9/0x2d0
[    8.414898][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.414898][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.414898][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.414898][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.424822][    T1]  vp_setup_vq+0xbf/0x330
[    8.424822][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.424822][    T1]  ? ioread16+0x2f/0x90
[    8.424822][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.424822][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.424822][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.424822][    T1]  virtscsi_init+0x8db/0xd00
[    8.434924][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.434924][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.434924][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.434924][    T1]  ? vp_get+0xfd/0x140
[    8.434924][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.434924][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.434924][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.444785][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.444785][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.444785][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.444785][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.454872][    T1]  really_probe+0x2b8/0xad0
[    8.454872][    T1]  __driver_probe_device+0x1a2/0x390
[    8.454872][    T1]  driver_probe_device+0x50/0x430
[    8.454872][    T1]  __driver_attach+0x45f/0x710
[    8.454872][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.454872][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.454872][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.464890][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.464890][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.464890][    T1]  bus_add_driver+0x347/0x620
[    8.464890][    T1]  driver_register+0x23a/0x320
[    8.464890][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.464890][    T1]  virtio_scsi_init+0x65/0xe0
[    8.464890][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.464890][    T1]  do_one_initcall+0x248/0x880
[    8.474920][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.474920][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.474920][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.474920][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.474920][    T1]  ? do_initcalls+0x1c/0x80
[    8.474920][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.474920][    T1]  do_initcall_level+0x157/0x210
[    8.474920][    T1]  do_initcalls+0x3f/0x80
[    8.474920][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.474920][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.484767][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.484767][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.484767][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.484767][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.484767][    T1]  kernel_init+0x1d/0x2b0
[    8.484767][    T1]  ret_from_fork+0x4b/0x80
[    8.484767][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.484767][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.484767][    T1]  </TASK>
[    8.484767][    T1] Kernel Offset: disabled
[    8.484767][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3987916201=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D17e67d0d180000


Tested on:

commit:         317c7bc0 Merge tag 'mmc-v6.9-rc1' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7b667bc37450fdc=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1fa663a2100308ab6=
eab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D144ea7451800=
00


