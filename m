Return-Path: <linux-kernel+bounces-10628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F981D7AB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 03:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3152F282BD1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 02:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92CA44;
	Sun, 24 Dec 2023 02:59:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE7807
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.225])
	by sina.com (10.75.12.45) with ESMTP
	id 65879E8100005D00; Sun, 24 Dec 2023 10:59:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 41351231457861
X-SMAIL-UIID: 9A8DA2E837BE45B2855FA4F8A01802BA-20231224-105916-1
From: Hillf Danton <hdanton@sina.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: rdbabiera@google.com,
	heikki.krogerus@linux.intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: use-after-free bisected to "usb: typec: class: fix typec_altmode_put_partner to put plugs"
Date: Sun, 24 Dec 2023 10:59:03 +0800
Message-Id: <20231224025903.1389-1-hdanton@sina.com>
In-Reply-To: <CAP-bSRb3SXpgo_BEdqZB-p1K5625fMegRZ17ZkPE1J8ZYgEHDg@mail.gmail.com>
References: <CAP-bSRb3SXpgo_BEdqZB-p1K5625fMegRZ17ZkPE1J8ZYgEHDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 24 Dec 2023 00:54:11 +0000 Chris Bainbridge <chris.bainbridge@gmail.com>
> Hello,
> 
> A use-after-free error has appeared after a recent commit. This occurs
> when I unplug the USB-C dock (HP G5).
> 
Thanks for your report.

