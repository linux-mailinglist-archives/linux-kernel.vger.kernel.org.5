Return-Path: <linux-kernel+bounces-45700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9B2843458
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D2C1F2631D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD10101C5;
	Wed, 31 Jan 2024 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pnoxswJV"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB0FBEA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670452; cv=none; b=FUjxI/nCPJ+p6q/+Feej2WCcMKd9tYKnMRiQOdVG89Wos6/1ry/3XH4wOaGxNwihWf2ZLghTa5FTL/iV1mF7MUTxLy7MV4WQdtHMobWBAWe2AAEHrduPporNbsWRxvhLO9nHtphYJ2GvpZ378LXGTTh4BrxsZhL4XmfxN+kPk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670452; c=relaxed/simple;
	bh=wGptIHszJhPa5ileBViBX/mcYWc779L3JP1n3pvT/c0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=glUu1vg3raxfHhNksdxx3Mj9QHKRJ5JhRcLNHKCK0RLvNuDA1GONKTauiWY+Ag0QLZwZETeMbVaVB3FF1ZrA7awmh17oBggpjgcLs18OrXHzIUNN89qWpi4wtMhuxGefq7thrQA2FYVz+VG4Cbn8cFHaZanOb241tXvwUgwVSbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pnoxswJV; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706670447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNpTT/WqMYE/kMlEau8F0K6s+byKh41jM8d3ijxTy+U=;
	b=pnoxswJVQxLXXKjgabA/iWqVs55dd1FIBzgFJZkrFqruLK6cJ93egcuzxTj86u1a4YNGwc
	N6RFFZZPkByRzNX+DvNBJPZxhiaHlumPSevDx48S0D+6Uzm6qIInKeeZPtT3lLTKpLW+jf
	OcDJOrb1g8fqXEAQghRBQLsoMx2S00c=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] fs,hugetlb: Fix NULL pointer dereference in
 hugetlbs_fill_super
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240130210418.3771-1-osalvador@suse.de>
Date: Wed, 31 Jan 2024 11:06:43 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Michal Hocko <mhocko@suse.com>,
 David Howells <dhowells@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C57651FA-D3E4-4B18-83F1-6BFDA70260A5@linux.dev>
