Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92179EA06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbjIMNrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbjIMNre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:47:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08BC19BB;
        Wed, 13 Sep 2023 06:47:29 -0700 (PDT)
Received: from mercury (dyndsl-091-248-208-175.ewe-ip-backbone.de [91.248.208.175])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BEF326607335;
        Wed, 13 Sep 2023 14:47:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694612847;
        bh=NyOfiNL1QfZTi8AUTOP2qNddPj8TuI1rL4jw3nqAoZs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=X6soAnEtTI2bdIG1a5NA3DIU4ySv5alyelYIHw2rI/4H7ifPLook5+WrhA46m1cXW
         R0yKemrgeNzYE6pnks6s+27+E7Dp/XHG9uzgyx4fvqj19GLg88jAnJzbFMqj+ZQs46
         hFvrvfaDHsVY+oCNubOEYXFgHNfK+Y5Hkx4ZXTxJ+iaC7NSFxEWoU780Jchqwak5Xc
         FftKP9brFiDzCTkD/6J+EPB8GbbOC70E4jEIRUdNmM97P/HRGv1W8SRQHNqoVHwP5X
         6q/V3vLKl0EGf2wES8G87lX88LizN19FN08HMXJ61GT5jWiXllb8t3IRmwA/h0aw0B
         gJca9SVex/uXg==
Received: by mercury (Postfix, from userid 1000)
        id 34F6E106098A; Wed, 13 Sep 2023 15:38:30 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     sre@kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Shyam-sundar.S-k@amd.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230913033233.602986-1-kai.heng.feng@canonical.com>
References: <20230913033233.602986-1-kai.heng.feng@canonical.com>
Subject: Re: [PATCH] power: supply: core: Use blocking_notifier_call_chain
 to avoid RCU complaint
Message-Id: <169461231016.591556.4454793162496509668.b4-ty@collabora.com>
Date:   Wed, 13 Sep 2023 15:38:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2023 11:32:33 +0800, Kai-Heng Feng wrote:
> AMD PMF driver can cause the following warning:
> [  196.159546] ------------[ cut here ]------------
> [  196.159556] Voluntary context switch within RCU read-side critical section!
> [  196.159571] WARNING: CPU: 0 PID: 9 at kernel/rcu/tree_plugin.h:320 rcu_note_context_switch+0x43d/0x560
> [  196.159604] Modules linked in: nvme_fabrics ccm rfcomm snd_hda_scodec_cs35l41_spi cmac algif_hash algif_skcipher af_alg bnep joydev btusb btrtl uvcvideo btintel btbcm videobuf2_vmalloc intel_rapl_msr btmtk videobuf2_memops uvc videobuf2_v4l2 intel_rapl_common binfmt_misc hid_sensor_als snd_sof_amd_vangogh hid_sensor_trigger bluetooth industrialio_triggered_buffer videodev snd_sof_amd_rembrandt hid_sensor_iio_common amdgpu ecdh_generic kfifo_buf videobuf2_common hp_wmi kvm_amd sparse_keymap snd_sof_amd_renoir wmi_bmof industrialio ecc mc nls_iso8859_1 kvm snd_sof_amd_acp irqbypass snd_sof_xtensa_dsp crct10dif_pclmul crc32_pclmul mt7921e snd_sof_pci snd_ctl_led polyval_clmulni mt7921_common polyval_generic snd_sof ghash_clmulni_intel mt792x_lib mt76_connac_lib sha512_ssse3 snd_sof_utils aesni_intel snd_hda_codec_realtek crypto_simd mt76 snd_hda_codec_generic cryptd snd_soc_core snd_hda_codec_hdmi rapl ledtrig_audio input_leds snd_compress i2c_algo_bit drm_ttm_helper mac80211 snd_p
 ci_ps hid_multitouch ttm drm_exec
> [  196.159970]  drm_suballoc_helper snd_rpl_pci_acp6x amdxcp drm_buddy snd_hda_intel snd_acp_pci snd_hda_scodec_cs35l41_i2c serio_raw gpu_sched snd_hda_scodec_cs35l41 snd_acp_legacy_common snd_intel_dspcfg snd_hda_cs_dsp_ctls snd_hda_codec libarc4 drm_display_helper snd_pci_acp6x cs_dsp snd_hwdep snd_soc_cs35l41_lib video k10temp snd_pci_acp5x thunderbolt snd_hda_core drm_kms_helper cfg80211 snd_seq snd_rn_pci_acp3x snd_pcm snd_acp_config cec snd_soc_acpi snd_seq_device rc_core ccp snd_pci_acp3x snd_timer snd soundcore wmi amd_pmf platform_profile amd_pmc mac_hid serial_multi_instantiate wireless_hotkey hid_sensor_hub sch_fq_codel msr parport_pc ppdev lp parport efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx libcrc32c xor raid6_pq raid1 raid0 multipath linear dm_mirror dm_region_hash dm_log cdc_ether usbnet r8152 mii hid_generic nvme i2c_hid_acpi i2c_hid nvme_core i2c_piix4 xhci_pci amd_sfh drm x
 hci_pci_renesas nvme_common hid
