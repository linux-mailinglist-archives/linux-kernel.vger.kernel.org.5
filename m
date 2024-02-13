Return-Path: <linux-kernel+bounces-62666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BD485242C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBE51C236E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BCB6310E;
	Tue, 13 Feb 2024 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU9BZrW3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFF6310B;
	Tue, 13 Feb 2024 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783705; cv=none; b=imsve1BKbBKTNtwgQLNzx+bysh5tQ2PRwQYFl16m3XeKhh9cZQqMbRreLvgNjS+2X7llpEjcGqNe8sTJOiJrePfwYnYm9LhuBPtXIvLoBczdYawBhqcF0AQNZIEuXK5ntV3woNksADP+/cqQcMLy2t9k3KDN5cmlDC8A4VEVdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783705; c=relaxed/simple;
	bh=DWkePK0Xam2qaULRVXpWh2OPl3w9W9RNKkmK0YBdDqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+y2EpOnVt4jX5k42Igsl4xRxOIOPltt7F9Nm9glE51E+pvAzLHSiTr8Yn1C+1OQ1Fm1BfmBe2yBQaPUbSVHWT9tJVZfWent38tmUlIvmhS6U+VzIX/JOX2x7Nl0fjVxj2bGcEr5AzJkvE44r+QZUXkiMU0hF7FSiVjlgez9isk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU9BZrW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04877C433C7;
	Tue, 13 Feb 2024 00:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783705;
	bh=DWkePK0Xam2qaULRVXpWh2OPl3w9W9RNKkmK0YBdDqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oU9BZrW33g/bvBWkyvRfT4cDDGuwrjaXGu3T2fd3RXKyyyrRkit+UO1qo/9G8nOnl
	 Oup9UQRWJpFdGQIxgO8imHAgzwy/uY3VewQvRHukRp6rO5S8QsfIRDCkVUJ7Z7zBnE
	 Di0IvMcRjLKeMRYi67aSqq4GVl6h2YkCM3LxHhUPPPtsDPAHy2uv2hRIaujXKsh3Gk
	 WHvLoHWxyXi+DhPU8FChFoQjSCUmUTxZTeFlck5PBE/yY+naInCHWUlC6RM1mOlrqY
	 4kKDAfCUH/Wkengnpw4nWDG1JdGFlXBpE41VnhTGn6Y4/3QEmiqd/RqTlzf9xXRRwx
	 uPN4QJeloQVcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	git@xen0n.name,
	zhuyinbo@loongson.cn,
	wangliupu@loongson.cn,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 35/51] LoongArch: Change acpi_core_pic[NR_CPUS] to acpi_core_pic[MAX_CORE_PIC]
Date: Mon, 12 Feb 2024 19:20:12 -0500
Message-ID: <20240213002052.670571-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 4551b30525cf3d2f026b92401ffe241eb04dfebe ]

With default config, the value of NR_CPUS is 64. When HW platform has
more then 64 cpus, system will crash on these platforms. MAX_CORE_PIC
is the maximum cpu number in MADT table (max physical number) which can
exceed the supported maximum cpu number (NR_CPUS, max logical number),
but kernel should not crash. Kernel should boot cpus with NR_CPUS, let
the remainder cpus stay in BIOS.

The potential crash reason is that the array acpi_core_pic[NR_CPUS] can
be overflowed when parsing MADT table, and it is obvious that CORE_PIC
should be corresponding to physical core rather than logical core, so it
is better to define the array as acpi_core_pic[MAX_CORE_PIC].

With the patch, system can boot up 64 vcpus with qemu parameter -smp 128,
otherwise system will crash with the following message.

