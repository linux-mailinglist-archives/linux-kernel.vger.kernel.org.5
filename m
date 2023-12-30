Return-Path: <linux-kernel+bounces-13330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8619A82039D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E972C2836B2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E8A7487;
	Sat, 30 Dec 2023 04:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="BNo+dBGB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EBF6119;
	Sat, 30 Dec 2023 04:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703911906; x=1704171106;
	bh=5VTyvL/DdMZsi5DBTtYh31sxBdNS0577y8NDRL+Gg3g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BNo+dBGBzkLAb7EgHKT13txrDvryR2z2YyH4r0qp0NPsaZT1MYUzp6uMQ+Y5sIwyv
	 8NaERvkvPzkzOPPWycmlera9yJ23tNaqUzIR6RqjiLu6m72ltxIYPIdcPyOMX8OOB0
	 gwUpkP2nhCVR0bYng1stFbiZOvoh1umuMsjK736USyXYcS0i9VHNLLGHCnYeVLI+by
	 CXNyTjUplwFH56N5IHDvqeEY3il2Y7EqjSmAzgHvfwa3PtMflhvtzAW07lsqq49WU1
	 g9kbD9HkZz6KpKszF5XkXEswu2E39o+P61yhj0ooTKyFTcU4qjkAqAPfZukZgBefLs
	 dOCLmTeFWEdNA==
Date: Sat, 30 Dec 2023 04:51:35 +0000
To: Kalle Valo <kvalo@kernel.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH wireless 2/5] wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
Message-ID: <20231230045105.91351-3-sergeantsagara@protonmail.com>
In-Reply-To: <20231230045105.91351-1-sergeantsagara@protonmail.com>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When QoS is disabled, the queue priority value will not map to the correct
ieee80211 queue since there is only one queue. Stop/wake queue 0 when QoS
is disabled to prevent trying to stop/wake a non-existent queue and failing
to stop/wake the actual queue instantiated.

Log of issue before change (with kernel parameter qos=3D0):
    [  +5.112651] ------------[ cut here ]------------
    [  +0.000005] WARNING: CPU: 7 PID: 25513 at net/mac80211/util.c:449 __i=
eee80211_wake_queue+0xd5/0x180 [mac80211]
    [  +0.000067] Modules linked in: b43(O) snd_seq_dummy snd_hrtimer snd_s=
eq snd_seq_device nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo xt=
_addrtype overlay ccm af_packet amdgpu snd_hda_codec_cirrus snd_hda_codec_g=
eneric ledtrig_audio drm_exec amdxcp gpu_sched xt_conntrack nf_conntrack nf=
_defrag_ipv6 nf_defrag_ipv4 ip6t_rpfilter ipt_rpfilter xt_pkttype xt_LOG nf=
_log_syslog xt_tcpudp nft_compat nf_tables nfnetlink sch_fq_codel btusb uin=
put iTCO_wdt ctr btrtl intel_pmc_bxt i915 intel_rapl_msr mei_hdcp mei_pxp j=
oydev at24 watchdog btintel atkbd libps2 serio radeon btbcm vivaldi_fmap bt=
mtk intel_rapl_common snd_hda_codec_hdmi bluetooth uvcvideo nls_iso8859_1 a=
pplesmc nls_cp437 x86_pkg_temp_thermal snd_hda_intel intel_powerclamp vfat =
videobuf2_vmalloc coretemp fat snd_intel_dspcfg crc32_pclmul uvc polyval_cl=
mulni snd_intel_sdw_acpi loop videobuf2_memops snd_hda_codec tun drm_suball=
oc_helper polyval_generic drm_ttm_helper drm_buddy tap ecdh_generic videobu=
f2_v4l2 gf128mul macvlan ttm ghash_clmulni_intel ecc tg3
    [  +0.000044]  videodev bridge snd_hda_core rapl crc16 drm_display_help=
er cec mousedev snd_hwdep evdev intel_cstate bcm5974 hid_appleir videobuf2_=
common stp mac_hid libphy snd_pcm drm_kms_helper acpi_als mei_me intel_unco=
re llc mc snd_timer intel_gtt industrialio_triggered_buffer apple_mfi_fastc=
harge i2c_i801 mei snd lpc_ich agpgart ptp i2c_smbus thunderbolt apple_gmux=
 i2c_algo_bit kfifo_buf video industrialio soundcore pps_core wmi tiny_powe=
