Return-Path: <linux-kernel+bounces-90760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A087A870495
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080B0284716
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B824595D;
	Mon,  4 Mar 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EJDTnK+4"
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05E2575B;
	Mon,  4 Mar 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564111; cv=none; b=JVUZ8TyYxokrSZ5qnt14JULryn2kc1p0uILSpT4qmCUJLKftKvRfsaGL3HEnifEMr1B3ohoqQO3EYXc1NuQRYNzwDuFohnVsA9n1b31/ACTfDG0vXeXZRGdYVN0Fob9uMfASyCAS+sMbUqKN0EW4ULtEQNCs2qLg3vCnbUu8DPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564111; c=relaxed/simple;
	bh=HGRYat/eYh0ApDIx8gqaYEl+zI7gjLODOfog2KkltXo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZqIJIQm7p+CUBhG2Iq5EkIEEN1kaqEZouhX1CVqT71TRuc3sSij8LCAueSWV4DNNb2uljIuGBc5yyncyWAcxnSAD4jI4LDQNaTKlCHO9JM0/relrOj/6uHzxNmus7WlUhC/LvteBW5ZvF/Pyb16pDF/6ohBG92iEDenDn1cUki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EJDTnK+4; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ymkgoy2wybgp5j7m54jr3djjwu.protonmail; t=1709564100; x=1709823300;
	bh=TsLH6GcyhjeX4MK4+a8jnEr9/YUAROrq4aOMbggRhIA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EJDTnK+4D6IPCn5y9K8CH+lx/RkNkANm5Fzv4Q2HVF0r1VMcoawsoOtHlB3oQHckQ
	 9Mk+83KeXCLbGbRlSrpnpkW4iwHQXetIsbN8AXpTP4cLGzsOS+yYaMgvtrTHi77GZB
	 R3h0No+lnkYauxun4dL+QhHrBdGoz7mmTUudWBQCo7BidVst3J6Lwe7tqTG1N+bGtc
	 6xvbr6BuzF+bivuS89FbmP1ykQ/8okJZoLsVgDYFq2ucSF2RAuztsFP7N+oSDNJFN5
	 vLncYdL3IlDfagCUM8LticBXlJkjVDVxsV7kUo4imJB5SN+gMKyVu5erNe+ht6TIzt
	 nzHom0RGxlULw==
Date: Mon, 04 Mar 2024 14:54:40 +0000
To: o-takashi@sakamocchi.jp, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
From: "edmund.raile" <edmund.raile@proton.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] snd_fireface: frozen buffer with full system lockup
Message-ID: <bxximozxfc5y4wkakaygoca7hxbirb52slrx6ru3usa4zodvbc@vcsso26htq2n>
Feedback-ID: 45198251:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I want to report a bug with snd_fireface.

issue
audio suddenly freezes, repeating the last buffer to infinity

