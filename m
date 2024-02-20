Return-Path: <linux-kernel+bounces-72344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A1B85B23E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A735B282413
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE24956B85;
	Tue, 20 Feb 2024 05:27:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403A2E40D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708406824; cv=none; b=Nct3eI00Y/pn+yFHJdN3so4v8RIdfktjqWwKtuxAqjnc/kHumjPLxG3Cvxkod3NZEGH5fBcX8wxM/3GPdcp7tYwPRA7SuVP4ypvaWIMuc29RzdubT8en/xvBFNC2iIcWBweCetTvAkvAKaH8kgEC12Q6FtjsGAk5M5QJR01QW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708406824; c=relaxed/simple;
	bh=1Ue8kYcJyaC4DJoTdElJiGjbX4z9xy0EQU0gZ7upH2A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cz63YGEB332901cvSDG9Yr6naLTjuVLAtqgxthmcapF+/NsMNfJMp5xzD6jFvObxtrTfpkBus2MnGyuE2ISihvTtLeE53sdnBoHVQjW0+QN7UXuzYaapXeGTdTUbdK+kbFbeDORYfdaz9pgu+YayalbYFrl4ITfQ7I1SQazPIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7490332deso162430839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708406822; x=1709011622;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGBYLg+oa70DUbN6SMMnFCiiHFgUlQfj8xsEEvpCX2k=;
        b=piamKIBs/7YyAzbe29AXMfobJ7qWSyNYQmqs0q6ZFT7VkmqmLRMWQ7c3llOUI9yWnu
         Os9FuR43BsIsjjH1tA38YUetjLpsjj6oYNE9vtTKODidjj+VygZcs/NmYFep/YUNFs6Z
         ZJTtft/tkR+1iOdDouWqtLme+/7k3vw+zIN8WqeVbtTI9jcVrhl5cx1BR4zJUe2aP3Yo
         eMUfPqMM/yvU00sHaEty3IvXyOyU9TK4hBVP+mkR36Ke5ezhsuxocc8cdzSocZlhyDk1
         MreRe237U/8Xp0aOGmNcHbEpcRwSl1YvnAifjAOQljnxV8yfWvfM3Cu5BTZbEHCimk8e
         p+RQ==
X-Gm-Message-State: AOJu0YyeUbPvaeeqLjs0EHZkXRN1ChJKCD5LoZZMMqfhyqfHlS5dvFNk
	1fMZ8uKGK7bQBdXfK5TIHqhO/t4WxOaQ5YIH02lpguDuL31j3oTNd65hZufs5gHqZw0x9mcGcW0
	UeHCNLCeOgxLDfjbCbPnwXXVhOXiKf5rOrvl8A8U/BovqD6gX+n6Pi4qMgA==
X-Google-Smtp-Source: AGHT+IEFdrY1LkexCRFBo5uuIfekHmM1sl29D1a8x+to+5qtoRQPALlJ5nmGtvKljINsrj7bPwSCKfL0keLWKMpKAQMytVYX5LiU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3a0b:b0:471:5dda:5c73 with SMTP id
 cn11-20020a0566383a0b00b004715dda5c73mr272246jab.4.1708406821968; Mon, 19 Feb
 2024 21:27:01 -0800 (PST)
Date: Mon, 19 Feb 2024 21:27:01 -0800
In-Reply-To: <ZdQvap_8BIiIq_GB@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c15e6c0611c97530@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

