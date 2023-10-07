Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667B07BDF10
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376358AbjJIN0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376491AbjJINZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:25:58 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA70CA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:25:54 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4S40Cj14mDz9vBy;
        Mon,  9 Oct 2023 15:25:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Gphn4PpLowuC; Mon,  9 Oct 2023 15:25:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4S40Ch6Kpkz9vBQ;
        Mon,  9 Oct 2023 15:25:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D33CB8B794;
        Mon,  9 Oct 2023 15:25:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id O5Nkp0HQcBAB; Mon,  9 Oct 2023 15:25:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.138])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AE9738B780;
        Mon,  9 Oct 2023 15:25:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 397AkNme258256
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 7 Oct 2023 12:46:23 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 397AkMZ8258254;
        Sat, 7 Oct 2023 12:46:22 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        "Christopher M . Riedl" <cmr@bluescreens.de>
Subject: [PATCH] powerpc/code-patching: Perform hwsync in __patch_instruction() in case of failure
Date:   Sat,  7 Oct 2023 12:46:19 +0200
Message-ID: <e88b154eaf2efd9ff177d472d3411dcdec8ff4f5.1696675567.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696675578; l=1348; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=k9MOIxjlEEg3xQ6FC272ePXV8stsS7VaLfDlN1rnk+A=; b=hLdvCOgOVWYoBIXrpWrB0Ja6rVFEwwkXVLbkWv8R+Sz1AlP6QTmKgTloUS9aOavXUbUvoscOM awoz7adu5idDnnHdGzUiebX+TlKUSisFGdmc+HkXO+O3QDnoXQ2ltYO
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

Commit c28c15b6d28a ("powerpc/code-patching: Use temporary mm for
Radix MMU") added a hwsync for when __patch_instruction() fails,
we results in a quite odd unbalanced logic.

Instead of calling mb() when __patch_instruction() returns an error,
call mb() in the __patch_instruction()'s error path directly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Christopher M. Riedl <cmr@bluescreens.de>
---
 arch/powerpc/lib/code-patching.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index b00112d7ad46..7a47a871e6b8 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -38,6 +38,7 @@ static int __patch_instruction(u32 *exec_addr, ppc_inst_t instr, u32 *patch_addr
 	return 0;
 
 failed:
+	mb();  /* sync */
 	return -EPERM;
 }
 
@@ -309,10 +310,6 @@ static int __do_patch_instruction_mm(u32 *addr, ppc_inst_t instr)
 
 	err = __patch_instruction(addr, instr, patch_addr);
 
-	/* hwsync performed by __patch_instruction (sync) if successful */
-	if (err)
-		mb();  /* sync */
-
 	/* context synchronisation performed by __patch_instruction (isync or exception) */
 	stop_using_temp_mm(patching_mm, orig_mm);
 
-- 
2.41.0

