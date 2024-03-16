Return-Path: <linux-kernel+bounces-105095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58687D908
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC8828256D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905779461;
	Sat, 16 Mar 2024 06:04:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BFF79D3
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710569045; cv=none; b=jg7eRGVi7sB6gUujM45ObgJf0D6ECTFqnyzfYLVkXUmXguIV9nCA/JzHA8y67sGXeeEurL86M9+hgXh8Zzyg7Y1FsWY+9E6Y5/tMHcgnuIhorX9mz34SQWsR2jnW7skIbNYeVRk6mfUcjaNqnVOVGkdE5bUVWbxM+K5N7P47Ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710569045; c=relaxed/simple;
	bh=Envg4ZNvPKtxLAyE37lgBXyAuH7oMagsLmkhUHMUo1Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AX//Mljotd+cu58NlZpdXVXyi7HMxnAFlsKtMVPh3P3uI43SuR60IrBq6wvw6lYwjUbfEV9sCVayOqxGZpKUSrUif+zaGL42fOCToRBMqt4ClfwIkSIXC7nbRf5Lag/RLwppG03Ajts2eXpLonJ6YgsWHv3py/RHvwD7a5QNjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c846da7ad2so221167539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710569042; x=1711173842;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzCl97IeV0pM7y/6y7Ji8R1jeE0JtSYVTEAQy/K4tqI=;
        b=eYVy/CXbAhbfjtPK8GHoZ9Dj6KB+8ESwE8VtVTKWr0H3qy0AozTvQrnD2rim28jfgn
         jQnevle3LhElc9WnDJt6yDEpcJN7h7OhttTZ4FCcJG7PviMNXN4qURa/AP4yCL4dqWjD
         KbziUvMCq69XaqwJ3HhtZ871mFzzXfRLF1FrIrsEQ7jphOhM9Y91TuA78ZnMKfITW1pe
         G2Vb5tGcTwcs/+fGs2S/GpEPdVCSzu/IZmHo2o0lVqc2T6/YAHp/WHYMdR6tDF6yVPTV
         DP9yf8LjJLqpEvfffzcg6WhMJ+g/TF70hTd/GdOqYBpTNugh9lSJ13I94ki4FXAPR+P/
         0hEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX20U07hMQQ9rcw2sok6HsQDrp4KW0QOJVZHt0u0l5Fvdp0VMyUFSixz8VWvPD+QW0TmOLiIyxv3TDVWllil1eFLML2R7UMMisv0E7D
X-Gm-Message-State: AOJu0Yza1g+A7idxI8cA+LLFZol2bgV0x6cVVBRnkSf+HmIUOd0Kj07E
	Ep56W4ZzASNCXR6SPVRDlaTRTqs7mQctgAYZdi0CxYi4M1pXTWraERJ8cLuctV5VixOrZDylSwc
	Dw+/w+M9tM8i8C1hFxuSApU2t9GgAfaisC9SFc4Y0Cd8Hknu5YJEYkeE=
X-Google-Smtp-Source: AGHT+IHdoSk1McBkmHLC2b7d3sPUkv1DKrzCFhr7nZ4eVgB4P2JOMQDXEPEHeQvY2j55LZjpjQu96esEHc3W7kyNlmM+WRtgjNu3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1609:b0:7c8:c581:b272 with SMTP id
 x9-20020a056602160900b007c8c581b272mr171839iow.2.1710569042753; Fri, 15 Mar
 2024 23:04:02 -0700 (PDT)
Date: Fri, 15 Mar 2024 23:04:02 -0700
In-Reply-To: <20240316053948.1711-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000284f750613c0e401@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
From: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

