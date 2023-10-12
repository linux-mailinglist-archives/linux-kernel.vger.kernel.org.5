Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803E77C70B2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379104AbjJLOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379089AbjJLOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:50:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175ACB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:50:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1533C433C8;
        Thu, 12 Oct 2023 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697122200;
        bh=z1ZRpKN4zGKXq55T5I704tUYnbOmVfb3YTkG0G86C4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvtwTxwHfDM2Xg+q/s9dvFpSAWc0Wgzy/sITutGQnDGMP0vF1cNiQgLiilNaam2bD
         xxiqNQgnivwSW3pVxziO6J1mUqKQazgCMwj+mcW/nT9IfgNPORGd1LTrvZ0m5kOS41
         vK4veMnWeZzu1ppbl7hP8/nopAQokhP/c51TgyyPIenQrc2V/3Jr6dJAFehs4QsSYS
         N4V6FW5VfBOCaWfUCbFwux76xuSDd8OZScojUOxMJEc40W9ktyscHL0FxnJG4LmmXV
         3QkZaG9+vd9HF+gkUXxfMgSdiwTG9aYdvfJ9BP61nDaeFBwNEQgfSuUflH0tB6dg+9
         4HTuBPXTyVl7Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] riscv: errata: thead: use pa based instructions for CMO
Date:   Thu, 12 Oct 2023 22:37:46 +0800
Message-Id: <20231012143746.454-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231012143746.454-1-jszhang@kernel.org>
References: <20231012143746.454-1-jszhang@kernel.org>
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

T-HEAD CPUs such as C906/C910/C920 support phy address based CMO, use
them so that we don't need to convert to virt address.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/errata/thead/errata.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 3fefeb1b456e..632557f36b19 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -58,9 +58,9 @@ static bool errata_probe_pbmt(unsigned int stage,
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
  *   0000000    11001     00000      000      00000  0001011
  */
-#define THEAD_inval_A0	".long 0x0265000b"
-#define THEAD_clean_A0	".long 0x0255000b"
-#define THEAD_flush_A0	".long 0x0275000b"
+#define THEAD_inval_A0	".long 0x02a5000b"
+#define THEAD_clean_A0	".long 0x0295000b"
+#define THEAD_flush_A0	".long 0x02b5000b"
 #define THEAD_SYNC_S	".long 0x0190000b"
 
 #define THEAD_CMO_OP(_op, _start, _size, _cachesize)			\
@@ -79,23 +79,17 @@ asm volatile("mv a0, %1\n\t"						\
 
 static void thead_errata_cache_inv(phys_addr_t paddr, size_t size)
 {
-	void *vaddr = phys_to_virt(paddr);
-
-	THEAD_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
+	THEAD_CMO_OP(inval, paddr, size, riscv_cbom_block_size);
 }
 
 static void thead_errata_cache_wback(phys_addr_t paddr, size_t size)
 {
-	void *vaddr = phys_to_virt(paddr);
-
-	THEAD_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+	THEAD_CMO_OP(clean, paddr, size, riscv_cbom_block_size);
 }
 
 static void thead_errata_cache_wback_inv(phys_addr_t paddr, size_t size)
 {
-	void *vaddr = phys_to_virt(paddr);
-
-	THEAD_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+	THEAD_CMO_OP(flush, paddr, size, riscv_cbom_block_size);
 }
 
 static const struct riscv_nonstd_cache_ops thead_errata_cmo_ops = {
-- 
2.40.1

