Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0965C79C84A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjILHhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjILHhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:37:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF987E73
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:37:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED340C433C7;
        Tue, 12 Sep 2023 07:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694504231;
        bh=E+RlzXrhxC9sJ+1xCsa1js9BLmbDx0kmE855Vv+kmoU=;
        h=From:To:Cc:Subject:Date:From;
        b=rh64MUnCsOxItgPHmycfAF99QqwrG5YZvkmo5UIvlDpZ9PGj0V/H7jL3fToAoaDCF
         N7vppkH/RE4oc6W6ik7pFu0LThkmq5gbtPIS1XtXF1Tb00S//F6qiTfjHqKsXOvZ4J
         u7Cs1vy2JiPKY+PsX3mIa7wfDjl1f7eftvxUBzx+ginILHllH7cr9IrLlvmi2c/gM1
         ihP+fSM7vkHF4QR33ViLUYNBR1YaB1EwXrxy+5vCguw24tkx2mD90HJyTKBv4LHlFT
         Npx6x/9+qjTm/w8NnH2UizDFZLr+OBV6C1ZRqUsOIe6rwA5ZfhnwtGZwwkuET7aOVB
         cV4LX0jvcsvdA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2] riscv: mm: update T-Head memory type definitions
Date:   Tue, 12 Sep 2023 15:25:10 +0800
Message-Id: <20230912072510.2510-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update T-Head memory type definitions according to C910 doc [1]
For NC and IO, SH property isn't configurable, hardcoded as SH,
so set SH for NOCACHE and IO.

And also set bit[61](Bufferable) for NOCACHE according to the
table 6.1 in the doc [1].

Link: https://github.com/T-head-Semi/openc910 [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Tested-by: Drew Fustini <dfustini@baylibre.com>
---

Since v1:
 - collect Reviewed-by and Tested-by tag
 - rebase on linux 6.6-rc1

 arch/riscv/include/asm/pgtable-64.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 7a5097202e15..9a2c780a11e9 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -126,14 +126,18 @@ enum napot_cont_order {
 
 /*
  * [63:59] T-Head Memory Type definitions:
- *
- * 00000 - NC   Weakly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
+ * bit[63] SO - Strong Order
+ * bit[62] C - Cacheable
+ * bit[61] B - Bufferable
+ * bit[60] SH - Shareable
+ * bit[59] Sec - Trustable
+ * 00110 - NC   Weakly-ordered, Non-cacheable, Bufferable, Shareable, Non-trustable
  * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-trustable
- * 10000 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
+ * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
  */
 #define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
-#define _PAGE_NOCACHE_THEAD	0UL
-#define _PAGE_IO_THEAD		(1UL << 63)
+#define _PAGE_NOCACHE_THEAD	((1UL < 61) | (1UL << 60))
+#define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
 #define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
 
 static inline u64 riscv_page_mtmask(void)
-- 
2.40.1

