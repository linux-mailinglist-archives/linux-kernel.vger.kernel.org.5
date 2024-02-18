Return-Path: <linux-kernel+bounces-70425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A42285978F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC761F2160B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED476BFDB;
	Sun, 18 Feb 2024 15:14:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A066BFC7;
	Sun, 18 Feb 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708269268; cv=none; b=t3AiYMaMkyk7r4yGSTihp47nRhSZUSdsYH8gZdpX/pQ7JUN/Ooy0eHqKVw/W5CPU09tWnJfsZ3D6bkO40S0tRYMhZza6KHyC+6FxiUN3FBr/RR5IDAh6NVksK3gCptjpYrEMGH79ZGovvnLhkOfBeJCrm5PjQ+pOF7BuQZ/bOf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708269268; c=relaxed/simple;
	bh=7ND1cr7GPflsn+fS87oYZAJbbZxVUvL0DV2PFVsYsnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ls7yawe1zQJ9nZ7kWaRNn+5mtlgx/prp8rQzPkTaf4OnBU1Vzw1tUqU/n1WmE2MXAvZm/+Bj5+/FuP/G+69uhqSUJTjofSgSKQltfZAz8EPdbnYeIO8WPN3t4u3WCFm1Q922Tm8OANEf/aGGQQsr4ju0826axoMAYqleuRK5vnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698DEC433C7;
	Sun, 18 Feb 2024 15:14:25 +0000 (UTC)
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
	Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH] LoongArch: Call early_init_fdt_scan_reserved_mem() earlier
Date: Sun, 18 Feb 2024 23:14:03 +0800
Message-ID: <20240218151403.2206980-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unflatten_and_copy_device_tree() function contains a call to
memblock_alloc(). This means that memblock is allocating memory before
any of the reserved memory regions are set aside in the arch_mem_init()
function which calls early_init_fdt_scan_reserved_mem(). Therefore,
there is a possibility for memblock to allocate from any of the
reserved memory regions.

Hence, move the call to early_init_fdt_scan_reserved_mem() to be earlier
in the init sequence, so that the reserved memory regions are set aside
before any allocations are done using memblock.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index edf2bba80130..634ef17fd38b 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -357,6 +357,8 @@ void __init platform_init(void)
 	acpi_gbl_use_default_register_widths = false;
 	acpi_boot_table_init();
 #endif
+
+	early_init_fdt_scan_reserved_mem();
 	unflatten_and_copy_device_tree();
 
 #ifdef CONFIG_NUMA
@@ -390,8 +392,6 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	check_kernel_sections_mem();
 
-	early_init_fdt_scan_reserved_mem();
-
 	/*
 	 * In order to reduce the possibility of kernel panic when failed to
 	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
-- 
2.43.0


