Return-Path: <linux-kernel+bounces-37137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311DC83ABF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AE61F21D97
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E91292D6;
	Wed, 24 Jan 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiC/MCCy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7537C0B2;
	Wed, 24 Jan 2024 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106574; cv=none; b=RccrwEXzoJ43uI7RQOnv8/IejwnfcsNV9QLe67+bIJcgcSD0d8h8DbS4pDjWan96ohP+HUJ4ynfu/DidO3sRB0zZBOzsekbCWh8aXkFbgPibkOAQ/5b/j7nKgxO8/zCeWrVTZ6bs9AVIvhO+N3Q3C5HQEofxl3mas9OYyBhv2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106574; c=relaxed/simple;
	bh=yiRheaS9gSGRAyOPZIgt6Cn9n01PdUHVYcjkvKmHKMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+pAn4pzPXGK5ynWBo4ZvlsonZy4U7KJYSHYAwbAiPecJh3c4A5ps7YuBJZ6nygMH4huVwTzD9XMCJXH4LJe1+R497bdrYntjLk0ejc8nNtBold+YpQlF7R4S5TcofdN05aM9YCHczdG96tyPuq73qUuJCHeozFk3AyYj3VoOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiC/MCCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159CCC433B2;
	Wed, 24 Jan 2024 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106574;
	bh=yiRheaS9gSGRAyOPZIgt6Cn9n01PdUHVYcjkvKmHKMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CiC/MCCy3GxxdX/l0tnM1x8BLgHVPz0HzHZZvTFTE1EixM7FZNI6Sq99iece/ZYwD
	 sFXIfUz0px5ZQQtCzBQkqpxsnfadayb1gVBHvX9w7Q67kJo7afWX7NUoD4bmn8vGEY
	 hYfXZIGijRkj3JEEAL1svS2Gn2y2ympnuqdDIZtEAC4jskJHe9mt7GTJ5d1RDzUa/j
	 /29BO0OJ6p1XMwlkijeWiC6373ktEQWsMVDq+X4hw+Y2JfuvUu3e9bfETMBATb0ePl
	 zrcEEWSLclcuek/LwADkdOQ+OyvXQSHwt7q/LnJazCEGoHlD2jZqrjs2JkeXrxY736
	 /dzuC02g6v7xQ==
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
	samitolvanen@google.com,
	heiko@sntech.de,
	greentime.hu@sifive.com,
	cleger@rivosinc.com,
	samuel.holland@sifive.com,
	guoren@kernel.org,
	namcaov@gmail.com,
	alexghiti@rivosinc.com,
	bhe@redhat.com,
	akpm@linux-foundation.org,
	chenjiahao16@huawei.com,
	bjorn@rivosinc.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 08/11] riscv: Make XIP bootable again
Date: Wed, 24 Jan 2024 09:28:51 -0500
Message-ID: <20240124142907.1283546-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142907.1283546-1-sashal@kernel.org>
References: <20240124142907.1283546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 3710ea5d160f..0097c145385f 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -88,6 +88,7 @@ relocate_enable_mmu:
 	/* Compute satp for kernel page tables, but don't load it yet */
 	srl a2, a0, PAGE_SHIFT
 	la a1, satp_mode
+	XIP_FIXUP_OFFSET a1
 	REG_L a1, 0(a1)
 	or a2, a2, a1
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0798bd861dcb..5f1921d014b1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -172,6 +172,9 @@ void __init mem_init(void)
 
 /* Limit the memory size via mem. */
 static phys_addr_t memory_limit;
+#ifdef CONFIG_XIP_KERNEL
+#define memory_limit	(*(phys_addr_t *)XIP_FIXUP(&memory_limit))
+#endif /* CONFIG_XIP_KERNEL */
 
 static int __init early_mem(char *p)
 {
@@ -950,7 +953,7 @@ static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
 	 * setup_vm_final installs the linear mapping. For 32-bit kernel, as the
 	 * kernel is mapped in the linear mapping, that makes no difference.
 	 */
-	dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
+	dtb_early_va = kernel_mapping_pa_to_va(dtb_pa);
 #endif
 
 	dtb_early_pa = dtb_pa;
@@ -1053,9 +1056,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 	kernel_map.virt_addr = KERNEL_LINK_ADDR + kernel_map.virt_offset;
-	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 
 #ifdef CONFIG_XIP_KERNEL
+	kernel_map.page_offset = PAGE_OFFSET_L3;
 	kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
 	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
@@ -1065,6 +1068,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
 #else
+	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 	kernel_map.phys_addr = (uintptr_t)(&_start);
 	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
 #endif
-- 
2.43.0


