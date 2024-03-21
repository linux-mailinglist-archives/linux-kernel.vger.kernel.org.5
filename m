Return-Path: <linux-kernel+bounces-109951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B118388581F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57F71C216EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767505821C;
	Thu, 21 Mar 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si7bC0gp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935557877
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020047; cv=none; b=D/0kOQ5wyJgZvC0whZmc5ha3yen684P4Z/Q//C8kncUBoNQMD1Nofp9kxBqoZUKDwTz3SekDXqPmZ8Z1FpKo4HaSgd1dn1YEPXK2hFyB1603ozhWFvMpgfV7cAjWpIWuWBj7ySsBZbh3QmhWLYAm6GApx1vBwbSfTZuqOvaIloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020047; c=relaxed/simple;
	bh=cSt5S4B9A2UOL7ohNnvGXaATZ2fGDr1mHfPE1aso2xw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Z66kOFYAlirgUeDuFqubb4icqj2yYfQ0cBrLuT19/Feve3IOiC2pBIY+7SQMuEbtZ+//wFXF7+eIhzBY3gAPpcyOrRSDvB98yhpbxBBBJM1Ph7u2ELTtz64HVi+wnHTxJr+3JNUPVRGJfEMpHHQOfSiAZOAH0+N3nug2z4NXQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si7bC0gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE31C433F1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711020046;
	bh=cSt5S4B9A2UOL7ohNnvGXaATZ2fGDr1mHfPE1aso2xw=;
	h=Subject:From:To:Date:From;
	b=Si7bC0gpAXK+np8BuXodcV+U5uv+JHv35gQl9NQpQjXEjeAmnu+D+LHlaTTeZuWQw
	 QpYg5coG4VpiDCmzCA6s+QQoz2CPLEantXqzX7I5UCF5enLqgIJ04bp42sF2X0UhwT
	 K/NjvE4F6AJ9qJDX5xu7Yi9bbEEM6ESXOQkTByrs5MB0aUFVOZEYV2zTuTG7X7m5Du
	 H/yzTJSVtJJRF0XriBHwALlByCjXVYn8EqNd6dr0G04PG5toiU9XPxawzZE8xFQfTk
	 2fisBSYRqag3DozhNgtrWNvfMUl4MZnJfjhlkHgo28kQt97EnSLefc+RqdpP4uhhAJ
	 pn/JsqewUM6Pg==
Message-ID: <12a57ca6f77c8d95939014448de28659ea223e16.camel@kernel.org>
Subject: crash in __pv_queued_spin_lock_slowpath while testing fstests
 generic/650
From: Jeff Layton <jlayton@kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 21 Mar 2024 07:20:45 -0400
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I set up a test run using a 6.9-pre kernel last night. 2 of the machines
crashed with similar stack traces:

[ 9204.447148] run fstests generic/650 at 2024-03-20 17:45:46
[ 9206.062145] smpboot: CPU 4 is now offline
[ 9207.149663] smpboot: Booting Node 0 Processor 4 APIC 0x4
[ 9207.151712] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[ 9207.192900] stack segment: 0000 [#2] PREEMPT SMP PTI
[ 9207.194185] CPU: 4 PID: 36 Comm: cpuhp/4 Tainted: G      D            6.=
8.0-g9f4a1748ce19 #167
[ 9207.196044] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
6.3-1.fc39 04/01/2014
[ 9207.197806] RIP: 0010:__pv_queued_spin_lock_slowpath+0x27a/0x370
[ 9207.199145] Code: 89 df e8 e9 c5 5f ff e9 02 ff ff ff 83 e0 03 c1 ea 12 =
48 c1 e0 05 48 8d a8 40 22 03 00 8d 42 ff 48 98 48 03 2c c5 e0 c4 6c 92 <4c=
> 89 75 00 b8 00 80 00 00 eb 13 84 c0 75 08 0f b6 55 14 84 d2 75
[ 9207.202877] RSP: 0000:ffff9b6b4016fd18 EFLAGS: 00010086
[ 9207.203988] RAX: 0000000000001110 RBX: ffff8ae8a31c20f4 RCX: 00000000000=
00001
[ 9207.205044] RDX: 0000000000001111 RSI: 0000000000000000 RDI: ffffffff926=
1d546
[ 9207.206079] RBP: ff7914a8ff7c30b2 R08: ffffffff930fed20 R09: ffff8ae8809=
10788
[ 9207.207114] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9b6b401=
6fda0
[ 9207.208162] R13: 0000000000140000 R14: ffff8ae9f7d32240 R15: 00000000000=
00000
[ 9207.209200] FS:  0000000000000000(0000) GS:ffff8ae9f7d00000(0000) knlGS:=
0000000000000000
[ 9207.210391] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9207.211273] CR2: 0000000000000000 CR3: 000000004e01a001 CR4: 00000000007=
70ef0
[ 9207.212355] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 9207.213403] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 9207.214440] PKRU: 55555554
[ 9207.214867] Call Trace:
[ 9207.215278]  <TASK>
[ 9207.215716]  ? die+0x32/0x80
[ 9207.216192]  ? do_trap+0xd9/0x100
[ 9207.216711]  ? do_error_trap+0x6a/0x90
[ 9207.217292]  ? exc_stack_segment+0x33/0x50
[ 9207.217941]  ? asm_exc_stack_segment+0x22/0x30
[ 9207.218625]  ? __pv_queued_spin_lock_slowpath+0x27a/0x370
[ 9207.219455]  ? __pv_queued_spin_lock_slowpath+0x6c/0x370
[ 9207.220442]  _raw_spin_lock_irqsave+0x44/0x50
[ 9207.221857]  task_rq_lock+0x29/0x100
[ 9207.222739]  ? __pfx_workqueue_online_cpu+0x10/0x10
[ 9207.223920]  __set_cpus_allowed_ptr+0x2d/0xa0
[ 9207.225103]  set_cpus_allowed_ptr+0x37/0x60
[ 9207.226241]  workqueue_online_cpu+0x242/0x320
[ 9207.227554]  ? __pfx_workqueue_online_cpu+0x10/0x10
[ 9207.228806]  cpuhp_invoke_callback+0xf5/0x450
[ 9207.229901]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 9207.231075]  cpuhp_thread_fun+0xe7/0x160
[ 9207.232002]  smpboot_thread_fn+0x184/0x220
[ 9207.233001]  kthread+0xda/0x110
[ 9207.233860]  ? __pfx_kthread+0x10/0x10
[ 9207.234840]  ret_from_fork+0x2d/0x50
[ 9207.235480]  ? __pfx_kthread+0x10/0x10
[ 9207.236090]  ret_from_fork_asm+0x1a/0x30
[ 9207.236725]  </TASK>
[ 9207.237116] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_res=
olver nfs lockd grace nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
nf_tables nfnetlink sunrpc 9p netfs siw ib_uverbs ib_core kvm_intel joydev =
kvm virtio_net pcspkr psmouse 9pnet_virtio net_failover failover virtio_bal=
loon button evdev loop drm dm_mod zram zsmalloc crct10dif_pclmul crc32_pclm=
ul ghash_clmulni_intel sha512_ssse3 sha512_generic xfs sha256_ssse3 libcrc3=
2c crc32c_generic sha1_ssse3 crc32c_intel nvme nvme_core t10_pi aesni_intel=
 crc64_rocksoft_generic crypto_simd crc64_rocksoft cryptd crc64 virtio_blk =
