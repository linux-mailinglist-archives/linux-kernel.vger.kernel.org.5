Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1AD789C8F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjH0JSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjH0JSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:18:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8E8D8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C637861374
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 09:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D2C433C8;
        Sun, 27 Aug 2023 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693127914;
        bh=Tsf6e5Pg927isx5zwcv/xL0jKM1+YyRgn6zbNLSS1+4=;
        h=From:To:Cc:Subject:Date:From;
        b=W/EzN40VCzy7Rc8zno7ucaZFINYPX8zWE9ayA96yjuse9VlM8G8rHaoYXGIuI/SJN
         onBOUmyLlkEHfT5AYNMfOO2CFU5v2tsFUuB2RnAqMRbR55qyC1Y9EpZBKWhuXD/R07
         zg8iTsX8k5zZYT4D+nsp1E4+GIBCM6Cjntui3KKwC22Iw4ZPx5OyOMZNnJdBSe+gks
         0SqpMGTjIvGndD9v7ezFdi5pbZ3K1jKtBiChGjHaUhDM7jbdxhLVul8v2ewqql+Kvv
         0KdQdcIzuezTzOfRHmkx2z5uHJX265CVKKgs4pW7jZM90es9RhlmNFRtXbT2BjeSym
         w3k5Roqwh/wlw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: mm: update T-Head memory type definitions
Date:   Sun, 27 Aug 2023 17:06:44 +0800
Message-Id: <20230827090644.1318-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
---
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

