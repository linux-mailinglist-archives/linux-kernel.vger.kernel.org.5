Return-Path: <linux-kernel+bounces-110156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF517885AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66955B239CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941984A5A;
	Thu, 21 Mar 2024 14:39:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCB41C71
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031944; cv=none; b=QgzNboCdI0mh3U86Hpdk/0Bo2hYnmZbj7jxQDE1j8To1lcODyjlraq2Kqaj8Z8+PHXpPfQqg9kA1oifsCOBQcscr8UAsHayG1l3RjKhp0xYQiZDryzbcCEY/SOzBUevxJr92lRTueVTgm5ecd1PAApVt0RV8YpFMCKLnodfSNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031944; c=relaxed/simple;
	bh=3ssEIDTQuuCn4km8Qf2Z1+SZJ+iKmL8OfuUecWuy77Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gXW9185FwYwzvYCJQ9q6Pg+Ap5094kh/p3cyFJEpgO3zEfQ9r74MJHjB62yfiCN2Tq8ACWo7Yd+T66SpTzy0DIix6WHNlHln+OxGZFtOSX2+w4cUKcRLR9pLTjEtisPxc7xEArEFcwO8NmoUgOiVjo7y4vbVdYD0I2f0b6SHl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc044e7456so92041039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711031941; x=1711636741;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLK2EBMFw4iQONFF0EaRJ8qiyeGEunqSprB4UJi7lX0=;
        b=oFiHLiZiJhj7mYgNXEgHRrR/9QO3e62q2aNjX/f1B38D5QujoNt2sOZiedpTud5NzL
         XkDipBpqD6bOLjXhqmtVueeaw64vyokSwFBeCjm+NaVRvBoZ3cZkVmw8uiC6iSP4FTK4
         cUbuuOR3WCzIElC+bGHbjOyby99LUFiUWqsbnhZULwpI2o+4m+63/mvkTMr+6boF66Sg
         6DeKJTNHQvQ42NJ4HXoJulzftb0bLs6AcMW8t2HJ/VFb1kdlJa5P0e365qUw7iTPYTgR
         hhmZljAoHWIJMimGJSsBgXmVQmrBnJBEWzveZjTo2S/7HhM6KkEvs2Q2brFg8L5czooM
         i9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCX8pzeDOz6MIt6ckqvx7tJxdikA7vxR4GwP06JpiFkqZXPoTocNj8CenzY2eSiyjUKNuciG67QK8bQoKmfQwk0ljVfpGEdbsPEqvnHZ
X-Gm-Message-State: AOJu0YyiaZvTZ9LoDomv2ejlLgwIk3dD86sZ5Uy81L9pOwNYjdGETlL/
	r98QI3WRmL24eApI+tLyc1sgiWBnuRtEmXjUJPk0I+RbHVbEHof/H7iqN7rujPCEXziXRbrycXg
	SwpzBeqECmG5j+HAhoAjwunsysaUPUT0qv7sZGj9k/IY5Nrrp54TdTOA=
X-Google-Smtp-Source: AGHT+IGtgyCn7CcVZG+cHKw34O+rRdsSjU23gCBmmpm7u5CaBc+vTw0HM02m+zCrbjj1cldtDbt29wroNH5e0PUYrduY0qa5DQ7q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c94:b0:7cc:342:72f9 with SMTP id
 i20-20020a0566022c9400b007cc034272f9mr369352iow.2.1711031941285; Thu, 21 Mar
 2024 07:39:01 -0700 (PDT)
