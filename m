Return-Path: <linux-kernel+bounces-105035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5497287D7FE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8271C21407
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FD61FA4;
	Sat, 16 Mar 2024 02:37:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F936C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710556626; cv=none; b=m8i9RqRXKO1mS7xXhbjpVA1n+lyYil3A0UopwM4ZL0RhESVgRTz9IpfvRsCN1M8HOQppCQow93DDDShfzSwtvIeKxuazG8jYAY2wJYCSd7+2gHvDxTC2KwRmwMVqRrMQ0fEtmxxkDwJIuUsz6Ti0EdBHVb8vNGrKUhFYfu+CUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710556626; c=relaxed/simple;
	bh=9m+c8XuUOZtq4G2R7ASKHsLEDKNdRe9anQmOsYIUJFU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LGlL+JYGXYUtFPRrKuU3peEjQwHWONHOPwDDKbNdVylS3gf4NJcO1rQXW3wP0lCRjQA6Yl5CmidqUetcezXORp2LrojppZruWsHby8cPeJDznI5i601HCA+MJaV/6Fheh4gmkALS0CnAxZitinjKbBfpVuI3E25sFuY4Dq/CL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3668f754090so15718175ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 19:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710556623; x=1711161423;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LaFfClARikskoSAFoyvOn4uimuuPXGD75KOgL1Iljs=;
        b=hTugUWjKvQNoy+rQkir4+nX2oUm8vSO6IGFG/g+NQpMjH/WpQT51lSbholoMWnwIBx
         o/WjsiOeMN3CMr3pOBL0LpKNamDMYuQV/7syLIqA6vJvKgO3sJcFYyRQG7+1lcivkGOA
         +Sz3aQ30GKRbFlAWRlKg1NTLAEdSHiGCGy/QYwqNeST9gukvpSXYZKD3Z27k4jTZIx+h
         HPq7WsvNzsAu/qYHRSFVTrdEPufnXlmNnwfswHqQmvUaNVNwKYJFrj0Qhx/SMLYjv0aA
         sqdyPQP0B/+g4F7C3XgFP9x4jpjHMbbMBNx8d7A4KtjCuOMaWafQtCbkIuza0AFL97ur
         9yuw==
X-Forwarded-Encrypted: i=1; AJvYcCVN/YWotKmKu13G7TLYlLod6w4k44wlQ4Y21qhSs7pLARU2fWCX7R//exJbD3+XmRk41FsJh0bv7oxhqrhSpMitoT4A6ZsA0A33YxkR
X-Gm-Message-State: AOJu0YywMwcBA0GD6CxY6tOpXZkLFVL7i81YvyNe4dAXWz4OLPfHM6Am
	XVqGlwXGkUTVOTglzqPAZTvDnWRkI7ijQ0kQuh6MJSHNZX2Xaiof7DX6Q9Szvy730jLCDH0o+d/
	NmrLEerOno6xZ6JtpzykCyDB0RKzBMgTTkTFZbu2aXWv8JS131lL1Frw=
X-Google-Smtp-Source: AGHT+IFecxXyg61rHcPjBcKxykvtJ/YYmxgeum3bMXYlLvRBtNJPUUZ6+KcXHxpWHL7ozbPX0Oxgu8JY7NiOVg42Ov5RyZeyeWqo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12eb:b0:365:1f8b:d103 with SMTP id
 l11-20020a056e0212eb00b003651f8bd103mr404350iln.6.1710556623537; Fri, 15 Mar
 2024 19:37:03 -0700 (PDT)
Date: Fri, 15 Mar 2024 19:37:03 -0700
In-Reply-To: <20240316012302.1634-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea17a60613bdff41@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
From: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

cheduler registered.
[   12.516188][    T1] IPVS: [sip] pe registered.
[   12.520995][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   12.530995][ T2596] kworker/u8:6 (2596) used greatest stack depth: 24584=
 bytes left
