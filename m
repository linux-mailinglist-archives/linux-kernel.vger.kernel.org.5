Return-Path: <linux-kernel+bounces-127868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD9E8951E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4D62844BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488BE657AD;
	Tue,  2 Apr 2024 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=preining.info header.i=@preining.info header.b="dzG/PLp5"
Received: from hz.preining.info (hz.preining.info [95.216.25.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8D6341C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.25.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057659; cv=none; b=gKDbbGiFEUHd+6FgYrCDiEgeXyxXr0+1eQxNVmrfod1/ERqCiJFZTqR/FCT+W1eyZVeBV2oxRXRfbR8tKXXPqRZH4RWQFYxrg/Eb3x6qmPj1MriBAiQbG57pnNJwcsrBxFpD/L5pst5K2UTMih4aJkXJAV3nQtwmoF2AtVBXHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057659; c=relaxed/simple;
	bh=Fw1+hra0A03myJvexzxBfAOfEr31l9iivWcQ+7VOtjY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iRuNdZPpTjXBZ4bDxT4b0bJWasibKlpqVy/6JMBRg3TP4mTP8XADz8Yi4ABImbGdrfqbGlKMl0a5yUqZKX+UXWafvQaVA2iJUN/UdsViIQJnL6Z01X32jUQKm2s0z9l7Qcbp8CuGb8Ci0B+XOjcMKyehU1Q33OFNgtveVlQqKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=preining.info; spf=pass smtp.mailfrom=preining.info; dkim=pass (2048-bit key) header.d=preining.info header.i=@preining.info header.b=dzG/PLp5; arc=none smtp.client-ip=95.216.25.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=preining.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=preining.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=preining.info; s=201909; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hMGGVOdo/itUKwmWLaKc0bOikp+kpkHqFdkzGAK43Ro=; b=dzG/PLp5SW/Z9TzZ1FJiSfQsNx
	57Cd70cedGr7QMGENwJCqdfRd+dG/HTZZoXfXsrB2cTxZWHba3+OGThefkOSfHsrpUIb26OZr3Qaq
	srwtj+XS7KPhcY2y7+AJtg4NraRma/GNXzzIB0lkA2nHECNYgvftqPkMOTUkKhGE0QYGbfh+etbJ6
	EocOmFKaZeTcdlCtGtunJE8XuXIP5zsyWZU5OpdmSDxxLhiOrg+X1kOh2saxebeMh/51V3MsyqOEq
	DnN9DcuAOy4SKiMUOqg0d4V/P3C4ZJneFgWfcw8RdDXb1CtJQbv+tJcdA0U25WYD9xWR9ehvvI2Kw
	XjfUSSVQ==;
Received: from tvk215040.tvk.ne.jp ([180.94.215.40] helo=burischnitzel.preining.info)
	by hz.preining.info with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <norbert@preining.info>)
	id 1rrbnh-00Epco-0f
	for linux-kernel@vger.kernel.org;
	Tue, 02 Apr 2024 10:55:33 +0000
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
	id 3391FF8C182; Tue,  2 Apr 2024 19:55:29 +0900 (JST)
Date: Tue, 2 Apr 2024 19:55:29 +0900
From: Norbert Preining <norbert@preining.info>
To: linux-kernel@vger.kernel.org
Subject: Regression in kernel 6.8.2 fails in various ways (USB, BT, ...)
Message-ID: <ZgvkIZFN23rkYhtS@burischnitzel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all

(please cc)

I am running Arch Linux on a Lenovo X1 Carbon Gen 10.
Tests are made with uptodate system, and besides the kernel no
difference.
The kernels are as distributed by Arch, but if necessary I can compile
locally.


Arch Linux kernel 6.8.1 works without any problems.
Upgrading to 6.8.2 breaks a lot of things:

* Plugging in my Yubikey C does not trigger any reaction
  (as a consequence scdaemon hangs)
* sending of bluetooth firmware data fails with Oops (see below)
* shutdown hangs and does not turn off the computer


I can repeat this behaviour on every reboot into 6.8.2.

I have dmesg/journalctl -b for both kernels collected, if required, I
can send them. I checked the diffs but nothing really did stand out.

Yubikey plugin:
On 6.8.1 when I plug in the yubikey it lights up, and in the logs I see:
[  370.767739] usb 3-1: new full-speed USB device number 5 using xhci_hcd
[  370.910392] usb 3-1: New USB device found, idVendor=3D1050, idProduct=3D=
0407, bcdDevice=3D 5.43
[  370.910403] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[  370.910407] usb 3-1: Product: YubiKey OTP+FIDO+CCID
[  370.910409] usb 3-1: Manufacturer: Yubico
[  371.497496] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0000:00/0=
000:00:14.0/usb3/3-1/3-1:1.0/0003:1050:0407.0005/input/input21
[  371.555342] hid-generic 0003:1050:0407.0005: input,hidraw4: USB HID v1.1=
0 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:14.0-1/input0
[  371.557021] hid-generic 0003:1050:0407.0006: hiddev96,hidraw5: USB HID v=
1.10 Device [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:14.0-1/input1
[  371.557145] usbcore: registered new interface driver usbhid
[  371.557151] usbhid: USB HID core driver

On 6.8.2 not short blinking, and nothing in the logs.



Bluetooth Ooops:
   14.271713] usb usb3-port10: disabled by hub (EMI?), re-enabling...
[   14.271725] usb 3-10: USB disconnect, device number 4
[   14.271893] Bluetooth: hci0: Failed to send firmware data (-19)
[   14.271953] Bluetooth: hci0: sending frame failed (-19)
[   14.271976] Bluetooth: hci0: Intel reset sent to retry FW download
[   14.427765] Bluetooth: hci0: sending frame failed (-19)
[   14.427811] BUG: kernel NULL pointer dereference, address: 0000000000000=
070
[   14.427814] #PF: supervisor read access in kernel mode
[   14.427815] #PF: error_code(0x0000) - not-present page
[   14.427816] PGD 0 P4D 0
[   14.427819] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   14.427820] CPU: 0 PID: 198 Comm: kworker/u41:0 Tainted: G           OE =
     6.8.2-arch2-1 #1 a430fb92f7ba43092b62bbe6bac995458d3d442d
