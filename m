Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A005781007
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378515AbjHRQOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378540AbjHRQN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:13:58 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE513C22
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:13:54 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RS6PX19G4z9vbf;
        Fri, 18 Aug 2023 18:13:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mr8JbmkwvXuM; Fri, 18 Aug 2023 18:13:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RS6PX0Rhfz9vbb;
        Fri, 18 Aug 2023 18:13:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B5CB8B76D;
        Fri, 18 Aug 2023 18:13:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id V6WLQT1FsPtw; Fri, 18 Aug 2023 18:13:51 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (PO17626.IDSI0.si.c-s.fr [172.19.54.29])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BE9B58B76C;
        Fri, 18 Aug 2023 18:13:51 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37IGDefs139533
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 18:13:40 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37IGDeGo139532;
        Fri, 18 Aug 2023 18:13:40 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Russell Currey <ruscur@russell.cc>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/2] powerpc/8xx: Honor execonly protection
Date:   Fri, 18 Aug 2023 18:13:27 +0200
Message-ID: <602dcac64428b91b1b11e0bb730e2455ff1fb688.1692375190.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <227e23622d4778c342d072541ad2416aea5ab44e.1692375190.git.christophe.leroy@csgroup.eu>
References: <227e23622d4778c342d072541ad2416aea5ab44e.1692375190.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692375205; l=1026; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=2rfl+yqmRc5MQ1yinQnNfbAsbCr55ZSojtTJwdSH9tw=; b=u6Pl/ROSjUzdFiIH/CYD4i5GoEZS0AfhI5NcocxUllCJh8EbJK6TsD0T9mGM1ZWovf8caCa0b XCBaisgJAD0BXyRQWDIV/fuZNPjXou+K8iV4oaoELCFnT6a7v55U+mz
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On powerpc 8xx, exec does not imply read so
redefine PAGE_NONE_X as PAGE_NONE + X

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Russell Currey <ruscur@russell.cc>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index b234a93b05f1..f47d36d40a26 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -79,7 +79,7 @@
 
 /* Permission masks used to generate the __P and __S table */
 #define PAGE_NONE	__pgprot(_PAGE_BASE | _PAGE_NA)
-#define PAGE_NONE_X	__pgprot(_PAGE_BASE | _PAGE_RO | _PAGE_EXEC)
+#define PAGE_NONE_X	__pgprot(_PAGE_BASE | _PAGE_NA | _PAGE_EXEC)
 #define PAGE_SHARED	__pgprot(_PAGE_BASE)
 #define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_EXEC)
 #define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_RO)
-- 
2.41.0

