Return-Path: <linux-kernel+bounces-140735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF568A1874
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247AE1C23BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BC0156CF;
	Thu, 11 Apr 2024 15:18:34 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFED13FF6;
	Thu, 11 Apr 2024 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848713; cv=none; b=GvszkhN5W+fop/0NG5LFmNasgV+qrsSwyuzDZv6qxLdrJc+7i5hqZroUswAriCAmBSMfmNVnllI4ORVV8G8KiTdZFjNY5+a24gO4MI1VcyVbqZAMpjX9thnpf3ga8ha3+4POEeXaCgZ3EUzz3Y8CjqXQUwZHiyG3kYe8n3tC89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848713; c=relaxed/simple;
	bh=NQqcyGqgDOL6Kp/5gAj8Hg3naHUnvrOWmSGNERpOGF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRe2bWMVezOGGIkggXQRNOAv8paylQ7gN4c5gdc2FZXNSm5CzR1z76hGEIt4MqxUf2TMF8g9+1LC+6Z5ly85/xkNMWdNoyMHDZ/xJThRwmHM9utBuVwJywWU81YHmPXJjyUQS1eVO7g1V4kYbzQVhVuUuGt7DmoXC/JHEIqXHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 0C5242F20242; Thu, 11 Apr 2024 15:18:21 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 7BE132F20238;
	Thu, 11 Apr 2024 15:18:15 +0000 (UTC)
From: kovalev@altlinux.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
	nickel@altlinux.org,
	oficerovas@altlinux.org,
	dutyrok@altlinux.org,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	stable@vger.kernel.org
Subject: [PATCH net] Bluetooth: hci_event: fix double hci_conn_drop() when conn->state == BT_CONNECTED
Date: Thu, 11 Apr 2024 18:18:10 +0300
Message-Id: <20240411151810.403167-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

There is no need to drop the connection of some functions in which the
conn->state in BT_CONNECTED is marked, since in the future the same check
takes place (for example, in the hci_encrypt_change_evt() function) and
the hci_conn_drop() is called.

Otherwise, the conn->refcnt will become below zero, which will trigger a
warning and may cause a crash on kernels with the panic_on_warn parameter
enabled.

Syzkaller hit 'WARNING in hci_conn_timeout' bug.

[   23.485892] Bluetooth: Core ver 2.22
[   23.485916] NET: Registered PF_BLUETOOTH protocol family
[   23.485917] Bluetooth: HCI device and connection manager initialized
[   23.486407] Bluetooth: HCI socket layer initialized
[   23.486410] Bluetooth: L2CAP socket layer initialized
[   23.486413] Bluetooth: SCO socket layer initialized
[   24.507112] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
[   24.507142] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
[   24.507165] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
[   24.508091] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
[   24.508109] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
[   24.508117] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
[   24.545962] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   24.545969] Bluetooth: BNEP filters: protocol multicast
[   24.545973] Bluetooth: BNEP socket layer initialized
[   24.547521] Bluetooth: MGMT ver 1.22
[   26.553008] Bluetooth: hci0: command tx timeout
[   26.561518] Bluetooth: RFCOMM TTY layer initialized
[   26.561526] Bluetooth: RFCOMM socket layer initialized
[   26.561532] Bluetooth: RFCOMM ver 1.11
[   28.602024] Bluetooth: hci0: Opcode 0x0c13 failed: -110
[   28.602054] Bluetooth: hci0: command tx timeout
[   30.650011] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   30.650021] Bluetooth: hci0: command tx timeout
[   32.696973] Bluetooth: hci0: command tx timeout
[   32.696985] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   34.744973] Bluetooth: hci0: command 0x0406 tx timeout
[   34.745008] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   36.792966] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   36.792980] Bluetooth: hci0: command 0x0406 tx timeout
[   38.841027] Bluetooth: hci0: command 0x0406 tx timeout
[   38.841035] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   40.889026] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   40.889999] Bluetooth: hci0: command 0x0406 tx timeout
[   40.890012] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   40.893629] NET: Registered PF_ALG protocol family
[   42.937008] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   42.937023] Bluetooth: hci0: command 0x0406 tx timeout
[   44.984984] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   44.985008] Bluetooth: hci0: command 0x0406 tx timeout
[   47.033023] Bluetooth: hci0: Opcode 0x0c1a failed: -110
[   47.033044] Bluetooth: hci0: command 0x0406 tx timeout
[   49.080976] Bluetooth: hci0: command 0x0406 tx timeout
[   49.080985] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   51.129140] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[   51.130051] Bluetooth: hci0: command 0x0406 tx timeout
[   53.177011] Bluetooth: hci0: command 0x0406 tx timeout
[   55.225969] Bluetooth: hci0: command 0x0406 tx timeout
[   57.272968] Bluetooth: hci0: command 0x0406 tx timeout
[   59.320982] Bluetooth: hci0: command 0x0406 tx timeout
[   61.368989] Bluetooth: hci0: command 0x0406 tx timeout
[  148.474066] ------------[ cut here ]------------
[  148.474072] WARNING: CPU: 0 PID: 3835 at net/bluetooth/hci_conn.c:612
				hci_conn_timeout+0x16/0x60 [bluetooth]
