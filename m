Return-Path: <linux-kernel+bounces-99592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD77878A72
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D5A1C20A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1FA57312;
	Mon, 11 Mar 2024 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkNiBOpf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA956B98;
	Mon, 11 Mar 2024 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194608; cv=none; b=FmCqifKIbcEjWezD8QHgYajsNpkIRvY9N0llzOS3HKKDcZZSYlZ3ZWKBoaL6Y+fcvlXQsKqpNHPWv9ZZ3JAqmeXdFbA1VqtomqiT/zLHhQNpVnQ/Erm/cL4ehq8tbTNC8lkKwHl5HTCUOssZy2WZnjXoyOSJS6u0nXI45v6EU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194608; c=relaxed/simple;
	bh=65bTy4O/5LgvJRBpVeWNXhuk+mmuaIAFbCgxKM2xEkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkBRBmi/+NudJ/KeLVS8L2/Zpfsx/ThdHdXfawbuKo9tXYUyGWsq1XRCqzp26lojn/AUn7w38TlArmn/mi/1uVXQ2j/67eNaKhysPNzIzJ4A1KPnfz7AFzeczviG181203qGHXJ12DniCgtn0J9O7DYX/hXkcPYL8nAtPBTL2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkNiBOpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C5BC433F1;
	Mon, 11 Mar 2024 22:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710194608;
	bh=65bTy4O/5LgvJRBpVeWNXhuk+mmuaIAFbCgxKM2xEkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkNiBOpfmjo2MVDbBPtTy1U/VGXNjG769GkKY2FH6bpANaaT343BmKK9knlt0oU9Q
	 e0QTUW2+QD6sgBPdLqvNxMD91ckMbp1sAPR7QkMeKTXeU2ol7kEqmgKfrPHIh986bS
	 ZvrmwEWUbuUeRpLE7SrzUBv/NxhmZjkFoSlxVZz5HvUhnTzEfpvJSuYF3SLCzuMxR1
	 WNK8YCMqjR6NR1tDOZidbRmB/+OPESzpFz3M4YgfkRspz8ndsT1F6keyD5/ZqdnRD4
	 ef/8S8dFL/fFtTb0m1g0V7wHxYpQxN7Zp8AhlC6d8p9bS0+9IBqyXnOSjp+m7MbvSx
	 FSiBJlDVjHy+g==
Date: Mon, 11 Mar 2024 19:03:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4] perf: Make SIGTRAP and __perf_pending_irq() work on
 RT.
Message-ID: <Ze9_rP9FaMq_fWHt@x1>
References: <20240308175810.2894694-1-bigeasy@linutronix.de>
 <Ze7eKgdajyEgQcpL@elver.google.com>
 <20240311155927.sbWzLN62@linutronix.de>
 <CANpmjNNXd6rL10Vju-tsa1aPsCSMykmfoMg1E1_B-DwKVQw_2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANpmjNNXd6rL10Vju-tsa1aPsCSMykmfoMg1E1_B-DwKVQw_2w@mail.gmail.com>

