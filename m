Return-Path: <linux-kernel+bounces-63660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF318532E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F728AC60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884FF5822D;
	Tue, 13 Feb 2024 14:20:09 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DC58205
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834009; cv=none; b=NICrvHJ2uRKZXx5quFs0qt8gmKtSXyUF5FLUb8kDl1AW0Ig4V12AFx7ZtFq8mFuksMSQ8lltTGj4Pabz7wpgTQ7W5UM+cA2IemFCHUcid17BIE3F4WzCC5G7ZKz/Ri2MGGmsUNMi5W9HqveBrxYS96o96AA7YqgdDpee7JnAdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834009; c=relaxed/simple;
	bh=kv2uFLc6+Eb7crZB0DwT0EbAmO8DVB3Gjl+I/8V/mOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utJC/66ChtA5znbynSMkqdza8Ngsi2QVUoALspYfqHfRO/I07hAR0Tl+tg7muMsY5ISuBhOX8YHJhcyKM0hku/M5113qjSVrBMN80Iz2aQAyFWaw00AUP0KIY5ct0cdgUWeyh3f9EOROzjpNa+sFhs1Cn3tAFWMkfnXU+G5p3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TZ2ww1CDMz9sVS;
	Tue, 13 Feb 2024 14:58:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b1E_EeBkDSIX; Tue, 13 Feb 2024 14:58:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TZ2ww0Zntz9sB2;
	Tue, 13 Feb 2024 14:58:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F7078B77C;
	Tue, 13 Feb 2024 14:58:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id JKHH19f2aSBj; Tue, 13 Feb 2024 14:58:40 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.8])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A89BA8B77A;
	Tue, 13 Feb 2024 14:58:39 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc: Force inlining of arch_vmap_p{u/m}d_supported()
Date: Tue, 13 Feb 2024 14:58:37 +0100
Message-ID: <bbd84ad52bf377e8d3b5865a906f2dc5d99964ba.1707832677.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707832717; l=2386; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=kv2uFLc6+Eb7crZB0DwT0EbAmO8DVB3Gjl+I/8V/mOI=; b=CNnbjJVQQZei8836DNMFYQzpXNX9HGWQZ2qITCeZPH6qZb3LJxSoMNxYif7L/PhiUI63WzKR6 fS0Wc5G6o0vBgO59ZJi4YOgMdzbTJOQpDp3j0AEqa4qfFOQmbWbxZal
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

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
---
 arch/powerpc/include/asm/vmalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
index 4c69ece52a31..59ed89890c90 100644
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


