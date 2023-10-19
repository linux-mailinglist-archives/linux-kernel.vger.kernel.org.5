Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BEC7CFBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345892AbjJSOAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbjJSOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:00:12 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A27B0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:00:09 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39JDxaO4026745;
        Thu, 19 Oct 2023 21:59:36 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 19 Oct 2023
 21:59:35 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <tglx@linutronix.de>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <tim609@andestech.com>,
        <dylan@andestech.com>, <locus84@andestech.com>,
        <dminus@andestech.com>, <peterlin@andestech.com>,
        Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [RFC PATCH v2 02/10] irqchip/riscv-intc: Allow large non-standard hwirq number
Date:   Thu, 19 Oct 2023 21:56:29 +0800
Message-ID: <20231019135629.3656450-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39JDxaO4026745
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
interrupt causes >= 16 are defined for platform use.

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
Changes v1 -> v2:
  - Fix irq mapping failure checking (suggested by Clément and Anup)
---
 drivers/irqchip/irq-riscv-intc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index e8d01b14ccdd..79d049105384 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -24,10 +24,8 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 {
 	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
 
-	if (unlikely(cause >= BITS_PER_LONG))
-		panic("unexpected interrupt cause");
-
-	generic_handle_domain_irq(intc_domain, cause);
+	if (generic_handle_domain_irq(intc_domain, cause))
+		pr_warn("Failed to handle interrupt (cause: %ld)\n", cause);
 }
 
 /*
@@ -117,8 +115,8 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 {
 	int rc;
 
-	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
-					       &riscv_intc_domain_ops, NULL);
+	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops,
+					     NULL);
 	if (!intc_domain) {
 		pr_err("unable to add IRQ domain\n");
 		return -ENXIO;
@@ -132,8 +130,6 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
-
 	return 0;
 }
 
-- 
2.34.1

