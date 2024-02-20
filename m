Return-Path: <linux-kernel+bounces-73706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072985C653
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3231F23228
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD3B151CE8;
	Tue, 20 Feb 2024 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GY/ICoVr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8303151CE7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462790; cv=none; b=EBBYlV2bUomY3uyg3fnXsjIfl2/PXl3dSDMUfKTiZJ2nMVWGYq/biDHka0ndnSC3hhNyi4UJnkneAz7tQBgxwCmNiVdnpX44xhtPGjlYnyqFb+IjF3IsGUpsK+vARZYWJPOF8J1kJyxvs2JRYetwRSaW7F3GXakEyVCWNUsXC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462790; c=relaxed/simple;
	bh=iq4V55mMHMiOmf2zEn7/G7jyPhFlvGyqjcidmiYj8ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQQtCZXUVdDt9Dg0t49n/3kVqKtkCjdmZsHGaJIl5bHBO8f1M9MKtZTkfOubd1lUu3UD33zIwk/DnQwi6fLVGw2FO3ZwuZo9Lr4+VjNtSpeQULROP2qe5AwNIJkAG/TIvxcVikJjS2oKop8M666kGKdaNGZwdvWyICcy6JLYdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GY/ICoVr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708462788; x=1739998788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iq4V55mMHMiOmf2zEn7/G7jyPhFlvGyqjcidmiYj8ic=;
  b=GY/ICoVrj48BdNKCWWHFes8p0VHncyRO/Ysjdfa1f2u40oagdLcVAUyF
   O2Rufl2O9wg4zESHFPC/IGgzzaS6BGBCMLRk0r8nIPiR0K1mdBqcKhW4y
   P7OOW7mh/So7ukQ/omREeD6lDLT2yWYsSRDAJnR0Ja1r++XJZWmMdn5vW
   BtiqcObwgy3GqMsvqFda5wmRTlT1uvlGSt0Mn9/DtMq4mB06pcB9oUto4
   RpqPXm9FeAyHL+XNaXQfPFjk+YuBDdO8vzSoQBXIWmE0hRdnLpvmJo3Tn
   kumWUy0Cb68cv46ciM1ktwcgS/6RNqGy6tAS37Ap3kDkVLLXLUsmuS/71
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2454927"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2454927"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:59:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5266372"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:59:47 -0800
Date: Tue, 20 Feb 2024 12:59:44 -0800
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Message-ID: <ZdUSwOM9UUNpw84Y@agluck-desk3>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local>
 <87zfvwieli.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87zfvwieli.ffs@tglx>