[    0.000000] CPU 0 Unable to handle kernel paging request at virtual address 0000420000004259, era == 90000000037a5f0c, ra == 90000000037a46ec
[    0.000000] Oops[#1]:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-rc2+ #192
[    0.000000] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
[    0.000000] pc 90000000037a5f0c ra 90000000037a46ec tp 9000000003c90000 sp 9000000003c93d60
[    0.000000] a0 0000000000000019 a1 9000000003d93bc0 a2 0000000000000000 a3 9000000003c93bd8
[    0.000000] a4 9000000003c93a74 a5 9000000083c93a67 a6 9000000003c938f0 a7 0000000000000005
[    0.000000] t0 0000420000004201 t1 0000000000000000 t2 0000000000000001 t3 0000000000000001
[    0.000000] t4 0000000000000003 t5 0000000000000000 t6 0000000000000030 t7 0000000000000063
[    0.000000] t8 0000000000000014 u0 ffffffffffffffff s9 0000000000000000 s0 9000000003caee98
[    0.000000] s1 90000000041b0480 s2 9000000003c93da0 s3 9000000003c93d98 s4 9000000003c93d90
[    0.000000] s5 9000000003caa000 s6 000000000a7fd000 s7 000000000f556b60 s8 000000000e0a4330
[    0.000000]    ra: 90000000037a46ec platform_init+0x214/0x250
[    0.000000]   ERA: 90000000037a5f0c efi_runtime_init+0x30/0x94
[    0.000000]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[    0.000000]  PRMD: 00000000 (PPLV0 -PIE -PWE)
[    0.000000]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[    0.000000]  ECFG: 00070800 (LIE=11 VS=7)
[    0.000000] ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
[    0.000000]  BADV: 0000420000004259
[    0.000000]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
[    0.000000] Modules linked in:
[    0.000000] Process swapper (pid: 0, threadinfo=(____ptrval____), task=(____ptrval____))
[    0.000000] Stack : 9000000003c93a14 9000000003800898 90000000041844f8 90000000037a46ec
[    0.000000]         000000000a7fd000 0000000008290000 0000000000000000 0000000000000000
[    0.000000]         0000000000000000 0000000000000000 00000000019d8000 000000000f556b60
[    0.000000]         000000000a7fd000 000000000f556b08 9000000003ca7700 9000000003800000
[    0.000000]         9000000003c93e50 9000000003800898 9000000003800108 90000000037a484c
[    0.000000]         000000000e0a4330 000000000f556b60 000000000a7fd000 000000000f556b08
[    0.000000]         9000000003ca7700 9000000004184000 0000000000200000 000000000e02b018
[    0.000000]         000000000a7fd000 90000000037a0790 9000000003800108 0000000000000000
[    0.000000]         0000000000000000 000000000e0a4330 000000000f556b60 000000000a7fd000
[    0.000000]         000000000f556b08 000000000eaae298 000000000eaa5040 0000000000200000
[    0.000000]         ...
[    0.000000] Call Trace:
[    0.000000] [<90000000037a5f0c>] efi_runtime_init+0x30/0x94
[    0.000000] [<90000000037a46ec>] platform_init+0x214/0x250
[    0.000000] [<90000000037a484c>] setup_arch+0x124/0x45c
[    0.000000] [<90000000037a0790>] start_kernel+0x90/0x670
[    0.000000] [<900000000378b0d8>] kernel_entry+0xd8/0xdc

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/acpi.h | 4 +++-
 arch/loongarch/kernel/acpi.c      | 4 +---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 8de6c4b83a61..49e29b29996f 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -32,8 +32,10 @@ static inline bool acpi_has_cpu_in_madt(void)
 	return true;
 }
 
+#define MAX_CORE_PIC 256
+
 extern struct list_head acpi_wakeup_device_list;
-extern struct acpi_madt_core_pic acpi_core_pic[NR_CPUS];
+extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
 
 extern int __init parse_acpi_topology(void);
 
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 8e00a754e548..55d6a48c76a8 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -29,11 +29,9 @@ int disabled_cpus;
 
 u64 acpi_saved_sp;
 
-#define MAX_CORE_PIC 256
-
 #define PREFIX			"ACPI: "
 
-struct acpi_madt_core_pic acpi_core_pic[NR_CPUS];
+struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
 
 void __init __iomem * __acpi_map_table(unsigned long phys, unsigned long size)
 {
-- 
2.43.0