[   14.427823] Hardware name: LENOVO 21CBCTO1WW/21CBCTO1WW, BIOS N3AET80W (=
1.45 ) 02/20/2024
[   14.427824] Workqueue: hci0 hci_power_on [bluetooth]
[   14.427874] RIP: 0010:btintel_read_debug_features+0x4d/0xf0 [btintel]
[   14.427880] Code: 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 8d =
4c 24 07 c6 44 24 07 01 e8 de a9 ef ff 48 89 c3 48 3d 00 f0 ff ff 77 49 <83=
> 78 70 13 75 67 48 8b 80 d0 00 00 00 be 02 00 00 00 48 89 df 48
[   14.427881] RSP: 0018:ffffb7ba80aa3cc0 EFLAGS: 00010207
[   14.427882] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff965ac0d=
daab0
[   14.427884] RDX: 0000000000000000 RSI: 0000000000000202 RDI: ffff965ac0d=
daaa8
[   14.427884] RBP: ffffb7ba80aa3cf0 R08: ffff965ac0ddaab0 R09: 00000000000=
00000
[   14.427885] R10: 0000000000000001 R11: 0000000000000100 R12: ffff965ac0d=
da000
[   14.427886] R13: ffff965a84746900 R14: ffff965a8208ca05 R15: ffff965ac0d=
da6d0
[   14.427887] FS:  0000000000000000(0000) GS:ffff9661bf400000(0000) knlGS:=
0000000000000000
[   14.427888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.427889] CR2: 0000000000000070 CR3: 00000002bb620000 CR4: 0000000000f=
50ef0
[   14.427889] PKRU: 55555554
[   14.427890] Call Trace:
[   14.427891]  <TASK>
[   14.427893]  ? __die+0x23/0x70
[   14.427898]  ? page_fault_oops+0x171/0x4e0
[   14.427901]  ? __timer_delete_sync+0x7d/0xe0
[   14.427905]  ? exc_page_fault+0x7f/0x180
[   14.427908]  ? asm_exc_page_fault+0x26/0x30
[   14.427912]  ? btintel_read_debug_features+0x4d/0xf0 [btintel 6735e787c9=
ed982ceaa471c7ab364a390a1acb37]
[   14.427916]  btintel_register_devcoredump_support.isra.0+0x3e/0x110 [bti=
ntel 6735e787c9ed982ceaa471c7ab364a390a1acb37]
[   14.427921]  btintel_setup_combined+0x503/0x790 [btintel 6735e787c9ed982=
ceaa471c7ab364a390a1acb37]
[   14.427925]  hci_dev_open_sync+0x102/0xc20 [bluetooth 81a2e5f6c3a85f38da=
de670bfe91d861a9119613]
[   14.427953]  ? __schedule+0x3ee/0x1520
[   14.427956]  hci_dev_do_open+0x23/0x60 [bluetooth 81a2e5f6c3a85f38dade67=
0bfe91d861a9119613]
[   14.427975]  hci_power_on+0x51/0x260 [bluetooth 81a2e5f6c3a85f38dade670b=
fe91d861a9119613]
[   14.427994]  process_one_work+0x183/0x370
[   14.427998]  worker_thread+0x3ab/0x4f0
[   14.428000]  ? __pfx_worker_thread+0x10/0x10
[   14.428001]  kthread+0xe5/0x120
[   14.428005]  ? __pfx_kthread+0x10/0x10
[   14.428006]  ret_from_fork+0x31/0x50
[   14.428009]  ? __pfx_kthread+0x10/0x10
[   14.428011]  ret_from_fork_asm+0x1b/0x30
[   14.428014]  </TASK>
[   14.428015] Modules linked in: nf_tables bnep tun btusb btrtl btintel bt=
bcm btmtk bluetooth gpio_ljca i2c_ljca ecdh_generic hid_sensor_custom_intel=
_hinge hid_sensor_trigger industrialio_triggered_buffer kfifo_buf hid_senso=
r_iio_common industrialio hid_sensor_custom hid_sensor_hub intel_ishtp_hid =
joydev vfat fat ext4 crc16 mbcache jbd2 snd_ctl_led snd_soc_skl_hda_dsp snd=
_soc_hdac_hdmi snd_soc_intel_hda_dsp_common snd_sof_probes hid_multitouch h=
id_generic mousedev snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_=
generic snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_intel_hda_common soundwi=
re_intel snd_sof_intel_hda_mlink soundwire_cadence snd_sof_intel_hda snd_so=
f_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_hdac_hda snd_hda_ext=
_core snd_soc_acpi_intel_match intel_uncore_frequency intel_uncore_frequenc=
y_common snd_soc_acpi intel_tcc_cooling iwlmvm soundwire_generic_allocation=
 soundwire_bus x86_pkg_temp_thermal intel_powerclamp snd_soc_core mac80211 =
