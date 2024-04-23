Return-Path: <linux-kernel+bounces-154800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535118AE133
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FF91F21C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77F659161;
	Tue, 23 Apr 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="GxO4pgeo"
Received: from out0-211.mail.aliyun.com (out0-211.mail.aliyun.com [140.205.0.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E25FB9A;
	Tue, 23 Apr 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865357; cv=none; b=jhkSfQ+9ILCiuTIJ8q+REPp4FIJ1QSCs8GmVqe/SmwROYs44nk2jeTBU2ZjHyJpQF1KTcL/v5mwtjvFI34yYBJjXZ+TCq1Ft/tvpVnyHcJZXB5KEI95KT7I1HE7I60GD8eS4ZmJrLWpo4oF8owa4F+6fGJneSyIs5A3Fph1ORWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865357; c=relaxed/simple;
	bh=HH2UmiPMMBGk7KoElLl+olNwdaMXD0BoL7x/bSioXAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=edHIasTZ5A39+y8MtLQxJENkIPWeGtnDOt42A1b+GPjbKxZ2hie5IMTlYr21w62Pr5lVQ8Xf/FZ0NInwhznsBfpLqw1T2N+9xV5w5DeIv6FV/jPrE97J/D5F+9OMdscvG1aYbypZjulHV5Suxi9GUr2VH50nHVAgzkHOXs/2ZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=GxO4pgeo; arc=none smtp.client-ip=140.205.0.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713865351; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZGZ0t2B2a4bviduXTVejdqN2/HaI1/q8fGUiKJDeZsI=;
	b=GxO4pgeobQJ1X1kxV8T6UpuvvQnk2QtxyJ6HxyFYUPLoteeRzraKSfokP8KikCxvjkmPaFKshgByck6uduTlylpUycYBgl+OGVQe881lks3q48UZgwTPdTokak9spsIGRTDymx4JA/RbaljGnWMhraBDYIe1WaWbF/uAmyH9ZaI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=zhubojun.zbj@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.XJPn81k_1713864399;
Received: from localhost(mailfrom:zhubojun.zbj@antgroup.com fp:SMTPD_---.XJPn81k_1713864399)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 17:26:54 +0800
From: "=?UTF-8?B?5pyx5Lyv5ZCbKOadsOmTrSk=?=" <zhubojun.zbj@antgroup.com>
To: linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	jarkko@kernel.org,
	dave.hansen@linux.intel.com
Cc:  <reinette.chatre@intel.com>,
  "=?UTF-8?B?5YiY5Y+MKOi9qeWxuSk=?=" <ls123674@antgroup.com>,
  "=?UTF-8?B?5pyx5Lyv5ZCbKOadsOmTrSk=?=" <zhubojun.zbj@antgroup.com>
Subject: [RFC PATCH 0/1] x86/sgx: Explicitly give up the CPU in EDMM's ioctl() to avoid softlockup
Date: Tue, 23 Apr 2024 17:25:49 +0800
Message-Id: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi folks,

If we run an enclave equipped with large EPC(30G or greater on my platfrom)
on the Linux with kernel preemptions disabled(by configuring
"CONFIG_PREEMPT_NONE=3Dy"), we will get the following softlockup warning=20
messages being reported in "dmesg" log:

Is it an known issue? I can get the warning messages on Linux v6.9-rc5.

The EDMM's ioctl()s (sgx_ioc_enclave_{ modify_types | restrict_permissions =
|  remove_pages})=20
interface provided by kernel support batch changing attributes of enclave's=
 EPC.
If userspace App requests kernel to handle too many EPC pages, kernel
may stuck for a long time(with preemption disabled).

The log is as follows:

