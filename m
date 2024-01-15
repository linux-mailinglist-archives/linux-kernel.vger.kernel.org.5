Return-Path: <linux-kernel+bounces-26577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851BA82E3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A44C1F23FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79078224CD;
	Mon, 15 Jan 2024 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrL+lkOa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842E224C9;
	Mon, 15 Jan 2024 23:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD78C433F1;
	Mon, 15 Jan 2024 23:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361257;
	bh=5yp0EWnlAhrYG5a0Bjz5GyU/T/CCzIcb1jmpsk8a7Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IrL+lkOaZHpQv5fnuC/5cFEnHqJ4OfBdyM2yn5YbRVzpKnVQxUUYVD6WKdGrSPVXT
	 IIUCuooNj/IzwxgDr2K+4SMVW+nMuQSTwMsgebtgWGdWt9jq486smJ7/pNOdMgflWi
	 GU3MbTrD+QhoJGTo0aYB8ZVSquBejSpcWLZkn6psqrEUDLtcuWBAT1tEOBkII+qozo
	 v4k7PzOPixA4fpMq3wPtQo428wnJxJrOdPk6uGLANsDL51TIpFXLHqvtmZ3UJ2st6P
	 tyKItY54o+CJ4ejK5NE5KqfhpAe3d6StaRCCSpec4E+WiPf0NWQmKwpr+DghQfadlc
	 37DM5ZcJfCEeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	christophe.leroy@csgroup.eu,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.15 07/12] powerpc/64s: Fix CONFIG_NUMA=n build due to create_section_mapping()
Date: Mon, 15 Jan 2024 18:26:52 -0500
Message-ID: <20240115232718.209642-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232718.209642-1-sashal@kernel.org>
References: <20240115232718.209642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit ede66cd22441820cbd399936bf84fdc4294bc7fa ]

With CONFIG_NUMA=n the build fails with:

  arch/powerpc/mm/book3s64/pgtable.c:275:15: error: no previous prototype for ‘create_section_mapping’ [-Werror=missing-prototypes]
  275 | int __meminit create_section_mapping(unsigned long start, unsigned long end,
      |               ^~~~~~~~~~~~~~~~~~~~~~

That happens because the prototype for create_section_mapping() is in
asm/mmzone.h, but asm/mmzone.h is only included by linux/mmzone.h
when CONFIG_NUMA=y.

In fact the prototype is only needed by arch/powerpc/mm code, so move
the prototype into arch/powerpc/mm/mmu_decl.h, which also fixes the
build error.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231129131919.2528517-5-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/mmzone.h | 5 -----
 arch/powerpc/mm/mmu_decl.h        | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 3764d3585d30..da827d2d0866 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -43,10 +43,5 @@ u64 memory_hotplug_max(void);
 #define memory_hotplug_max() memblock_end_of_DRAM()
 #endif /* CONFIG_NUMA */
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-extern int create_section_mapping(unsigned long start, unsigned long end,
-				  int nid, pgprot_t prot);
-#endif
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_MMZONE_H_ */
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index dd1cabc2ea0f..21996b9e0a64 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -190,3 +190,8 @@ static inline bool debug_pagealloc_enabled_or_kfence(void)
 {
 	return IS_ENABLED(CONFIG_KFENCE) || debug_pagealloc_enabled();
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int create_section_mapping(unsigned long start, unsigned long end,
+			   int nid, pgprot_t prot);
+#endif
-- 
2.43.0