r_button sbs sbshc button ac cordic bcma mac80211 cfg80211 ssb rfkill libar=
c4 kvm_intel kvm drm irqbypass fuse backlight firmware_class efi_pstore con=
figfs efivarfs dmi_sysfs ip_tables x_tables autofs4 dm_crypt cbc encrypted_=
keys trusted asn1_encoder tee tpm rng_core input_leds hid_apple led_class h=
id_generic usbhid hid sd_mod t10_pi crc64_rocksoft crc64 crc_t10dif crct10d=
if_generic ahci libahci libata uhci_hcd ehci_pci ehci_hcd crct10dif_pclmul =
crct10dif_common sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesni_=
intel usbcore scsi_mod libaes crypto_simd cryptd scsi_common
    [  +0.000055]  usb_common rtc_cmos btrfs blake2b_generic libcrc32c crc3=
2c_generic crc32c_intel xor raid6_pq dm_snapshot dm_bufio dm_mod dax [last =
unloaded: b43(O)]
    [  +0.000009] CPU: 7 PID: 25513 Comm: irq/17-b43 Tainted: G        W  O=
       6.6.7 #1-NixOS
    [  +0.000003] Hardware name: Apple Inc. MacBookPro8,3/Mac-942459F5819B1=
71B, BIOS 87.0.0.0.0 06/13/2019
    [  +0.000001] RIP: 0010:__ieee80211_wake_queue+0xd5/0x180 [mac80211]
    [  +0.000046] Code: 00 45 85 e4 0f 85 9b 00 00 00 48 8d bd 40 09 00 00 =
f0 48 0f ba ad 48 09 00 00 00 72 0f 5b 5d 41 5c 41 5d 41 5e e9 cb 6d 3c d0 =
<0f> 0b 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 48 8d b4 16 94 00 00
    [  +0.000002] RSP: 0018:ffffc90003c77d60 EFLAGS: 00010097
    [  +0.000001] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 00000000=
00000000
    [  +0.000001] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff8882=
0b924900
    [  +0.000002] RBP: ffff88820b924900 R08: ffffc90003c77d90 R09: 00000000=
0003bfd0
    [  +0.000001] R10: ffff88820b924900 R11: ffffc90003c77c68 R12: 00000000=
00000000
    [  +0.000001] R13: 0000000000000000 R14: ffffc90003c77d90 R15: ffffffff=
c0fa6f40
    [  +0.000001] FS:  0000000000000000(0000) GS:ffff88846fb80000(0000) knl=
GS:0000000000000000
    [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  +0.000001] CR2: 00007fafda7ae008 CR3: 000000046d220005 CR4: 00000000=
000606e0
    [  +0.000002] Call Trace:
    [  +0.000003]  <TASK>
    [  +0.000001]  ? __ieee80211_wake_queue+0xd5/0x180 [mac80211]
    [  +0.000044]  ? __warn+0x81/0x130
    [  +0.000005]  ? __ieee80211_wake_queue+0xd5/0x180 [mac80211]
    [  +0.000045]  ? report_bug+0x171/0x1a0
    [  +0.000004]  ? handle_bug+0x41/0x70
    [  +0.000004]  ? exc_invalid_op+0x17/0x70
    [  +0.000003]  ? asm_exc_invalid_op+0x1a/0x20
    [  +0.000005]  ? __ieee80211_wake_queue+0xd5/0x180 [mac80211]
    [  +0.000043]  ieee80211_wake_queue+0x4a/0x80 [mac80211]
    [  +0.000044]  b43_dma_handle_txstatus+0x29c/0x3a0 [b43]
    [  +0.000016]  ? __pfx_irq_thread_fn+0x10/0x10
    [  +0.000002]  b43_handle_txstatus+0x61/0x80 [b43]
    [  +0.000012]  b43_interrupt_thread_handler+0x3f9/0x6b0 [b43]
    [  +0.000011]  irq_thread_fn+0x23/0x60
    [  +0.000002]  irq_thread+0xfe/0x1c0
    [  +0.000002]  ? __pfx_irq_thread_dtor+0x10/0x10
    [  +0.000001]  ? __pfx_irq_thread+0x10/0x10
    [  +0.000001]  kthread+0xe8/0x120
    [  +0.000003]  ? __pfx_kthread+0x10/0x10
    [  +0.000003]  ret_from_fork+0x34/0x50
    [  +0.000002]  ? __pfx_kthread+0x10/0x10
    [  +0.000002]  ret_from_fork_asm+0x1b/0x30
    [  +0.000004]  </TASK>
    [  +0.000001] ---[ end trace 0000000000000000 ]---

    [  +0.000065] ------------[ cut here ]------------
    [  +0.000001] WARNING: CPU: 0 PID: 56077 at net/mac80211/util.c:514 __i=