On Mon, Feb 19, 2024 at 05:49:29PM +0100, Thomas Gleixner wrote:
> On Sat, Feb 17 2024 at 11:55, Borislav Petkov wrote:
>=20
> > On Tue, Feb 13, 2024 at 06:44:14PM +0000, James Morse wrote:
> >> Hello!
> >>=20
> >> It's been back and forth for whether this series should be rebased ont=
o Tony's
> >> SNC series. This version isn't, its based on tip/x86/cache.
> >> (I have the rebased-and-tested versions if anyone needs them)
> >
> > The set applied ontop of tip:x86/cache gives:
> >
> > vmlinux.o: in function `get_domain_from_cpu':
> > (.text+0x150f33): undefined reference to `lockdep_is_cpus_held'
> > ld: vmlinux.o: in function `rdt_ctrl_update':
> > (.text+0x150fbc): undefined reference to `lockdep_is_cpus_held'
>=20
> Wants to be folded into patch 24.
>=20
> Thanks,
>=20
>         tglx
> ---
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -368,8 +368,8 @@ struct rdt_domain *get_domain_from_cpu(i
>  	 * about locks this thread holds will lead to false positives. Check
>  	 * someone is holding the CPUs lock.
>  	 */
> -	if (IS_ENABLED(CONFIG_LOCKDEP))
> -		lockdep_is_cpus_held();
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && IS_ENABLED(CONFIG_LOCKDEP))
> +		WARN_ON_ONCE(!lockdep_is_cpus_held());
> =20
>  	list_for_each_entry(d, &r->domains, list) {
>  		/* Find the domain that contains this CPU */

Testing tip x86/cache that WARN fires while running
tools/tests/selftests/resctrl/resctrl_test.

Everthing runs OK if I drop the top commit:
  fb700810d30b ("x86/resctrl: Separate arch and fs resctrl locks")

-Tony


[  663.817986] ------------[ cut here ]------------
[  663.822667] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/cpu/resctrl/core.c=
:372 get_domain_from_cpu+0x45/0x50
[  663.832332] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq=
_device snd_timer snd soundcore nf_conntrack_netbios_ns nf_conntrack_broadc=
ast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_rejec=
t_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack n=
f_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr intel_r=
apl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_com=
mon i10nm_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretem=
p kvm_intel ipmi_ssif sunrpc binfmt_misc kvm dax_hmem cxl_acpi irqbypass vf=
at iTCO_wdt rapl intel_pmc_bxt iTCO_vendor_support intel_cstate fat intel_u=
ncore cxl_core pcspkr acpi_ipmi isst_if_mmio isst_if_mbox_pci i2c_i801 isst=
_if_common mei_me i2c_smbus mei intel_pch_thermal intel_vsec ioatdma ipmi_s=
i ipmi_devintf joydev ipmi_msghandler acpi_power_meter acpi_pad loop zram c=
rct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic g=
hash_clmulni_intel sha512_ssse3 ixgbe igb sha256_ssse3 ast
[  663.832534]  mdio sha1_ssse3 i2c_algo_bit dca wmi ip6_tables ip_tables f=
use
[  663.929224] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc1+ #247
[  663.935662] Hardware name: Intel Corporation WilsonCity/WilsonCity, BIOS=
 WLYDCRB1.SYS.0021.P06.2104260458 04/26/2021
[  663.946175] RIP: 0010:get_domain_from_cpu+0x45/0x50
[  663.951061] Code: 73 40 89 ef 48 39 f0 75 0a eb 16 48 8b 00 48 39 f0 74 =
0e 48 0f a3 78 18 73 f1 5b 5d c3 cc cc cc cc 31 c0 5b 5d c3 cc cc cc cc <0f=
> 0b eb cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
[  663.969807] RSP: 0018:ff22c48cc0003f80 EFLAGS: 00010046
[  663.975042] RAX: 0000000000000000 RBX: ffffffff92e4a3a0 RCX: 00000000000=
00001
[  663.982174] RDX: 0000000000000000 RSI: ffffffff92aa8289 RDI: ffffffff92b=
56a1e
[  663.989305] RBP: 0000000000000000 R08: 0000000000000002 R09: 00000000000=
00000
[  663.996436] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff92e=
4a3a0
[  664.003570] R13: 0000000000000000 R14: ffffffff910672c0 R15: ff22c48ce0e=
17df0
[  664.010699] FS:  0000000000000000(0000) GS:ff1f2c6cdde00000(0000) knlGS:=
0000000000000000
[  664.018785] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  664.024530] CR2: 00007f608c001048 CR3: 0000000582e38003 CR4: 00000000007=
71ef0
[  664.031664] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  664.038794] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  664.045927] PKRU: 55555554
[  664.048641] Call Trace:
[  664.051093]  <IRQ>
[  664.053113]  ? get_domain_from_cpu+0x45/0x50
[  664.057391]  ? __warn+0x81/0x170
[  664.060637]  ? get_domain_from_cpu+0x45/0x50
[  664.064917]  ? report_bug+0x18d/0x1c0
[  664.068593]  ? handle_bug+0x3c/0x80
[  664.072089]  ? exc_invalid_op+0x13/0x60
[  664.075931]  ? asm_exc_invalid_op+0x16/0x20
[  664.080124]  ? __pfx_rdt_ctrl_update+0x10/0x10
[  664.084574]  ? get_domain_from_cpu+0x45/0x50
[  664.088854]  rdt_ctrl_update+0x20/0x70
[  664.092613]  __flush_smp_call_function_queue+0xdd/0x560
[  664.097848]  __sysvec_call_function+0x32/0x110
[  664.102301]  sysvec_call_function+0x99/0xc0
[  664.106497]  </IRQ>
[  664.108602]  <TASK>
[  664.110708]  asm_sysvec_call_function+0x16/0x20
[  664.115246] RIP: 0010:cpuidle_enter_state+0xfb/0x4f0
[  664.120221] Code: c0 48 0f a3 05 16 4d 0a 01 0f 82 fb 02 00 00 31 ff e8 =
d9 32 06 ff 45 84 ff 0f 85 cb 02 00 00 e8 ab 70 18 ff fb 0f 1f 44 00 00 <45=
> 85 f6 0f 88 eb 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[  664.138966] RSP: 0018:ffffffff92e03e28 EFLAGS: 00000202
[  664.144191] RAX: 00000000002458c1 RBX: ff54c484be002f38 RCX: 00000000000=
0001f
[  664.151323] RDX: 0000000000000000 RSI: ffffffff92be36c1 RDI: ffffffff92b=
56a1e
[  664.158454] RBP: 0000000000000002 R08: 0000000000000001 R09: 00000000000=
00001
[  664.165588] R10: 0000000000000003 R11: ff1f2c6cdde34de4 R12: ffffffff930=
d0560
[  664.172719] R13: 0000009a8ea28623 R14: 0000000000000002 R15: 00000000000=
00000
[  664.179860]  ? cpuidle_enter_state+0xf5/0x4f0
[  664.184221]  cpuidle_enter+0x29/0x40
[  664.187808]  do_idle+0x231/0x290
[  664.191052]  cpu_startup_entry+0x26/0x30
[  664.194983]  rest_init+0xf1/0x190
[  664.198303]  arch_call_rest_init+0xa/0x30
[  664.202323]  start_kernel+0x8b8/0xac0
[  664.205993]  x86_64_start_reservations+0x14/0x30
[  664.210617]  x86_64_start_kernel+0x92/0xa0
[  664.214725]  secondary_startup_64_no_verify+0x184/0x18b
[  664.219965]  </TASK>
[  664.222159] irq event stamp: 2382018
[  664.225737] hardirqs last  enabled at (2382017): [<ffffffff9212dea5>] cp=
uidle_enter_state+0xf5/0x4f0
[  664.234873] hardirqs last disabled at (2382018): [<ffffffff9212b29a>] sy=
svec_call_function+0xa/0xc0
[  664.243920] softirqs last  enabled at (2382012): [<ffffffff91120705>] __=
irq_exit_rcu+0xa5/0x110
[  664.252621] softirqs last disabled at (2381797): [<ffffffff91120705>] __=
irq_exit_rcu+0xa5/0x110
[  664.261311] ---[ end trace 0000000000000000 ]---

