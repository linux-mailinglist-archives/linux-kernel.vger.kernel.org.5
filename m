Return-Path: <linux-kernel+bounces-130801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B348897D45
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43077B296FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5409618AED;
	Thu,  4 Apr 2024 01:04:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36B1803D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192646; cv=none; b=CsXsGpef3uHt8FzAXoz4mZIvHLcEn8fnOcfu2UB8cbe4qOSZQHMhxrGHSuihoqSzQ3vOEQgnMddWj+xteaCKBmCbxxOgwbfne5uM25Kn9jmagEBrdvFskJu7dLgFsD6wYSSmVyg9l+bQOW0t8ruscAANPHPC3VjZrRHUFjFcOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192646; c=relaxed/simple;
	bh=RsJplWjIOeTnosEC442hqw0sUCU/SZhKn8m4e5QhLm0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aF9TRzlOn/XU25dUNox4+vWdl8OCcbUoN+Ii1RO6AbRtmowtLBPa+qxDMa6kjkaHW9pbB8cIS2CADHkhXuHYRbMod5ZEzAdCLYgtuFLHt7Jxjk7AAOm9KUre8FuhAV2TeQ6GTWV06cKq8YyDFBe8Dgk4yTJgLEkjOWJId5HmSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso50376439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 18:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712192643; x=1712797443;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCbgRfcWdTAvUcS13+ObiHStF4Kp4c1Vb6X1/6See38=;
        b=AYiP/g87+j6Y02EiNfASOc5cpaxRB1YwafNU+wGGlfcbIdPp2Be7mTruojohbucRaU
         cStEoTNB8C6o0NOzEmivdG1HAMH7n4S4hyBCPKHrrSm2rTBWUqHbVVoFhdmRUIGmxO/E
         LyMcYGwFCU7+IaKoTwBYzscpsFvopX10WfaKckhpdtIEIS2DD7XXi2Vll/FURWidFDMc
         zLX159w3uzifMJzq2rpPtXBI/Nm8uDYjqFEW0YR1Y2sh5AtXpe7i+Incz+WEyUD9gnyU
         6/wpwMcs87ORqg/4Cv5r92pMdWGQ3IaZgIQg8fCV/mPixr1ztQ87yG0ia0onFMJAve7A
         6Kjw==
X-Gm-Message-State: AOJu0Yz7PfgyrZCo2ipIKh/qUZ4v6jl7n2zB+iOUThwccTvcztGFUEt/
	KKwIk75gPpncsJKnNq/7Un95JCQmdzezVAv+T0xthJmMQ61+7sQHbT8yiIe9cwtrQ0mJDy1QDri
	vK0K5O+xruQmYPVqYZVAR2F8DV1idF4LNu7eeOht4ITS4YxeSC51y2PZpTg==
X-Google-Smtp-Source: AGHT+IGZbDqTPZrS4OMviVWuy34lOkJQkG9Z29TFBS3QD0n+CVWn5dbEVHu5+Fu1lHTJn3dYUfFZfOQTAZ/vSMmSaKcfAYpcvmPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:890b:b0:47f:162f:7060 with SMTP id
 jc11-20020a056638890b00b0047f162f7060mr49468jab.1.1712192643082; Wed, 03 Apr
 2024 18:04:03 -0700 (PDT)
Date: Wed, 03 Apr 2024 18:04:03 -0700
In-Reply-To: <20240403144724.14960-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000473d2906153aeac8@google.com>
Subject: Re: [syzbot] [usb?] [wireless?] WARNING in carl9170_usb_send_rx_irq_urb/usb_submit_urb
From: syzbot <syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

