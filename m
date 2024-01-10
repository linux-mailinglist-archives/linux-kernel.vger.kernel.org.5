Return-Path: <linux-kernel+bounces-22855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E168882A404
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557C81F23A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908214CDE7;
	Wed, 10 Jan 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaWc4I34"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7914D13F;
	Wed, 10 Jan 2024 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so5219863e87.0;
        Wed, 10 Jan 2024 14:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704926103; x=1705530903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMJuS9c4zXqLw3hPK375p+mzMip1QBopb/rPnG9PM7M=;
        b=IaWc4I346ZU4DBM2yAf8s9pBuJDxKx1qN7J1lEi+H8rWu7XigCCpedogXAlteT1mwr
         ge56Ror4OZvhqyv8Xlmz9XfSJRXrzWmCYO29j4HR35Z+t0XDA6IDoVWvyLvwbCyAr+sQ
         4yGigOD4XzTZdI1geyNbjKB0j7VwB8DiFPNDyLbnPwaVcn9VAgP0Elww14fkk+Wl9UyF
         vlwzLPY1/F7xc0etw9loq5KeEXp0l3xlZ2TjLFVQa5mX0cN9XaK3MgaA2hMcsVeW+xC+
         XfDkoGAqsg3ugARZUM2FAaYmJRIq7gsnJm55t5RdDuh2tKV/0Jl/ivOhzBamEs/nQNxU
         rhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704926103; x=1705530903;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xMJuS9c4zXqLw3hPK375p+mzMip1QBopb/rPnG9PM7M=;
        b=k0Hw+VglSFShvBLBhCBUR170sQko56pw5YLMS5EbtWk/S03oHa0nANxs34t7wS7Tsm
         DZcSxZtUY/lqsw0zXVaeUnqYWeoTHD49VVQdtX7uwJ3Hw+cewsK6RkT7dVVDbnPYJWwJ
         csPnUkY5xnZdkP03fuWOdYm4PEQQUfgQXNLfhXLh7H/YGoKA5LAITkhKszm6AM9uj9NJ
         a4qFqXuH94OnMc1aHIhCuTIqogXWF3UP3kKqS5efLe3+qlKzh6L4gEpjCgregKZd8NcX
         dHvA9nYdPW6zqlxHKvk4huUW+p+Yq765SueI9HLFtaroL/KMEly6fdlQIUFJilkQXKzs
         dnmA==
X-Gm-Message-State: AOJu0YzdIs0i6pnhI07eEe/eciKsSAUFx2OUjYxx76GPNea7onbdAGLQ
	5Cuv+bE5NTwC7zZOaem2f+g=
X-Google-Smtp-Source: AGHT+IGdsEQX633VgA0HGT7grJNyNSoSt6lUy0v/kbxjod+TMRFn6ILwsX0sAWTxHk/LOVX5YhVl+w==
X-Received: by 2002:a05:6512:34cc:b0:50e:b46f:4378 with SMTP id w12-20020a05651234cc00b0050eb46f4378mr55840lfr.14.1704926103013;
        Wed, 10 Jan 2024 14:35:03 -0800 (PST)
Received: from [192.168.1.99] ([151.95.98.96])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709060d9200b00a26aea4942dsm2451347eji.123.2024.01.10.14.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 14:35:02 -0800 (PST)
Message-ID: <31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com>
Date: Wed, 10 Jan 2024 23:35:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Denis Benato <benato.denis96@gmail.com>
Subject: iio: iio-trig-hrtimer bug on suspend/resume when used with bmi160 and
 bmi323
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jagath Jog J <jagathjog1996@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Language: en-US, en-US-large
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

With this mail I am submitting bug report that is probably related to iio=
-trig-hrtimer but there is also the possibility for it to be specific to =
bmi160 and bmi323.

The described problem have been reproduced on my handheld PC (Asus RC71L)=
 and in another handheld PC with two different gyroscope drivers: bmi323 =
(backported by me on v6.7, on RC71L) and bmi160.

My target hardware (RC71L that yeld to this discovery) has a bmi323 chip =
that does not have any interrupt pins reaching the CPU, yet I need to fet=
ch periodically data from said device, therefore I used iio-trig-hrtimer:=
 created a trigger, set the device and trigger sampling frequencies, boun=
d the trigger to the device and enabled buffer: data is being read and av=
ailable over /dev/iio:device0.

While in this state if I suspend my handheld I receive (from dmesg) the w=
arning reported below and at resume data is not coming out of the iio dev=
ice and the hrtimer appears to not be working. If I create a new trigger =
and bind the new trigger to said iio device and re-enable buffer data doe=
s come out of /dev/iio:device0 once more, until the next sleep.

