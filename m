Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C06E7DB3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjJ3HBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjJ3HBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:01:31 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2806CC4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:01:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,262,1694707200"; 
   d="scan'208";a="94799117"
From:   Fang Xiang <fangxiang3@xiaomi.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fangxiang3@xiaomi.com>
Subject: [PATCH v3] irqchip/gic-v3-its: Flush ITS tables before writing GITS_BASER<n> registers in non-coherent GIC designs.
Date:   Mon, 30 Oct 2023 15:00:20 +0800
Message-ID: <20231030070020.3689-1-fangxiang3@xiaomi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.237.8.18]
X-ClientProxiedBy: BJ-MBX15.mioffice.cn (10.237.8.135) To BJ-MBX15.mioffice.cn
 (10.237.8.135)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non-coherent GIC design, ITS tables should be clean and flushed
to the PoV of the ITS before writing GITS_BASER<n> registers, otherwise
the ITS would read dirty tables and lead to UNPREDICTABLE behaviors.

The ITS always got clean tables in initialization with this fix, by
observing the signals from GIC.

Furthermore, hoist the quirked non-shareable attributes earlier to
save effort in tables setup.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Fang Xiang <fangxiang3@xiaomi.com>
Tested-by: Fang Xiang <fangxiang3@xiaomi.com>

Link to v2:
https://lore.kernel.org/all/20231027031007.2088-1-fangxiang3@xiaomi.com/

Link to v1:
https://lore.kernel.org/all/20231026020116.4238-1-fangxiang3@xiaomi.com/

v2 -> v3:
    - Add 'Signed-off-by' trailer for original author Marc
    - Expand commit message with testing result

v1 -> v2:
    - Flush ITS tables before writing GITS_BASER<n> registers
    - Hoist the quirked non-shareable attributes earlier
---
 drivers/irqchip/irq-gic-v3-its.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 75a2dd550625..d76d44ea2de1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2379,12 +2379,12 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		break;
 	}
 
+	if (!shr)
+		gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
+
 	its_write_baser(its, baser, val);
 	tmp = baser->val;
 
-	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
-		tmp &= ~GITS_BASER_SHAREABILITY_MASK;
-
 	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
 		/*
 		 * Shareability didn't stick. Just use
@@ -2394,10 +2394,9 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		 * non-cacheable as well.
 		 */
 		shr = tmp & GITS_BASER_SHAREABILITY_MASK;
-		if (!shr) {
+		if (!shr)
 			cache = GITS_BASER_nC;
-			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
-		}
+
 		goto retry_baser;
 	}
 
@@ -2609,6 +2608,11 @@ static int its_alloc_tables(struct its_node *its)
 		/* erratum 24313: ignore memory access type */
 		cache = GITS_BASER_nCnB;
 
+	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE) {
+		cache = GITS_BASER_nC;
+		shr = 0;
+	}
+
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		struct its_baser *baser = its->tables + i;
 		u64 val = its_read_baser(its, baser);
-- 
2.34.1

