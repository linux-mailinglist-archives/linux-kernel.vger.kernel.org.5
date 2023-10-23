Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98C57D27A2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjJWAq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjJWAqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:46:15 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C03E7;
        Sun, 22 Oct 2023 17:46:09 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39N0ij19079679;
        Mon, 23 Oct 2023 08:44:45 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 23 Oct 2023
 08:44:41 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <ajones@ventanamicro.com>, <alexander.shishkin@linux.intel.com>,
        <andre.przywara@arm.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <conor+dt@kernel.org>, <conor.dooley@microchip.com>,
        <conor@kernel.org>, <devicetree@vger.kernel.org>,
        <dminus@andestech.com>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>,
        <jolsa@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <locus84@andestech.com>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <n.shubin@yadro.com>,
        <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterlin@andestech.com>,
        <peterz@infradead.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <sunilvl@ventanamicro.com>,
        <tglx@linutronix.de>, <tim609@andestech.com>, <uwu@icenowy.me>,
        <wens@csie.org>, <will@kernel.org>, <ycliang@andestech.com>
Subject: [PATCH v3 RESEND 06/13] perf: RISC-V: Eliminate redundant IRQ enable/disable operations
Date:   Mon, 23 Oct 2023 08:40:53 +0800
Message-ID: <20231023004100.2663486-7-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023004100.2663486-1-peterlin@andestech.com>
References: <20231023004100.2663486-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39N0ij19079679
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ enable/disable operations are already performed by the
IRQ chip functions riscv_intc_irq_unmask()/riscv_intc_irq_mask()
during enable_percpu_irq()/disable_percpu_irq(). We can just do
it once.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
---
This patch allows us to drop unnecessary ALT_SBI_PMU_OVF_{DISABLE,ENABLE}
in the last PATCH3 [1].

[1] https://patchwork.kernel.org/project/linux-riscv/patch/20230907021635.1002738-4-peterlin@andestech.com/

Changes v1 -> v2:
  - New patch
Changes v2 -> v3:
  - No change
---
 drivers/perf/riscv_pmu_sbi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 96c7f670c8f0..f340db9ce1e2 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -778,7 +778,6 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 	if (riscv_pmu_use_irq) {
 		cpu_hw_evt->irq = riscv_pmu_irq;
 		csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
-		csr_set(CSR_IE, BIT(riscv_pmu_irq_num));
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
 
@@ -789,7 +788,6 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	if (riscv_pmu_use_irq) {
 		disable_percpu_irq(riscv_pmu_irq);
-		csr_clear(CSR_IE, BIT(riscv_pmu_irq_num));
 	}
 
 	/* Disable all counters access for user mode now */
-- 
2.34.1

