Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2AF7839C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjHVGPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjHVGPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:15:50 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789111C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:15:46 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RVJxY10WMz9vw7;
        Tue, 22 Aug 2023 08:15:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UfYttzXdVmqA; Tue, 22 Aug 2023 08:15:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RVJxY0Md1z9vw6;
        Tue, 22 Aug 2023 08:15:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 08C038B779;
        Tue, 22 Aug 2023 08:15:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id S6PYw4i-Ct8A; Tue, 22 Aug 2023 08:15:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.234.16])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C67EA8B766;
        Tue, 22 Aug 2023 08:15:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37M67tfv824938
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 08:07:55 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37M67sLQ824905;
        Tue, 22 Aug 2023 08:07:54 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc/64e: Fix circular dependency with CONFIG_SMP disabled
Date:   Tue, 22 Aug 2023 08:07:50 +0200
Message-ID: <5e0f97d5cbcd05238b56b4424ab096468296824d.1692684461.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692684469; l=1823; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=cN7ysd0pEuTs9KetlOtchuamoQatSbRcFDq/YjZFQrM=; b=fqXeKHRuVI0KcphSDM0XEiLbGBkTtTQ4BrmIoMXVDZOAiUCIGv6E/KRXSAyhNPzSb+ZB36E99 AOvESC6Oo0ABaVQCfiHt/xo2cGR4/ZRV0sC1i8ZwzVI+ETch1cyfgNB
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/percpu.h includes asm/paca.h which needs struct tlb_core_data
which is defined in mmu-e500.h

asm/percpu.h is included from asm/mmu.h in a #ifdef CONFIG_E500
before the inclusion of mmu-e500.h

To fix that, move the inclusion of asm/percpu.h into mmu-e500.h
after the definition of struct tlb_core_data

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308220708.nRf5AUAe-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202308220857.uFq2oAxM-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202308221055.lw3UzJIL-lkp@intel.com/
Fixes: 3a24ea0df83e ("powerpc/kuap: Use ASM feature fixups instead of static branches")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mmu.h             | 5 -----
 arch/powerpc/include/asm/nohash/mmu-e500.h | 3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 82af2e2c5eca..52cc25864a1b 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -144,11 +144,6 @@
 
 typedef pte_t *pgtable_t;
 
-#ifdef CONFIG_PPC_E500
-#include <asm/percpu.h>
-DECLARE_PER_CPU(int, next_tlbcam_idx);
-#endif
-
 enum {
 	MMU_FTRS_POSSIBLE =
 #if defined(CONFIG_PPC_BOOK3S_604)
diff --git a/arch/powerpc/include/asm/nohash/mmu-e500.h b/arch/powerpc/include/asm/nohash/mmu-e500.h
index e43a418d3ccd..6ddced0415cb 100644
--- a/arch/powerpc/include/asm/nohash/mmu-e500.h
+++ b/arch/powerpc/include/asm/nohash/mmu-e500.h
@@ -319,6 +319,9 @@ extern int book3e_htw_mode;
 
 #endif
 
+#include <asm/percpu.h>
+DECLARE_PER_CPU(int, next_tlbcam_idx);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_MMU_BOOK3E_H_ */
-- 
2.41.0

