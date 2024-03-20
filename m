Return-Path: <linux-kernel+bounces-108857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5528B8810F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C077C1F24428
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0753FB83;
	Wed, 20 Mar 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I17qBePQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD13FB21
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934217; cv=none; b=BW6BDlHXXiGhaGLi/+4/fFxEzaP4s6537P9IV05jDA9DGTdycdwxadcQ5mVBbcHXe+lkFrQZDS/uHS72k0MW4jVmsEXocTMHagdFVrfwP6s5wW0m0GjG2a+Dn8HUcqr/kN6xeZUaSv6UuT25PgZcYSSYbcxeJ3uF8VxNcDJpdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934217; c=relaxed/simple;
	bh=VWquOK27lG1w00p9rxyIOoVMvJQSuUJXHMbqv++jl1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TS8SB7VP/KV7x9XQ10vxjAMynTIXgZ1+WKXFlRi0b56yOku7s14LL2IcjI5+SQHwHr0IrHGndPGWciM9dv76gQx/5c9psNxae++5F083zEbICjFLVAEnHCGG661+0LVUXAsBwtiRzKYC2M1JLCNIiECCFCo1+1UDYCYsUvRgmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I17qBePQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710934213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+DS7O+uLNXOu+o2xejhG7+ZLipONJDITwt5dOMYlTM=;
	b=I17qBePQIvcE8PkwYgh91hySq+dnGQvV/vL7/lOY0nAduQyBZbQwpvu/r6JaUtyoRQpoXA
	eD3Upw9KKPr6MKShnctdS2wybLd6sj46hbJPJKOWY6jtqwnESiO8bGHLz8O0UWqJrUZeIC
	wjNV3EhuwivbvtAtSfPiiyQBGlAQUIw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-gbWkaORzPNiBKS1sBqXqEA-1; Wed,
 20 Mar 2024 07:30:10 -0400
X-MC-Unique: gbWkaORzPNiBKS1sBqXqEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B3813830083;
	Wed, 20 Mar 2024 11:30:10 +0000 (UTC)
Received: from localhost (unknown [10.39.194.238])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6EB121121337;
	Wed, 20 Mar 2024 11:30:08 +0000 (UTC)
Date: Wed, 20 Mar 2024 07:30:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>,
	jasowang@redhat.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, Paolo Bonzini <pbonzini@redhat.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING:
 refcount bug in __free_pages_ok
Message-ID: <20240320113002.GA1178948@fedora>
References: <000000000000cfd4800613fe79b1@google.com>
 <20240319033941-mutt-send-email-mst@kernel.org>
 <20240319171923.GA1123315@fedora>
 <7a767645-af51-456d-bf7e-e0038ba38871@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/MjWCU5vnQ3+Qgsd"
Content-Disposition: inline
In-Reply-To: <7a767645-af51-456d-bf7e-e0038ba38871@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