eee80211_stop_queue+0xcc/0xe0 [mac80211]
    [  +0.000077] Modules linked in: b43(O) snd_seq_dummy snd_hrtimer snd_s=
eq snd_seq_device nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo xt=
_addrtype overlay ccm af_packet amdgpu snd_hda_codec_cirrus snd_hda_codec_g=
eneric ledtrig_audio drm_exec amdxcp gpu_sched xt_conntrack nf_conntrack nf=
_defrag_ipv6 nf_defrag_ipv4 ip6t_rpfilter ipt_rpfilter xt_pkttype xt_LOG nf=
_log_syslog xt_tcpudp nft_compat nf_tables nfnetlink sch_fq_codel btusb uin=
put iTCO_wdt ctr btrtl intel_pmc_bxt i915 intel_rapl_msr mei_hdcp mei_pxp j=
oydev at24 watchdog btintel atkbd libps2 serio radeon btbcm vivaldi_fmap bt=
mtk intel_rapl_common snd_hda_codec_hdmi bluetooth uvcvideo nls_iso8859_1 a=
pplesmc nls_cp437 x86_pkg_temp_thermal snd_hda_intel intel_powerclamp vfat =
videobuf2_vmalloc coretemp fat snd_intel_dspcfg crc32_pclmul uvc polyval_cl=
mulni snd_intel_sdw_acpi loop videobuf2_memops snd_hda_codec tun drm_suball=
oc_helper polyval_generic drm_ttm_helper drm_buddy tap ecdh_generic videobu=
f2_v4l2 gf128mul macvlan ttm ghash_clmulni_intel ecc tg3
    [  +0.000073]  videodev bridge snd_hda_core rapl crc16 drm_display_help=
er cec mousedev snd_hwdep evdev intel_cstate bcm5974 hid_appleir videobuf2_=
common stp mac_hid libphy snd_pcm drm_kms_helper acpi_als mei_me intel_unco=
re llc mc snd_timer intel_gtt industrialio_triggered_buffer apple_mfi_fastc=
harge i2c_i801 mei snd lpc_ich agpgart ptp i2c_smbus thunderbolt apple_gmux=
 i2c_algo_bit kfifo_buf video industrialio soundcore pps_core wmi tiny_powe=
r_button sbs sbshc button ac cordic bcma mac80211 cfg80211 ssb rfkill libar=
c4 kvm_intel kvm drm irqbypass fuse backlight firmware_class efi_pstore con=
figfs efivarfs dmi_sysfs ip_tables x_tables autofs4 dm_crypt cbc encrypted_=
keys trusted asn1_encoder tee tpm rng_core input_leds hid_apple led_class h=
id_generic usbhid hid sd_mod t10_pi crc64_rocksoft crc64 crc_t10dif crct10d=
if_generic ahci libahci libata uhci_hcd ehci_pci ehci_hcd crct10dif_pclmul =
crct10dif_common sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesni_=
intel usbcore scsi_mod libaes crypto_simd cryptd scsi_common
    [  +0.000084]  usb_common rtc_cmos btrfs blake2b_generic libcrc32c crc3=
2c_generic crc32c_intel xor raid6_pq dm_snapshot dm_bufio dm_mod dax [last =
unloaded: b43]
    [  +0.000012] CPU: 0 PID: 56077 Comm: kworker/u16:17 Tainted: G        =
W  O       6.6.7 #1-NixOS
    [  +0.000003] Hardware name: Apple Inc. MacBookPro8,3/Mac-942459F5819B1=
71B, BIOS 87.0.0.0.0 06/13/2019
    [  +0.000001] Workqueue: phy7 b43_tx_work [b43]
    [  +0.000019] RIP: 0010:__ieee80211_stop_queue+0xcc/0xe0 [mac80211]
    [  +0.000076] Code: 74 11 48 8b 78 08 0f b7 d6 89 e9 4c 89 e6 e8 ab f4 =
