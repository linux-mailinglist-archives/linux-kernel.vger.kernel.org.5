Return-Path: <linux-kernel+bounces-145222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95B8A510E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39EE1C2088B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55C7691F;
	Mon, 15 Apr 2024 13:07:10 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0FE77623
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186429; cv=none; b=XqDr3blO1n7gec0fCCbLPGLiJ2kTB8ibj8RrcgTWD0EtWDyXZKP+OSm8OMsm5rWA6HAygfPd4IAYgmjTGOYdUJlG17I7fPEX6CxBxsS5ImewB0Ds+YFsuzLsddMRVD7RxFwed7EHO5CCQNHXDTRCAVW+82QLUjf6zeAXAWfZ7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186429; c=relaxed/simple;
	bh=ijkbD89ZG4W2rSGkfOFs+CQCwbIqvmCMvRyCc0dkfDo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hamZz2No08CnQREFWnVqEtyXX1DmWs8E3ptLdHXOXIU5HNX3xdz0ZUzNwW12PeeaH4OwZAfzUS5/F4y2sAsoI3u+yAQd9X33Pgi3cqB8s5Egfv4XCOLWR1pvkpSYK8K8mI0/+MNpOVak1cPso2h8UIIFEnA8wKqYIF1m4mbZTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a1a2f396aso32554755ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713186424; x=1713791224;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ast5JwL1W7Ounlak7DiRBSHLDkausJYlwCBRxNoub7M=;
        b=ergl9bdZSyVrFsS8p2N+oB63drCu1S7WiPA0zEMiFpE924daXHLQlayEFyL7u976NG
         pjG32Gonm349CcGRphGk0hmRvLM6nmq1s0dLB1m7igM6GauD32wDFciDY/mqUUloo/ix
         t8k0COPJ75Ksm/oBkAJLFY0RebKFX3W83vqPchSF2A2rzlxf9ZAZwi40hFkfJiNfywZK
         StJRDiEXyFjOBCK+dg4XYK4VvLQq92zCVm9fihfDb1yGDvMW9SeCT2kWV7RHEwB65DvJ
         /o20oVQhoZ/HSnuekaJNpRMF4w1NdkqpyeNWsYSLu1jta++NF53IVYM3xvyxWd9cXfqY
         pkzA==
X-Gm-Message-State: AOJu0YyTT8/v4GcaNYWqJaduCEUErDruXHWmAXP94rjuS2QmYQCeJVZV
	SQpMAewl9r9akC1dRcAajdnuLCYNRLg91T5EXS9wEollnUEPxfNYLzIyMmmbOSLN6VvRrhGJoWB
	18u+sK5HaTgSD3jOgdKs54pEtmROJcIBjsmpueQxuJRJ5BIQRem+rcwY=
X-Google-Smtp-Source: AGHT+IHwVN8074rl4iNlQaN5oTrsdFUPkUA/EKJOuXF7gsYVOiVWrn2+KhHpRisfI8nr02C3tCxAPpCIUShEnke4VWabQc87pwdV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a49:b0:36b:1bc:adc0 with SMTP id
 u9-20020a056e021a4900b0036b01bcadc0mr424570ilv.4.1713186424141; Mon, 15 Apr
 2024 06:07:04 -0700 (PDT)
Date: Mon, 15 Apr 2024 06:07:04 -0700
In-Reply-To: <CA+LQOUczHtC_3cxUFbkcpWYwLCr62k229ym9B3NL6RS6NQHdhw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ece180616224c96@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_set_handle
From: syzbot <syzbot+d6282a21a27259b5f7e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mukattreyee@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

