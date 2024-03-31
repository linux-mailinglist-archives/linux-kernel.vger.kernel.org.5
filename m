Return-Path: <linux-kernel+bounces-126371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFA08935E1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 22:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F251F2268F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702A147C86;
	Sun, 31 Mar 2024 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ooi7ov2Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF926AE1
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711917030; cv=none; b=Bx7Ck0HhsGht78zNgJN8R0B6IPH2Vm/0xWfLmFEDcGQf0esdRUlOOhaP6CJfMydqK6Dv5JT7dFyzXODz4VmepPVdp9+htLAijsk/VQ8ZIYzQesY85FtmjYdty1q1eF+PzPE81X1BhK587pB2rIXFv/70E3DMxVTbTHQ/NcAc3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711917030; c=relaxed/simple;
	bh=zKeTMexv2M9gZTFL99lSfrRPEl4ZwfNguWU3Tzt2U7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em+SkdX2LoHdGAkR6x5uPNZIcpc+n2s4tUM6f9xTHKv34GbA5AhV6spPhRbBMxrwofNKk1HFVE0TRwtWdRD6cFWnN5S43lX3LndQNcU6ljwnIJ6abM3NqjNDW1E4ZVbsvWB5MHFt/OaOP4Mr1xk6PFXPjvJUXABdrd7cjEiLIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ooi7ov2Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711917027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YS9a3ltUP9MHJSlPOoblUJDC1YtE0AudZuifCNAqSJM=;
	b=Ooi7ov2Zj4zPDNu0MNEjiR2tSO7LTDo7qVa+3HLleodJGF7Dm0EO/hOb4nT828rTLzMSfY
	0C1rqDDmO5CbOclYnQ2Wn5sVCAKWh58XRkxSQg616p7xg6qxkg3Y5zT0bwofpthWakIt6S
	gNjYqy4IOhgGbg23kW0f0P1vzgi12us=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-OYb6yxPBNvawxkdfodr33g-1; Sun, 31 Mar 2024 16:30:26 -0400
X-MC-Unique: OYb6yxPBNvawxkdfodr33g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5689f41cf4dso2948112a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 13:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711917025; x=1712521825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS9a3ltUP9MHJSlPOoblUJDC1YtE0AudZuifCNAqSJM=;
        b=cw/gkSfQfFGCLxbbbyXcrqE6WZPyC/yYF3KCN8tFYHzmOnf2JMhuxcfQyz0ImARUjY
         u1JqYWUD0Pm5pyQ1orWDH5Qj13Zo08Jyr/o1Z2VzJxP+LK+kMsE/8gLi8iutZS0xaQpR
         lwicx5DFQDxjPwUeKMMS/pSRTjAYekHv9RkswkIGaigIKaZDHSqdyPkOhc2TYitGK3vm
         2iz3ZPNx3wtdRnv73f7+0RQlaqSaW9aPPYN3bB+9CrWoUfxV9F/W8TPhxG7O+7Cd5C+Q
         GX2qXq2I6aaw38r3L3ae64nClzKr0L/NeNrILE0jZsOhGRYsm9rKg+OeiTlgHp+7of5h
         bMKA==
X-Forwarded-Encrypted: i=1; AJvYcCUANFrJN9N66bW8yVkDzs8MhJf7xXsx6DqRmIctJd77l+f4SbagD2wlU3ZJHFRc9m11lXrXOh2Af0Vc/0ABUSrU+au3eJyFUi/ZpfTL
X-Gm-Message-State: AOJu0Yzo467Uw0zvc3M+H/BfKKX15Nzloifdt/rBkrdB+L29723unB0s
	bnjnG9jC/E5ThxReM5RcsbFvr1qRUqgz3R7nxb3IiTKk2s/3UCDrYc192uk+mDtd4iXBX8gxyjM
	R2p2kYU0OC5XCZUDrbrBUqJmplB0vbY98wQAxo/Sb0Fplumkt54DepP8Z0w02cw==
X-Received: by 2002:a50:8d07:0:b0:56c:17be:5b03 with SMTP id s7-20020a508d07000000b0056c17be5b03mr5781237eds.36.1711917024843;
        Sun, 31 Mar 2024 13:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsaZkRJsBtE3C/KRuI5NnqdY65rPDdd/YOopmOpx1kVws7xNKoe8KhbCY/E8xsXpyk75bzxw==
X-Received: by 2002:a50:8d07:0:b0:56c:17be:5b03 with SMTP id s7-20020a508d07000000b0056c17be5b03mr5781222eds.36.1711917024296;
        Sun, 31 Mar 2024 13:30:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:9c27:9486:684f:de6:8ab8])
        by smtp.gmail.com with ESMTPSA id bf18-20020a0564021a5200b0056bd13ce50esm4752138edb.44.2024.03.31.13.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 13:30:23 -0700 (PDT)
Date: Sun, 31 Mar 2024 16:30:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+689655a7402cc18ace0a@syzkaller.appspotmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virtualization?] bpf boot error: WARNING: refcount bug
 in __free_pages_ok
Message-ID: <20240331162212-mutt-send-email-mst@kernel.org>
References: <0000000000002aea130614e28812@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002aea130614e28812@google.com>

