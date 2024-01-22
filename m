Return-Path: <linux-kernel+bounces-33772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9561A836E61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452AC286E91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3253F8F5;
	Mon, 22 Jan 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJAzeDtW"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF43F8D3;
	Mon, 22 Jan 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944034; cv=none; b=pjN3X3OX1C81gaJMnAPHB+LB2hRhGgMx+h9feHyHqxscpznI1tXYYEWa7HsP4iW40eQ4R7s8B8Jou1eaLCaiHPwqPXrp+byTpdTcO1GMD8G4Evv12uCXFZPB3hrz+c8XFvAzPNshK2eX2RQI4jS/5k+BiHFDcA79mis0HJsq8nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944034; c=relaxed/simple;
	bh=XSWUtpmkS3MJVxN3YP3G4RlNgipjGYbafOZlwDKlMAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApxO2bJM/mpJvCsG11T2XJ3fFIU6sMgIml6YbrEFfF++kBk4mz4120qvfWakY3J5a6C4SF6mqWagK2kDNY2zA6Qc7/YSKZb8NukRcHejmRf8z0LAtnkFGW1x5XC5YmRBo860a7sLSGlWz3NqQnNSucufN33hafvW0OPu/PM+zjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJAzeDtW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50edf4f478eso4389063e87.3;
        Mon, 22 Jan 2024 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705944031; x=1706548831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiQFTf5/J7i1f8VPBFGNtA57fkQqmzHvl57qIMKO7yI=;
        b=JJAzeDtWwkC5B0Phhy3WpM4wFNhslqsvz9SNECrvO7jLtVZcd82H8t6qmCW8s1OdAX
         iL528UQlYMvIc8xfD3irapWnr9u8hwf5PUfFIeRIhyFjLAS2+prj6Zu2zZwgE3RIIvh0
         d+zKLZb9/3utKVIcW8/6UCwnIg+UKDD/vWUzPZLKO8RUrFOvmtGMwu0Cnk/6x1noVtlk
         SHkJcaxFxrsSw63BFAHxnOCFDE8ooHy+q/ByEuqI43ShsM2vx4AKzA38wMpUl//SKo+X
         SS92dK7fx/69q+LA38Oko1F9S/gegTLRluR+9jb6HVox2o+6PE3Rz78B/s4MKOqEm1on
         iQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944031; x=1706548831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiQFTf5/J7i1f8VPBFGNtA57fkQqmzHvl57qIMKO7yI=;
        b=kbrLMNNNtBEW09TzMIy2MACNYRlNDtU/+zP2RgmDB/PvL/iqgcbxuDL9mdi1fIk088
         lm0qmI6hD6ZjTv4I4uQQrqwA1iA1cEY+ilqnDPIMCf65YiOi82Jb5OYHDzITuXgVS1MZ
         Rm/S2wKKP1geGQkKDznxcnj0AG/dlNMpJZvnvlGw56KQSjGQWG4cp5F2qw2y90sx74pv
         +mggRP4BJFw6b1J5qTUOzB9XUKIWjr90IwG3lOcE9psvpjiJAxuTti6ONYH5vrYQ5yH0
         epLrja6xejyDYoCFY/yfPG8hx4eKyKNu8gaSKaB/wCDNXh+LB1biihJt/fmNL7eSxVup
         QOgA==
X-Gm-Message-State: AOJu0YxZuazPXAs802IMqjz3+ryegTsqGIORiLqKNLdQdjGwHGkahW8V
	U+lQOznC1nA1Dv4aZgVm2YYL2odZGe8Lxwd9eJ+JWOrWu+CczNav3C/yocqTX6+nRDZ+2N8cPVK
	NnQNOJsb6d1kaB5LifD3DAdC73O8lX0FEWC0=
X-Google-Smtp-Source: AGHT+IE+hyM4smX0AQ73kpNqDwJKbGXedJ1x9gm4UHmSMlSyIrEx2EfLrxQM84nwUstKhWo8rj2AdIzKr1ysRdR/dGY=
X-Received: by 2002:a05:6512:3b2c:b0:50e:a789:dd3b with SMTP id
 f44-20020a0565123b2c00b0050ea789dd3bmr2320705lfv.1.1705944030418; Mon, 22 Jan
 2024 09:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com>
