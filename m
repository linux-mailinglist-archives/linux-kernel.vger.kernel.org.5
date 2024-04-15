Return-Path: <linux-kernel+bounces-145407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A7C8A55D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6674F282CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213697602A;
	Mon, 15 Apr 2024 15:00:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F971B4F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193208; cv=none; b=gP913sjURTGHVoLjNSojYanhL0oIADD6UnYqDAVp13bHR55xW+vQMpCxELLSfzUKXDDskW0YZTPeFwDxpa826cZ0M+ulIUqUoRvrAgnA8/l9ex7QIOyur+eOSZBnPC0r8bsO79gfxLiWF8pXKnizao2m2sHhm2aOv+9L2mWfCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193208; c=relaxed/simple;
	bh=w5M2W6cKF5tJ1DQc+jA8paic3+AIiFsr7hEC+m3rviY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iOHJy6WGyzOMY0QdkQLv64gyWM3Kkl7j4myNenuQ9ScS0esLe3wPaidXeXtBXeG4ym9lg3lJh12xts5Vc/Y0WyfzjF1Smhgjdgz7i92idQ+ETke3BnqHyaTxGdjoP90MBXV2qUOQauWHyjJnGp7IEiWx30atNMt20eL9jjQWIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc764c885bso404346439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193205; x=1713798005;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfmAvCiFzxC+XHzeiFzWvjQc+jIkelkTR/tOGmpDB+8=;
        b=DIzDsIRjHE6HeDN8egFt0L2e75SVj5xDuHjWIexfUVwMGDGmTzjo49gyb1FnxOguk9
         pxvct17lIyNs4BXA5VhtgiAoTAmQQDL2I/HARHfRmCiuwLUewnwQiF83EAP5nQQZib6t
         bbCN+4TjQ0BybPEhcMm6EvWMqjUr3G0+CUZ0dsvGGeOYjAfbaxLw0K+5bDtM1f/NQqXW
         shf6/pcUCglnG4E1VoM4pZ+YLwGVyXL5+MqQ1L+Aunoj+vyspsBMus5LVW5UkMdhpTf8
         LB2H5l7trT/T6iSBtSNg9OzHzVx/5FURd3bwFiFl7EOYRYkHlMR8oPmD/HFKV8SsH8uk
         YtqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSM8d4yV2jjulUMh+Po9BsAZ14EnoYpBgLjsHLj5OEql1Fpdvw5nbDraaNeZjh6QRVxXqOAPa61yGyrjlyof50fSq1qoImfVIv6KAs
X-Gm-Message-State: AOJu0YxC2OU4IA3s1mu1+wNothMTvoDkGynceUyDFfLv2Cq0pP3llPlm
	CigI3SNfZK6uAm/TDZjQ6OCsDJhZ+2YKT3puMoCTbbsc89+t2B9URHpP+E3MmmFUFsd0emZlpax
	MJFtu7NV9IXNpMBEpnofZw4k3xy5MnuU782aijA53GZCl8RKFKoIv5yc=
X-Google-Smtp-Source: AGHT+IFu/R6bPOjqPlYnQlPzOM7qwXa4pBX0TQwd4j0sVN8Ilrjz2EmkDmjklFvYBBZbQKpXvgoTHnIQis/i13m0icRGWzmJiw1c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411c:b0:482:f1bb:d927 with SMTP id
 ay28-20020a056638411c00b00482f1bbd927mr318415jab.3.1713193204938; Mon, 15 Apr
 2024 08:00:04 -0700 (PDT)
Date: Mon, 15 Apr 2024 08:00:04 -0700
In-Reply-To: <20240415132828.149954-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000698d5c061623e0d1@google.com>
Subject: Re: [syzbot] [nilfs?] UBSAN: array-index-out-of-bounds in nilfs_add_link
From: syzbot <syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

