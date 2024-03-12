Return-Path: <linux-kernel+bounces-100399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173A8796EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC694B225D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54277BAE6;
	Tue, 12 Mar 2024 14:53:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5E7B3E9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255185; cv=none; b=Cm7NZRvJtBLLZGqP09ZzWdycrZWGEQH3wdZXQhwqB5CGxd4MkGWidZVKUdh4nqa80lOFUKD02hWBRfyC9xcjY6vdVd/6S/LFj8HaijxHufKJDsX+N/cnOIb8EwBWhr0L2r2hjYlkQSkqP5Ttv2l1JNu51t2qesnU7boUWaRJ4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255185; c=relaxed/simple;
	bh=3BDs1kftJKvMzQdg8BphaZenNHn9/u9N4kazx8dVKSM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tfs6+XQV0FuDoSsjVcBZ+7U/CsxisyK5DegHT8QH8UtcdjoyWSpWTHYx4Dqtv/39qOSjfxp/3ofHAT/Peo7vTwbLdQwyBiTCPLyZm4a5CRmIUGbCeszp5NhvoehGYo1nVPPlKATFEBIOzEu2QBvhxAJDTw/VAQakUbVrWUmxQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36662c67b7cso13987385ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710255182; x=1710859982;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXbxWY0ggpBnAPBCR2nNXAvLuJRqe8cvleYylEcKaLA=;
        b=QmXGd3X40uMceFENjgS2toP6ObmIFGRCAumsslFJHdibAiOCTxlzFCp5p0rYM1rOCo
         SE0ncBhWB0iMrwgJ65T8cFegQv9OlqZFs3nSBpL3hfnEKtFi6MeGms9K1U60QCdo9+3Y
         CcFD+ThGAkrohr8uUDJk1LH2RDXBfm4tMST+EOhJ1aC30Lq9hOA7/ctE2tnlgPPRs9Vb
         Ek6ifNw/zIVePXEOgmnZqCXrt7Y3Pdajz7TrTNteZ1v1hy4UUej+868NXKY5W1qTgW7d
         +J4NkC6+ztTDUI8WaO+l/Y6b+5icE6q3d6TdGeI6etMewAagtrBZ6vevUCzObcilUSnI
         iOgg==
X-Gm-Message-State: AOJu0YxxVF+ENujYs/oZFfyU7fux/DFTgDdusksdx1ZSmVf1dIQUa+c+
	JYObOwGKiVEc1VqbGogb8bnfdGMO6pTFD+0swuZTqD+FuiwuqEQkhPyml/EzprrWJ9PbbU2pFXk
	5uayFJWr/COthd0Bq70t2GajU9X9oE20Ga4gTM/yyPKJMuNM96FPTysDXJg==
X-Google-Smtp-Source: AGHT+IEWhfDsE3TaJ9LukOLchIIdCdi86Ldinuz2r+ouf880EBJNq36QEsuP6kjC5h8rs0BfvY1HuCYBDdcF+y8mFjXOKNdkcQyK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0d:b0:366:69b1:99a6 with SMTP id
 i13-20020a056e021d0d00b0036669b199a6mr62032ila.4.1710255182144; Tue, 12 Mar
 2024 07:53:02 -0700 (PDT)