------------[ cut here ]------------
[  901.101294] watchdog: BUG: soft lockup - CPU#92 stuck for 23s! [occlum-r=
un:4289]
[  901.109617] Modules linked in: veth xt_conntrack xt_MASQUERADE nf_conntr=
ack_netlink nfnetlink xfrm_user xfrm_algo iptable_nat nf_nat nf_conntrack n=
f_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_addrtype iptable_filter br_netfil=
ter bridge stp llc overlay nls_iso8859_1 intel_rapl_msr intel_rapl_common i=
ntel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit binfmt_=
misc ipmi_ssif x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm=
 crct10dif_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel sha51=
2_ssse3 sha256_ssse3 pmt_telemetry sha1_ssse3 pmt_class joydev intel_sdsi i=
nput_leds aesni_intel crypto_simd cryptd dax_hmem cxl_acpi cmdlinepart rapl=
 cxl_core ast spi_nor intel_cstate drm_shmem_helper einj mtd drm_kms_helper=
 mei_me idxd isst_if_mmio isst_if_mbox_pci isst_if_common intel_vsec idxd_b=
us mei acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_m=
eter mac_hid sch_fq_codel msr parport_pc ppdev lp parport ramoops reed_solo=
mon pstore_blk pstore_zone efi_pstore drm ip_tables x_tables
[  901.109670]  autofs4 mlx5_ib ib_uverbs ib_core hid_generic usbhid hid se=
s enclosure scsi_transport_sas mlx5_core pci_hyperv_intf mlxfw igb ahci psa=
mple i2c_algo_bit i2c_i801 spi_intel_pci xhci_pci tls megaraid_sas dca spi_=
intel crc32_pclmul i2c_smbus i2c_ismt libahci xhci_pci_renesas wmi pinctrl_=
emmitsburg
[  901.109691] CPU: 92 PID: 4289 Comm: occlum-run Not tainted 6.9.0-rc5 #3
[  901.109693] Hardware name: Inspur NF5468-M7-A0-R0-00/NF5468-M7-A0-R0-00,=
 BIOS 05.02.01 05/08/2023
