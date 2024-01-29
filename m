Return-Path: <linux-kernel+bounces-43389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B30384130D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E9D1F258BA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9B3C060;
	Mon, 29 Jan 2024 19:06:30 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797AB29CFB;
	Mon, 29 Jan 2024 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555190; cv=none; b=dwaDV6852ntNjn2jyuB5bzrPLSRCDIqH4gn0Ec2EtnVev5P4YArr4IVGDW7s0IFZ2mu9dGNC8ZX7SA88Uao6RDxzt/2Xvg11GjVkhRylfzruQY5A7GO0IH+t9K1uZtQCx3uYoqcgAmDqMkojwW/RheoxPZUaWNM+SJpF8ixMRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555190; c=relaxed/simple;
	bh=QWJhC9KauIHgrOBoUrRh45vzEQe6OoYHJxiTtCcpTV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLby4DTN0HFxg0Nf+xkIG2wFfGcO+1A4U2Kc1bleR+8fxKUnMSx5NR4qIw7fVEC8aUZ/roDq44d0uw06nDV5DBaJsx9sho/gyL8q5ITIMsZwT5nblO9undF4IHWW9LCx9qkVng/q3BmRMPUGsNKhOuwkWEuetsIJRW8NHJKk/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 36F881402F9; Mon, 29 Jan 2024 20:06:27 +0100 (CET)
Date: Mon, 29 Jan 2024 20:06:27 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: typec_altmode_release =?utf-8?B?4oaS?=
 =?utf-8?Q?_refcount=5Ft=3A?= underflow; use-after-free.
Message-ID: <Zbf3M2+r5RP9K8jJ@cae.in-ulm.de>
References: <e12b5e52-1c94-472d-949b-2ee158857584@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e12b5e52-1c94-472d-949b-2ee158857584@molgen.mpg.de>


Hi Paul,