> b17b7fe6dd5c6ff74b38b0758ca799cdbb79e26e is the first bad commit
> commit b17b7fe6dd5c6ff74b38b0758ca799cdbb79e26e
> Author: RD Babiera <rdbabiera@google.com>
> Date:   Wed Nov 29 19:23:50 2023 +0000
> 
>     usb: typec: class: fix typec_altmode_put_partner to put plugs
> 
> 
> [   86.738038] usb 1-1: USB disconnect, device number 2
> [   86.738052] usb 1-1.2: USB disconnect, device number 4
> [   86.746191] [drm] DM_MST: stopping TM on aconnector:
> 0000000012454e94 [id: 101]
> [   86.757367] usb 2-1: USB disconnect, device number 2
> [   86.757373] usb 2-1.3: USB disconnect, device number 3
> [   86.757378] usb 2-1.3.3: USB disconnect, device number 5
> [   86.788662] r8152-cfgselector 2-1.4: USB disconnect, device number 4
> [   86.788937] r8152 2-1.4:1.0 enx64c901a35e3d: Stop submitting intr,
> status -108
> [   86.803049] ------------[ cut here ]------------
> [   86.803052] refcount_t: underflow; use-after-free.
> [   86.803059] WARNING: CPU: 0 PID: 2971 at lib/refcount.c:28
> refcount_warn_saturate+0xbe/0x110
> [   86.803067] Modules linked in: rfcomm ctr ccm xt_conntrack
> nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype
> nft_compat nf_tables nfnetlink br_netfilter bridge stp llc
> nvme_fabrics snd_seq_dummy snd_hrtimer snd_seq overlay qrtr cmac
> algif_hash algif_skcipher af_alg bnep binfmt_misc rtw89_8852ae
> rtw89_8852a nls_ascii rtw89_pci nls_cp437 vfat rtw89_core btusb fat
> btrtl btintel btbcm ext4 snd_ctl_led btmtk snd_hda_codec_realtek
> bluetooth mac80211 snd_hda_codec_generic intel_rapl_msr mbcache
> snd_hda_codec_hdmi ledtrig_audio intel_rapl_common snd_acp3x_rn
> snd_acp3x_pdm_dma jbd2 snd_soc_dmic uvcvideo snd_usb_audio
> snd_hda_intel kvm_amd snd_soc_core snd_intel_dspcfg videobuf2_vmalloc
> snd_hda_codec sha3_generic snd_usbmidi_lib videobuf2_memops
> jitterentropy_rng snd_pci_acp6x kvm uvc snd_hwdep snd_hda_core drbg
> videobuf2_v4l2 snd_pci_acp5x snd_rawmidi libarc4 snd_pcm
> snd_seq_device snd_rn_pci_acp3x videodev ansi_cprng cfg80211 ucsi_acpi
> hp_wmi
> [   86.803149]  snd_timer irqbypass snd_acp_config ecdh_generic
> typec_ucsi sparse_keymap videobuf2_common snd snd_soc_acpi ecc roles
> ccp rapl platform_profile mc joydev sg pcspkr k10temp rfkill
> snd_pci_acp3x crc16 soundcore wmi_bmof typec ac battery button
> serio_raw evdev amd_pmc acpi_tad hid_multitouch msr parport_pc ppdev
> lp fuse parport loop efi_pstore configfs efivarfs ip_tables x_tables
> autofs4 btrfs blake2b_generic libcrc32c crc32c_generic xor raid6_pq
> dm_crypt hid_microsoft ff_memless hid_cmedia amdgpu r8153_ecm
> cdc_ether usbnet r8152 mii usbhid dm_mod sd_mod uas usb_storage
> scsi_mod scsi_common i2c_algo_bit drm_ttm_helper ttm nvme drm_exec
> drm_suballoc_helper nvme_core amdxcp t10_pi drm_buddy
> crc64_rocksoft_generic gpu_sched hid_generic crc64_rocksoft
> drm_display_helper crc32_pclmul xhci_pci crc_t10dif i2c_hid_acpi
> drm_kms_helper crc32c_intel xhci_hcd crct10dif_generic i2c_hid
> ghash_clmulni_intel amd_sfh crct10dif_pclmul sha512_ssse3 drm usbcore
> cec video hid crc64 sha512_generic rc_core i2c_piix4 usb_common fan
> [   86.803237]  crct10dif_common wmi aesni_intel crypto_simd cryptd
> [   86.803243] CPU: 0 PID: 2971 Comm: kworker/0:6 Not tainted 6.7.0-rc6+ #728
> [   86.803245] Hardware name: HP HP Pavilion Aero Laptop
> 13-be0xxx/8916, BIOS F.12 04/11/2023
> [   86.803246] Workqueue: events ucsi_handle_connector_change [typec_ucsi]
> [   86.803254] RIP: 0010:refcount_warn_saturate+0xbe/0x110
> [   86.803257] Code: 01 01 e8 d5 1d ab ff 0f 0b e9 c9 3d 70 00 80 3d
> 92 22 40 01 00 75 85 48 c7 c7 28 5d ab 9f c6 05 82 22 40 01 01 e8 b2
> 1d ab ff <0f> 0b e9 a6 3d 70 00 80 3d 6d 22 40 01 00 0f 85 5e ff ff ff
> 48 c7
> [   86.803258] RSP: 0018:ffffc900032d7d90 EFLAGS: 00010282
> [   86.803260] RAX: 0000000000000000 RBX: ffff888103d28808 RCX: 0000000000000000
> [   86.803262] RDX: 0000000000000002 RSI: ffffffff9fa36b45 RDI: 00000000ffffffff
> [   86.803263] RBP: ffff888103d28800 R08: 0000000000000000 R09: ffffc900032d7c18
> [   86.803264] R10: 0000000000000003 R11: ffffffffa00d2368 R12: 0000000000000000
> [   86.803265] R13: ffff8881058ac280 R14: ffffffff9f71cb20 R15: ffff88816282b838
> [   86.803266] FS:  0000000000000000(0000) GS:ffff88840e400000(0000)
> knlGS:0000000000000000
> [   86.803268] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.803269] CR2: 0000562440baafc0 CR3: 000000002bc20000 CR4: 0000000000750ef0
> [   86.803271] PKRU: 55555554
> [   86.803271] Call Trace:
> [   86.803274]  <TASK>
> [   86.803275]  ? refcount_warn_saturate+0xbe/0x110
> [   86.803277]  ? __warn+0x81/0x130
> [   86.803282]  ? refcount_warn_saturate+0xbe/0x110
> [   86.803285]  ? report_bug+0x191/0x1c0
> [   86.803288]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   86.803292]  ? console_unlock+0x78/0x120
> [   86.803296]  ? handle_bug+0x41/0x70
> [   86.803300]  ? exc_invalid_op+0x17/0x70
> [   86.803302]  ? asm_exc_invalid_op+0x1a/0x20
> [   86.803308]  ? refcount_warn_saturate+0xbe/0x110
> [   86.803311]  typec_altmode_release+0x49/0xc0 [typec]
> [   86.803321]  device_release+0x37/0x90
> [   86.803325]  kobject_put+0x7b/0x190
> [   86.803329]  ucsi_unregister_altmodes+0x41/0x90 [typec_ucsi]
> [   86.803334]  ucsi_unregister_partner.part.0+0x77/0xa0 [typec_ucsi]
> [   86.803339]  ucsi_handle_connector_change+0x1bb/0x310 [typec_ucsi]
> [   86.803344]  process_one_work+0x174/0x340
> [   86.803349]  worker_thread+0x27b/0x3a0
> [   86.803352]  ? __pfx_worker_thread+0x10/0x10
> [   86.803354]  kthread+0xf7/0x130
> [   86.803356]  ? __pfx_kthread+0x10/0x10
> [   86.803359]  ret_from_fork+0x34/0x50
> [   86.803362]  ? __pfx_kthread+0x10/0x10
> [   86.803364]  ret_from_fork_asm+0x1b/0x30
> [   86.803370]  </TASK>
> [   86.803371] ---[ end trace 0000000000000000 ]---
> [   86.932845] usb 1-1.3: USB disconnect, device number 6
> [   86.932852] usb 1-1.3.3: USB disconnect, device number 8
> [   86.932855] usb 1-1.3.3.1: USB disconnect, device number 9
> [   87.028738] usb 1-1.3.3.2: USB disconnect, device number 10
> [   87.028745] usb 1-1.3.3.2.1: USB disconnect, device number 12
> [   87.124962] usb 1-1.3.3.2.4: USB disconnect, device number 13
> [   87.508733] usb 1-1.3.3.3: USB disconnect, device number 11
> [   87.604996] usb 1-1.5: USB disconnect, device number 7
> 
Given the check for partner in typec_altmode_put_partner(), the
port check is not needed because partner is set after checking port
in typec_register_altmode().

Alternatively hold parent until partner is put.

Only for thoughts.

--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -497,8 +497,7 @@ static void typec_altmode_release(struct
 {
 	struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-	if (!is_typec_port(dev->parent))
-		typec_altmode_put_partner(alt);
+	typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
 	kfree(alt);
--