yS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
[    9.038219][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[    9.057953][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[    9.072243][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[    9.097318][    T1] Non-volatile memory driver v1.3
[    9.116138][    T1] Linux agpgart interface v0.103
[    9.127340][    T1] ACPI: bus type drm_connector registered
[    9.136388][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[    9.148877][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[    9.243029][    T1] Console: switching to colour frame buffer device 128=
x48
[    9.260911][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[    9.262683][    T1] usbcore: registered new interface driver udl
[    9.362369][    T1] brd: module loaded
[    9.478297][    T1] loop: module loaded
[    9.645631][    T1] zram: Added device: zram0
[    9.657180][    T1] null_blk: disk nullb0 created
[    9.658224][    T1] null_blk: module loaded
[    9.659262][    T1] Guest personality initialized and is inactive
[    9.661760][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[    9.662919][    T1] Initialized host personality
[    9.664352][    T1] usbcore: registered new interface driver rtsx_usb
[    9.667085][    T1] usbcore: registered new interface driver viperboard
[    9.668967][    T1] usbcore: registered new interface driver dln2
[    9.670645][    T1] usbcore: registered new interface driver pn533_usb
[    9.678467][    T1] nfcsim 0.2 initialized
[    9.681449][    T1] usbcore: registered new interface driver port100
[    9.683084][    T1] usbcore: registered new interface driver nfcmrvl
[    9.691418][    T1] Loading iSCSI transport class v2.0-870.
[    9.713074][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    9.725636][    T1] ------------[ cut here ]------------
[    9.726707][    T1] refcount_t: decrement hit 0; leaking memory.
[    9.728009][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1d7/0x1f0
[    9.729498][    T1] Modules linked in:
[    9.730156][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00080-gc85af715cac0-dirty #0
[    9.731847][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.734170][    T1] RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0
[    9.735216][    T1] Code: 05 39 20 fe 0a 01 e8 18 fa 11 fd 0f 0b e9 d7 f=
e ff ff e8 8c aa 4f fd 48 c7 c7 40 11 29 8b c6 05 18 20 fe 0a 01 e8 f9 f9 1=
1 fd <0f> 0b e9 b8 fe ff ff 48 89 ef e8 ca 96 a8 fd e9 5c fe ff ff 0f 1f
[    9.738879][    T1] RSP: 0000:ffffc900000673b8 EFLAGS: 00010282
[    9.740066][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fadaa
[    9.741609][    T1] RDX: ffff888017e78000 RSI: ffffffff814fadb7 RDI: 000=
0000000000001
[    9.744190][    T1] RBP: ffff88801f94beac R08: 0000000000000001 R09: 000=
0000000000000
[    9.746435][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88801f94beac
[    9.748384][    T1] R13: 0000000000000000 R14: 0000000007d200ba R15: fff=
f88814051b5c8
[    9.750792][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    9.752672][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.754415][    T1] CR2: ffff88823ffff000 CR3: 000000000d17a000 CR4: 000=
00000003506f0
[    9.755796][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    9.757015][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    9.758294][    T1] Call Trace:
[    9.758885][    T1]  <TASK>
[    9.760367][    T1]  ? show_regs+0x8c/0xa0
[    9.761843][    T1]  ? __warn+0xe5/0x3b0
[    9.762467][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.763325][    T1]  ? report_bug+0x3c0/0x580
[    9.764121][    T1]  ? handle_bug+0x3c/0x70
[    9.764824][    T1]  ? exc_invalid_op+0x17/0x40
[    9.765648][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    9.766958][    T1]  ? __warn_printk+0x17a/0x310
[    9.768097][    T1]  ? __warn_printk+0x187/0x310
[    9.769136][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.770546][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.771460][    T1]  __reset_page_owner+0x2ea/0x370
[    9.772227][    T1]  __free_pages_ok+0x5aa/0xbb0
[    9.772998][    T1]  ? __split_page_owner+0xdd/0x120
[    9.774098][    T1]  make_alloc_exact+0x165/0x260
[    9.774925][    T1]  vring_alloc_queue+0xc1/0x110
[    9.775640][    T1]  vring_alloc_queue_split.part.0+0x19a/0x4d0
[    9.776631][    T1]  ? __pfx_vring_alloc_queue_split.part.0+0x10/0x10
[    9.778003][    T1]  vring_create_virtqueue_split+0x135/0x300
[    9.779110][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.780406][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.781306][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.782361][    T1]  ? driver_register+0x15c/0x4b0
[    9.783247][    T1]  ? virtio_scsi_init+0x75/0x100
[    9.783971][    T1]  ? do_one_initcall+0x113/0x6c0
[    9.784818][    T1]  vring_create_virtqueue+0xd7/0x140
[    9.785769][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.787208][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.788260][    T1]  setup_vq+0x123/0x2f0
[    9.788878][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.790089][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.791293][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.792374][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.793404][    T1]  vp_setup_vq+0xb1/0x380
[    9.794570][    T1]  ? ioread16+0x50/0xc0
[    9.795458][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.796558][    T1]  vp_find_vqs_msix+0x661/0xe30
[    9.797762][    T1]  vp_find_vqs+0x58/0x560
[    9.798819][    T1]  virtscsi_init+0x459/0x9f0
[    9.799877][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.801319][    T1]  ? __init_waitqueue_head+0xca/0x150
[    9.802288][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.803271][    T1]  ? ioread8+0x4f/0xc0
[    9.803999][    T1]  ? vp_get+0xf6/0x140
[    9.804908][    T1]  virtscsi_probe+0x39b/0xda0
[    9.805839][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.806643][    T1]  virtio_dev_probe+0x5fd/0x9b0
[    9.807771][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.808641][    T1]  really_probe+0x23e/0xa90
[    9.809546][    T1]  __driver_probe_device+0x1de/0x440
[    9.810393][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[    9.811353][    T1]  driver_probe_device+0x4c/0x1b0
[    9.812164][    T1]  __driver_attach+0x283/0x580
[    9.813013][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.814078][    T1]  bus_for_each_dev+0x12a/0x1c0
[    9.814957][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.815902][    T1]  bus_add_driver+0x2ed/0x640
[    9.816570][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.817691][    T1]  driver_register+0x15c/0x4b0
[    9.818894][    T1]  virtio_scsi_init+0x75/0x100
[    9.819993][    T1]  do_one_initcall+0x113/0x6c0
[    9.820861][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.822094][    T1]  ? parameq+0x150/0x180
[    9.822808][    T1]  ? trace_kmalloc+0x2d/0xd0
[    9.823806][    T1]  ? __kmalloc+0x20f/0x430
[    9.824660][    T1]  kernel_init_freeable+0x5c7/0x900
[    9.825629][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.826507][    T1]  kernel_init+0x1c/0x2b0
[    9.827258][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.828571][    T1]  ret_from_fork+0x45/0x80
[    9.829390][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.830312][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.831556][    T1]  </TASK>
[    9.832046][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    9.833135][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00080-gc85af715cac0-dirty #0
[    9.835063][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.836779][    T1] Call Trace:
[    9.837873][    T1]  <TASK>
[    9.838456][    T1]  dump_stack_lvl+0x3d/0x1f0
[    9.839689][    T1]  panic+0x6d2/0x780
[    9.840276][    T1]  ? __pfx_panic+0x10/0x10
[    9.840297][    T1]  ? show_trace_log_lvl+0x35c/0x510
[    9.840297][    T1]  ? check_panic_on_warn+0x1f/0xb0
[    9.840297][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.840297][    T1]  check_panic_on_warn+0xab/0xb0
[    9.840297][    T1]  __warn+0xf1/0x3b0
[    9.840297][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.840297][    T1]  report_bug+0x3c0/0x580
[    9.840297][    T1]  handle_bug+0x3c/0x70
[    9.840297][    T1]  exc_invalid_op+0x17/0x40
[    9.840297][    T1]  asm_exc_invalid_op+0x1a/0x20
[    9.840297][    T1] RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0
[    9.840297][    T1] Code: 05 39 20 fe 0a 01 e8 18 fa 11 fd 0f 0b e9 d7 f=
e ff ff e8 8c aa 4f fd 48 c7 c7 40 11 29 8b c6 05 18 20 fe 0a 01 e8 f9 f9 1=
1 fd <0f> 0b e9 b8 fe ff ff 48 89 ef e8 ca 96 a8 fd e9 5c fe ff ff 0f 1f
[    9.840297][    T1] RSP: 0000:ffffc900000673b8 EFLAGS: 00010282
[    9.840297][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814fadaa
[    9.840297][    T1] RDX: ffff888017e78000 RSI: ffffffff814fadb7 RDI: 000=
0000000000001
[    9.840297][    T1] RBP: ffff88801f94beac R08: 0000000000000001 R09: 000=
0000000000000
[    9.840297][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88801f94beac
[    9.840297][    T1] R13: 0000000000000000 R14: 0000000007d200ba R15: fff=
f88814051b5c8
[    9.840297][    T1]  ? __warn_printk+0x17a/0x310
[    9.840297][    T1]  ? __warn_printk+0x187/0x310
[    9.840297][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.840297][    T1]  __reset_page_owner+0x2ea/0x370
[    9.840297][    T1]  __free_pages_ok+0x5aa/0xbb0
[    9.840297][    T1]  ? __split_page_owner+0xdd/0x120
[    9.840297][    T1]  make_alloc_exact+0x165/0x260
[    9.840297][    T1]  vring_alloc_queue+0xc1/0x110
[    9.840297][    T1]  vring_alloc_queue_split.part.0+0x19a/0x4d0
[    9.840297][    T1]  ? __pfx_vring_alloc_queue_split.part.0+0x10/0x10
[    9.840297][    T1]  vring_create_virtqueue_split+0x135/0x300
[    9.840297][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.840297][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.840297][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.840297][    T1]  ? driver_register+0x15c/0x4b0
[    9.840297][    T1]  ? virtio_scsi_init+0x75/0x100
[    9.840297][    T1]  ? do_one_initcall+0x113/0x6c0
[    9.840297][    T1]  vring_create_virtqueue+0xd7/0x140
[    9.840297][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.840297][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.840297][    T1]  setup_vq+0x123/0x2f0
[    9.840297][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.840297][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.889816][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.889816][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.889816][    T1]  vp_setup_vq+0xb1/0x380
[    9.889816][    T1]  ? ioread16+0x50/0xc0
[    9.889816][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.889816][    T1]  vp_find_vqs_msix+0x661/0xe30
[    9.889816][    T1]  vp_find_vqs+0x58/0x560
[    9.889816][    T1]  virtscsi_init+0x459/0x9f0
[    9.889816][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.889816][    T1]  ? __init_waitqueue_head+0xca/0x150
[    9.889816][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.889816][    T1]  ? ioread8+0x4f/0xc0
[    9.889816][    T1]  ? vp_get+0xf6/0x140
[    9.889816][    T1]  virtscsi_probe+0x39b/0xda0
[    9.889816][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.889816][    T1]  virtio_dev_probe+0x5fd/0x9b0
[    9.889816][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.889816][    T1]  really_probe+0x23e/0xa90
[    9.889816][    T1]  __driver_probe_device+0x1de/0x440
[    9.889816][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[    9.889816][    T1]  driver_probe_device+0x4c/0x1b0
[    9.889816][    T1]  __driver_attach+0x283/0x580
[    9.889816][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.889816][    T1]  bus_for_each_dev+0x12a/0x1c0
[    9.889816][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.889816][    T1]  bus_add_driver+0x2ed/0x640
[    9.889816][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.889816][    T1]  driver_register+0x15c/0x4b0
[    9.889816][    T1]  virtio_scsi_init+0x75/0x100
[    9.889816][    T1]  do_one_initcall+0x113/0x6c0
[    9.889816][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.889816][    T1]  ? parameq+0x150/0x180
[    9.889816][    T1]  ? trace_kmalloc+0x2d/0xd0
[    9.889816][    T1]  ? __kmalloc+0x20f/0x430
[    9.889816][    T1]  kernel_init_freeable+0x5c7/0x900
[    9.889816][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.889816][    T1]  kernel_init+0x1c/0x2b0
[    9.889816][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.889816][    T1]  ret_from_fork+0x45/0x80
[    9.889816][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.889816][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.889816][    T1]  </TASK>
[    9.889816][    T1] Kernel Offset: disabled
[    9.889816][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3177901411=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at ab32d5088
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
/syzkaller/prog.GitRevision=3Dab32d50881df9f96f2af301aadca62ad00b7e099 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20221230-155636'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dab32d50881df9f96f2af301aadca62ad00b7e099 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20221230-155636'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dab32d50881df9f96f2af301aadca62ad00b7e099 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20221230-155636'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 =
\
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"ab32d50881df9f96f2af301aadca62ad00=
b7e099\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1216333d180000


Tested on:

commit:         c85af715 Merge tag 'vboxsf-v6.9-1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3583c441956deae=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D0ae4804973be759fa=
420
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D158448de1800=
00


