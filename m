Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5B27AB22E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjIVMdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVMdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:33:36 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E6CC2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:33:30 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RsWs46G01z9vCF;
        Fri, 22 Sep 2023 14:33:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TROVTetYC20s; Fri, 22 Sep 2023 14:33:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RsWs45cz7z9vCC;
        Fri, 22 Sep 2023 14:33:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD4798B787;
        Fri, 22 Sep 2023 14:33:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jYfSB0-1QeqY; Fri, 22 Sep 2023 14:33:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.41])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 898558B763;
        Fri, 22 Sep 2023 14:33:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38MCXKcQ639082
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 14:33:21 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38MCXJhD639073;
        Fri, 22 Sep 2023 14:33:19 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc: Only define __parse_fpscr() when required
Date:   Fri, 22 Sep 2023 14:33:13 +0200
Message-ID: <5de2998c57f3983563b27b39228ea9a7229d4110.1695385984.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695385992; l=1324; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=kqkFpcU5+/aIs05XRui9EgavgKRFVnBzzl5hzd+0zQM=; b=AMfPBLW5FkhYq/RQTxJ+uvLiQNcmDeRTJ5CCQtyGrx953lAKR9+ttHHWR7VNCqPhEPuHg2NY2 I1D641rG18YDZ9b3fXvP7R/9CS0k8/czenjlM8TccwKdyCYWOpui/Cz
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

Clang 17 reports:

arch/powerpc/kernel/traps.c:1167:19: error: unused function '__parse_fpscr' [-Werror,-Wunused-function]

__parse_fpscr() is called from two sites. First call is guarded
by #ifdef CONFIG_PPC_FPU_REGS

Second call is guarded by CONFIG_MATH_EMULATION which selects
CONFIG_PPC_FPU_REGS.

So only define __parse_fpscr() when CONFIG_PPC_FPU_REGS is defined.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309210327.WkqSd5Bq-lkp@intel.com/
Fixes: b6254ced4da6 ("powerpc/signal: Don't manage floating point regs when no FPU")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index eeff136b83d9..a52c786c2aec 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1164,6 +1164,7 @@ void emulate_single_step(struct pt_regs *regs)
 		__single_step_exception(regs);
 }
 
+#ifdef CONFIG_PPC_FPU_REGS
 static inline int __parse_fpscr(unsigned long fpscr)
 {
 	int ret = FPE_FLTUNK;
@@ -1190,6 +1191,7 @@ static inline int __parse_fpscr(unsigned long fpscr)
 
 	return ret;
 }
+#endif
 
 static void parse_fpe(struct pt_regs *regs)
 {
-- 
2.41.0