On Sat, Mar 30, 2024 at 08:37:19AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6dae957c8eef bpf: fix possible file descriptor leaks in ve..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ec025e180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7b667bc37450fdcd
> dashboard link: https://syzkaller.appspot.com/bug?extid=689655a7402cc18ace0a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/94b03853b65f/disk-6dae957c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7375c1b6b108/vmlinux-6dae957c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/126013ac11e1/bzImage-6dae957c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+689655a7402cc18ace0a@syzkaller.appspotmail.com
> 
> Key type pkcs7_test registered
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
> io scheduler mq-deadline registered
> io scheduler kyber registered
> io scheduler bfq registered
> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> ACPI: button: Power Button [PWRF]
> input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
> ACPI: button: Sleep Button [SLPF]
> ioatdma: Intel(R) QuickData Technology Driver 5.00
> ACPI: \_SB_.LNKC: Enabled at IRQ 11
> virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
> ACPI: \_SB_.LNKD: Enabled at IRQ 10
> virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
> ACPI: \_SB_.LNKB: Enabled at IRQ 10
> virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
> virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
> N_HDLC line discipline registered with maxframe=4096
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
> 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
> Non-volatile memory driver v1.3
> Linux agpgart interface v0.103
> ACPI: bus type drm_connector registered
> [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
> [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
> Console: switching to colour frame buffer device 128x48
> platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
> usbcore: registered new interface driver udl
> brd: module loaded
> loop: module loaded
> zram: Added device: zram0
> null_blk: disk nullb0 created
> null_blk: module loaded
> Guest personality initialized and is inactive
> VMCI host device registered (name=vmci, major=10, minor=118)
> Initialized host personality
> usbcore: registered new interface driver rtsx_usb
> usbcore: registered new interface driver viperboard
> usbcore: registered new interface driver dln2
> usbcore: registered new interface driver pn533_usb
> nfcsim 0.2 initialized
> usbcore: registered new interface driver port100
> usbcore: registered new interface driver nfcmrvl
> Loading iSCSI transport class v2.0-870.
> virtio_scsi virtio0: 1/0/0 default/read/poll queues
> ------------[ cut here ]------------
> refcount_t: decrement hit 0; leaking memory.
> WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-syzkaller-00160-g6dae957c8eef #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
> Code: b2 00 00 00 e8 97 cf e9 fc 5b 5d c3 cc cc cc cc e8 8b cf e9 fc c6 05 8e 73 e8 0a 01 90 48 c7 c7 e0 33 1f 8c e8 c7 6b ac fc 90 <0f> 0b 90 90 eb d9 e8 6b cf e9 fc c6 05 6b 73 e8 0a 01 90 48 c7 c7
> RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
> RAX: eee901a1fb7e2300 RBX: ffff888146687e7c RCX: ffff8880166d0000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000004 R08: ffffffff815800c2 R09: fffffbfff1c396e0
> R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: ffffea000502edc0
> R13: ffffea000502edc8 R14: 1ffffd4000a05db9 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000000e132000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1141 [inline]
>  __free_pages_ok+0xc60/0xd90 mm/page_alloc.c:1270
>  make_alloc_exact+0xa3/0xf0 mm/page_alloc.c:4829
>  vring_alloc_queue drivers/virtio/virtio_ring.c:319 [inline]
>  vring_alloc_queue_split+0x20a/0x600 drivers/virtio/virtio_ring.c:1108
>  vring_create_virtqueue_split+0xc6/0x310 drivers/virtio/virtio_ring.c:1158
>  vring_create_virtqueue+0xca/0x110 drivers/virtio/virtio_ring.c:2683
>  setup_vq+0xe9/0x2d0 drivers/virtio/virtio_pci_legacy.c:131
>  vp_setup_vq+0xbf/0x330 drivers/virtio/virtio_pci_common.c:189
>  vp_find_vqs_msix+0x8b2/0xc80 drivers/virtio/virtio_pci_common.c:331
>  vp_find_vqs+0x4c/0x4e0 drivers/virtio/virtio_pci_common.c:408
>  virtio_find_vqs include/linux/virtio_config.h:233 [inline]
>  virtscsi_init+0x8db/0xd00 drivers/scsi/virtio_scsi.c:887
>  virtscsi_probe+0x3ea/0xf60 drivers/scsi/virtio_scsi.c:945
>  virtio_dev_probe+0x991/0xaf0 drivers/virtio/virtio.c:311
>  really_probe+0x2b8/0xad0 drivers/base/dd.c:656
>  __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
>  driver_probe_device+0x50/0x430 drivers/base/dd.c:828
>  __driver_attach+0x45f/0x710 drivers/base/dd.c:1214
>  bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
>  bus_add_driver+0x347/0x620 drivers/base/bus.c:673
>  driver_register+0x23a/0x320 drivers/base/driver.c:246
>  virtio_scsi_init+0x65/0xe0 drivers/scsi/virtio_scsi.c:1083
>  do_one_initcall+0x248/0x880 init/main.c:1238
>  do_initcall_level+0x157/0x210 init/main.c:1300
>  do_initcalls+0x3f/0x80 init/main.c:1316
>  kernel_init_freeable+0x435/0x5d0 init/main.c:1548
>  kernel_init+0x1d/0x2b0 init/main.c:1437
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>

We keep seeing this report and I'm stumped.
Jason any idea?

> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