other symptoms
Most of the time, the GUI also freezes to a point that no interaction
is possible.
Not even a user console can be reached (ctrl + alt + F#).
The only way to get the system back in this scenario is to use REISUB
or power it down, I can not reach any console.
Luckily, sometimes the kernel messages at the bottom are written to
the logfile.

occurrence
This issue is triggered by more "stressful" circumstances, specifically
while using the Windows VST Kontakt in linux-native reaper through
yabridge (wine).
The timeframe is 5-20 minutes.
Reaper connects to the interface using ALSA, no other application is
playing audio.
My default sample rate is 96k, increasing buffer size to 512 samples
decreases CPU load but does not prevent this crash.

variables I tried to exclude

OS
Manjaro or fresh Artix install makes no difference

host application
the crash happens just as well with linux-native bitwig under similar
circumstances

wine variants
wine, wine-staging, wine-tkg w esync and fsync patches

The reason why I attribute both these issues to snd_firewire is that I
get no freezes / instabilities at all under these circumstances:
 * in Linux, using an usb audio interface or the onboard audio instead.
   To me, this suggests Wine, Reaper and Kontakt are not likely the
   culprit.
 * in Windows, using RME's dirver.
   To me, this suggests FW643 and my platform have no issue working
   together and the FireFace works as it should.
 * in Linux, passing the FW643 card through to a windows VM with
   vfio-pci.
   Here I am just booting the same physical drive in QEMU,
   so using the same RME driver.
   To me, this suggests there is no strange interaction between linux
   and FW643.

system
Interface: RME FireFace 800
FireWire controller: LSI FW643 rev 8
Platform: MSI ms7d25 Z690
Kernel: 6.8.0-rc5-1-mainline #8 SMP PREEMPT_DYNAMIC
OS: Artix Xfce
video driver: mesa

An related issue?
During normal use, as of recent kernel versions, just playing back audio
from any pulse audio application, I get a similar freeze but less severe:
no other applications are blocked and it can be removed by just stoping
playback, then after 5 seconds the audible freeze stops and I can start
playback again.
This happens less often, 5-60 minutes between freezes.
I managed to capture this unicorn event yesterday in a relatively short
file using 'sudo trace-cmd record -e snd_firewire_lib:amdtp_packet',
maybe it can give you a hint as to what may be going on:
https://pixeldrain.com/u/tgoSA1mk
I tried to do the same for my real issue (the one with the full system
freeze but I can not stop the recording and the output after rebooting
are files split by cpu cores.

I hope this is the right place to turn to for help.
It has prevented me from using my interface in linux for audio production
for a long time and I want to help fix it.
If I can provide any form of further assistance or somehow collect
any more data, please let me know.

Kind regards,
Edmund Raile.

watchdog: Watchdog detected hard LOCKUP on cpu 13
Modules linked in: ntfs3 fuse 8021q garp mrp stp llc bnep bluetooth ecdh_ge=
neric rfkill vfat fat snd_sof_pci_intel_tgl snd_sof_intel_hda_common soundw=
ire_intel snd_sof_intel_hda_mlink snd_hda_codec_hdmi soundwire_cadence snd_=
sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof intel_rapl_msr snd_sof=
_utils intel_rapl_common snd_soc_hdac_hda snd_hda_ext_core snd_soc_acpi_int=
el_match intel_uncore_frequency intel_uncore_frequency_common snd_soc_acpi =
intel_tcc_cooling soundwire_generic_allocation snd_hda_codec_realtek x86_pk=
g_temp_thermal soundwire_bus intel_powerclamp snd_hda_codec_generic snd_soc=
_core coretemp snd_compress kvm_intel ac97_bus snd_pcm_dmaengine snd_hda_in=
tel snd_usb_audio snd_intel_dspcfg snd_fireface snd_intel_sdw_acpi kvm snd_=
usbmidi_lib snd_dice snd_hda_codec snd_firewire_lib snd_ump snd_hda_core sn=
d_rawmidi irqbypass mc snd_hwdep snd_seq_device rapl iTCO_wdt snd_pcm intel=
_pmc_bxt intel_cstate mei_pxp mei_hdcp iTCO_vendor_support ee1004 snd_timer=
 intel_uncore psmouse pcspkr crypto_user
 spi_nor snd i2c_i801 mei_me mousedev wacom joydev mtd igc soundcore i2c_sm=
bus intel_pmc_core intel_vsec mei pmt_telemetry pmt_class mac_hid coreboot_=
table intel_scu_pltdrv ext4 crc32c_generic crc16 mbcache jbd2 hid_logitech =
ff_memless hid_logitech_hidpp hid_logitech_dj dm_crypt cbc uas usb_storage =
encrypted_keys trusted asn1_encoder tee dm_mod usbhid crct10dif_pclmul crc3=
2_pclmul crc32c_intel polyval_clmulni polyval_generic gf128mul ghash_clmuln=
i_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 serio_raw aesni_intel atkbd nv=
me libps2 spi_intel_pci vivaldi_fmap firewire_ohci crypto_simd nvme_core fi=
rewire_core cryptd xhci_pci spi_intel nvme_auth xhci_pci_renesas i8042 crc_=
itu_t serio i915 i2c_algo_bit drm_buddy video wmi ttm intel_gtt drm_display=
_helper cec
CPU: 13 PID: 1993 Comm: reaper/audio Not tainted 6.8.0-rc5-1-mainline #8 c2=
061649224b2c533bd915b824b700586979f2da
Hardware name: Micro-Star International Co., Ltd. MS-7D25/PRO Z690-A DDR4(M=
S-7D25), BIOS Dasharo (coreboot+UEFI) v1.1.3 01/17/2024
RIP: 0010:tasklet_unlock_spin_wait+0xd/0x20
Code: c0 c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 eb 02 f3 90 <48> 8b 47 08 a8 0=
2 75 f6 c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90
RSP: 0018:ffffb828c1cdbd08 EFLAGS: 00000002
RAX: 0000000000000002 RBX: ffff951841aba028 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff951841a2aa70 RDI: ffff951841aba0a8
RBP: ffffb828c1cdbea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000075800 R14: ffff951846a9f600 R15: 0000000000000000
FS:  00007f7f394006c0(0000) GS:ffff952b9fb40000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc65c2a0000 CR3: 000000018516a000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <NMI>
 ? watchdog_hardlockup_check+0xfc/0x1d0
 ? __perf_event_overflow+0xe5/0x2a0
 ? handle_pmi_common+0x16f/0x380
 ? intel_pmu_handle_irq+0x104/0x480
 ? perf_event_nmi_handler+0x2a/0x50
 ? nmi_handle+0x5e/0x150
 ? default_do_nmi+0x40/0x100
 ? exc_nmi+0x139/0x1c0
 ? end_repeat_nmi+0xf/0x60
 ? tasklet_unlock_spin_wait+0xd/0x20
 ? tasklet_unlock_spin_wait+0xd/0x20
 ? tasklet_unlock_spin_wait+0xd/0x20
 </NMI>
 <TASK>
 ohci_flush_iso_completions+0x1d/0x100 [firewire_ohci 83160820eab58a73fec0d=
1e78730dd51dd0ac98c]
 amdtp_domain_stream_pcm_pointer+0x41/0x50 [snd_firewire_lib 95578abd4cf50f=
7c2e87b0d8233b959be2154fc3]
 snd_pcm_update_hw_ptr0+0x6c/0x430 [snd_pcm df3bd3d8840cfa728bc0f17b93055a5=
a1595ec6d]
 ? sched_clock_cpu+0xf/0x190
 ? __smp_call_single_queue+0xad/0x120
 snd_pcm_delay+0x33/0x140 [snd_pcm df3bd3d8840cfa728bc0f17b93055a5a1595ec6d=
]
 snd_pcm_common_ioctl+0x922/0x12b0 [snd_pcm df3bd3d8840cfa728bc0f17b93055a5=
a1595ec6d]
 ? wake_up_q+0x4e/0x90
 ? futex_wake+0x159/0x190
 snd_pcm_ioctl+0x2e/0x50 [snd_pcm df3bd3d8840cfa728bc0f17b93055a5a1595ec6d]
 __x64_sys_ioctl+0x94/0xd0
 do_syscall_64+0x86/0x170
 ? do_syscall_64+0x96/0x170
 ? do_syscall_64+0x96/0x170
 ? do_syscall_64+0x96/0x170
 ? do_syscall_64+0x96/0x170
 ? __irq_exit_rcu+0x4b/0xc0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7f7f47cfd4ff
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 =
24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 f=
f ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007f7f393ffd50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000003cfc060 RCX: 00007f7f47cfd4ff
RDX: 00007f7f393ffdf0 RSI: 0000000080084121 RDI: 000000000000000a
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000004
R10: 00007f7f393ffb20 R11: 0000000000000246 R12: 0000000000005000
R13: 0000000003272a80 R14: 0000000000000050 R15: 00000000032706c0
 </TASK>
watchdog: Watchdog detected hard LOCKUP on cpu 6
CPU: 6 PID: 0 Comm: swapper/6 Not tainted 6.8.0-rc5-1-mainline #8 c20616492=
24b2c533bd915b824b700586979f2da
Hardware name: Micro-Star International Co., Ltd. MS-7D25/PRO Z690-A DDR4(M=
S-7D25), BIOS Dasharo (coreboot+UEFI) v1.1.3 01/17/2024
RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2e0
Code: 77 7f f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4 09 d0 3d =
ff 00 00 00 77 5b 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 <0f> b6 03 84 c0 7=
5 f7 b8 01 00 00 00 66 89 03 65 48 ff 05 83 a6 23
RSP: 0018:ffffb828c01ece08 EFLAGS: 00000002
RAX: 0000000000000001 RBX: ffff951846a9f6f8 RCX: 0000000000000300
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff951846a9f6f8
RBP: ffff95184684c438 R08: ffff951879f3f800 R09: ffff951841a94028
R10: ffff951879f3f800 R11: 0000000000000000 R12: 0000000000000031
R13: 0000000000000000 R14: ffff9518a562e000 R15: ffff9518c49e5800
FS:  0000000000000000(0000) GS:ffff952b9f980000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000001010fdac8 CR3: 000000018516a000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <NMI>
 ? watchdog_hardlockup_check+0xfc/0x1d0
 ? __perf_event_overflow+0xe5/0x2a0
 ? handle_pmi_common+0x16f/0x380
 ? intel_pmu_handle_irq+0x104/0x480
 ? perf_event_nmi_handler+0x2a/0x50
 ? nmi_handle+0x5e/0x150
 ? default_do_nmi+0x40/0x100
 ? exc_nmi+0x139/0x1c0
 ? end_repeat_nmi+0xf/0x60
 ? native_queued_spin_lock_slowpath+0x6e/0x2e0
 ? native_queued_spin_lock_slowpath+0x6e/0x2e0
 ? native_queued_spin_lock_slowpath+0x6e/0x2e0
 </NMI>
 <IRQ>
 _raw_spin_lock_irqsave+0x3d/0x50
 snd_pcm_period_elapsed+0x18/0x40 [snd_pcm df3bd3d8840cfa728bc0f17b93055a5a=
1595ec6d]
 process_rx_packets+0x245/0x5a0 [snd_firewire_lib 95578abd4cf50f7c2e87b0d82=
33b959be2154fc3]
 ? irqtime_account_irq+0x40/0xc0
 irq_target_callback+0x16/0x20 [snd_firewire_lib 95578abd4cf50f7c2e87b0d823=
3b959be2154fc3]
 handle_it_packet+0x135/0x150 [firewire_ohci 83160820eab58a73fec0d1e78730dd=
51dd0ac98c]
 context_tasklet+0x140/0x160 [firewire_ohci 83160820eab58a73fec0d1e78730dd5=
1dd0ac98c]
 tasklet_action_common.isra.0+0x146/0x240
 __do_softirq+0xc9/0x2c8
 __irq_exit_rcu+0xa3/0xc0
 common_interrupt+0x86/0xa0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40
RIP: 0010:cpuidle_enter_state+0xcc/0x440
Code: 2a 39 36 ff e8 05 f1 ff ff 8b 53 04 49 89 c5 0f 1f 44 00 00 31 ff e8 =
83 38 35 ff 45 84 ff 0f 85 56 02 00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 8=
5 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
RSP: 0018:ffffb828c00ffe90 EFLAGS: 00000246
RAX: ffff952b9f9b4800 RBX: ffff952b9f9be208 RCX: 000000000000001f
RDX: 0000000000000006 RSI: 0000000022b8e38e RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 00000000000001c8
R10: 0000000000000018 R11: ffff952b9f9b31e4 R12: ffffffff83f49780
R13: 0000006b6114102b R14: 0000000000000001 R15: 0000000000000000
 cpuidle_enter+0x2d/0x40
 do_idle+0x1d8/0x230
 cpu_startup_entry+0x2a/0x30
 start_secondary+0x11e/0x140
 secondary_startup_64_no_verify+0x184/0x18b
 </TASK>
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: \x096-...0: (1 GPs behind) idle=3Dd7ec/1/0x4000000000000002 softirq=3D=
52862/52863 fqs=3D5201
rcu: \x0913-...0: (1 GPs behind) idle=3Dc9d4/1/0x4000000000000000 softirq=
=3D53654/53655 fqs=3D5201
rcu: \x09(detected by 2, t=3D18002 jiffies, g=3D76629, q=3D5124 ncpus=3D16)
Sending NMI from CPU 2 to CPUs 6:
NMI backtrace for cpu 6
CPU: 6 PID: 0 Comm: swapper/6 Not tainted 6.8.0-rc5-1-mainline #8 c20616492=
24b2c533bd915b824b700586979f2da
Hardware name: Micro-Star International Co., Ltd. MS-7D25/PRO Z690-A DDR4(M=
S-7D25), BIOS Dasharo (coreboot+UEFI) v1.1.3 01/17/2024
RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2e0
Code: 77 7f f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4 09 d0 3d =
ff 00 00 00 77 5b 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 <0f> b6 03 84 c0 7=
5 f7 b8 01 00 00 00 66 89 03 65 48 ff 05 83 a6 23
RSP: 0018:ffffb828c01ece08 EFLAGS: 00000002
RAX: 0000000000000001 RBX: ffff951846a9f6f8 RCX: 0000000000000300
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff951846a9f6f8
RBP: ffff95184684c438 R08: ffff951879f3f800 R09: ffff951841a94028
R10: ffff951879f3f800 R11: 0000000000000000 R12: 0000000000000031
R13: 0000000000000000 R14: ffff9518a562e000 R15: ffff9518c49e5800
FS:  0000000000000000(0000) GS:ffff952b9f980000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000001010fdac8 CR3: 000000018516a000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <NMI>
 ? nmi_cpu_backtrace+0x99/0x110
 ? nmi_cpu_backtrace_handler+0x11/0x20
 ? nmi_handle+0x5e/0x150
 ? default_do_nmi+0x40/0x100
 ? exc_nmi+0x139/0x1c0
 ? end_repeat_nmi+0xf/0x60
 ? native_queued_spin_lock_slowpath+0x6e/0x2e0
 ? native_queued_spin_lock_slowpath+0x6e/0x2e0
 ? native_queued_spin_lock_slowpath+0x6e/0x2e0
 </NMI>
 <IRQ>
 _raw_spin_lock_irqsave+0x3d/0x50
 snd_pcm_period_elapsed+0x18/0x40 [snd_pcm df3bd3d8840cfa728bc0f17b93055a5a=
1595ec6d]
 process_rx_packets+0x245/0x5a0 [snd_firewire_lib 95578abd4cf50f7c2e87b0d82=
33b959be2154fc3]
 ? irqtime_account_irq+0x40/0xc0
 irq_target_callback+0x16/0x20 [snd_firewire_lib 95578abd4cf50f7c2e87b0d823=
3b959be2154fc3]
 handle_it_packet+0x135/0x150 [firewire_ohci 83160820eab58a73fec0d1e78730dd=
51dd0ac98c]
 context_tasklet+0x140/0x160 [firewire_ohci 83160820eab58a73fec0d1e78730dd5=
1dd0ac98c]
 tasklet_action_common.isra.0+0x146/0x240
 __do_softirq+0xc9/0x2c8
 __irq_exit_rcu+0xa3/0xc0
 common_interrupt+0x86/0xa0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40
RIP: 0010:cpuidle_enter_state+0xcc/0x440
Code: 2a 39 36 ff e8 05 f1 ff ff 8b 53 04 49 89 c5 0f 1f 44 00 00 31 ff e8 =
83 38 35 ff 45 84 ff 0f 85 56 02 00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 8=
5 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
RSP: 0018:ffffb828c00ffe90 EFLAGS: 00000246
RAX: ffff952b9f9b4800 RBX: ffff952b9f9be208 RCX: 000000000000001f
RDX: 0000000000000006 RSI: 0000000022b8e38e RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 00000000000001c8
R10: 0000000000000018 R11: ffff952b9f9b31e4 R12: ffffffff83f49780
R13: 0000006b6114102b R14: 0000000000000001 R15: 0000000000000000
 cpuidle_enter+0x2d/0x40
 do_idle+0x1d8/0x230
 cpu_startup_entry+0x2a/0x30
 start_secondary+0x11e/0x140
 secondary_startup_64_no_verify+0x184/0x18b
 </TASK>
Sending NMI from CPU 2 to CPUs 13:
NMI backtrace for cpu 13
CPU: 13 PID: 1993 Comm: reaper/audio Not tainted 6.8.0-rc5-1-mainline #8 c2=
061649224b2c533bd915b824b700586979f2da
Hardware name: Micro-Star International Co., Ltd. MS-7D25/PRO Z690-A DDR4(M=
S-7D25), BIOS Dasharo (coreboot+UEFI) v1.1.3 01/17/2024
RIP: 0010:tasklet_unlock_spin_wait+0xd/0x20
Code: c0 c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 eb 02 f3 90 <48> 8b 47 08 a8 0=
2 75 f6 c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90
RSP: 0018:ffffb828c1cdbd08 EFLAGS: 00000002
RAX: 0000000000000002 RBX: ffff951841aba028 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff951841a2aa70 RDI: ffff951841aba0a8
RBP: ffffb828c1cdbea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000075800 R14: ffff951846a9f600 R15: 0000000000000000
FS:  00007f7f394006c0(0000) GS:ffff952b9fb40000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc65c2a0000 CR3: 000000018516a000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <NMI>
 ? nmi_cpu_backtrace+0x99/0x110
 ? nmi_cpu_backtrace_handler+0x11/0x20
 ? nmi_handle+0x5e/0x150
 ? default_do_nmi+0x40/0x100
 ? exc_nmi+0x139/0x1c0
 ? end_repeat_nmi+0xf/0x60
 ? tasklet_unlock_spin_wait+0xd/0x20
 ? tasklet_unlock_spin_wait+0xd/0x20
 ? tasklet_unlock_spin_wait+0xd/0x20
 </NMI>
 <TASK>
 ohci_flush_iso_completions+0x1d/0x100 [firewire_ohci 83160820eab58a73fec0d=
1e78730dd51dd0ac98c]
 amdtp_domain_stream_pcm_pointer+0x41/0x50 [snd_firewire_lib 95578abd4cf50f=
7c2e87b0d8233b959be2154fc3]
 snd_pcm_update_hw_ptr0+0x6c/0x430 [snd_pcm df3bd3d8840cfa728bc0f17b93055a5=
a1595ec6d]
 ? sched_clock_cpu+0xf/0x190
 ? __smp_call_single_queue+0xad/0x120
 snd_pcm_delay+0x33/0x140 [snd_pcm df3bd3d8840cfa728bc0f17b93055a5a1595ec6d=
]
 snd_pcm_common_ioctl+0x922/0x12b0 [snd_pcm df3bd3d8840cfa728bc0f17b93055a5=
a1595ec6d]
 ? wake_up_q+0x4e/0x90
 ? futex_wake+0x159/0x190
 snd_pcm_ioctl+0x2e/0x50 [snd_pcm df3bd3d8840cfa728bc0f17b93055a5a1595ec6d]
 __x64_sys_ioctl+0x94/0xd0
 do_syscall_64+0x86/0x170
 ? do_syscall_64+0x96/0x170
 ? do_syscall_64+0x96/0x170
 ? do_syscall_64+0x96/0x170
 ? do_syscall_64+0x96/0x170
 ? __irq_exit_rcu+0x4b/0xc0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7f7f47cfd4ff
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 =
24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 f=
f ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007f7f393ffd50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000003cfc060 RCX: 00007f7f47cfd4ff
RDX: 00007f7f393ffdf0 RSI: 0000000080084121 RDI: 000000000000000a
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000004
R10: 00007f7f393ffb20 R11: 0000000000000246 R12: 0000000000005000
R13: 0000000003272a80 R14: 0000000000000050 R15: 00000000032706c0
 </TASK>
INFO: task khugepaged:124 blocked for more than 122 seconds.
      Not tainted 6.8.0-rc5-1-mainline #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:khugepaged      state:D stack:0     pid:124   tgid:124   ppid:2      f=
lags:0x00004000
Call Trace:
 <TASK>
 __schedule+0x3e6/0x1520
 ? place_entity+0x1b/0xf0
 schedule+0x32/0xd0
 schedule_timeout+0x151/0x160
 wait_for_completion+0x8a/0x160
 __flush_work.isra.0+0x173/0x280
 ? __pfx_wq_barrier_func+0x10/0x10
 __lru_add_drain_all+0x14c/0x200
 khugepaged+0x72/0x950
 ? __pfx_autoremove_wake_function+0x10/0x10
 ? __pfx_khugepaged+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>