On Mon, Jan 29, 2024 at 12:57:11PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> I noticed the message first time with Linux 6.6.8 on December 26th, and also
> with 6.6.11, 6.7 and 6.7.1. I am unsure how to reproduce it though.
> 
> Here the trace from Linux 6.7.1-1~exp1:
> 
> ```
> [    0.000000] Linux version 6.7-amd64 (debian-kernel@lists.debian.org)
> (x86_64-linux-gnu-gcc-13 (Debian 13.2.0-10) 13.2.0, GNU ld (GNU Binutils for
> Debian) 2.41.90.20240115) #1 SMP PREEMPT_DYNAMIC Debian 6.7.1-1~exp1
> (2024-01-22)
> […]
> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> […]
> [ 9068.294345] ucsi_acpi USBC000:00: failed to re-enable notifications
> (-110)
> [ 9068.499156] ------------[ cut here ]------------
> [ 9068.499172] refcount_t: underflow; use-after-free.
> [ 9068.499199] WARNING: CPU: 0 PID: 5598 at lib/refcount.c:28
> refcount_warn_saturate+0xbe/0x110
> [ 9068.499209] Modules linked in: uinput rfcomm cmac algif_hash
> algif_skcipher af_alg bnep xfrm_interface xfrm6_tunnel tunnel6 tunnel4
> xfrm_user l2tp_ppp xfrm_algo l2tp_netlink l2tp_core ip6_udp_tunnel
> udp_tunnel pppox ppp_generic slhc ctr ccm typec_displayport snd_seq_dummy
> snd_hrtimer snd_seq snd_seq_device qrtr binfmt_misc snd_sof_pci_intel_skl
> snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation
> snd_sof_intel_hda_mlink soundwire_cadence snd_sof_intel_hda snd_sof_pci
> snd_sof_xtensa_dsp snd_sof snd_sof_utils soundwire_bus snd_hda_codec_hdmi
> snd_soc_avs snd_soc_hda_codec snd_soc_skl snd_soc_hdac_hda snd_hda_ext_core
> snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi
> snd_ctl_led btusb snd_soc_core btrtl btintel snd_hda_codec_realtek
> ath10k_pci btbcm x86_pkg_temp_thermal nls_ascii btmtk intel_powerclamp
> snd_hda_codec_generic bluetooth mei_hdcp mei_pxp mei_wdt ath10k_core
> coretemp snd_compress nls_cp437 snd_pcm_dmaengine kvm_intel vfat
> snd_hda_intel ath snd_intel_dspcfg fat
> [ 9068.499300]  snd_intel_sdw_acpi kvm mac80211 snd_hda_codec intel_rapl_msr
> dell_laptop ledtrig_audio i915 snd_hda_core sha3_generic jitterentropy_rng
> irqbypass libarc4 dell_smm_hwmon snd_hwdep dell_wmi rapl cfg80211 uvcvideo
> snd_pcm intel_cstate dell_smbios joydev videobuf2_vmalloc iTCO_wdt
> intel_pmc_bxt drbg intel_uncore dcdbas ansi_cprng uvc snd_timer
> iTCO_vendor_support dell_wmi_descriptor intel_wmi_thunderbolt
> videobuf2_memops snd videobuf2_v4l2 watchdog ecdh_generic wmi_bmof pcspkr
> videodev soundcore rfkill mei_me ucsi_acpi mei typec_ucsi videobuf2_common
> ecc typec mc drm_buddy intel_pch_thermal drm_display_helper sg
> processor_thermal_device_pci_legacy cec processor_thermal_device
> processor_thermal_wt_hint rc_core intel_vbtn processor_thermal_rfim
> soc_button_array processor_thermal_rapl intel_rapl_common ttm
> processor_thermal_wt_req drm_kms_helper int3403_thermal
> processor_thermal_power_floor evdev processor_thermal_mbox
> intel_xhci_usb_role_switch int340x_thermal_zone intel_pmc_core i2c_algo_bit
> intel_hid
> [ 9068.499386]  int3400_thermal intel_soc_dts_iosf acpi_pad roles ac
> acpi_thermal_rel sparse_keymap button hid_multitouch serio_raw msr
> parport_pc ppdev lp parport loop efi_pstore configfs nfnetlink efivarfs
> ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic sd_mod
> r8153_ecm cdc_ether usbnet r8152 mii uas usb_storage scsi_mod scsi_common
> usbhid dm_crypt dm_mod hid_generic nvme i2c_hid_acpi crc32_pclmul i2c_hid
> crc32c_intel nvme_core t10_pi xhci_pci ghash_clmulni_intel drm
> crc64_rocksoft_generic xhci_hcd crc64_rocksoft crc_t10dif sha512_ssse3
> sha512_generic crct10dif_generic intel_lpss_pci crct10dif_pclmul i2c_i801
> sha256_ssse3 intel_lpss crc64 usbcore sha1_ssse3 crct10dif_common i2c_smbus
> idma64 hid usb_common battery video wmi aesni_intel crypto_simd cryptd
> [ 9068.499459] CPU: 0 PID: 5598 Comm: kworker/0:1 Not tainted 6.7-amd64 #1
> Debian 6.7.1-1~exp1
> [ 9068.499471] Hardware name: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0
> 06/02/2022
> [ 9068.499473] Workqueue: events ucsi_handle_connector_change [typec_ucsi]
> [ 9068.499484] RIP: 0010:refcount_warn_saturate+0xbe/0x110
> [ 9068.499496] Code: 01 01 e8 d5 21 a9 ff 0f 0b c3 cc cc cc cc 80 3d bf 61
> 7e 01 00 75 85 48 c7 c7 30 ca 8f aa c6 05 af 61 7e 01 01 e8 b2 21 a9 ff <0f>
> 0b c3 cc cc cc cc 80 3d 9d 61 7e 01 00 0f 85 5e ff ff ff 48 c7
> [ 9068.499498] RSP: 0018:ffffae5a05d67d90 EFLAGS: 00010282
> [ 9068.499500] RAX: 0000000000000000 RBX: ffff8d8a094d2c08 RCX:
> 0000000000000027
> [ 9068.499502] RDX: ffff8d8d6f021408 RSI: 0000000000000001 RDI:
> ffff8d8d6f021400
> [ 9068.499503] RBP: ffff8d8a094d2c00 R08: 0000000000000000 R09:
> ffffae5a05d67c18
> [ 9068.499504] R10: 0000000000000003 R11: ffff8d8d80ffffe8 R12:
> 0000000000000000
> [ 9068.499506] R13: ffff8d8a038a51d0 R14: ffffffffaa520100 R15:
> ffff8d8a4028b038
> [ 9068.499507] FS:  0000000000000000(0000) GS:ffff8d8d6f000000(0000)
> knlGS:0000000000000000
> [ 9068.499509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9068.499516] CR2: 000002f9ce649010 CR3: 000000010cc86004 CR4:
> 00000000003706f0
> [ 9068.499517] Call Trace:
> [ 9068.499521]  <TASK>
> [ 9068.499522]  ? refcount_warn_saturate+0xbe/0x110
> [ 9068.499526]  ? __warn+0x81/0x130
> [ 9068.499533]  ? refcount_warn_saturate+0xbe/0x110
> [ 9068.499545]  ? report_bug+0x171/0x1a0
> [ 9068.499549]  ? console_unlock+0x78/0x120
> [ 9068.499553]  ? handle_bug+0x3c/0x80
> [ 9068.499557]  ? exc_invalid_op+0x17/0x70
> [ 9068.499565]  ? asm_exc_invalid_op+0x1a/0x20
> [ 9068.499570]  ? refcount_warn_saturate+0xbe/0x110
> [ 9068.499576]  typec_altmode_release+0x49/0xc0 [typec]
> [ 9068.499615]  device_release+0x34/0x90
> [ 9068.499624]  kobject_put+0x78/0x190
> [ 9068.499629]  ucsi_unregister_altmodes+0x41/0xa0 [typec_ucsi]
> [ 9068.499648]  ucsi_unregister_partner.part.0+0x77/0xa0 [typec_ucsi]
> [ 9068.499662]  ucsi_handle_connector_change+0x1bb/0x310 [typec_ucsi]
> [ 9068.499671]  process_one_work+0x171/0x340
> [ 9068.499676]  worker_thread+0x27b/0x3a0
> [ 9068.499679]  ? __pfx_worker_thread+0x10/0x10
> [ 9068.499681]  kthread+0xe5/0x120
> [ 9068.499690]  ? __pfx_kthread+0x10/0x10
> [ 9068.499693]  ret_from_fork+0x31/0x50
> [ 9068.499698]  ? __pfx_kthread+0x10/0x10
> [ 9068.499700]  ret_from_fork_asm+0x1b/0x30
> [ 9068.499714]  </TASK>
> [ 9068.499715] ---[ end trace 0000000000000000 ]---
> ```
> 
> Please find the full output of `dmesg` attached.

This should be fixed by

| commit 5962ded777d689cd8bf04454273e32228d7fb71f
| Author: RD Babiera <rdbabiera@google.com>
| Date:   Wed Jan 3 18:17:55 2024 +0000
| 
|     usb: typec: class: fix typec_altmode_put_partner to put plugs

which is in mainline and 6.7.2.

     regards    Christian