coretemp snd_compress ac97_bus snd_pcm_dmaengine kvm_intel
[   14.428048]  snd_hda_intel libarc4 ptp snd_intel_dspcfg pps_core snd_int=
el_sdw_acpi snd_hda_codec processor_thermal_device_pci kvm processor_therma=
l_device processor_thermal_wt_hint snd_hda_core processor_thermal_rfim iwlw=
ifi iTCO_wdt irqbypass intel_rapl_msr processor_thermal_rapl mei_pxp snd_hw=
dep ucsi_acpi mei_hdcp mei_wdt rapl intel_rapl_common intel_pmc_bxt typec_u=
csi iTCO_vendor_support intel_lpss_pci intel_cstate thinkpad_acpi mei_me th=
ink_lmi snd_pcm spi_nor processor_thermal_wt_req intel_ish_ipc typec ntfs3 =
i2c_i801 intel_lpss nxp_nci_i2c ledtrig_audio processor_thermal_power_floor=
 cfg80211 wmi_bmof intel_uncore psmouse pcspkr firmware_attributes_class mt=
d thunderbolt mei snd_timer idma64 intel_ishtp i2c_smbus ov2740 roles platf=
orm_profile igen6_edac processor_thermal_mbox nxp_nci v4l2_fwnode nci snd i=
ntel_skl_int3472_tps68470 int3403_thermal v4l2_async intel_pmc_core soc_but=
ton_array tps68470_regulator nfc soundcore int340x_thermal_zone clk_tps6847=
0 mei_vsc_hw rfkill videodev intel_vsec i2c_hid_acpi
[   14.428085]  intel_hid int3400_thermal i2c_hid pmt_telemetry mc pinctrl_=
tigerlake sparse_keymap acpi_pad acpi_thermal_rel intel_skl_int3472_discret=
e acpi_tad pmt_class mac_hid i2c_dev corefreqk(OE) sg crypto_user fuse loop=
 nfnetlink ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generi=
