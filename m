Return-Path: <linux-kernel+bounces-100367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF9C87965C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13686287778
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB0E7A703;
	Tue, 12 Mar 2024 14:30:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078F28FA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253808; cv=none; b=D0qTooIdtbtgxd4e0KkUBiNIcjYeSuYKZ/fB88FaI4YoE2fvfRAlDv8vlLEx/Fp8ghCSdmzwIYhcByVyBCgtyumG2JB+DwTAHlhI+JquKFar6QHTO9Isx3xMsg5SNfMelhcSxsM3LxojeyREmQpoP6GQsUQ8/ruBJNTlnrNIO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253808; c=relaxed/simple;
	bh=gvbXi7rnDo1RU5QOPzQOsFYn+OkU57g8GjGN0WcBtOY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cf4s4pNXFUnnKJuES4hDUeCtJaDRuUd67o8CKpNnhlHJ7MF/uDJK0Ei68H5QzyzpUF0+2ZNE08wdEJFLYsdpdyfWirDlIB0gXN0aiwW+xS6p+VRSWOwldV1oZ2dZhOyufKR0wnTp68jXrADDSXOIu0FSwLfPR+8r5ohOl1CzPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3662592dc1dso40589865ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710253806; x=1710858606;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIPw/iDvaI+GD0Zw1iS600Mpns2eTf+pilXDei+CxW0=;
        b=vOvzpLbtywG/336BxOb85BNyhTBiXmY3mPIhc+wsmGReyWQ/g3N5DiVstF8qk9u9DS
         GKBzQkyChRRPosJuVxrar/23tR+0e6q5xNWEqXCcD/GzXgwZZJqjQO8rxPAAg5jHTa9D
         97FqJmXGxFXgvIF37L0PaLMpyMRLIX7Q8UdqauFfOZHeGp5oXLvbEdqzapnKwiToBW/r
         OcUwqQqrf+AhJi6K2Q55grjfmS4bc0KhzF86lAaw6sB0EUrJXYta/oxHEyUEt0AfAJ/N
         incILU+b1K+WcL8E6U0HV9XQEecKDR9/97q6b0upd5IOps6JsUbfF4SdzLzP3SvNxl04
         y1ww==
X-Gm-Message-State: AOJu0YzRQp5RFy1siTRb/6U0RsGiKvUS4jCg4hlJ3WldgyV2ttlcIp8g
	cXelXh9+nw9epb1Uar6VwU+dmfYLU/hxef3d9GKyO705KlL75TnVg5p+vyAz3q9oOdrckxoSS+W
	6+Mzom7eM7WeCCpciYRxPS1t2BxOBauf9EUp0mcX1A0DNjv8WxLobApHpBw==
X-Google-Smtp-Source: AGHT+IEUre8zTvyQ7skjcKxxuoDC49aOm0oQVKNC/MGHG4TYdPPXtxy8Pvb/H37TbqHDKRf3tj85va0LAJHiTKiaRMFG27Ow09iD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0c:b0:366:2ce0:cde7 with SMTP id
 s12-20020a056e021a0c00b003662ce0cde7mr521843ild.3.1710253806054; Tue, 12 Mar
 2024 07:30:06 -0700 (PDT)
Date: Tue, 12 Mar 2024 07:30:06 -0700
In-Reply-To: <20240312.225158.1066421875659457320.syoshida@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095ffe20613777eb5@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (2)
From: syzbot <syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syoshida@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

   T1] usbhid: USB HID core driver
