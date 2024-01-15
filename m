Return-Path: <linux-kernel+bounces-26595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133D82E3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E51C283C99
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B80A1CAA0;
	Mon, 15 Jan 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUIxx/LO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519524B49;
	Mon, 15 Jan 2024 23:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9C7C43390;
	Mon, 15 Jan 2024 23:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361353;
	bh=vFh8jvKFzRE0JyxxMJmWAr2ocLHhnFn3NKZvxgUFWrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUIxx/LOt/w/n3Vv9Yw3nb5ur5CxydaOFVBIZS3TuSF3zPGbH/tQNF3xIaHLXzcMR
	 UdmbCtl9TztSD28YY5mcNOZW0zc3up/Ee+ls1jKnMDzbWAMLZyuXKoSKoYvhdtXu6r
	 2yIIrJe7+Iq/wAYSzcMFfBgeHvvXy1PKsHTQHcp2gNiwheGyovTuG6ySNH2S5zMgNB
	 Q+U2f9fJQ/62A1bF90BE8qQzH0wiKdbNVX0yklJbUtjUJKLDLmxkGGGTwlOkxJa3ML
	 Jd1E5yivp5cYdEmQDh4XIlBmWfNJb0uDqAZClllFH/fq4qd3K3+ejAta+fPCKXKMY0
	 GIXjdFcd6/RHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	christophe.leroy@csgroup.eu,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 3/7] powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()
Date: Mon, 15 Jan 2024 18:28:48 -0500
Message-ID: <20240115232905.210324-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232905.210324-1-sashal@kernel.org>
References: <20240115232905.210324-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit d8c3f243d4db24675b653f0568bb65dae34e6455 ]

With NUMA=n and FA_DUMP=y or PRESERVE_FA_DUMP=y the build fails with:

  arch/powerpc/kernel/fadump.c:1739:22: error: no previous prototype for ‘arch_reserved_kernel_pages’ [-Werror=missing-prototypes]
  1739 | unsigned long __init arch_reserved_kernel_pages(void)
       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~

The prototype for arch_reserved_kernel_pages() is in include/linux/mm.h,
but it's guarded by __HAVE_ARCH_RESERVED_KERNEL_PAGES. The powerpc
headers define __HAVE_ARCH_RESERVED_KERNEL_PAGES in asm/mmzone.h, which
is not included into the generic headers when NUMA=n.

Move the definition of __HAVE_ARCH_RESERVED_KERNEL_PAGES into asm/mmu.h
which is included regardless of NUMA=n.

Additionally the ifdef around __HAVE_ARCH_RESERVED_KERNEL_PAGES needs to
also check for CONFIG_PRESERVE_FA_DUMP.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231130114433.3053544-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/mmu.h    | 4 ++++
 arch/powerpc/include/asm/mmzone.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 0699cfeeb8c9..2141ae7441a9 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -375,5 +375,9 @@ extern void *abatron_pteptrs[2];
 #include <asm/nohash/mmu.h>
 #endif
 
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
+#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 91c69ff53a8a..50c2198c2c76 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -42,9 +42,6 @@ u64 memory_hotplug_max(void);
 #else
 #define memory_hotplug_max() memblock_end_of_DRAM()
 #endif /* CONFIG_NEED_MULTIPLE_NODES */
-#ifdef CONFIG_FA_DUMP
-#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
-#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_MMZONE_H_ */
-- 
2.43.0