On Mon, Mar 11, 2024 at 05:31:09PM +0100, Marco Elver wrote:
> On Mon, 11 Mar 2024 at 16:59, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2024-03-11 11:34:18 [+0100], Marco Elver wrote:
> > > Unfortunately there's a bug in it somewhere. It can be reproduced with
> > > tools/testing/selftests/perf_events/remove_on_exec.
> > >
> > > (FWIW, the kselftests in that directory are more aggressive test cases
> > > that I never figured out how to properly port to the 'perf test'
> > > framework: sigtrap_threads is a more aggressive version of the 'sigtr=
ap'
> > > perf test, and remove_on_exec has no perf test counterpart.)
> >
> > You posted to warnings, I can only reproduce the second one. Based on t=
he
> > backtrace it is obvious what happens and I dare to say that I know why=
=E2=80=A6
> > Let me try address them.
>=20
> I guess I got lucky with hitting 2 warnings instantly. It might be
> necessary to run remove_on_exec several times, or even start several
> instances of it concurrently (something like "for x in {0..100}; do
> (./remove_on_exec &); done" might do the trick).

Doing this parallel remove_on_exec selftest, without Sebastian's patchs I
eventually hit, which is the original, the following output, then I
managed to replicate Marco's two different splats, see below.

[  275.644373] BUG: scheduling while atomic: remove_on_exec/10716/0x00000002
[  275.644378] Modules linked in: xfs libcrc32c i915 i2c_algo_bit drm_buddy=
 ttm intel_gtt drm_display_helper drm_kms_helper sr_mod sd_mod cdrom t10_pi=
 sg drm sdhci_pci cqhci ahci crct10dif_pclmul crc32_pclmul libahci crc32c_i=
ntel sdhci e1000e libata ghash_clmulni_intel mmc_core cec video wmi serio_r=
aw dm_mirror dm_region_hash dm_log dm_mod fuse
[  275.644402] Preemption disabled at:
[  275.644402] [<0000000000000000>] 0x0
[  275.644407] CPU: 0 PID: 10716 Comm: remove_on_exec Kdump: loaded Tainted=
: G        W          6.8.0-rc7-rt6 #1
[  275.644410] Hardware name: LENOVO 427623U/427623U, BIOS 8BET45WW (1.25 )=
 05/18/2011
[  275.644411] Call Trace:
[  275.644414]  <TASK>
[  275.644416]  dump_stack_lvl+0x51/0x70
[  275.644421]  __schedule_bug+0x89/0xa0
[  275.644426]  schedule_debug.constprop.0+0xd1/0x120
[  275.644430]  __schedule+0x50/0x680
[  275.644433]  ? _raw_spin_lock+0x13/0x40
[  275.644436]  ? __sigqueue_alloc+0x81/0x120
[  275.644440]  schedule_rtlock+0x1e/0x40
[  275.644443]  rtlock_slowlock_locked+0xcd/0x270
[  275.644446]  rt_spin_lock+0x41/0x60
[  275.644448]  obj_cgroup_charge+0x3c/0x1d0
[  275.644451]  kmem_cache_alloc+0x255/0x2a0
[  275.644455]  __sigqueue_alloc+0x81/0x120
[  275.644459]  __send_signal_locked+0x25c/0x3c0
[  275.644461]  ? send_signal_locked+0x3f/0x130
[  275.644464]  do_send_sig_info+0x54/0xb0
[  275.644467]  send_sig_perf+0x70/0x90
[  275.644470]  perf_pending_task+0x89/0xa0
[  275.644473]  task_work_run+0x59/0x90
[  275.644476]  irqentry_exit_to_user_mode+0x1dd/0x1e0
[  275.644480]  asm_sysvec_irq_work+0x16/0x20
[  275.644483] RIP: 0033:0x403376
[  275.644485] Code: 48 89 bd c8 fe ff ff 48 89 b5 c0 fe ff ff 48 89 95 b8 =
fe ff ff e8 1a df ff ff 89 85 24 ff ff ff 83 bd 24 ff ff ff 00 75 15 90 <8b=
> 05 84 53 00 00 85 c0 74 f6 bf 2a 00 00 00 e8 e6 dc ff ff 48 8d
[  275.644487] RSP: 002b:00007fffc462fde0 EFLAGS: 00000246
[  275.644489] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f442bd=
9a018
[  275.644490] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00001
[  275.644491] RBP: 00007fffc462ff30 R08: 0000000000000000 R09: 00000000000=
00000
[  275.644493] R10: 00007f442bd9a008 R11: 0000000000000246 R12: 00007fffc46=
301f8
[  275.644494] R13: 00000000004046cf R14: 0000000000407e08 R15: 00007f442bd=
99000
[  275.644497]  </TASK>
[  275.681832] BUG: using smp_processor_id() in preemptible [00000000] code=
: remove_on_exec/10716
[  275.681838] caller is perf_pending_task+0x34/0xa0



Now with Sebastian's patch series:

  612.723013] ------------[ cut here ]------------
[  612.723016] WARNING: CPU: 3 PID: 8655 at kernel/events/core.c:9595 __per=
f_event_overflow+0x21a/0x230
[  612.723026] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nf=
t_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_c=
hain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables=
 nfnetlink bnep sunrpc iwldvm intel_rapl_msr intel_rapl_common x86_pkg_temp=
