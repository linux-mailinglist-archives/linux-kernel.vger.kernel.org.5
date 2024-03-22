Return-Path: <linux-kernel+bounces-111316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC930886A95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33309B25AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12B83EA66;
	Fri, 22 Mar 2024 10:42:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EF3E487
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104125; cv=none; b=Q3exfIW8uoo+qrfsqmV+4CQqO5Tx500iZ3LJ256Dc369qCvBVRPt6xMfVGYb6026qqaBlQ3gOVMz1cTA4dE63x8GaAanjihupd9Gpv/FzMeL6IVOofuCl6A7KxqqEoBCzV+bnJL+nUwctSz6CHS39nKhAZn93I7WIW7FyThzDWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104125; c=relaxed/simple;
	bh=WGlen2OLdklRg+xIdxND2HizhKKN6xHzwsnEH6wUSvQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bZnARisXlE9z/sEF3jn6Jn2KtU0YVE9WXmUO6jObXbMGp6KGkqT2gfsT3NFnN1w6zzylfLSGBZHhnZZxb0O64bfxhcuNx2o26/NEyI+971go5csm3u7lo4YMAQ16m2MkzduJ7vBwJkZMczO5x60HVt8JQXbpb8ZPZRGEL8uNNYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3673c792f3eso18337455ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711104122; x=1711708922;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlOeBRrbxTtKZrnomrD8yd/twiq+3+2FYOcgMTzky80=;
        b=I/EtAzsytJbDL2lF320W/xGQL3rgl8vlt9Wfc3arKebKg6imajeqMdHF9/dNaLnNhM
         IKM4DcbEjqlYNq/vDsETZpV/zvs5g5kryZkFfw9H8GpfJS61HJkT9DxzDzSXiDNnDY2C
         Aj+q/dxZZ38as2LXaHLEtXiqEXD3S6x3qbH5fKKiI1AmDr7IdnmQud/GZYvFQjg5snvl
         +/FIND+kLBLa5NkBUq4ahYNdwRgyvPG46CK6Ccys01DuPCk7szIFpIf9gT2Bq2KHZW8q
         u9ODgt0zQ3YlxpNh25vHzI/hvlYUGOl11twfjhBxOQjXDtYjbWyyKghXkvO+FDM4jK0y
         K79Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBaWxRtR9wv6Yh0vkc67LuPSt+iXJtCVpP2HjCLDBMdq8RsJAhV5XyW1HnKhwYbisTPpd9azMNjsK3dsdE5B3oiMc/hryXG3lppl+I
X-Gm-Message-State: AOJu0YyMAk+ma4STZ6kyK8pEpxz6m61626X9T1cl6vDN7BvhUMVZe+68
	o8ARhzQHWpA1i3gYJruEOy5/ObV7bFz3Az0vTXAjYb+RwwLE93IWr0skjlJnwYO7sLbWgWaHzis
	Ps1uk69Om9xDELS9i1hsi5Y93h+zR3FBJdqbnLbV1P4S3PI13tP4HHmE=
X-Google-Smtp-Source: AGHT+IHrRuTfKLBxJJmQt7Glj6NhpBr4tlYOG6uSI3qJa+leqeeLpt+eADTHq+FPNrT6RnyVuTyIpDMtlVQ6Zf4F4X7CjN0yp/u2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e3:b0:368:754e:f5b7 with SMTP id
 q3-20020a056e0220e300b00368754ef5b7mr55389ilv.2.1711104122090; Fri, 22 Mar
 2024 03:42:02 -0700 (PDT)