Date: Tue, 12 Mar 2024 07:53:02 -0700
In-Reply-To: <ZfBnHO7FAAavfANp@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b889f061377d037@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up
From: syzbot <syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

][    T1] usbcore: registered new interface driver es2_ap_driver
[   42.422197][    T1] comedi: version 0.7.76 - http://www.comedi.org
[   42.430658][    T1] usbcore: registered new interface driver dt9812
[   42.438267][    T1] usbcore: registered new interface driver ni6501
[   42.446411][    T1] usbcore: registered new interface driver usbdux
[   42.453934][    T1] usbcore: registered new interface driver usbduxfast
[   42.463997][    T1] usbcore: registered new interface driver usbduxsigma
[   42.473612][    T1] usbcore: registered new interface driver vmk80xx
[   42.483836][    T1] usbcore: registered new interface driver prism2_usb
[   42.494704][    T1] usbcore: registered new interface driver r8712u
[   42.503460][    T1] greybus: registered new driver hid
[   42.512311][    T1] greybus: registered new driver gbphy
[   42.519579][    T1] gb_gbphy: registered new driver usb
[   42.527020][    T1] asus_wmi: ASUS WMI generic driver loaded
[   42.731296][    T1] usbcore: registered new interface driver snd-usb-aud=
io
[   42.741620][    T1] usbcore: registered new interface driver snd-ua101
[   42.749952][    T1] usbcore: registered new interface driver snd-usb-usx=
2y
[   42.758661][    T1] usbcore: registered new interface driver snd-usb-us1=
22l
[   42.767118][    T1] usbcore: registered new interface driver snd-usb-cai=
aq
[   42.775321][    T1] usbcore: registered new interface driver snd-usb-6fi=
re
[   42.783674][    T1] usbcore: registered new interface driver snd-usb-hif=
ace
[   42.791997][    T1] usbcore: registered new interface driver snd-bcd2000
[   42.800157][    T1] usbcore: registered new interface driver snd_usb_pod
[   42.808478][    T1] usbcore: registered new interface driver snd_usb_pod=
hd
[   42.816850][    T1] usbcore: registered new interface driver snd_usb_ton=
eport
[   42.825534][    T1] usbcore: registered new interface driver snd_usb_var=
iax
[   42.833932][    T1] drop_monitor: Initializing network drop monitor serv=
ice
[   42.842629][    T1] NET: Registered PF_LLC protocol family
[   42.848636][    T1] GACT probability on
[   42.853209][    T1] Mirror/redirect action on
[   42.858743][    T1] Simple TC action Loaded
[   42.871438][    T1] netem: version 1.3
[   42.879018][    T1] u32 classifier
[   42.882828][    T1]     Performance counters on
[   42.887765][    T1]     input device check on
[   42.892411][    T1]     Actions configured
[   42.920768][    T1] nf_conntrack_irc: failed to register helpers
[   42.927913][    T1] nf_conntrack_sane: failed to register helpers
[   43.075226][    T1] nf_conntrack_sip: failed to register helpers
[   43.093698][    T1] xt_time: kernel timezone is -0000
[   43.099798][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[   43.107126][    T1] IPVS: Connection hash table configured (size=3D4096,=
 memory=3D32Kbytes)
[   43.117858][    T1] IPVS: ipvs loaded.
[   43.122006][    T1] IPVS: [rr] scheduler registered.
[   43.127305][    T1] IPVS: [wrr] scheduler registered.
[   43.132903][    T1] IPVS: [lc] scheduler registered.
[   43.138550][    T1] IPVS: [wlc] scheduler registered.
[   43.144107][    T1] IPVS: [fo] scheduler registered.
[   43.149582][    T1] IPVS: [ovf] scheduler registered.
[   43.155079][    T1] IPVS: [lblc] scheduler registered.
[   43.160612][    T1] IPVS: [lblcr] scheduler registered.
[   43.166196][    T1] IPVS: [dh] scheduler registered.
[   43.171697][    T1] IPVS: [sh] scheduler registered.
[   43.177019][    T1] IPVS: [mh] scheduler registered.
[   43.182292][    T1] IPVS: [sed] scheduler registered.
[   43.188071][    T1] IPVS: [nq] scheduler registered.
[   43.193517][    T1] IPVS: [twos] scheduler registered.
[   43.199089][    T1] IPVS: [sip] pe registered.
[   43.206293][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   43.220297][    T1] gre: GRE over IPv4 demultiplexor driver
[   43.226392][    T1] ip_gre: GRE over IPv4 tunneling driver
[   43.253883][    T1] IPv4 over IPsec tunneling driver
[   43.270573][    T1] Initializing XFRM netlink socket
[   43.278345][    T1] IPsec XFRM device driver
[   43.284328][    T1] NET: Registered PF_INET6 protocol family
[   43.337639][    T1] Segment Routing with IPv6
[   43.342341][    T1] RPL Segment Routing with IPv6
[   43.349039][    T1] In-situ OAM (IOAM) with IPv6
[   43.355176][    T1] mip6: Mobile IPv6
[   43.363111][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   43.363352][    T1] BUG: KMSAN: use-after-free in __list_add_valid_or_re=
port+0xeb/0x2c0
[   43.363499][    T1]  __list_add_valid_or_report+0xeb/0x2c0
[   43.363629][    T1]  stack_depot_save_flags+0x554/0x6a0
[   43.363748][    T1]  stack_depot_save+0x12/0x20
[   43.363852][    T1]  ref_tracker_alloc+0x215/0x700
[   43.363968][    T1]  net_rx_queue_update_kobjects+0x1eb/0xa80
[   43.364082][    T1]  netdev_register_kobject+0x30e/0x530
[   43.364186][    T1]  register_netdevice+0x1995/0x2180
[   43.364280][    T1]  register_netdev+0xa5/0xe0
[   43.364365][    T1]  vti6_init_net+0x3f9/0x6a0
[   43.364486][    T1]  ops_init+0x30c/0x880
[   43.364570][    T1]  register_pernet_operations+0x523/0xa00
[   43.364660][    T1]  register_pernet_device+0x4f/0x180
[   43.364742][    T1]  vti6_tunnel_init+0x34/0x450
[   43.364783][    T1]  do_one_initcall+0x219/0x970
[   43.364964][    T1]  do_initcall_level+0x140/0x350
[   43.364964][    T1]  do_initcalls+0xf0/0x1e0
[   43.364964][    T1]  do_basic_setup+0x22/0x30
[   43.364964][    T1]  kernel_init_freeable+0x30b/0x4c0
[   43.364964][    T1]  kernel_init+0x2f/0x7e0
[   43.364964][    T1]  ret_from_fork+0x6d/0x90
[   43.364964][    T1]  ret_from_fork_asm+0x1a/0x30
[   43.364964][    T1]=20
[   43.364964][    T1] Uninit was created at:
[   43.364964][    T1]  free_unref_page_prepare+0xc1/0xad0
[   43.364964][    T1]  free_unref_page+0x59/0x730
[   43.364964][    T1]  destroy_large_folio+0x12a/0x1d0
[   43.364964][    T1]  __folio_put_large+0x101/0x110
[   43.364964][    T1]  __folio_put+0x153/0x160
[   43.364964][    T1]  free_large_kmalloc+0x167/0x210
[   43.364964][    T1]  kfree+0x4e3/0xa40
[   43.364964][    T1]  kmsan_vmap_pages_range_noflush+0x347/0x3d0
[   43.364964][    T1]  __vmalloc_node_range+0x217c/0x28c0
[   43.364964][    T1]  vmalloc_huge+0x92/0xb0
[   43.364964][    T1]  alloc_large_system_hash+0x459/0xa30
[   43.364964][    T1]  dcache_init+0x125/0x220
[   43.364964][    T1]  vfs_caches_init+0x7c/0xd0
[   43.364964][    T1]  start_kernel+0x8d8/0xa60
[   43.364964][    T1]  x86_64_start_reservations+0x2e/0x30
[   43.364964][    T1]  x86_64_start_kernel+0x98/0xa0
[   43.364964][    T1]  secondary_startup_64_no_verify+0x15f/0x16b
[   43.364964][    T1]=20
[   43.364964][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-01185-g855684c7d938-dirty #0
[   43.364964][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   43.364964][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   43.364964][    T1] Disabling lock debugging due to kernel taint
[   43.364964][    T1] Kernel panic - not syncing: kmsan.panic set ...
[   43.364964][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B       =
       6.8.0-syzkaller-01185-g855684c7d938-dirty #0
[   43.364964][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   43.364964][    T1] Call Trace:
[   43.364964][    T1]  <TASK>
[   43.364964][    T1]  dump_stack_lvl+0x1bf/0x240
[   43.364964][    T1]  dump_stack+0x1e/0x30
[   43.364964][    T1]  panic+0x4e2/0xcc0
[   43.364964][    T1]  ? kmsan_get_metadata+0x121/0x1c0
[   43.364964][    T1]  kmsan_report+0x2d5/0x2e0
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? __msan_warning+0x95/0x110
[   43.364964][    T1]  ? __list_add_valid_or_report+0xeb/0x2c0
[   43.364964][    T1]  ? stack_depot_save_flags+0x554/0x6a0
[   43.364964][    T1]  ? stack_depot_save+0x12/0x20
[   43.364964][    T1]  ? ref_tracker_alloc+0x215/0x700
[   43.364964][    T1]  ? net_rx_queue_update_kobjects+0x1eb/0xa80
[   43.364964][    T1]  ? netdev_register_kobject+0x30e/0x530
[   43.364964][    T1]  ? register_netdevice+0x1995/0x2180
[   43.364964][    T1]  ? register_netdev+0xa5/0xe0
[   43.364964][    T1]  ? vti6_init_net+0x3f9/0x6a0
[   43.364964][    T1]  ? ops_init+0x30c/0x880
[   43.364964][    T1]  ? register_pernet_operations+0x523/0xa00
[   43.364964][    T1]  ? register_pernet_device+0x4f/0x180
[   43.364964][    T1]  ? vti6_tunnel_init+0x34/0x450
[   43.364964][    T1]  ? do_one_initcall+0x219/0x970
[   43.364964][    T1]  ? do_initcall_level+0x140/0x350
[   43.364964][    T1]  ? do_initcalls+0xf0/0x1e0
[   43.364964][    T1]  ? do_basic_setup+0x22/0x30
[   43.364964][    T1]  ? kernel_init_freeable+0x30b/0x4c0
[   43.364964][    T1]  ? kernel_init+0x2f/0x7e0
[   43.364964][    T1]  ? ret_from_fork+0x6d/0x90
[   43.364964][    T1]  ? ret_from_fork_asm+0x1a/0x30
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   43.364964][    T1]  ? _raw_spin_lock_irqsave+0x35/0xc0
[   43.364964][    T1]  ? filter_irq_stacks+0x60/0x1a0
[   43.364964][    T1]  ? stack_depot_save_flags+0x2c/0x6a0
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   43.364964][    T1]  __msan_warning+0x95/0x110
[   43.364964][    T1]  __list_add_valid_or_report+0xeb/0x2c0
[   43.364964][    T1]  stack_depot_save_flags+0x554/0x6a0
[   43.364964][    T1]  stack_depot_save+0x12/0x20
[   43.364964][    T1]  ref_tracker_alloc+0x215/0x700
[   43.364964][    T1]  ? dev_uevent_filter+0x53/0x110
[   43.364964][    T1]  ? net_rx_queue_update_kobjects+0x1eb/0xa80
[   43.364964][    T1]  ? netdev_register_kobject+0x30e/0x530
[   43.364964][    T1]  ? register_netdevice+0x1995/0x2180
[   43.364964][    T1]  ? register_netdev+0xa5/0xe0
[   43.364964][    T1]  ? vti6_init_net+0x3f9/0x6a0
[   43.364964][    T1]  ? ops_init+0x30c/0x880
[   43.364964][    T1]  ? register_pernet_operations+0x523/0xa00
[   43.364964][    T1]  ? register_pernet_device+0x4f/0x180
[   43.364964][    T1]  ? vti6_tunnel_init+0x34/0x450
[   43.364964][    T1]  ? do_one_initcall+0x219/0x970
[   43.364964][    T1]  ? do_initcall_level+0x140/0x350
[   43.364964][    T1]  ? do_initcalls+0xf0/0x1e0
[   43.364964][    T1]  ? do_basic_setup+0x22/0x30
[   43.364964][    T1]  ? kernel_init_freeable+0x30b/0x4c0
[   43.364964][    T1]  ? kernel_init+0x2f/0x7e0
[   43.364964][    T1]  ? ret_from_fork+0x6d/0x90
[   43.364964][    T1]  net_rx_queue_update_kobjects+0x1eb/0xa80
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  netdev_register_kobject+0x30e/0x530
[   43.364964][    T1]  register_netdevice+0x1995/0x2180
[   43.364964][    T1]  register_netdev+0xa5/0xe0
[   43.364964][    T1]  vti6_init_net+0x3f9/0x6a0
[   43.364964][    T1]  ? __pfx_vti6_init_net+0x10/0x10
[   43.364964][    T1]  ops_init+0x30c/0x880
[   43.364964][    T1]  register_pernet_operations+0x523/0xa00
[   43.364964][    T1]  register_pernet_device+0x4f/0x180
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  vti6_tunnel_init+0x34/0x450
[   43.364964][    T1]  ? __pfx_vti6_tunnel_init+0x10/0x10
[   43.364964][    T1]  do_one_initcall+0x219/0x970
[   43.364964][    T1]  ? __pfx_vti6_tunnel_init+0x10/0x10
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   43.364964][    T1]  ? parse_args+0x266/0x1600
[   43.364964][    T1]  ? filter_irq_stacks+0x60/0x1a0
[   43.364964][    T1]  ? stack_depot_save_flags+0x2c/0x6a0
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   43.364964][    T1]  ? parse_args+0x152c/0x1600
[   43.364964][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   43.364964][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   43.364964][    T1]  ? __pfx_vti6_tunnel_init+0x10/0x10
[   43.375029][    T1]  do_initcall_level+0x140/0x350
[   43.375029][    T1]  do_initcalls+0xf0/0x1e0
[   43.375216][    T1]  ? __pfx_native_smp_prepare_cpus+0x10/0x10
[   43.375216][    T1]  do_basic_setup+0x22/0x30
[   43.375216][    T1]  kernel_init_freeable+0x30b/0x4c0
[   43.375216][    T1]  ? __pfx_kernel_init+0x10/0x10
[   43.375216][    T1]  kernel_init+0x2f/0x7e0
[   43.375216][    T1]  ? __pfx_kernel_init+0x10/0x10
[   43.375216][    T1]  ret_from_fork+0x6d/0x90
[   43.375216][    T1]  ? __pfx_kernel_init+0x10/0x10
[   43.375216][    T1]  ret_from_fork_asm+0x1a/0x30
[   43.375216][    T1]  </TASK>
[   43.375216][    T1] Kernel Offset: disabled


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
 -ffile-prefix-map=3D/tmp/go-build870398676=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at 1e153dc8b
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
/syzkaller/prog.GitRevision=3D1e153dc8b31e685ca8495576db4f8c077585e39c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240123-140118'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D1e153dc8b31e685ca8495576db4f8c077585e39c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240123-140118'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D1e153dc8b31e685ca8495576db4f8c077585e39c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240123-140118'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"1e153dc8b31e685ca8495576db4f8c0775=
85e39c\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12af9786180000


Tested on:

commit:         855684c7 Merge tag 'x86_tdx_for_6.9' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6b3a9c97e8057f2=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D7ea9413ea6749baf5=
574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D12ba6c691800=
00