[   12.531547][    T1] gre: GRE over IPv4 demultiplexor driver
[   12.546566][    T1] ip_gre: GRE over IPv4 tunneling driver
[   12.562031][    T1] IPv4 over IPsec tunneling driver
[   12.571861][    T1] Initializing XFRM netlink socket
[   12.577184][    T1] IPsec XFRM device driver
[   12.582228][    T1] NET: Registered PF_INET6 protocol family
[   12.601211][    T1] Segment Routing with IPv6
[   12.605725][    T1] RPL Segment Routing with IPv6
[   12.611988][    T1] In-situ OAM (IOAM) with IPv6
[   12.617157][    T1] mip6: Mobile IPv6
[   12.625315][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   12.640254][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   12.650891][    T1] NET: Registered PF_PACKET protocol family
[   12.657015][    T1] NET: Registered PF_KEY protocol family
[   12.663860][    T1] Bridge firewalling registered
[   12.669841][    T1] NET: Registered PF_X25 protocol family
[   12.675613][    T1] X25: Linux Version 0.2
[   12.728707][    T1] NET: Registered PF_NETROM protocol family
[   12.781365][    T1] NET: Registered PF_ROSE protocol family
[   12.787626][    T1] NET: Registered PF_AX25 protocol family
[   12.793791][    T1] can: controller area network core
[   12.799680][    T1] NET: Registered PF_CAN protocol family
[   12.805409][    T1] can: raw protocol
[   12.809343][    T1] can: broadcast manager protocol
[   12.814559][    T1] can: netlink gateway - max_hops=3D1
[   12.820138][    T1] can: SAE J1939
[   12.823728][    T1] can: isotp protocol (max_pdu_size 8300)
[   12.829882][    T1] Bluetooth: RFCOMM TTY layer initialized
[   12.835710][    T1] Bluetooth: RFCOMM socket layer initialized
[   12.842556][    T1] Bluetooth: RFCOMM ver 1.11
[   12.847753][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.854618][    T1] Bluetooth: BNEP filters: protocol multicast
[   12.861574][    T1] Bluetooth: BNEP socket layer initialized
[   12.867468][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   12.873580][    T1] Bluetooth: CMTP socket layer initialized
[   12.879495][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   12.886302][    T1] Bluetooth: HIDP socket layer initialized
[   12.895398][    T1] NET: Registered PF_RXRPC protocol family
[   12.901429][    T1] Key type rxrpc registered
[   12.906026][    T1] Key type rxrpc_s registered
[   12.911826][    T1] NET: Registered PF_KCM protocol family
[   12.918328][    T1] lec:lane_module_init: lec.c: initialized
[   12.924409][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   12.930280][    T1] l2tp_core: L2TP core driver, V2.0
[   12.935598][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   12.941358][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   12.947949][    T1] l2tp_netlink: L2TP netlink interface
[   12.953654][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   12.960697][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   12.968360][    T1] NET: Registered PF_PHONET protocol family
[   12.974813][    T1] 8021q: 802.1Q VLAN Support v1.8
[   12.994336][    T1] DCCP: Activated CCID 2 (TCP-like)
[   12.999843][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   13.007186][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   13.018788][    T1] sctp: Hash tables configured (bind 32/56)
[   13.026856][    T1] NET: Registered PF_RDS protocol family
[   13.033336][    T1] Registered RDS/infiniband transport
[   13.040666][    T1] Registered RDS/tcp transport
[   13.045434][    T1] tipc: Activated (version 2.0.0)
[   13.051314][    T1] NET: Registered PF_TIPC protocol family
[   13.058003][    T1] tipc: Started in single node mode
[   13.064169][    T1] NET: Registered PF_SMC protocol family
[   13.070187][    T1] 9pnet: Installing 9P2000 support
[   13.076496][    T1] NET: Registered PF_CAIF protocol family
[   13.086967][    T1] NET: Registered PF_IEEE802154 protocol family
[   13.093617][    T1] Key type dns_resolver registered
[   13.098818][    T1] Key type ceph registered
[   13.104600][    T1] libceph: loaded (mon/osd proto 15/24)
[   13.112473][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.1 (compatibil=
ity version 15) loaded
[   13.121607][    T1] openvswitch: Open vSwitch switching datapath
[   13.131618][    T1] NET: Registered PF_VSOCK protocol family
[   13.137773][    T1] mpls_gso: MPLS GSO support
[   13.156405][    T1] IPI shorthand broadcast: enabled
[   13.161743][    T1] AVX2 version of gcm_enc/dec engaged.
[   13.167509][    T1] AES CTR mode by8 optimization enabled
[   14.590865][    T1] sched_clock: Marking stable (14560030479, 29021812)-=
>(14596728069, -7675778)
[   14.601567][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   14.613912][    T1] registered taskstats version 1
[   14.632381][    T1] Loading compiled-in X.509 certificates
[   14.642765][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 08ce2e0f9d36a5c5a02b0d1885081503e195390d'
[   14.937998][    T1] zswap: loaded using pool lzo/zsmalloc
[   14.945577][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   15.348632][    T1] ------------[ cut here ]------------
[   15.354159][    T1] refcount_t: decrement hit 0; leaking memory.
[   15.360853][    T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[   15.370031][    T1] Modules linked in:
[   15.374015][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-11136-g66a27abac311-dirty #0
[   15.383944][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   15.394635][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[   15.401092][    T1] Code: b2 00 00 00 e8 e7 9b f5 fc 5b 5d c3 cc cc cc c=
c e8 db 9b f5 fc c6 05 b8 1e d2 0a 01 90 48 c7 c7 60 da fd 8b e8 57 61 b8 f=
c 90 <0f> 0b 90 90 eb d9 e8 bb 9b f5 fc c6 05 95 1e d2 0a 01 90 48 c7 c7
[   15.421121][    T1] RSP: 0000:ffffc90000067668 EFLAGS: 00010246
[   15.427191][    T1] RAX: e1235bce1b62cf00 RBX: ffff88803032668c RCX: fff=
f8880166c8000
[   15.435218][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   15.443447][    T1] RBP: 0000000000000004 R08: ffffffff8157df32 R09: fff=
ffbfff1bf9660
[   15.451777][    T1] R10: dffffc0000000000 R11: fffffbfff1bf9660 R12: fff=
fea0001004000
[   15.459840][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: fff=
fea0001004008
[   15.468317][    T1] FS:  0000000000000000(0000) GS:ffff8880b9500000(0000=
) knlGS:0000000000000000
[   15.477318][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.483974][    T1] CR2: 0000000000000000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[   15.492092][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   15.500314][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   15.508269][    T1] Call Trace:
[   15.513679][    T1]  <TASK>
[   15.516698][    T1]  ? __warn+0x163/0x4b0
[   15.520937][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   15.526671][    T1]  ? report_bug+0x2b3/0x500
[   15.531428][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   15.536983][    T1]  ? handle_bug+0x3e/0x70
[   15.541430][    T1]  ? exc_invalid_op+0x1a/0x50
[   15.546283][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   15.551725][    T1]  ? __warn_printk+0x292/0x360
[   15.557114][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   15.562830][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[   15.568524][    T1]  free_unref_page_prepare+0x95d/0xa80
[   15.574314][    T1]  free_unref_page+0x37/0x3f0
[   15.579022][    T1]  free_contig_range+0x9e/0x160
[   15.584149][    T1]  destroy_args+0x8a/0x890
[   15.588646][    T1]  debug_vm_pgtable+0x4be/0x550
[   15.593527][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   15.598924][    T1]  ? __pfx_add_device_randomness+0x10/0x10
[   15.604940][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   15.610502][    T1]  do_one_initcall+0x238/0x830
[   15.615350][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   15.620738][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   15.626106][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   15.632176][    T1]  ? __pfx_parse_args+0x10/0x10
[   15.637014][    T1]  ? lockdep_hardirqs_on+0x99/0x150
[   15.642851][    T1]  ? rcu_is_watching+0x15/0xb0
[   15.647694][    T1]  do_initcall_level+0x157/0x210
[   15.652718][    T1]  do_initcalls+0x3f/0x80
[   15.657067][    T1]  kernel_init_freeable+0x435/0x5d0
[   15.662296][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   15.668107][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   15.674547][    T1]  ? __pfx_kernel_init+0x10/0x10
[   15.679619][    T1]  ? __pfx_kernel_init+0x10/0x10
[   15.684552][    T1]  ? __pfx_kernel_init+0x10/0x10
[   15.689518][    T1]  kernel_init+0x1d/0x2b0
[   15.693855][    T1]  ret_from_fork+0x4b/0x80
[   15.698260][    T1]  ? __pfx_kernel_init+0x10/0x10
[   15.703215][    T1]  ret_from_fork_asm+0x1a/0x30
[   15.708008][    T1]  </TASK>
[   15.711089][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   15.718361][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-11136-g66a27abac311-dirty #0
[   15.728316][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   15.738366][    T1] Call Trace:
[   15.741728][    T1]  <TASK>
[   15.744741][    T1]  dump_stack_lvl+0x241/0x360
[   15.749412][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[   15.754650][    T1]  ? __pfx__printk+0x10/0x10
[   15.759325][    T1]  ? vscnprintf+0x5d/0x90
[   15.763651][    T1]  panic+0x349/0x860
[   15.767594][    T1]  ? __warn+0x172/0x4b0
[   15.771736][    T1]  ? __pfx_panic+0x10/0x10
[   15.776157][    T1]  ? ret_from_fork_asm+0x1a/0x30
[   15.781165][    T1]  __warn+0x31e/0x4b0
[   15.785225][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   15.790902][    T1]  report_bug+0x2b3/0x500
[   15.795231][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   15.800875][    T1]  handle_bug+0x3e/0x70
[   15.805104][    T1]  exc_invalid_op+0x1a/0x50
[   15.809682][    T1]  asm_exc_invalid_op+0x1a/0x20
[   15.814549][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[   15.820611][    T1] Code: b2 00 00 00 e8 e7 9b f5 fc 5b 5d c3 cc cc cc c=
c e8 db 9b f5 fc c6 05 b8 1e d2 0a 01 90 48 c7 c7 60 da fd 8b e8 57 61 b8 f=
c 90 <0f> 0b 90 90 eb d9 e8 bb 9b f5 fc c6 05 95 1e d2 0a 01 90 48 c7 c7
[   15.840487][    T1] RSP: 0000:ffffc90000067668 EFLAGS: 00010246
[   15.846584][    T1] RAX: e1235bce1b62cf00 RBX: ffff88803032668c RCX: fff=
f8880166c8000
[   15.854803][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   15.862798][    T1] RBP: 0000000000000004 R08: ffffffff8157df32 R09: fff=
ffbfff1bf9660
[   15.870787][    T1] R10: dffffc0000000000 R11: fffffbfff1bf9660 R12: fff=
fea0001004000
[   15.878941][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: fff=
fea0001004008
[   15.887231][    T1]  ? __warn_printk+0x292/0x360
[   15.892088][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[   15.897560][    T1]  free_unref_page_prepare+0x95d/0xa80
[   15.903006][    T1]  free_unref_page+0x37/0x3f0
[   15.907714][    T1]  free_contig_range+0x9e/0x160
[   15.912573][    T1]  destroy_args+0x8a/0x890
[   15.916981][    T1]  debug_vm_pgtable+0x4be/0x550
[   15.921815][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   15.927183][    T1]  ? __pfx_add_device_randomness+0x10/0x10
[   15.932971][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   15.938411][    T1]  do_one_initcall+0x238/0x830
[   15.943437][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   15.948978][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   15.954251][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   15.960417][    T1]  ? __pfx_parse_args+0x10/0x10
[   15.965563][    T1]  ? lockdep_hardirqs_on+0x99/0x150
[   15.970756][    T1]  ? rcu_is_watching+0x15/0xb0
[   15.975499][    T1]  do_initcall_level+0x157/0x210
[   15.980614][    T1]  do_initcalls+0x3f/0x80
[   15.984954][    T1]  kernel_init_freeable+0x435/0x5d0
[   15.990162][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   15.996700][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   16.003016][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.008110][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.013192][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.018149][    T1]  kernel_init+0x1d/0x2b0
[   16.022473][    T1]  ret_from_fork+0x4b/0x80
[   16.026961][    T1]  ? __pfx_kernel_init+0x10/0x10
[   16.031885][    T1]  ret_from_fork_asm+0x1a/0x30
[   16.036835][    T1]  </TASK>
[   16.040270][    T1] Kernel Offset: disabled
[   16.044588][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2856129853=3D/tmp/go-build -gno-record-gc=
c-switches'

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
https://syzkaller.appspot.com/x/error.txt?x=3D10f21d66180000


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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D119687111800=
00