_thermal intel_powerclamp mac80211 snd_hda_codec_hdmi snd_ctl_led snd_hda_c=
odec_conexant coretemp snd_hda_codec_generic kvm_intel snd_hda_intel snd_in=
tel_dspcfg snd_intel_sdw_acpi libarc4 snd_hda_codec kvm snd_hda_core iwlwif=
i snd_hwdep uvcvideo snd_seq uvc btusb snd_seq_device videobuf2_vmalloc btr=
tl snd_pcm videobuf2_memops btintel btbcm videobuf2_v4l2 btmtk videodev mei=
_wdt irqbypass thinkpad_acpi snd_timer rapl think_lmi iTCO_wdt cfg80211 blu=
etooth iTCO_vendor_support intel_cstate snd videobuf2_common i2c_i801 firmw=
are_attributes_class mei_me mc pcspkr intel_uncore wmi_bmof ledtrig_audio i=
2c_smbus mei soundcore lpc_ich platform_profile rfkill joydev xfs libcrc32c=
 i915 i2c_algo_bit drm_buddy ttm intel_gtt drm_display_helper
[  612.723090]  drm_kms_helper sr_mod sd_mod cdrom t10_pi sg drm crct10dif_=
pclmul ahci crc32_pclmul sdhci_pci libahci crc32c_intel e1000e cqhci libata=
 sdhci ghash_clmulni_intel mmc_core cec video wmi serio_raw dm_mirror dm_re=
gion_hash dm_log dm_mod fuse
[  612.723111] CPU: 3 PID: 8655 Comm: remove_on_exec Kdump: loaded Not tain=
ted 6.8.0-rc7.sebastian-rt6+ #1
[  612.723114] Hardware name: LENOVO 427623U/427623U, BIOS 8BET45WW (1.25 )=
 05/18/2011
[  612.723115] RIP: 0010:__perf_event_overflow+0x21a/0x230
[  612.723120] Code: 45 31 ed 5b 5d 44 89 e8 41 5c 41 5d 41 5e c3 cc cc cc =
cc 48 c7 83 40 03 00 00 00 00 00 00 e9 03 ff ff ff 0f 0b e9 c8 fe ff ff <0f=
> 0b e9 77 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
[  612.723123] RSP: 0000:ffffb81e833abc50 EFLAGS: 00010087
[  612.723125] RAX: 00000000004045c1 RBX: ffff93e80107ec48 RCX: 00000000004=
045bb
[  612.723127] RDX: 0000000000000020 RSI: ffffffffac25de92 RDI: ffffffffac1=
f45ee
[  612.723128] RBP: ffffb81e833abcc0 R08: 0000000000000002 R09: ffffb81e833=
abcc0
[  612.723130] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb81e833=
abf58
[  612.723131] R13: 0000000000000000 R14: 0000000000000001 R15: 00000000000=
00020
[  612.723132] FS:  00007f6a22d87600(0000) GS:ffff93eb1e2c0000(0000) knlGS:=
0000000000000000
[  612.723135] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  612.723136] CR2: 0000000000405730 CR3: 000000011687c003 CR4: 00000000000=
606f0
[  612.723138] Call Trace:
[  612.723139]  <TASK>
[  612.723141]  ? __warn+0x85/0x140
[  612.723145]  ? __perf_event_overflow+0x21a/0x230
[  612.723149]  ? report_bug+0x1c3/0x1d0
[  612.723155]  ? handle_bug+0x3c/0x70
[  612.723159]  ? exc_invalid_op+0x14/0x70
[  612.723163]  ? asm_exc_invalid_op+0x16/0x20
[  612.723170]  ? __perf_event_overflow+0x21a/0x230
[  612.723174]  handle_pmi_common+0x18b/0x400
[  612.723178]  ? kick_process+0x46/0xc0
[  612.723183]  ? migrate_enable+0xaa/0xf0
[  612.723188]  ? rt_spin_unlock+0x13/0x40
[  612.723191]  ? do_send_sig_info+0x63/0xb0
[  612.723195]  ? kill_pid_info+0x9f/0xb0
[  612.723199]  ? kill_something_info+0x170/0x1a0
[  612.723202]  ? rt_read_unlock+0x31/0x1a0
[  612.723205]  ? __x64_sys_kill+0x7f/0xb0
[  612.723209]  intel_pmu_handle_irq+0x112/0x2a0
[  612.723213]  perf_event_nmi_handler+0x28/0x50
[  612.723217]  nmi_handle+0x5e/0x150
[  612.723222]  default_do_nmi+0x6b/0x180
[  612.723225]  exc_nmi+0x10f/0x190
[  612.723227]  asm_exc_nmi+0xb1/0xfa
[  612.723230] RIP: 0033:0x4045c1
[  612.723233] Code: 8b 40 2c 85 c0 75 d4 83 45 c4 01 8b 45 c4 83 f8 1d 0f =
86 3e fe ff ff 8b 05 4c 41 00 00 89 85 2c ff ff ff 90 8b 15 3f 41 00 00 <8b=
> 85 2c ff ff ff 39 c2 74 f0 90 90 c9 c3 55 48 89 e5 48 81 ec b0
[  612.723234] RSP: 002b:00007ffc40fd6c40 EFLAGS: 00000246
[  612.723236] RAX: 0000000000000005 RBX: 0000000000000000 RCX: 00007f6a22b=
a676b
[  612.723238] RDX: 0000000000000005 RSI: 0000000000000009 RDI: 00000000000=
021ed
[  612.723239] RBP: 00007ffc40fd6d40 R08: 00000000000021ed R09: 00000000000=
00000
[  612.723241] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc40f=
d7008
[  612.723242] R13: 00000000004046cf R14: 0000000000407e08 R15: 00007f6a22d=
ca000
[  612.723246]  </TASK>
[  612.723247] ---[ end trace 0000000000000000 ]---
[  617.892290] perf: interrupt took too long (2509 > 2500), lowering kernel=
=2Eperf_event_max_sample_rate to 79000
[  618.992995] ------------[ cut here ]------------
[  618.992999] unexpected event refcount: 2; ptr=3D0000000022c05d43
[  618.993007] WARNING: CPU: 2 PID: 8967 at kernel/events/core.c:5240 free_=
event+0x36/0x40
[  618.993015] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nf=
t_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_c=
hain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables=
 nfnetlink bnep sunrpc iwldvm intel_rapl_msr intel_rapl_common x86_pkg_temp=