[    8.046646][    T1] usbcore: registered new interface driver pn533_usb
[    8.053398][    T1] nfcsim 0.2 initialized
[    8.054384][    T1] usbcore: registered new interface driver port100
[    8.056070][    T1] usbcore: registered new interface driver nfcmrvl
[    8.063127][    T1] Loading iSCSI transport class v2.0-870.
[    8.083033][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    8.093514][    T1] ------------[ cut here ]------------
[    8.097392][    T1] refcount_t: decrement hit 0; leaking memory.
[    8.098749][    T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    8.100089][    T1] Modules linked in:
[    8.100981][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-dirty #0
[    8.102964][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.104809][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.105854][    T1] Code: b2 00 00 00 e8 87 70 f0 fc 5b 5d c3 cc cc cc c=
c e8 7b 70 f0 fc c6 05 ac bf ed 0a 01 90 48 c7 c7 80 66 1e 8c e8 e7 0a b3 f=
c 90 <0f> 0b 90 90 eb d9 e8 5b 70 f0 fc c6 05 89 bf ed 0a 01 90 48 c7 c7
[    8.109304][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.110372][    T1] RAX: a5557a779647f700 RBX: ffff8881432f33fc RCX: fff=
f888016ac0000
[    8.111482][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.112881][    T1] RBP: 0000000000000004 R08: ffffffff81587fc2 R09: fff=
ffbfff1c39b48
[    8.114169][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea000503cdc0
[    8.115576][    T1] R13: ffffea000503cdc8 R14: 1ffffd4000a079b9 R15: 000=
0000000000000
[    8.116934][    T1] FS:  0000000000000000(0000) GS:ffff8880b9500000(0000=
) knlGS:0000000000000000
[    8.118632][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.120448][    T1] CR2: 0000000000000000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    8.121952][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.125239][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.128444][    T1] Call Trace:
[    8.128999][    T1]  <TASK>
[    8.129476][    T1]  ? __warn+0x163/0x4e0
[    8.130277][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.131293][    T1]  ? report_bug+0x2b3/0x500
[    8.132024][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.133864][    T1]  ? handle_bug+0x3e/0x70
[    8.134800][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.135746][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.136660][    T1]  ? __warn_printk+0x292/0x360
[    8.138782][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.139747][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.141576][    T1]  __free_pages_ok+0xc54/0xd80
[    8.142662][    T1]  make_alloc_exact+0xa3/0xf0
[    8.143619][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.144668][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.145585][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.146361][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.147253][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.148035][    T1]  ? really_probe+0x2b8/0xad0
[    8.148878][    T1]  ? driver_probe_device+0x50/0x430
[    8.149903][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.150905][    T1]  ? ret_from_fork+0x4b/0x80
[    8.152921][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.154006][    T1]  vring_create_virtqueue+0xca/0x110
[    8.155477][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.156849][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.158255][    T1]  setup_vq+0xe9/0x2d0
[    8.158966][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.160058][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.161161][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.162896][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.163930][    T1]  vp_setup_vq+0xbf/0x330
[    8.164941][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.166253][    T1]  ? ioread16+0x2f/0x90
[    8.167168][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.168459][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.169516][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.170429][    T1]  virtscsi_init+0x8db/0xd00
[    8.171852][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.172801][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.176106][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.177026][    T1]  ? vp_get+0xfd/0x140
[    8.177595][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.178351][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.179274][    T1]  ? vp_get_shm_region+0x51d/0x8b0
[    8.180369][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    8.181850][    T1]  ? vp_set_status+0x1a/0x40
[    8.182628][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.183880][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.184839][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.185666][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.186643][    T1]  really_probe+0x2b8/0xad0
[    8.187658][    T1]  __driver_probe_device+0x1a2/0x390
[    8.188847][    T1]  driver_probe_device+0x50/0x430
[    8.189648][    T1]  __driver_attach+0x45f/0x710
[    8.190566][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.191463][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.192162][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.193282][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.194135][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.195052][    T1]  bus_add_driver+0x347/0x620
[    8.195904][    T1]  driver_register+0x23a/0x320
[    8.196676][    T1]  virtio_scsi_init+0x69/0xe0
[    8.197688][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.198566][    T1]  do_one_initcall+0x248/0x880
[    8.199453][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.200558][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.201915][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.202821][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.203915][    T1]  ? do_initcalls+0x1c/0x80
[    8.204956][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.205785][    T1]  do_initcall_level+0x157/0x210
[    8.206580][    T1]  do_initcalls+0x3f/0x80
[    8.207402][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.208171][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.209120][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.210016][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.211607][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.212570][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.213608][    T1]  kernel_init+0x1d/0x2b0
[    8.214363][    T1]  ret_from_fork+0x4b/0x80
[    8.215262][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.216195][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.216904][    T1]  </TASK>
[    8.217906][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.219113][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-dirty #0
[    8.220551][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.222223][    T1] Call Trace:
[    8.222793][    T1]  <TASK>
[    8.223243][    T1]  dump_stack_lvl+0x241/0x360
[    8.224079][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.224927][    T1]  ? __pfx__printk+0x10/0x10
[    8.225243][    T1]  ? _printk+0xd5/0x120
[    8.225243][    T1]  ? vscnprintf+0x5d/0x90
[    8.225243][    T1]  panic+0x349/0x860
[    8.225243][    T1]  ? __warn+0x172/0x4e0
[    8.225243][    T1]  ? __pfx_panic+0x10/0x10
[    8.225243][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.225243][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.225243][    T1]  __warn+0x346/0x4e0
[    8.225243][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.225243][    T1]  report_bug+0x2b3/0x500
[    8.225243][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.225243][    T1]  handle_bug+0x3e/0x70
[    8.225243][    T1]  exc_invalid_op+0x1a/0x50
[    8.225243][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.225243][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.225243][    T1] Code: b2 00 00 00 e8 87 70 f0 fc 5b 5d c3 cc cc cc c=
c e8 7b 70 f0 fc c6 05 ac bf ed 0a 01 90 48 c7 c7 80 66 1e 8c e8 e7 0a b3 f=
c 90 <0f> 0b 90 90 eb d9 e8 5b 70 f0 fc c6 05 89 bf ed 0a 01 90 48 c7 c7
[    8.225243][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.225243][    T1] RAX: a5557a779647f700 RBX: ffff8881432f33fc RCX: fff=
f888016ac0000
[    8.225243][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.225243][    T1] RBP: 0000000000000004 R08: ffffffff81587fc2 R09: fff=
ffbfff1c39b48
[    8.225243][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea000503cdc0
[    8.225243][    T1] R13: ffffea000503cdc8 R14: 1ffffd4000a079b9 R15: 000=
0000000000000
[    8.225243][    T1]  ? __warn_printk+0x292/0x360
[    8.225243][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.225243][    T1]  __free_pages_ok+0xc54/0xd80
[    8.225243][    T1]  make_alloc_exact+0xa3/0xf0
[    8.225243][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.225243][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.225243][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.225243][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.225243][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.225243][    T1]  ? really_probe+0x2b8/0xad0
[    8.225243][    T1]  ? driver_probe_device+0x50/0x430
[    8.225243][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.225243][    T1]  ? ret_from_fork+0x4b/0x80
[    8.225243][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.225243][    T1]  vring_create_virtqueue+0xca/0x110
[    8.225243][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.225243][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.225243][    T1]  setup_vq+0xe9/0x2d0
[    8.225243][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.225243][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.225243][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.225243][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.225243][    T1]  vp_setup_vq+0xbf/0x330
[    8.225243][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.225243][    T1]  ? ioread16+0x2f/0x90
[    8.225243][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.274896][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.274896][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.274896][    T1]  virtscsi_init+0x8db/0xd00
[    8.274896][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.274896][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.274896][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.274896][    T1]  ? vp_get+0xfd/0x140
[    8.274896][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.274896][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.274896][    T1]  ? vp_get_shm_region+0x51d/0x8b0
[    8.274896][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    8.274896][    T1]  ? vp_set_status+0x1a/0x40
[    8.274896][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.274896][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.274896][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.274896][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.274896][    T1]  really_probe+0x2b8/0xad0
[    8.274896][    T1]  __driver_probe_device+0x1a2/0x390
[    8.274896][    T1]  driver_probe_device+0x50/0x430
[    8.274896][    T1]  __driver_attach+0x45f/0x710
[    8.274896][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.274896][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.274896][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.274896][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.274896][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.274896][    T1]  bus_add_driver+0x347/0x620
[    8.274896][    T1]  driver_register+0x23a/0x320
[    8.274896][    T1]  virtio_scsi_init+0x69/0xe0
[    8.274896][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.274896][    T1]  do_one_initcall+0x248/0x880
[    8.274896][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.274896][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.274896][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.274896][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.274896][    T1]  ? do_initcalls+0x1c/0x80
[    8.274896][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.274896][    T1]  do_initcall_level+0x157/0x210
[    8.274896][    T1]  do_initcalls+0x3f/0x80
[    8.274896][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.274896][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.274896][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.274896][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.274896][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.274896][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.274896][    T1]  kernel_init+0x1d/0x2b0
[    8.274896][    T1]  ret_from_fork+0x4b/0x80
[    8.274896][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.274896][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.274896][    T1]  </TASK>
[    8.274896][    T1] Kernel Offset: disabled
[    8.274896][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2608577974=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at c8349e485
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
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c8349e48534ea6d8f01515335d95de8ebf=
5da8df\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D16ca23d5180000


Tested on:

commit:         0bbac3fa Linux 6.9-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db6bcb7598d5494c=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3D2e22057de05b9f3b3=
0d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13fe882b1800=
00


