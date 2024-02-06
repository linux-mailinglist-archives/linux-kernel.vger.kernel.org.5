Return-Path: <linux-kernel+bounces-54308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282984AD8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1A51F24C02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0510B77F37;
	Tue,  6 Feb 2024 04:34:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0C77F09;
	Tue,  6 Feb 2024 04:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194052; cv=none; b=SqTJtkIU5xj7nmVjsJS5AO9gOry6AlBD3Z/aW+AnRm3UFGSec9mCJftsWUERO2UwNwx3mEBsTQbR/YjNuZUTpTjMs4pL4LI1N/zXKCYxXgdvrMdXWYiZ/ngSZPVHAvntK7Lozc33Atnzmh0Ot7j85M8OkYMtAVwC+/aTQTm9tJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194052; c=relaxed/simple;
	bh=T/0jfpTltszgcnQmvq7Rngdk9OPOW1YZyG11eq0/cX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IR2C3fLA+tU5yqzSOVAp6+rP6SoQpU5Vx2LcBwA5NH10qOTnx1ErYY9UK/4YYU2gBkBuvdjITeP7PbappU1WWPYlfHsNl83TKZgfaALSM3jO0pFcUopIUOIJKwl8wwoxL/YLJCcFwj8ABqW/m160q9Us4nzn12g789+uCH3jHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B4EC433C7;
	Tue,  6 Feb 2024 04:34:09 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH] LoongArch: Change acpi_core_pic[NR_CPUS] to acpi_core_pic[MAX_CORE_PIC]
Date: Tue,  6 Feb 2024 12:33:42 +0800
Message-ID: <20240206043342.2740197-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index b6b097bbf866..5cf59c617126 100644
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


