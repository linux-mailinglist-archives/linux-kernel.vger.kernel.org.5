Return-Path: <linux-kernel+bounces-84944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593DC86AE07
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A862EB25008
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A46CDAC;
	Wed, 28 Feb 2024 11:47:46 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E373503;
	Wed, 28 Feb 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120866; cv=none; b=HbekzEPVO3nv0yYVcMdPBU3HXcVW8YQBCQP9E2QtxcPi/KwxGqdMlPvUJ+/txrMeG6E8hNnKlqjMG9L8laN9TLlgW2+lAAJfYK+kTI3fEZgrektuYoqjhQMoVunQw9CymlvWE5aEvOxX0uqJ1dKp4jWvShwruPx3fQu+VwFgZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120866; c=relaxed/simple;
	bh=q/fvf1CYGaXkHgF84IqRTm66BviS/l9Brmv4QWjZBZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaNwBEqkRgW0VULhMjcz3LYm49lv95Oq4xAn5RGrrm8L1Jc0H9BXWNXIdHWrxjGaVoSJlUU/mtRPuC7aKKJaCgz2Ra05a4GBozk8KGRBX1lREnKFz5ry9FZtjZLQ68wQ24WAj1toGBl018N2e+/rMTGqzBcbbSkpDic+67QLy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 8A1BF2F2024D; Wed, 28 Feb 2024 11:47:34 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 838342F2024A;
	Wed, 28 Feb 2024 11:47:32 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: edumazet@google.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	kovalev@altlinux.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	stable@vger.kernel.org
Subject: [PATCH net] gtp: fix use-after-free and null-ptr-deref in gtp_newlink()
Date: Wed, 28 Feb 2024 14:47:03 +0300
Message-ID: <20240228114703.465107-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The gtp_link_ops operations structure for the subsystem must be
registered after registering the gtp_net_ops pernet operations structure.

Syzkaller hit 'general protection fault in gtp_genl_dump_pdp' bug:

[ 1010.702740] gtp: GTP module unloaded
[ 1010.715877] general protection fault, probably for non-canonical address=
 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