In-Reply-To: <31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com>
From: Jagath Jog J <jagathjog1996@gmail.com>
Date: Mon, 22 Jan 2024 22:50:18 +0530
Message-ID: <CAM+2Eu+AqBDEufSt+Q7EURxdF0ra2aBg8wRB2QjmnKGS=93Xvw@mail.gmail.com>
Subject: Re: iio: iio-trig-hrtimer bug on suspend/resume when used with bmi160
 and bmi323
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Denis and Jonathan

Thank you for testing the driver, and I apologize for the delayed response.

During the development of the BMI323 driver, I used an ARM-based
Raspberry Pi for testing. I tested the triggers with interrupt, sysfs, and =
HRT.
However, I haven't tested the HRT triggers with power-saving modes. Current=
ly,
I'm trying to reproduce the issue by continuously reading the sensor, simil=
ar
to your approach, and putting my board into suspend-to-ram mode.
Unfortunately, my board doesn't support low-power modes, resulting in a
continuous data output from the sensor and the following error related to
suspend mode. I plan to acquire another board that supports these
low-power modes soon and will work on resolving this issue.

$ echo mem > /sys/power/state

<6>[ 5636.810797] PM: suspend entry (s2idle)
<6>[ 5636.840781] Filesystems sync: 0.029 seconds
<6>[ 5636.923133] Freezing user space processes completed (elapsed
0.002 seconds)
<6>[ 5636.923156] OOM killer disabled.
<6>[ 5636.923162] Freezing remaining freezable tasks
<6>[ 5636.924689] Freezing remaining freezable tasks completed
(elapsed 0.001 seconds)
<6>[ 5636.924700] printk: Suspending console(s) (use
no_console_suspend to debug)
<4>[ 5636.969691]
<4>[ 5636.969703] WARN::dwc_otg_hcd_urb_dequeue:639: Timed out waiting
for FSM NP transfer to complete on 6
<3>[ 5637.962420] brcmfmac: brcmf_sdio_dpc: failed backplane access
over SDIO, halting operation
<3>[ 5637.962433] ieee80211 phy21: brcmf_cfg80211_reg_notifier:
Country code iovar returned err =3D -5
<3>[ 5637.962528] ieee80211 phy21: brcmf_proto_bcdc_query_dcmd:
brcmf_proto_bcdc_msg failed w/status -5
<3>[ 5637.962536] ieee80211 phy21: brcmf_cfg80211_reg_notifier:
Country code iovar returned err =3D -5
<3>[ 5637.962563] ieee80211 phy21: brcmf_fil_cmd_data: bus is down. we
have nothing to do.
<3>[ 5637.962571] ieee80211 phy21: brcmf_cfg80211_get_tx_power: error (-5)
<7>[ 5638.518728] brcmfmac_wcc: brcmf_wcc_detach: executing
<3>[ 5638.561147] usb usb1: PM: dpm_run_callback():
usb_dev_suspend+0x0/0x10 returns -2
<3>[ 5638.561179] usb usb1: PM: failed to suspend async: error -2
<3>[ 5638.561194] PM: Some devices failed to suspend, or early wake
event detected
<7>[ 5638.661065] brcmfmac: F1 signature read @0x18000000=3D0x15264345
<6>[ 5638.665324] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
<4>[ 5638.665413] brcmfmac mmc1:0001:1: Direct firmware load for
brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with
error -2
<6>[ 5638.709079] lan78xx 1-1.1.1:1.0 eth0: Link is Down
<7>[ 5638.841128] brcmfmac_wcc: brcmf_wcc_attach: executing
<6>[ 5638.848752] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=3D-2)
<6>[ 5638.849206] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID
01-2dbd9d2e
<6>[ 5638.859102] OOM killer enabled.
<6>[ 5638.862718] PM: suspend entry (s2idle)
<6>[ 5638.980447] Filesystems sync: 0.117 seconds
<6>[ 5639.479450] Restarting tasks ... done.
<5>[ 5639.481816] random: crng reseeded on system resumption
<6>[ 5639.481967] PM: suspend exit