_thermal intel_powerclamp mac80211 snd_hda_codec_hdmi snd_ctl_led snd_hda_c=
odec_conexant coretemp snd_hda_codec_generic kvm_intel snd_hda_intel snd_in=
tel_dspcfg snd_intel_sdw_acpi libarc4 snd_hda_codec kvm snd_hda_core iwlwif=
i snd_hwdep uvcvideo snd_seq uvc btusb snd_seq_device videobuf2_vmalloc btr=
tl snd_pcm videobuf2_memops btintel btbcm videobuf2_v4l2 btmtk videodev mei=
_wdt irqbypass thinkpad_acpi snd_timer rapl think_lmi iTCO_wdt cfg80211 blu=
etooth iTCO_vendor_support intel_cstate snd videobuf2_common i2c_i801 firmw=
are_attributes_class mei_me mc pcspkr intel_uncore wmi_bmof ledtrig_audio i=
2c_smbus mei soundcore lpc_ich platform_profile rfkill joydev xfs libcrc32c=
 i915 i2c_algo_bit drm_buddy ttm intel_gtt drm_display_helper
[  618.993068]  drm_kms_helper sr_mod sd_mod cdrom t10_pi sg drm crct10dif_=
pclmul ahci crc32_pclmul sdhci_pci libahci crc32c_intel e1000e cqhci libata=
 sdhci ghash_clmulni_intel mmc_core cec video wmi serio_raw dm_mirror dm_re=
gion_hash dm_log dm_mod fuse
[  618.993086] CPU: 2 PID: 8967 Comm: exe Kdump: loaded Tainted: G        W=
          6.8.0-rc7.sebastian-rt6+ #1
[  618.993089] Hardware name: LENOVO 427623U/427623U, BIOS 8BET45WW (1.25 )=
 05/18/2011