[ 1010.715888] KASAN: null-ptr-deref in range [0x0000000000000008-0x0000000=
00000000f]
[ 1010.715895] CPU: 1 PID: 128616 Comm: a.out Not tainted 6.8.0-rc6-std-def=
-alt1 #1
[ 1010.715899] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
6.0-alt1 04/01/2014
[ 1010.715908] RIP: 0010:gtp_newlink+0x4d7/0x9c0 [gtp]
[ 1010.715915] Code: 80 3c 02 00 0f 85 41 04 00 00 48 8b bb d8 05 00 00 e8 =
ed f6 ff ff 48 89 c2 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80=
> 3c 02 00 0f 85 4f 04 00 00 4c 89 e2 4c 8b 6d 00 48 b8 00 00 00
[ 1010.715920] RSP: 0018:ffff888020fbf180 EFLAGS: 00010203
[ 1010.715929] RAX: dffffc0000000000 RBX: ffff88800399c000 RCX: 00000000000=
00000
[ 1010.715933] RDX: 0000000000000001 RSI: ffffffff84805280 RDI: 00000000000=
00282
[ 1010.715938] RBP: 000000000000000d R08: 0000000000000001 R09: 00000000000=
00000
[ 1010.715942] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880039=
9cc80
[ 1010.715947] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00400
[ 1010.715953] FS:  00007fd1509ab5c0(0000) GS:ffff88805b300000(0000) knlGS:=
0000000000000000
[ 1010.715958] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1010.715962] CR2: 0000000000000000 CR3: 000000001c07a000 CR4: 00000000007=
50ee0
[ 1010.715968] PKRU: 55555554
[ 1010.715972] Call Trace:
[ 1010.715985]  ? __die_body.cold+0x1a/0x1f
[ 1010.715995]  ? die_addr+0x43/0x70
[ 1010.716002]  ? exc_general_protection+0x199/0x2f0
[ 1010.716016]  ? asm_exc_general_protection+0x1e/0x30
[ 1010.716026]  ? gtp_newlink+0x4d7/0x9c0 [gtp]
[ 1010.716034]  ? gtp_net_exit+0x150/0x150 [gtp]
[ 1010.716042]  __rtnl_newlink+0x1063/0x1700
[ 1010.716051]  ? rtnl_setlink+0x3c0/0x3c0
[ 1010.716063]  ? is_bpf_text_address+0xc0/0x1f0
[ 1010.716070]  ? kernel_text_address.part.0+0xbb/0xd0
[ 1010.716076]  ? __kernel_text_address+0x56/0xa0
[ 1010.716084]  ? unwind_get_return_address+0x5a/0xa0
[ 1010.716091]  ? create_prof_cpu_mask+0x30/0x30
[ 1010.716098]  ? arch_stack_walk+0x9e/0xf0
[ 1010.716106]  ? stack_trace_save+0x91/0xd0
[ 1010.716113]  ? stack_trace_consume_entry+0x170/0x170
[ 1010.716121]  ? __lock_acquire+0x15c5/0x5380
[ 1010.716139]  ? mark_held_locks+0x9e/0xe0
[ 1010.716148]  ? kmem_cache_alloc_trace+0x35f/0x3c0
[ 1010.716155]  ? __rtnl_newlink+0x1700/0x1700
[ 1010.716160]  rtnl_newlink+0x69/0xa0
[ 1010.716166]  rtnetlink_rcv_msg+0x43b/0xc50
[ 1010.716172]  ? rtnl_fdb_dump+0x9f0/0x9f0
[ 1010.716179]  ? lock_acquire+0x1fe/0x560
[ 1010.716188]  ? netlink_deliver_tap+0x12f/0xd50
[ 1010.716196]  netlink_rcv_skb+0x14d/0x440
[ 1010.716202]  ? rtnl_fdb_dump+0x9f0/0x9f0
[ 1010.716208]  ? netlink_ack+0xab0/0xab0
[ 1010.716213]  ? netlink_deliver_tap+0x202/0xd50
[ 1010.716220]  ? netlink_deliver_tap+0x218/0xd50
[ 1010.716226]  ? __virt_addr_valid+0x30b/0x590
[ 1010.716233]  netlink_unicast+0x54b/0x800
[ 1010.716240]  ? netlink_attachskb+0x870/0x870
[ 1010.716248]  ? __check_object_size+0x2de/0x3b0
[ 1010.716254]  netlink_sendmsg+0x938/0xe40
[ 1010.716261]  ? netlink_unicast+0x800/0x800
[ 1010.716269]  ? __import_iovec+0x292/0x510
[ 1010.716276]  ? netlink_unicast+0x800/0x800
[ 1010.716284]  __sock_sendmsg+0x159/0x190
[ 1010.716290]  ____sys_sendmsg+0x712/0x880
[ 1010.716297]  ? sock_write_iter+0x3d0/0x3d0
[ 1010.716304]  ? __ia32_sys_recvmmsg+0x270/0x270
[ 1010.716309]  ? lock_acquire+0x1fe/0x560
[ 1010.716315]  ? drain_array_locked+0x90/0x90
[ 1010.716324]  ___sys_sendmsg+0xf8/0x170
[ 1010.716331]  ? sendmsg_copy_msghdr+0x170/0x170
[ 1010.716337]  ? lockdep_init_map_type+0x2c7/0x860
[ 1010.716343]  ? lockdep_hardirqs_on_prepare+0x430/0x430
[ 1010.716350]  ? debug_mutex_init+0x33/0x70
[ 1010.716360]  ? percpu_counter_add_batch+0x8b/0x140
[ 1010.716367]  ? lock_acquire+0x1fe/0x560
[ 1010.716373]  ? find_held_lock+0x2c/0x110
[ 1010.716384]  ? __fd_install+0x1b6/0x6f0
[ 1010.716389]  ? lock_downgrade+0x810/0x810
[ 1010.716396]  ? __fget_light+0x222/0x290
[ 1010.716403]  __sys_sendmsg+0xea/0x1b0
[ 1010.716409]  ? __sys_sendmsg_sock+0x40/0x40
[ 1010.716419]  ? lockdep_hardirqs_on_prepare+0x2b3/0x430
[ 1010.716425]  ? syscall_enter_from_user_mode+0x1d/0x60
[ 1010.716432]  do_syscall_64+0x30/0x40
[ 1010.716438]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
[ 1010.716444] RIP: 0033:0x7fd1508cbd49
[ 1010.716452] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ef 70 0d 00 f7 d8 64 89 01 48
[ 1010.716456] RSP: 002b:00007fff18872348 EFLAGS: 00000202 ORIG_RAX: 000000=
000000002e
[ 1010.716463] RAX: ffffffffffffffda RBX: 000055f72bf0eac0 RCX: 00007fd1508=
cbd49
[ 1010.716468] RDX: 0000000000000000 RSI: 0000000020000280 RDI: 00000000000=
00006
[ 1010.716473] RBP: 00007fff18872360 R08: 00007fff18872360 R09: 00007fff188=
72360
[ 1010.716478] R10: 00007fff18872360 R11: 0000000000000202 R12: 000055f72bf=
0e1b0
[ 1010.716482] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[ 1010.716491] Modules linked in: gtp(+) udp_tunnel ib_core uinput af_packe=
t rfkill qrtr joydev hid_generic usbhid hid kvm_intel iTCO_wdt intel_pmc_bx=
t iTCO_vendor_support kvm snd_hda_codec_generic ledtrig_audio irqbypass crc=
t10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel snd_hda_intel n=
ls_utf8 snd_intel_dspcfg nls_cp866 psmouse aesni_intel vfat crypto_simd fat=
 cryptd glue_helper snd_hda_codec pcspkr snd_hda_core i2c_i801 snd_hwdep i2=