c xor raid6_pq dm_crypt cbc encrypted_keys trusted asn1_encoder tee dm_mod =
xe drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec spi_ljca=
 usb_ljca i915 crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni p=
olyval_generic gf128mul ghash_clmulni_intel sha512_ssse3 serio_raw sha256_s=
sse3 atkbd i2c_algo_bit sha1_ssse3 drm_buddy libps2 vivaldi_fmap aesni_inte=
l ttm nvme intel_gtt crypto_simd nvme_core cryptd drm_display_helper video =
xhci_pci spi_intel_pci i8042 nvme_auth xhci_pci_renesas spi_intel cec serio=
 wmi
[   14.428121] CR2: 0000000000000070
[   14.428123] ---[ end trace 0000000000000000 ]---
[   14.428124] RIP: 0010:btintel_read_debug_features+0x4d/0xf0 [btintel]
[   14.428128] Code: 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 8d =
4c 24 07 c6 44 24 07 01 e8 de a9 ef ff 48 89 c3 48 3d 00 f0 ff ff 77 49 <83=
> 78 70 13 75 67 48 8b 80 d0 00 00 00 be 02 00 00 00 48 89 df 48
[   14.428130] RSP: 0018:ffffb7ba80aa3cc0 EFLAGS: 00010207
[   14.428131] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff965ac0d=
daab0
[   14.428131] RDX: 0000000000000000 RSI: 0000000000000202 RDI: ffff965ac0d=
daaa8
[   14.428132] RBP: ffffb7ba80aa3cf0 R08: ffff965ac0ddaab0 R09: 00000000000=
00000
[   14.428133] R10: 0000000000000001 R11: 0000000000000100 R12: ffff965ac0d=
da000
[   14.428133] R13: ffff965a84746900 R14: ffff965a8208ca05 R15: ffff965ac0d=
da6d0
[   14.428134] FS:  0000000000000000(0000) GS:ffff9661bf400000(0000) knlGS:=
0000000000000000
[   14.428135] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.428136] CR2: 0000000000000070 CR3: 00000002bb620000 CR4: 0000000000f=
50ef0
[   14.428137] PKRU: 55555554
[   14.428137] note: kworker/u41:0[198] exited with irqs disabled
[   16.434794] Bluetooth: hci0: command 0xfc09 tx timeout


Thanks for any suggestions and best regards
(and please Cc)

Norbert

--
PREINING Norbert                              https://www.preining.info
arXiv / Cornell University   +   IFMGA Guide   +   TU Wien  +  TeX Live
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13