Regards
Jagath

Jagath

On Thu, Jan 11, 2024 at 4:05=E2=80=AFAM Denis Benato <benato.denis96@gmail.=
com> wrote:
>
> Hello,
>
> With this mail I am submitting bug report that is probably related to iio=
-trig-hrtimer but there is also the possibility for it to be specific to bm=
i160 and bmi323.
>
> The described problem have been reproduced on my handheld PC (Asus RC71L)=
 and in another handheld PC with two different gyroscope drivers: bmi323 (b=
ackported by me on v6.7, on RC71L) and bmi160.
>
> My target hardware (RC71L that yeld to this discovery) has a bmi323 chip =
that does not have any interrupt pins reaching the CPU, yet I need to fetch=
 periodically data from said device, therefore I used iio-trig-hrtimer: cre=
ated a trigger, set the device and trigger sampling frequencies, bound the =
trigger to the device and enabled buffer: data is being read and available =
over /dev/iio:device0.
>
> While in this state if I suspend my handheld I receive (from dmesg) the w=
arning reported below and at resume data is not coming out of the iio devic=
e and the hrtimer appears to not be working. If I create a new trigger and =
bind the new trigger to said iio device and re-enable buffer data does come=
 out of /dev/iio:device0 once more, until the next sleep.
>
> Since this is important to me I have taken the time to look at both drive=
rs and iio-trig-hrtimer and I have identified three possible reasons:
>
> 1) iio-trig-hrtimer won't work after suspend regardless of how it is used=
 (this is what I believe is the cause)
> 2) iio-trig-hrtimer is stopped by the -ESHTDOWN returned by the function =
printing "Transfer while suspended", however that stack trace does not incl=
ude function calls related to iio-trig-hrtimer and this seems less plausibl=
e
> 3) bmi160 and bmi323 appears to be similar and maybe are sharing a common=
 bug with suspend (this is also why I have maintainers of those drivers in =
the recipient list)
>
> Thanks for your time, patience and understanding,
> Denis Benato
>
>
> This one is from my device:
> [  635.956648] ------------[ cut here ]------------
> [  635.956649] i2c i2c-1: Transfer while suspended
> [  635.956663] WARNING: CPU: 9 PID: 848 at __i2c_transfer+0xaf/0x6e0
> [  635.956670] Modules linked in: ccm rfcomm ntfs3 snd_seq_dummy snd_hrti=
mer snd_seq cmac algif_hash algif_skcipher af_alg bnep iio_trig_hrtimer iio=
_trig_sysfs hid_playstation led_class_multicolor industrialio_sw_trigger uh=
id industrialio_configfs snd_sof_amd_acp63 snd_sof_amd_rembrandt mt7921e sn=
d_sof_amd_renoir mt7921_common snd_sof_amd_acp snd_usb_audio hid_logitech_h=
idpp snd_sof_xtensa_dsp mt792x_lib snd_sof_pci r8153_ecm mt76_connac_lib cd=
c_ether snd_ump snd_sof snd_usbmidi_lib mt76 usbnet snd_rawmidi snd_hda_cod=
ec_realtek snd_sof_utils snd_seq_device snd_hda_scodec_cs35l41_spi mc snd_h=
da_codec_generic intel_rapl_msr mac80211 hid_multitouch snd_hda_codec_hdmi =
snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_pci_ps intel_rapl_=
common snd_hda_intel edac_mce_amd snd_intel_dspcfg snd_rpl_pci_acp6x snd_ac=
p_pci snd_hda_codec snd_acp_legacy_common kvm_amd snd_hda_core snd_pci_acp6=
x snd_pci_acp5x snd_hwdep btusb snd_rn_pci_acp3x snd_hda_scodec_cs35l41_i2c=
 snd_acp_config btrtl snd_pcm snd_hda_scodec_cs35l41 bmi323_i2c
