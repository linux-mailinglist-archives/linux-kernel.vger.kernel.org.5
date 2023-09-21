Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061AB7A9115
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjIUCus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjIUCuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:50:46 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9F9CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:50:39 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 38L2oY9j059266;
        Thu, 21 Sep 2023 10:50:34 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Sep 2023
 10:50:30 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <alexghiti@rivosinc.com>,
        <bjorn@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <conor.dooley@microchip.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v4 1/3] riscv: Improve PTDUMP to show RSW with non-zero value
Date:   Thu, 21 Sep 2023 10:50:20 +0800
Message-ID: <20230921025022.3989723-2-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921025022.3989723-1-peterlin@andestech.com>
References: <20230921025022.3989723-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 38L2oY9j059266
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RSW field can be used to encode 2 bits of software
defined information. Currently, PTDUMP only prints
"RSW" when its value is 1 or 3.

To fix this issue and improve the debugging experience
with PTDUMP, we redefine _PAGE_SPECIAL to its original
value and use _PAGE_SOFT as the RSW mask, allow it to
print the RSW with any non-zero value.

This patch also removes the val from the struct prot_bits
as it is no longer needed.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
Changes v1 -> v2
- Redefine _PAGE_SPECIAL to (1 << 8)
Changes v2 -> v3
- Add commet for _PAGE_SPECIAL
- Add ".." when RSW field is clear
- Fix unbalanced braces warning
Changes v3 -> v4
- Include Alexandre's RB/TB-tags
---
 arch/riscv/include/asm/pgtable-bits.h |  4 +--
 arch/riscv/mm/ptdump.c                | 35 ++++++++++++---------------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index f896708e8331..179bd4afece4 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -16,9 +16,9 @@
 #define _PAGE_GLOBAL    (1 << 5)    /* Global */
 #define _PAGE_ACCESSED  (1 << 6)    /* Set by hardware on any access */
 #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
-#define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
+#define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
 
-#define _PAGE_SPECIAL   _PAGE_SOFT
+#define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 20a9f991a6d7..57a0926c6627 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -129,7 +129,6 @@ static struct ptd_mm_info efi_ptd_info = {
 /* Page Table Entry */
 struct prot_bits {
 	u64 mask;
-	u64 val;
 	const char *set;
 	const char *clear;
 };
@@ -137,47 +136,38 @@ struct prot_bits {
 static const struct prot_bits pte_bits[] = {
 	{
 		.mask = _PAGE_SOFT,
-		.val = _PAGE_SOFT,
-		.set = "RSW",
-		.clear = "   ",
+		.set = "RSW(%d)",
+		.clear = "  ..  ",
 	}, {
 		.mask = _PAGE_DIRTY,
-		.val = _PAGE_DIRTY,
 		.set = "D",
 		.clear = ".",
 	}, {
 		.mask = _PAGE_ACCESSED,
-		.val = _PAGE_ACCESSED,
 		.set = "A",
 		.clear = ".",
 	}, {
 		.mask = _PAGE_GLOBAL,
-		.val = _PAGE_GLOBAL,
 		.set = "G",
 		.clear = ".",
 	}, {
 		.mask = _PAGE_USER,
-		.val = _PAGE_USER,
 		.set = "U",
 		.clear = ".",
 	}, {
 		.mask = _PAGE_EXEC,
-		.val = _PAGE_EXEC,
 		.set = "X",
 		.clear = ".",
 	}, {
 		.mask = _PAGE_WRITE,
-		.val = _PAGE_WRITE,
 		.set = "W",
 		.clear = ".",
 	}, {
 		.mask = _PAGE_READ,
-		.val = _PAGE_READ,
 		.set = "R",
 		.clear = ".",
 	}, {
 		.mask = _PAGE_PRESENT,
-		.val = _PAGE_PRESENT,
 		.set = "V",
 		.clear = ".",
 	}
@@ -208,15 +198,20 @@ static void dump_prot(struct pg_state *st)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(pte_bits); i++) {
-		const char *s;
-
-		if ((st->current_prot & pte_bits[i].mask) == pte_bits[i].val)
-			s = pte_bits[i].set;
-		else
-			s = pte_bits[i].clear;
+		char s[7];
+		unsigned long val;
+
+		val = st->current_prot & pte_bits[i].mask;
+		if (val) {
+			if (pte_bits[i].mask == _PAGE_SOFT)
+				sprintf(s, pte_bits[i].set, val >> 8);
+			else
+				sprintf(s, "%s", pte_bits[i].set);
+		} else {
+			sprintf(s, "%s", pte_bits[i].clear);
+		}
 
-		if (s)
-			pt_dump_seq_printf(st->seq, " %s", s);
+		pt_dump_seq_printf(st->seq, " %s", s);
 	}
 }
 
-- 
2.34.1

