Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10D796F01
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbjIGCdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243335AbjIGCdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:33:35 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3AD19B5;
        Wed,  6 Sep 2023 19:33:28 -0700 (PDT)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
        by Atcsqr.andestech.com with ESMTP id 3872JAWr025829;
        Thu, 7 Sep 2023 10:19:10 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3872IFlN024125;
        Thu, 7 Sep 2023 10:18:15 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 7 Sep 2023
 10:18:10 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <conor.dooley@microchip.com>,
        <atishp@atishpatra.org>, <anup@brainfault.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC:     <ajones@ventanamicro.com>, <heiko@sntech.de>,
        <samuel@sholland.org>, <geert+renesas@glider.be>,
        <n.shubin@yadro.com>, <dminus@andestech.com>,
        <ycliang@andestech.com>, <tim609@andestech.com>,
        <locus84@andestech.com>, <dylan@andestech.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [RFC PATCH 2/4] irqchip/riscv-intc: Support large non-standard hwirq number
Date:   Thu, 7 Sep 2023 10:16:33 +0800
Message-ID: <20230907021635.1002738-3-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907021635.1002738-1-peterlin@andestech.com>
References: <20230907021635.1002738-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3872JAWr025829
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the implementation of the RISC-V INTC driver uses the
interrupt cause as hwirq and has a limitation of supporting a
maximum of 64 hwirqs. However, according to the privileged spec,
interrupt cause >= 16 are defined for platform use.

This limitation prevents us from fully utilizing the available
local interrupt sources. Additionally, the hwirqs used on RISC-V
are sparse, with only interrupt numbers 1, 5 and 9 (plus Sscofpmf
or T-Head's PMU irq) being currently used for supervisor mode.

The patch switches to using irq_domain_create_tree() which
creates the radix tree map, allowing us to handle a larger
number of hwirqs.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

---
There are 3 hwirqs of local interrupt source exceed 64 defined in
AX45MP datasheet [1] Table 56: AX45MP-1C scause Value After Trap:
- 256+16 Slave port ECC error interrupt (S-mode)
- 256+17 Bus write transaction error interrupt (S-mode)
- 256+18 Performance monitor overflow interrupt(S-mode)

[1] http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
---
 drivers/irqchip/irq-riscv-intc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 4adeee1bc391..76e1229c45de 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -24,8 +24,8 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 {
 	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
 
-	if (unlikely(cause >= BITS_PER_LONG))
-		panic("unexpected interrupt cause");
+	if (!irq_find_mapping(intc_domain, cause))
+		panic("unexpected interrupt cause: %ld", cause);
 
 	generic_handle_domain_irq(intc_domain, cause);
 }
@@ -117,8 +117,8 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 {
 	int rc;
 
-	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
-					       &riscv_intc_domain_ops, NULL);
+	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops,
+					     NULL);
 	if (!intc_domain) {
 		pr_err("unable to add IRQ domain\n");
 		return -ENXIO;
@@ -132,8 +132,6 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
-
 	return 0;
 }
 
-- 
2.34.1

