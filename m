Return-Path: <linux-kernel+bounces-107941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88988803D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339851F23623
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513AB2375B;
	Tue, 19 Mar 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdVmHkzA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA0208D4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870443; cv=none; b=K2gF5HCS7jwTiapXD2y89vQPQINfVdqTT06ZRN7pl79lIknWYh654yPiTL8LGMR+h/U/Fg8K5skPtKYcF+nFK8gV4vLt2MQICrnfi+xo7iQzSq7JrX2HcPpQKt/UBzjbVRakbuCtdfyix15vY+xq7MAPU/EqE7CEoaTE81Zrbz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870443; c=relaxed/simple;
	bh=Mqo/nadr4sUvK89Vf2FC/QM23gUrvZFQrdTQSn41oow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXMbfOJxF0PZJzQpu5zozFXf1gU0cnODKoliK8DV4jheCTEmSdZCdU02ItjZ5jTpDPYQnb13/yKf2sG50ZHaKC4cju7R+Irn9BWHWm4tcdU44BahXGplhzDE33vaOBfnc5ZA4Bt4y4L99hb1NtiFJMrY5ojv5cdHceWo2gKzL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdVmHkzA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710870439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+rmrga3JuFoaVfJ7QmbCDlcqIAWeeR7wyKeXaNczDs=;
	b=hdVmHkzA+coBEnFN2SIW3KU7SL+NdeM71sxwvi+YAfrPKo7yb9ysb/1CK4m00oWJ/qKAp7
	PoduCrbV/pXcindozOzZKa4FMRNFrcsE6KED1A2zJK1b4knEmIn+OTC/WoQCiBI8h+UdcJ
	rLT/LwLcm0mFG3NsWeTkvpP8shWF6WU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-NxRyoD9UMf6CDHPhbnjW8g-1; Tue, 19 Mar 2024 13:47:18 -0400
X-MC-Unique: NxRyoD9UMf6CDHPhbnjW8g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3418f237c0bso258949f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870437; x=1711475237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+rmrga3JuFoaVfJ7QmbCDlcqIAWeeR7wyKeXaNczDs=;
        b=ekp8H7VZJ4Bi4fi8g7unzjWbYry1x949k/6e+uglSMU/anuUCqMxwNtLbyt98zsDsd
         LYWvLuu5U2j81MBNDlJ+Fj9wcTpBgRQy6kmVGuGFOtOiFEyz60RQQIMHdaYOGq58Otsh
         /JWFcAe8+4KtXx3MmgMnDgZIxYDZp4tCgA8i+kdAQmvYdaIoyv/lTLxfFLIGvxvwXVHg
         TunfxYyViplnd+5QNMMMH5+V/A3tu41ZYvXXDS5+DDDZZbfXu/2i0HnAzLo+388OMXz5
         egZZkn971mfkRClKMIwB243qm8VrvdL14Gi1c/9lrYC5nM7lTEAHld8P1q9AjjzFZgo7
         8XDg==
X-Forwarded-Encrypted: i=1; AJvYcCWE4nTNOz3CPRa0zsXPBeIfJ6F+oewEAg1PJ/BC5N3oDu8Wcr5HcuBW8lu35/SAl5LLLjIvsSh/E72yJbXHYvA5w1CZwdudj0fx/TU6
X-Gm-Message-State: AOJu0YwIxVRXVwZoy68r2ZryCt6aUms8u6FvxToqai67lSmQJI2evile
	i3is+h1jhj7ApaNs/DNmH/jjwVSxSHiv1z2LtBG+KwaBStbXtG9jYOBIeOihDd+vTYwi3SGQmDz
	OZdCSe0oHYQpMvhRCs6cr3HvFtdaR2m3D10dotbLCP0S2M1he3LmATziZH9bs+A==
X-Received: by 2002:adf:f789:0:b0:341:6725:c966 with SMTP id q9-20020adff789000000b003416725c966mr5282249wrp.3.1710870436588;
        Tue, 19 Mar 2024 10:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIRHHLuGfA1Rmiu6n5bxnmm4C/aw8tOQx0KDK6rdYg3AKMtcNQet7PZLbBzQ79wtwjFwqvVg==
