Return-Path: <linux-kernel+bounces-70838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF62859D10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A921C20DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FA820DC3;
	Mon, 19 Feb 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIRJ2bIl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AF20B11
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328131; cv=none; b=YxbGSvmzOvzV+9B6u5K3zqkYykThyO5RPphRgMznJsAFNktAhrh2oXambjQnNtgTDjpMXp/rzYRQlGRkGzhiTy5DJJCwVRDYYgzb8YqjGNr3pQfVlHkbGNEJUBltJwVzcog5KCovPssNLonmUarFEJJviaOUdB/1VRxhPqczees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328131; c=relaxed/simple;
	bh=G7HLOrYngo8q4BEnvRRH2ahhz3DfOF7qDbhuFedVurs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWypNyIAsUIieShNOlG5wt9s6xtQhMq6jdteVDa3WIbRNahcgQWYvUxQkWz/h2bYTgJL8kKngowGyTjzInEUbrDgX28e99McByVl5rf/QyjquCal5E/ZaqRfFGhP/4jPwbhcb1swAwNDScxgn93s9OcWh22DWj5+QzgEg3RQKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIRJ2bIl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708328129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bl9XnWl1XVxx3txJT849rP5bjpqGNtkwrTydDeqJ91Y=;
	b=QIRJ2bIlIwz6rCJqtEQ926gUCr68+kiJlGOiX2H65XcSpw+2Ra65IV/KRalIp3KrV1dvXI
	OwPYkwBVuN251n5g1yuPWilaLTT8akkfCraWJueayyONSBOa9sM5riHWBc/eGXdpxGq+yD
	be2USSxaVxJmG6IAlZ+WBfs9Wh4ZCSo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-O_pKKx-7PQmYfbHND62Nfw-1; Mon, 19 Feb 2024 02:35:26 -0500
X-MC-Unique: O_pKKx-7PQmYfbHND62Nfw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41082621642so22394915e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708328125; x=1708932925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bl9XnWl1XVxx3txJT849rP5bjpqGNtkwrTydDeqJ91Y=;
        b=czBk2eZMxb12jeaqoH6KrU2osqG58KjIfSNSRiyTmuSAKCJgXCcFBT+shwV5FGWsq+
         44EHzCGBo9I71AkPX7WqnMTobEFaxVdmcTgIoAqU+Y9EcBhVz4Vh+hsawUJjchWeKYpb
         ssbsJl06mw9waK3nXoukVcosdAUA/FtWNCazdI5ZMvISMbB5W+e1TKOhccUkVJO6DWKd
         ksdQeRHZNv0Y5Rn3vHUmuDYU2GJx7wgjF485H8t8n1BpnQqmuzvtEMgxEMp8M1CW7TkA
         33ygj4PFVDnAZo4vz3aVdcVlzZYKdh23BXuTbi5kFnaux/iKduT62b1eCwjnVwpgCfLT
         Xq9w==
X-Forwarded-Encrypted: i=1; AJvYcCWyLXK/t7Fe3Lx8mrmdw9PaqB6RiQ6h1qXARW9jPE9h6OtW/EJlxSnfvsoj6B9qFk/Jhhz4PbIJ6xAKug2jgVGpgRy4BDZT4cx4pBci
X-Gm-Message-State: AOJu0YwqfrzJHwWOtdKeO1VRpCXrhF8ultMPP6XIxr+ZW/wl+Ec4O+7P
	M6E3rnupiw2jx9HYm6iwYgDAa8uS3FA9S8qv4glJ784aJLPrweoGjB8/NHiiRlNe2xkkuLsXQsQ
	S7KUx2gv2b3vd343dLEQriLJIjiazBTq/hs55ZoW1Yoy9i8osfgSxjmPfWyqCaA==
X-Received: by 2002:a05:600c:3788:b0:410:c148:2a4b with SMTP id o8-20020a05600c378800b00410c1482a4bmr9613531wmr.37.1708328125158;
        Sun, 18 Feb 2024 23:35:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfOWPFrTaQjiUUO0BsYoZHbxf9g5FgMEc6KPGmDU1RfUXTi6ysJf8vefAhkzBbQMN4SRDoPQ==
X-Received: by 2002:a05:600c:3788:b0:410:c148:2a4b with SMTP id o8-20020a05600c378800b00410c1482a4bmr9613516wmr.37.1708328124746;
        Sun, 18 Feb 2024 23:35:24 -0800 (PST)
Received: from redhat.com ([2.52.19.211])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc40a000000b004101f27737asm10397510wmi.29.2024.02.18.23.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 23:35:23 -0800 (PST)
Date: Mon, 19 Feb 2024 02:35:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+6f3c38e8a6a0297caa5a@syzkaller.appspotmail.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, sfr@canb.auug.org.au,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [syzbot] [virtualization?] linux-next boot error: WARNING:
 refcount bug in __free_pages_ok
Message-ID: <20240219022853-mutt-send-email-mst@kernel.org>
References: <000000000000d305050611b50d09@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d305050611b50d09@google.com>

On Sun, Feb 18, 2024 at 09:06:18PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d37e1e4c52bc Add linux-next specific files for 20240216
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=171ca652180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4bc446d42a7d56c0
> dashboard link: https://syzkaller.appspot.com/bug?extid=6f3c38e8a6a0297caa5a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/14d0894504b9/disk-d37e1e4c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6cda61e084ee/vmlinux-d37e1e4c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/720c85283c05/bzImage-d37e1e4c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6f3c38e8a6a0297caa5a@syzkaller.appspotmail.com
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
> WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-next-20240216-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
> Code: b2 00 00 00 e8 b7 94 f0 fc 5b 5d c3 cc cc cc cc e8 ab 94 f0 fc c6 05 c6 16 ce 0a 01 90 48 c7 c7 a0 5a fe 8b e8 67 69 b4 fc 90 <0f> 0b 90 90 eb d9 e8 8b 94 f0 fc c6 05 a3 16 ce 0a 01 90 48 c7 c7
> RSP: 0000:ffffc90000066e10 EFLAGS: 00010246
> RAX: 15c2c224c9b50400 RBX: ffff888020827d2c RCX: ffff8880162d8000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000004 R08: ffffffff8157b942 R09: fffffbfff1bf95cc
> R10: dffffc0000000000 R11: fffffbfff1bf95cc R12: ffffea000502fdc0
> R13: ffffea000502fdc8 R14: 1ffffd4000a05fb9 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1140 [inline]
>  __free_pages_ok+0xc42/0xd70 mm/page_alloc.c:1269
>  make_alloc_exact+0xc4/0x140 mm/page_alloc.c:4847
>  vring_alloc_queue drivers/virtio/virtio_ring.c:319 [inline]

Wow this seems to be breakage deep in mm/ - all virtio does is
call alloc_pages_exact and that corrupts the refcounts?


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
>  really_probe+0x29e/0xc50 drivers/base/dd.c:658
>  __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
>  driver_probe_device+0x50/0x430 drivers/base/dd.c:830
>  __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
>  bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
>  bus_add_driver+0x347/0x620 drivers/base/bus.c:673
>  driver_register+0x23a/0x320 drivers/base/driver.c:246
>  virtio_scsi_init+0x65/0xe0 drivers/scsi/virtio_scsi.c:1083
>  do_one_initcall+0x238/0x830 init/main.c:1233
>  do_initcall_level+0x157/0x210 init/main.c:1295
>  do_initcalls+0x3f/0x80 init/main.c:1311
>  kernel_init_freeable+0x435/0x5d0 init/main.c:1543
>  kernel_init+0x1d/0x2b0 init/main.c:1432
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>
> 
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


