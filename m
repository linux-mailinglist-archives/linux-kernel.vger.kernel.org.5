Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D80C7EB2BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjKNOqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjKNOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:46:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4320910D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:46:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B89EC433C8;
        Tue, 14 Nov 2023 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699973162;
        bh=gyx5uorL/T7u5Zf3KBdw6WSx5NX44qtilXB2fUrTgbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjqpJeHCXZ2By7PxAYSg55SsIlNJlNzU9mTWAl8lkKPDNV4TmtfnPIzka8II3wW3I
         4QYJzqQRpNCG/ijoRB37V1pJLQ5adJDbDmBcucoZFL7KHHGjxG/A/A5jaxpSS4lWE0
         82duHi2SF1WnJJHu1EmSKuzJVxOtibxn0yck4MaWywpKLYq3IeIpNyRsyk2u5POLc+
         qxbQlkFfcR5qwuukM3ZDoo6ISfJCD9sdHQ8C57NJ/owoId9oImZPVe+jCScd5FuVMB
         Xv4k/LoEVTCvPACYT77Xl+j6reIEpATg8duKYCNv6YDSiSpa5rlfzOmZx+u6XgFpQX
         F2VeBbPMOg6Iw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH RESEND v4 2/2] riscv: errata: thead: use pa based instructions for CMO
Date:   Tue, 14 Nov 2023 22:33:38 +0800
Message-Id: <20231114143338.2406-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231114143338.2406-1-jszhang@kernel.org>
References: <20231114143338.2406-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index c07d957b1468..b1c410bbc1ae 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -58,9 +58,9 @@ static bool errata_probe_pbmt(unsigned int stage,
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
  *   0000000    11001     00000      000      00000  0001011
  */
-#define THEAD_INVAL_A0	".long 0x0265000b"
-#define THEAD_CLEAN_A0	".long 0x0255000b"
-#define THEAD_FLUSH_A0	".long 0x0275000b"
+#define THEAD_INVAL_A0	".long 0x02a5000b"
+#define THEAD_CLEAN_A0	".long 0x0295000b"
+#define THEAD_FLUSH_A0	".long 0x02b5000b"
 #define THEAD_SYNC_S	".long 0x0190000b"
 
 #define THEAD_CMO_OP(_op, _start, _size, _cachesize)			\
@@ -79,23 +79,17 @@ asm volatile("mv a0, %1\n\t"						\
 
 static void thead_errata_cache_inv(phys_addr_t paddr, size_t size)
 {
-	void *vaddr = phys_to_virt(paddr);
-
-	THEAD_CMO_OP(INVAL, vaddr, size, riscv_cbom_block_size);
+	THEAD_CMO_OP(INVAL, paddr, size, riscv_cbom_block_size);
 }
 
 static void thead_errata_cache_wback(phys_addr_t paddr, size_t size)
 {
-	void *vaddr = phys_to_virt(paddr);
-
-	THEAD_CMO_OP(CLEAN, vaddr, size, riscv_cbom_block_size);
+	THEAD_CMO_OP(CLEAN, paddr, size, riscv_cbom_block_size);
 }
 
 static void thead_errata_cache_wback_inv(phys_addr_t paddr, size_t size)
 {
-	void *vaddr = phys_to_virt(paddr);
-
-	THEAD_CMO_OP(FLUSH, vaddr, size, riscv_cbom_block_size);
+	THEAD_CMO_OP(FLUSH, paddr, size, riscv_cbom_block_size);
 }
 
 static const struct riscv_nonstd_cache_ops thead_errata_cmo_ops = {
-- 
2.40.0