Date: Fri, 22 Mar 2024 03:42:02 -0700
In-Reply-To: <tencent_57A1EED82EC60C94E7EDC6DA12C306474906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f088906143d79e7@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
From: syzbot <syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ly
[   13.243082][    T1] X25: Linux Version 0.2
[   13.292064][    T1] NET: Registered PF_NETROM protocol family
[   13.343313][    T1] NET: Registered PF_ROSE protocol family
[   13.349296][    T1] NET: Registered PF_AX25 protocol family
[   13.355995][    T1] can: controller area network core
[   13.361609][    T1] NET: Registered PF_CAN protocol family
[   13.367325][    T1] can: raw protocol
[   13.371880][    T1] can: broadcast manager protocol
[   13.376970][    T1] can: netlink gateway - max_hops=3D1
[   13.382696][    T1] can: SAE J1939
[   13.386246][    T1] can: isotp protocol (max_pdu_size 8300)
[   13.392393][    T1] Bluetooth: RFCOMM TTY layer initialized
[   13.398148][    T1] Bluetooth: RFCOMM socket layer initialized
[   13.405038][    T1] Bluetooth: RFCOMM ver 1.11
[   13.409743][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   13.415895][    T1] Bluetooth: BNEP filters: protocol multicast
[   13.422062][    T1] Bluetooth: BNEP socket layer initialized
[   13.427913][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   13.433798][    T1] Bluetooth: CMTP socket layer initialized
[   13.439683][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   13.446589][    T1] Bluetooth: HIDP socket layer initialized
[   13.455663][    T1] NET: Registered PF_RXRPC protocol family
[   13.461694][    T1] Key type rxrpc registered
[   13.466180][    T1] Key type rxrpc_s registered
[   13.471908][    T1] NET: Registered PF_KCM protocol family
[   13.478501][    T1] lec:lane_module_init: lec.c: initialized
[   13.484387][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   13.490222][    T1] l2tp_core: L2TP core driver, V2.0
[   13.495433][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   13.501085][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   13.507588][    T1] l2tp_netlink: L2TP netlink interface
[   13.513727][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   13.520521][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   13.528163][    T1] NET: Registered PF_PHONET protocol family
[   13.534342][    T1] 8021q: 802.1Q VLAN Support v1.8
[   13.553054][    T1] DCCP: Activated CCID 2 (TCP-like)
[   13.558374][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   13.565874][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   13.577035][    T1] sctp: Hash tables configured (bind 32/56)
[   13.584677][    T1] NET: Registered PF_RDS protocol family
[   13.591398][    T1] Registered RDS/infiniband transport
[   13.597871][    T1] Registered RDS/tcp transport
[   13.602694][    T1] tipc: Activated (version 2.0.0)
[   13.608498][    T1] NET: Registered PF_TIPC protocol family
[   13.615258][    T1] tipc: Started in single node mode
[   13.621255][    T1] NET: Registered PF_SMC protocol family
[   13.627139][    T1] 9pnet: Installing 9P2000 support
[   13.633262][    T1] NET: Registered PF_CAIF protocol family
[   13.643520][    T1] NET: Registered PF_IEEE802154 protocol family
[   13.650024][    T1] Key type dns_resolver registered
[   13.655322][    T1] Key type ceph registered
[   13.660315][    T1] libceph: loaded (mon/osd proto 15/24)
[   13.667023][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.1 (compatibil=
ity version 15) loaded
[   13.676163][    T1] openvswitch: Open vSwitch switching datapath
[   13.685504][    T1] NET: Registered PF_VSOCK protocol family
[   13.692734][    T1] mpls_gso: MPLS GSO support
[   13.713085][    T1] IPI shorthand broadcast: enabled
[   13.718324][    T1] AVX2 version of gcm_enc/dec engaged.
[   13.724817][    T1] AES CTR mode by8 optimization enabled
[   15.093071][    T1] sched_clock: Marking stable (15050030128, 39570184)-=
>(15098082991, -8482679)
[   15.103483][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   15.113749][    T1] registered taskstats version 1
[   15.123705][    T1] meta:ffffc90000066170, maptr:0000000000000000, check=
_helper_call
[   15.132660][    T1] general protection fault, probably for non-canonical=
 address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
[   15.144894][    T1] KASAN: null-ptr-deref in range [0x0000000000000018-0=
x000000000000001f]
[   15.153438][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-05232-gddb2ffdc474a-dirty #0
[   15.163497][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   15.173648][    T1] RIP: 0010:check_helper_call+0x14ec/0x7620
[   15.179554][    T1] Code: 8d bc 24 70 01 00 00 e8 62 f7 4c 00 4c 8b a4 2=
4 70 01 00 00 49 8d 7c 24 1c 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc f=
f df <0f> b6 04 08 84 c0 0f 85 67 17 00 00 41 8b 5c 24 1c 49 8d 7c 24 20
[   15.199330][    T1] RSP: 0000:ffffc90000066000 EFLAGS: 00010207
[   15.205657][    T1] RAX: 0000000000000003 RBX: 0000000000008004 RCX: dff=
ffc0000000000
[   15.213721][    T1] RDX: ffff8880162d0000 RSI: 0000000000008004 RDI: 000=
000000000001c
[   15.221695][    T1] RBP: ffffc90000066250 R08: ffffffff81ab43c7 R09: 1ff=
ff9200000cb54
[   15.229826][    T1] R10: dffffc0000000000 R11: fffff5200000cb55 R12: 000=
0000000000000
[   15.238066][    T1] R13: 0000000000000001 R14: ffff88802e208000 R15: 000=
0000000008004
[   15.246307][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[   15.255391][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.261971][    T1] CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[   15.269930][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   15.277901][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   15.285863][    T1] Call Trace:
[   15.289137][    T1]  <TASK>
[   15.292167][    T1]  ? __die_body+0x88/0xe0
[   15.296480][    T1]  ? die_addr+0x108/0x140
[   15.300794][    T1]  ? exc_general_protection+0x3dd/0x5d0
[   15.306433][    T1]  ? asm_exc_general_protection+0x26/0x30
[   15.312151][    T1]  ? check_helper_call+0x13d7/0x7620
[   15.317696][    T1]  ? check_helper_call+0x14ec/0x7620
[   15.323087][    T1]  ? __pfx_check_helper_call+0x10/0x10
[   15.328743][    T1]  ? tnum_const+0xd/0x20
[   15.333063][    T1]  do_check+0x9e29/0x10530
[   15.337512][    T1]  ? kmalloc_trace+0x1d9/0x360
[   15.342265][    T1]  ? do_check_common+0x190/0x1dd0
[   15.347908][    T1]  ? bpf_check+0x136ab/0x19010
[   15.352746][    T1]  ? kernel_init+0x1d/0x2a0
[   15.357416][    T1]  ? ret_from_fork+0x4b/0x80
[   15.362091][    T1]  ? __pfx_do_check+0x10/0x10
[   15.366750][    T1]  ? mark_reg_not_init+0xd4/0x4b0
[   15.372015][    T1]  ? __asan_memcpy+0x40/0x70
[   15.376588][    T1]  ? mark_reg_not_init+0xd4/0x4b0
[   15.381594][    T1]  do_check_common+0x14bd/0x1dd0
[   15.386655][    T1]  bpf_check+0x136ab/0x19010
[   15.391261][    T1]  ? __pfx_validate_chain+0x10/0x10
[   15.396455][    T1]  ? validate_chain+0x11b/0x58e0
[   15.401383][    T1]  ? validate_chain+0x11b/0x58e0
[   15.406524][    T1]  ? validate_chain+0x11b/0x58e0
[   15.411641][    T1]  ? validate_chain+0x11b/0x58e0
[   15.416565][    T1]  ? __pfx_bpf_check+0x10/0x10
[   15.421319][    T1]  ? __pfx_validate_chain+0x10/0x10
[   15.426499][    T1]  ? mark_lock+0x9a/0x350
[   15.430811][    T1]  ? mark_lock+0x9a/0x350
[   15.435122][    T1]  ? __lock_acquire+0x1346/0x1fd0
[   15.440128][    T1]  ? mark_lock+0x9a/0x350
[   15.444451][    T1]  ? __lock_acquire+0x1346/0x1fd0
[   15.449546][    T1]  ? mark_lock+0x9a/0x350
[   15.453880][    T1]  ? __lock_acquire+0x1346/0x1fd0
[   15.458925][    T1]  ? __pfx_lock_acquire+0x10/0x10
[   15.463951][    T1]  ? ktime_get_with_offset+0x105/0x330
[   15.469575][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   15.476306][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   15.482659][    T1]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   15.488838][    T1]  ? ktime_get_with_offset+0x105/0x330
[   15.494460][    T1]  ? seqcount_lockdep_reader_access+0x157/0x220
[   15.500687][    T1]  ? lockdep_hardirqs_on+0x99/0x150
[   15.505871][    T1]  ? seqcount_lockdep_reader_access+0x1d7/0x220
[   15.512096][    T1]  ? __pfx_seqcount_lockdep_reader_access+0x10/0x10
[   15.518670][    T1]  ? pcpu_alloc+0xf1a/0x1670
[   15.523350][    T1]  ? bpf_obj_name_cpy+0x18a/0x1d0
[   15.528458][    T1]  ? bpf_lsm_bpf_prog_load+0x9/0x10
[   15.533651][    T1]  ? security_bpf_prog_load+0x87/0xb0
[   15.539207][    T1]  bpf_prog_load+0x1667/0x20f0
[   15.544077][    T1]  ? __pfx_bpf_prog_load+0x10/0x10
[   15.549174][    T1]  ? kasan_quarantine_put+0xdc/0x230
[   15.554552][    T1]  ? map_update_elem+0x363/0x6f0
[   15.559475][    T1]  ? copy_from_kernel_nofault_allowed+0xa9/0x130
[   15.565786][    T1]  ? bpf_lsm_bpf+0x9/0x10
[   15.570102][    T1]  ? security_bpf+0x87/0xb0
[   15.574700][    T1]  __sys_bpf+0x4ee/0x810
[   15.579189][    T1]  ? __pfx___sys_bpf+0x10/0x10
[   15.584016][    T1]  kern_sys_bpf+0x185/0x6b0
[   15.588592][    T1]  ? __pfx_kern_sys_bpf+0x10/0x10
[   15.593801][    T1]  ? load+0xf4/0xfd0
[   15.597854][    T1]  ? kmalloc_trace+0x1d9/0x360
[   15.602706][    T1]  ? load+0x40e/0xfd0
[   15.606676][    T1]  load+0x550/0xfd0
[   15.610560][    T1]  ? __pfx_load+0x10/0x10
[   15.615004][    T1]  ? kasan_save_track+0x51/0x80
[   15.619962][    T1]  ? kasan_save_track+0x3f/0x80
[   15.624889][    T1]  ? __kasan_kmalloc+0x98/0xb0
[   15.629899][    T1]  ? __kmalloc_node+0x251/0x4e0
[   15.634736][    T1]  ? alloc_bulk+0x472/0x6f0
[   15.639225][    T1]  ? bpf_mem_alloc_init+0x47d/0xc50
[   15.644423][    T1]  ? cpumask_kfunc_init+0x98/0x150
[   15.649710][    T1]  ? do_one_initcall+0x238/0x830
[   15.654739][    T1]  ? do_initcall_level+0x157/0x210
[   15.659948][    T1]  ? do_initcalls+0x3f/0x80
[   15.664643][    T1]  ? kernel_init_freeable+0x435/0x5d0
[   15.670263][    T1]  ? kernel_init+0x1d/0x2a0
[   15.674937][    T1]  ? ret_from_fork+0x4b/0x80
[   15.684622][    T1]  ? ret_from_fork_asm+0x1a/0x30
[   15.689876][    T1]  ? mark_lock+0x9a/0x350
[   15.694286][    T1]  ? __lock_acquire+0x1346/0x1fd0
[   15.699402][    T1]  ? _raw_spin_unlock_irqrestore+0x8f/0x140
[   15.705953][    T1]  ? lockdep_hardirqs_on+0x99/0x150
[   15.711328][    T1]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   15.717218][    T1]  ? __pfx_add_device_randomness+0x10/0x10
[   15.723251][    T1]  ? __pfx_load+0x10/0x10
[   15.727637][    T1]  do_one_initcall+0x238/0x830
[   15.732504][    T1]  ? __pfx_load+0x10/0x10
[   15.736814][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   15.743306][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   15.748700][    T1]  ? __pfx_parse_args+0x10/0x10
[   15.753887][    T1]  ? do_initcalls+0x1c/0x80
[   15.758588][    T1]  ? rcu_is_watching+0x15/0xb0
[   15.763350][    T1]  do_initcall_level+0x157/0x210
[   15.768389][    T1]  do_initcalls+0x3f/0x80
[   15.772732][    T1]  kernel_init_freeable+0x435/0x5d0
[   15.777955][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   15.783663][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   15.789977][    T1]  ? __pfx_kernel_init+0x10/0x10
[   15.794990][    T1]  ? __pfx_kernel_init+0x10/0x10
[   15.800002][    T1]  ? __pfx_kernel_init+0x10/0x10
[   15.804935][    T1]  kernel_init+0x1d/0x2a0
[   15.809370][    T1]  ret_from_fork+0x4b/0x80
[   15.813832][    T1]  ? __pfx_kernel_init+0x10/0x10
[   15.818780][    T1]  ret_from_fork_asm+0x1a/0x30
[   15.823558][    T1]  </TASK>
[   15.826588][    T1] Modules linked in:
[   15.830703][    T1] ---[ end trace 0000000000000000 ]---
[   15.836626][    T1] RIP: 0010:check_helper_call+0x14ec/0x7620
[   15.843209][    T1] Code: 8d bc 24 70 01 00 00 e8 62 f7 4c 00 4c 8b a4 2=
4 70 01 00 00 49 8d 7c 24 1c 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc f=
f df <0f> b6 04 08 84 c0 0f 85 67 17 00 00 41 8b 5c 24 1c 49 8d 7c 24 20
[   15.863225][    T1] RSP: 0000:ffffc90000066000 EFLAGS: 00010207
[   15.869311][    T1] RAX: 0000000000000003 RBX: 0000000000008004 RCX: dff=
ffc0000000000
[   15.877516][    T1] RDX: ffff8880162d0000 RSI: 0000000000008004 RDI: 000=
000000000001c
[   15.885761][    T1] RBP: ffffc90000066250 R08: ffffffff81ab43c7 R09: 1ff=
ff9200000cb54
[   15.893940][    T1] R10: dffffc0000000000 R11: fffff5200000cb55 R12: 000=
0000000000000
[   15.902193][    T1] R13: 0000000000000001 R14: ffff88802e208000 R15: 000=
0000000008004
[   15.910257][    T1] FS:  0000000000000000(0000) GS:ffff8880b9500000(0000=
) knlGS:0000000000000000
[   15.919196][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.925873][    T1] CR2: 0000000000000000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[   15.933923][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   15.942979][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   15.951017][    T1] Kernel panic - not syncing: Fatal exception
[   15.957777][    T1] Kernel Offset: disabled
[   15.962097][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3260162229=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at baa80228d
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
/syzkaller/prog.GitRevision=3Dbaa80228d652d8b1341ecf7f1411c4e4caf75bd5 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240318-105857'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dbaa80228d652d8b1341ecf7f1411c4e4caf75bd5 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240318-105857'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dbaa80228d652d8b1341ecf7f1411c4e4caf75bd5 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240318-105857'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"baa80228d652d8b1341ecf7f1411c4e4ca=
f75bd5\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D13b0b5c9180000


Tested on:

commit:         ddb2ffdc libbpf: Define MFD_CLOEXEC if not available
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git=
 master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a193d44=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D33f4297b5f9276487=
41a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1702b4811800=
00