Date: Thu, 21 Mar 2024 07:39:01 -0700
In-Reply-To: <tencent_1FB08DB4A5808DDF12555DA6DDE799744F07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f5e2906142cab26@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
From: syzbot <syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ocol family
[   11.721719][    T1] NET: Registered PF_ROSE protocol family
[   11.729719][    T1] NET: Registered PF_AX25 protocol family
[   11.735660][    T1] can: controller area network core
[   11.742759][    T1] NET: Registered PF_CAN protocol family
[   11.748916][    T1] can: raw protocol
[   11.752863][    T1] can: broadcast manager protocol
[   11.757998][    T1] can: netlink gateway - max_hops=3D1
[   11.763319][    T1] can: SAE J1939
[   11.766850][    T1] can: isotp protocol (max_pdu_size 8300)
[   11.773552][    T1] Bluetooth: RFCOMM TTY layer initialized
[   11.779399][    T1] Bluetooth: RFCOMM socket layer initialized
[   11.785432][    T1] Bluetooth: RFCOMM ver 1.11
[   11.790172][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   11.796312][    T1] Bluetooth: BNEP filters: protocol multicast
[   11.802789][    T1] Bluetooth: BNEP socket layer initialized
[   11.809184][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   11.815016][    T1] Bluetooth: CMTP socket layer initialized
[   11.820951][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   11.827828][    T1] Bluetooth: HIDP socket layer initialized
[   11.837659][    T1] NET: Registered PF_RXRPC protocol family
[   11.843508][    T1] Key type rxrpc registered
[   11.848040][    T1] Key type rxrpc_s registered
[   11.853631][    T1] NET: Registered PF_KCM protocol family
[   11.860130][    T1] lec:lane_module_init: lec.c: initialized
[   11.865944][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   11.872062][    T1] l2tp_core: L2TP core driver, V2.0
[   11.877329][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   11.882971][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   11.889548][    T1] l2tp_netlink: L2TP netlink interface
[   11.895277][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   11.902381][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   11.910064][    T1] NET: Registered PF_PHONET protocol family
[   11.916248][    T1] 8021q: 802.1Q VLAN Support v1.8
[   11.934795][    T1] DCCP: Activated CCID 2 (TCP-like)
[   11.940297][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   11.947385][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   11.958542][    T1] sctp: Hash tables configured (bind 32/56)
[   11.966039][    T1] NET: Registered PF_RDS protocol family
[   11.972547][    T1] Registered RDS/infiniband transport
[   11.979222][    T1] Registered RDS/tcp transport
[   11.984224][    T1] tipc: Activated (version 2.0.0)
[   11.990037][    T1] NET: Registered PF_TIPC protocol family
[   11.996601][    T1] tipc: Started in single node mode
[   12.002800][    T1] NET: Registered PF_SMC protocol family
[   12.009698][    T1] 9pnet: Installing 9P2000 support
[   12.015903][    T1] NET: Registered PF_CAIF protocol family
[   12.026175][    T1] NET: Registered PF_IEEE802154 protocol family
[   12.032826][    T1] Key type dns_resolver registered
[   12.038192][    T1] Key type ceph registered
[   12.043168][    T1] libceph: loaded (mon/osd proto 15/24)
[   12.050090][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.1 (compatibil=
ity version 15) loaded
[   12.060608][    T1] openvswitch: Open vSwitch switching datapath
[   12.070242][    T1] NET: Registered PF_VSOCK protocol family
[   12.076372][    T1] mpls_gso: MPLS GSO support
[   12.097330][    T1] IPI shorthand broadcast: enabled
[   12.102869][    T1] AVX2 version of gcm_enc/dec engaged.
[   12.108892][    T1] AES CTR mode by8 optimization enabled
[   13.500244][    T1] sched_clock: Marking stable (13460031426, 37162474)-=
>(13499967596, -2773696)
[   13.516849][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   13.528203][    T1] registered taskstats version 1
[   13.534887][    T1] general protection fault, probably for non-canonical=
 address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
[   13.547040][    T1] KASAN: null-ptr-deref in range [0x0000000000000018-0=
x000000000000001f]
[   13.555448][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-05231-ga51cd6bf8e10-dirty #0
[   13.565246][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   13.575304][    T1] RIP: 0010:check_helper_call+0x113d/0x76b0
[   13.581246][    T1] Code: 48 8d bc 24 70 01 00 00 e8 a0 fb 4c 00 4c 8b b=
4 24 70 01 00 00 49 8d 7e 1c 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc f=
f df <0f> b6 04 08 84 c0 0f 85 33 59 00 00 45 8b 66 1c 49 8d 7e 20 48 89
[   13.601839][    T1] RSP: 0000:ffffc90000066000 EFLAGS: 00010207
[   13.607897][    T1] RAX: 0000000000000003 RBX: 0000000000000000 RCX: dff=
ffc0000000000
[   13.615863][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
000000000001c
[   13.623838][    T1] RBP: ffffc90000066250 R08: ffffffff81ab3c9e R09: fff=
fffff81ab66aa
[   13.631800][    T1] R10: 0000000000000002 R11: ffff8880162d0000 R12: fff=
fffff8baff368
[   13.639935][    T1] R13: 1ffff9200000cc28 R14: 0000000000000000 R15: dff=
ffc0000000000
[   13.648268][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[   13.660039][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.666609][    T1] CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[   13.674655][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   13.682811][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   13.690867][    T1] Call Trace:
[   13.694157][    T1]  <TASK>
[   13.697082][    T1]  ? __die_body+0x88/0xe0
[   13.701706][    T1]  ? die_addr+0x108/0x140
[   13.706041][    T1]  ? exc_general_protection+0x3dd/0x5d0
[   13.711612][    T1]  ? asm_exc_general_protection+0x26/0x30
[   13.717553][    T1]  ? check_helper_call+0x36ba/0x76b0
[   13.723267][    T1]  ? check_helper_call+0xcae/0x76b0
[   13.728546][    T1]  ? check_helper_call+0x113d/0x76b0
[   13.733831][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   13.739891][    T1]  ? __pfx_check_helper_call+0x10/0x10
[   13.751844][    T1]  ? reg_bounds_sanity_check+0x7b2/0xa20
[   13.757490][    T1]  ? tnum_const+0xd/0x20
[   13.761901][    T1]  do_check+0x9e29/0x10530
[   13.766314][    T1]  ? kmalloc_trace+0x1d9/0x360
[   13.771068][    T1]  ? do_check_common+0x190/0x1dd0
[   13.776172][    T1]  ? bpf_check+0x136ab/0x19010
[   13.780919][    T1]  ? kernel_init+0x1d/0x2a0
[   13.785402][    T1]  ? ret_from_fork+0x4b/0x80
[   13.789980][    T1]  ? __pfx_do_check+0x10/0x10
[   13.794877][    T1]  ? mark_reg_not_init+0xd4/0x4b0
[   13.799933][    T1]  ? __asan_memcpy+0x40/0x70
[   13.804688][    T1]  ? mark_reg_not_init+0xd4/0x4b0
[   13.809695][    T1]  do_check_common+0x14bd/0x1dd0
[   13.814643][    T1]  bpf_check+0x136ab/0x19010
[   13.819224][    T1]  ? __pfx_validate_chain+0x10/0x10
[   13.824407][    T1]  ? validate_chain+0x11b/0x58e0
[   13.829323][    T1]  ? validate_chain+0x11b/0x58e0
[   13.834278][    T1]  ? validate_chain+0x11b/0x58e0
[   13.839287][    T1]  ? validate_chain+0x11b/0x58e0
[   13.844302][    T1]  ? __pfx_bpf_check+0x10/0x10
[   13.849168][    T1]  ? __pfx_validate_chain+0x10/0x10
[   13.854372][    T1]  ? mark_lock+0x9a/0x350
[   13.858697][    T1]  ? mark_lock+0x9a/0x350
[   13.863019][    T1]  ? __lock_acquire+0x1346/0x1fd0
[   13.868213][    T1]  ? mark_lock+0x9a/0x350
[   13.872597][    T1]  ? __lock_acquire+0x1346/0x1fd0
[   13.877768][    T1]  ? mark_lock+0x9a/0x350
[   13.882276][    T1]  ? __lock_acquire+0x1346/0x1fd0
[   13.887379][    T1]  ? __pfx_lock_acquire+0x10/0x10
[   13.892384][    T1]  ? ktime_get_with_offset+0x105/0x330
[   13.897995][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   13.904156][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   13.910768][    T1]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   13.917288][    T1]  ? ktime_get_with_offset+0x105/0x330
[   13.922910][    T1]  ? seqcount_lockdep_reader_access+0x157/0x220
[   13.929217][    T1]  ? lockdep_hardirqs_on+0x99/0x150
[   13.934406][    T1]  ? seqcount_lockdep_reader_access+0x1d7/0x220
[   13.940657][    T1]  ? __pfx_seqcount_lockdep_reader_access+0x10/0x10
[   13.947674][    T1]  ? pcpu_alloc+0xf1a/0x1670
[   13.952256][    T1]  ? bpf_obj_name_cpy+0x18a/0x1d0
[   13.957261][    T1]  ? bpf_lsm_bpf_prog_load+0x9/0x10
[   13.962451][    T1]  ? security_bpf_prog_load+0x87/0xb0
[   13.967821][    T1]  bpf_prog_load+0x1667/0x20f0
[   13.972819][    T1]  ? __pfx_bpf_prog_load+0x10/0x10
[   13.978234][    T1]  ? kasan_quarantine_put+0xdc/0x230
[   13.983684][    T1]  ? map_update_elem+0x363/0x6f0
[   13.988601][    T1]  ? copy_from_kernel_nofault_allowed+0xa9/0x130
[   13.994944][    T1]  ? bpf_lsm_bpf+0x9/0x10
[   13.999430][    T1]  ? security_bpf+0x87/0xb0
[   14.003930][    T1]  __sys_bpf+0x4ee/0x810
[   14.008173][    T1]  ? __pfx___sys_bpf+0x10/0x10
[   14.012929][    T1]  kern_sys_bpf+0x185/0x6b0
[   14.017420][    T1]  ? __pfx_kern_sys_bpf+0x10/0x10
[   14.022429][    T1]  ? load+0xf4/0xfd0
[   14.026397][    T1]  ? kmalloc_trace+0x1d9/0x360
[   14.031153][    T1]  ? load+0x40e/0xfd0
[   14.035426][    T1]  load+0x550/0xfd0
[   14.039405][    T1]  ? __pfx_load+0x10/0x10
[   14.043720][    T1]  ? kasan_save_track+0x51/0x80
[   14.048558][    T1]  ? kasan_save_track+0x3f/0x80
[   14.053476][    T1]  ? __kasan_kmalloc+0x98/0xb0
[   14.058229][    T1]  ? __kmalloc_node+0x251/0x4e0
[   14.063154][    T1]  ? alloc_bulk+0x472/0x6f0
[   14.067634][    T1]  ? bpf_mem_alloc_init+0x47d/0xc50
[   14.073107][    T1]  ? cpumask_kfunc_init+0x98/0x150
[   14.078385][    T1]  ? do_one_initcall+0x238/0x830
[   14.083663][    T1]  ? do_initcall_level+0x157/0x210
[   14.088981][    T1]  ? do_initcalls+0x3f/0x80
[   14.093672][    T1]  ? kernel_init_freeable+0x435/0x5d0
[   14.099031][    T1]  ? kernel_init+0x1d/0x2a0
[   14.103530][    T1]  ? ret_from_fork+0x4b/0x80
[   14.108136][    T1]  ? ret_from_fork_asm+0x1a/0x30
[   14.113154][    T1]  ? mark_lock+0x9a/0x350
[   14.117670][    T1]  ? __lock_acquire+0x1346/0x1fd0
[   14.122697][    T1]  ? _raw_spin_unlock_irqrestore+0x8f/0x140
[   14.128591][    T1]  ? lockdep_hardirqs_on+0x99/0x150
[   14.133952][    T1]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   14.139832][    T1]  ? __pfx_add_device_randomness+0x10/0x10
[   14.145719][    T1]  ? __pfx_load+0x10/0x10
[   14.150121][    T1]  do_one_initcall+0x238/0x830
[   14.154863][    T1]  ? __pfx_load+0x10/0x10
[   14.159166][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   14.166079][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   14.171368][    T1]  ? __pfx_parse_args+0x10/0x10
[   14.176223][    T1]  ? do_initcalls+0x1c/0x80
[   14.181017][    T1]  ? rcu_is_watching+0x15/0xb0
[   14.185910][    T1]  do_initcall_level+0x157/0x210
[   14.190924][    T1]  do_initcalls+0x3f/0x80
[   14.195251][    T1]  kernel_init_freeable+0x435/0x5d0
[   14.200463][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   14.206174][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   14.212486][    T1]  ? __pfx_kernel_init+0x10/0x10
[   14.217521][    T1]  ? __pfx_kernel_init+0x10/0x10
[   14.222482][    T1]  ? __pfx_kernel_init+0x10/0x10
[   14.227773][    T1]  kernel_init+0x1d/0x2a0
[   14.232101][    T1]  ret_from_fork+0x4b/0x80
[   14.236503][    T1]  ? __pfx_kernel_init+0x10/0x10
[   14.241421][    T1]  ret_from_fork_asm+0x1a/0x30
[   14.246167][    T1]  </TASK>
[   14.249165][    T1] Modules linked in:
[   14.253332][    T1] ---[ end trace 0000000000000000 ]---
[   14.259150][    T1] RIP: 0010:check_helper_call+0x113d/0x76b0
[   14.265131][    T1] Code: 48 8d bc 24 70 01 00 00 e8 a0 fb 4c 00 4c 8b b=
4 24 70 01 00 00 49 8d 7e 1c 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc f=
f df <0f> b6 04 08 84 c0 0f 85 33 59 00 00 45 8b 66 1c 49 8d 7e 20 48 89
[   14.285348][    T1] RSP: 0000:ffffc90000066000 EFLAGS: 00010207
[   14.291474][    T1] RAX: 0000000000000003 RBX: 0000000000000000 RCX: dff=
ffc0000000000
[   14.299537][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
000000000001c
[   14.307519][    T1] RBP: ffffc90000066250 R08: ffffffff81ab3c9e R09: fff=
fffff81ab66aa
[   14.315662][    T1] R10: 0000000000000002 R11: ffff8880162d0000 R12: fff=
fffff8baff368
[   14.323705][    T1] R13: 1ffff9200000cc28 R14: 0000000000000000 R15: dff=
ffc0000000000
[   14.331703][    T1] FS:  0000000000000000(0000) GS:ffff8880b9500000(0000=
) knlGS:0000000000000000
[   14.340738][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.347336][    T1] CR2: 0000000000000000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[   14.355310][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   14.363321][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   14.371501][    T1] Kernel panic - not syncing: Fatal exception
[   14.378082][    T1] Kernel Offset: disabled
[   14.382392][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build516019239=3D/tmp/go-build -gno-record-gcc=
-switches'

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
https://syzkaller.appspot.com/x/error.txt?x=3D15ca4c81180000


Tested on:

commit:         a51cd6bf arm64: bpf: fix 32bit unconditional bswap
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git=
 master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a193d44=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D33f4297b5f9276487=
41a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D134ceaa51800=
00


