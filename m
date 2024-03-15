Return-Path: <linux-kernel+bounces-104997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4174987D770
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8FE283382
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA85A4C9;
	Fri, 15 Mar 2024 23:53:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB263D55D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710546786; cv=none; b=sLYO2kI0rpVtl8iaOKrVxnYm+vuQW7e7Aquqag5L31q+hAYjSaPXoRbRIDzOIEK1iVCnbctrQ/595lBnlm6XwwD72Zb5+Giljj1/m8fHZO+oOMPlD43feS/V8WDYkMvt+tCQfDKisG47hJo2c28W9gXYPUG6QjJ4Kz+VDFfM56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710546786; c=relaxed/simple;
	bh=EmexldmbV6RDVxRNyyWiQVFmZKK+5zTQD8ozANROZKU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NnHvuONqLVON9WSU72ZXK1qrE8Uz9fUO9U0bf9xwqxJryTB0XeHX8uWshIBaTioc1g2aCb4+tUxNDgPykSK2Xu0zTy1q7SPJQ6JB2KNuUrJgX1O6ubSNveachbNpjD107dnJkkoelEZsEvPQzBhJSUZQ7D8cAP+7wpx56iF5Dy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc0370e9b0so45499239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710546783; x=1711151583;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UqWYgLc9i0lJF70Mac1HRTUiGGtaojMMEV1iwItIwM=;
        b=A2PASAltPgpiDUCoW8p+uvUCgk5a5hd59Vj9jwR6WNc5irCtehtmp2ImLxscgKFPI2
         XO02AxdoXZM0g/LBjIjuGI03fK3EXodlnj+fyZ9M9pRDV8fHvQ6yVviC4ZHScI3NzlvK
         Mqft8JANW6JCsP03ZuLk/UU5K4k8zdUY2ScFvFRMBnok6eVqHY/bcpYxmcjWzmrvsal4
         ViFceuDT3Y8ZJPeOPx7fjZXY2HoUIXDxMj6Y2IpeYLY7hIbyz8n8tgHTeSsUpSI7NatW
         1i1felCR6PJUWByi4LBHAwmX92LdbwKcaYhXwl3nLJj16Fc+jieAP/ba9KVO8DPrEjlm
         mflQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrv5wuq9/elAAPtOMnX/FEptkzQ56HUehob5hmhi+w/SZoOh3zIztallMJuAnscd2dri4jmd8eWOBwlxGea2ctNtTgKHE29GrfmU0B
X-Gm-Message-State: AOJu0YwA1h0qgF5GCpblaOnUIByavRbTEONbecd/M/VelBQh8XOI341G
	UIFQbF/f8J5s88JJ2YGvEhoaaNsfghOfC+xgeGuxW+ywj/3BzgtvumTWGWUnkSDm2cg7eMkeId9
	QnSaF4x63QVcQdU2pj91+l+7Dg1yf8lX/vcfxttXOn7JSXlWw6CdX2bM=
X-Google-Smtp-Source: AGHT+IF2UwsvPJwUdEd3F3SbTkeHKZP5yyVQQ4B5/PoV514dWOcv2D6NcOeU06nisYmtlHq8IyBwZE/K0G8U0Gy2ucbnQOOQw9gj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a7:b0:476:fdd3:7bf6 with SMTP id
 w39-20020a05663837a700b00476fdd37bf6mr306657jal.3.1710546782988; Fri, 15 Mar
 2024 16:53:02 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:53:02 -0700