> [  635.956705]  btmtk btbcm bmi323_core kvm snd_hda_cs_dsp_ctls cfg80211 =
btintel snd_soc_acpi snd_timer uas ucsi_acpi cs_dsp xpad industrialio_trigg=
ered_buffer irqbypass crct10dif_pclmul polyval_clmulni polyval_generic blue=
tooth r8152 joydev ghash_clmulni_intel snd_soc_cs35l41_lib ecdh_generic sha=
1_ssse3 rapl ecc usb_storage mii pcspkr asus_nb_wmi wmi_bmof efi_pstore typ=
ec_ucsi kfifo_buf k10temp i2c_piix4 snd ff_memless snd_pci_acp3x nls_iso885=
9_1 libarc4 soundcore ccp typec hid_logitech_dj usbmouse usbkbd i2c_hid_acp=
i i2c_hid industrialio amd_pmc serial_multi_instantiate input_leds mac_hid =
sch_fq_codel crypto_user nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid=
_asus asus_wmi ledtrig_audio sparse_keymap platform_profile hid_generic usb=
hid hid btrfs mmc_block amdgpu drm_buddy drm_suballoc_helper raid6_pq xor l=
ibcrc32c drm_exec i2c_algo_bit drm_display_helper cec gpu_sched amdxcp drm_=
ttm_helper ttm drm_kms_helper video crc32_pclmul sha512_ssse3 drm sha256_ss=
se3 nvme sdhci_pci nvme_core cqhci serio_raw xhci_pci sdhci
> [  635.956752]  xhci_pci_renesas wmi overlay aesni_intel crypto_simd cryp=
td
> [  635.956755] CPU: 9 PID: 848 Comm: irq/90-bmi323-i Tainted: G        W =
         6.7.0--xanmod1-neroreflex-1 #1
