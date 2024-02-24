Return-Path: <linux-kernel+bounces-79584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6E0862478
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2131C21568
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A811525564;
	Sat, 24 Feb 2024 11:19:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295A1AAD0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708773545; cv=none; b=nTYGGXxMylPgitijkc1g2kfIDo6bBZ59hwxupj1CtMU4zx8EUO0cAE2w388uuECvh9Z0MJsbZzrnQ4Z0HkbupGXrWdXH/Tm538iY3DbquhbuKbpMnl+FvU9LO4DJsllYoUcsmPHBEzkAONXj+XHdXPpUm+ysb864xQV2WHF4uSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708773545; c=relaxed/simple;
	bh=d8/K3B05mXt5vDkPFK8k2rxX/jJNveAyzK7RcJtrSP0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MWs0lTX+8fxqqmgzknRLLd8mk37z69saQaNFVL6OUV3MxGVVcxeoqpoLJaX7+4SZ6PhVWGCHPuX/2pX2whLsmbOY0oybLdqPR71No0MCyV2HDDtw/nBIeqHGPSlsfVwroGjz/wnNnJQ4f6qt8jOErvbtLdEGfEHdWmcSW6H8WGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c78573f2d0so95597339f.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708773543; x=1709378343;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMMEJA00zlu8CDSWPxJMVCLRxlLWUbZsRYeNCvq56BY=;
        b=QBWBkYlEI9wxYkvDFtllKjhz9lA+mkP/wET54ynUqh5IpWZk4w5Ug41WIel8WfGZg/
         uhHEPKXoNb942rZKu8DvzGRjh0voF5S8rvQPhHefH9isN0UhthSk/43XwUrVV85XmnC6
         BDePqU4F9s2XKyPY9TqfT9xcYPEziQFgI9hUK1JJweVINRwwgNXECpJpt/sBwJfR/84C
         0hlbK8BWjeP2r/xL5/0Sd3PKk/U07fG5/rYd8J/PIKhl9npiPHeHJf/qHTHukOMiUGYf
         E7vlF9/mJUw7WfIZ9JeBsgY0aQE6qSkBSIsi714YTrvCrxdhqmMCT7y2ncguV/rvCpA4
         A3fA==
X-Gm-Message-State: AOJu0Yy5TJXByF6g/m6JojhnbUO7HZSRqE2xRdwSjg7jO+FWwtsgBioY
	2aaish+peLRebz1Ni2uANmPH9VYbpNV9JVUDUftGJ8h6gms+zDNBQWDMQvs22KVJhKk9v0MhakW
	0vO+nM4Wc7UjvypGSSGn2IrAH0QiVId2/HHR2LoWym3Yv4PtAtjnpv7GC+g==
X-Google-Smtp-Source: AGHT+IGiWbeUjlncU9FVAB9muhIFAalrmD+KtuIsbPxFOJ11saBpjuNItCmISJxl3p0kx/IMaRCn04jIlIblPbkOy8g+GwjF8SB5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3712:b0:474:6adc:5f6e with SMTP id
 k18-20020a056638371200b004746adc5f6emr68147jav.4.1708773542803; Sat, 24 Feb
 2024 03:19:02 -0800 (PST)
Date: Sat, 24 Feb 2024 03:19:02 -0800
In-Reply-To: <e34d2e40-de98-4736-bae9-7271fe9cf242@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000053e7f06121ed89c@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