c_smbus xhci_pci snd_pcm lpc_ich xhci_pci_renesas xhci_hcd qemu_fw_cfg tiny=
_power_button button sch_fq_codel vboxvideo drm_vram_helper drm_ttm_helper =
ttm vboxsf vboxguest snd_seq_midi snd_seq_midi_event snd_seq snd_rawmidi sn=
d_seq_device snd_timer snd soundcore msr fuse efi_pstore dm_mod ip_tables x=
_tables autofs4 virtio_gpu virtio_dma_buf drm_kms_helper cec rc_core drm vi=
rtio_rng virtio_scsi rng_core virtio_balloon virtio_blk virtio_net virtio_c=
onsole net_failover failover ahci libahci libata evdev scsi_mod input_leds =
serio_raw virtio_pci intel_agp
[ 1010.716674]  virtio_ring intel_gtt virtio [last unloaded: gtp]
[ 1010.716693] ---[ end trace 04990a4ce61e174b ]---

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunnelin=
g Protocol (GTP-U)")
---
 drivers/net/gtp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2129ae42c7030..0ddec4cc84093 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1903,26 +1903,26 @@ static int __init gtp_init(void)
=20
 	get_random_bytes(&gtp_h_initval, sizeof(gtp_h_initval));
=20
-	err =3D rtnl_link_register(&gtp_link_ops);
+	err =3D register_pernet_subsys(&gtp_net_ops);
 	if (err < 0)
 		goto error_out;
=20
-	err =3D register_pernet_subsys(&gtp_net_ops);
+	err =3D rtnl_link_register(&gtp_link_ops);
 	if (err < 0)
-		goto unreg_rtnl_link;
+		goto unreg_pernet_subsys;
=20
 	err =3D genl_register_family(&gtp_genl_family);
 	if (err < 0)
-		goto unreg_pernet_subsys;
+		goto unreg_rtnl_link;
=20
 	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
 		sizeof(struct pdp_ctx));
 	return 0;
=20
-unreg_pernet_subsys:
-	unregister_pernet_subsys(&gtp_net_ops);
 unreg_rtnl_link:
 	rtnl_link_unregister(&gtp_link_ops);
+unreg_pernet_subsys:
+	unregister_pernet_subsys(&gtp_net_ops);
 error_out:
 	pr_err("error loading GTP module loaded\n");
 	return err;
--=20
2.42.1


