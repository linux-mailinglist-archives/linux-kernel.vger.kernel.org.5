Return-Path: <linux-kernel+bounces-8065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D781B1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8376281A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89C64E1CF;
	Thu, 21 Dec 2023 09:03:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996274CE11;
	Thu, 21 Dec 2023 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4SwkxQ52fPz9vCB;
	Thu, 21 Dec 2023 10:03:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FKlQMyQJLnqX; Thu, 21 Dec 2023 10:03:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Swkwm32vqz9v9n;
	Thu, 21 Dec 2023 10:03:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 64C748B788;
	Thu, 21 Dec 2023 10:03:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id EZnoZuYRvcNG; Thu, 21 Dec 2023 10:03:04 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO25106.IDSI0.si.c-s.fr [192.168.232.169])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E4F228B765;
	Thu, 21 Dec 2023 10:03:03 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-modules@vger.kernel.org
Subject: [PATCH 3/3] powerpc: Simplify strict_kernel_rwx_enabled()
Date: Thu, 21 Dec 2023 10:02:48 +0100
Message-ID: <c54d7059af678e68a44f308b5b7257de1f185593.1703149011.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <7b5df1782e94a755b4a18733af44d17d8dd8b37b.1703149011.git.christophe.leroy@csgroup.eu>
References: <7b5df1782e94a755b4a18733af44d17d8dd8b37b.1703149011.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703149365; l=975; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=61tIdC869creNbvoUUZwC7sh+5NT+SZdhVBf8LQ7dmo=; b=VM3FCIwO0MJ1zMIjQiNfj86TkrOAgOPhedmsu+HpbdECtBstZmTqjVAlvXBy5YRxmlHpNeXW8 ztSK1PqCA/IB5f4La4LlLFvdZT5vzS7bceDCx4bpcXDmTR98vximFzt
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Now that rodata_enabled is always declared, remove #ifdef
and define a single version of strict_kernel_rwx_enabled().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mmu.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index d8b7e246a32f..24241995f740 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -330,17 +330,10 @@ static __always_inline bool early_radix_enabled(void)
 	return early_mmu_has_feature(MMU_FTR_TYPE_RADIX);
 }
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
 static inline bool strict_kernel_rwx_enabled(void)
 {
-	return rodata_enabled;
+	return IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) && rodata_enabled;
 }
-#else
-static inline bool strict_kernel_rwx_enabled(void)
-{
-	return false;
-}
-#endif
 
 static inline bool strict_module_rwx_enabled(void)
 {
-- 
2.41.0