12.943031][    T1] IPVS: [mh] scheduler registered.
[   12.948210][    T1] IPVS: [sed] scheduler registered.
[   12.953811][    T1] IPVS: [nq] scheduler registered.
[   12.958959][    T1] IPVS: [twos] scheduler registered.
[   12.964757][    T1] IPVS: [sip] pe registered.
[   12.969994][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   12.980131][    T1] gre: GRE over IPv4 demultiplexor driver
[   12.986107][    T1] ip_gre: GRE over IPv4 tunneling driver
[   13.002885][    T1] IPv4 over IPsec tunneling driver
[   13.013497][    T1] Initializing XFRM netlink socket
[   13.019152][    T1] IPsec XFRM device driver
[   13.024288][    T1] NET: Registered PF_INET6 protocol family
[   13.044269][    T1] Segment Routing with IPv6
[   13.049148][    T1] RPL Segment Routing with IPv6
[   13.054335][    T1] In-situ OAM (IOAM) with IPv6
[   13.059809][    T1] mip6: Mobile IPv6
[   13.068217][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   13.084725][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   13.094832][    T1] NET: Registered PF_PACKET protocol family
[   13.100861][    T1] NET: Registered PF_KEY protocol family
[   13.107075][    T1] Bridge firewalling registered
[   13.112811][    T1] NET: Registered PF_X25 protocol family
[   13.118805][    T1] X25: Linux Version 0.2
[   13.171958][    T1] NET: Registered PF_NETROM protocol family
[   13.231378][    T1] NET: Registered PF_ROSE protocol family
[   13.237759][    T1] NET: Registered PF_AX25 protocol family
[   13.243628][    T1] can: controller area network core
[   13.249225][    T1] NET: Registered PF_CAN protocol family
[   13.254866][    T1] can: raw protocol
[   13.260173][    T1] can: broadcast manager protocol
[   13.265261][    T1] can: netlink gateway - max_hops=3D1
[   13.270756][    T1] can: SAE J1939
[   13.274343][    T1] can: isotp protocol (max_pdu_size 8300)
[   13.280558][    T1] Bluetooth: RFCOMM TTY layer initialized
[   13.287006][    T1] Bluetooth: RFCOMM socket layer initialized
[   13.293219][    T1] Bluetooth: RFCOMM ver 1.11
[   13.298196][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   13.304369][    T1] Bluetooth: BNEP filters: protocol multicast
[   13.310576][    T1] Bluetooth: BNEP socket layer initialized
[   13.316420][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   13.322246][    T1] Bluetooth: CMTP socket layer initialized
[   13.328135][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   13.334946][    T1] Bluetooth: HIDP socket layer initialized
[   13.344387][    T1] NET: Registered PF_RXRPC protocol family
[   13.350330][    T1] Key type rxrpc registered
[   13.354846][    T1] Key type rxrpc_s registered
[   13.360283][    T1] NET: Registered PF_KCM protocol family
[   13.366731][    T1] lec:lane_module_init: lec.c: initialized
[   13.372544][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   13.378511][    T1] l2tp_core: L2TP core driver, V2.0
[   13.383910][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   13.389565][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   13.396254][    T1] l2tp_netlink: L2TP netlink interface
[   13.401985][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   13.408805][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   13.417012][    T1] NET: Registered PF_PHONET protocol family
[   13.423231][    T1] 8021q: 802.1Q VLAN Support v1.8
[   13.444693][    T1] DCCP: Activated CCID 2 (TCP-like)
[   13.450195][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   13.457434][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   13.469019][    T1] sctp: Hash tables configured (bind 32/56)
[   13.477144][    T1] NET: Registered PF_RDS protocol family
[   13.483759][    T1] Registered RDS/infiniband transport
[   13.490657][    T1] Registered RDS/tcp transport
[   13.495427][    T1] tipc: Activated (version 2.0.0)
[   13.502074][    T1] NET: Registered PF_TIPC protocol family
[   13.509135][    T1] tipc: Started in single node mode
[   13.515425][    T1] NET: Registered PF_SMC protocol family
[   13.521519][    T1] 9pnet: Installing 9P2000 support
[   13.527264][    T1] NET: Registered PF_CAIF protocol family
[   13.538490][    T1] NET: Registered PF_IEEE802154 protocol family
[   13.545010][    T1] Key type dns_resolver registered
[   13.550298][    T1] Key type ceph registered
[   13.555300][    T1] libceph: loaded (mon/osd proto 15/24)
[   13.562208][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.1 (compatibil=
ity version 15) loaded
[   13.571294][    T1] openvswitch: Open vSwitch switching datapath
[   13.581192][    T1] NET: Registered PF_VSOCK protocol family
[   13.587645][    T1] mpls_gso: MPLS GSO support
[   13.606375][    T1] IPI shorthand broadcast: enabled
[   13.611614][    T1] AVX2 version of gcm_enc/dec engaged.
[   13.617408][    T1] AES CTR mode by8 optimization enabled
[   15.027917][    T1] sched_clock: Marking stable (14980033732, 45862812)-=
>(15027552445, -1655901)
[   15.060393][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   15.071403][    T1] registered taskstats version 1
[   15.093857][    T1] Loading compiled-in X.509 certificates
[   15.104512][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 991e12b3e9ed2951305419ad7742982355df57eb'
[   15.401200][    T1] zswap: loaded using pool lzo/zsmalloc
[   15.408732][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   15.900621][    T1] ------------[ cut here ]------------
[   15.906364][    T1] refcount_t: decrement hit 0; leaking memory.
[   15.912957][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[   15.922163][    T1] Modules linked in:
[   15.926098][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-11136-g66a27abac311-dirty #0
[   15.935922][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   15.946042][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[   15.952210][    T1] Code: b2 00 00 00 e8 e7 9b f5 fc 5b 5d c3 cc cc cc c=
c e8 db 9b f5 fc c6 05 b8 1e d2 0a 01 90 48 c7 c7 60 da fd 8b e8 57 61 b8 f=
c 90 <0f> 0b 90 90 eb d9 e8 bb 9b f5 fc c6 05 95 1e d2 0a 01 90 48 c7 c7
[   15.971955][    T1] RSP: 0000:ffffc90000067660 EFLAGS: 00010246
[   15.978221][    T1] RAX: 0fe32bb113e5bf00 RBX: ffff88802fb6472c RCX: fff=
f8880166c8000
[   15.986337][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   15.994305][    T1] RBP: 0000000000000004 R08: ffffffff8157df32 R09: fff=
ffbfff1bf9660
[   16.002477][    T1] R10: dffffc0000000000 R11: fffffbfff1bf9660 R12: fff=
fea0001004000
[   16.010484][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: fff=
fea0001004008
[   16.018469][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[   16.027499][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.034061][    T1] CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[   16.042391][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   16.050505][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   16.058778][    T1] Call Trace:
[   16.062157][    T1]  <TASK>
[   16.065073][    T1]  ? __warn+0x163/0x4b0
[   16.069266][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   16.074748][    T1]  ? report_bug+0x2b3/0x500
[   16.079564][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   16.085135][    T1]  ? handle_bug+0x3e/0x70
[   16.089485][    T1]  ? exc_invalid_op+0x1a/0x50
[   16.094158][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   16.099373][    T1]  ? __warn_printk+0x292/0x360
[   16.104139][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   16.109624][    T1]  free_unref_page_prepare+0x95d/0xa80
[   16.115106][    T1]  free_unref_page+0x37/0x3f0
[   16.119816][    T1]  free_contig_range+0x9e/0x160
[   16.124767][    T1]  destroy_args+0xbf/0x930
[   16.129207][    T1]  debug_vm_pgtable+0x4be/0x550
[   16.134142][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   16.139640][    T1]  ? __pfx_add_device_randomness+0x10/0x10
[   16.145480][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   16.151256][    T1]  do_one_initcall+0x238/0x830
[   16.156291][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   16.161763][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   16.167120][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   16.173394][    T1]  ? __pfx_parse_args+0x10/0x10
[   16.178404][    T1]  ? lockdep_hardirqs_on+0x99/0x150
[   16.183698][    T1]  ? rcu_is_watching+0x15/0xb0
[   16.188485][    T1]  do_initcall_level+0x157/0x210
[   16.193436][    T1]  do_initcalls+0x3f/0x80
[   16.197830][    T1]  kernel_init_freeable+0x435/0x5d0
[   16.203149][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   16.209002][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   16.215336][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.220450][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.225404][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.230363][    T1]  kernel_init+0x1d/0x2b0
[   16.234710][    T1]  ret_from_fork+0x4b/0x80
[   16.239252][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.244360][    T1]  ret_from_fork_asm+0x1a/0x30
[   16.249246][    T1]  </TASK>
[   16.252545][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   16.259895][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-11136-g66a27abac311-dirty #0
[   16.269779][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   16.279812][    T1] Call Trace:
[   16.283087][    T1]  <TASK>
[   16.286006][    T1]  dump_stack_lvl+0x241/0x360
[   16.290695][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[   16.295873][    T1]  ? __pfx__printk+0x10/0x10
[   16.300449][    T1]  ? vscnprintf+0x5d/0x90
[   16.304763][    T1]  panic+0x349/0x860
[   16.308647][    T1]  ? __warn+0x172/0x4b0
[   16.312869][    T1]  ? __pfx_panic+0x10/0x10
[   16.317443][    T1]  ? ret_from_fork_asm+0x1a/0x30
[   16.322385][    T1]  __warn+0x31e/0x4b0
[   16.326346][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   16.331877][    T1]  report_bug+0x2b3/0x500
[   16.336186][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   16.341810][    T1]  handle_bug+0x3e/0x70
[   16.345964][    T1]  exc_invalid_op+0x1a/0x50
[   16.350577][    T1]  asm_exc_invalid_op+0x1a/0x20
[   16.355427][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[   16.361582][    T1] Code: b2 00 00 00 e8 e7 9b f5 fc 5b 5d c3 cc cc cc c=
c e8 db 9b f5 fc c6 05 b8 1e d2 0a 01 90 48 c7 c7 60 da fd 8b e8 57 61 b8 f=
c 90 <0f> 0b 90 90 eb d9 e8 bb 9b f5 fc c6 05 95 1e d2 0a 01 90 48 c7 c7
[   16.381608][    T1] RSP: 0000:ffffc90000067660 EFLAGS: 00010246
[   16.387763][    T1] RAX: 0fe32bb113e5bf00 RBX: ffff88802fb6472c RCX: fff=
f8880166c8000
[   16.395735][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   16.403711][    T1] RBP: 0000000000000004 R08: ffffffff8157df32 R09: fff=
ffbfff1bf9660
[   16.411751][    T1] R10: dffffc0000000000 R11: fffffbfff1bf9660 R12: fff=
fea0001004000
[   16.419724][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: fff=
fea0001004008
[   16.427717][    T1]  ? __warn_printk+0x292/0x360
[   16.432558][    T1]  free_unref_page_prepare+0x95d/0xa80
[   16.438001][    T1]  free_unref_page+0x37/0x3f0
[   16.442973][    T1]  free_contig_range+0x9e/0x160
[   16.448493][    T1]  destroy_args+0xbf/0x930
[   16.453099][    T1]  debug_vm_pgtable+0x4be/0x550
[   16.457978][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   16.463467][    T1]  ? __pfx_add_device_randomness+0x10/0x10
[   16.469469][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   16.474941][    T1]  do_one_initcall+0x238/0x830
[   16.479709][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   16.485072][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   16.490365][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   16.496385][    T1]  ? __pfx_parse_args+0x10/0x10
[   16.501233][    T1]  ? lockdep_hardirqs_on+0x99/0x150
[   16.506558][    T1]  ? rcu_is_watching+0x15/0xb0
[   16.511494][    T1]  do_initcall_level+0x157/0x210
[   16.516440][    T1]  do_initcalls+0x3f/0x80
[   16.520760][    T1]  kernel_init_freeable+0x435/0x5d0
[   16.526036][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   16.531754][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   16.538096][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.543023][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.547967][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.552913][    T1]  kernel_init+0x1d/0x2b0
[   16.557267][    T1]  ret_from_fork+0x4b/0x80
[   16.562141][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.567085][    T1]  ret_from_fork_asm+0x1a/0x30
[   16.572035][    T1]  </TASK>
[   16.575576][    T1] Kernel Offset: disabled
[   16.579900][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build501078772=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at d615901c7
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
/syzkaller/prog.GitRevision=3Dd615901c739a765329b688494cee2f8e1b5037cb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240314-145638'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd615901c739a765329b688494cee2f8e1b5037cb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240314-145638'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd615901c739a765329b688494cee2f8e1b5037cb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240314-145638'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"d615901c739a765329b688494cee2f8e1b=
5037cb\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D14921546180000


Tested on:

commit:         66a27aba Merge tag 'powerpc-6.9-1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfe0919aedd4b3fc=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3D28c1a5a5b041a754b=
947
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D15c05ac91800=
00