References: <20240130210418.3771-1-osalvador@suse.de>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On Jan 31, 2024, at 05:04, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> When configuring a hugetlb filesystem via the fsconfig() syscall, =
there is a
> possible NULL dereference in hugetlbfs_fill_super() caused by =
assigning
> NULL to ctx->hstate in hugetlbfs_parse_param() when the requested =
pagesize
> is non valid.
>=20
> E.g: Taking the following steps:
>=20
>     fd =3D fsopen("hugetlbfs", FSOPEN_CLOEXEC);
>     fsconfig(fd, FSCONFIG_SET_STRING, "pagesize", "1024", 0);
>     fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
>=20
> Given that the requested "pagesize" is invalid, ctxt->hstate will be =
replaced
> with NULL, losing its previous value, and we will print an error:
>=20
> ...
> ...
> case Opt_pagesize:
> ps =3D memparse(param->string, &rest);
> ctx->hstate =3D h;
> if (!ctx->hstate) {
>         pr_err("Unsupported page size %lu MB\n", ps / SZ_1M);
>         return -EINVAL;
> }
> return 0;
> ...
> ...
>=20
> This is a problem because later on, we will dereference ctxt->hstate =
in
> hugetlbfs_fill_super()
>=20
> ...
> ...
> sb->s_blocksize =3D huge_page_size(ctx->hstate);
> ...
> ...
>=20
> Causing below Oops.
>=20
> Fix this by replacing cxt->hstate value only when then pagesize is =
known to be valid.
>=20
> kernel: hugetlbfs: Unsupported page size 0 MB
> kernel: BUG: kernel NULL pointer dereference, address: =
0000000000000028
> kernel: #PF: supervisor read access in kernel mode
> kernel: #PF: error_code(0x0000) - not-present page
> kernel: PGD 800000010f66c067 P4D 800000010f66c067 PUD 1b22f8067 PMD 0
> kernel: Oops: 0000 [#1] PREEMPT SMP PTI
> kernel: CPU: 4 PID: 5659 Comm: syscall Tainted: G            E      =
6.8.0-rc2-default+ #22 5a47c3fef76212addcc6eb71344aabc35190ae8f
> kernel: Hardware name: Intel Corp. GROVEPORT/GROVEPORT, BIOS =
GVPRCRB1.86B.0016.D04.1705030402 05/03/2017
> kernel: RIP: 0010:hugetlbfs_fill_super+0xb4/0x1a0
> kernel: Code: 48 8b 3b e8 3e c6 ed ff 48 85 c0 48 89 45 20 0f 84 d6 00 =
00 00 48 b8 ff ff ff ff ff ff ff 7f 4c 89 e7 49 89 44 24 20 48 8b 03 =
<8b> 48 28 b8 00 10 00 00 48 d3 e0 49 89 44 24 18 48 8b 03 8b 40 28
> kernel: RSP: 0018:ffffbe9960fcbd48 EFLAGS: 00010246
> kernel: RAX: 0000000000000000 RBX: ffff9af5272ae780 RCX: =
0000000000372004
> kernel: RDX: ffffffffffffffff RSI: ffffffffffffffff RDI: =
ffff9af555e9b000
> kernel: RBP: ffff9af52ee66b00 R08: 0000000000000040 R09: =
0000000000370004
> kernel: R10: ffffbe9960fcbd48 R11: 0000000000000040 R12: =
ffff9af555e9b000
> kernel: R13: ffffffffa66b86c0 R14: ffff9af507d2f400 R15: =
ffff9af507d2f400
> kernel: FS:  00007ffbc0ba4740(0000) GS:ffff9b0bd7000000(0000) =
knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000000028 CR3: 00000001b1ee0000 CR4: =
00000000001506f0
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  ? __die_body+0x1a/0x60
> kernel:  ? page_fault_oops+0x16f/0x4a0
> kernel:  ? search_bpf_extables+0x65/0x70
> kernel:  ? fixup_exception+0x22/0x310
> kernel:  ? exc_page_fault+0x69/0x150
> kernel:  ? asm_exc_page_fault+0x22/0x30
> kernel:  ? __pfx_hugetlbfs_fill_super+0x10/0x10
> kernel:  ? hugetlbfs_fill_super+0xb4/0x1a0
> kernel:  ? hugetlbfs_fill_super+0x28/0x1a0
> kernel:  ? __pfx_hugetlbfs_fill_super+0x10/0x10
> kernel:  vfs_get_super+0x40/0xa0
> kernel:  ? __pfx_bpf_lsm_capable+0x10/0x10
> kernel:  vfs_get_tree+0x25/0xd0
> kernel:  vfs_cmd_create+0x64/0xe0
> kernel:  __x64_sys_fsconfig+0x395/0x410
> kernel:  do_syscall_64+0x80/0x160
> kernel:  ? syscall_exit_to_user_mode+0x82/0x240
> kernel:  ? do_syscall_64+0x8d/0x160
> kernel:  ? syscall_exit_to_user_mode+0x82/0x240
> kernel:  ? do_syscall_64+0x8d/0x160
> kernel:  ? exc_page_fault+0x69/0x150
> kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> kernel: RIP: 0033:0x7ffbc0cb87c9
> kernel: Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 =
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 =
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 96 0d 00 f7 d8 64 89 01 48
> kernel: RSP: 002b:00007ffc29d2f388 EFLAGS: 00000206 ORIG_RAX: =
00000000000001af
> kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: =
00007ffbc0cb87c9
> kernel: RDX: 0000000000000000 RSI: 0000000000000006 RDI: =
0000000000000003
> kernel: RBP: 00007ffc29d2f3b0 R08: 0000000000000000 R09: =
0000000000000000
> kernel: R10: 0000000000000000 R11: 0000000000000206 R12: =
0000000000000000
> kernel: R13: 00007ffc29d2f4c0 R14: 0000000000000000 R15: =
0000000000000000
> kernel:  </TASK>
> kernel: Modules linked in: rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) =
dns_resolver(E) nfs(E) lockd(E) grace(E) sunrpc(E) netfs(E) af_packet(E) =
bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) =
intel_rapl_msr(E) intel_rapl_common(E) iTCO_wdt(E) intel_pmc_bxt(E) =
sb_edac(E) iTCO_vendor_support(E) x86_pkg_temp_thermal(E) =
intel_powerclamp(E) coretemp(E) kvm_intel(E) rfkill(E) ipmi_ssif(E) =
kvm(E) acpi_ipmi(E) irqbypass(E) pcspkr(E) igb(E) ipmi_si(E) mei_me(E) =
i2c_i801(E) joydev(E) intel_pch_thermal(E) i2c_smbus(E) dca(E) =
lpc_ich(E) mei(E) ipmi_devintf(E) ipmi_msghandler(E) acpi_pad(E) =
tiny_power_button(E) button(E) fuse(E) efi_pstore(E) configfs(E) =
ip_tables(E) x_tables(E) ext4(E) mbcache(E) jbd2(E) hid_generic(E) =
usbhid(E) sd_mod(E) t10_pi(E) crct10dif_pclmul(E) crc32_pclmul(E) =
crc32c_intel(E) polyval_clmulni(E) ahci(E) xhci_pci(E) =
polyval_generic(E) gf128mul(E) ghash_clmulni_intel(E) sha512_ssse3(E) =
sha256_ssse3(E) xhci_pci_renesas(E) libahci(E) ehci_pci(E) sha1_ssse3(E) =
xhci_hcd(E) ehci_hcd(E) libata(E)
> kernel:  mgag200(E) i2c_algo_bit(E) usbcore(E) wmi(E) sg(E) =
dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) =
scsi_mod(E) scsi_common(E) aesni_intel(E) crypto_simd(E) cryptd(E)
> kernel: Unloaded tainted modules: acpi_cpufreq(E):1 fjes(E):1
> kernel: CR2: 0000000000000028
> kernel: ---[ end trace 0000000000000000 ]---
> kernel: RIP: 0010:hugetlbfs_fill_super+0xb4/0x1a0
> kernel: Code: 48 8b 3b e8 3e c6 ed ff 48 85 c0 48 89 45 20 0f 84 d6 00 =
00 00 48 b8 ff ff ff ff ff ff ff 7f 4c 89 e7 49 89 44 24 20 48 8b 03 =
<8b> 48 28 b8 00 10 00 00 48 d3 e0 49 89 44 24 18 48 8b 03 8b 40 28
> kernel: RSP: 0018:ffffbe9960fcbd48 EFLAGS: 00010246
> kernel: RAX: 0000000000000000 RBX: ffff9af5272ae780 RCX: =
0000000000372004
> kernel: RDX: ffffffffffffffff RSI: ffffffffffffffff RDI: =
ffff9af555e9b000
> kernel: RBP: ffff9af52ee66b00 R08: 0000000000000040 R09: =
0000000000370004
> kernel: R10: ffffbe9960fcbd48 R11: 0000000000000040 R12: =
ffff9af555e9b000
> kernel: R13: ffffffffa66b86c0 R14: ffff9af507d2f400 R15: =
ffff9af507d2f400
> kernel: FS:  00007ffbc0ba4740(0000) GS:ffff9b0bd7000000(0000) =
knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000000028 CR3: 00000001b1ee0000 CR4: =
00000000001506f0
>=20
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Thanks for your fix.

Acked-by: Muchun Song <muchun.song@linux.dev>