Since this is important to me I have taken the time to look at both drive=
rs and iio-trig-hrtimer and I have identified three possible reasons:

1) iio-trig-hrtimer won't work after suspend regardless of how it is used=
 (this is what I believe is the cause)
2) iio-trig-hrtimer is stopped by the -ESHTDOWN returned by the function =
printing "Transfer while suspended", however that stack trace does not in=
clude function calls related to iio-trig-hrtimer and this seems less plau=
sible
3) bmi160 and bmi323 appears to be similar and maybe are sharing a common=
 bug with suspend (this is also why I have maintainers of those drivers i=
n the recipient list)

Thanks for your time, patience and understanding,
Denis Benato


This one is from my device:
[  635.956648] ------------[ cut here ]------------
[  635.956649] i2c i2c-1: Transfer while suspended
[  635.956663] WARNING: CPU: 9 PID: 848 at __i2c_transfer+0xaf/0x6e0
[  635.956670] Modules linked in: ccm rfcomm ntfs3 snd_seq_dummy snd_hrti=
mer snd_seq cmac algif_hash algif_skcipher af_alg bnep iio_trig_hrtimer i=
io_trig_sysfs hid_playstation led_class_multicolor industrialio_sw_trigge=
r uhid industrialio_configfs snd_sof_amd_acp63 snd_sof_amd_rembrandt mt79=
21e snd_sof_amd_renoir mt7921_common snd_sof_amd_acp snd_usb_audio hid_lo=
gitech_hidpp snd_sof_xtensa_dsp mt792x_lib snd_sof_pci r8153_ecm mt76_con=
nac_lib cdc_ether snd_ump snd_sof snd_usbmidi_lib mt76 usbnet snd_rawmidi=
 snd_hda_codec_realtek snd_sof_utils snd_seq_device snd_hda_scodec_cs35l4=
1_spi mc snd_hda_codec_generic intel_rapl_msr mac80211 hid_multitouch snd=
_hda_codec_hdmi snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_=
pci_ps intel_rapl_common snd_hda_intel edac_mce_amd snd_intel_dspcfg snd_=
rpl_pci_acp6x snd_acp_pci snd_hda_codec snd_acp_legacy_common kvm_amd snd=
_hda_core snd_pci_acp6x snd_pci_acp5x snd_hwdep btusb snd_rn_pci_acp3x sn=
d_hda_scodec_cs35l41_i2c snd_acp_config btrtl snd_pcm snd_hda_scodec_cs35=
l41 bmi323_i2c
[  635.956705]  btmtk btbcm bmi323_core kvm snd_hda_cs_dsp_ctls cfg80211 =
btintel snd_soc_acpi snd_timer uas ucsi_acpi cs_dsp xpad industrialio_tri=
ggered_buffer irqbypass crct10dif_pclmul polyval_clmulni polyval_generic =
bluetooth r8152 joydev ghash_clmulni_intel snd_soc_cs35l41_lib ecdh_gener=
ic sha1_ssse3 rapl ecc usb_storage mii pcspkr asus_nb_wmi wmi_bmof efi_ps=
tore typec_ucsi kfifo_buf k10temp i2c_piix4 snd ff_memless snd_pci_acp3x =
nls_iso8859_1 libarc4 soundcore ccp typec hid_logitech_dj usbmouse usbkbd=
 i2c_hid_acpi i2c_hid industrialio amd_pmc serial_multi_instantiate input=
_leds mac_hid sch_fq_codel crypto_user nfnetlink dmi_sysfs ip_tables x_ta=
bles autofs4 hid_asus asus_wmi ledtrig_audio sparse_keymap platform_profi=
le hid_generic usbhid hid btrfs mmc_block amdgpu drm_buddy drm_suballoc_h=
elper raid6_pq xor libcrc32c drm_exec i2c_algo_bit drm_display_helper cec=
 gpu_sched amdxcp drm_ttm_helper ttm drm_kms_helper video crc32_pclmul sh=
a512_ssse3 drm sha256_ssse3 nvme sdhci_pci nvme_core cqhci serio_raw xhci=
_pci sdhci
[  635.956752]  xhci_pci_renesas wmi overlay aesni_intel crypto_simd cryp=
td
[  635.956755] CPU: 9 PID: 848 Comm: irq/90-bmi323-i Tainted: G        W =
         6.7.0--xanmod1-neroreflex-1 #1