[   41.445057][    T1] usbcore: registered new interface driver es2_ap_driv=
er
[   41.452522][    T1] comedi: version 0.7.76 - http://www.comedi.org
[   41.462013][    T1] usbcore: registered new interface driver dt9812
[   41.470508][    T1] usbcore: registered new interface driver ni6501
[   41.478004][    T1] usbcore: registered new interface driver usbdux
[   41.485497][    T1] usbcore: registered new interface driver usbduxfast
[   41.493272][    T1] usbcore: registered new interface driver usbduxsigma
[   41.501230][    T1] usbcore: registered new interface driver vmk80xx
[   41.509250][    T1] usbcore: registered new interface driver prism2_usb
[   41.518077][    T1] usbcore: registered new interface driver r8712u
[   41.525021][    T1] greybus: registered new driver hid
[   41.531212][    T1] greybus: registered new driver gbphy
[   41.537142][    T1] gb_gbphy: registered new driver usb
[   41.542897][    T1] asus_wmi: ASUS WMI generic driver loaded
[   41.738826][    T1] usbcore: registered new interface driver snd-usb-aud=
io
[   41.747671][    T1] usbcore: registered new interface driver snd-ua101
[   41.756259][    T1] usbcore: registered new interface driver snd-usb-usx=
2y
[   41.764396][    T1] usbcore: registered new interface driver snd-usb-us1=
22l
[   41.772587][    T1] usbcore: registered new interface driver snd-usb-cai=
aq
[   41.781306][    T1] usbcore: registered new interface driver snd-usb-6fi=
re
[   41.790406][    T1] usbcore: registered new interface driver snd-usb-hif=
ace
[   41.799287][    T1] usbcore: registered new interface driver snd-bcd2000
[   41.807204][    T1] usbcore: registered new interface driver snd_usb_pod
[   41.815236][    T1] usbcore: registered new interface driver snd_usb_pod=
hd
[   41.823341][    T1] usbcore: registered new interface driver snd_usb_ton=
eport
[   41.831585][    T1] usbcore: registered new interface driver snd_usb_var=
iax
[   41.839634][    T1] drop_monitor: Initializing network drop monitor serv=
ice
[   41.848496][    T1] NET: Registered PF_LLC protocol family
[   41.854636][    T1] GACT probability on
[   41.858817][    T1] Mirror/redirect action on
[   41.863972][    T1] Simple TC action Loaded
[   41.876090][    T1] netem: version 1.3
[   41.880422][    T1] u32 classifier
[   41.884012][    T1]     Performance counters on
[   41.890459][    T1]     input device check on
[   41.895664][    T1]     Actions configured
[   41.921296][    T1] nf_conntrack_irc: failed to register helpers
[   41.928588][    T1] nf_conntrack_sane: failed to register helpers
[   42.073937][    T1] nf_conntrack_sip: failed to register helpers
[   42.090482][    T1] xt_time: kernel timezone is -0000
[   42.096261][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[   42.103352][    T1] IPVS: Connection hash table configured (size=3D4096,=
 memory=3D32Kbytes)
[   42.113694][    T1] IPVS: ipvs loaded.
[   42.117739][    T1] IPVS: [rr] scheduler registered.
[   42.122901][    T1] IPVS: [wrr] scheduler registered.
[   42.128228][    T1] IPVS: [lc] scheduler registered.
[   42.133405][    T1] IPVS: [wlc] scheduler registered.
[   42.138759][    T1] IPVS: [fo] scheduler registered.
[   42.143924][    T1] IPVS: [ovf] scheduler registered.
[   42.149391][    T1] IPVS: [lblc] scheduler registered.
[   42.154820][    T1] IPVS: [lblcr] scheduler registered.
[   42.160239][    T1] IPVS: [dh] scheduler registered.
[   42.165456][    T1] IPVS: [sh] scheduler registered.
[   42.170640][    T1] IPVS: [mh] scheduler registered.
[   42.175915][    T1] IPVS: [sed] scheduler registered.
[   42.181264][    T1] IPVS: [nq] scheduler registered.
[   42.186471][    T1] IPVS: [twos] scheduler registered.
[   42.191914][    T1] IPVS: [sip] pe registered.
[   42.198686][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   42.213107][    T1] gre: GRE over IPv4 demultiplexor driver
[   42.219041][    T1] ip_gre: GRE over IPv4 tunneling driver
[   42.246435][    T1] IPv4 over IPsec tunneling driver
[   42.260657][    T1] Initializing XFRM netlink socket
[   42.268642][    T1] IPsec XFRM device driver
[   42.275059][    T1] NET: Registered PF_INET6 protocol family
[   42.326632][    T1] Segment Routing with IPv6
[   42.331207][    T1] RPL Segment Routing with IPv6
[   42.337084][    T1] In-situ OAM (IOAM) with IPv6
[   42.342955][    T1] mip6: Mobile IPv6
[   42.351543][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   42.351775][    T1] BUG: KMSAN: use-after-free in __list_add_valid_or_re=
port+0xeb/0x2c0
[   42.351917][    T1]  __list_add_valid_or_report+0xeb/0x2c0
[   42.352049][    T1]  stack_depot_save_flags+0x554/0x6a0
[   42.352178][    T1]  stack_depot_save+0x12/0x20
[   42.352283][    T1]  ref_tracker_alloc+0x215/0x700
[   42.352396][    T1]  net_rx_queue_update_kobjects+0x1eb/0xa80
[   42.352510][    T1]  netdev_register_kobject+0x30e/0x530
[   42.352609][    T1]  register_netdevice+0x1995/0x2180
[   42.352703][    T1]  register_netdev+0xa5/0xe0
[   42.352791][    T1]  vti6_init_net+0x3f9/0x6a0
[   42.352910][    T1]  ops_init+0x30c/0x880
[   42.352973][    T1]  register_pernet_operations+0x523/0xa00
[   42.353034][    T1]  register_pernet_device+0x4f/0x180
[   42.353092][    T1]  vti6_tunnel_init+0x34/0x450
[   42.353185][    T1]  do_one_initcall+0x219/0x970
[   42.353263][    T1]  do_initcall_level+0x140/0x350
[   42.353346][    T1]  do_initcalls+0xf0/0x1e0
[   42.353418][    T1]  do_basic_setup+0x22/0x30
[   42.353491][    T1]  kernel_init_freeable+0x30b/0x4c0
[   42.353569][    T1]  kernel_init+0x2f/0x7e0
[   42.353651][    T1]  ret_from_fork+0x6d/0x90
[   42.353723][    T1]  ret_from_fork_asm+0x1a/0x30
[   42.353801][    T1]=20
[   42.353811][    T1] Uninit was created at:
[   42.353928][    T1]  free_unref_page_prepare+0xc1/0xad0
[   42.354016][    T1]  free_unref_page+0x59/0x730
[   42.354119][    T1]  destroy_large_folio+0x12a/0x1d0
[   42.354239][    T1]  __folio_put_large+0x101/0x110
[   42.354353][    T1]  __folio_put+0x153/0x160
[   42.354441][    T1]  free_large_kmalloc+0x167/0x210
[   42.354529][    T1]  kfree+0x4e3/0xa40
[   42.354605][    T1]  kmsan_vmap_pages_range_noflush+0x347/0x3d0
[   42.354702][    T1]  __vmalloc_node_range+0x217c/0x28c0
[   42.354772][    T1]  vmalloc_huge+0x92/0xb0
[   42.354834][    T1]  alloc_large_system_hash+0x459/0xa30
[   42.354904][    T1]  dcache_init+0x125/0x220
[   42.354980][    T1]  vfs_caches_init+0x7c/0xd0
[   42.355056][    T1]  start_kernel+0x8d8/0xa60
[   42.355125][    T1]  x86_64_start_reservations+0x2e/0x30
[   42.355190][    T1]  x86_64_start_kernel+0x98/0xa0
[   42.355280][    T1]  secondary_startup_64_no_verify+0x15f/0x16b
[   42.355364][    T1]=20
[   42.355375][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-01185-g855684c7d938-dirty #0
[   42.355437][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   42.355469][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   42.355485][    T1] Disabling lock debugging due to kernel taint
[   42.355505][    T1] Kernel panic - not syncing: kmsan.panic set ...
[   42.355529][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B       =
       6.8.0-syzkaller-01185-g855684c7d938-dirty #0
[   42.355590][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   42.355621][    T1] Call Trace:
[   42.355640][    T1]  <TASK>
[   42.355659][    T1]  dump_stack_lvl+0x1bf/0x240
[   42.355746][    T1]  dump_stack+0x1e/0x30
[   42.355818][    T1]  panic+0x4e2/0xcc0
[   42.355896][    T1]  ? kmsan_get_metadata+0x121/0x1c0
[   42.355998][    T1]  kmsan_report+0x2d5/0x2e0
[   42.356087][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356181][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   42.356276][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356363][    T1]  ? __msan_warning+0x95/0x110
[   42.356442][    T1]  ? __list_add_valid_or_report+0xeb/0x2c0
[   42.356539][    T1]  ? stack_depot_save_flags+0x554/0x6a0
[   42.356620][    T1]  ? stack_depot_save+0x12/0x20
[   42.356694][    T1]  ? ref_tracker_alloc+0x215/0x700
[   42.356772][    T1]  ? net_rx_queue_update_kobjects+0x1eb/0xa80
[   42.356846][    T1]  ? netdev_register_kobject+0x30e/0x530
[   42.356916][    T1]  ? register_netdevice+0x1995/0x2180
[   42.356973][    T1]  ? register_netdev+0xa5/0xe0
[   42.356973][    T1]  ? vti6_init_net+0x3f9/0x6a0
[   42.356973][    T1]  ? ops_init+0x30c/0x880
[   42.356973][    T1]  ? register_pernet_operations+0x523/0xa00
[   42.356973][    T1]  ? register_pernet_device+0x4f/0x180
[   42.356973][    T1]  ? vti6_tunnel_init+0x34/0x450
[   42.356973][    T1]  ? do_one_initcall+0x219/0x970
[   42.356973][    T1]  ? do_initcall_level+0x140/0x350
[   42.356973][    T1]  ? do_initcalls+0xf0/0x1e0
[   42.356973][    T1]  ? do_basic_setup+0x22/0x30
[   42.356973][    T1]  ? kernel_init_freeable+0x30b/0x4c0
[   42.356973][    T1]  ? kernel_init+0x2f/0x7e0
[   42.356973][    T1]  ? ret_from_fork+0x6d/0x90
[   42.356973][    T1]  ? ret_from_fork_asm+0x1a/0x30
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   42.356973][    T1]  ? _raw_spin_lock_irqsave+0x35/0xc0
[   42.356973][    T1]  ? filter_irq_stacks+0x60/0x1a0
[   42.356973][    T1]  ? stack_depot_save_flags+0x2c/0x6a0
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   42.356973][    T1]  __msan_warning+0x95/0x110
[   42.356973][    T1]  __list_add_valid_or_report+0xeb/0x2c0
[   42.356973][    T1]  stack_depot_save_flags+0x554/0x6a0
[   42.356973][    T1]  stack_depot_save+0x12/0x20
[   42.356973][    T1]  ref_tracker_alloc+0x215/0x700
[   42.356973][    T1]  ? dev_uevent_filter+0x53/0x110
[   42.356973][    T1]  ? net_rx_queue_update_kobjects+0x1eb/0xa80
[   42.356973][    T1]  ? netdev_register_kobject+0x30e/0x530
[   42.356973][    T1]  ? register_netdevice+0x1995/0x2180
[   42.356973][    T1]  ? register_netdev+0xa5/0xe0
[   42.356973][    T1]  ? vti6_init_net+0x3f9/0x6a0
[   42.356973][    T1]  ? ops_init+0x30c/0x880
[   42.356973][    T1]  ? register_pernet_operations+0x523/0xa00
[   42.356973][    T1]  ? register_pernet_device+0x4f/0x180
[   42.356973][    T1]  ? vti6_tunnel_init+0x34/0x450
[   42.356973][    T1]  ? do_one_initcall+0x219/0x970
[   42.356973][    T1]  ? do_initcall_level+0x140/0x350
[   42.356973][    T1]  ? do_initcalls+0xf0/0x1e0
[   42.356973][    T1]  ? do_basic_setup+0x22/0x30
[   42.356973][    T1]  ? kernel_init_freeable+0x30b/0x4c0
[   42.356973][    T1]  ? kernel_init+0x2f/0x7e0
[   42.356973][    T1]  ? ret_from_fork+0x6d/0x90
[   42.356973][    T1]  net_rx_queue_update_kobjects+0x1eb/0xa80
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  netdev_register_kobject+0x30e/0x530
[   42.356973][    T1]  register_netdevice+0x1995/0x2180
[   42.356973][    T1]  register_netdev+0xa5/0xe0
[   42.356973][    T1]  vti6_init_net+0x3f9/0x6a0
[   42.356973][    T1]  ? __pfx_vti6_init_net+0x10/0x10
[   42.356973][    T1]  ops_init+0x30c/0x880
[   42.356973][    T1]  register_pernet_operations+0x523/0xa00
[   42.356973][    T1]  register_pernet_device+0x4f/0x180
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  vti6_tunnel_init+0x34/0x450
[   42.356973][    T1]  ? __pfx_vti6_tunnel_init+0x10/0x10
[   42.356973][    T1]  do_one_initcall+0x219/0x970
[   42.356973][    T1]  ? __pfx_vti6_tunnel_init+0x10/0x10
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   42.356973][    T1]  ? filter_irq_stacks+0x164/0x1a0
[   42.356973][    T1]  ? stack_depot_save_flags+0x2c/0x6a0
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   42.356973][    T1]  ? parse_args+0x152c/0x1600
[   42.356973][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   42.356973][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   42.356973][    T1]  ? __pfx_vti6_tunnel_init+0x10/0x10
[   42.356973][    T1]  do_initcall_level+0x140/0x350
[   42.356973][    T1]  do_initcalls+0xf0/0x1e0
[   42.356973][    T1]  ? __pfx_native_smp_prepare_cpus+0x10/0x10
[   42.356973][    T1]  do_basic_setup+0x22/0x30
[   42.356973][    T1]  kernel_init_freeable+0x30b/0x4c0
[   42.356973][    T1]  ? __pfx_kernel_init+0x10/0x10
[   42.356973][    T1]  kernel_init+0x2f/0x7e0
[   42.356973][    T1]  ? __pfx_kernel_init+0x10/0x10
[   42.356973][    T1]  ret_from_fork+0x6d/0x90
[   42.356973][    T1]  ? __pfx_kernel_init+0x10/0x10
[   42.356973][    T1]  ret_from_fork_asm+0x1a/0x30
[   42.356973][    T1]  </TASK>
[   42.356973][    T1] Kernel Offset: disabled


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
 -ffile-prefix-map=3D/tmp/go-build2225259581=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at b438bd66d
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
/syzkaller/prog.GitRevision=3Db438bd66d6f95113d52f25c25bfef0e963c8ce8d -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240109-174804'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Db438bd66d6f95113d52f25c25bfef0e963c8ce8d -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240109-174804'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Db438bd66d6f95113d52f25c25bfef0e963c8ce8d -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240109-174804'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"b438bd66d6f95113d52f25c25bfef0e963=
c8ce8d\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D136675fa180000


Tested on:

commit:         855684c7 Merge tag 'x86_tdx_for_6.9' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6b3a9c97e8057f2=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D2ef3a8ce8e91b5a50=
098
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D139516461800=
00