[  618.993090] RIP: 0010:free_event+0x36/0x40
[  618.993093] Code: f0 48 0f b1 97 38 02 00 00 48 83 f8 01 75 05 e9 a0 fd =
ff ff 48 8b b7 38 02 00 00 48 89 fa 48 c7 c7 20 9c 1b ac e8 6a 52 dd ff <0f=
> 0b c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90
[  618.993095] RSP: 0018:ffffb81e83c8bd30 EFLAGS: 00010282
[  618.993097] RAX: 0000000000000000 RBX: dead000000000122 RCX: 00000000000=
00000
[  618.993099] RDX: 0000000000000002 RSI: ffffffffac1dcc6a RDI: 00000000fff=
fffff
[  618.993100] RBP: ffff93e8010799c8 R08: 0000000000000000 R09: ffffb81e83c=
8bb28
[  618.993102] R10: ffffb81e83c8bb20 R11: ffffffffacdefe48 R12: ffff93e8010=
4e1f8
[  618.993103] R13: ffff93e82d021284 R14: ffffb81e83c8bad8 R15: dead0000000=
00100
[  618.993104] FS:  0000000000000000(0000) GS:ffff93eb1e280000(0000) knlGS:=
0000000000000000
[  618.993106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  618.993108] CR2: 00007ffce8826e40 CR3: 0000000116464004 CR4: 00000000000=
606f0
[  618.993110] Call Trace:
[  618.993111]  <TASK>
[  618.993113]  ? __warn+0x85/0x140
[  618.993116]  ? free_event+0x36/0x40
[  618.993118]  ? report_bug+0x1c3/0x1d0
[  618.993124]  ? handle_bug+0x3c/0x70
[  618.993127]  ? exc_invalid_op+0x14/0x70
[  618.993130]  ? asm_exc_invalid_op+0x16/0x20
[  618.993136]  ? free_event+0x36/0x40
[  618.993138]  perf_event_release_kernel+0x255/0x2f0
[  618.993142]  perf_release+0x11/0x20
[  618.993144]  __fput+0x96/0x2c0
[  618.993147]  task_work_run+0x59/0x90
[  618.993152]  get_signal+0x91/0x900
[  618.993156]  arch_do_signal_or_restart+0x25/0x100
[  618.993160]  ? do_execveat_common.isra.0+0x1ae/0x230
[  618.993164]  ? syscall_exit_work+0x103/0x130
[  618.993166]  syscall_exit_to_user_mode+0x1ae/0x1f0
[  618.993170]  do_syscall_64+0x90/0x170
[  618.993173]  ? do_user_addr_fault+0x31b/0x690
[  618.993177]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  618.993180] RIP: 0033:0x7f573a46eed0
[  618.993185] Code: Unable to access opcode bytes at 0x7f573a46eea6.
[  618.993186] RSP: 002b:00007ffce8826e40 EFLAGS: 00000200 ORIG_RAX: 000000=
000000003b
[  618.993188] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[  618.993189] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[  618.993190] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[  618.993191] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[  618.993192] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[  618.993195]  </TASK>
[  618.993195] ---[ end trace 0000000000000000 ]---
[  619.727029] ------------[ cut here ]------------
[  619.727033] unexpected event refcount: 2; ptr=3D00000000b09e0f42
[  619.727042] WARNING: CPU: 2 PID: 9017 at kernel/events/core.c:5240 free_=
event+0x36/0x40
[  619.727048] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nf=
t_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_c=
hain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables=
 nfnetlink bnep sunrpc iwldvm intel_rapl_msr intel_rapl_common x86_pkg_temp=
_thermal intel_powerclamp mac80211 snd_hda_codec_hdmi snd_ctl_led snd_hda_c=
odec_conexant coretemp snd_hda_codec_generic kvm_intel snd_hda_intel snd_in=
tel_dspcfg snd_intel_sdw_acpi libarc4 snd_hda_codec kvm snd_hda_core iwlwif=
i snd_hwdep uvcvideo snd_seq uvc btusb snd_seq_device videobuf2_vmalloc btr=
tl snd_pcm videobuf2_memops btintel btbcm videobuf2_v4l2 btmtk videodev mei=
_wdt irqbypass thinkpad_acpi snd_timer rapl think_lmi iTCO_wdt cfg80211 blu=
etooth iTCO_vendor_support intel_cstate snd videobuf2_common i2c_i801 firmw=
are_attributes_class mei_me mc pcspkr intel_uncore wmi_bmof ledtrig_audio i=
2c_smbus mei soundcore lpc_ich platform_profile rfkill joydev xfs libcrc32c=
 i915 i2c_algo_bit drm_buddy ttm intel_gtt drm_display_helper