> [  196.160382] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.6.0-rc1 #4
> [  196.160397] Hardware name: HP HP EliteBook 845 14 inch G10 Notebook PC/8B6E, BIOS V82 Ver. 01.02.00 08/24/2023
> [  196.160405] Workqueue: events power_supply_changed_work
> [  196.160426] RIP: 0010:rcu_note_context_switch+0x43d/0x560
> [  196.160440] Code: 00 48 89 be 40 08 00 00 48 89 86 48 08 00 00 48 89 10 e9 63 fe ff ff 48 c7 c7 10 e7 b0 9e c6 05 e8 d8 20 02 01 e8 13 0f f3 ff <0f> 0b e9 27 fc ff ff a9 ff ff ff 7f 0f 84 cf fc ff ff 65 48 8b 3c
> [  196.160450] RSP: 0018:ffffc900001878f0 EFLAGS: 00010046
> [  196.160462] RAX: 0000000000000000 RBX: ffff88885e834040 RCX: 0000000000000000
> [  196.160470] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  196.160476] RBP: ffffc90000187910 R08: 0000000000000000 R09: 0000000000000000
> [  196.160482] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  196.160488] R13: 0000000000000000 R14: ffff888100990000 R15: ffff888100990000
> [  196.160495] FS:  0000000000000000(0000) GS:ffff88885e800000(0000) knlGS:0000000000000000
> [  196.160504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  196.160512] CR2: 000055cb053c8246 CR3: 000000013443a000 CR4: 0000000000750ef0
> [  196.160520] PKRU: 55555554
> [  196.160526] Call Trace:
> [  196.160532]  <TASK>
> [  196.160548]  ? show_regs+0x72/0x90
> [  196.160570]  ? rcu_note_context_switch+0x43d/0x560
> [  196.160580]  ? __warn+0x8d/0x160
> [  196.160600]  ? rcu_note_context_switch+0x43d/0x560
> [  196.160613]  ? report_bug+0x1bb/0x1d0
> [  196.160637]  ? handle_bug+0x46/0x90
> [  196.160658]  ? exc_invalid_op+0x19/0x80
> [  196.160675]  ? asm_exc_invalid_op+0x1b/0x20
> [  196.160709]  ? rcu_note_context_switch+0x43d/0x560
> [  196.160727]  __schedule+0xb9/0x15f0
> [  196.160746]  ? srso_alias_return_thunk+0x5/0x7f
> [  196.160765]  ? srso_alias_return_thunk+0x5/0x7f
> [  196.160778]  ? acpi_ns_search_one_scope+0xbe/0x270
> [  196.160806]  schedule+0x68/0x110
> [  196.160820]  schedule_timeout+0x151/0x160
> [  196.160829]  ? srso_alias_return_thunk+0x5/0x7f
> [  196.160842]  ? srso_alias_return_thunk+0x5/0x7f
> [  196.160855]  ? acpi_ns_lookup+0x3c5/0xa90
> [  196.160878]  __down_common+0xff/0x220
> [  196.160905]  __down_timeout+0x16/0x30
> [  196.160920]  down_timeout+0x64/0x70
> [  196.160938]  acpi_os_wait_semaphore+0x85/0x200
> [  196.160959]  acpi_ut_acquire_mutex+0x9e/0x280
> [  196.160979]  acpi_ex_enter_interpreter+0x2d/0xb0
> [  196.160992]  acpi_ns_evaluate+0x2f0/0x5f0
> [  196.161005]  acpi_evaluate_object+0x172/0x490
> [  196.161018]  ? acpi_os_signal_semaphore+0x8a/0xd0
> [  196.161038]  acpi_evaluate_integer+0x52/0xe0
> [  196.161055]  ? kfree+0x79/0x120
> [  196.161071]  ? srso_alias_return_thunk+0x5/0x7f
> [  196.161089]  acpi_ac_get_state.part.0+0x27/0x80
> [  196.161110]  get_ac_property+0x5c/0x70
> [  196.161127]  ? __pfx___power_supply_is_system_supplied+0x10/0x10
> [  196.161146]  __power_supply_is_system_supplied+0x44/0xb0
> [  196.161166]  class_for_each_device+0x124/0x160
> [  196.161184]  ? acpi_ac_get_state.part.0+0x27/0x80
> [  196.161203]  ? srso_alias_return_thunk+0x5/0x7f
> [  196.161223]  power_supply_is_system_supplied+0x3c/0x70
> [  196.161243]  amd_pmf_get_power_source+0xe/0x20 [amd_pmf]
> [  196.161276]  amd_pmf_power_slider_update_event+0x49/0x90 [amd_pmf]
> [  196.161310]  amd_pmf_pwr_src_notify_call+0xe7/0x100 [amd_pmf]
> [  196.161340]  notifier_call_chain+0x5f/0xe0
> [  196.161362]  atomic_notifier_call_chain+0x33/0x60
> [  196.161378]  power_supply_changed_work+0x84/0x110
> [  196.161394]  process_one_work+0x178/0x360
> [  196.161412]  ? __pfx_worker_thread+0x10/0x10
> [  196.161424]  worker_thread+0x307/0x430
> [  196.161440]  ? __pfx_worker_thread+0x10/0x10
> [  196.161451]  kthread+0xf4/0x130
> [  196.161467]  ? __pfx_kthread+0x10/0x10
> [  196.161486]  ret_from_fork+0x43/0x70
> [  196.161502]  ? __pfx_kthread+0x10/0x10
> [  196.161518]  ret_from_fork_asm+0x1b/0x30
> [  196.161558]  </TASK>
> [  196.161562] ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied, thanks!

[1/1] power: supply: core: Use blocking_notifier_call_chain to avoid RCU complaint
      commit: bbaa6ffa5b6c9609d3b3c431c389b407eea5441f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