X-Received: by 2002:adf:f789:0:b0:341:6725:c966 with SMTP id q9-20020adff789000000b003416725c966mr5282234wrp.3.1710870436057;
        Tue, 19 Mar 2024 10:47:16 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id v18-20020adfe4d2000000b0033ec9936909sm12795811wrm.39.2024.03.19.10.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:47:15 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:47:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>,
	jasowang@redhat.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, Paolo Bonzini <pbonzini@redhat.com>,
	Mike Christie <michael.christie@oracle.com>
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING:
 refcount bug in __free_pages_ok
Message-ID: <20240319134625-mutt-send-email-mst@kernel.org>
References: <000000000000cfd4800613fe79b1@google.com>
 <20240319033941-mutt-send-email-mst@kernel.org>
 <20240319171923.GA1123315@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319171923.GA1123315@fedora>

On Tue, Mar 19, 2024 at 01:19:23PM -0400, Stefan Hajnoczi wrote:
> On Tue, Mar 19, 2024 at 03:40:53AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Mar 19, 2024 at 12:32:26AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    b3603fcb79b1 Merge tag 'dlm-6.9' of git://git.kernel.org/p..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10f04c81180000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=fcb5bfbee0a42b54
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=70f57d8a3ae84934c003
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/43969dffd4a6/disk-b3603fcb.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/ef48ab3b378b/vmlinux-b3603fcb.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/728f5ff2b6fe/bzImage-b3603fcb.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com
> > > 
> > > Key type pkcs7_test registered
> > > Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
> > > io scheduler mq-deadline registered
> > > io scheduler kyber registered
> > > io scheduler bfq registered
> > > input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> > > ACPI: button: Power Button [PWRF]
> > > input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
> > > ACPI: button: Sleep Button [SLPF]
> > > ioatdma: Intel(R) QuickData Technology Driver 5.00
> > > ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > > virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
> > > ACPI: \_SB_.LNKD: Enabled at IRQ 10
> > > virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
> > > ACPI: \_SB_.LNKB: Enabled at IRQ 10
> > > virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
> > > virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
> > > N_HDLC line discipline registered with maxframe=4096
> > > Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > > 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> > > 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> > > 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
> > > 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
> > > Non-volatile memory driver v1.3
> > > Linux agpgart interface v0.103
> > > ACPI: bus type drm_connector registered
> > > [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
> > > [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
> > > Console: switching to colour frame buffer device 128x48
> > > platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
> > > usbcore: registered new interface driver udl
> > > brd: module loaded
> > > loop: module loaded
> > > zram: Added device: zram0
> > > null_blk: disk nullb0 created
> > > null_blk: module loaded
> > > Guest personality initialized and is inactive
> > > VMCI host device registered (name=vmci, major=10, minor=118)
> > > Initialized host personality
> > > usbcore: registered new interface driver rtsx_usb
> > > usbcore: registered new interface driver viperboard
> > > usbcore: registered new interface driver dln2
> > > usbcore: registered new interface driver pn533_usb
> > > nfcsim 0.2 initialized
> > > usbcore: registered new interface driver port100
> > > usbcore: registered new interface driver nfcmrvl
> > > Loading iSCSI transport class v2.0-870.
> > > virtio_scsi virtio0: 1/0/0 default/read/poll queues
> > > ------------[ cut here ]------------
> > > refcount_t: decrement hit 0; leaking memory.
> > > WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
> > > Modules linked in:
> > > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzkaller-11567-gb3603fcb79b1 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> > > RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
> > > Code: b2 00 00 00 e8 57 d4 f2 fc 5b 5d c3 cc cc cc cc e8 4b d4 f2 fc c6 05 0c f9 ef 0a 01 90 48 c7 c7 a0 5d 1e 8c e8 b7 75 b5 fc 90 <0f> 0b 90 90 eb d9 e8 2b d4 f2 fc c6 05 e9 f8 ef 0a 01 90 48 c7 c7
> > > RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
> > > RAX: 76f86e452fcad900 RBX: ffff8880210d2aec RCX: ffff888016ac8000
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fffffbfff1c396e0
> > > R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: ffffea000502cdc0
> > > R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 0000000000000000
> > > FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  reset_page_owner include/linux/page_owner.h:25 [inline]
> > >  free_pages_prepare mm/page_alloc.c:1141 [inline]
> > >  __free_pages_ok+0xc54/0xd80 mm/page_alloc.c:1270
> > >  make_alloc_exact+0xa3/0xf0 mm/page_alloc.c:4829
> > >  vring_alloc_queue drivers/virtio/virtio_ring.c:319 [inline]
> > >  vring_alloc_queue_split+0x20a/0x600 drivers/virtio/virtio_ring.c:1108
> > >  vring_create_virtqueue_split+0xc6/0x310 drivers/virtio/virtio_ring.c:1158
> > >  vring_create_virtqueue+0xca/0x110 drivers/virtio/virtio_ring.c:2683
> > >  setup_vq+0xe9/0x2d0 drivers/virtio/virtio_pci_legacy.c:131
> > >  vp_setup_vq+0xbf/0x330 drivers/virtio/virtio_pci_common.c:189
> > >  vp_find_vqs_msix+0x8b2/0xc80 drivers/virtio/virtio_pci_common.c:331
> > >  vp_find_vqs+0x4c/0x4e0 drivers/virtio/virtio_pci_common.c:408
> > >  virtio_find_vqs include/linux/virtio_config.h:233 [inline]
> > >  virtscsi_init+0x8db/0xd00 drivers/scsi/virtio_scsi.c:887
> > >  virtscsi_probe+0x3ea/0xf60 drivers/scsi/virtio_scsi.c:945
> > >  virtio_dev_probe+0x991/0xaf0 drivers/virtio/virtio.c:311
> > >  really_probe+0x29e/0xc50 drivers/base/dd.c:658
> > >  __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
> > >  driver_probe_device+0x50/0x430 drivers/base/dd.c:830
> > >  __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
> > >  bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
> > >  bus_add_driver+0x347/0x620 drivers/base/bus.c:673
> > >  driver_register+0x23a/0x320 drivers/base/driver.c:246
> > >  virtio_scsi_init+0x65/0xe0 drivers/scsi/virtio_scsi.c:1083
> > >  do_one_initcall+0x248/0x880 init/main.c:1238
> > >  do_initcall_level+0x157/0x210 init/main.c:1300
> > >  do_initcalls+0x3f/0x80 init/main.c:1316
> > >  kernel_init_freeable+0x435/0x5d0 init/main.c:1548
> > >  kernel_init+0x1d/0x2b0 init/main.c:1437
> > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> > >  </TASK>
> > > 
> > 
> > I think I saw this already and also with virtio scsi. virtio
> > core does not seem to be doing anything special here,
> > Cc virtio scsi maintainers.
> 
> The oldest commit that syzkaller found is a memory management pull
> request:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=e5eb28f6d1afebed4bb7d740a797d0390bd3a357
> 
> I can't reproduce the issue locally with QEMU 8.2.0 so I don't have a
> way to bisect.
> 
> I reviewed the virtio_scsi.c git log and there have been few changes
> over the last several months. I couldn't spot an issue in this patch,
> but the most likely virtio-scsi commit is:
> 
>   commit 95e7249691f082a5178d4d6f60fcdee91da458ab
>   Author: Mike Christie <michael.christie@oracle.com>
>   Date:   Wed Dec 13 23:26:49 2023 -0600
> 
>       scsi: virtio_scsi: Add mq_poll support
> 
> Stefan


Send a revert and ask syzbot to test it then?

> > 
> > 
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > 
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > 
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > > 
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > > 
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > > 
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> > 