[    T1] usbcore: registered new interface driver rtsx_usb
[    9.001776][    T1] usbcore: registered new interface driver viperboard
[    9.003717][    T1] usbcore: registered new interface driver dln2
[    9.005598][    T1] usbcore: registered new interface driver pn533_usb
[    9.013420][    T1] nfcsim 0.2 initialized
[    9.014891][    T1] usbcore: registered new interface driver port100
[    9.017076][    T1] usbcore: registered new interface driver nfcmrvl
[    9.024386][    T1] Loading iSCSI transport class v2.0-870.
[    9.045243][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    9.054420][    T1] ------------[ cut here ]------------
[    9.055600][    T1] refcount_t: decrement hit 0; leaking memory.
[    9.058135][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    9.059662][    T1] Modules linked in:
[    9.060283][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-g0bbac3facb5d #0
[    9.061791][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.064097][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    9.065736][    T1] Code: b2 00 00 00 e8 17 b7 e7 fc 5b 5d c3 cc cc cc c=
c e8 0b b7 e7 fc c6 05 da 2a e6 0a 01 90 48 c7 c7 40 3b 1f 8c e8 67 51 aa f=
c 90 <0f> 0b 90 90 eb d9 e8 eb b6 e7 fc c6 05 b7 2a e6 0a 01 90 48 c7 c7
[    9.070788][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    9.072245][    T1] RAX: 351085e3228a4100 RBX: ffff888140b8782c RCX: fff=
f8880166d0000
[    9.073867][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000000
[    9.075497][    T1] RBP: 0000000000000004 R08: ffffffff815880a2 R09: fff=
ffbfff1c39b48
[    9.077798][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea000502fdc0
[    9.079999][    T1] R13: ffffea000502fdc8 R14: 1ffffd4000a05fb9 R15: 000=
0000000000000
[    9.081851][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    9.083677][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.084919][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    9.087312][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    9.089274][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    9.091115][    T1] Call Trace:
[    9.091939][    T1]  <TASK>
[    9.092755][    T1]  ? __warn+0x163/0x4e0
[    9.093619][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.095294][    T1]  ? report_bug+0x2b3/0x500
[    9.096601][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.097921][    T1]  ? handle_bug+0x3e/0x70
[    9.098837][    T1]  ? exc_invalid_op+0x1a/0x50
[    9.099638][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    9.100572][    T1]  ? __warn_printk+0x292/0x360
[    9.101393][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.102618][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    9.103558][    T1]  __free_pages_ok+0xc60/0xd90
[    9.104346][    T1]  make_alloc_exact+0xa3/0xf0
[    9.105584][    T1]  vring_alloc_queue_split+0x20a/0x600
[    9.107299][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    9.108282][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    9.109083][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    9.109892][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    9.111059][    T1]  ? really_probe+0x2b8/0xad0
[    9.111905][    T1]  ? driver_probe_device+0x50/0x430
[    9.112883][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    9.114048][    T1]  ? ret_from_fork+0x4b/0x80
[    9.115005][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.116583][    T1]  vring_create_virtqueue+0xca/0x110
[    9.117692][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.118573][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.119440][    T1]  setup_vq+0xe9/0x2d0
[    9.120171][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.121026][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.122122][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.123154][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.124442][    T1]  vp_setup_vq+0xbf/0x330
[    9.125185][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    9.126354][    T1]  ? ioread16+0x2f/0x90
[    9.127130][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.128255][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    9.129303][    T1]  vp_find_vqs+0x4c/0x4e0
[    9.130202][    T1]  virtscsi_init+0x8db/0xd00
[    9.131552][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.132275][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.133141][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    9.133889][    T1]  ? vp_get+0xfd/0x140
[    9.134477][    T1]  virtscsi_probe+0x3ea/0xf60
[    9.135321][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.136249][    T1]  ? kernfs_add_one+0x156/0x8b0
[    9.136999][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    9.137816][    T1]  ? virtio_features_ok+0x10c/0x270
[    9.138562][    T1]  virtio_dev_probe+0x991/0xaf0
[    9.139279][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.140212][    T1]  really_probe+0x2b8/0xad0
[    9.141018][    T1]  __driver_probe_device+0x1a2/0x390
[    9.141833][    T1]  driver_probe_device+0x50/0x430
[    9.142652][    T1]  __driver_attach+0x45f/0x710
[    9.143347][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.144150][    T1]  bus_for_each_dev+0x239/0x2b0
[    9.144879][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.145689][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.146652][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    9.147529][    T1]  bus_add_driver+0x347/0x620
[    9.148216][    T1]  driver_register+0x23a/0x320
[    9.149041][    T1]  virtio_scsi_init+0x69/0xe0
[    9.149787][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.150636][    T1]  do_one_initcall+0x248/0x880
[    9.151316][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.152299][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.153225][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.154272][    T1]  ? __pfx_parse_args+0x10/0x10
[    9.155071][    T1]  ? do_initcalls+0x1c/0x80
[    9.155945][    T1]  ? rcu_is_watching+0x15/0xb0
[    9.156723][    T1]  do_initcall_level+0x157/0x210
[    9.157685][    T1]  do_initcalls+0x3f/0x80
[    9.158363][    T1]  kernel_init_freeable+0x435/0x5d0
[    9.159252][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    9.160093][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.161282][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.162184][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.162958][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.163681][    T1]  kernel_init+0x1d/0x2b0
[    9.164282][    T1]  ret_from_fork+0x4b/0x80
[    9.164897][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.165604][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.166304][    T1]  </TASK>
[    9.166746][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    9.167732][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-g0bbac3facb5d #0
[    9.168948][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.170299][    T1] Call Trace:
[    9.170755][    T1]  <TASK>
[    9.171219][    T1]  dump_stack_lvl+0x241/0x360
[    9.171943][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    9.172804][    T1]  ? __pfx__printk+0x10/0x10
[    9.173454][    T1]  ? _printk+0xd5/0x120
[    9.175261][    T1]  ? vscnprintf+0x5d/0x90
[    9.176277][    T1]  panic+0x349/0x860
[    9.176277][    T1]  ? __warn+0x172/0x4e0
[    9.176277][    T1]  ? __pfx_panic+0x10/0x10
[    9.176277][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    9.176277][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    9.176277][    T1]  __warn+0x346/0x4e0
[    9.176277][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.176277][    T1]  report_bug+0x2b3/0x500
[    9.176277][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    9.176277][    T1]  handle_bug+0x3e/0x70
[    9.176277][    T1]  exc_invalid_op+0x1a/0x50
[    9.176277][    T1]  asm_exc_invalid_op+0x1a/0x20
[    9.176277][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    9.176277][    T1] Code: b2 00 00 00 e8 17 b7 e7 fc 5b 5d c3 cc cc cc c=
c e8 0b b7 e7 fc c6 05 da 2a e6 0a 01 90 48 c7 c7 40 3b 1f 8c e8 67 51 aa f=
c 90 <0f> 0b 90 90 eb d9 e8 eb b6 e7 fc c6 05 b7 2a e6 0a 01 90 48 c7 c7
[    9.176277][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    9.176277][    T1] RAX: 351085e3228a4100 RBX: ffff888140b8782c RCX: fff=
f8880166d0000
[    9.176277][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000000
[    9.176277][    T1] RBP: 0000000000000004 R08: ffffffff815880a2 R09: fff=
ffbfff1c39b48
[    9.176277][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea000502fdc0
[    9.176277][    T1] R13: ffffea000502fdc8 R14: 1ffffd4000a05fb9 R15: 000=
0000000000000
[    9.176277][    T1]  ? __warn_printk+0x292/0x360
[    9.176277][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    9.176277][    T1]  __free_pages_ok+0xc60/0xd90
[    9.176277][    T1]  make_alloc_exact+0xa3/0xf0
[    9.176277][    T1]  vring_alloc_queue_split+0x20a/0x600
[    9.176277][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    9.176277][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    9.176277][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    9.176277][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    9.176277][    T1]  ? really_probe+0x2b8/0xad0
[    9.176277][    T1]  ? driver_probe_device+0x50/0x430
[    9.176277][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    9.176277][    T1]  ? ret_from_fork+0x4b/0x80
[    9.176277][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.176277][    T1]  vring_create_virtqueue+0xca/0x110
[    9.176277][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.176277][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.176277][    T1]  setup_vq+0xe9/0x2d0
[    9.176277][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.176277][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.176277][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.176277][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.176277][    T1]  vp_setup_vq+0xbf/0x330
[    9.176277][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    9.226166][    T1]  ? ioread16+0x2f/0x90
[    9.226237][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.226237][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    9.226237][    T1]  vp_find_vqs+0x4c/0x4e0
[    9.226237][    T1]  virtscsi_init+0x8db/0xd00
[    9.226237][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.226237][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.226237][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    9.226237][    T1]  ? vp_get+0xfd/0x140
[    9.226237][    T1]  virtscsi_probe+0x3ea/0xf60
[    9.226237][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.226237][    T1]  ? kernfs_add_one+0x156/0x8b0
[    9.226237][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    9.226237][    T1]  ? virtio_features_ok+0x10c/0x270
[    9.226237][    T1]  virtio_dev_probe+0x991/0xaf0
[    9.226237][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.226237][    T1]  really_probe+0x2b8/0xad0
[    9.226237][    T1]  __driver_probe_device+0x1a2/0x390
[    9.226237][    T1]  driver_probe_device+0x50/0x430
[    9.226237][    T1]  __driver_attach+0x45f/0x710
[    9.226237][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.226237][    T1]  bus_for_each_dev+0x239/0x2b0
[    9.226237][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.226237][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.226237][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    9.226237][    T1]  bus_add_driver+0x347/0x620
[    9.226237][    T1]  driver_register+0x23a/0x320
[    9.226237][    T1]  virtio_scsi_init+0x69/0xe0
[    9.226237][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.226237][    T1]  do_one_initcall+0x248/0x880
[    9.226237][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.226237][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.226237][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.226237][    T1]  ? __pfx_parse_args+0x10/0x10
[    9.226237][    T1]  ? do_initcalls+0x1c/0x80
[    9.226237][    T1]  ? rcu_is_watching+0x15/0xb0
[    9.226237][    T1]  do_initcall_level+0x157/0x210
[    9.226237][    T1]  do_initcalls+0x3f/0x80
[    9.226237][    T1]  kernel_init_freeable+0x435/0x5d0
[    9.226237][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    9.226237][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.226237][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.226237][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.226237][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.276351][    T1]  kernel_init+0x1d/0x2b0
[    9.276351][    T1]  ret_from_fork+0x4b/0x80
[    9.276351][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.276351][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.276351][    T1]  </TASK>
[    9.276351][    T1] Kernel Offset: disabled
[    9.276351][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3485891342=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 56086b24b
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
/syzkaller/prog.GitRevision=3D56086b24bdfd822d3b227edb3064db443cd8c971 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-083312'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D56086b24bdfd822d3b227edb3064db443cd8c971 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-083312'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D56086b24bdfd822d3b227edb3064db443cd8c971 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-083312'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"56086b24bdfd822d3b227edb3064db443c=
d8c971\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D115a9fcb180000


Tested on:

commit:         0bbac3fa Linux 6.9-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc6e826cf3c9c6ff=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd6282a21a27259b5f=
7e7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