In-Reply-To: <20240315233429.2554-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f3c790613bbb598@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
From: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 scheduler registered.
[   20.046212][    T1] IPVS: [twos] scheduler registered.
[   20.052487][    T1] IPVS: [sip] pe registered.
[   20.058236][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   20.068626][    T1] gre: GRE over IPv4 demultiplexor driver
[   20.074591][    T1] ip_gre: GRE over IPv4 tunneling driver
[   20.088795][    T1] IPv4 over IPsec tunneling driver
[   20.098760][    T1] Initializing XFRM netlink socket
[   20.104824][    T1] IPsec XFRM device driver
[   20.109872][    T1] NET: Registered PF_INET6 protocol family
[   20.126622][    T1] Segment Routing with IPv6
[   20.131497][    T1] RPL Segment Routing with IPv6
[   20.137569][    T1] In-situ OAM (IOAM) with IPv6
[   20.143198][    T1] mip6: Mobile IPv6
[   20.150447][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   20.163905][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   20.173318][    T1] NET: Registered PF_PACKET protocol family
[   20.180115][    T1] NET: Registered PF_KEY protocol family
[   20.185979][    T1] Bridge firewalling registered
[   20.191499][    T1] NET: Registered PF_X25 protocol family
[   20.197301][    T1] X25: Linux Version 0.2
[   20.239984][    T1] NET: Registered PF_NETROM protocol family
[   20.286824][    T1] NET: Registered PF_ROSE protocol family
[   20.292725][    T1] NET: Registered PF_AX25 protocol family
[   20.298720][    T1] can: controller area network core
[   20.304462][    T1] NET: Registered PF_CAN protocol family
[   20.310192][    T1] can: raw protocol
[   20.314261][    T1] can: broadcast manager protocol
[   20.319507][    T1] can: netlink gateway - max_hops=3D1
[   20.325224][    T1] can: SAE J1939
[   20.328777][    T1] can: isotp protocol (max_pdu_size 8300)
[   20.335062][    T1] Bluetooth: RFCOMM TTY layer initialized
[   20.341008][    T1] Bluetooth: RFCOMM socket layer initialized
[   20.347605][    T1] Bluetooth: RFCOMM ver 1.11
[   20.352523][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   20.359022][    T1] Bluetooth: BNEP filters: protocol multicast
[   20.365382][    T1] Bluetooth: BNEP socket layer initialized
[   20.371175][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   20.377149][    T1] Bluetooth: CMTP socket layer initialized
[   20.383020][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   20.390320][    T1] Bluetooth: HIDP socket layer initialized
[   20.398622][    T1] NET: Registered PF_RXRPC protocol family
[   20.405217][    T1] Key type rxrpc registered
[   20.409717][    T1] Key type rxrpc_s registered
[   20.415444][    T1] NET: Registered PF_KCM protocol family
[   20.422288][    T1] lec:lane_module_init: lec.c: initialized
[   20.428813][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   20.434819][    T1] l2tp_core: L2TP core driver, V2.0
[   20.440043][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   20.445986][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   20.453014][    T1] l2tp_netlink: L2TP netlink interface
[   20.459661][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   20.467052][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   20.474967][    T1] NET: Registered PF_PHONET protocol family
[   20.481779][    T1] 8021q: 802.1Q VLAN Support v1.8
[   20.498499][    T1] DCCP: Activated CCID 2 (TCP-like)
[   20.504156][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   20.511295][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   20.522532][    T1] sctp: Hash tables configured (bind 32/56)
[   20.530588][    T1] NET: Registered PF_RDS protocol family
[   20.537571][    T1] Registered RDS/infiniband transport
[   20.544168][    T1] Registered RDS/tcp transport
[   20.549028][    T1] tipc: Activated (version 2.0.0)
[   20.554726][    T1] NET: Registered PF_TIPC protocol family
[   20.561546][    T1] tipc: Started in single node mode
[   20.567475][    T1] NET: Registered PF_SMC protocol family
[   20.573541][    T1] 9pnet: Installing 9P2000 support
[   20.579112][    T1] NET: Registered PF_CAIF protocol family
[   20.588434][    T1] NET: Registered PF_IEEE802154 protocol family
[   20.595147][    T1] Key type dns_resolver registered
[   20.600428][    T1] Key type ceph registered
[   20.605307][    T1] libceph: loaded (mon/osd proto 15/24)
[   20.612071][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.1 (compatibil=
ity version 15) loaded
[   20.621780][    T1] openvswitch: Open vSwitch switching datapath
[   20.630000][    T1] NET: Registered PF_VSOCK protocol family
[   20.636459][    T1] mpls_gso: MPLS GSO support
[   20.656569][    T1] IPI shorthand broadcast: enabled
[   20.661987][    T1] AVX2 version of gcm_enc/dec engaged.
[   20.667932][    T1] AES CTR mode by8 optimization enabled
[   21.651138][    T1] sched_clock: Marking stable (21600020702, 43682234)-=
>(21641677555, 2025381)
[   21.665130][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   21.676589][    T1] registered taskstats version 1
[   21.691534][    T1] Loading compiled-in X.509 certificates
[   21.701390][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: caf27e718a03c2875c0f3e9da2fdca81dac83f88'
[   21.935630][    T1] zswap: loaded using pool lzo/zsmalloc
[   21.942820][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   22.363865][    T1] ------------[ cut here ]------------
[   22.369435][    T1] refcount_t: decrement hit 0; leaking memory.
[   22.375980][    T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[   22.385786][    T1] Modules linked in:
[   22.389701][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B       =
       6.8.0-syzkaller-11063-g277100b3d5fe-dirty #0
[   22.401469][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   22.411821][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[   22.418047][    T1] Code: b2 00 00 00 e8 a7 9b f5 fc 5b 5d c3 cc cc cc c=
c e8 9b 9b f5 fc c6 05 78 1e d2 0a 01 90 48 c7 c7 60 da fd 8b e8 17 61 b8 f=
c 90 <0f> 0b 90 90 eb d9 e8 7b 9b f5 fc c6 05 55 1e d2 0a 01 90 48 c7 c7
[   22.438852][    T1] RSP: 0000:ffffc90000067668 EFLAGS: 00010246
[   22.445745][    T1] RAX: 033873f32e959400 RBX: ffff8880324819fc RCX: fff=
f888014fc8000
[   22.453986][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   22.462526][    T1] RBP: 0000000000000004 R08: ffffffff8157df32 R09: fff=
ffbfff1bf9660
[   22.471060][    T1] R10: dffffc0000000000 R11: fffffbfff1bf9660 R12: fff=
fea0001004000
[   22.479700][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: fff=
fea0001004008
[   22.487826][    T1] FS:  0000000000000000(0000) GS:ffff8880b9500000(0000=
) knlGS:0000000000000000
[   22.497607][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.504295][    T1] CR2: 0000000000000000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[   22.512391][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   22.520813][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   22.528932][    T1] Call Trace:
[   22.532611][    T1]  <TASK>
[   22.535936][    T1]  ? __warn+0x163/0x4b0
[   22.540206][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   22.546004][    T1]  ? report_bug+0x2b3/0x500
[   22.550821][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   22.556437][    T1]  ? handle_bug+0x3e/0x70
[   22.560824][    T1]  ? exc_invalid_op+0x1a/0x50
[   22.566609][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   22.572222][    T1]  ? __warn_printk+0x292/0x360
[   22.577412][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   22.582973][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[   22.588927][    T1]  free_unref_page_prepare+0x95d/0xa80
[   22.594950][    T1]  free_unref_page+0x37/0x3f0
[   22.599804][    T1]  free_contig_range+0x9e/0x160
[   22.605030][    T1]  destroy_args+0x8a/0x890
[   22.609936][    T1]  debug_vm_pgtable+0x4be/0x550
[   22.615039][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   22.620764][    T1]  ? __pfx_add_device_randomness+0x10/0x10
[   22.627385][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   22.633103][    T1]  do_one_initcall+0x238/0x830
[   22.638015][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   22.643644][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   22.650443][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   22.656040][    T1]  ? __pfx_parse_args+0x10/0x10
[   22.660908][    T1]  ? do_initcalls+0x1c/0x80
[   22.665859][    T1]  ? rcu_is_watching+0x15/0xb0
[   22.670696][    T1]  do_initcall_level+0x157/0x210
[   22.675732][    T1]  do_initcalls+0x3f/0x80
[   22.680130][    T1]  kernel_init_freeable+0x435/0x5d0
[   22.685954][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   22.691972][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   22.699054][    T1]  ? __pfx_kernel_init+0x10/0x10
[   22.704428][    T1]  ? rcu_is_watching+0x15/0xb0
[   22.709362][    T1]  ? __pfx_kernel_init+0x10/0x10
[   22.714513][    T1]  kernel_init+0x1d/0x2b0
[   22.719075][    T1]  ret_from_fork+0x4b/0x80
[   22.723973][    T1]  ? __pfx_kernel_init+0x10/0x10
[   22.729016][    T1]  ret_from_fork_asm+0x1a/0x30
[   22.734205][    T1]  </TASK>
[   22.737838][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   22.745594][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B       =
       6.8.0-syzkaller-11063-g277100b3d5fe-dirty #0
[   22.758472][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[   22.768882][    T1] Call Trace:
[   22.772150][    T1]  <TASK>
[   22.775081][    T1]  dump_stack_lvl+0x241/0x360
[   22.779750][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[   22.785102][    T1]  ? __pfx__printk+0x10/0x10
[   22.789812][    T1]  ? vscnprintf+0x5d/0x90
[   22.794277][    T1]  panic+0x349/0x860
[   22.798282][    T1]  ? __warn+0x172/0x4b0
[   22.802468][    T1]  ? __pfx_panic+0x10/0x10
[   22.807313][    T1]  ? ret_from_fork_asm+0x1a/0x30
[   22.812449][    T1]  __warn+0x31e/0x4b0
[   22.816898][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   22.823360][    T1]  report_bug+0x2b3/0x500
[   22.827814][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[   22.833548][    T1]  handle_bug+0x3e/0x70
[   22.837969][    T1]  exc_invalid_op+0x1a/0x50
[   22.842546][    T1]  asm_exc_invalid_op+0x1a/0x20
[   22.847390][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[   22.853763][    T1] Code: b2 00 00 00 e8 a7 9b f5 fc 5b 5d c3 cc cc cc c=
c e8 9b 9b f5 fc c6 05 78 1e d2 0a 01 90 48 c7 c7 60 da fd 8b e8 17 61 b8 f=
c 90 <0f> 0b 90 90 eb d9 e8 7b 9b f5 fc c6 05 55 1e d2 0a 01 90 48 c7 c7
[   22.874384][    T1] RSP: 0000:ffffc90000067668 EFLAGS: 00010246
[   22.880535][    T1] RAX: 033873f32e959400 RBX: ffff8880324819fc RCX: fff=
f888014fc8000
[   22.888976][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   22.898233][    T1] RBP: 0000000000000004 R08: ffffffff8157df32 R09: fff=
ffbfff1bf9660
[   22.906475][    T1] R10: dffffc0000000000 R11: fffffbfff1bf9660 R12: fff=
fea0001004000
[   22.914518][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: fff=
fea0001004008
[   22.923156][    T1]  ? __warn_printk+0x292/0x360
[   22.927943][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[   22.933793][    T1]  free_unref_page_prepare+0x95d/0xa80
[   22.939366][    T1]  free_unref_page+0x37/0x3f0
[   22.944052][    T1]  free_contig_range+0x9e/0x160
[   22.949130][    T1]  destroy_args+0x8a/0x890
[   22.953659][    T1]  debug_vm_pgtable+0x4be/0x550
[   22.958647][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   22.964417][    T1]  ? __pfx_add_device_randomness+0x10/0x10
[   22.970326][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   22.975903][    T1]  do_one_initcall+0x238/0x830
[   22.981102][    T1]  ? __pfx_debug_vm_pgtable+0x10/0x10
[   22.987110][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   22.994429][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   22.999923][    T1]  ? __pfx_parse_args+0x10/0x10
[   23.005032][    T1]  ? do_initcalls+0x1c/0x80
[   23.010320][    T1]  ? rcu_is_watching+0x15/0xb0
[   23.015546][    T1]  do_initcall_level+0x157/0x210
[   23.020786][    T1]  do_initcalls+0x3f/0x80
[   23.025244][    T1]  kernel_init_freeable+0x435/0x5d0
[   23.030660][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   23.036955][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   23.044099][    T1]  ? __pfx_kernel_init+0x10/0x10
[   23.049265][    T1]  ? rcu_is_watching+0x15/0xb0
[   23.054394][    T1]  ? __pfx_kernel_init+0x10/0x10
[   23.059490][    T1]  kernel_init+0x1d/0x2b0
[   23.063815][    T1]  ret_from_fork+0x4b/0x80
[   23.068382][    T1]  ? __pfx_kernel_init+0x10/0x10
[   23.073539][    T1]  ret_from_fork_asm+0x1a/0x30
[   23.078377][    T1]  </TASK>
[   23.082209][    T1] Kernel Offset: disabled
[   23.086616][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3765643222=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D176687b9180000


Tested on:

commit:         277100b3 Merge tag 'block-6.9-20240315' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfe0919aedd4b3fc=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3D28c1a5a5b041a754b=
947
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13e5efb61800=
00