--/MjWCU5vnQ3+Qgsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 03:51:18PM -0500, Mike Christie wrote:
> On 3/19/24 12:19 PM, Stefan Hajnoczi wrote:
> > On Tue, Mar 19, 2024 at 03:40:53AM -0400, Michael S. Tsirkin wrote:
> >> On Tue, Mar 19, 2024 at 12:32:26AM -0700, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    b3603fcb79b1 Merge tag 'dlm-6.9' of git://git.kernel.=
org/p..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10f04c811=
80000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfcb5bfbee=
0a42b54
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D70f57d8a3ae=
84934c003
> >>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> >>>
> >>> Downloadable assets:
> >>> disk image: https://storage.googleapis.com/syzbot-assets/43969dffd4a6=
/disk-b3603fcb.raw.xz
> >>> vmlinux: https://storage.googleapis.com/syzbot-assets/ef48ab3b378b/vm=
linux-b3603fcb.xz
> >>> kernel image: https://storage.googleapis.com/syzbot-assets/728f5ff2b6=
fe/bzImage-b3603fcb.xz
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> >>> Reported-by: syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com
> >>>
> >>> Key type pkcs7_test registered
> >>> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
> >>> io scheduler mq-deadline registered
> >>> io scheduler kyber registered
> >>> io scheduler bfq registered
> >>> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> >>> ACPI: button: Power Button [PWRF]
> >>> input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
> >>> ACPI: button: Sleep Button [SLPF]
> >>> ioatdma: Intel(R) QuickData Technology Driver 5.00
> >>> ACPI: \_SB_.LNKC: Enabled at IRQ 11
> >>> virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
> >>> ACPI: \_SB_.LNKD: Enabled at IRQ 10
> >>> virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
> >>> ACPI: \_SB_.LNKB: Enabled at IRQ 10
> >>> virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
> >>> virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
> >>> N_HDLC line discipline registered with maxframe=3D4096
> >>> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> >>> 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 1655=
0A
> >>> 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) is a 1655=
0A
> >>> 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D 115200) is a 1655=
0A
> >>> 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D 115200) is a 1655=
0A
> >>> Non-volatile memory driver v1.3
> >>> Linux agpgart interface v0.103
> >>> ACPI: bus type drm_connector registered
> >>> [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
> >>> [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
> >>> Console: switching to colour frame buffer device 128x48
> >>> platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
> >>> usbcore: registered new interface driver udl
> >>> brd: module loaded
> >>> loop: module loaded
> >>> zram: Added device: zram0
> >>> null_blk: disk nullb0 created
> >>> null_blk: module loaded
> >>> Guest personality initialized and is inactive
> >>> VMCI host device registered (name=3Dvmci, major=3D10, minor=3D118)
> >>> Initialized host personality
> >>> usbcore: registered new interface driver rtsx_usb
> >>> usbcore: registered new interface driver viperboard
> >>> usbcore: registered new interface driver dln2
> >>> usbcore: registered new interface driver pn533_usb
> >>> nfcsim 0.2 initialized
> >>> usbcore: registered new interface driver port100
> >>> usbcore: registered new interface driver nfcmrvl
> >>> Loading iSCSI transport class v2.0-870.
> >>> virtio_scsi virtio0: 1/0/0 default/read/poll queues
> >>> ------------[ cut here ]------------
> >>> refcount_t: decrement hit 0; leaking memory.
> >>> WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0x=
fa/0x1d0 lib/refcount.c:31
> >>> Modules linked in:
> >>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzkaller-11567-gb360=
3fcb79b1 #0
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 02/29/2024
> >>> RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
> >>> Code: b2 00 00 00 e8 57 d4 f2 fc 5b 5d c3 cc cc cc cc e8 4b d4 f2 fc =
c6 05 0c f9 ef 0a 01 90 48 c7 c7 a0 5d 1e 8c e8 b7 75 b5 fc 90 <0f> 0b 90 9=
0 eb d9 e8 2b d4 f2 fc c6 05 e9 f8 ef 0a 01 90 48 c7 c7
> >>> RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
> >>> RAX: 76f86e452fcad900 RBX: ffff8880210d2aec RCX: ffff888016ac8000
> >>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> >>> RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fffffbfff1c396e0
> >>> R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: ffffea000502cdc0
> >>> R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 0000000000000000
> >>> FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:000000000=
0000000
> >>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 00000000003506f0
> >>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>> Call Trace:
> >>>  <TASK>
> >>>  reset_page_owner include/linux/page_owner.h:25 [inline]
> >>>  free_pages_prepare mm/page_alloc.c:1141 [inline]
> >>>  __free_pages_ok+0xc54/0xd80 mm/page_alloc.c:1270
> >>>  make_alloc_exact+0xa3/0xf0 mm/page_alloc.c:4829
> >>>  vring_alloc_queue drivers/virtio/virtio_ring.c:319 [inline]
> >>>  vring_alloc_queue_split+0x20a/0x600 drivers/virtio/virtio_ring.c:1108
> >>>  vring_create_virtqueue_split+0xc6/0x310 drivers/virtio/virtio_ring.c=
:1158
> >>>  vring_create_virtqueue+0xca/0x110 drivers/virtio/virtio_ring.c:2683
> >>>  setup_vq+0xe9/0x2d0 drivers/virtio/virtio_pci_legacy.c:131
> >>>  vp_setup_vq+0xbf/0x330 drivers/virtio/virtio_pci_common.c:189
> >>>  vp_find_vqs_msix+0x8b2/0xc80 drivers/virtio/virtio_pci_common.c:331
> >>>  vp_find_vqs+0x4c/0x4e0 drivers/virtio/virtio_pci_common.c:408
> >>>  virtio_find_vqs include/linux/virtio_config.h:233 [inline]
> >>>  virtscsi_init+0x8db/0xd00 drivers/scsi/virtio_scsi.c:887
> >>>  virtscsi_probe+0x3ea/0xf60 drivers/scsi/virtio_scsi.c:945
> >>>  virtio_dev_probe+0x991/0xaf0 drivers/virtio/virtio.c:311
> >>>  really_probe+0x29e/0xc50 drivers/base/dd.c:658
> >>>  __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
> >>>  driver_probe_device+0x50/0x430 drivers/base/dd.c:830
> >>>  __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
> >>>  bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
> >>>  bus_add_driver+0x347/0x620 drivers/base/bus.c:673
> >>>  driver_register+0x23a/0x320 drivers/base/driver.c:246
> >>>  virtio_scsi_init+0x65/0xe0 drivers/scsi/virtio_scsi.c:1083
> >>>  do_one_initcall+0x248/0x880 init/main.c:1238
> >>>  do_initcall_level+0x157/0x210 init/main.c:1300
> >>>  do_initcalls+0x3f/0x80 init/main.c:1316
> >>>  kernel_init_freeable+0x435/0x5d0 init/main.c:1548
> >>>  kernel_init+0x1d/0x2b0 init/main.c:1437
> >>>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> >>>  </TASK>
> >>>
> >>
> >> I think I saw this already and also with virtio scsi. virtio
> >> core does not seem to be doing anything special here,
> >> Cc virtio scsi maintainers.
> >=20
> > The oldest commit that syzkaller found is a memory management pull
> > request:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/=
?id=3De5eb28f6d1afebed4bb7d740a797d0390bd3a357
> >=20
> > I can't reproduce the issue locally with QEMU 8.2.0 so I don't have a
> > way to bisect.
> >=20
> > I reviewed the virtio_scsi.c git log and there have been few changes
> > over the last several months. I couldn't spot an issue in this patch,
> > but the most likely virtio-scsi commit is:
> >=20
> >   commit 95e7249691f082a5178d4d6f60fcdee91da458ab
> >   Author: Mike Christie <michael.christie@oracle.com>
> >   Date:   Wed Dec 13 23:26:49 2023 -0600
> >=20
> >       scsi: virtio_scsi: Add mq_poll support
> >=20
> > Stefan
>=20
> I also tested the current kernel and didn't hit it.
>=20
> In this mail:
>=20
> https://lore.kernel.org/all/ZfKPf_pGxv-xtSPN@localhost.localdomain/
>=20
> from this thread:
>=20
> https://lore.kernel.org/all/37cb2e7c-97f1-4179-a715-84cc02096083@I-love.S=
AKURA.ne.jp/T/
>=20
> it looks like Oscar is saying he has a fix right?

Yes, here is Oscar's work-in-progress fix:
https://lore.kernel.org/all/20240319183212.17156-1-osalvador@suse.de/

Commit 217b2119b9e2 ("mm,page_owner: implement the tracking of the
stacks count") introduced the issue and it was merged via commit
902861e34c40 ("Merge tag 'mm-stable-2024-03-13-20-04' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm").

To be 100% sure, I'll test the commit in question and its parent:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 4bedfb314bdd85c1662ecc46fa25b33b998f994d

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 217b2119b9e260609958db413876f211038f00ee

Stefan

--/MjWCU5vnQ3+Qgsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX6yLoACgkQnKSrs4Gr
c8g6HQf/YTuhREkOeez+yTdpYkpWdZ64aYtIysjLFZ6BdIFjd/Zc66nGgPQlN65o
7nmt4g/RMWXbiPzYbbX6vqCbJ60xAUIJeTPBBBrqb9IcAlEXGrMwjzA2cem4oSFj
5l2zCZVT2aZzHuor0Y8MbS3OMtVN0NiPlB2hsxZWgQJnALU0ga4XjAirKVsOG+P/
nMVMCWybu+h4TnmtDqNBpliV8AYmxpd/+fMhZvBpEhsR7bW2xUK/jWltrqOkcy87
WI3p2mYxURl3OsxTLFsar2AKXPoHk1GtdcGoi5sJUyKALLhkvM41iUQtoM+CnoFi
syAxgvrKgxy3f+HrEEEBVC0btMmdYA==
=mdxQ
-----END PGP SIGNATURE-----

--/MjWCU5vnQ3+Qgsd--