[  901.109695] RIP: 0010:sgx_enclave_restrict_permissions+0xba/0x1f0
[  901.109701] Code: 48 c1 e6 05 48 89 d1 48 8d 5c 24 40 b8 0e 00 00 00 48 =
2b 8e 70 8e 15 8b 48 c1 e9 05 48 c1 e1 0c 48 03 8e 68 8e 15 8b 0f 01 cf <a9=
> 00 00 00 40 0f 85 b2 00 00 00 85 c0 0f 85 db 00 00 00 4c 89 ef
[  901.109702] RSP: 0018:ffffad0ae5d0f8c0 EFLAGS: 00000202
[  901.109704] RAX: 0000000000000000 RBX: ffffad0ae5d0f900 RCX: ffffad11dfc=
0e000
[  901.109705] RDX: ffffad2adcff81c0 RSI: 0000000000000000 RDI: ffff9a12f5f=
4f000
[  901.109706] RBP: ffffad0ae5d0f9b0 R08: 0000000000000002 R09: ffff9a1289f=
57520
[  901.109707] R10: 000000000000005d R11: 0000000000000002 R12: 00000006d8f=
f2000
[  901.109708] R13: ffff9a12f5f4f000 R14: ffffad0ae5d0fa18 R15: ffff9a12f5f=
4f020
[  901.109709] FS:  00007fb20ad1d740(0000) GS:ffff9a317fe00000(0000) knlGS:=
0000000000000000
[  901.109710] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  901.109711] CR2: 00007f8041811000 CR3: 0000000118530006 CR4: 00000000007=
70ef0
[  901.109712] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  901.109713] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[  901.109714] PKRU: 55555554
[  901.109714] Call Trace:
[  901.109716]  <IRQ>
[  901.109718]  ? show_regs+0x67/0x70
[  901.109722]  ? watchdog_timer_fn+0x1f3/0x280
[  901.109725]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  901.109727]  ? __hrtimer_run_queues+0xc8/0x220
[  901.109731]  ? hrtimer_interrupt+0x10c/0x250
[  901.109733]  ? __sysvec_apic_timer_interrupt+0x53/0x130
[  901.109736]  ? sysvec_apic_timer_interrupt+0x7b/0x90
[  901.109739]  </IRQ>
[  901.109740]  <TASK>
[  901.109740]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  901.109745]  ? sgx_enclave_restrict_permissions+0xba/0x1f0
[  901.109747]  ? aa_file_perm+0x145/0x550
[  901.109750]  sgx_ioctl+0x1ab/0x900
[  901.109751]  ? xas_find+0x84/0x200
[  901.109754]  ? sgx_enclave_etrack+0xbb/0x140
[  901.109756]  ? sgx_encl_may_map+0x19a/0x240
[  901.109758]  ? common_file_perm+0x8a/0x1b0
[  901.109760]  ? obj_cgroup_charge_pages+0xa2/0x100
[  901.109763]  ? tlb_flush_mmu+0x31/0x1c0
[  901.109766]  ? tlb_finish_mmu+0x42/0x80
[  901.109767]  ? do_mprotect_pkey+0x150/0x530
[  901.109769]  ? __fget_light+0xc0/0x100
[  901.109772]  __x64_sys_ioctl+0x95/0xd0
[  901.109775]  x64_sys_call+0x1209/0x20c0
[  901.109777]  do_syscall_64+0x6d/0x110
[  901.109779]  ? syscall_exit_to_user_mode+0x86/0x1c0
[  901.109782]  ? do_syscall_64+0x79/0x110
[  901.109783]  ? syscall_exit_to_user_mode+0x86/0x1c0
[  901.109784]  ? do_syscall_64+0x79/0x110
[  901.109785]  ? free_unref_page+0x10e/0x180
[  901.109788]  ? __do_fault+0x36/0x130
[  901.109791]  ? do_pte_missing+0x2e8/0xcc0
[  901.109792]  ? __pte_offset_map+0x1c/0x190
[  901.109795]  ? __handle_mm_fault+0x7b9/0xe60
[  901.109796]  ? __count_memcg_events+0x70/0x100
[  901.109798]  ? handle_mm_fault+0x256/0x360
[  901.109799]  ? do_user_addr_fault+0x3c1/0x860
[  901.109801]  ? irqentry_exit_to_user_mode+0x67/0x190
[  901.109803]  ? irqentry_exit+0x3b/0x50
[  901.109804]  ? exc_page_fault+0x89/0x180
[  901.109806]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  901.109807] RIP: 0033:0x7fb20b4315cb
[  901.109810] Code: 0f 1e fa 48 8b 05 c5 78 0d 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 78 0d 00 f7 d8 64 89 01 48
[  901.109811] RSP: 002b:00007ffc0e7af718 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[  901.109812] RAX: ffffffffffffffda RBX: 0000000780000000 RCX: 00007fb20b4=
315cb
[  901.109813] RDX: 00007ffc0e7af720 RSI: 00000000c028a405 RDI: 00000000000=
00005
[  901.109814] RBP: 0000000000000005 R08: 0000000000000000 R09: 00007ffc0e7=
af794
[  901.109815] R10: 00007ffc0e7af7c8 R11: 0000000000000246 R12: 00000000c02=
8a405
[  901.109815] R13: 00007ffc0e7af720 R14: 0000000780000000 R15: 00007fb20b2=
ea980
[  901.109817]  </TASK>
------------[ end trace ]------------

We suggest to give up CPU in the ioctl() handler explicitly. I have attache=
d a
patch which can fix such issue. I'm looking forward to receiving suggestions
from community regarding this patch.

Thanks for your time!

Regards,
Bojun Zhu

Bojun Zhu (1):
  x86/sgx: Explicitly give up the CPU in EDMM's ioctl() to avoid
    softlockup

 arch/x86/kernel/cpu/sgx/ioctl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--=20
2.25.1


