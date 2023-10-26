Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE37D7A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjJZCCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZCCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:02:30 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 19:02:27 PDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D05A116
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:02:27 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,252,1694707200"; 
   d="scan'208";a="68935568"
From:   Fang Xiang <fangxiang3@xiaomi.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fangxiang3@xiaomi.com>
Subject: [PATCH] irqchip/gic-v3-its: Fix the coherent issue in its_setup_baser() when shr = 0.
Date:   Thu, 26 Oct 2023 10:01:16 +0800
Message-ID: <20231026020116.4238-1-fangxiang3@xiaomi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.237.8.18]
X-ClientProxiedBy: BJ-MBX02.mioffice.cn (10.237.8.122) To BJ-MBX15.mioffice.cn
 (10.237.8.135)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_SOFTFAIL,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The table would not be flushed if the input parameter shr = 0 in its_setup_baser() and
it would cause a coherent problem.

Signed-off-by: Fang Xiang <fangxiang3@xiaomi.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 75a2dd550625..58a9f24ccfa7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2394,13 +2394,15 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
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
 
+	if (!shr)
+		gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
+
 	if (val != tmp) {
 		pr_err("ITS@%pa: %s doesn't stick: %llx %llx\n",
 		       &its->phys_base, its_base_type_string[type],
-- 
2.34.1