> [  635.956758] Hardware name: ASUSTeK COMPUTER INC. ROG Ally RC71L_RC71L/=
RC71L, BIOS RC71L.335 11/29/2023
> [  635.956759] RIP: 0010:__i2c_transfer+0xaf/0x6e0
> [  635.956761] Code: 00 00 48 85 c0 0f 84 2a 06 00 00 48 8b 30 48 8b 93 c=
0 00 00 00 48 85 d2 75 04 48 8b 53 70 48 c7 c7 9a 5e aa 99 e8 31 57 3e ff <=
0f> 0b e9 2e 04 00 00 ba 02 00 00 00 41 83 ff 02 0f 85 dd 01 00 00
> [  635.956763] RSP: 0018:ffffbf33c160bbf8 EFLAGS: 00010246
> [  635.956764] RAX: 41e9eaf9bb59b300 RBX: ffff9f8f013a28e8 RCX: 000000000=
0000027
> [  635.956765] RDX: ffffffff9a235ab8 RSI: 0000000000000002 RDI: ffff9f915=
2261888
> [  635.956766] RBP: 00000000ffffff94 R08: 80000000ffffe5fd R09: 656c69687=
7207265
> [  635.956767] R10: 0000000000000023 R11: 0a6465646e657073 R12: 000000000=
0000000
> [  635.956768] R13: 0000000000000003 R14: ffffbf33c160bc50 R15: 000000000=
0000002
> [  635.956769] FS:  0000000000000000(0000) GS:ffff9f9152240000(0000) knlG=
S:0000000000000000
> [  635.956770] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  635.956771] CR2: 0000020b0a053000 CR3: 000000028ae10000 CR4: 000000000=
0750ef0
> [  635.956773] PKRU: 55555554
> [  635.956773] Call Trace:
> [  635.956775]  <TASK>
> [  635.956777]  ? __warn+0x13c/0x1f0
> [  635.956779]  ? __i2c_transfer+0xaf/0x6e0
> [  635.956781]  ? report_bug+0x16e/0x1f0
> [  635.956784]  ? handle_bug+0x42/0x70
> [  635.956786]  ? exc_invalid_op+0x16/0x50
> [  635.956788]  ? asm_exc_invalid_op+0x16/0x20
> [  635.956791]  ? __i2c_transfer+0xaf/0x6e0
> [  635.956793]  ? __i2c_transfer+0xaf/0x6e0
> [  635.956794]  i2c_transfer+0xe3/0x110
> [  635.956798]  bmi323_regmap_i2c_read+0x7b/0xc0 [bmi323_i2c]
> [  635.956803]  _regmap_raw_read+0x11d/0x200
> [  635.956806]  regmap_raw_read+0x26a/0x2c0
> [  635.956807]  ? __schedule+0x604/0x16b0
> [  635.956810]  regmap_bulk_read+0x17b/0x200
> [  635.956813]  ? iio_store_to_kfifo+0x11/0x30 [kfifo_buf]
> [  635.956818]  bmi323_trigger_handler+0x52/0x160 [bmi323_core]
> [  635.956824]  irq_thread_fn+0x18/0x50
> [  635.956826]  irq_thread+0x21a/0x3c0
> [  635.956828]  ? wake_up_and_wait_for_irq_thread_ready+0x190/0x190
> [  635.956830]  ? irq_forced_thread_fn+0x110/0x110
> [  635.956831]  kthread+0x26c/0x2b0
> [  635.956833]  ? irq_forced_secondary_handler+0x20/0x20
> [  635.956835]  ? kthreadd+0x300/0x300
> [  635.956836]  ret_from_fork+0x2e/0x40
> [  635.956838]  ? kthreadd+0x300/0x300
> [  635.956839]  ret_from_fork_asm+0x11/0x20
> [  635.956841]  </TASK>
> [  635.956842] ---[ end trace 0000000000000000 ]---
>
> The following is from the other device (amd 5600u):
> [   67.131064] ------------[ cut here ]------------
> [   67.131067] i2c i2c-1: Transfer while suspended
> [   67.131078] WARNING: CPU: 1 PID: 1655 at drivers/i2c/i2c-core.h:54 __i=
2c_transfer+0x594/0x6b0
> [   67.131090] Modules linked in: iio_trig_hrtimer iio_trig_sysfs industr=
ialio_sw_trigger industrialio_configfs ccm rfcomm cmac algif_hash algif_skc=
ipher af_alg snd_seq_dummy snd_hrtimer snd_seq snd_seq_device exfat bnep wl=
(POE) intel_rapl_msr zenergy(OE) intel_rapl_common mousedev joydev snd_sof_=
amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci mt7921e snd_so=
f_xtensa_dsp mt7921_common snd_hda_codec_realtek snd_sof mt792x_lib snd_hda=
_codec_generic snd_sof_utils mt76_connac_lib cdc_mbim cdc_wdm edac_mce_amd =
ledtrig_audio snd_hda_codec_hdmi snd_soc_core mt76 kvm_amd snd_hda_intel sn=
d_compress snd_intel_dspcfg ac97_bus mac80211 snd_pcm_dmaengine
> [   67.131146] ACPI Error:
> [   67.131147]  snd_intel_sdw_acpi kvm btusb snd_pci_ps
> [   67.131151] No handler for Region [ECRM] (00000000b2bf81c9) [EmbeddedC=
ontrol]
> [   67.131152]  btrtl snd_hda_codec
> [   67.131155]  (20230628/evregion-130)
> [   67.131155]  snd_rpl_pci_acp6x libarc4 snd_acp_pci
> [   67.131158] ACPI Error:
> [   67.131159]  irqbypass
> [   67.131161] Region EmbeddedControl (ID=3D3) has no handler
> [   67.131165]  btintel
> [   67.131166]  (20230628/exfldio-261)
> [   67.131169]  snd_hda_core snd_acp_legacy_common btbcm crct10dif_pclmul
> [   67.131176] ACPI Error:
> [   67.131176]  bmi160_spi
> [   67.131178] Aborting method
> [   67.131178]  snd_pci_acp6x
> [   67.131180] \_SB.GPIO._EVT
> [   67.131180]  snd_hwdep
> [   67.131182]  due to previous error (AE_NOT_EXIST)
> [   67.131182]  btmtk
> [   67.131183]  (20230628/psparse-529)
> [   67.131183]  polyval_clmulni cfg80211 snd_pcm polyval_generic snd_pci_=
acp5x gf128mul cdc_ncm snd_timer snd_rn_pci_acp3x bluetooth hid_multitouch =
ghash_clmulni_intel cdc_ether bmi160_i2c snd_acp_config snd usbnet sha1_sss=
e3 vfat bmi160_core snd_soc_acpi oxp_sensors fat rapl ecdh_generic wmi_bmof=
 industrialio_triggered_buffer mii pcspkr rfkill k10temp i2c_piix4 snd_pci_=
