Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B25789C91
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjH0JUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjH0JUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDC3109
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75FCA60F16
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 09:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6044C433C8;
        Sun, 27 Aug 2023 09:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693128014;
        bh=wVJEp+DWxjAP9hqubYfmJYRid/a/jKOOXMXkMs86vv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usLvamgE7qx33BKjeqfkpc4BxoEL/KXx5jq76XtCseuMSLbZmPX2d/m1jxn/t2SDE
         eSqzYV0Lv7kQYuB4o7blMl4YnZH+q6ZlSjOFwBqHLC1l79YIToF2CKAlt70qQEraG9
         crQZzSLltAjbiTxmVXZ6KSqLOSDoBQz4k7jBoLydhEj9oKPen6mgqggmTvCS/6c1y3
         yXWoj+jSrtZRh6HB+IvSE6jbaCA2aBxqL518aT5zRkB9U9GBD3Wh4PKHSFZtIZHskZ
         q8QRtI7g/Bx0m3tr0Nhe10L5O630jEXbxR1wp8+M3EoBARB/+Wrgu6uZEmDUmsxlPQ
         tbQ0wJERV9RXg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 1/2] riscv: errata: fix T-Head dcache.cva encoding
Date:   Sun, 27 Aug 2023 17:08:12 +0800
Message-Id: <20230827090813.1353-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827090813.1353-1-jszhang@kernel.org>
References: <20230827090813.1353-1-jszhang@kernel.org>
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

From: Icenowy Zheng <uwu@icenowy.me>

The dcache.cva encoding shown in the comments are wrong, it's for
dcache.cval1 (which is restricted to L1) instead.

Fix this in the comment and in the hardcoded instruction.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/errata_list.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index fb1a810f3d8c..feab334dd832 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -100,7 +100,7 @@ asm volatile(ALTERNATIVE(						\
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
  *   0000001    01001      rs1       000      00000  0001011
  * dcache.cva rs1 (clean, virtual address)
- *   0000001    00100      rs1       000      00000  0001011
+ *   0000001    00101      rs1       000      00000  0001011
  *
  * dcache.cipa rs1 (clean then invalidate, physical address)
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
@@ -113,7 +113,7 @@ asm volatile(ALTERNATIVE(						\
  *   0000000    11001     00000      000      00000  0001011
  */
 #define THEAD_inval_A0	".long 0x0265000b"
-#define THEAD_clean_A0	".long 0x0245000b"
+#define THEAD_clean_A0	".long 0x0255000b"
 #define THEAD_flush_A0	".long 0x0275000b"
 #define THEAD_SYNC_S	".long 0x0190000b"
 
-- 
2.40.1