t_init: NFSv4 File Layout Driver Registering...
[   20.471049][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[   20.505263][    T1] Key type cifs.spnego registered
[   20.511376][    T1] Key type cifs.idmap registered
[   20.520289][    T1] ntfs: driver 2.1.32 [Flags: R/W].
[   20.527115][    T1] ntfs3: Max link count 4000
[   20.531960][    T1] ntfs3: Enabled Linux POSIX ACLs support
[   20.538483][    T1] ntfs3: Read-only LZX/Xpress compression included
[   20.545508][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[   20.551729][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   20.557831][    T1] QNX4 filesystem 0.2.3 registered.
[   20.563340][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[   20.570536][    T1] fuse: init (API version 7.39)
[   20.571734][  T101] kworker/u4:2 (101) used greatest stack depth: 11288 =
bytes left
[   20.581752][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:
[   20.592075][    T1] orangefs_init: module version upstream loaded
[   20.600151][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536
[   20.639154][    T1] SGI XFS with ACLs, security attributes, realtime, qu=
ota, no debug enabled
[   20.657570][    T1] 9p: Installing v9fs 9p2000 file system support
[   20.665095][    T1] NILFS version 2 loaded
[   20.669396][    T1] befs: version: 0.9.3
[   20.674578][    T1] ocfs2: Registered cluster interface o2cb
[   20.681669][    T1] ocfs2: Registered cluster interface user
[   20.688930][    T1] OCFS2 User DLM kernel interface loaded
[   20.707749][    T1] gfs2: GFS2 installed
[   20.744474][    T1] ceph: loaded (mds proto 32)
[   24.874084][    T1] NET: Registered PF_ALG protocol family
[   24.880210][    T1] xor: automatically using best checksumming function =
  avx      =20
[   24.888295][    T1] async_tx: api initialized (async)
[   24.893754][    T1] Key type asymmetric registered
[   24.898745][    T1] Asymmetric key parser 'x509' registered
[   24.904660][    T1] Asymmetric key parser 'pkcs8' registered
[   24.910541][    T1] Key type pkcs7_test registered
[   24.916242][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 240)
[   24.926204][    T1] io scheduler mq-deadline registered
[   24.931648][    T1] io scheduler kyber registered
[   24.937150][    T1] io scheduler bfq registered
[   24.953833][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[   24.971277][    T1] ACPI: button: Power Button [PWRF]
[   24.979332][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN=
:00/input/input1
[   24.989840][    T1] ACPI: button: Sleep Button [SLPF]
[   25.012119][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[   25.095202][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[   25.101026][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[   25.175231][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[   25.180945][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[   25.256940][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   25.262845][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[   25.319638][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for leg=
acy driver
[   25.380117][  T192] kworker/u4:2 (192) used greatest stack depth: 11000 =
bytes left
[   25.419761][  T216] kworker/u4:4 (216) used greatest stack depth: 10880 =
bytes left
[   26.330623][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[   26.337903][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[   26.350042][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[   26.379363][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[   26.408213][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[   26.436415][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[   26.484205][    T1] Non-volatile memory driver v1.3
[   26.510889][    T1] Linux agpgart interface v0.103
[   26.525992][    T1] ACPI: bus type drm_connector registered
[   26.541877][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[   26.561354][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[   27.039310][    T1] Console: switching to colour frame buffer device 128=
x48
[   27.194448][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[   27.202140][    T1] usbcore: registered new interface driver udl
[   27.363686][    T1] brd: module loaded
[   27.533426][    T1] loop: module loaded
[   27.781686][    T1] zram: Added device: zram0
[   27.803872][    T1] null_blk: disk nullb0 created
[   27.808850][    T1] null_blk: module loaded
[   27.813612][    T1] Guest personality initialized and is inactive
[   27.821083][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[   27.828876][    T1] Initialized host personality
[   27.835427][    T1] usbcore: registered new interface driver rtsx_usb
[   27.843793][    T1] usbcore: registered new interface driver viperboard
[   27.851479][    T1] usbcore: registered new interface driver dln2
[   27.858605][    T1] usbcore: registered new interface driver pn533_usb
[   27.871594][    T1] nfcsim 0.2 initialized
[   27.876318][    T1] usbcore: registered new interface driver port100
[   27.883331][    T1] usbcore: registered new interface driver nfcmrvl
[   27.899548][    T1] Loading iSCSI transport class v2.0-870.
[   27.935492][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[   27.968598][    T1] scsi host0: Virtio SCSI HBA
[   28.484347][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs =
256
[   28.491538][   T26] scsi 0:0:1:0: Direct-Access     Google   PersistentD=
isk   1    PQ: 0 ANSI: 6
[   28.563800][    T1] Rounding down aligned max_sectors from 4294967295 to=
 4294967288
[   28.574157][    T1] db_root: cannot open: /etc/target
[   28.623965][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   28.624202][    T1] BUG: KMSAN: use-after-free in __list_del_entry_valid=
_or_report+0x19e/0x490
[   28.624362][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
[   28.624516][    T1]  stack_depot_save_flags+0x3e2/0x7a0
[   28.624621][    T1]  stack_depot_save+0x12/0x20
[   28.624709][    T1]  ref_tracker_alloc+0x215/0x700
[   28.624801][    T1]  netdev_hold+0xe2/0x120
[   28.624916][    T1]  register_netdevice+0x1bc7/0x2170
[   28.625022][    T1]  bond_create+0x138/0x2a0
[   28.625148][    T1]  bonding_init+0x1a7/0x2d0
[   28.625247][    T1]  do_one_initcall+0x216/0x960
[   28.625348][    T1]  do_initcall_level+0x140/0x350
[   28.625453][    T1]  do_initcalls+0xf0/0x1d0
[   28.625556][    T1]  do_basic_setup+0x22/0x30
[   28.625649][    T1]  kernel_init_freeable+0x300/0x4b0
[   28.625757][    T1]  kernel_init+0x2f/0x7e0
[   28.625871][    T1]  ret_from_fork+0x66/0x80
[   28.625991][    T1]  ret_from_fork_asm+0x11/0x20
[   28.626101][    T1]=20
[   28.626114][    T1] Uninit was created at:
[   28.626277][    T1]  free_unref_page_prepare+0xc1/0xad0
[   28.626418][    T1]  free_unref_page+0x58/0x6d0
[   28.626549][    T1]  __free_pages+0xb1/0x1f0
[   28.626626][    T1]  thread_stack_free_rcu+0x97/0xb0
[   28.626721][    T1]  rcu_core+0xa3c/0x1df0
[   28.626843][    T1]  rcu_core_si+0x12/0x20
[   28.626950][    T1]  __do_softirq+0x1b7/0x7c3
[   28.627080][    T1]=20
[   28.627096][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc5-=
syzkaller-00278-g603c04e27c3e-dirty #0
[   28.627194][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[   28.627246][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   28.627270][    T1] Disabling lock debugging due to kernel taint
[   28.627299][    T1] Kernel panic - not syncing: kmsan.panic set ...
[   28.627335][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B       =
       6.8.0-rc5-syzkaller-00278-g603c04e27c3e-dirty #0
[   28.627441][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[   28.627493][    T1] Call Trace:
[   28.627520][    T1]  <TASK>
[   28.627548][    T1]  dump_stack_lvl+0x1bf/0x240
[   28.627651][    T1]  dump_stack+0x1e/0x20
[   28.627733][    T1]  panic+0x4de/0xc90
[   28.627875][    T1]  kmsan_report+0x2d0/0x2d0
[   28.627974][    T1]  ? cleanup_uevent_env+0x40/0x50
[   28.628108][    T1]  ? netdev_queue_update_kobjects+0x3f5/0x870
[   28.628237][    T1]  ? netdev_register_kobject+0x41e/0x520
[   28.628357][    T1]  ? register_netdevice+0x198f/0x2170
[   28.628473][    T1]  ? __msan_warning+0x96/0x110
[   28.628609][    T1]  ? __list_del_entry_valid_or_report+0x19e/0x490
[   28.628762][    T1]  ? stack_depot_save_flags+0x3e2/0x7a0
[   28.628872][    T1]  ? stack_depot_save+0x12/0x20
[   28.628971][    T1]  ? ref_tracker_alloc+0x215/0x700
[   28.629069][    T1]  ? netdev_hold+0xe2/0x120
[   28.629172][    T1]  ? register_netdevice+0x1bc7/0x2170
[   28.629287][    T1]  ? bond_create+0x138/0x2a0
[   28.629416][    T1]  ? bonding_init+0x1a7/0x2d0
[   28.629523][    T1]  ? do_one_initcall+0x216/0x960
[   28.629638][    T1]  ? do_initcall_level+0x140/0x350
[   28.629749][    T1]  ? do_initcalls+0xf0/0x1d0
[   28.629852][    T1]  ? do_basic_setup+0x22/0x30
[   28.629955][    T1]  ? kernel_init_freeable+0x300/0x4b0
[   28.630064][    T1]  ? kernel_init+0x2f/0x7e0
[   28.630180][    T1]  ? ret_from_fork+0x66/0x80
[   28.630304][    T1]  ? ret_from_fork_asm+0x11/0x20
[   28.630420][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   28.630527][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.630619][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.630710][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.630805][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   28.630913][    T1]  ? filter_irq_stacks+0x60/0x1a0
[   28.631030][    T1]  ? stack_depot_save_flags+0x2c/0x7a0
[   28.631140][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.631239][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.631330][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.631426][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   28.631538][    T1]  __msan_warning+0x96/0x110
[   28.631674][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
[   28.631838][    T1]  stack_depot_save_flags+0x3e2/0x7a0
[   28.631958][    T1]  stack_depot_save+0x12/0x20
[   28.632058][    T1]  ref_tracker_alloc+0x215/0x700
[   28.632169][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.632260][    T1]  ? netdev_hold+0xe2/0x120
[   28.632365][    T1]  ? register_netdevice+0x1bc7/0x2170
[   28.632438][    T1]  ? bond_create+0x138/0x2a0
[   28.632438][    T1]  ? bonding_init+0x1a7/0x2d0
[   28.632438][    T1]  ? do_one_initcall+0x216/0x960
[   28.632438][    T1]  ? do_initcall_level+0x140/0x350
[   28.632900][    T1]  ? do_initcalls+0xf0/0x1d0
[   28.632900][    T1]  ? do_basic_setup+0x22/0x30
[   28.632900][    T1]  ? kernel_init_freeable+0x300/0x4b0
[   28.632900][    T1]  ? kernel_init+0x2f/0x7e0
[   28.632900][    T1]  ? ret_from_fork+0x66/0x80
[   28.632900][    T1]  ? ret_from_fork_asm+0x11/0x20
[   28.632900][    T1]  ? kmsan_internal_unpoison_memory+0x14/0x20
[   28.633734][    T1]  netdev_hold+0xe2/0x120
[   28.633734][    T1]  register_netdevice+0x1bc7/0x2170
[   28.633970][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   28.633970][    T1]  bond_create+0x138/0x2a0
[   28.633970][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   28.633970][    T1]  bonding_init+0x1a7/0x2d0
[   28.633970][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   28.633970][    T1]  do_one_initcall+0x216/0x960
[   28.633970][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   28.634792][    T1]  ? kmsan_get_metadata+0x80/0x1c0
[   28.634802][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   28.634802][    T1]  ? filter_irq_stacks+0x60/0x1a0
[   28.634802][    T1]  ? stack_depot_save_flags+0x2c/0x7a0
[   28.634802][    T1]  ? skip_spaces+0x8f/0xc0
[   28.634802][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.634802][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.634802][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   28.635636][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.635636][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   28.635636][    T1]  ? parse_args+0x1511/0x15e0
[   28.635636][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   28.635636][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   28.635636][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   28.635636][    T1]  do_initcall_level+0x140/0x350
[   28.635636][    T1]  do_initcalls+0xf0/0x1d0
[   28.636461][    T1]  ? arch_cpuhp_init_parallel_bringup+0xe0/0xe0
[   28.636461][    T1]  do_basic_setup+0x22/0x30
[   28.636461][    T1]  kernel_init_freeable+0x300/0x4b0
[   28.636461][    T1]  ? rest_init+0x260/0x260
[   28.636461][    T1]  kernel_init+0x2f/0x7e0
[   28.636461][    T1]  ? rest_init+0x260/0x260
[   28.636461][    T1]  ret_from_fork+0x66/0x80
[   28.637299][    T1]  ? rest_init+0x260/0x260
[   28.637299][    T1]  ret_from_fork_asm+0x11/0x20
[   28.637299][    T1]  </TASK>
[   28.637299][    T1] Kernel Offset: disabled


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
 -ffile-prefix-map=3D/tmp/go-build1437193816=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 9bd8dcda8
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
/syzkaller/prog.GitRevision=3D9bd8dcda8c7c494d59bd3132a668f4784ea835c6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240119-142441'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D9bd8dcda8c7c494d59bd3132a668f4784ea835c6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240119-142441'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D9bd8dcda8c7c494d59bd3132a668f4784ea835c6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240119-142441'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"9bd8dcda8c7c494d59bd3132a668f4784e=
a835c6\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1423a4ac180000


Tested on:

commit:         603c04e2 Merge tag 'parisc-for-6.8-rc6' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd33318d4e4a0d22=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7521c1e3841ed075=
a42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D17a12a301800=
00