[  635.956758] Hardware name: ASUSTeK COMPUTER INC. ROG Ally RC71L_RC71L/=
RC71L, BIOS RC71L.335 11/29/2023
[  635.956759] RIP: 0010:__i2c_transfer+0xaf/0x6e0
[  635.956761] Code: 00 00 48 85 c0 0f 84 2a 06 00 00 48 8b 30 48 8b 93 c=
0 00 00 00 48 85 d2 75 04 48 8b 53 70 48 c7 c7 9a 5e aa 99 e8 31 57 3e ff=
 <0f> 0b e9 2e 04 00 00 ba 02 00 00 00 41 83 ff 02 0f 85 dd 01 00 00
[  635.956763] RSP: 0018:ffffbf33c160bbf8 EFLAGS: 00010246
[  635.956764] RAX: 41e9eaf9bb59b300 RBX: ffff9f8f013a28e8 RCX: 000000000=
0000027
[  635.956765] RDX: ffffffff9a235ab8 RSI: 0000000000000002 RDI: ffff9f915=
2261888
[  635.956766] RBP: 00000000ffffff94 R08: 80000000ffffe5fd R09: 656c69687=
7207265
[  635.956767] R10: 0000000000000023 R11: 0a6465646e657073 R12: 000000000=
0000000
[  635.956768] R13: 0000000000000003 R14: ffffbf33c160bc50 R15: 000000000=
0000002
[  635.956769] FS:  0000000000000000(0000) GS:ffff9f9152240000(0000) knlG=
S:0000000000000000
[  635.956770] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  635.956771] CR2: 0000020b0a053000 CR3: 000000028ae10000 CR4: 000000000=
0750ef0
[  635.956773] PKRU: 55555554
[  635.956773] Call Trace:
[  635.956775]  <TASK>
[  635.956777]  ? __warn+0x13c/0x1f0
[  635.956779]  ? __i2c_transfer+0xaf/0x6e0
[  635.956781]  ? report_bug+0x16e/0x1f0
[  635.956784]  ? handle_bug+0x42/0x70
[  635.956786]  ? exc_invalid_op+0x16/0x50
[  635.956788]  ? asm_exc_invalid_op+0x16/0x20
[  635.956791]  ? __i2c_transfer+0xaf/0x6e0
[  635.956793]  ? __i2c_transfer+0xaf/0x6e0
[  635.956794]  i2c_transfer+0xe3/0x110
[  635.956798]  bmi323_regmap_i2c_read+0x7b/0xc0 [bmi323_i2c]
[  635.956803]  _regmap_raw_read+0x11d/0x200
[  635.956806]  regmap_raw_read+0x26a/0x2c0
[  635.956807]  ? __schedule+0x604/0x16b0
[  635.956810]  regmap_bulk_read+0x17b/0x200
[  635.956813]  ? iio_store_to_kfifo+0x11/0x30 [kfifo_buf]
[  635.956818]  bmi323_trigger_handler+0x52/0x160 [bmi323_core]
[  635.956824]  irq_thread_fn+0x18/0x50
[  635.956826]  irq_thread+0x21a/0x3c0
[  635.956828]  ? wake_up_and_wait_for_irq_thread_ready+0x190/0x190
[  635.956830]  ? irq_forced_thread_fn+0x110/0x110
[  635.956831]  kthread+0x26c/0x2b0
[  635.956833]  ? irq_forced_secondary_handler+0x20/0x20
[  635.956835]  ? kthreadd+0x300/0x300
[  635.956836]  ret_from_fork+0x2e/0x40
[  635.956838]  ? kthreadd+0x300/0x300
[  635.956839]  ret_from_fork_asm+0x11/0x20
[  635.956841]  </TASK>
[  635.956842] ---[ end trace 0000000000000000 ]---