00 00 65 ff 0d 9c b7 34 3f 0f 85 55 ff ff ff 0f 1f 44 00 00 e9 4b ff ff ff =
<0f> 0b 5b 5d 41 5c 41 5d c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90
    [  +0.000002] RSP: 0000:ffffc90004157d50 EFLAGS: 00010097
    [  +0.000002] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 00000000=
00000000
    [  +0.000002] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff8882=
d65d0900
    [  +0.000002] RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000=
00000001
    [  +0.000001] R10: 00000000000000ff R11: ffff88814d0155a0 R12: ffff8882=
d65d0900
    [  +0.000002] R13: 0000000000000000 R14: ffff8881002d2800 R15: 00000000=
000000d0
    [  +0.000002] FS:  0000000000000000(0000) GS:ffff88846f800000(0000) knl=
GS:0000000000000000
    [  +0.000003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  +0.000002] CR2: 00007f2e8c10c880 CR3: 0000000385b66005 CR4: 00000000=
000606f0
    [  +0.000002] Call Trace:
    [  +0.000001]  <TASK>
    [  +0.000001]  ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211]
    [  +0.000075]  ? __warn+0x81/0x130
    [  +0.000004]  ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211]
    [  +0.000075]  ? report_bug+0x171/0x1a0
    [  +0.000005]  ? handle_bug+0x41/0x70
    [  +0.000003]  ? exc_invalid_op+0x17/0x70
    [  +0.000004]  ? asm_exc_invalid_op+0x1a/0x20
    [  +0.000004]  ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211]
    [  +0.000076]  ieee80211_stop_queue+0x36/0x50 [mac80211]
    [  +0.000077]  b43_dma_tx+0x550/0x780 [b43]
    [  +0.000023]  b43_tx_work+0x90/0x130 [b43]
    [  +0.000018]  process_one_work+0x174/0x340
    [  +0.000003]  worker_thread+0x27b/0x3a0
    [  +0.000004]  ? __pfx_worker_thread+0x10/0x10
    [  +0.000002]  kthread+0xe8/0x120
    [  +0.000003]  ? __pfx_kthread+0x10/0x10
    [  +0.000004]  ret_from_fork+0x34/0x50
    [  +0.000002]  ? __pfx_kthread+0x10/0x10
    [  +0.000003]  ret_from_fork_asm+0x1b/0x30
    [  +0.000006]  </TASK>
    [  +0.000001] ---[ end trace 0000000000000000 ]---

Fixes: e6f5b934fba8 ("b43: Add QOS support")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---
 drivers/net/wireless/broadcom/b43/dma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless=
/broadcom/b43/dma.c
index 760d1a28edc6..68671de27569 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1399,7 +1399,10 @@ int b43_dma_tx(struct b43_wldev *dev, struct sk_buff=
 *skb)
 =09    should_inject_overflow(ring)) {
 =09=09/* This TX ring is full. */
 =09=09unsigned int skb_mapping =3D skb_get_queue_mapping(skb);
-=09=09ieee80211_stop_queue(dev->wl->hw, skb_mapping);
+=09=09if (dev->qos_enabled)
+=09=09=09ieee80211_stop_queue(dev->wl->hw, skb_mapping);
+=09=09else
+=09=09=09ieee80211_stop_queue(dev->wl->hw, 0);
 =09=09dev->wl->tx_queue_stopped[skb_mapping] =3D true;
 =09=09ring->stopped =3D true;
 =09=09if (b43_debug(dev, B43_DBG_DMAVERBOSE)) {
@@ -1570,7 +1573,10 @@ void b43_dma_handle_txstatus(struct b43_wldev *dev,
 =09} else {
 =09=09/* If the driver queue is running wake the corresponding
 =09=09 * mac80211 queue. */
-=09=09ieee80211_wake_queue(dev->wl->hw, ring->queue_prio);
+=09=09if (dev->qos_enabled)
+=09=09=09ieee80211_wake_queue(dev->wl->hw, ring->queue_prio);
+=09=09else
+=09=09=09ieee80211_wake_queue(dev->wl->hw, 0);
 =09=09if (b43_debug(dev, B43_DBG_DMAVERBOSE)) {
 =09=09=09b43dbg(dev->wl, "Woke up TX ring %d\n", ring->index);
 =09=09}
--=20
2.42.0



