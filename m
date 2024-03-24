Return-Path: <linux-kernel+bounces-114308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE48889B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00851C20B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9942C58106;
	Sun, 24 Mar 2024 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kefrF0Z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36113A896;
	Sun, 24 Mar 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321686; cv=none; b=RHY/KoK4FoLIwT18pIbf8TTKJ+SuU5wHTNGkLX3ajd+LpTHX5f7Wyl6RjvmyngrkjaaKQva/89cFxLiDfOXdHei/Z3ShyFAuzZuQrqb6Mkt1oq4JqkHrZBXNqSBZBiP1uRqSpDVEczTX3j4VDrcce6tj4T+pEo03Tcr+N5mW8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321686; c=relaxed/simple;
	bh=+PUu5RM10hKszLtQ9PhN2GrdWiBPvEkFSKTRdD/60jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVLObqkWdDCm6okfDJBC8RjJXpCaPT38nn79IUPECG4Ulc5dODCktNJCAco3JoiUtkwKnYoUYpG+U+fLhwdMao21sZxVGtosIy2z5M1DTIMvNLn/5/gJ+lAdKHSvPIgO85bK60wy4DQ39PJZQVz9rbNt2S5VQbAQJ0w39mX5W/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kefrF0Z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80438C43394;
	Sun, 24 Mar 2024 23:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321685;
	bh=+PUu5RM10hKszLtQ9PhN2GrdWiBPvEkFSKTRdD/60jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kefrF0Z8eeG4mtigTo/6idbTySJgnpHXDRH92Dhyb7Qq68RlGSXOLOcv8J5qzq5gY
	 fC/nxssmTEJA+hGEXj1h+KlQ2oPTSAzE/zePlsEynD1bYSLd5MF8lzQLxAZ8w4suER
	 P9n4mE3KbHdt/j08KUKK0gvn0DWrBeDvHWcYW6dWtqd6yzLxlZPj0+73CywLXJOIGa
	 nasqMZSNE3HI9BFXTvkiMv05x3ygCtBOdshw8uI+ICA2cqYs72gFpdahcPxdHFc68S
	 cgkxW3851tpHdZ8iCccdVB1rJsxewrXHsZ62SCrUhAUPmM1jJtqBK9qzaHUlt5w/ZW
	 qydfb7JjJSQPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	kernel test robot <lkp@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 413/638] powerpc: Force inlining of arch_vmap_p{u/m}d_supported()
Date: Sun, 24 Mar 2024 18:57:30 -0400
Message-ID: <20240324230116.1348576-414-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit c5aebb53b32460bc52680dd4e2a2f6b84d5ea521 ]

arch_vmap_pud_supported() and arch_vmap_pmd_supported() are
expected to constant-fold to false when RADIX is not enabled.

Force inlining in order to avoid following failure which
leads to unexpected call of non-existing pud_set_huge() and
pmd_set_huge() on powerpc 8xx.

In function 'pud_huge_tests',
    inlined from 'debug_vm_pgtable' at mm/debug_vm_pgtable.c:1399:2:
/arch/powerpc/include/asm/vmalloc.h:9:33: warning: inlining failed in call to 'arch_vmap_pud_supported.isra': call is unlikely and code size would grow [-Winline]
    9 | #define arch_vmap_pud_supported arch_vmap_pud_supported
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~
/arch/powerpc/include/asm/vmalloc.h:10:20: note: in expansion of macro 'arch_vmap_pud_supported'
   10 | static inline bool arch_vmap_pud_supported(pgprot_t prot)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~
/arch/powerpc/include/asm/vmalloc.h:9:33: note: called from here
    9 | #define arch_vmap_pud_supported arch_vmap_pud_supported
mm/debug_vm_pgtable.c:458:14: note: in expansion of macro 'arch_vmap_pud_supported'
  458 |         if (!arch_vmap_pud_supported(args->page_prot) ||
      |              ^~~~~~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402131836.OU1TDuoi-lkp@intel.com/
Fixes: 8309c9d71702 ("powerpc: inline huge vmap supported functions")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/bbd84ad52bf377e8d3b5865a906f2dc5d99964ba.1707832677.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/vmalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
index 4c69ece52a31e..59ed89890c902 100644
--- a/arch/powerpc/include/asm/vmalloc.h
+++ b/arch/powerpc/include/asm/vmalloc.h
@@ -7,14 +7,14 @@
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 
 #define arch_vmap_pud_supported arch_vmap_pud_supported
-static inline bool arch_vmap_pud_supported(pgprot_t prot)
+static __always_inline bool arch_vmap_pud_supported(pgprot_t prot)
 {
 	/* HPT does not cope with large pages in the vmalloc area */
 	return radix_enabled();
 }
 
 #define arch_vmap_pmd_supported arch_vmap_pmd_supported
-static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+static __always_inline bool arch_vmap_pmd_supported(pgprot_t prot)
 {
 	return radix_enabled();
 }
-- 
2.43.0