[  148.474115] Modules linked in: cmac algif_hash algif_skcipher af_alg
	rfcomm bnep hci_vhci bluetooth ecdh_generic uinput af_packet
	rfkill joydev hid_generic usbhid hid qrtr intel_rapl_msr
	intel_rapl_common intel_pmc_core kvm_intel nls_utf8 iTCO_wdt
	intel_pmc_bxt iTCO_vendor_support nls_cp866 vfat fat kvm irqbypass
	crct10dif_pclmul crc32_pclmul snd_hda_codec_generic crc32c_intel
	ghash_clmulni_intel ledtrig_audio sha512_ssse3 snd_hda_intel
	sha256_ssse3 sha1_ssse3 snd_intel_dspcfg snd_intel_sdw_acpi
	snd_hda_codec aesni_intel crypto_simd cryptd i2c_i801 snd_hda_core
	psmouse snd_hwdep i2c_smbus xhci_pci pcspkr snd_pcm lpc_ich
	xhci_pci_renesas xhci_hcd tiny_power_button qemu_fw_cfg button
	sch_fq_codel vboxvideo drm_vram_helper drm_ttm_helper ttm vboxsf
	vboxguest snd_seq_midi snd_seq_midi_event snd_seq snd_rawmidi
	snd_seq_device snd_timer snd soundcore msr fuse efi_pstore dm_mod
	ip_tables x_tables autofs4 virtio_gpu virtio_net virtio_dma_buf
	drm_shmem_helper net_failover drm_kms_helper
[  148.474210]  virtio_rng drm virtio_scsi rng_core virtio_console
	virtio_balloon virtio_blk failover ahci libahci libata evdev
	input_leds serio_raw scsi_mod scsi_common virtio_pci
	virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring virtio
	intel_agp intel_gtt
[  148.474234] CPU: 0 PID: 3835 Comm: kworker/u5:2
		Not tainted 6.1.85-un-def-alt1 #1
[  148.474238] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
		BIOS 1.16.0-alt1 04/01/2014
[  148.474241] Workqueue: hci0 hci_conn_timeout [bluetooth]
[  148.474265] RIP: 0010:hci_conn_timeout+0x16/0x60 [bluetooth]
[  148.474288] Code: 00 00 66 89 44 24 06 e8 58 a7 ff ff eb a8 e8 41 7b ee
		c1 90 0f 1f 44 00 00 8b 87 20 fd ff ff 85 c0 78 07 74 07 c3
		cc cc cc cc <0f> 0b 55 0f b6 87 49 fd ff ff 48 8d af 10 fd
		ff ff 3c 01 74 12 be
[  148.474291] RSP: 0018:ffffa7fd80b53e90 EFLAGS: 00010286
[  148.474295] RAX: 00000000fffe728b RBX: ffff8959c46ab180 RCX: ffff8959c3b70028
[  148.474297] RDX: 0000000000000001 RSI: ffff8959c86ce0b0 RDI: ffff895a105aeaf0
[  148.474299] RBP: ffff895a105aeaf0 R08: ffff8959c86ce0b0 R09: ffff8959c46ab1f4
[  148.474301] R10: 0000000000000005 R11: 0000000000000005 R12: ffff8959c3b70000
[  148.474302] R13: ffff8959ec495400 R14: 0000000000000000 R15: ffff8959ec495405
[  148.474305] FS:  0000000000000000(0000) GS:ffff895a3dc00000(0000)
						knlGS:0000000000000000
[  148.474308] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  148.474310] CR2: 00007f2a1b7baa48 CR3: 0000000034b98000 CR4: 0000000000750ef0
[  148.474317] PKRU: 55555554
[  148.474319] Call Trace:
[  148.474323]  <TASK>
[  148.474327]  ? __warn+0x79/0xc0
[  148.474343]  ? hci_conn_timeout+0x16/0x60 [bluetooth]
[  148.474364]  ? report_bug+0xff/0x150
[  148.474375]  ? handle_bug+0x49/0xa0
[  148.474398]  ? exc_invalid_op+0x14/0x70
[  148.474402]  ? asm_exc_invalid_op+0x16/0x20
[  148.474408]  ? hci_conn_timeout+0x16/0x60 [bluetooth]
[  148.474441]  process_one_work+0x217/0x3e0
[  148.474467]  worker_thread+0x4d/0x3c0
[  148.474473]  ? process_one_work+0x3e0/0x3e0
[  148.474478]  kthread+0xd6/0x100
[  148.474482]  ? kthread_complete_and_exit+0x20/0x20
[  148.474486]  ret_from_fork+0x1f/0x30
[  148.474500]  </TASK>
[  148.474502] ---[ end trace 0000000000000000 ]---

Fixes: 0fe29fd1cd77 ("Bluetooth: Read LE remote features during connection establishment")
Fixes: 769be974d0c7 ("[Bluetooth] Use ACL config stage to retrieve remote features")
Fixes: f8558555f31e ("[Bluetooth] Initiate authentication during connection establishment")
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/bluetooth/hci_event.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a8b8cfebe0180c..64477e1bde7cec 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3529,7 +3529,6 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, void *data,
 		} else {
 			conn->state = BT_CONNECTED;
 			hci_connect_cfm(conn, ev->status);
-			hci_conn_drop(conn);
 		}
 	} else {
 		hci_auth_cfm(conn, ev->status);
@@ -3776,7 +3775,6 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
 		hci_connect_cfm(conn, ev->status);
-		hci_conn_drop(conn);
 	}
 
 unlock:
@@ -5030,7 +5028,6 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev, void *data,
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
 		hci_connect_cfm(conn, ev->status);
-		hci_conn_drop(conn);
 	}
 
 unlock:
@@ -6561,7 +6558,6 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 
 			conn->state = BT_CONNECTED;
 			hci_connect_cfm(conn, status);
-			hci_conn_drop(conn);
 		}
 	}
 
-- 
2.33.8


