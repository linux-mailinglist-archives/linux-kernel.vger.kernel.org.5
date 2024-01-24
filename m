Return-Path: <linux-kernel+bounces-37126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE7C83ABD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B681C211AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355D82D85;
	Wed, 24 Jan 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWkA0A7R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A57CF22;
	Wed, 24 Jan 2024 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106529; cv=none; b=neaI6lfILZgp7XbTQE/0gjIWkTeIqL3+hmenYLdRFj2typhTHbiIoLxwsvyoD+7SawLt2Fa1scF5IAiE5XUQ9VrpJzMgCq4P4ur8nrQbtnbR5fBnAu80I6cf4EfEmHJHhwDohEAQg32tHOGwLfw0MIpcK9o1NX8rV1siuOuiR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106529; c=relaxed/simple;
	bh=rl17rrrrdDpGDd/ayUegjJVsAbRli/J9OpRT36DGW8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L63DkMUf90vgZdsacioE18g6hLvDwwlc1gkJ8ekw6qGG/gl+MBLyBMBYKZrGzPfr0+TN7aLGVO8Usws+2+Sec9hcISSRo9kwkgUxYP4i1iub/BRmBJ2Tp1AkSYSWe7GKJW9xWR0s/UMo/lFLxrDWiUaXRL4Kbfwc7rPlNb4y7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWkA0A7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFE7C433C7;
	Wed, 24 Jan 2024 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106529;
	bh=rl17rrrrdDpGDd/ayUegjJVsAbRli/J9OpRT36DGW8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWkA0A7RVjrn1XzuGgIzBx89fDBGHy7Pzg7AsbUxkwP5f/jmQ9dm/SqsKWTKda6Zj
	 d950eFlSN/S38N+kuGlLrrLlJJdL+eGV111fD8qL2pTY4zpq/ZhhTRkfYyaq/jAoaA
	 yZ4n4nJmbSa+w3BNezmuWb7kt9XF/iXnmj2loPGSCscLgMFhIRPBEkRuZ7PElBI5gI
	 lMHe/6FDFo4tlIkevQ1f5P1bX16UqHmqiJ2IMF+jRJsPnfnCyPyFNlEu82pWx6aaB0
	 QYMfoCZzC1dXVRKaCV37KPoYUDp/+2oXiNTwErgAFfLQvvt2POAlMX1HO6I5gCqBl9
	 I9ReuKhOvvxaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederik Haxel <haxel@fzi.de>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	conor.dooley@microchip.com,
	andy.chiu@sifive.com,
	heiko@sntech.de,
	samitolvanen@google.com,
	greentime.hu@sifive.com,
	samuel.holland@sifive.com,
	cleger@rivosinc.com,
	guoren@kernel.org,
	namcaov@gmail.com,
	alexghiti@rivosinc.com,
	anup@brainfault.org,
	bjorn@rivosinc.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 10/13] riscv: Make XIP bootable again
Date: Wed, 24 Jan 2024 09:28:03 -0500
Message-ID: <20240124142820.1283206-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142820.1283206-1-sashal@kernel.org>
References: <20240124142820.1283206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Frederik Haxel <haxel@fzi.de>

[ Upstream commit 66f1e68093979816a23412a3fad066f5bcbc0360 ]

Currently, the XIP kernel seems to fail to boot due to missing
XIP_FIXUP and a wrong page_offset value. A superfluous XIP_FIXUP
has also been removed.

Signed-off-by: Frederik Haxel <haxel@fzi.de>
Link: https://lore.kernel.org/r/20231212130116.848530-2-haxel@fzi.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/head.S | 1 +
 arch/riscv/mm/init.c     | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 76ace1e0b46f..663881785b2b 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -89,6 +89,7 @@ relocate_enable_mmu:
 	/* Compute satp for kernel page tables, but don't load it yet */
 	srl a2, a0, PAGE_SHIFT
 	la a1, satp_mode
+	XIP_FIXUP_OFFSET a1
 	REG_L a1, 0(a1)
 	or a2, a2, a1
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2e011cbddf3a..a65937336cdc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -174,6 +174,9 @@ void __init mem_init(void)
 
 /* Limit the memory size via mem. */
 static phys_addr_t memory_limit;
+#ifdef CONFIG_XIP_KERNEL
+#define memory_limit	(*(phys_addr_t *)XIP_FIXUP(&memory_limit))
+#endif /* CONFIG_XIP_KERNEL */
 
 static int __init early_mem(char *p)
 {
@@ -952,7 +955,7 @@ static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
 	 * setup_vm_final installs the linear mapping. For 32-bit kernel, as the
 	 * kernel is mapped in the linear mapping, that makes no difference.
 	 */
-	dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
+	dtb_early_va = kernel_mapping_pa_to_va(dtb_pa);
 #endif
 
 	dtb_early_pa = dtb_pa;
@@ -1055,9 +1058,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 	kernel_map.virt_addr = KERNEL_LINK_ADDR + kernel_map.virt_offset;
-	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 
 #ifdef CONFIG_XIP_KERNEL
+	kernel_map.page_offset = PAGE_OFFSET_L3;
 	kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
 	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
@@ -1067,6 +1070,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
 #else
+	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 	kernel_map.phys_addr = (uintptr_t)(&_start);
 	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
 #endif
-- 
2.43.0