acp3x soundcore ccp kfifo_buf i2c_hid_acpi soc_button_array i2c_hid industr=
ialio mac_hid xpad ff_memless uinput ec_sys crypto_user fuse loop nfnetlink=
 ip_tables x_tables uas usbhid usb_storage amdgpu btrfs drm_exec blake2b_ge=
neric amdxcp xor drm_buddy raid6_pq gpu_sched libcrc32c crc32_pclmul i2c_al=
go_bit sha512_ssse3 drm_suballoc_helper serio_raw sha256_ssse3 drm_ttm_help=
er atkbd aesni_intel libps2 ttm nvme vivaldi_fmap crypto_simd drm_display_h=
elper nvme_core cryptd video i8042 cec nvme_common wmi serio overlay ext4 c=
rc32c_generic crc32c_intel crc16 mbcache jbd2 dm_mod
> [   67.131318] CPU: 1 PID: 1655 Comm: irq/70-i2c-BMI0 Tainted: P         =
  OE      6.6.7-chos5-chimeraos-1 #1 011c184bc075678bbf5f825a76fa2f06741839=
b6
> [   67.131324] Hardware name: ONE-NETBOOK TECHNOLOGY CO., LTD. ONE XPLAYE=
R/ONE XPLAYER, BIOS V1.08_P4C8M43L6 04/28/2022
> [   67.131327] RIP: 0010:__i2c_transfer+0x594/0x6b0
> [   67.131334] Code: 8b af c0 00 00 00 48 85 ed 75 04 48 8b 6f 70 48 8d 7=
b 70 e8 ae 92 ea ff 48 89 ea 48 c7 c7 c8 f0 ed 82 48 89 c6 e8 2c e7 63 ff <=
0f> 0b bd 94 ff ff ff e9 fc fb ff ff 48 c7 c6 50 95 9e 82 48 c7 c7
> [   67.131336] RSP: 0018:ffffc90012623cb0 EFLAGS: 00010286
> [   67.131339] RAX: 0000000000000000 RBX: ffff8881017c68e8 RCX: 000000000=
0000027
> [   67.131342] RDX: ffff888360e616c8 RSI: 0000000000000001 RDI: ffff88836=
0e616c0
> [   67.131344] RBP: ffff888100e0de38 R08: ffffffff83756c80 R09: 000000008=
407cebb
> [   67.131345] R10: ffffffffffffffff R11: 0000000000000100 R12: 000000000=
0000002
> [   67.131347] R13: ffff888110836c00 R14: 0000000000000000 R15: ffff88811=
0836c00
> [   67.131348] FS:  0000000000000000(0000) GS:ffff888360e40000(0000) knlG=
S:0000000000000000
> [   67.131351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   67.131352] CR2: 0000000000000000 CR3: 000000024ec20000 CR4: 000000000=
0750ee0
> [   67.131354] PKRU: 55555554
> [   67.131356] Call Trace:
> [   67.131358]  <TASK>
> [   67.131359]  ? __i2c_transfer+0x594/0x6b0
> [   67.131363]  ? __warn+0x81/0x130
> [   67.131373]  ? __i2c_transfer+0x594/0x6b0
> [   67.131377]  ? report_bug+0x171/0x1a0
> [   67.131382]  ? srso_alias_return_thunk+0x5/0x7f
> [   67.131387]  ? console_unlock+0xcb/0x120
> [   67.131394]  ? handle_bug+0x3c/0x80
> [   67.131399]  ? exc_invalid_op+0x17/0x70
> [   67.131402]  ? asm_exc_invalid_op+0x1a/0x20
> [   67.131411]  ? __i2c_transfer+0x594/0x6b0
> [   67.131417]  i2c_transfer+0x4f/0x100
> [   67.131421]  regmap_i2c_read+0x73/0xb0
> [   67.131428]  _regmap_raw_read+0xe6/0x230
> [   67.131434]  regmap_raw_read+0x25c/0x2c0
> [   67.131440]  regmap_bulk_read+0x1e4/0x290
> [   67.131448]  bmi160_trigger_handler+0x56/0x100 [bmi160_core 01d2f0c9a6=
f31373f2aa6b38a031d29ec6d3cd40]
> [   67.131457]  ? __pfx_irq_thread_fn+0x10/0x10
> [   67.131461]  irq_thread_fn+0x23/0x60
> [   67.131466]  irq_thread+0xfe/0x1c0
> [   67.131470]  ? __pfx_irq_thread_dtor+0x10/0x10
> [   67.131475]  ? __pfx_irq_thread+0x10/0x10
> [   67.131478]  kthread+0xe8/0x120
> [   67.131484]  ? __pfx_kthread+0x10/0x10
> [   67.131488]  ret_from_fork+0x34/0x50
> [   67.131493]  ? __pfx_kthread+0x10/0x10
> [   67.131496]  ret_from_fork_asm+0x1b/0x30
> [   67.131506]  </TASK>
> [   67.131507] ---[ end trace 0000000000000000 ]---
>
> For reference I place here the bash file that is used to reproduce the is=
sue:
> #!/bin/bash
> modprobe industrialio-sw-trigger
> modprobe iio-trig-sysfs
> modprobe iio-trig-hrtimer
>
> # hrtimer
> if [ ! -d "/home/config" ]; then
>     mkdir -p /home/config
> fi
>
> mount -t configfs none /home/config
> mkdir -p /home/config/iio/triggers/hrtimer/rogue
>
> # set sampling frequency for rogue
> for i in /sys/bus/iio/devices/* ; do
>   if [ -d "$i" ]; then
>     if [ -f "$i/name" ]; then
>       name=3D$(cat "$i/name")
>       if [ "$name" =3D "rogue" ]; then
>         echo "1600" > "$i/sampling_frequency"
>       fi
>     fi
>   fi
> done
>
> # set the gyroscope
> for i in /sys/bus/iio/devices/* ; do
>   if [ -d "$i" ]; then
>     if [ -f "$i/name" ]; then
>       name=3D$(cat "$i/name")
>       if [ "$name" =3D "bmi323-imu" ]; then
>
>         # change chip sampling frequency
>         echo "1600.000000" > "$i/in_accel_sampling_frequency"
>         echo "1600.000000" > "$i/in_anglvel_sampling_frequency"
>
>         # enable accel data acquisition
>         echo 1 > "$i/scan_elements/in_accel_x_en"
>         echo 1 > "$i/scan_elements/in_accel_y_en"
>         echo 1 > "$i/scan_elements/in_accel_z_en"
>
>         # enable gyroscope data acquisition
>         echo 1 > "$i/scan_elements/in_anglvel_x_en"
>         echo 1 > "$i/scan_elements/in_anglvel_y_en"
>         echo 1 > "$i/scan_elements/in_anglvel_z_en"
>
>         # enable timestamp reporting
>         echo 1 > "$i/scan_elements/in_timestamp_en"
>
>         # bind rogue hrtimer to to the iio device
>         echo "rogue" > "$i/trigger/current_trigger"
>
>         # enable the buffer
>         echo 1 > "$i/buffer0/enable"
>
>         echo "bmi323-imu buffer started"
>       fi
>     fi
>   fi
> done

