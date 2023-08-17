Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8C077F8D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351866AbjHQO0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351868AbjHQO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:26:10 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FF62D76
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:26:08 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RRS3g3hSxz9wrn;
        Thu, 17 Aug 2023 16:26:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KUkmeh0sFkNs; Thu, 17 Aug 2023 16:26:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RRS3g2sr1z9wrl;
        Thu, 17 Aug 2023 16:26:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F07D8B76C;
        Thu, 17 Aug 2023 16:26:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hQ_dsETZXfsT; Thu, 17 Aug 2023 16:26:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.19.54.59])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E4208B763;
        Thu, 17 Aug 2023 16:26:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37HEQ206445864
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 16:26:02 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37HEPt0q445818;
        Thu, 17 Aug 2023 16:25:55 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc/47x: Add prototype for mmu_init_secondary()
Date:   Thu, 17 Aug 2023 16:25:49 +0200
Message-ID: <e89d9927c926044e54fd056a849785f526c6414f.1692282340.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692282348; l=1005; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=y4MtXxcU/CLYY/EtZYOAASD5LB5BrZFf3sfN3Cc+IB0=; b=EiYYpSO+gQkYlnYN6efHgQZWyYz6PTS17/ghX4U8eDhBEXY/XuAExALjYn3RCfiCIHKIvzshj vNckpfsTqjLC9AvgdCVo49MKntTWmiaBGnOeVsrMHfs79NDafRL+EJA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_FAIL,SPF_HELO_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A W=1 build of 44x/iss476-smp_defconfig gives:

arch/powerpc/mm/nohash/44x.c:220:13: error: no previous prototype for 'mmu_init_secondary' [-Werror=missing-prototypes]
  220 | void __init mmu_init_secondary(int cpu)
      |             ^~~~~~~~~~~~~~~~~~

That function is called from head_4xx.S

Add a prototype in mmu_decl.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/mm/mmu_decl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index c6dccb4f06dc..7f9ff0640124 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -110,6 +110,7 @@ extern void MMU_init_hw(void);
 void MMU_init_hw_patch(void);
 unsigned long mmu_mapin_ram(unsigned long base, unsigned long top);
 #endif
+void mmu_init_secondary(int cpu);
 
 #ifdef CONFIG_PPC_E500
 extern unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx,
-- 
2.41.0