virtio_console serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci=
_modern_dev virtio_ring autofs4
[ 9207.247496] ---[ end trace 0000000000000000 ]---
[ 9207.248273] RIP: 0010:nfs_inode_find_state_and_recover+0x8e/0x250 [nfsv4=
]
[ 9207.249491] Code: 00 00 49 8b 47 40 a8 01 0f 85 a4 00 00 00 49 8b 85 80 =
00 00 00 4c 8d 68 80 48 39 c3 74 52 4d 8b 7d 60 4d 85 ff 74 e7 49 8b 0e <49=
> 39 4f 58 75 bd 41 8b 7e 08 41 39 7f 60 75 b3 41 8b 14 24 85 d2
[ 9207.252441] RSP: 0018:ffff9b6b4ed63d38 EFLAGS: 00010206
[ 9207.253336] RAX: ffff8ae8a0c1bd80 RBX: ffff8ae8b2773bd8 RCX: 96c8a28e65f=
afadb
[ 9207.254537] RDX: ffff8ae8a31c1840 RSI: ffff8ae88a855904 RDI: ffff8ae8b27=
73c58
[ 9207.255670] RBP: ffff8ae8b2773c58 R08: ffff8ae88005f428 R09: ffff8ae88a8=
50910
[ 9207.256829] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8ae88a8=
55904
[ 9207.257922] R13: ffff8ae8a0c1bd00 R14: ffff8ae88a855908 R15: 00000100000=
02000
[ 9207.259108] FS:  0000000000000000(0000) GS:ffff8ae9f7d00000(0000) knlGS:=
0000000000000000
[ 9207.260363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9207.261274] CR2: 0000000000000000 CR3: 000000004e01a001 CR4: 00000000007=
70ef0
[ 9207.262436] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 9207.263598] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 9207.264795] PKRU: 55555554
[ 9207.265262] note: cpuhp/4[36] exited with irqs disabled
[ 9207.266096] note: cpuhp/4[36] exited with preempt_count 1

$ ./scripts/faddr2line --list vmlinux __pv_queued_spin_lock_slowpath+0x27a/=
0x370
__pv_queued_spin_lock_slowpath+0x27a/0x370:

__pv_queued_spin_lock_slowpath at kernel/locking/qspinlock.c:474 (discrimin=
ator 2)
 469 		 */
 470 		if (old & _Q_TAIL_MASK) {
 471 			prev =3D decode_tail(old);
 472 =09
 473 			/* Link @node into the waitqueue. */
>474<			WRITE_ONCE(prev->next, node);
 475 =09
 476 			pv_wait_node(node, prev);
 477 			arch_mcs_spin_lock_contended(&node->locked);
 478 =09
 479 			/*


generic/650 offlines some CPUs, so that might be a factor here. The
kernel is based on commit a4145ce1e7bc ("Merge tag 'bcachefs-2024-03-19'
of https://evilpiepirate.org/git/bcachefs"), with some directory
delegation patches on top that I doubt are a factor.

Let me know if there's any other info you need!
--=20
Jeff Layton <jlayton@kernel.org>