The following is from the other device (amd 5600u):
[   67.131064] ------------[ cut here ]------------
[   67.131067] i2c i2c-1: Transfer while suspended
[   67.131078] WARNING: CPU: 1 PID: 1655 at drivers/i2c/i2c-core.h:54 __i=
2c_transfer+0x594/0x6b0
[   67.131090] Modules linked in: iio_trig_hrtimer iio_trig_sysfs industr=
ialio_sw_trigger industrialio_configfs ccm rfcomm cmac algif_hash algif_s=
kcipher af_alg snd_seq_dummy snd_hrtimer snd_seq snd_seq_device exfat bne=
p wl(POE) intel_rapl_msr zenergy(OE) intel_rapl_common mousedev joydev sn=
d_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci mt7921=
e snd_sof_xtensa_dsp mt7921_common snd_hda_codec_realtek snd_sof mt792x_l=
ib snd_hda_codec_generic snd_sof_utils mt76_connac_lib cdc_mbim cdc_wdm e=
dac_mce_amd ledtrig_audio snd_hda_codec_hdmi snd_soc_core mt76 kvm_amd sn=
d_hda_intel snd_compress snd_intel_dspcfg ac97_bus mac80211 snd_pcm_dmaen=
gine
[   67.131146] ACPI Error:=20
[   67.131147]  snd_intel_sdw_acpi kvm btusb snd_pci_ps
[   67.131151] No handler for Region [ECRM] (00000000b2bf81c9) [EmbeddedC=
ontrol]
[   67.131152]  btrtl snd_hda_codec
[   67.131155]  (20230628/evregion-130)
[   67.131155]  snd_rpl_pci_acp6x libarc4 snd_acp_pci
[   67.131158] ACPI Error:=20
[   67.131159]  irqbypass
[   67.131161] Region EmbeddedControl (ID=3D3) has no handler
[   67.131165]  btintel
[   67.131166]  (20230628/exfldio-261)
[   67.131169]  snd_hda_core snd_acp_legacy_common btbcm crct10dif_pclmul=

[   67.131176] ACPI Error:=20
[   67.131176]  bmi160_spi
[   67.131178] Aborting method=20
[   67.131178]  snd_pci_acp6x
[   67.131180] \_SB.GPIO._EVT
[   67.131180]  snd_hwdep
[   67.131182]  due to previous error (AE_NOT_EXIST)
[   67.131182]  btmtk
[   67.131183]  (20230628/psparse-529)
[   67.131183]  polyval_clmulni cfg80211 snd_pcm polyval_generic snd_pci_=
acp5x gf128mul cdc_ncm snd_timer snd_rn_pci_acp3x bluetooth hid_multitouc=
h ghash_clmulni_intel cdc_ether bmi160_i2c snd_acp_config snd usbnet sha1=
_ssse3 vfat bmi160_core snd_soc_acpi oxp_sensors fat rapl ecdh_generic wm=
i_bmof industrialio_triggered_buffer mii pcspkr rfkill k10temp i2c_piix4 =
snd_pci_acp3x soundcore ccp kfifo_buf i2c_hid_acpi soc_button_array i2c_h=
id industrialio mac_hid xpad ff_memless uinput ec_sys crypto_user fuse lo=
op nfnetlink ip_tables x_tables uas usbhid usb_storage amdgpu btrfs drm_e=
xec blake2b_generic amdxcp xor drm_buddy raid6_pq gpu_sched libcrc32c crc=
32_pclmul i2c_algo_bit sha512_ssse3 drm_suballoc_helper serio_raw sha256_=
ssse3 drm_ttm_helper atkbd aesni_intel libps2 ttm nvme vivaldi_fmap crypt=
o_simd drm_display_helper nvme_core cryptd video i8042 cec nvme_common wm=
i serio overlay ext4 crc32c_generic crc32c_intel crc16 mbcache jbd2 dm_mo=
d
[   67.131318] CPU: 1 PID: 1655 Comm: irq/70-i2c-BMI0 Tainted: P         =
  OE      6.6.7-chos5-chimeraos-1 #1 011c184bc075678bbf5f825a76fa2f067418=
39b6
[   67.131324] Hardware name: ONE-NETBOOK TECHNOLOGY CO., LTD. ONE XPLAYE=
R/ONE XPLAYER, BIOS V1.08_P4C8M43L6 04/28/2022
[   67.131327] RIP: 0010:__i2c_transfer+0x594/0x6b0
[   67.131334] Code: 8b af c0 00 00 00 48 85 ed 75 04 48 8b 6f 70 48 8d 7=
b 70 e8 ae 92 ea ff 48 89 ea 48 c7 c7 c8 f0 ed 82 48 89 c6 e8 2c e7 63 ff=
 <0f> 0b bd 94 ff ff ff e9 fc fb ff ff 48 c7 c6 50 95 9e 82 48 c7 c7