.
[   10.076074][    T1] fuse: init (API version 7.39)
[   10.080364][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:
[   10.082002][    T1] orangefs_init: module version upstream loaded
[   10.083592][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536
[   10.099770][    T1] SGI XFS with ACLs, security attributes, realtime, qu=
ota, no debug enabled
[   10.104241][    T1] 9p: Installing v9fs 9p2000 file system support
[   10.105539][    T1] NILFS version 2 loaded
[   10.106156][    T1] befs: version: 0.9.3
[   10.107195][    T1] ocfs2: Registered cluster interface o2cb
[   10.108527][    T1] ocfs2: Registered cluster interface user
[   10.111379][    T1] OCFS2 User DLM kernel interface loaded
[   10.118460][    T1] gfs2: GFS2 installed
[   10.135588][    T1] ceph: loaded (mds proto 32)
[   12.024322][    T1] NET: Registered PF_ALG protocol family
[   12.025308][    T1] xor: automatically using best checksumming function =
  avx      =20
[   12.027314][    T1] async_tx: api initialized (async)
[   12.028180][    T1] Key type asymmetric registered
[   12.029109][    T1] Asymmetric key parser 'x509' registered
[   12.030157][    T1] Asymmetric key parser 'pkcs8' registered
[   12.030980][    T1] Key type pkcs7_test registered
[   12.032530][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 240)
[   12.034815][    T1] io scheduler mq-deadline registered
[   12.035601][    T1] io scheduler kyber registered
[   12.036477][    T1] io scheduler bfq registered
[   12.043584][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[   12.054905][    T1] ACPI: button: Power Button [PWRF]
[   12.061506][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN=
:00/input/input1
[   12.071048][    T1] ACPI: button: Sleep Button [SLPF]
[   12.086912][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[   12.130351][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[   12.135899][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[   12.175460][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[   12.181044][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[   12.221372][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   12.226897][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[   12.317580][  T257] kworker/u4:0 (257) used greatest stack depth: 11000 =
bytes left
[   12.798023][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[   12.805613][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[   12.815494][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[   12.835349][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[   12.855309][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[   12.875589][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[   12.907146][    T1] Non-volatile memory driver v1.3
[   12.921393][    T1] Linux agpgart interface v0.103
[   12.931868][    T1] ACPI: bus type drm_connector registered
[   12.943489][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[   12.959783][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[   13.248241][    T1] Console: switching to colour frame buffer device 128=
x48
[   13.314754][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[   13.322329][    T1] usbcore: registered new interface driver udl
[   13.472888][    T1] brd: module loaded
[   13.561610][    T1] loop: module loaded
[   13.689528][    T1] zram: Added device: zram0
[   13.702671][    T1] null_blk: disk nullb0 created
[   13.707565][    T1] null_blk: module loaded
[   13.712923][    T1] Guest personality initialized and is inactive
[   13.719805][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[   13.727398][    T1] Initialized host personality
[   13.732444][    T1] usbcore: registered new interface driver rtsx_usb
[   13.741306][    T1] usbcore: registered new interface driver viperboard
[   13.748470][    T1] usbcore: registered new interface driver dln2
[   13.755172][    T1] usbcore: registered new interface driver pn533_usb
[   13.765466][    T1] nfcsim 0.2 initialized
[   13.769944][    T1] usbcore: registered new interface driver port100
[   13.776737][    T1] usbcore: registered new interface driver nfcmrvl
[   13.789159][    T1] Loading iSCSI transport class v2.0-870.
[   13.809621][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[   13.830894][    T1] scsi host0: Virtio SCSI HBA
[   14.080706][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs =
256
[   14.093000][   T41] scsi 0:0:1:0: Direct-Access     Google   PersistentD=
isk   1    PQ: 0 ANSI: 6
[   14.119106][    T1] Rounding down aligned max_sectors from 4294967295 to=
 4294967288
[   14.128024][    T1] db_root: cannot open: /etc/target
[   14.157608][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   14.157758][    T1] BUG: KMSAN: use-after-free in __list_del_entry_valid=
_or_report+0x19e/0x490
[   14.157853][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
[   14.157942][    T1]  stack_depot_save_flags+0x3e7/0x7b0
[   14.158005][    T1]  stack_depot_save+0x12/0x20
[   14.158059][    T1]  ref_tracker_alloc+0x215/0x700
[   14.158123][    T1]  linkwatch_fire_event+0x32b/0x6d0
[   14.158208][    T1]  netif_carrier_off+0xec/0x110
[   14.158278][    T1]  bond_create+0x19d/0x2a0
[   14.158354][    T1]  bonding_init+0x1a7/0x2d0
[   14.158412][    T1]  do_one_initcall+0x216/0x960
[   14.158478][    T1]  do_initcall_level+0x140/0x350
[   14.158540][    T1]  do_initcalls+0xf0/0x1d0
[   14.158595][    T1]  do_basic_setup+0x22/0x30
[   14.158651][    T1]  kernel_init_freeable+0x300/0x4b0
[   14.158713][    T1]  kernel_init+0x2f/0x7e0
[   14.158781][    T1]  ret_from_fork+0x66/0x80
[   14.158855][    T1]  ret_from_fork_asm+0x11/0x20
[   14.158921][    T1]=20
[   14.158930][    T1] Uninit was created at:
[   14.158959][    T1]  __free_pages_ok+0x133/0xeb0
[   14.159060][    T1]  alloc_pages_exact+0x2f5/0x350
[   14.159060][    T1]  vring_alloc_queue_split+0x2d9/0x990
[   14.159060][    T1]  vring_create_virtqueue_split+0x89/0x380
[   14.159060][    T1]  vring_create_virtqueue+0x101/0x1a0
[   14.159060][    T1]  setup_vq+0x175/0x510
[   14.159060][    T1]  vp_setup_vq+0x103/0x630
[   14.159060][    T1]  vp_find_vqs_msix+0x1162/0x16c0
[   14.159060][    T1]  vp_find_vqs+0x78/0x770
[   14.159060][    T1]  virtscsi_init+0xff7/0x17a0
[   14.159060][    T1]  virtscsi_probe+0x43b/0xfe0
[   14.159060][    T1]  virtio_dev_probe+0x16df/0x1900
[   14.159060][    T1]  really_probe+0x506/0xf40
[   14.159060][    T1]  __driver_probe_device+0x2a7/0x5d0
[   14.159060][    T1]  driver_probe_device+0x72/0x7b0
[   14.159060][    T1]  __driver_attach+0x710/0xa30
[   14.159060][    T1]  bus_for_each_dev+0x34c/0x530
[   14.159060][    T1]  driver_attach+0x51/0x60
[   14.159060][    T1]  bus_add_driver+0x747/0xca0
[   14.159060][    T1]  driver_register+0x3fb/0x650
[   14.159060][    T1]  register_virtio_driver+0xd1/0xf0
[   14.159060][    T1]  virtio_scsi_init+0x123/0x2f0
[   14.159060][    T1]  do_one_initcall+0x216/0x960
[   14.159060][    T1]  do_initcall_level+0x140/0x350
[   14.159060][    T1]  do_initcalls+0xf0/0x1d0
[   14.159060][    T1]  do_basic_setup+0x22/0x30
[   14.159060][    T1]  kernel_init_freeable+0x300/0x4b0
[   14.159060][    T1]  kernel_init+0x2f/0x7e0
[   14.159060][    T1]  ret_from_fork+0x66/0x80
[   14.159060][    T1]  ret_from_fork_asm+0x11/0x20
[   14.159060][    T1]=20
[   14.159060][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc5-=
syzkaller-gb401b621758e-dirty #0
[   14.159060][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[   14.159060][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   14.159060][    T1] Disabling lock debugging due to kernel taint
[   14.159060][    T1] Kernel panic - not syncing: kmsan.panic set ...
[   14.159060][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B       =
       6.8.0-rc5-syzkaller-gb401b621758e-dirty #0
[   14.159060][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[   14.159060][    T1] Call Trace:
[   14.159060][    T1]  <TASK>
[   14.159060][    T1]  dump_stack_lvl+0x1bf/0x240
[   14.159060][    T1]  dump_stack+0x1e/0x20
[   14.159060][    T1]  panic+0x4de/0xc90
[   14.159060][    T1]  kmsan_report+0x2d0/0x2d0
[   14.159060][    T1]  ? filter_irq_stacks+0x164/0x1a0
[   14.159060][    T1]  ? __msan_warning+0x96/0x110
[   14.159060][    T1]  ? __list_del_entry_valid_or_report+0x19e/0x490
[   14.159060][    T1]  ? stack_depot_save_flags+0x3e7/0x7b0
[   14.159060][    T1]  ? stack_depot_save+0x12/0x20
[   14.159060][    T1]  ? ref_tracker_alloc+0x215/0x700
[   14.159060][    T1]  ? linkwatch_fire_event+0x32b/0x6d0
[   14.159060][    T1]  ? netif_carrier_off+0xec/0x110
[   14.159060][    T1]  ? bond_create+0x19d/0x2a0
[   14.159060][    T1]  ? bonding_init+0x1a7/0x2d0
[   14.159060][    T1]  ? do_one_initcall+0x216/0x960
[   14.159060][    T1]  ? do_initcall_level+0x140/0x350
[   14.159060][    T1]  ? do_initcalls+0xf0/0x1d0
[   14.159060][    T1]  ? do_basic_setup+0x22/0x30
[   14.159060][    T1]  ? kernel_init_freeable+0x300/0x4b0
[   14.159060][    T1]  ? kernel_init+0x2f/0x7e0
[   14.159060][    T1]  ? ret_from_fork+0x66/0x80
[   14.159060][    T1]  ? ret_from_fork_asm+0x11/0x20
[   14.159060][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   14.159060][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   14.159060][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   14.159060][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   14.159060][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   14.159060][    T1]  ? _raw_spin_lock_irqsave+0x35/0xc0
[   14.159060][    T1]  ? filter_irq_stacks+0x60/0x1a0
[   14.159060][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
[   14.159060][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   14.159060][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   14.159060][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   14.159060][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   14.159060][    T1]  __msan_warning+0x96/0x110
[   14.159060][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
[   14.159060][    T1]  stack_depot_save_flags+0x3e7/0x7b0
[   14.159060][    T1]  stack_depot_save+0x12/0x20
[   14.159060][    T1]  ref_tracker_alloc+0x215/0x700
[   14.159060][    T1]  ? linkwatch_fire_event+0x32b/0x6d0
[   14.159060][    T1]  ? netif_carrier_off+0xec/0x110
[   14.159060][    T1]  ? bond_create+0x19d/0x2a0
[   14.159060][    T1]  ? bonding_init+0x1a7/0x2d0
[   14.159060][    T1]  ? do_one_initcall+0x216/0x960
[   14.159060][    T1]  ? do_initcall_level+0x140/0x350
[   14.159060][    T1]  ? do_initcalls+0xf0/0x1d0
[   14.159060][    T1]  ? do_basic_setup+0x22/0x30
[   14.159060][    T1]  ? kernel_init_freeable+0x300/0x4b0
[   14.159060][    T1]  ? kernel_init+0x2f/0x7e0
[   14.159060][    T1]  ? ret_from_fork+0x66/0x80
[   14.159060][    T1]  ? ret_from_fork_asm+0x11/0x20
[   14.159060][    T1]  ? kmsan_internal_unpoison_memory+0x14/0x20
[   14.159060][    T1]  linkwatch_fire_event+0x32b/0x6d0
[   14.159060][    T1]  ? advisor_target_scan_time_store+0xe0/0x170
[   14.159060][    T1]  netif_carrier_off+0xec/0x110
[   14.159060][    T1]  bond_create+0x19d/0x2a0
[   14.159060][    T1]  bonding_init+0x1a7/0x2d0
[   14.159060][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   14.159060][    T1]  do_one_initcall+0x216/0x960
[   14.159060][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   14.159060][    T1]  ? kmsan_get_metadata+0xb0/0x1c0
[   14.159060][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   14.159060][    T1]  ? filter_irq_stacks+0x164/0x1a0
[   14.159060][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
[   14.159060][    T1]  ? skip_spaces+0x8f/0xc0
[   14.159060][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   14.159060][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   14.159060][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   14.159060][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   14.159060][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   14.159060][    T1]  ? parse_args+0x1511/0x15e0
[   14.159060][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   14.159060][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   14.159060][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   14.159060][    T1]  do_initcall_level+0x140/0x350
[   14.159060][    T1]  do_initcalls+0xf0/0x1d0
[   14.159060][    T1]  ? arch_cpuhp_init_parallel_bringup+0xe0/0xe0
[   14.159060][    T1]  do_basic_setup+0x22/0x30
[   14.159060][    T1]  kernel_init_freeable+0x300/0x4b0
[   14.159060][    T1]  ? rest_init+0x260/0x260
[   14.159060][    T1]  kernel_init+0x2f/0x7e0
[   14.159060][    T1]  ? rest_init+0x260/0x260
[   14.159060][    T1]  ret_from_fork+0x66/0x80
[   14.159060][    T1]  ? rest_init+0x260/0x260
[   14.159060][    T1]  ret_from_fork_asm+0x11/0x20
[   14.159060][    T1]  </TASK>
[   14.159060][    T1] Kernel Offset: disabled


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
 -ffile-prefix-map=3D/tmp/go-build3485226163=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 3222d10cb
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
/syzkaller/prog.GitRevision=3D3222d10cbe77bbedb5a7c455e5bcb6b7081a63b7 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231213-164354'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D3222d10cbe77bbedb5a7c455e5bcb6b7081a63b7 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231213-164354'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D3222d10cbe77bbedb5a7c455e5bcb6b7081a63b7 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231213-164354'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"3222d10cbe77bbedb5a7c455e5bcb6b708=
1a63b7\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1556f362180000


Tested on:

commit:         b401b621 Linux 6.8-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd33318d4e4a0d22=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D34ad5fab48f7bf510=
349
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D127e7e941800=
00