[  619.727102]  drm_kms_helper sr_mod sd_mod cdrom t10_pi sg drm crct10dif_=
pclmul ahci crc32_pclmul sdhci_pci libahci crc32c_intel e1000e cqhci libata=
 sdhci ghash_clmulni_intel mmc_core cec video wmi serio_raw dm_mirror dm_re=
gion_hash dm_log dm_mod fuse
[  619.727119] CPU: 2 PID: 9017 Comm: exe Kdump: loaded Tainted: G        W=
          6.8.0-rc7.sebastian-rt6+ #1
[  619.727122] Hardware name: LENOVO 427623U/427623U, BIOS 8BET45WW (1.25 )=
 05/18/2011
[  619.727123] RIP: 0010:free_event+0x36/0x40
[  619.727126] Code: f0 48 0f b1 97 38 02 00 00 48 83 f8 01 75 05 e9 a0 fd =
ff ff 48 8b b7 38 02 00 00 48 89 fa 48 c7 c7 20 9c 1b ac e8 6a 52 dd ff <0f=
> 0b c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90
[  619.727128] RSP: 0018:ffffb81e83d5bca8 EFLAGS: 00010282
[  619.727130] RAX: 0000000000000000 RBX: dead000000000122 RCX: 00000000000=
00000
[  619.727132] RDX: 0000000000000002 RSI: ffffffffac1dcc6a RDI: 00000000fff=
fffff
[  619.727133] RBP: ffff93e801023390 R08: 0000000000000000 R09: ffffb81e83d=
5baa0
[  619.727134] R10: ffffb81e83d5ba98 R11: ffffffffacdefe48 R12: ffff93e8010=
261f8
[  619.727136] R13: ffff93e8054b7d84 R14: ffffb81e83d5ba50 R15: dead0000000=
00100
[  619.727137] FS:  0000000000000000(0000) GS:ffff93eb1e280000(0000) knlGS:=
0000000000000000
[  619.727139] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  619.727140] CR2: 00007ffe58ed17b9 CR3: 00000001058da003 CR4: 00000000000=
606f0
[  619.727142] Call Trace:
[  619.727143]  <TASK>
[  619.727145]  ? __warn+0x85/0x140
[  619.727148]  ? free_event+0x36/0x40
[  619.727150]  ? report_bug+0x1c3/0x1d0
[  619.727156]  ? handle_bug+0x3c/0x70
[  619.727159]  ? exc_invalid_op+0x14/0x70
[  619.727162]  ? asm_exc_invalid_op+0x16/0x20
[  619.727169]  ? free_event+0x36/0x40
[  619.727171]  ? free_event+0x36/0x40
[  619.727172]  perf_event_release_kernel+0x255/0x2f0
[  619.727176]  perf_release+0x11/0x20
[  619.727178]  __fput+0x96/0x2c0
[  619.727182]  task_work_run+0x59/0x90
[  619.727185]  get_signal+0x91/0x900
[  619.727190]  ? migrate_enable+0xaa/0xf0
[  619.727194]  arch_do_signal_or_restart+0x25/0x100
[  619.727197]  ? do_execveat_common.isra.0+0x1ae/0x230
[  619.727200]  ? syscall_exit_work+0x103/0x130
[  619.727202]  syscall_exit_to_user_mode+0x1ae/0x1f0
[  619.727206]  do_syscall_64+0x90/0x170
[  619.727209]  ? __count_memcg_events+0x60/0x100
[  619.727213]  ? mm_account_fault+0x6c/0x100
[  619.727217]  ? handle_mm_fault+0xd8/0x210
[  619.727220]  ? do_user_addr_fault+0x31b/0x690
[  619.727224]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  619.727227] RIP: 0033:0x7ffb0bcffed0
[  619.727232] Code: Unable to access opcode bytes at 0x7ffb0bcffea6.
[  619.727233] RSP: 002b:00007ffe58ed14b0 EFLAGS: 00000200 ORIG_RAX: 000000=
000000003b
[  619.727236] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[  619.727237] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[  619.727238] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[  619.727239] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[  619.727240] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[  619.727242]  </TASK>
[  619.727243] ---[ end trace 0000000000000000 ]---
[acme@nine perf_events]$=20