[   67.131336] RSP: 0018:ffffc90012623cb0 EFLAGS: 00010286
[   67.131339] RAX: 0000000000000000 RBX: ffff8881017c68e8 RCX: 000000000=
0000027
[   67.131342] RDX: ffff888360e616c8 RSI: 0000000000000001 RDI: ffff88836=
0e616c0
[   67.131344] RBP: ffff888100e0de38 R08: ffffffff83756c80 R09: 000000008=
407cebb
[   67.131345] R10: ffffffffffffffff R11: 0000000000000100 R12: 000000000=
0000002
[   67.131347] R13: ffff888110836c00 R14: 0000000000000000 R15: ffff88811=
0836c00
[   67.131348] FS:  0000000000000000(0000) GS:ffff888360e40000(0000) knlG=
S:0000000000000000
[   67.131351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.131352] CR2: 0000000000000000 CR3: 000000024ec20000 CR4: 000000000=
0750ee0
[   67.131354] PKRU: 55555554
[   67.131356] Call Trace:
[   67.131358]  <TASK>
[   67.131359]  ? __i2c_transfer+0x594/0x6b0
[   67.131363]  ? __warn+0x81/0x130
[   67.131373]  ? __i2c_transfer+0x594/0x6b0
[   67.131377]  ? report_bug+0x171/0x1a0
[   67.131382]  ? srso_alias_return_thunk+0x5/0x7f
[   67.131387]  ? console_unlock+0xcb/0x120
[   67.131394]  ? handle_bug+0x3c/0x80
[   67.131399]  ? exc_invalid_op+0x17/0x70
[   67.131402]  ? asm_exc_invalid_op+0x1a/0x20
[   67.131411]  ? __i2c_transfer+0x594/0x6b0
[   67.131417]  i2c_transfer+0x4f/0x100
[   67.131421]  regmap_i2c_read+0x73/0xb0
[   67.131428]  _regmap_raw_read+0xe6/0x230
[   67.131434]  regmap_raw_read+0x25c/0x2c0
[   67.131440]  regmap_bulk_read+0x1e4/0x290
[   67.131448]  bmi160_trigger_handler+0x56/0x100 [bmi160_core 01d2f0c9a6=
f31373f2aa6b38a031d29ec6d3cd40]
[   67.131457]  ? __pfx_irq_thread_fn+0x10/0x10
[   67.131461]  irq_thread_fn+0x23/0x60
[   67.131466]  irq_thread+0xfe/0x1c0
[   67.131470]  ? __pfx_irq_thread_dtor+0x10/0x10
[   67.131475]  ? __pfx_irq_thread+0x10/0x10
[   67.131478]  kthread+0xe8/0x120
[   67.131484]  ? __pfx_kthread+0x10/0x10
[   67.131488]  ret_from_fork+0x34/0x50
[   67.131493]  ? __pfx_kthread+0x10/0x10
[   67.131496]  ret_from_fork_asm+0x1b/0x30
[   67.131506]  </TASK>
[   67.131507] ---[ end trace 0000000000000000 ]---

For reference I place here the bash file that is used to reproduce the is=
sue:
#!/bin/bash
modprobe industrialio-sw-trigger
modprobe iio-trig-sysfs
modprobe iio-trig-hrtimer

# hrtimer
if [ ! -d "/home/config" ]; then
    mkdir -p /home/config
fi

mount -t configfs none /home/config
mkdir -p /home/config/iio/triggers/hrtimer/rogue

# set sampling frequency for rogue
for i in /sys/bus/iio/devices/* ; do
  if [ -d "$i" ]; then
    if [ -f "$i/name" ]; then
      name=3D$(cat "$i/name")
      if [ "$name" =3D "rogue" ]; then
        echo "1600" > "$i/sampling_frequency"
      fi
    fi
  fi
done

# set the gyroscope
for i in /sys/bus/iio/devices/* ; do
  if [ -d "$i" ]; then
    if [ -f "$i/name" ]; then
      name=3D$(cat "$i/name")
      if [ "$name" =3D "bmi323-imu" ]; then

        # change chip sampling frequency
        echo "1600.000000" > "$i/in_accel_sampling_frequency"
        echo "1600.000000" > "$i/in_anglvel_sampling_frequency"

        # enable accel data acquisition
        echo 1 > "$i/scan_elements/in_accel_x_en"
        echo 1 > "$i/scan_elements/in_accel_y_en"
        echo 1 > "$i/scan_elements/in_accel_z_en"

        # enable gyroscope data acquisition
        echo 1 > "$i/scan_elements/in_anglvel_x_en"
        echo 1 > "$i/scan_elements/in_anglvel_y_en"
        echo 1 > "$i/scan_elements/in_anglvel_z_en"

        # enable timestamp reporting
        echo 1 > "$i/scan_elements/in_timestamp_en"

        # bind rogue hrtimer to to the iio device
        echo "rogue" > "$i/trigger/current_trigger"

        # enable the buffer
        echo 1 > "$i/buffer0/enable"

        echo "bmi323-imu buffer started"
      fi
    fi
  fi
done

